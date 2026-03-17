-- NOTE: Plugins também podem ser configurados para executar Lua quando são carregados.
--
-- Isso é útil tanto para agrupar configuracões quanto para lidar com o
-- lazy loading de plugins que não precisam iniciar imediatamente.
--
-- Por exemplo, na config abaixo, usamos:
--   event = 'VimEnter'
-- que carrega o 'which-key' antes de todos os elementos da UI serem carregados.

-- Eventos podem ser eventos normais de autocomandos (`:help autocmd-events`).
--
-- Além disso, como usamos a chave `opts`, a config é executada
-- após o plugin ter sido carregado como `require(MODULO).setup(opts)`.

---@module 'lazy'
---@type LazySpec
return {
  { -- Plugin que mostra os atalhos que podem ser usados.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Carrega ao iniciar a interface do Vim
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      -- Atraso entre pressionar uma tecla e abrir o menu do which-key (em milissegundos)
      delay = 0,
      icons = {
        -- Usa ícones se tiver Nerd Font
        mappings = vim.g.have_nerd_font,
      },

      -- Cria grupos de keybinds existentes (prefixos)
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },
} -- vim: ts=2 sts=2 sw=2 et
