local status_ok, rainbow = pcall(require, "rainbow-delimiters")
if not status_ok then return end

vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow.strategy.global,
  },
}
