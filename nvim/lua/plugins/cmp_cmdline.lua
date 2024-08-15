return {
    {
        "hrsh6th/cmp-cmdline",
        event = "VeryLazy",
        config = function()
            local cmp = require("cmp")
            local mapping = {
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            }

            -- Use buffer source for `/`.
            cmp.setup.cmdline("/", {
                preselect = "None",
                completion = {
                    -- completeopt = "menu,preview,menuone,noselect",
                    completeopt = "menuone",
                },
                mapping = mapping,
                sources = {
                    { name = "buffer" },
                },
                experimental = {
                    ghost_text = true,
                    native_menu = false,
                },
            })

            -- Use cmdline & path source for ':'.
            cmp.setup.cmdline(":", {
                preselect = "None",
                completion = {
                    -- completeopt = "menu,preview,menuone,noselect",
                    completeopt = "menuone",
                },
                mapping = mapping,
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
                experimental = {
                    ghost_text = true,
                    native_menu = false,
                },
            })
        end,
    },
}
