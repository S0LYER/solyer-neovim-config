-- Colors
vim.api.nvim_set_hl(0, "AlphaHeader",  { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "AlphaFooter",  { fg = "#ffffff", italic = true })

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then return end

local dashboard = require("alpha.themes.dashboard")

local top_border = { type = "text", val = "╔══════════════════════════════════════════════════════════════╗", opts = { hl = "AlphaButtons", position = "center" } }
local bottom_border = { type = "text", val = "╚══════════════════════════════════════════════════════════════╝", opts = { hl = "AlphaButtons", position = "center" } }

dashboard.section.header.val = {
  [[  ██████  ▒█████   ██▓   ▓██   ██▓▓█████  ██▀███   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
  [[ ▒██    ▒ ▒██▒  ██▒▓██▒    ▒██  ██▒▓█   ▀ ▓██ ▒ ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
  [[ ░ ▓██▄   ▒██░  ██▒▒██░     ▒██ ██░▒███   ▓██ ░▄█ ▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
  [[   ▒   ██▒▒██   ██░▒██░     ░ ▐██▓░▒▓█  ▄ ▒██▀▀█▄    ▒██ █░░░██░▒██    ▒██  ]],
  [[ ▒██████▒▒░ ████▓▒░░██████▒ ░ ██▒▓░░▒████▒░██▓ ▒██▒   ▒▀█░  ░██░▒██▒   ░██▒ ]],
  [[ ▒ ▒▓▒ ▒ ░░ ▒░▒░▒░ ░ ▒░▓  ░  ██▒▒▒ ░░ ▒░ ░░ ▒▓ ░▒▓░   ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
  [[ ░ ░▒  ░ ░  ░ ▒ ▒░ ░ ░ ▒  ░▓██ ░▒░  ░ ░  ░  ░▒ ░ ▒░   ░ ░░   ▒ ░░  ░      ░ ]],
  [[ ░  ░  ░  ░ ░ ░ ▒    ░ ░   ▒ ▒ ░░     ░     ░░   ░      ░░   ▒ ░░      ░    ]],
  [[       ░      ░ ░      ░  ░░ ░        ░  ░   ░           ░   ░         ░    ]],
  [[                           ░ ░                          ░                   ]],
}
dashboard.section.header.opts.hl = "AlphaHeader"

dashboard.section.buttons.val = {
  dashboard.button("n", "   New file", "<cmd>ene<CR>"),
  dashboard.button("r", "   Recent files", "<cmd>browse oldfiles<CR>"),
  dashboard.button("u", " 󰚰  Sync plugins", "<cmd>Pckr sync<CR>"),
  dashboard.button("s", "   Plugin status", "<cmd>Pckr<CR>"),
  dashboard.button("q", " 󰈆  Exit", "<cmd>qa<CR>"),
}

dashboard.section.footer.val = "Solyer's neovim v 1.0.0"
dashboard.section.footer.opts.hl = "AlphaFooter"

local function get_layout()
  local win_height = vim.api.nvim_win_get_height(0)
  local content_height = #dashboard.section.header.val + 2 + #dashboard.section.buttons.val + 2
  local remaining_space = win_height - content_height

  return {
    { type = "padding", val = math.max(1, math.floor(remaining_space * 0.20)) },
    dashboard.section.header,
    { type = "padding", val = math.max(1, math.floor(remaining_space * 0.15)) },
    top_border,
    { type = "padding", val = 1 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    bottom_border,
    { type = "padding", val = math.max(1, math.floor(remaining_space * 0.35)) },
    dashboard.section.footer,
  }
end

dashboard.config.layout = get_layout()
alpha.setup(dashboard.config)

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "alpha" then
      dashboard.config.layout = get_layout()
      alpha.setup(dashboard.config)
      pcall(vim.cmd, "AlphaRedraw")
    end
  end,
})

