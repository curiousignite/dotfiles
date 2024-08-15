return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*",
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "snippets" })
            local ls = require("luasnip")
            ls.filetype_extend("javascript", { "jsdoc" })
            -- <c-l> is my expansion key
            -- this will expand the current item or jump to the next item within the snippet.
            vim.keymap.set({ "i", "s" }, "<c-l>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true })

            -- <c-h> is my jump backwards key.
            -- this always moves to the previous item within the snippet
            vim.keymap.set({ "i", "s" }, "<c-h>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true })
        end,
    },
}
