local on_attach = function(client, bufnr) end
return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		keys = {
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions({ reuse_win = true })
				end,
				desc = "Goto Definition",
			},
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
			{ "gR", "<cmd>Telescope live_grep<cr>", desc = "Live grep", nowait = true },
			{
				"gI",
				function()
					require("telescope.builtin").lsp_implementations({ reuse_win = true })
				end,
				desc = "Goto Implementation",
			},
			-- { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		keys = {
			{ "gy", vim.lsp.buf.rename, desc = "Goto T[y]pe Definition" },
			{ "gh", vim.lsp.buf.signature_help, desc = "Signature Help" },
		},
	},
	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "User",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		-- Not all LSP servers add brackets when completing a function.
		-- To better deal with this, LazyVim adds a custom option to cmp,
		-- that you can configure. For example:
		--
		-- ```lua
		-- opts = {
		--   auto_brackets = { "python" }
		-- }
		-- ```
		opts = function()
			-- Set up nvim-cmp.
			local cmp = require("cmp")

			opts = {
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					-- { name = 'vsnip' }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			}

			-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
			-- Set configuration for specific filetype.
			--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]
			--

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			local lspconfig = require("lspconfig")
			lspconfig["jedi_language_server"].setup({
				capabilities = capabilities,
			})
			lspconfig["clangd"].setup({
				capabilities = capabilities,
			})
			lspconfig["gopls"].setup({
				capabilities = capabilities,
			})
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
			})
			lspconfig["texlab"].setup({
				capabilities = capabilities,
			})
			lspconfig["asm_lsp"].setup({
				capabilities = capabilities,
			})
			lspconfig["ansiblels"].setup({
				capabilities = capabilities,
			})
			return opts
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
	},

	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
