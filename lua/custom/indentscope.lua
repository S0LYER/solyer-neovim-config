local status_ok, indentscope = pcall(require, "mini.indentscope")
if not status_ok then
  return
end

indentscope.setup({
  symbol = "│", 
  options = {
    try_as_border = true,
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "alpha", "dashboard", "help", "lazy", "mason", "notify" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
