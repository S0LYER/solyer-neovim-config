if vim.fn.has("nvim-0.11") == 0 then
  vim.notify("custom.lsp: нужен Neovim 0.11+", vim.log.levels.WARN)
  return
end

local mason_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

if not (mason_ok and mason_lsp_ok) then
  return
end

-- Mason initialisation
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Capabilities 
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- Settings for all servers
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Lua settings
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- Servers
local servers = {
  "lua_ls",
}

-- Installation and autostart
mason_lsp.setup({
  ensure_installed = servers,
  automatic_enable = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Перейти к определению")
    map("gr", vim.lsp.buf.references, "Ссылки")
    map("K", vim.lsp.buf.hover, "Документация")
    map("<leader>rn", vim.lsp.buf.rename, "Переименовать")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>e", vim.diagnostic.open_float, "Показать диагностику")
  end,
})
