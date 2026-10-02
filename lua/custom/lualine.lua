local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local function get_project_name()
  local root_dir = vim.fs.dirname(vim.fs.find({'.git', 'package.json', 'go.mod', 'Cargo.toml'}, { upward = true })[1])
  if root_dir then
    return vim.fs.basename(root_dir)
  end
  return "No Project"
end

lualine.setup({
  options = {
    theme = 'auto', 
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' }, 
    disabled_filetypes = {
      statusline = { "alpha", "dashboard", "NvimTree", "nerdtree" },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true, 
  },
  sections = {
    lualine_a = {
      { 
        'mode', 
        fmt = function(str) return str:sub(1,3) end 
      }
    },
    lualine_b = {
      { 'branch', icon = '' },
      { 
        'diff', 
        symbols = { added = ' ', modified = ' ', removed = '' } 
      },
    },
    lualine_c = {
      { get_project_name, icon = ' ', color = { fg = '#A3E635', gui = 'bold' } }, 
      { 
        'filename', 
        file_status = true, 
        path = 1 
      }
    },
    
    lualine_x = {
      {
        'diagnostics', 
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰞏 ' },
      },
      'encoding',      
      'fileformat',    
      'filetype',     
    },
    lualine_y = { 'progress' }, 
    lualine_z = { 'location' }  
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
})

