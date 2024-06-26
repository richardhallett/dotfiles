return {
    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf",                                config = true },
            { "folke/neodev.nvim",  opts = { experimental = { pathStrict = true } } },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "j-hui/fidget.nvim",
        },
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                virtual_text = false,
                signs = true,
                update_in_insert = true,
                underline = true,
                severity_sort = false,
                float = {
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
            },
            signs = {
                Error = " ",
                Warn = " ",
                Hint = " ",
                Info = " ",
            },
            inlay_hints = {
                enabled = true,
                exclude = {},
            },
            -- Automatically format on save
            autoformat = false,
            -- LSP Server Settings
            servers = {
            },
            -- Custom LSP Setup, return true to denote manual setup and not lspconfig
            -- Specify * as server to use function as a fallback for any server
            setup = {

            },
        },
        config = function(plugin, opts)
            -- Show diagnostics in a floaing window when cursor hold
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = function()
                    vim.diagnostic.open_float(nil, { focusable = false })
                end,
            })

            -- Attach to lsp and setup keymaps and autoformat
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local buffer = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    local nmap = function(keys, func, desc)
                        if desc then
                            desc = 'LSP: ' .. desc
                        end

                        vim.keymap.set('n', keys, func, {
                            buffer = buffer,
                            desc = desc
                        })
                    end

                    nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
                    nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

                    nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
                    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
                    nmap('gr', vim.lsp.buf.references, 'Goto References')
                    nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')

                    -- See `:help K` for why this keymap
                    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

                    -- Create a command `:Format` local to the LSP buffer
                    vim.api.nvim_buf_create_user_command(buffer, 'Format', function(_)
                        vim.lsp.buf.format()
                    end, {
                        desc = 'Format Document'
                    })

                    -- Setup autoformat
                    if opts.autoformat then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("LspFormat." .. buffer, {}),
                            buffer = buffer,
                            callback = function()
                                vim.lsp.buf.format()
                            end,
                        })
                    end
                end,
            })

            -- Diagnostics
            -- Set signs
            for name, icon in pairs(opts.signs) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end
            vim.diagnostic.config(opts.diagnostics)

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            local function setup(server)
                local server_opts = servers[server] or {}
                server_opts.capabilities = capabilities

                -- If server has custom setup, use it
                if opts.setup[server] then
                    opts.setup[server](server, server_opts)
                    return
                    -- If there is a fallback setup, use it
                elseif opts.setup["*"] then
                    opts.setup["*"](server, server_opts)
                    return
                end

                -- Default to lspconfig setup
                require("lspconfig")[server].setup(server_opts)
            end

            -- Get all available mason managed servers
            local mason_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            local ensure_installed = {}

            -- Loop through all servers and run setup if they are not in mason_servers
            for server, server_opts in pairs(servers) do
                if server_opts.mason == false or not vim.tbl_contains(mason_servers, server) then
                    setup(server)
                else
                    -- Add to ensure_installed if it is a mason managed server
                    table.insert(ensure_installed, server)
                end
            end

            -- Run the setup default for all remaining servers not set up,
            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed,
                handlers = { setup }
            })
        end,
    },

    -- Tools and LSP Servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            ensure_installed = {},
        },
        config = function(plugin, opts)
            require("mason").setup(opts)

            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },

    -- Simple inlay-hints plugin
    -- TODO: Maybe should handle this as part of lsp config myself
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup()
        end,
    }
}
