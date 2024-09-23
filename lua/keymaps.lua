-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- For nvim-tree.lua
-- default leader key: \
-- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- vim.keymap.set("n", "s", "<Plug>(leap-forward)")
-- vim.keymap.set("n", "S", "<Plug>(leap-backward)")
-- vim.keymap.set("n", "gs", "<Plug>(leap-from-window)")

-- -- BufferLine
-- vim.keymap.set("n", "<space>q", "<CMD>BufferLinePickClose<CR>")
-- vim.keymap.set("n", "<space>j", "<CMD>BufferLineCyclePrev<CR>")
-- vim.keymap.set("n", "<space>k", "<CMD>BufferLineCycleNext<CR>")
-- vim.keymap.set("n", "<space>h", "<CMD>BufferLineMovePrev<CR>")
-- vim.keymap.set("n", "<space>l", "<CMD>BufferLineMoveNext<CR>")
