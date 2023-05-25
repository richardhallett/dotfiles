return {
    -- Used by other libraries i.e. telescope
    { "nvim-lua/plenary.nvim", lazy = true },

    -- Session management
    {
        "shatur/neovim-session-manager",
        init = function()
            vim.keymap.set("n", "<leader>qs", "<cmd>SessionManager save_current_session<cr>", { desc = "Save session" })
            vim.keymap.set("n", "<leader>ql", "<cmd>SessionManager load_session<cr>", { desc = "Load session" })
        end,
        config = function(_, opts)
            require("session_manager").setup({
                autoload_mode = require('session_manager.config').AutoloadMode.Disabled
            })
        end,
    }
}
