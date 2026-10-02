local cmp = require("cmp")
local luasnip = require("luasnip")

------------------------------
---------- Settings ----------
------------------------------
-- Icon color
-- true  = colorfull icons (VSCode like)
-- false = switch off colorfull icons
local colored_icons = true

-- Separator (false = swith off)
local separators = true
local separator_color = "#ffffff" -- You can do darker "#555555"

-- Transparrent (0 = no transparrent, 100 = full transparrent)
local menu_blend = 15

-- Frame
local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local winhl = "Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpMenuSel,Search:None"

-- Icons
local kind_icons = {
  Text = "≡", Method = "ƒ", Function = "ƒ", Constructor = "⌘",
  Field = "◇", Variable = "α", Class = "◆", Interface = "◈",
  Module = "▣", Property = "◇", Unit = "∪", Value = "#",
  Enum = "∈", Keyword = "¶", Snippet = "§", Color = "●",
  File = "▤", Reference = "↗", Folder = "▸", EnumMember = "∋",
  Constant = "π", Struct = "▢", Event = "↯", Operator = "±",
  TypeParameter = "τ",
}

local source_names = {
  nvim_lsp = "lsp",
  luasnip = "snip",
  buffer = "buf",
  path = "path",
}

-- Colors
local kind_colors = {
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

local function set_highlights()
  local hl = vim.api.nvim_set_hl
  local menu_bg = "#0f0f0f" -- You need real color

  -- Menu
  hl(0, "CmpMenu", { fg = "#d4d4d4", bg = menu_bg })
  hl(0, "CmpMenuBorder", { fg = "#ffffff", bg = menu_bg })
  hl(0, "CmpMenuSel", { bg = "#2a2a2a", bold = true })
  hl(0, "CmpMenuSep", { underline = true, sp = separator_color })

  -- Text of suggestion
  hl(0, "CmpItemAbbr", { fg = "#d4d4d4" })
  hl(0, "CmpItemAbbrMatch", { fg = "#ffffff", bold = true })
  hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#ffffff", bold = true })
  hl(0, "CmpItemAbbrDeprecated", { fg = "#6b6b6b", strikethrough = true })
  hl(0, "CmpItemMenu", { fg = "#808080", italic = true })

  -- Color icons (you can switch off in colored_icons on top)
  for kind, color in pairs(kind_colors) do
    hl(0, "CmpItemKind" .. kind, { fg = colored_icons and color or "#d4d4d4" })
  end
end

set_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

--------------------------------
---------- Separators ----------
--------------------------------
if separators then
  local ns = vim.api.nvim_create_namespace("cmp_menu_separators")
  vim.api.nvim_set_decoration_provider(ns, {
    on_win = function(_, _, buf)
      return vim.bo[buf].filetype == "cmp_menu"
    end,
    on_line = function(_, _, buf, row)
      -- последнюю строку не трогаем: под ней уже есть рамка
      if row < vim.api.nvim_buf_line_count(buf) - 1 then
        vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
          line_hl_group = "CmpMenuSep",
          ephemeral = true,
        })
      end
    end,
  })
end

------------------------------
---------- nvim-cmp ----------
------------------------------
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  preselect = cmp.PreselectMode.None,

  window = {
    completion = cmp.config.window.bordered({
      border = border,
      winhighlight = winhl,
      winblend = menu_blend,
      col_offset = -3,
      side_padding = 0,
      scrollbar = false,
    }),
    documentation = cmp.config.window.bordered({
      border = border,
      winhighlight = winhl,
      winblend = menu_blend,
    }),
  },

  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),

    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, item)
      local kind_name = item.kind

      item.kind_hl_group = "CmpItemKind" .. kind_name
      item.kind = " " .. (kind_icons[kind_name] or "·") .. " "

      local max_width = 50
      if vim.fn.strdisplaywidth(item.abbr) > max_width then
        item.abbr = vim.fn.strcharpart(item.abbr, 0, max_width - 1) .. "…"
      end

      item.menu = source_names[entry.source.name]
      return item
    end,
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})
