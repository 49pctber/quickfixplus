local M = {}

-- signs
local show_signs = false
local sign_name = "QfSign"
vim.fn.sign_define(sign_name, {
  text = "",
  texthl = "QuickFixLine",
  linehl = "",
  numhl = "",
})

-- update the signs
local function update_qf_signs()
  local ns = "qf_plugin_group"
  -- clear existing signs
  vim.fn.sign_unplace(ns)

  if show_signs then
    -- place signs next to quickfix items
    local qf_list = vim.fn.getqflist()
    for i, item in ipairs(qf_list) do
      if item.bufnr > 0 and item.lnum > 0 then
        vim.fn.sign_place(i, ns, sign_name, item.bufnr, {
          lnum = item.lnum,
          priority = 10,
        })
      end
    end
  end
end

-- update the signs any time the quickfix list changes
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "*",
  callback = update_qf_signs,
})

-- update the quickfix signs any time you enter a buffer or window
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = update_qf_signs,
})

-- adds the current position to the quickfix list
function M.add_pos()
  local pos = vim.fn.getpos('.')
  local line = vim.fn.getline('.')
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)
  vim.fn.setqflist({ {
    filename = file,
    lnum = pos[2],
    col = pos[3],
    text = line
  } }, 'a')
  update_qf_signs()
end

-- removes any entries in the quickfix list that contain the current line
function M.remove_pos()
  local pos = vim.fn.getpos('.')
  local buf = vim.api.nvim_get_current_buf()
  local qf_list = vim.fn.getqflist()
  for idx, entry in ipairs(qf_list) do
    if entry.bufnr == buf and entry.lnum == pos[2] then
      -- remove
      table.remove(qf_list, idx)
      vim.fn.setqflist(qf_list, 'r')
    end
  end
  update_qf_signs()
end

-- toggles the current line in the quickfix list
function M.toggle_pos()
  local pos = vim.fn.getpos('.')
  local line = vim.fn.getline('.')
  local buf = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(buf)

  -- check whether entry already exists for line
  local found = false
  local qf_list = vim.fn.getqflist()
  for idx, entry in ipairs(qf_list) do
    if entry.bufnr == buf and entry.lnum == pos[2] then
      -- found, so remove from quickfix list
      found = true
      table.remove(qf_list, idx)
      vim.fn.setqflist(qf_list, 'r')
    end
  end

  if not found then
    -- not found, so add to quickfix list
    vim.fn.setqflist({ {
      filename = file,
      lnum = pos[2],
      col = pos[3],
      text = line
    } }, 'a')
  end

  update_qf_signs()
end

-- toggles the visibility of the quickfix signs
function M.toggle_signs()
  show_signs = not show_signs
  update_qf_signs()
end

function M.enable_signs()
  show_signs = true
  update_qf_signs()
end

function M.disable_signs()
  show_signs = false
  update_qf_signs()
end

-- allows user to configure plugin
function M.setup(opts)
  -- get configuration options
  opts = opts or {}
  local defaults = {
    show_signs = false,
    sign_text = ""
  }
  M.config = vim.tbl_deep_extend("force", defaults, opts or {})

  -- enable/disable signs
  show_signs = M.config.show_signs

  -- choose sign based on opts
  vim.fn.sign_define(sign_name, {
    text = M.config.sign_text,
    texthl = "QuickFixLine",
    linehl = "",
    numhl = "",
  })
end

return M
