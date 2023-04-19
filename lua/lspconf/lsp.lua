---
--- mason, mason-lspconfig and cmp_nvim_lsp config
---

-- enable config
local lspconfig = require('lspconfig')
-- enable mason.nvim
require("mason").setup()
-- enable mason-lspconfig
local mason_lspconfig=require("mason-lspconfig")

-- ensure gopls pyright r_language_server be installed
mason_lspconfig.setup({
	ensure_installed = {
		"gopls",
		"pyright",
		"r_language_server",
		"lua_ls",
	},
})

local attach = function ()
	-- enable lsp keymaps 
	require('keymaps').attach()
	-- enable auto-open floating diagnostics, lsp info style
	require('lspconf.handlers').setup()
	-- LSP signature hint as you type 
	require("lsp_signature").on_attach()
end



-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
----------give up the deprecated api : cmp_nvim_lsp.update_capabilities---------
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)   --
----------use cmp_nvim_lsp.default_capabilities() instead-----------------------
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
----------enable foldingRange to ensure nvim-ufo work---------------------------
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Enable all language servers installed with the additional completion capabilities offered by nvim-cmp
-- use quick-start config to speed up this step
require("mason-lspconfig").setup_handlers({
	-- default setup
    function(server)
        lspconfig[server].setup({
            on_attach = attach,
			capabilities = capabilities,
        })
    end,

   -- provide targeted overrides for specific servers.
   ["r_language_server"] = function ()
		lspconfig["r_language_server"].setup {
		  on_attach = attach,
		  capabilities = capabilities,
		  settings = {
			r = {
			  lsp = {
				diagnostics = false,
			  },
			},
		  },
		}
   end,
   ["lua_ls"] = function ()
	   lspconfig.lua_ls.setup {
		  on_attach = attach,
		  capabilities = capabilities,
		   settings = {
			   Lua = {
				   diagnostics = {
					   globals = { "vim" }
				   }
			   }
		   }
	   }
   end,
})


-- luasnip setup for cmp
local luasnip = require 'luasnip'
require('luasnip/loaders/from_vscode').lazy_load({ paths = { './snippets' } })

-- for cmp copilot
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end


-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
--    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = vim.schedule_wrap(function(fallback)
		  if cmp.visible() and has_words_before() then
			cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
		  elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		  else
			fallback()
		  end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = "copilot"},
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
	{ name = 'buffer' },
	{ name = 'path'},
	{ name = 'nvim_lua'},
  },
}



