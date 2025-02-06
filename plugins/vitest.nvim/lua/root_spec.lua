---@diagnostic disable: undefined-field
local jstest = require("jstest")
local Path = require("plenary.path")
local p = Path.path
local uv = vim.uv

--- @param path string: The path to start searching from.
--- @return boolean: true if the path is a git project, false otherwise.
local is_git = function(path)
	local git_root_path = Path:new(path .. p.sep .. ".git")

	return git_root_path:exists() and git_root_path:is_dir()
end
--- Returns root of the project or nil if not found.
--- There are multiple options:
--- 1. It is a .git project which has a package.json
--- 2. It is a .git project but does not have package.json
--- 3. It is not a .git project but it has package.json
--- 4. It is not a .git project, it has package.json but it is part of monorepository
---@param path string
---@return string:

describe("project root", function()
	it("finds root project with .git", function()
		local root_dir = vim.fs.dirname(debug.getinfo(1).source:gsub("^@", ""))

		local git_absolute_path = jstest.root(root_dir .. "/" .. "test_data/root/git")
		-- local git_absolute_path = find_project(root_dir .. "/" .. "test_data/root/git")

		assert.is_not_nil(git_absolute_path)
		assert.is_true(git_absolute_path:match("^/") ~= nil)
		assert.is_true(git_absolute_path:match("test_data/root/git$") ~= nil)
	end)

	it("finds root project with .git when init in sub-directory", function()
		local root_dir = vim.fs.dirname(debug.getinfo(1).source:gsub("^@", ""))

		local git_absolute_path = jstest.root(root_dir .. "/" .. "test_data/root/git/child")
		-- local git_absolute_path = find_project(root_dir .. "/" .. "test_data/root/git/child")
		print("git absolute path: " .. git_absolute_path)

		assert.is_true(git_absolute_path:match("^/") ~= nil)
		assert.is_true(git_absolute_path:match("test_data/root/git$") ~= nil)
	end)

	it("finds root project with .git when init in sub-sub-directory", function()
		local root_dir = vim.fs.dirname(debug.getinfo(1).source:gsub("^@", ""))

		local git_absolute_path = jstest.root(root_dir .. "/" .. "test_data/root/git/child/child")
		print("git absolute path: " .. git_absolute_path)

		assert.is_true(git_absolute_path:match("^/") ~= nil)
		assert.is_true(git_absolute_path:match("test_data/root/git$") ~= nil)
	end)

	it("uses current path as root when .git directory not found", function()
		local root_dir = uv.os_tmpdir()

		local git_absolute_path = jstest.root(root_dir)
		print("git absolute path: " .. git_absolute_path)
		print("root dir path: " .. root_dir)

		assert.is_true(root_dir == git_absolute_path)
	end)
end)

--- @param file_path: string file path
--- @return boolean: true if the file is a test file, false otherwise.
local is_test_file = function(file_path)
	return vim.regex("spec\\.\\(ts\\|js\\)$"):match_str(file_path) ~= nil
end

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
