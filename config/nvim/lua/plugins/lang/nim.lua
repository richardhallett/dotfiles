return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                nim_langserver = {
                    settings = {
                        nim = {
                                nimsuggestPath = "nimsuggest",
                        }
                    }
                }
            }
        }
    }
}
