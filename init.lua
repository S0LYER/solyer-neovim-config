-- Vim-plug installation
local plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_path)) > 0 then
  vim.fn.system({'curl', '-fLo', plug_path, '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
end

vim.cmd('source ' .. plug_path)

-- Plugins
vim.cmd([[
call plug#begin('~/.config/nvim/plugged')

Plug 'MunifTanjim/nui.nvim'
Plug 'folke/noice.nvim'

Plug 'nvim-tree/nvim-web-devicons' " Icons
Plug 'goolord/alpha-nvim'           " Start screen

Plug 'preservim/nerdtree'

call plug#end()
]])

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

local cmd_color = "#ffffff" -- Color

vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = cmd_color }) -- Frame
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = cmd_color })  -- Text on frame
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = cmd_color })        -- ":" symbol
vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = cmd_color })  -- "/" symbol
vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = cmd_color })      -- ">" symbol

require("startscreen")

-- Transparrent background

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
