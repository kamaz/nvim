---@diagnostic disable: undefined-field
---
require("plenary.async").tests.add_to_env()
local Tree = require("neotest.types").Tree
local jstest = require("jstest")
local nio = require("nio")
local lib = require("neotest.lib")

local Path = require("plenary.path")
local p = Path.path
local uv = vim.uv
local nit = nio.tests.it

---Converts a path to an absolute path in the test_data directory.
---
---@param path string: the path to file in test_data directory
---@return string: the absolute path to the file in the test_data directory
function test_data(path)
	local root_dir = vim.fs.dirname(debug.getinfo(1).source:gsub("^@", ""))

	return root_dir .. "/test_data/" .. path
end

describe("project root", function()
	it("finds root project with .git", function()
		local project_dir = test_data("root/git")

		assert.is_not_nil(project_dir)
		assert.is_true(project_dir:match("^/") ~= nil)
		assert.is_true(project_dir:match("test_data/root/git$") ~= nil)
	end)

	it("finds root project with .git when init in sub-directory", function()
		local project_dir = test_data("root/git/child")

		local project_root = jstest.root(project_dir)

		assert.is_true(project_root:match("^/") ~= nil)
		assert.is_true(project_root:match("test_data/root/git$") ~= nil)
	end)

	it("finds root project with .git when init in sub-sub-directory", function()
		local project_dir = test_data("root/git/child/child")

		local project_root = jstest.root(project_dir)

		assert.is_true(project_root:match("^/") ~= nil)
		assert.is_true(project_root:match("test_data/root/git$") ~= nil)
	end)

	it("uses current path as root when .git directory not found", function()
		local root_dir = uv.os_tmpdir()

		local project_dir = jstest.root(root_dir)

		assert.is_true(root_dir == project_dir)
	end)
end)

describe("is test file", function()
	it("returns true when file matches glob for ts file", function()
		local result = jstest.is_test_file("test/my.spec.ts")

		assert.is_true(result)
	end)

	it("returns true when file matches glob for js file", function()
		local result = jstest.is_test_file("my.spec.js")

		assert.is_true(result)
	end)
end)

describe("filter directory", function()
	it("returns false when directory is node_modules", function()
		local result = jstest.filter_dir("node_modules", "", "")

		assert.is_false(result)
	end)

	it("returns false when directory starts from dot(.)", function()
		local result = jstest.filter_dir(".hidden", "", "")

		assert.is_false(result)
	end)

	it("returns true otherwise", function()
		local result = jstest.filter_dir("just_a_dir", "", "")

		assert.is_true(result)
	end)
end)

describe("discover position", function()
	describe("typescript", function()
		nio.tests.it("finds test definition", function()
			local file_path = test_data("test_files/vitest/typescript/test.test.ts")
			local tree = jstest.discover_positions(file_path)
			assert.is_not_nil(tree)

			local pos = tree:data()
			assert.is_not_nil(pos)
			assert.is_equal("test.test.ts", pos.name, "file has to be test.ts")
			assert.is_equal("file", pos.type, "type of pos has to be file")

			-- here we should have file + test
			--
			for _, node in tree:iter() do
				print("node: " .. vim.inspect(node))
			end
		end)

		nio.tests.it("finds test definition in describe", function()
			local file_path = test_data("test_files/vitest/typescript/describe.test.ts")
			local tree = jstest.discover_positions(file_path)
			assert.is_not_nil(tree)

			local pos = tree:data()
			assert.is_not_nil(pos)
			assert.is_equal("describe.test.ts", pos.name, "file has to be test.ts")
			assert.is_equal("file", pos.type, "type of pos has to be file")

			-- (row, col) tuple representing the new position
			-- nvim_win_set_cursor
			-- { row: range[1] + 1, col: range[2], rowlength: range[3], collength: range[4] }
			-- here we should have file + namespace + test
			for _, node in tree:iter() do
				print("node: " .. vim.inspect(node))
			end
		end)
	end)

	describe("javascript", function()
		nio.tests.it("finds test definition", function()
			local file_path = test_data("test_files/vitest/javascript/test.test.js")
			local tree = jstest.discover_positions(file_path)
			assert.is_not_nil(tree)

			local pos = tree:data()
			assert.is_not_nil(pos)
			assert.is_equal("test.test.js", pos.name, "file has to be test.ts")
			assert.is_equal("file", pos.type, "type of pos has to be file")

			-- here we should have file + test
			--
			for _, node in tree:iter() do
				print("node: " .. vim.inspect(node))
			end
		end)

		nio.tests.it("finds test definition in describe", function()
			local file_path = test_data("test_files/vitest/javascript/describe.test.js")
			local tree = jstest.discover_positions(file_path)
			assert.is_not_nil(tree)

			local pos = tree:data()
			assert.is_not_nil(pos)
			assert.is_equal("describe.test.js", pos.name, "file has to be test.ts")
			assert.is_equal("file", pos.type, "type of pos has to be file")

			-- (row, col) tuple representing the new position
			-- nvim_win_set_cursor
			-- { row: range[1] + 1, col: range[2], rowlength: range[3], collength: range[4] }
			-- here we should have file + namespace + test
			for _, node in tree:iter() do
				print("node: " .. vim.inspect(node))
			end
		end)
	end)
end)

