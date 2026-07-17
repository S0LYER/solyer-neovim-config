-------------------------------------
---------- Editor settings ----------
-------------------------------------

-- Line numbers
vim.opt.number = true     
vim.opt.relativenumber = true    

-- Left space
vim.opt.expandtab = true          -- Tab > spaces
vim.opt.shiftwidth = 2            -- Space size
vim.opt.tabstop = 2               -- Tab spacesize
vim.opt.smartindent = true        -- Smart spaces
vim.opt.termguicolors = true      -- 24bit colors

--------------------------------------------
---------- Vim-plug installation -----------
--------------------------------------------

local plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({'curl', '-fLo', plug_path, '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
end

vim.cmd('source ' .. plug_path)

-----------------------------
---------- Plugins ----------
-----------------------------

vim.cmd([[
call plug#begin('~/.config/nvim/plugged')

Plug 'MunifTanjim/nui.nvim'
Plug 'folke/noice.nvim'

Plug 'nvim-tree/nvim-web-devicons' " Icons
Plug 'goolord/alpha-nvim'           " Start screen

Plug 'preservim/nerdtree'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Code highlighting

Plug 'echasnovski/mini.indentscope' " Visual functions

Plug 'NvChad/nvim-colorizer.lua'           " Hex-codes color visualisation

Plug 'lewis6991/gitsigns.nvim'             " Git-indicators 

Plug 'nvim-lualine/lualine.nvim'           " Custom line

Plug 'akinsho/bufferline.nvim', { 'tag': '*' } " Bufferline

Plug 'HiPhish/rainbow-delimiters.nvim'     " Rainbow-delimiters
Plug 'windwp/nvim-autopairs'               " Autopairs
Plug 'folke/todo-comments.nvim'            " TODO-comments

Plug 'neovim/nvim-lspconfig'               " Base LSP settings
Plug 'williamboman/mason.nvim'             " LSP Manager
Plug 'williamboman/mason-lspconfig.nvim'   " Autostart 

call plug#end()
]])

-- CMD Line
local status_ok, noice = pcall(require, "noice")
if status_ok then
  noice.setup({
    cmdline = {
      enabled = true,         
      view = "cmdline_popup", 
    },
    messages = {
      enabled = true,         
    },
    popupmenu = {
      enabled = true,         
    },
    views = {
      cmdline_popup = {
        position = {  -- Frame position
          row = 5,           
          col = "50%",       
        },
      },
    },
  })
end

----------------------------
---------- Colors ----------
----------------------------

local cmd_color = "#ffffff" 

vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = cmd_color }) -- Frame
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = cmd_color })  -- Text on frame
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = cmd_color })        -- ":" symbol
vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = cmd_color })  -- "/" symbol
vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = cmd_color })      -- ">" symbol

require("startscreen")

---------------------------------------------
---------- Transparrent background ----------
---------------------------------------------

-- It works only if you activate transparrency on your terminal
local function set_transparent_background()
  local hl_groups = {
    "Normal",        -- Workspace
    "NormalNC",      -- Not active windows
    "SignColumn",    -- Collumn
    "NormalFloat",   -- Windows
    "FloatBorder",   -- Window frame
    "FloatTitle",    -- Window header
  }
  for _, group in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end

set_transparent_background()

------------------------------------
---------- Plugin require ----------
------------------------------------

require("custom.treesitter") --Code highlighting
require("custom.indentscope") -- Visual functions
require("custom.colorizer") -- Hex-codes color visualisation
require("custom.gitsigns") -- Git-indicators
require("custom.lualine") -- Custom line
require("custom.bufferline") -- Bufferline
require("custom.rainbow") -- Rainbow-delimiters
require("custom.autopairs") -- Autopairs
require("custom.todo") -- TODO-comments
require("custom.lsp") -- LSP

