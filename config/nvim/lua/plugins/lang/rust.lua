return {

    -- lsp config for rust
    {
        "neovim/nvim-lspconfig",
        dependencies = "simrat39/rust-tools.nvim",
        opts = {
            servers = {
                rust_analyzer = {
                    mason = false,
                    tools = {
                        runnables = {
                            use_telescope = true
                        },
                        inlay_hints = {
                            auto = true,
                            show_parameter_hints = true,
                        },
                    },
                }
            },
            setup = {
                rust_analyzer = function(_, opts)
                    require("rust-tools").setup(opts)
                end
            }
        }
    }

}
