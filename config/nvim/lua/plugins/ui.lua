-- Constant that defines UI buffers that we do general exclusion of plugins
local UI_BUFFERS = { "help", "alpha", "NvimTree", "Trouble", "lazy", "netrw", "text" }

return {

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            theme = "gruvbox_dark",
            extensions = {},
        }
    },

    -- Bufferline
    {
        "akinsho/nvim-bufferline.lua",
        event = "VeryLazy",
        init = function()
            vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
            vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
        end,
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                mode = "tabs",
            },
        },
    },

    -- Automatic switching for relative line numbers when in different modes
    {
        "sitiom/nvim-numbertoggle",
        event = "BufReadPre",
    },

    -- Add visible indentation
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        main = "ibl",
        opts = {
            indent = {
                char = '┊',
                tab_char = '┊',
            },
            scope = {
                enabled = false,
            },
            exclude = {
                filetypes = UI_BUFFERS,
                buftypes = { "terminal", "nofile" },
            },
        },
    },

    -- Additional UI for vim.ui.select i.e. to popup telescope
    {
        "stevearc/dressing.nvim",
        opts = {
            dressing = {
                border = {
                    style = "rounded",
                    highlight = "Normal",
                },
                prompt = {
                    highlight = "Comment",
                },
                results = {
                    highlight = "Normal",
                },
                preview = {
                    highlight = "Normal",
                },
            },
        },
    },

    -- Dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local logo = [[
            +----------------------------+
            |                            |
            |            /\        /\    |
            |           /  \      / /    |
            |       /\ /    \    / /     |
            |      /./\      \  / /      |
            |     / /\ \     | / /       |
            |     \/  \ \-----/ /        |
            |          \/     \/         |
            |           |______\         |
            |           \       \        |
            |   Hello    \      /        |
            |             \    /         |
            |              \  /          |
            |               \/           |
            |                            |
            +-----------------------------
        ]]

            dashboard.section.header.val = vim.split(logo, "\n")
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", " " .. " New file", ":ene <CR>"),
                dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                dashboard.button("s", "󱉟" .. " Restore Session", ":NeovimProjectLoadRecent<CR>"),
                dashboard.button("l", "l " .. " Load Session", ":Telescope neovim-project discover<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            require("alpha").setup(dashboard.opts)
        end,
    },
}
