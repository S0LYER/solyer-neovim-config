-- Colors
vim.api.nvim_set_hl(0, "AlphaHeader",  { fg = "#ffffff" }) -- Цвет вашего ASCII-арта
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#ffffff" }) -- Цвет текста кнопок
vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#ffffff", bold = true }) -- Цвет горячих клавиш (букв слева)
vim.api.nvim_set_hl(0, "AlphaFooter",  { fg = "#ffffff", italic = true }) -- Цвет подписи снизу

-- Safe plugin loader
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")

--- Frame
local top_border = {
  type = "text",
  val = "╔══════════════════════════════════════════════════════════════╗",
  opts = {
    hl = "AlphaButtons",
    position = "center",
  },
}

local bottom_border = {
  type = "text",
  val = "╚══════════════════════════════════════════════════════════════╝",
  opts = {
    hl = "AlphaButtons",
    position = "center",
  },
}

-- Banner (top)
dashboard.section.header.val = {
  [[ ]],
  [[ ]],
  [[ ]],
  [[ ]],
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


-- Menu buttons
dashboard.section.buttons.val = {
  dashboard.button("n", "   New file", "<cmd>ene<CR>"),
  dashboard.button("r", "   Recent files", "<cmd>browse oldfiles<CR>"),
  dashboard.button("i", "   Install plugins", "<cmd>PlugInstall<CR>"),
  dashboard.button("u", " 󰚰  Update plugins", "<cmd>PlugUpdate<CR>"),
  dashboard.button("s", "   Plugin status", "<cmd>PlugStatus<CR>"),
  dashboard.button("q", " 󰈆  Exit", "<cmd>qa<CR>"),

}

dashboard.section.buttons.opts.hl = "AlphaButtons" -- Button colors
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end


-- Text (bot)
dashboard.section.footer.val = "Solyer's neovim v 1.0.0"
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Startup setup
dashboard.config.layout = {
  { type = "padding", val = 7 }, -- Space between banner and top
  
  dashboard.section.header,      -- Banner
  
  { type = "padding", val = 10 }, -- Space between banner and top of frame
  
  top_border,                    -- Top of frame

  { type = "padding", val = 1 }, -- Space between top of frame and buttons

  dashboard.section.buttons,     -- Buttons
  
 -- { type = "padding", val = 1 }, -- Space between buttons and bot of frame

  bottom_border,                 -- Bot of frame
  
  { type = "padding", val = 25 }, -- Space betmeen futter and bot of frame
  dashboard.section.footer,
}

alpha.setup(dashboard.config)
