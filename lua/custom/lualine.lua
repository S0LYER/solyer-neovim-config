local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

----------------------------
---------- Colors ----------
----------------------------

local colors = {
  white       = "#ffffff", 
  dark_text   = "#11111b", 
  grey_border = "#313244", 
  transparent = "NONE"     
}

------------------------------------
---------- Theme creation ----------
------------------------------------

local bubbles_theme = {
  normal = {
    a = { fg = colors.dark_text, bg = colors.white, bold = true },
    b = { fg = colors.dark_text, bg = colors.white, bold = true },
    c = { fg = colors.grey_border, bg = colors.transparent },
  },
  insert = {
    a = { fg = colors.dark_text, bg = colors.white, bold = true },
    b = { fg = colors.dark_text, bg = colors.white, bold = true },
  },
  visual = {
    a = { fg = colors.dark_text, bg = colors.white, bold = true },
    b = { fg = colors.dark_text, bg = colors.white, bold = true },
  },
  inactive = {
    a = { fg = colors.grey_border, bg = colors.transparent },
    b = { fg = colors.grey_border, bg = colors.transparent },
    c = { fg = colors.grey_border, bg = colors.transparent },
  },
}

-- Separators between squares
local function spacer()
  return " "
end

lualine.setup({
  options = {
    theme = bubbles_theme,
    component_separators = "", -- Turn off default separators
    section_separators = "",   -- Turn off default sections
  },
  sections = {
    
    --------------------------
    ---------- Left ----------
    --------------------------

    lualine_a = {
      { "mode", separator = { left = "", right = "" } },
    },
    lualine_b = {
      { spacer, color = { bg = "NONE" } }, -- Пропуск
      { "filename", separator = { left = "", right = "" } },
      { spacer, color = { bg = "NONE" } }, -- Пропуск
      -- Mistakes
      { "diagnostics", separator = { left = "", right = "" } },
    },
    lualine_c = {}, -- Transparrensed center
    
    ---------------------------
    ---------- Right ----------
    ---------------------------

    lualine_x = {},
    lualine_y = {
      -- Git changes
      { "diff", separator = { left = "", right = "" } },
      { spacer, color = { bg = "NONE" } }, -- Пропуск
      { "branch", separator = { left = "", right = "" } },
      { spacer, color = { bg = "NONE" } }, -- Пропуск
    },
    lualine_z = {
      -- File type
      { "filetype", separator = { left = "", right = "" } },
      { spacer, color = { bg = "NONE" } }, -- Пропуск
      { "location", separator = { left = "", right = "" } },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})

-- Border 
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = colors.grey_border, underline = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = colors.grey_border, underline = true })
