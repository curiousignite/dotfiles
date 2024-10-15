-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local keymap = vim.keymap
local builtin = require("telescope.builtin")
local harpoon = require("harpoon")
--Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
--
--Split window
keymap.set("n", "ss", ":split<Return>", { desc = 'Split Horizantally' })
keymap.set("n", "sv", ":vsplit<Return>", { desc = 'Split Vertically' })
--
--Move window
-- keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left  window" })
-- keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- WezTerm navigation
keymap.set({ 'n', 't' }, '<C-h>', '<CMD>NavigatorLeft<CR>')
keymap.set({ 'n', 't' }, '<C-l>', '<CMD>NavigatorRight<CR>')
keymap.set({ 'n', 't' }, '<C-k>', '<CMD>NavigatorUp<CR>')
keymap.set({ 'n', 't' }, '<C-j>', '<CMD>NavigatorDown<CR>')

--IncRename
keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Incremental Rename" })

--UndoTree
keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Undotree Toggle" })

--Give the current file execute perms
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--Smart Move
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set({ "n", "x", "o" }, "H", "^")
keymap.set({ "n", "x", "o" }, "L", "$")
-- keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
-- keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap.set("n", "<BS>", "_")

--Yank into system clipboard
keymap.set("v", "<leader>y", '"+y', { desc = "[y]ank to system clipboard" })
keymap.set("n", "<leader>y", '"+y', { desc = "[y]ank to system clipboard" })
keymap.set("n", "<leader>Y", '"+y$', { desc = "[Y]ank to system clipboard" })

-- Common typos
keymap.set('n', ':W', ':w<CR>', { noremap = true, silent = true })
keymap.set('n', ':Q', ':q<CR>', { noremap = true, silent = true })
keymap.set('n', ':Wq', ':wq<CR>', { noremap = true, silent = true })
keymap.set('n', ':WQ', ':wq<CR>', { noremap = true, silent = true })
keymap.set('n', 'q:', ':q<CR>', { noremap = true, silent = true })

-- Delete to void
keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "[D]elete to void" })
keymap.set({ "n", "v" }, "<leader>D", '"_D', { desc = "[D]elete to void" })
-- Paste to void
keymap.set({ "n", "v" }, "<leader>p", '"_p', { desc = "[P]aste to void" })
-- Change to void
keymap.set({ "n", "v" }, "<leader>c", '"_c', { desc = "[C]hange to void" })

-- Shift+Insert Multiline paste for windows
keymap.set("i", "<S-Insert>", "<C-R>+")
keymap.set("n", "<S-Insert>", "<C-R>")

-- Open parent directory in current window
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Open parent directory in floating window
keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open parent directory floating" })

-- Diagnostic keymaps // Using trouble so this is mostly redundant
-- keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to previous [d]iagnostic message" })
-- keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next [d]iagnostic message" })
-- keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "show diagnostic [e]rror messages" })
-- keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
--
--Quick Save
keymap.set("n", "<ESC>", "<CMD>w<CR>")
-- Disable arrow keys in normal mode
keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

--Explore
keymap.set("n", "<leader>fs", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "[F]ind with [S]tring" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
keymap.set("n", "<leader>fW", function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
end, { desc = "[F]ind current [W]hole [W]ord " })
keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
keymap.set("n", "<leader>fr", function()
    local word = vim.fn.expand("<cWORD>")
    if string.find(word, "/") ~= nil then
        if string.find(word, ",") ~= nil then
            word = string.sub(word, 0, string.len(word) - 1)
        end
        os.execute("start https://github.com/" .. word)
    else
        print("Move your cursor on to a repo. ex: \"nvim-lua/plenary.nvim\"")
    end
end, { desc = "[F]ind [r]epo " })
keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Harpoon configs
keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end, { desc = "[A]dd to Harpoon list" })
keymap.set("n", "<leader><C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon list" })

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

keymap.set("n", "<C-n>", function()
    harpoon:list():select(1)
end)
keymap.set("n", "<C-m>", function()
    harpoon:list():select(2)
end)
keymap.set("n", "<C-ö>", function()
    harpoon:list():select(3)
end)
keymap.set("n", "<C-ç>", function()
    harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
-- keymap.set("n", "<leader>p", function()
--     harpoon:list():prev()
-- end, { desc = "Harpoon [P]revious" })
keymap.set("n", "<leader>n", function()
    harpoon:list():next()
end, { desc = "Harpoon [N]ext" })

--Cellular Automaton
keymap.set("n", "<leader>fml", "<CMD>CellularAutomaton make_it_rain<CR>", { desc = "FML" })

-- Easy Align
keymap.set('x', 'ga', '<Plug>(EasyAlign)', { desc = 'vim-easy-align', })
keymap.set('n', 'ga', '<Plug>(EasyAlign)', { desc = 'vim-easy-align', })

--Go quick err
keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
    { desc = "if err != nil, return err" })
