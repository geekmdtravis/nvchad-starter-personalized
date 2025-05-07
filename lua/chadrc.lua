-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}
M.nvdash = {
  load_on_startup = true,
}
M.base46 = {
  theme = "material-deep-ocean",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.ui = {
  -- Configuration for the NvChad terminal
  term = {
    enabled = true, -- Ensure the terminal integration is enabled
    direction = "float", -- We are configuring the floating terminal

    -- Options specific to the floating terminal
    float = {
      -- Set the width and height of the floating terminal
      -- Values between 0 and 1 are percentages of the editor size
      -- Values > 1 are absolute column/row counts
      width = 0.8, -- Make the terminal 80% of the editor width
      height = 0.8, -- Make the terminal 80% of the editor height

      -- You can also adjust position if needed, e.g.:
      -- row = 0.1, -- 10% from the top
      -- col = 0.1, -- 10% from the left

      -- Other float options like border can be set here if desired
      -- border = "rounded",
    },
  },

  -- You can keep other M.ui configurations here if you have them,
  -- for example, if you had tabufline settings:
  -- tabufline = {
  --    lazyload = false
  -- }
}

return M
