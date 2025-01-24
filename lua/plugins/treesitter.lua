return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    -- Textobjects, optional:
    "nvim-treesitter/nvim-treesitter-textobjects",

    -- Playground, optional for debugging/development:
    -- "nvim-treesitter/playground",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all" (for all supported parsers)
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "bash",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "git_config",
        "gitignore",
        "go",
        "graphql",
        "hcl",
        "ssh_config",
        "sql",
        "terraform"
      },

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- If you need to disable for large files, you can do something like:
      -- ignore_install = { "javascript" },

      highlight = {
        enable = true,              -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
      },

      -- Tree-sitter based indentation (experimental, but often helpful)
      indent = {
        enable = true,
      },

      -- Incremental selection based on node capture
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = "gnn", -- set to `false` to disable
          node_incremental  = "grn",
          scope_incremental = "grc",
          node_decremental  = "grm",
        },
      },

      -- Text objects (requires `nvim-treesitter-textobjects` plugin)
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can define your own text objects directly here
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- more text objects can be added here
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        -- If you want swap support:
        swap = {
          enable = true,
          swap_next = {
            ["]a"] = "@parameter.inner",
          },
          swap_previous = {
            ["[a"] = "@parameter.inner",
          },
        },
      },

      -- You can enable the 'playground' for interactive syntax tree exploration
      -- (Requires the nvim-treesitter/playground plugin)
      -- playground = {
      --   enable = true,
      --   disable = {},
      --   updatetime = 25, -- Debounced time for highlighting nodes
      --   persist_queries = false, -- Whether the query persists across vim sessions
      -- },
    })
  end,
}

