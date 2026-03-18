-- NOTE: Plugins podem especificar dependências.
--
-- As dependências também são especificações de plugin completas - qualquer coisa
-- que você faça para um plugin no nível parent, pode fazer para uma child.
--
-- Use `dependencies` para especificar as dependências de um plugin específico.

---@module 'lazy'
---@type LazySpec
return {
  { -- Fuzzy Finder (arquivos, lsp, etc)
    'nvim-telescope/telescope.nvim',
    -- Por padrão, o Telescope está incluído e atua como seu picker para tudo.

    -- Se você quiser mudar para um picker diferente (como snacks ou fzf-lua),
    -- você pode desativar o plugin Telescope definindo enabled como false e ativar
    -- o seu picker substituto exigindo-o explicitamente (ex: 'custom.plugins.snacks')

    -- NOTE: Se você customizar sua config,
    -- é melhor remover a config do plugin Telescope inteiramente
    -- em vez de apenas desativá-la aqui, para manter sua config limpa.
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- Se encontrar erros, veja o README do telescope-fzf-native para instruções de instalação
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` é usado para executar algum comando quando o plugin é instalado/atualizado.
        -- Isso é executado apenas nessas ocasiões, não toda vez que o Neovim inicia.
        build = 'make',

        -- `cond` é uma condição usada para determinar se este plugin deve ser
        -- instalado e carregado.
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Útil para ícones, mas requer uma Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- O Telescope é um fuzzy finder que vem com muitas coisas diferentes que
      -- ele pode encontrar via fuzzy find!
      -- ele pode pesquisar muitos aspectos diferentes do Neovim, seu workspace, LSP e mais!
      --
      -- A maneira mais fácil de usar o Telescope é começar fazendo algo como:
      --  :Telescope help_tags
      --
      -- Após executar este comando, uma janela abrirá e você poderá digitar na
      -- janela de prompt. Você verá uma lista de opções de `help_tags` e uma
      -- pré-visualização correspondente da ajuda.
      --
      -- Dois keymaps importantes para usar enquanto estiver no Telescope são:
      --  - Insert mode: <C-/>
      --  - Normal mode: ?
      --
      -- Isso abre uma janela que mostra todos os keymaps para o picker atual do Telescope.
      -- Isso é muito útil para descobrir o que o Telescope pode fazer e como fazê-lo!

      -- [[ Configura o Telescope ]]
      -- Veja `:help telescope` e `:help telescope.setup()`
      require('telescope').setup {
        -- Você pode colocar seus mappings padrão / atualizações / etc. aqui
        -- Todas as informações estão em `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }

      -- Ativa extensões do Telescope se estiverem instaladas
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Veja `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'Search current Word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Search Commands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search Opened Buffers' })

      -- Isso é executado no LspAttach por buffer (veja a função principal de attach do LSP
      -- na config de 'neovim/nvim-lspconfig' para mais info).
      -- Isso permite alternar facilmente entre pickers se preferir usar outra coisa!
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf

          -- Encontra referências para a palavra sob o cursor.
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = 'Goto References' })

          -- Pula para a implementação da palavra sob o cursor.
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = 'Goto Implementation' })

          -- Pula para a definição da palavra sob o cursor.
          -- Para voltar, pressione <C-t>.
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = 'Goto Definition' })

          -- Busca via fuzzy find todos os símbolos no documento atual.
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

          -- Busca via fuzzy find todos os símbolos no seu workspace atual.
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

          -- Pula para a definição de tipo da palavra sob o cursor.
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = 'Goto Type Definition' })
        end,
      })

      -- Sobrescreve o comportamento padrão e tema ao pesquisar no buffer atual
      vim.keymap.set('n', '<leader>/', function()
        -- Você pode passar configurações adicionais ao Telescope para mudar o tema, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Search fuzzy find no buffer atual' })

      -- Também é possível passar opções de configuração adicionais.
      -- Veja `:help telescope.builtin.live_grep()` para informações sobre chaves específicas
      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep em Arquivos Abertos',
          }
        end,
        { desc = 'Search grep em Arquivos Abertos' }
      )

      -- Atalho para pesquisar seus arquivos de configuração do Neovim
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Search Neovim files' })
    end,
  },
}
