return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "horizon",
        incons_enabled = true,
      },
    })
  end,
}
-- Configuration from gentleman programming
-- statusline
-- {
-- 	"nvim-lualine/lualine.nvim",
-- 	event = "VeryLazy",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		require("lualine").setup({
-- 			options = {
-- 				theme = "everforest",
-- 				icons_enabled = true,
-- 			},
-- 			sections = {
-- 				lualine_a = {
-- 					{
-- 						"mode",
-- 						icon = "󱗞",
-- 					},
-- 				},
-- 			},
-- 		})
-- 	end,
-- },
