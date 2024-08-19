return {
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		config = function()
			vim.cmd.colorscheme("nord")
			vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
		end,
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss All Notifications",
			},
		},
		opts = {
			background_colour = "#000000",
			stages = "static",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		config = function(_, opts)
			notify = require("notify")
			vim.notify = notify
			notify.setup(opts)
		end,
	},

	-- better vim.ui with telescope
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"lambdalisue/vim-suda",
		cmd = { "SudaRead", "SudaWrite" },
	},

	{
		'Wansmer/langmapper.nvim',
		lazy = false,
		priority = 1, -- High priority is needed if you will use `autoremap()`
		config = function()
			local function escape(str)
				-- You need to escape these characters to work correctly
				local escape_chars = [[;,."|\]]
				return vim.fn.escape(str, escape_chars)
			end

			-- Recommended to use lua template string
			local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
			local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
			local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
			local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

			vim.opt.langmap = vim.fn.join({
				-- | `to` should be first     | `from` should be second
				escape(ru_shift) .. ';' .. escape(en_shift),
				escape(ru) .. ';' .. escape(en),
			}, ',')
			require('langmapper').setup({
			})
		end,
	},

	{
		'akinsho/bufferline.nvim',
		event = "VeryLazy",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				-- numbers = function(args) return tostring(args.id); end,
				buffer_close_icon = 'x',
				close_icon = 'x',
				modified_icon = '~',
				left_trunc_marker = '<',
				right_trunc_marker = '>',
				show_buffer_icons = true,
				separator_style = "thin",

			}
		}

	},
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

}
