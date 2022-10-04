---
--- mason, mason-lspconfig and cmp_nvim_lsp config
---
-- enable lspconfig
local lspconfig = require('lspconfig')
-- enable mason.nvim
local mason=require("mason")
mason.setup()
-- enable mason-lspconfig
local mason_lspconfig=require("mason-lspconfig")
mason_lspconfig.setup()

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
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
-- Enable all language servers installed with the additional completion capabilities offered by nvim-cmp
local servers = mason_lspconfig.get_installed_servers()
for _, lsp in ipairs(servers) do
  if lsp == "r_language_server" then
	lspconfig[lsp].setup {
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
  else
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
    }
  end

end


-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
	{ name = 'buffer' },
	{ name = 'path'},
	{ name = 'nvim_lua'},
  },
}


