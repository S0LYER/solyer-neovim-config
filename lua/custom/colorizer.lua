local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup({
  filetypes = { "*" }, 
  user_default_options = {
    RGB = true,       
    RRGGBB = true,    
    names = false,     
    RRGGBBAA = true,  
    rgb_fn = true,     
    hsl_fn = true,     
    css = true,       
    css_fn = true,    
    mode = "background", 
  },
})

