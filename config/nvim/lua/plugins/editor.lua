return {
    -- nvim web devicons for file icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        event = "BufReadPre",
    },

    -- Tree explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-web-devicons" },
        cmd = "NvimTreeToggle",
        keys = {
            { "<leader>tt", "<cmd>NvimTreeToggle<CR>", desc = "Toggle Tree" },
        },
        opts = {
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
            },
        },
        config = function(_, opts)
            local tree = require("nvim-tree")
            tree.setup(opts)
        end,
    },

    -- Which key to lookup keybindings
    {
        "folke/which-key.nvim",
        config = function(_, opts)
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require("which-key")
            wk.setup(opts)
            wk.register({
                ["g"] = { name = "+g" },
                ["gs"] = { name = "+surround" },
                ["gc"] = { name = "+comment" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader>t"] = { name = "+Toggle" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>f"] = { name = "+find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            })
        end,
    },

    -- Search and replace functionality
    -- Requires ripgrep and sed installed
    {
        "windwp/nvim-spectre",
        keys = {
            { "<leader>fr", function() require("spectre").open() end, desc = "Find Replace" },
        },
    },

    -- Telescope is used for fuzzy finding files, live_grep, etc.
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable "make" == 1 } },
        version = false,
        keys = {
            {
                "<leader>/",
                function()
                    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false
                    })
                end,
                desc = "Search in current buffer"
            },
            { "<leader>fg", function() require('telescope.builtin').live_grep() end,                    desc = "Find in Files (Grep)" },
            {
                "<leader>ff",
                function()
                    local function is_git_repo()
                        vim.fn.system("git rev-parse --is-inside-work-tree")
                        return vim.v.shell_error == 0
                    end
                    local function get_git_root()
                        local dot_git_path = vim.fn.finddir(".git", ".;")
                        return vim.fn.fnamemodify(dot_git_path, ":h")
                    end
                    local opts = {}
                    if is_git_repo() then
                        opts = {
                            cwd = get_git_root(),
                        }
                    end
                    require("telescope.builtin").find_files(opts)
                end,
                desc = "Find Files (cwd)"
            },
            -- { "<leader>ff", function() require('telescope.builtin').find_files() end,                   desc = "Find Files (cwd)" },
            { "<leader>fb", function() require('telescope.builtin').buffers() end,                      desc = "Find Buffers" },
            { "<leader>fw", function() require('telescope.builtin').grep_string() end,                  desc = "Find current word" },
            { "<leader>fh", function() require('telescope.builtin').help_tags() end,                    desc = "Find in Help" },
            { "<leader>fd", function() require('telescope.builtin').diagnostics() end,                  desc = "Find in Diagnostics" },
            { "<leader>fp", function() require('telescope.builtin').lsp_document_symbols() end,         desc = "Find Document Symbols" },
            { "<leader>fP", function() require('telescope.builtin').lsp_workspace_symbols() end,        desc = "Find Workspace Symbols" },
            { "<leader>ft", function() require('telescope').extensions.file_browser.file_browser() end, desc = "Find file browser" },
            {
                "<leader>fs",
                function()
                    require('telescope.builtin').lsp_document_symbols({
                        symbols = {
                            "Class",
                            "Function",
                            "Method",
                            "Constructor",
                            "Interface",
                            "Module",
                            "Struct",
                            "Trait",
                            "Field",
                            "Property",
                        },
                    })
                end,
                desc = "Find Symbol",
            },
        },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                mappings = {
                    i = {
                        -- These enable the default behaviour for C-u and C-d
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = false,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            },
            pickers = {
                find_files = {
                    follow = true
                }
            }
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
        end,
    },

    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "▎" },
                untracked = { text = "░" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },

    -- Vim fugitive - General git utilities within vim
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "GBrowse", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GRename", "GRemove", "Glgrep", "Gedit" },
    },

    -- Highlight other instances of the word under the cursor
    {
        "RRethy/vim-illuminate",
        event = "BufReadPost",
        opts = { delay = 200 },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },

    -- Buffer removing (unshow, delete, wipeout), which saves window layout
    {
        "echasnovski/mini.bufremove",
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
        },
    },

    -- Pretty window for diagnostics
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
        },
    },

    -- Better terminal support
    {
        "akinsho/nvim-toggleterm.lua",
        cmd = { "ToggleTerm" },
        keys = {
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Terminal (Float)" },
        },
        config = function(_, opts)
            -- Set escape sequence to exit terminal
            opts.on_open = function(term)
                vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", "<C-\\><C-n>", { noremap = true })
            end
            require("toggleterm").setup(opts)
        end,
    },

    -- hardtime - help to establish good vim workflow
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    },
}
