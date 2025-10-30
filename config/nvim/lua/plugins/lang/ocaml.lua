return {

    -- lsp config for ocaml
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ocamllsp = {
                    mason = false,
                }
            },
        }
    },
}
