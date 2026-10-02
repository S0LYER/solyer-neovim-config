-------------------------------------
---------- Editor settings ----------
-------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"


--------------------------------
---------- Keybindings ---------
--------------------------------
vim.keymap.set("n", "<Tab>", function()
  vim.cmd("Neotree toggle left")
end, { silent = true, desc = "Switch filemanager" })


--------------------------------------------
---------- Pckr.nvim installation ----------
--------------------------------------------
local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

if not vim.uv.fs_stat(pckr_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/lewis6991/pckr.nvim",
    pckr_path,
  })
end

vim.opt.rtp:prepend(pckr_path)


-----------------------------
---------- Plugins ----------
-----------------------------
local pckr = require("pckr")

pckr.add({
  { "lewis6991/pckr.nvim" },

  ---------- UI ----------
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },

  {
    "folke/noice.nvim",
    requires = { "MunifTanjim/nui.nvim" },
    config = function()
      require("noice").setup({
        cmdline = { enabled = true, view = "cmdline_popup" },
        messages = { enabled = true },
        popupmenu = { enabled = true },
        views = { cmdline_popup = { position = { row = 5, col = "50%" } } },
      })
    end,
  },

  {
    "goolord/alpha-nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("startscreen")
    end,
  },

  ---------- Inline errors ----------
    {
    "rachartier/tiny-inline-diagnostic.nvim",
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        transparent_bg = true,          
        transparent_cursorline = true,  
        hi = {
          background = "CursorLine",
        },
        options = {
          show_source = { enabled = true },
        },
      })
    end,
  },

  ---------- File tree ----------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = { width = 30 },
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
      })
    end,
  },

  ---------- Syntax ----------
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("custom.treesitter")
    end,
  },
  { "the-mayankjha/fk_markdown.nvim" },

  ---------- Utilities ----------
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("custom.indentblankline") end,
  },
  {
    "echasnovski/mini.indentscope",
    config = function() require("custom.indentscope") end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function() require("custom.colorizer") end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("custom.gitsigns") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function() require("custom.lualine") end,
  },
  {
    "akinsho/bufferline.nvim",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function() require("custom.bufferline") end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function() require("custom.rainbow") end,
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("custom.autopairs") end,
  },
  { "mihovilrak/scroll.nvim" },
  {
    "folke/todo-comments.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("custom.todocomments") end,
  },

  ---------- LSP and Mason ----------
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    requires = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  },
  {
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("custom.lsp")
    end,
  },

  ---------- Completion ----------
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "onsails/lspkind.nvim" },
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      require("custom.cmp")
    end,
  },
})


--------------------------------
---------- Diagnostics ---------
--------------------------------
vim.diagnostic.config({
  virtual_text = false, 
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰞏 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  severity_sort = true,
  float = {
    focused = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})


----------------------------
---------- Colors ----------
----------------------------
local cmd_color = "#ffffff"
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = cmd_color })
vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = cmd_color })
vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = cmd_color })
vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", { fg = cmd_color })
vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { fg = cmd_color })

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2c313c", fg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })

local vscode_colors = {    -- Comment this function if you need monochrome style (or if you need monochrome icons in autosuggestions)
  Text = "#9CDCFE", Method = "#B5CEA8", Function = "#C586C0",
  Constructor = "#DCDCAA", Field = "#9CDCFE", Variable = "#9CDCFE",
  Class = "#4EC9B0", Interface = "#4EC9B0", Module = "#4EC9B0",
  Property = "#9CDCFE", Unit = "#DCDCAA", Value = "#9CDCFE",
  Enum = "#4EC9B0", Keyword = "#C586C0", Snippet = "#CE9178",
  Color = "#DCDCAA", File = "#9CDCFE", Reference = "#9CDCFE",
  Folder = "#9CDCFE", EnumMember = "#9CDCFE", Constant = "#4FC1FF",
  Struct = "#4EC9B0", Event = "#4EC9B0", Operator = "#DCDCAA",
  TypeParameter = "#4EC9B0",
}

for kind, color in pairs(vscode_colors) do
  vim.api.nvim_set_hl(0, "CmpItemKind" .. kind, { fg = color, bg = "NONE" })
end

vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })


--------------------------------------------
---------- Transparent background ----------
--------------------------------------------
local function set_transparent_background()
  local hl_groups = { "Normal", "NormalNC", "SignColumn", "NormalFloat", "FloatBorder", "FloatTitle" }
  for _, group in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end
set_transparent_background()
