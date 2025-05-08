require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tf", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "open floating diagnostic" })
map("n", "<leader>lr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "see references to symbol" })
