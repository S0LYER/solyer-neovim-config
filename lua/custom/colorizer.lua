local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then return end

colorizer.setup({
  filetypes = { "*" }, 
  user_default_options = {
    RGB = true,
    RGBA = true,
    names = false,        
    RRGGBB = true,
    RRGGBBAA = true,
    mode = "background",   
  },
})

vim.cmd("ColorizerAttachToBuffer")
