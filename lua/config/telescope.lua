local is_ok, builtin = pcall(require, "telescope.builtin")
if not is_ok then
	return
end

vim.keymap.set("n", "<A-f>", builtin.find_files, {})
vim.keymap.set("n", "<A-g>", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {}) -- i.e. previously open files
vim.keymap.set("n", "<leader>fc", function() -- fc = find by command
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require("telescope").setup{
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			preview_height = 0.65,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
