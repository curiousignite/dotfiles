-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m]"]])
vim.cmd([[let &t_Ce = "\e[4:0m]"]])
local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
}

for option, value in pairs(powershell_options) do
    vim.opt[option] = value
end
vim.opt.clipboard = ""
vim.opt.spelllang = "tr,en"
vim.opt.spell = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.scroll = 16
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = true
vim.o.guicursor = 'n-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20,i:block-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
if vim.loop.os_uname().sysname == "Windows_NT" then
    -- For windows undotree
    vim.opt.undodir = vim.fn.expand('$HOME\\AppData\\Local\\nvim\\undodir')
    vim.g.undotree_DiffCommand = "FC"
else
    vim.opt.undodir = vim.fn.expand('$HOME/nvim/undodir')
end
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.g.mapleader = " "
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
local cpo = "+>"
vim.api.nvim_set_option_value('cpoptions', cpo, {})
local cpoptions = vim.api.nvim_get_option_value('cpoptions', {})
print(vim.inspect(cpoptions))
-- PERF fully optimized
if vim.g.vscode then
    -- config vscode
    Map = vim.keymap.set
    Cmd = vim.cmd

    VSCodeNotify = vim.fn.VSCodeNotify
    VSCodeCall = vim.fn.VSCodeCall

    require("_vscode.functions")
    require("_vscode.mappings")
end
if vim.fn.executable("rg") then
    -- if ripgrep installed, use that as a grepper
    vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
    vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
