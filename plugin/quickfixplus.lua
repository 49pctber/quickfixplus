
vim.api.nvim_create_user_command("QuickFixPlusAdd", require("quickfixplus").add_pos,
  { desc = "Add the current position to the quickfix list" })

vim.api.nvim_create_user_command("QuickFixPlusRemove", require("quickfixplus").remove_pos,
  { desc = "Remove the current position from the quickfix list" })

vim.api.nvim_create_user_command("QuickFixPlusToggle", require("quickfixplus").toggle_pos,
  { desc = "Toggle the current position in the quickfix list" })

vim.api.nvim_create_user_command("QuickFixPlusToggleSigns", require("quickfixplus").toggle_signs,
  { desc = "Toggle the QuickFixPlus signs" })

vim.api.nvim_create_user_command("QuickFixPlusEnableSigns", require("quickfixplus").enable_signs,
  { desc = "Enable the QuickFixPlus signs" })

vim.api.nvim_create_user_command("QuickFixPlusDisableSigns", require("quickfixplus").disable_signs,
  { desc = "Disable the QuickFixPlus signs" })

