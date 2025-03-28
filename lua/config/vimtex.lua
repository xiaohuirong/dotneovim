-- for xorg
-- vim.g.vimtex_view_method = "zathura"
-- for wayland
vim.g.vimtex_view_method = "zathura_simple"
-- vim.g.maplocalleader = ","

vim.g.vimtex_compiler_latexmk_engines = {
	["_"] = "-pdf",
	pdfdvi = "-pdfdvi",
	pdfps = "-pdfps",
	pdflatex = "-pdf",
	luatex = "-lualatex",
	lualatex = "-lualatex",
	xelatex = "-xelatex",
	["context (pdftex)"] = "-pdf -pdflatex=texexec",
	["context (luatex)"] = "-pdf -pdflatex=context",
	["context (xetex)"] = "-pdf -pdflatex='texexec --xtx'",
}

vim.g.vimtex_format_enabled = 1
