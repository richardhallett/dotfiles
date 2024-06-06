return {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                            telemetry = {
                                enable = false
                            }
                        },
                    },
                },
            }
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {

            vim.filetype.add({
                extension = {
                    script = "lua",
                    render_script = "lua",
                    gui_script = "lua",
                    editor_script = "lua",
                }
            })
        }
    }
