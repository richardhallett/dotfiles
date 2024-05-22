
local projectfile = io.open(vim.fn.getcwd()..'/project.godot', 'r')
if projectfile then
    io.close(projectfile)
    vim.fn.serverstart './godothost'
end

return {

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gdscript = {
                }
            }
        }
    },
    -- Godot dap config
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require('dap')
            dap.adapters.godot = {
              type = "server",
              host = '127.0.0.1',
              port = 6006,
            }

            dap.configurations.gdscript = {
                {
                  type = "godot",
                  request = "launch",
                  name = "Launch scene",
                  project = "${workspaceFolder}",
                  launch_scene = true,
                }
            }
        end,
    },
}
