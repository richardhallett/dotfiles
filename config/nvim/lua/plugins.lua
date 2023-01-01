local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local packer = require("packer")

packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        requires = { -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
        'j-hui/fidget.nvim', -- Additional lua configuration, makes nvim stuff amazing
        'folke/neodev.nvim'}
    }

    use 'simrat39/rust-tools.nvim'

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua', 'hrsh7th/cmp-calc', 'hrsh7th/cmp-vsnip'}
    }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update {
                with_sync = true
            })
        end
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
    }

    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'

    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder (files, lsp, etc)
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- Theme
    use 'ellisonleao/gruvbox.nvim'

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1
    }

    -- Treeview
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {'nvim-tree/nvim-web-devicons' -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    -- nvim-tree
    vim.keymap.set('n', '<leader>tt', require('nvim-tree').toggle, {
        desc = '[T]oggle [T]ree'
    })


    use 'mhinz/vim-startify'   -- Start screen

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)

if packer_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', {
    clear = true
})
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC'
})
