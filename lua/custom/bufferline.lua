local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    mode = "buffers",                   
    style_preset = bufferline.style_preset.default,
    
    separator_style = "thin",           
    
    themable = true,
    numbers = "none",                   
    close_command = "bdelete! %d",       
    right_mouse_command = "bdelete! %d", 
    
    -- Icons
    show_buffer_icons = true,           
    show_buffer_close_icons = true,    
    show_close_icon = false,           
    show_tab_indicators = true,
    
    -- Custom name and view
    enforce_regular_tabs = false,       
    always_show_bufferline = true,     
    
    -- Changes indicator
    indicator = {
      style = 'none',                   
    },
    modified_icon = '●',                
    close_icon = '  ',
    left_trunc_marker = '',
    right_trunc_marker = '',
    
    -- Nerdtree (sidebar) integration 
    offsets = {
      {
        filetype = "nerdtree",
        text = "EXPLORER",         
        text_align = "left",
        separator = true
      }
    },
    
    -- Errors diagnostic
    diagnostics = "nvim_lsp",          
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "  " or (e == "warning" and " " or "")
        if sym ~= "" then
          s = s .. sym .. n
        end
      end
      return s
    end,
  }
})

