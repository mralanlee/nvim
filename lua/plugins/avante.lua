return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,

	-- Main Avante configuration
	opts = {
		-- Primary provider for Avante
		provider = "claude",
		auto_suggestion_provider = "claude",
		-- If you want to enable both OpenAI and Copilot from Avante,
		-- you can do: providers = { "openai", "copilot" },
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-3-5-sonnet-20241022",
			temperature = 0,
			max_tokens = 4096,
		},
		behavior = {
			auto_suggestion = true,
			auto_set_highlight_group = true,
		},
		claude_api_key = vim.fn.getenv("ANTHROPIC_API_KEY"),
		model = "claude-2",
		-- Example: choose a different model
		-- model = "gpt-3.5-turbo",
		max_tokens = 2048, -- Maximum tokens in response
		temperature = 0.7, -- Creativity level (higher = more creative)
		top_p = 0.9, -- Sampling parameter
		top_k = 50, -- Sampling parameter

		-- Customize the appearance of the chat window
		chat_window = {
			border = "rounded",
			position = "50%", -- Centered on the screen
		},
		-- ...additional Avante settings...
	},

	-- If you want to build from source: `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- or on Windows:
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"

	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",

		-- Optional dependencies for certain Avante features:
		"echasnovski/mini.pick", -- for file_selector with mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector with telescope
		"hrsh7th/nvim-cmp", -- autocompletion for Avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector with fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons

		-- Copilot provider for Avante (and general inline AI suggestions)
		{
			"zbirenbaum/copilot.lua",
			event = "VeryLazy",
			config = function()
				require("copilot").setup({
					suggestion = {
						enabled = true, -- inline suggestions
						auto_trigger = true,
						keymap = {
							accept = "<C-l>",
							accept_word = false,
							accept_line = false,
							next = "<C-j>",
							prev = "<C-k>",
							dismiss = "<C-h>",
						},
					},
					panel = { enabled = true },
				})
			end,
		},

		-- Image paste support
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				embed_image_as_base64 = false,
				prompt_for_file_name = false,
				drag_and_drop = { insert_mode = true },
				use_absolute_path = true, -- required for Windows
			},
		},

		-- Markdown rendering (optional)
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
