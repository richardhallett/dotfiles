return {
    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },
        opts = function()
            local cmp = require("cmp")
            local lspkind = require('lspkind')
            return {
                snippet = {
                    expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    -- ["<CR>"] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item({behaviour = cmp.SelectBehavior.Replace })
                    --     else
                    --         fallback()
                    --     end
                    -- end),
                    ["<CR>"] = cmp.mapping.confirm({ select = false, behaviour = cmp.ConfirmBehavior.Replace }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", group_index = 1},
                    { name = "luasnip", group_index = 1},
                    { name = "buffer", group_index = 3},
                    { name = "path", group_index = 1},
                    { name = "crates", group_index = 1},
                    { name = "copilot", group_index = 4 },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        symbol_map = { Copilot = "" }
                    })
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                      require("copilot_cmp.comparators").prioritize,
                      require("copilot_cmp.comparators").score,

                      -- Below is the default comparitor list and order for nvim-cmp
                      cmp.config.compare.offset,
                      cmp.config.compare.exact,
                      cmp.config.compare.score,
                      cmp.config.compare.recently_used,
                      cmp.config.compare.locality,
                      cmp.config.compare.kind,
                      cmp.config.compare.sort_text,
                      cmp.config.compare.length,
                      cmp.config.compare.order,
                    },
                },
            }
        end,
        },

    -- Snippet engine
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                 return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },

    -- Auto pairing for brackets, quotes, etc
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },

    -- Auto surrounding for brackets, quotes, etc
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {
            mappings = {
              add = "gsa", -- Add surrounding in Normal and Visual modes
              delete = "gsd", -- Delete surrounding
              find = "gsf", -- Find surrounding (to the right)
              find_left = "gsF", -- Find surrounding (to the left)
              highlight = "gsh", -- Highlight surrounding
              replace = "gsr", -- Replace surrounding
              update_n_lines = "gsn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },

    -- Auto commenting
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        opts = {
                suggestion = { enabled = true },
                panel = { enabled = false },
        },
        event = "VimEnter",
        config = function(_, opts)
            vim.defer_fn(function()
            require("copilot").setup(opts)
            end, 100)
        end,
    },

    -- copilot cmp plugin
    {
        "NOBLES5E/copilot-cmp",
        dependencies = { "copilot.lua" },
        opts = {
            method = "getCompletionsCycling",
        },
        config = function (_, opts)
            require("copilot_cmp").setup(opts)
        end
    },


    -- Debugging nvim-dap
    {
        "mfussenegger/nvim-dap",
        event = "BufRead",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            require('telescope').load_extension('dap')
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        event = "BufRead",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" },
        cmd = { "DapInstall", "DapUninstall" },
        config = function(plugin, opts)
            require("mason-nvim-dap").setup(opts)
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        opts = { },
        config = function()
            require("dapui").setup()
        end,
      },

}
