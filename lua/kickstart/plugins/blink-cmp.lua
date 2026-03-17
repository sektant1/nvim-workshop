-- NOTE: Plugins de Autocompletion
-- O blink.cmp é um motor de completion moderno e extremamente rápido.
-- Ele lida com sugestões do LSP, file paths e snippets.

---@module 'lazy'
---@type LazySpec
return {
  { -- Autocomplete
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Engine de Snippets
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- O passo de Build é necessário para suporte a regex nos snippets.
          -- Isso não é suportado em muitos ambientes Windows.
          -- Remova a condição abaixo para tentar habilitar no Windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contém uma variedade de snippets pré-fabricados.
          -- Veja o README sobre snippets de linguagens/frameworks específicos:
          -- https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          },
        },
        opts = {},
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recomendado) para atalhos similares aos nativos do Vim:
        --   <c-y> para aceitar ([y]es) a completação.
        --     Isso fará o auto-import se o seu LSP suportar.
        --     Isso expandirá o snippet se o LSP enviar um.
        -- 'super-tab' para usar Tab para aceitar igual no vscode
        -- 'enter' para usar Enter para aceitar
        -- 'none' para desativar todos os atalhos padrão
        --
        -- Para entender por que o preset 'default' é recomendado,
        -- leia a documentação em: `:help ins-completion`
        --
        -- Sério, leia `:help ins-completion`, é um guia muito bom!
        --
        -- Todos os presets possuem os seguintes atalhos:
        -- <Tab>/<S-Tab>: mover para a direita/esquerda na expansão do seu snippet
        -- <C-space>: Abre o menu ou abre a documentação se já estiver aberto
        -- <C-n>/<C-p> ou <Up>/<Down>: Selecionar item próximo/anterior
        -- <C-e>: Esconder o menu
        -- <C-k>: Alternar a ajuda de assinatura (signature help)
        --
        -- Veja :h blink-cmp-config-keymap para definir seus próprios atalhos
        preset = 'super-tab',

        -- Para atalhos mais avançados do Luasnip (ex: selecionar nodes de escolha), veja:
        -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (padrão) para 'Nerd Font Mono' ou 'normal' para 'Nerd Font'
        -- Ajusta o espaçamento para garantir que os ícones fiquem alinhados
        nerd_font_variant = 'mono',
      },

      completion = {
        -- Por padrão, você pode pressionar `<C-Space>` para mostrar a documentação.
        -- Opcionalmente, defina `auto_show = true` para mostrar após um atraso.
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        -- Define as fontes de onde virão as sugestões
        -- Tu pode colocar snippets custom dentro da sua ./config/nvim/snippets/*
        default = { 'lsp', 'path', 'snippets' },
      },

      snippets = { preset = 'luasnip' },

      -- O Blink.cmp inclui um buscador fuzzy em Rust opcional e recomendado,
      -- que baixa um binário pré-compilado automaticamente quando ativado.
      --
      -- Por padrão, usamos a implementação em Lua, mas você pode ativar a
      -- implementação em Rust via `'prefer_rust_with_warning'`
      --
      -- Veja :h blink-cmp-config-fuzzy para mais informações
      fuzzy = { implementation = 'lua' },

      -- Mostra uma janela de ajuda de assinatura enquanto você digita argumentos de uma função
      signature = { enabled = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
