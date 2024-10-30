return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap-python",
        },
        lazy = true,
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            require("dapui").setup()
            require("dap-go").setup()

            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })

            --Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            --C/C++/Rust
            -- dap.configuratiodap.adapters.cppdbg = {
            --     id = 'cppdbg',
            --     type = 'executable',
            --     command = 'C:\\absolute\\path\\to\\cpptools\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe',
            --     options = {
            --         detached = false
            --     }
            -- }
            -- SAP ABAP Debugger configuration for muscle memory
            vim.keymap.set("n", "<F5>", dap.step_into)
            vim.keymap.set("n", "<F6>", dap.step_over)
            vim.keymap.set("n", "<F7>", dap.step_back)
            vim.keymap.set("n", "<F8>", dap.continue)
            vim.keymap.set("n", "<F12>", dap.restart)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end

    }
}
