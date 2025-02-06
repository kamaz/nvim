---@diagnostic disable: undefined-field
local async = require("neotest.async")
local logger = require("neotest.logging")
local lib = require("neotest.lib")
local Path = require("plenary.path")
local p = Path.path

print("loading jstest.nvim")

--- @param path string: the path to check
--- @return boolean: true if the path is a root project, false otherwise.
local is_root = function(path)
	local root = p.root(path)
	return root == path
end

local is_node_module = function(path)
	return path:match("node_modules") ~= nil
end

--- @param path string: The path to start searching from.
--- @return boolean: true if the path is a git project, false otherwise.
local is_git = function(path)
	local git_root_path = Path:new(path .. p.sep .. ".git")

	return git_root_path:exists() and git_root_path:is_dir()
end

local is_package_root = function(path)
	local package_path = Path:new(path .. p.sep .. "package.json")

	return package_path:exists() and not package_path:is_dir()
end
local package_managers = {
	pnpm = { "pnpm-lock.yaml", "pnpm-workspace.yaml" },
	npm = { "package-lock.json" },
}

local resolve_package_manager = function(path)
	-- TODO: what if lock is not present
	-- we could unpack each package.json to find configuration

	for manager, files in pairs(package_managers) do
		for _, file in ipairs(files) do
			local package_file = Path:new(path .. p.sep .. file)
			if package_file:exists() then
				return manager
			end
		end
	end
end

---@class Adapter
---@field name string
local adapter = {
	name = "jstest",
}

---Find the project root directory given a current directory to work from.
---It tries to determine following:
---1. If it is a .git project and if it is then return the root directory
---2. If it is not a .git project it it uses current directory
---
---TODO: Implement the following types of the project root
---3. Determine based on the package json
---4. Determin based on the user defined configuraton
---@async
---@param dir string @Directory to treat as cwd
---@return string | nil @Absolute root dir of test suite
adapter.root = function(dir)
	if is_git(dir) then
		return Path:new(dir):absolute()
	end

	-- start moving down to check for .git
	local current_path = Path:new(dir)

	local max_count = 0
	while not is_git(current_path:absolute()) and not is_root(current_path:absolute()) and max_count < 50 do
		current_path = current_path:parent()
		max_count = max_count + 1
	end

	if is_root(current_path:absolute()) then
		-- print("current path dir" .. dir)
		return dir
	end

	-- print("current path" .. current_path:absolute())
	return current_path:absolute()
end

---Filter directories when searching for test files
---
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
adapter.filter_dir = function(name, rel_path, root)
	-- print("filter dir, name: " .. name .. ", path: " .. rel_path .. ", root: " .. root)
	--TODO: can we use something like .gitignore to filter out directories and files
	-- Take configuration from vitest.config.ts
	-- Ignore node_modules
	if name == "node_modules" then
		return false
	end

	-- Ignore hidden directories
	if name:sub(1, 1) == "." then
		return false
	end

	return true
end

-- ViTest Default Configuration
-- include: **/*.{test,spec}.?(c|m)[jt]s?(x)
-- exclude:  **/node_modules/**, **/dist/**, **/cypress/**, **/.{idea,git,cache,output,temp}/**, **/{karma,rollup,webpack,vite,vitest,jest,ava,babel,nyc,cypress,tsup,build,eslint,prettier}.config.*

-- Checks if a file is a test file
---@async
---@param file_path string
---@return boolean
adapter.is_test_file = function(file_path)
	-- local pattern = vim.glob.to_lpeg("**/*.{test,spec}.?(c|m)[jt]s?(x)")
	-- does not like [] or ?
	local pattern = vim.glob.to_lpeg("**/*.{spec,test}.{ts,js}")

	local result = pattern:match(file_path)

	print("file path: " .. file_path .. ", result: " .. tostring(result ~= nil))
	return result ~= nil
