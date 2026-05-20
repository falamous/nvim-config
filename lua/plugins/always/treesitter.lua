local parsers = {
	"bash",
	"c",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"vim",
	"vimdoc",
	"cpp",
	"rust",
	"typescript",
	"javascript",
	"latex",
	"dockerfile",
}

local select_maps = {
	["ak"] = { "@block.outer", "around block" },
	["ik"] = { "@block.inner", "inside block" },
	["ac"] = { "@class.outer", "around class" },
	["ic"] = { "@class.inner", "inside class" },
	["a?"] = { "@conditional.outer", "around conditional" },
	["i?"] = { "@conditional.inner", "inside conditional" },
	["af"] = { "@function.outer", "around function" },
	["if"] = { "@function.inner", "inside function" },
	["ao"] = { "@loop.outer", "around loop" },
	["io"] = { "@loop.inner", "inside loop" },
	["aa"] = { "@parameter.outer", "around argument" },
	["ia"] = { "@parameter.inner", "inside argument" },
}

local move_maps = {
	goto_next_start = {
		["]k"] = { "@block.outer", "Next block start" },
		["]f"] = { "@function.outer", "Next function start" },
		["]a"] = { "@parameter.inner", "Next argument start" },
	},
	goto_next_end = {
		["]K"] = { "@block.outer", "Next block end" },
		["]F"] = { "@function.outer", "Next function end" },
		["]A"] = { "@parameter.inner", "Next argument end" },
	},
	goto_previous_start = {
		["[k"] = { "@block.outer", "Previous block start" },
		["[f"] = { "@function.outer", "Previous function start" },
		["[a"] = { "@parameter.inner", "Previous argument start" },
	},
	goto_previous_end = {
		["[K"] = { "@block.outer", "Previous block end" },
		["[F"] = { "@function.outer", "Previous function end" },
		["[A"] = { "@parameter.inner", "Previous argument end" },
	},
}

local swap_maps = {
	swap_next = {
		[">K"] = { "@block.outer", "Swap next block" },
		[">F"] = { "@function.outer", "Swap next function" },
		[">A"] = { "@parameter.inner", "Swap next argument" },
	},
	swap_previous = {
		["<K"] = { "@block.outer", "Swap previous block" },
		["<F"] = { "@function.outer", "Swap previous function" },
		["<A"] = { "@parameter.inner", "Swap previous argument" },
	},
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			for lhs, spec in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					require("nvim-treesitter-textobjects.select").select_textobject(spec[1], "textobjects")
				end, { desc = spec[2] })
			end

			for fn, maps in pairs(move_maps) do
				for lhs, spec in pairs(maps) do
					vim.keymap.set({ "n", "x", "o" }, lhs, function()
						require("nvim-treesitter-textobjects.move")[fn](spec[1], "textobjects")
					end, { desc = spec[2] })
				end
			end

			for fn, maps in pairs(swap_maps) do
				for lhs, spec in pairs(maps) do
					vim.keymap.set("n", lhs, function()
						require("nvim-treesitter-textobjects.swap")[fn](spec[1])
					end, { desc = spec[2] })
				end
			end
		end,
	},
}
