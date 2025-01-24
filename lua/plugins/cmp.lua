-- lua/user/cmp.lua
-------------------------------------------------------------
-- This module returns a Lazy plugin spec for nvim-cmp plus
-- some companion plugins (cmp-nvim-lsp, luasnip, etc.).
-------------------------------------------------------------
return {
  -- The main completion plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- LSP source for nvim-cmp
    "hrsh7th/cmp-nvim-lsp",

    -- Useful completion sources
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    -- Snippet engine
    "L3MON4D3/LuaSnip",
    -- Snippet source for nvim-cmp
    "saadparwaiz1/cmp_luasnip",
    -- (Optional) A collection of snippets
    "rafamadriz/friendly-snippets",
  },

  config = function()
    -----------------------------------------------------------
    -- 1) Setup LuaSnip
    -----------------------------------------------------------
    local luasnip = require("luasnip")
    -- If you installed "rafamadriz/friendly-snippets", you can do:
    require("luasnip.loaders.from_vscode").lazy_load()

    -----------------------------------------------------------
    -- 2) Setup nvim-cmp
    -----------------------------------------------------------
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = {
        -- Use <Tab> and <S-Tab> to navigate through popup menu
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Confirm selection with <CR>
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- (Optional) Setup cmdline completions, e.g., for searching `/` or command `:`
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline" }
      }),
    })
  end,
}

