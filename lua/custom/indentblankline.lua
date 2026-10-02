local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

-- Grey default lines
local function set_highlights()
  vim.api.nvim_set_hl(0, "IblIndentGray", { fg = "#4b5263" })
end
set_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_highlights,
})

ibl.setup({
  indent = {
    char = "│",
    tab_char = "│",
    highlight = "IblIndentGray",
  },
  -- Active highlight mini.indentscope
  scope = { enabled = false },
  exclude = {
    filetypes = {
      "alpha", "dashboard", "help", "lazy", "mason", "notify",
      "neo-tree", "Trouble", "lspinfo", "checkhealth",
    },
  },
})
