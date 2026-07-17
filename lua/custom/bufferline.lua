local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then return end

bufferline.setup({
  options = {
    mode = "buffers",
    separator_style = { "", "" },  -- Rounded
    show_buffer_close_icons = true, -- X to close
    show_close_icon = false,
  },
  highlights = {

    fill = {
      bg = "NONE",
    },

    -- Unactive
    background = {
      fg = "#a6adc8", 
      bg = "NONE",
    },
    buffer_visible = {
      fg = "#cdd6f4", 
      bg = "NONE",
    },

    -- Active
    buffer_selected = {
      fg = "#11111b", 
      bg = "#ffffff", 
      bold = true,   
      italic = false,
    },

    -- Rounded
    separator_selected = {
      fg = "#ffffff", 
      bg = "NONE",   
    },

    -- Separators
    separator = {
      fg = "#313244", 
      bg = "NONE",
    },
    separator_visible = {
      fg = "#313244",
      bg = "NONE",
    },

    -- "Close" button
    close_button = {
      fg = "#a6adc8", 
      bg = "NONE",
    },
    close_button_visible = {
      fg = "#cdd6f4",
      bg = "NONE",
    },
    close_button_selected = {
      fg = "#1e1e2e", 
      bg = "#ffffff", 
    },

    -- Changes in files
    modified = {
      fg = "#f38ba8", 
      bg = "NONE",
    },
    modified_visible = {
      fg = "#f38ba8",
      bg = "NONE",
    },
    modified_selected = {
      fg = "#f38ba8", 
      bg = "#ffffff",
    },

    -- Other colors
    tab = { bg = "NONE" },
    tab_selected = { bg = "NONE" },
    indicator_selected = {
      fg = "NONE",
      bg = "NONE",
    },
  }
})
