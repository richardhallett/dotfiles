require('opts')
require('keys')

if vim.g.vscode then

else
    -- Eagerly disable netrw before we do anything
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Bootstrap lazy plugin manager
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system(
            { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
                lazypath })
    end
    vim.opt.rtp:prepend(lazypath)

    -- Load plugins specs in plugins module i.e ./plugins
    require("lazy").setup({ { import = "plugins" }, { import = "plugins.lang" } })
end
