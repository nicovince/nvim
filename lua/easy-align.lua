-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")

-- This configuration is remapping the ga command (which show the ascii char under the cursor.
-- the ga command can be replaced with ':as(cii)'
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")

vim.g.easy_align_delimiters = {
  ["\\"] = {
    pattern = "\\\\",
  },
}
