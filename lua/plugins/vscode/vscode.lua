-- Keybindings for nvim in VSCode
-- Mirrors the keybindings from novscode/lsp.lua and novscode/core.lua

local vscode = require("vscode")

return {
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		event = "VeryLazy",
		cond = vim.g.vscode,
		opts = {},
	},
	{
		dir = vim.fn.stdpath("config"),
		name = "vscode-keybindings",
		cond = vim.g.vscode,
		lazy = false,
		config = function()
			local keymap = vim.keymap.set

			-- LSP keybindings (from lsp.lua)
			keymap("n", "gd", function()
				vscode.call("editor.action.revealDefinition")
			end, { desc = "Goto Definition" })

			keymap("n", "gr", function()
				vscode.call("editor.action.goToReferences")
			end, { desc = "References" })

			keymap("n", "gR", function()
				vscode.call("workbench.action.findInFiles")
			end, { desc = "Live grep" })

			keymap("n", "gI", function()
				vscode.call("editor.action.goToImplementation")
			end, { desc = "Goto Implementation" })

			keymap("n", "ge", function()
				vscode.call("editor.action.showHover")
			end, { desc = "Show diagnostic" })

			keymap("n", "gy", function()
				vscode.call("editor.action.rename")
			end, { desc = "Rename" })

			keymap("n", "gh", function()
				vscode.call("editor.action.showHover")
			end, { desc = "Hover" })

			-- Core keybindings (from core.lua)
			keymap("n", "<leader>?", function()
				vscode.call("workbench.action.showCommands")
			end, { desc = "Show Commands" })

			keymap("n", "<leader>un", function()
				vscode.call("notifications.clearAll")
			end, { desc = "Dismiss All Notifications" })

			-- Additional useful VSCode keybindings
			keymap("n", "<leader>ff", function()
				vscode.call("workbench.action.quickOpen")
			end, { desc = "Find Files" })

			keymap("n", "<leader>e", function()
				vscode.call("workbench.action.toggleSidebarVisibility")
			end, { desc = "Toggle Sidebar" })

			keymap("n", "[d", function()
				vscode.call("editor.action.marker.prev")
			end, { desc = "Previous Diagnostic" })

			keymap("n", "]d", function()
				vscode.call("editor.action.marker.next")
			end, { desc = "Next Diagnostic" })

			keymap("n", "<leader>ca", function()
				vscode.call("editor.action.quickFix")
			end, { desc = "Code Action" })

			keymap("n", "<leader>cf", function()
				vscode.call("editor.action.formatDocument")
			end, { desc = "Format Document" })

			-- Comment keybindings (gc like vim-commentary/Comment.nvim)
			keymap("n", "gcc", function()
				vscode.call("editor.action.commentLine")
			end, { desc = "Toggle Comment Line" })

			keymap("v", "gc", function()
				vscode.call("editor.action.commentLine")
			end, { desc = "Toggle Comment" })

			keymap("n", "gbc", function()
				vscode.call("editor.action.blockComment")
			end, { desc = "Toggle Block Comment" })

			keymap("v", "gb", function()
				vscode.call("editor.action.blockComment")
			end, { desc = "Toggle Block Comment" })
		end,
	},
}

