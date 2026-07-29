return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'default' },
    completion = { documentation = { auto_show = true} },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    appearance = {
      nerd_font_variant = 'mono'
    },
  },
  opts_extend = { "sources.default" }
}
