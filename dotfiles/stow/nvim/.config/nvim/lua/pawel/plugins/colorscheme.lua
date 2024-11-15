return {
	"Rigellute/shades-of-purple.vim",
	lazy = false,
	priority = 1000,
	opts = {
    	-- transparent_background = true, -- set background to transparent
    	-- transparent = true
    	-- gamma = 1.00, -- adjust the brightness of the theme
         -- custom options here
    },
    config = function(_, opts)
        -- require("shades_of_purple").setup(opts) -- calling setup is optional
		vim.cmd("colorscheme shades_of_purple")
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		-- transparent_background = true -- set background to transparent
    	-- gamma = 1.00 -- adjust the brightness of the theme
	end,
}


-- return {
-- 	"tiagovla/tokyodark.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	opts = {
--     	transparent_background = false, -- set background to transparent
--     	gamma = 1.00, -- adjust the brightness of the theme
--        -- custom options here
--     },
--     config = function(_, opts)
--         require("tokyodark").setup(opts) -- calling setup is optional
-- 		vim.cmd("colorscheme tokyodark")
-- 	end,
-- }





-- return {
-- 	"folke/tokyonight.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		local transparent = true -- set to true if you would like to enable transparency

-- 		local bg = "#011628"
-- 		local bg_dark = "#011423"
-- 		local bg_highlight = "#143652"
-- 		local bg_search = "#0A64AC"
-- 		local bg_visual = "#275378"
-- 		local fg = "#CBE0F0"
-- 		local fg_dark = "#B4D0E9"
-- 		local fg_gutter = "#627E97"
-- 		local border = "#547998"

-- 		require("tokyonight").setup({
-- 			style = "night",
-- 			transparent = transparent,
-- 			styles = {
-- 				sidebars = transparent and "transparent" or "dark",
-- 				floats = transparent and "transparent" or "dark",
-- 			},
-- 			on_colors = function(colors)
-- 				colors.bg = bg
-- 				colors.bg_dark = transparent and colors.none or bg_dark
-- 				colors.bg_float = transparent and colors.none or bg_dark
-- 				colors.bg_highlight = bg_highlight
-- 				colors.bg_popup = bg_dark
-- 				colors.bg_search = bg_search
-- 				colors.bg_sidebar = transparent and colors.none or bg_dark
-- 				colors.bg_statusline = transparent and colors.none or bg_dark
-- 				colors.bg_visual = bg_visual
-- 				colors.border = border
-- 				colors.fg = fg
-- 				colors.fg_dark = fg_dark
-- 				colors.fg_float = fg
-- 				colors.fg_gutter = fg_gutter
-- 				colors.fg_sidebar = fg_dark
-- 			end,
-- 		})

-- 		vim.cmd("colorscheme tokyonight")
-- 	end,
-- }
