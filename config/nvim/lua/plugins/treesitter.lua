-- Treesitter plugin, seperate config load because this might end up in neovim core

return {
    {
      "nvim-treesitter/nvim-treesitter",
      version = false,
      build = ":TSUpdate",
      event = "BufReadPost",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Shrink selection", mode = "x" },
      },
      opts = {
        highlight = { enable = true },
        indent = {
            enable = true,
            disable = {'python'}
        },
        context_commentstring = { enable = true, enable_autocmd = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<bs>",
          },
        },
        ensure_installed = {
            "bash",
            "fish",
            "help",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "ruby",
            "go",
            "rust",
            "toml",
            "query",
            "regex",
            "tsx",
            "typescript",
            "vim",
            "yaml",
          },
      },
      config = function(plugin, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },

    -- Additional text objects via treesitter
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "BufReadPost",
      keys = {
        { "a", mode = { "x", "o" } },
        { "i", mode = { "x", "o" } },
      },
      opts = {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["is"] = "@statement.inner",
              ["as"] = "@statement.outer",
              ["ad"] = "@conditional.outer",
              ["id"] = "@conditional.inner",
              ["am"] = "@call.outer",
              ["im"] = "@call.inner",
              ["aC"] = "@comment.outer",
              ["iC"] = "@comment.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          lsp_interop = {
            enable = true,
            border = "none",
            peek_definition_code = {
              ["<leader>pd"] = "@function.outer",
            },
          },
        },
      },
      config = function(plugin, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
  }
