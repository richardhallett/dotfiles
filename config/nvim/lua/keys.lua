-- Mode reminders
-- n: Normal
-- i: Insert
-- v: Visual
-- x: Visual block
-- t: Terminal
-- c: Command
-- s: Select
-- o: Operator pending

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- See `:help vim.keymap.set()`
-- We use space for leader above
vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', {
    silent = true
})

-- Disable arrow keys
vim.keymap.set({'n', 'v', 'i'}, '<Up>', '<Nop>', {
    silent = true
})
vim.keymap.set({'n', 'v', 'i'}, '<Down>', '<Nop>', {
    silent = true
})
vim.keymap.set({'n', 'v', 'i'}, '<Left>', '<Nop>', {
    silent = true
})
vim.keymap.set({'n', 'v', 'i'}, '<Right>', '<Nop>', {
    silent = true
})

-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set('i', '<A-j>', "<Esc>:m .+1<CR>==gi", {
    desc = 'Move current line / block with Alt-j/k ala vscode.'
})
-- Move current line / block with Alt-j/k ala vscode
vim.keymap.set('i', '<A-k>', "<Esc>:m .-2<CR>==gi", {
    desc = 'Move current line / block with Alt-j/k ala vscode.'
})

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' } )
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' } )
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic in float' } )
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show diagnostic in loclist'} )


-- Save file shortcut
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- better indent
vim.keymap.set("v", "<", "<gv", { desc = "Better indent" })
vim.keymap.set("v", ">", ">gv", { desc = "Better indent" })
