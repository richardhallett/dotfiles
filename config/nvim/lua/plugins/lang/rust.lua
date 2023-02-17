return {

    -- lsp config for rust
    {
        "neovim/nvim-lspconfig",
        dependencies = "simrat39/rust-tools.nvim",
        opts = {
            servers = {
                rust_analyzer = {}
            },
            setup = {
                rust_analyzer = function()
                    require("rust-tools").setup({})
                end
            }
        }
    }

}