end

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
adapter.discover_positions = function(file_path)
	-- lets move this to seperate file and have this configured per testing framework
	local query = [[
    ; -- Namespaces --
    ; Matches: `describe('context')`
    ((call_expression
      function: (identifier) @func_name (#eq? @func_name "describe")
      arguments: (arguments (string (string_fragment) @namespace.name) (arrow_function))
    )) @namespace.definition
    ; Matches: `describe.only('context')`
    ((call_expression
      function: (member_expression
        object: (identifier) @func_name (#any-of? @func_name "describe")
      )
      arguments: (arguments (string (string_fragment) @namespace.name) (arrow_function))
    )) @namespace.definition
    ; Matches: `describe.each(['data'])('context')`
    ((call_expression
      function: (call_expression
        function: (member_expression
          object: (identifier) @func_name (#any-of? @func_name "describe")
        )
      )
      arguments: (arguments (string (string_fragment) @namespace.name) (arrow_function))
    )) @namespace.definition

    ; -- Tests --
    ; Matches: `test('test') / it('test')`
    ((call_expression
      function: (identifier) @func_name (#any-of? @func_name "it" "test")
      arguments: (arguments (string (string_fragment) @test.name) (arrow_function))
    )) @test.definition
    ; Matches: `test.only('test') / it.only('test')`
    ((call_expression
      function: (member_expression
        object: (identifier) @func_name (#any-of? @func_name "test" "it")
      )
      arguments: (arguments (string (string_fragment) @test.name) (arrow_function))
    )) @test.definition
    ; Matches: `test.each(['data'])('test') / it.each(['data'])('test')`
    ((call_expression
      function: (call_expression
        function: (member_expression
          object: (identifier) @func_name (#any-of? @func_name "it" "test")
        )
      )
      arguments: (arguments (string (string_fragment) @test.name) (arrow_function))
    )) @test.definition
  ]]

	-- TODO: check if this works with function and () =>
	query = query .. string.gsub(query, "arrow_function", "function_expression")

	print("what is the path to the file: " .. file_path .. tostring(lib.subprocess.enabled()))

	local result = lib.treesitter.parse_positions(file_path, query, { nested_tests = true })

	return result
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
adapter.build_spec = function(args)
	if not args then
		return nil
	end

	local tree = args.tree
	if not tree then
		return nil
	end

	-- check if the package.json exists
	--
	-- great we have package.json now lets determine
	-- what package manager do we work with as this will make things easier
	--

	local results_path = async.fn.tempname() .. ".json"
	local root_pos = tree:data()

	if root_pos.type ~= "file" then
		-- log error saying that it expect root pos to be a file
		return nil
	end

	-- how we have a file lets try to find package.json
	print("root pos path: " .. root_pos.path)
	-- FIXME: we have to have package root and workspace root
	-- FIXME: workspace root is the root of the workspace to understand what package manager we are working with
	local base_search_dir = vim.fs.dirname(root_pos.path)
	local package_roots = vim.fs.find(
		{ "package.json", "pnpm-workspace.yaml", "pnpm-lock.yaml", "package-lock.json" },
		{
			path = base_search_dir,
			type = "file",
			upward = true,
			-- TODO: make it configurable
			limit = 10,
		}
	)

	print(
		"package roots: "
			.. #package_roots
			.. ", packages: "
			.. vim.inspect(package_roots)
			.. ", base search dir: "
			.. base_search_dir
	)
	-- if there is not package that is just a file
	-- we have to fallback to global package using npx
	-- TODO: make npx configurable
	-- TODO: make vitest configurable
	-- TODO: make vitest version configurable
	local command = { "npx", "vitest" }
	if #package_roots > 0 then
		-- TODO: we have to write a test for this
		local package_root = vim.fs.dirname(package_roots[1])

		-- otherwise we are almost there now lets find the type of package manager
		-- FIXME: lets assume that is vitest
		-- FIXME: actually we could potentially use all the packages roots to determine if we use find with relevant number of depth
		local package_manager = resolve_package_manager(package_root)

		command = { package_manager, "exec", "vitest" }
	end

	local names = {}
	while tree and tree:data().type ~= "file" do
		table.insert(names, 1, tree:data().name)
		tree = tree:parent() --[[@as neotest.Tree]]
	end

	local testNamePattern = table.concat(names, " ")
	local pos = args.tree:data()

	print("what is the position: " .. vim.inspect(pos))
	--
	vim.list_extend(command, {
		-- this values should be configurable
		"--watch=false",
		"--reporter=verbose",
		"--reporter=json",
		"--outputFile=" .. results_path,
		-- "--testNamePattern=" .. testNamePattern,
		vim.fs.normalize(pos.path),
	})

	-- TODO: I think in repository we have to
	-- -- give a context from where it should be exectued so it matches package.json configuration
	return {
		command = command,
		-- cwd = cwd,
		context = {
			results_path = results_path,
			file = pos.path,
			-- stop_stream = stop_stream,
		},
		-- stream block the process
		-- stream = function()
		-- 	return function()
		-- 		-- local new_results = stream_data()
		-- 		--
		-- 		-- if not new_results or new_results == "" then
		-- 		-- 	return {}
		-- 		-- end
		-- 		--
		-- 		-- local ok, parsed = pcall(vim.json.decode, new_results, { luanil = { object = true } })
		-- 		--
		-- 		-- if not ok or not parsed.testResults then
		-- 		-- 	return {}
		-- 		-- end
		--
		-- 		return {}
		-- 	end
		-- end,
		-- strategy = get_strategy_config(args.strategy, command, cwd),
		-- env = getEnv(args[2] and args[2].env or {}),
	}
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
adapter.results = function(spec, result, tree)
	-- local output_file = spec.context.results_path
	-- local success, data = pcall(lib.files.read, output_file)
	-- local ok, parsed = pcall(vim.json.decode, data, { luanil = { object = true } })
	local results = {}
	for _, node in tree:iter_nodes() do
		local value = node:data()
		if value.type == "file" then
			results[value.id] = {
				status = "passed",
				output = "all good sir",
			}
		end
	end

	-- example of streaming https://github.com/nvim-neotest/neotest-python/blob/master/lua/neotest-python/adapter.lua and dap config
	return results
end

-- setmetatable(adapter, {
-- 	__call = function(_, opts)
-- 		if is_callable(opts.args) then
-- 			get_args = opts.args
-- 		elseif opts.args then
-- 			get_args = function()
-- 				return opts.args
-- 			end
-- 		end
-- 		return adapter
-- 	end,
-- })

return adapter
