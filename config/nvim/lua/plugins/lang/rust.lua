return {

    -- lsp config for rust
    {
        "neovim/nvim-lspconfig",
        dependencies = "simrat39/rust-tools.nvim",
        opts = {
            servers = {
                rust_analyzer = {
                    mason = false,
                }
            },
            setup = {
                rust_analyzer = function(_, opts)
                    local rt = require("rust-tools")
                    rt.setup({
                        server = {
                            on_attach = function(_, bufnr)
                                -- Hover actions
                                vim.keymap.set("n", "<C-Space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                            end,
                            settings = {
                                ["rust-analyzer"] = {
                                    checkOnSave = {
                                        command = "clippy"
                                    },
                                }
                            }
                        },
                        tools = {
                            inlay_hints = {
                                auto = true,
                                show_parameter_hints = true,
                            },
                        },
                    })
                end
            }
        }
    },

    {
        'saecki/crates.nvim',
        ft = { "rust", "toml" },
        config = function(_, opts)
            local crates = require("crates")
            crates.setup(opts)
            crates.show()
        end
    },

}
