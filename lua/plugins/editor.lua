return {
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", desc = "Comment toggle current line" },
			{ "gbc", desc = "Comment toggle current block" },
			{ "gc",  desc = "Comment toggle linewise" },
			{ "gb",  desc = "Comment toggle blockwise" },
			{ "gc",  desc = "Comment toggle linewise (visual)" },
			{ "gb",  desc = "Comment toggle blockwise (visual)" },
			{ "gco", desc = "Comment insert below" },
			{ "gcO", desc = "Comment insert above" },
			{ "gcA", desc = "Comment insert end of line" },
		},
	},

	-- search/replace in multiple files
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
	},

	-- git signs highlights text that has changed since the list
	-- git commit, and also lets you interactively stage & unstage
	-- hunks in a commit.
	{
		"lewis6991/gitsigns.nvim",
		event = "User",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
		},
	},
	{
		lazy = false,
		'nmac427/guess-indent.nvim',
		cmd = "GuessIndent",
		config = function() require('guess-indent').setup {} end,
	},
}
