-- [[ Configura e instala os plugins ]]
--
--  Para verificiar, atualizar ou remover plugins:
--    :Lazy
--
--  Para so atualizar:
--    :Lazy update
--
-- NOTE: Aqui é onde você instala os seus plugins.
require('lazy').setup({
  -- NOTE: Plugins podem ser adicionas com github org/name. Para rodar o setup automatico do plugin, use `opts = {}`
  { 'NMAC427/guess-indent.nvim', opts = {} },

  -- Como esse repo é modular, você carrega os arquivos de plugin assim: using `require 'path.name'`
  -- isso vai incluir o plugin do path usado, ex: 'lua/custom/plugin_name.lua' ficaria assim: require 'custom.plugin_name'

  -- Abaixo estão os plugins padrões do kickstart (lua/kickstart/plugins/*)
  require 'kickstart.plugins.gitsigns',

  require 'kickstart.plugins.which-key',

  require 'kickstart.plugins.telescope',

  require 'kickstart.plugins.lspconfig',

  require 'kickstart.plugins.conform',

  require 'kickstart.plugins.blink-cmp',

  require 'kickstart.plugins.tokyonight',

  require 'kickstart.plugins.todo-comments',

  require 'kickstart.plugins.mini',

  require 'kickstart.plugins.treesitter',

  -- Abaixo estão plugins opcionais que você pode habilitar apenas descomentando a linha (tip: keybind 'gcc' pra comentar/descomentar uma linha)

  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',

  -- NOTE: O import abaixo adiciona os plugins, configs, etc automaticamente de: `lua/custom/plugins/*.lua`
  --    Esse é o jeito mais prático de modularizar sua config do neovim.
  --
  --  adicione seus plugins em `lua/custom/plugins/*.lua` e eles serão instalados automaticamente.
  --  o arquivo `lua/custom/plugins/init.lua` é um exemplo de como adicionar mais plugins
  { import = 'custom.plugins' },
  --
  --
  -- Abaixo sao os icones de fallback caso não use uma nerdfont
  --
}, { ---@diagnostic disable-line: missing-fields
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
