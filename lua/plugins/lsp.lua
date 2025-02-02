-- lua/user/lsp.lua
--------------------------------------------------------------------------------
-- This file configures the Neovim LSP client via nvim-lspconfig, Mason, and
-- Mason-LSPconfig. It declares the plugin specs for lazy.nvim, installs them,
-- and then sets up the servers (with an example on_attach function).
--------------------------------------------------------------------------------
return {
	-- 1) The core LSP config plugin
	"neovim/nvim-lspconfig",

	-- 2) Mason and Mason-LSPconfig for installing/updating language servers
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Optional: If you’re using nvim-cmp for autocompletion, you might want:
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		-- 3) Set up Mason first
		require("mason").setup()

		-- 4) Ensure the servers you want are installed
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ansiblels",
				"bashls",
				"denols",
				"gopls",
				"helm_ls",
				"eslint",
				"puppet",
				"terraformls",
				"yamlls",
				-- Add any other LSP servers you want here
			},
			automatic_installation = true, -- automatically detect & install new servers
		})

		-- 5) If you use nvim-cmp, you can set custom capabilities:
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) -- If using nvim-cmp

		-- 6) `on_attach` function to map keybinds after LSP attaches to the current buffer
		local on_attach = function(client, bufnr)
			-- Example keymaps
			local buf_map = function(mode, lhs, rhs, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
			buf_map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
			buf_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
			buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			buf_map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
			-- etc...
		end

		-- 7) Now let's configure servers via lspconfig
		local lspconfig = require("lspconfig")

		-- denols
		lspconfig.denols.setup({
			on_attach = on_attach,
			capabilities = capabilities,

			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"), -- Only activate in Deno projects

			init_options = {
				enable = true,
				lint = true, -- Enable Deno's built-in linter
				unstable = false, -- Set to true if you want to use unstable Deno APIs
			},
		})

		-- Lua (lua_ls)
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			},
		})

		-- Go (gopls)
		lspconfig.gopls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						nilness = true,
						unusedwrite = true,
					},
					staticcheck = true,
				},
			},
		})

		-- eslint
		lspconfig.eslint.setup({
			on_attach = function(client, bufnr)
				-- If you want ESLint to handle formatting:
				-- client.server_capabilities.documentFormattingProvider = true

				-- Combine your general on_attach with ESLint specifics:
				on_attach(client, bufnr)

				-- Auto-fix on save (code actions)
				-- This pattern uses an autocmd to run eslint fixes on save:
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
			capabilities = capabilities,
			settings = {
				eslint = {
					-- Some users like enabling code actions on save:
					codeActionOnSave = {
						enable = true,
						mode = "all", -- "all" or "problems"
					},
					-- "packageManager" can be "npm" or "yarn" if needed
				},
			},
		})

		-- Python (pyright)
		lspconfig.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			-- settings = { ... } -- your Python-specific settings here
		})

		-- For other servers, just do something like:
		-- lspconfig.tsserver.setup({
		--   on_attach = on_attach,
		--   capabilities = capabilities,
		-- })
		-- lspconfig.html.setup({...})
		-- etc.
	end,
}
