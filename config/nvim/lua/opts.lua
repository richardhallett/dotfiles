local opt = vim.opt

-- [[ Context ]]
opt.colorcolumn = '80' -- str:  Show col for max line length
opt.number = true -- bool: Show line numbers
opt.relativenumber = false
opt.scrolloff = 4 -- int:  Min num lines of context
opt.signcolumn = "yes" -- str:  Show the sign column
opt.mouse = "a" -- str:  Enable mouse support
opt.updatetime = 250 -- int:  Delay before swap file is saved

-- [[ Filetypes ]]
opt.encoding = 'utf8' -- str:  String encoding to use
opt.fileencoding = 'utf8' -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON" -- str:  Allow syntax highlighting
opt.termguicolors = true -- bool: If term supports ui color then enable
opt.background = "light" -- gruvbox light mode
opt.guifont = "JetBrainsMono\\ Nerd\\ Font\\ Mono:h16"

-- [[ Search ]]
opt.ignorecase = true -- bool: Ignore case in search patterns
opt.smartcase = true -- bool: Override ignorecase if search contains capitals
opt.incsearch = true -- bool: Use incremental search
opt.hlsearch = false -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true -- bool: Use spaces instead of tabs
opt.shiftwidth = 4 -- num:  Size of an indent
opt.softtabstop = 4 -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4 -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true -- bool: Place new window to right of current one
opt.splitbelow = true -- bool: Place new window below the current one

opt.completeopt = "menu,menuone,noinsert" -- str:  Completion options

-- [[ Misc ]]
-- Use system clipboard
opt.clipboard = "unnamedplus"