describe("build spec", function()
	describe("empty", function()
		nio.tests.it("returns nil when tree is nil", function()
			local result = jstest.build_spec({})

			assert.is_nil(result)
		end)
	end)

	describe("just file", function()
		nio.tests.it("returns nil when tree is nil", function()
			local file_path = test_data("test_files/vitest/javascript/test.test.js")
			local tree = jstest.discover_positions(file_path)
			local result, context = jstest.build_spec({
				tree = tree,
				strategy = "test",
			})

			assert.is_not_nil(result.command)
			assert.is_not_nil(result.context)

			-- TODO: configure option to set the version for vitest
			assert.same({
				"npx",
				"vitest",
				"--watch=false",
				"--reporter=verbose",
				"--reporter=json",
				result.command[6],
				file_path,
			}, result.command)
		end)
	end)

	describe("pnpm", function()
		nio.tests.it(
			"returns command for pnpm when package has pnpm-lock.yaml file and source file is in the root of package",
			function()
				local file_path = test_data("package_managers/pnpm/vitest/root_package/test.test.js")
				local tree = jstest.discover_positions(file_path)
				local result, context = jstest.build_spec({
					tree = tree,
					strategy = "test",
				})

				assert.is_not_nil(result.command)
				assert.is_not_nil(result.context)

				assert.same({
					"pnpm",
					"exec",
					"vitest",
					"--watch=false",
					"--reporter=verbose",
					"--reporter=json",
					result.command[7],
					file_path,
				}, result.command)
			end
		)

		nio.tests.it(
			"returns command for pnpm when package has pnpm-lock.yaml file and source file is nested in the package",
			function()
				local file_path = test_data("package_managers/pnpm/vitest/root_package/src/test.test.js")
				local tree = jstest.discover_positions(file_path)
				local result, context = jstest.build_spec({
					tree = tree,
					strategy = "test",
				})

				assert.is_not_nil(result.command)
				assert.is_not_nil(result.context)

				assert.same({
					"pnpm",
					"exec",
					"vitest",
					"--watch=false",
					"--reporter=verbose",
					"--reporter=json",
					result.command[7],
					file_path,
				}, result.command)
			end
		)

		nio.tests.it("returns command for pnpm when package has pnpm-lock.yaml file", function()
			local file_path = test_data("package_managers/pnpm/vitest/root_package/test.test.js")
			local tree = jstest.discover_positions(file_path)
			local result, context = jstest.build_spec({
				tree = tree,
				strategy = "test",
			})

			assert.is_not_nil(result.command)
			assert.is_not_nil(result.context)

			assert.same({
				"pnpm",
				"exec",
				"vitest",
				"--watch=false",
				"--reporter=verbose",
				"--reporter=json",
				result.command[7],
				file_path,
			}, result.command)
		end)

		-- TODO: what if that is not workspace and it can't vitest
		nio.tests.it("returns command for pnpm when file is in pnpm workspace", function()
			local file_path = test_data("package_managers/pnpm/vitest/monorepo/package2/src/test.test.js")
			local tree = jstest.discover_positions(file_path)
			local result, context = jstest.build_spec({
				tree = tree,
				strategy = "test",
			})

			assert.is_not_nil(result.command)
			assert.is_not_nil(result.context)

			assert.same({
				"pnpm",
				"exec",
				"vitest",
				"--watch=false",
				"--reporter=verbose",
				"--reporter=json",
				result.command[7],
				file_path,
			}, result.command)
		end)
	end)

	describe("npm", function()
		nio.tests.it("returns command for npm when package has package-lock.json file", function()
			local file_path = test_data("package_managers/npm/vitest/root_package/test.test.js")
			local tree = jstest.discover_positions(file_path)
			local result, context = jstest.build_spec({
				tree = tree,
				strategy = "test",
			})

			assert.is_not_nil(result.command)
			assert.is_not_nil(result.context)

			assert.same({
				"npm",
				"exec",
				"vitest",
				"--watch=false",
				"--reporter=verbose",
				"--reporter=json",
				result.command[7],
				file_path,
			}, result.command)
		end)
	end)

	-- npm exec
	-- no package.json
	--
	-- pnpm
	-- pnpm-lock.yaml
	-- pnpm-workspace.yaml
	-- pnpm exec vitest
	--
	-- yarn
	-- yarn.lock
	-- yarn exec vitest
	--
	-- npm
	-- package-lock.json
	-- "packageManager": "pnpm@9.2.0"
	-- npm exec vitest
	--

	-- stragegy "dap"
end)
