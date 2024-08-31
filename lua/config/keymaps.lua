-- Map Ctrl+c to escape from other modes
vim.keymap.set({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]])

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

