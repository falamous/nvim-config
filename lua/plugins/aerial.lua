return {
	"stevearc/aerial.nvim",
	event = "User",
	cmd = {
		"AerialToggle",
		"AerialOpen",
		"AerialOpenAll",
		"AerialClose",
		"AerialCloseAll",
		"AerialNext",
		"AerialPrev",
		"AerialGo",
		"AerialInfo",
		"AerialNavToggle",
		"AerialNavOpen",
		"AerialNavClose",
	},
	keys = { "{", "}" },
	opts = function()
		local opts = {
			attach_mode = "global",
			backends = { "lsp", "treesitter", "markdown", "man" },
			layout = { min_width = 28 },
			show_guides = true,
			filter_kind = false,
			guides = {
				mid_item = "├ ",
				last_item = "└ ",
				nested_top = "│ ",
				whitespace = "  ",
			},
			keymaps = {
				["{"] = "actions.prev",
				["}"] = "actions.next",
			},
		}

		return opts
	end,
}
