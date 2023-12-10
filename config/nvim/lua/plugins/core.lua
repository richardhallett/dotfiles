return {
    -- Used by other libraries i.e. telescope
    { "nvim-lua/plenary.nvim", lazy = true },

    -- Session management with neovim-project
    {
        "coffebar/neovim-project",
        opts = {
            projects = { -- define project roots
                "~/.config/*",
                "~/projects/*",
                "~/projects/datacite/*",
                "~/projects/personal/*",
            },
            last_session_on_startup = false,
        },
        keys = {
            { "<leader>qs", "<cmd>:NeovimProjectLoadRecent<cr>", desc = "Open Previous Session" },
            { "<leader>ql", "<cmd>:Telescope neovim-project discover<cr>", desc = "Load session" },
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
    },
}
