local mason_ok, mason = pcall(require, "mason")
local lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

if not (mason_ok and lsp_ok) then
  return
end

mason.setup()

mason_lsp.setup({
  ensure_installed = { "lua_ls", "pyright" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})
