return {
	event = "BufWritePost",
	"mfussenegger/nvim-lint",
	config = function()
		-- clang-tidy include path

		require("lint").linters_by_ft = {
			typescript = { "eslint" },
			go = { "golangcilint" },
			sh = { "shellcheck" },
			zsh = { "zsh" },
			yaml = { "yamllint" },
			-- lua = { "luacheck" },
			ansible = { "ansible_lint" },
			terraform = { "tflint" },
			markdown = { "vale" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
