# QuickFixPlus

A simple plugin to make adding and removing items from your quickfix list easier.

## Example Configuration

``` lua
require("quickfixplus").setup({
  show_signs = true,
  sign_text = "Q"
})

vim.keymap.set('n', "<leader>qa", require("quickfixplus").add_pos, { desc = "Append current position to quickfix list" })
vim.keymap.set('n', "<leader>qd", require("quickfixplus").remove_pos, { desc = "Remove current line from quickfix list" })
vim.keymap.set('n', "<leader>qq", require("quickfixplus").toggle_pos, { desc = "Toggle current line in quickfix list" })
vim.keymap.set('n', "<leader>qs", require("quickfixplus").toggle_signs, { desc = "Toggle quickfixplus signs" })
```
