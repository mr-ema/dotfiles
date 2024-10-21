local port = os.getenv('GDScript_Port') or '6005'
local pipe = '/tmp/godot.pipe' -- Godot pipe

local function start_godot_lsp(bufnr)
  local cmd = { 'nc', '127.0.0.1', port }

  -- Start LSP for the current buffer
  vim.lsp.start({
    name = 'Godot',
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
    on_attach = function(client, bufnr)
      -- Ensure server starts only once, but for multiple buffers
      if not client.initialized then
        vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
        client.initialized = true
      end
    end,
    -- Pass the current buffer as the context for the LSP client
    bufnr = bufnr,
  })
end

-- Attach LSP to the current buffer
start_godot_lsp(vim.api.nvim_get_current_buf())
