return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "ziglang/zig.vim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        local lspconfig = require("lspconfig")
        require("fidget").setup({
            --Theme settings
            notification = {
                window = {
                    winblend = 0,
                },
            },
        })
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "tsserver",
                "html",
                "cssls",
                "tailwindcss",
                "svelte",
                "lua_ls",
                "graphql",
                "emmet_ls",
                "prismals",
                "pyright",
                "gopls",
                "zls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                -- zig
                ["zls"] = function()
                    lspconfig.zls.setup({
                        filetypes = { 'zig', 'zir' },
                        cmd = { 'C:\\zig-windows-x86_64-0.14.0-dev.311+c50f30038\\' },
                        single_file_support = true,
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                                zig_exe_path = 'C:\\zig-windows-x86_64-0.14.0-dev.311+c50f30038\\',
                            },
                        },
                    })
                end,
                --TypeScript
                ["tsserver"] = function()
                    lspconfig.tsserver.setup({
                        capabilities = capabilities,
                        settings = {
                            completions = {
                                completeFunctionCalls = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,

                -- Emmet
                ["emmet_ls"] = function()
                    lspconfig.emmet_ls.setup({
                        capabilities = capabilities,
                    })
                end,

                -- Go
                ["gopls"] = function()
                    lspconfig.gopls.setup({
                        capabilities = capabilities,
                    })
                end,
                -- Python
                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        settings = {
                            python = {
                                analysis = {
                                    autoSearchPaths = true,
                                    diagnosticMode = "workspace",
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    })
                end,
                --PowerShell
                ["powershell_es"] = function()
                    lspconfig.powershell_es.setup({
                        capabilities = capabilities,
                        settings = { powershell = { codeFormatting = { Preset = 'OTBS' } } },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.4" },
                                telemetry = { enabled = false },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                    undefined_global = false,
                                    missing_parameters = false,
                                    disable = { "missing-parameters", "missing-fields" }
                                },
                            },
                        },
                    })
                end,
                lspconfig.html.setup({ capabilities = capabilities }),
                lspconfig.cssls.setup({ capabilities = capabilities }),
                lspconfig.eslint.setup({ capabilities = capabilities }),
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
                ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
