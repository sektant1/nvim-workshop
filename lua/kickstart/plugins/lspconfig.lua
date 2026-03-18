-- Plugins de LSP
---@module 'lazy'
---@type LazySpec
return {
  {
    -- Configuração Principal do LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Instala automaticamente LSPs e ferramentas relacionadas no stdpath do Neovim
      -- O Mason deve ser carregado antes dos seus dependentes, por isso o configuramos aqui.
      -- NOTE: `opts = {}` é o mesmo que chamar `require('mason').setup({})`
      {
        'mason-org/mason.nvim',
        ---@module 'mason.settings'
        ---@type MasonSettings
        ---@diagnostic disable-next-line: missing-fields
        opts = {},
      },
      -- Faz o mapeamento dos nomes de servidores LSP entre nvim-lspconfig e Mason.
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Atualizações de status úteis para o LSP (canto inferior da tela).
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- NOTE: **O que é LSP?**
      --
      -- LSP é a sigla para Language Server Protocol. É um protocolo que ajuda editores
      -- e ferramentas de linguagem a comunicarem de forma padronizada.
      --
      -- Em geral, você tem um "servidor" (server) que é uma ferramenta feita para entender uma
      -- linguagem específica (como `gopls`, `lua_ls`, `rust_analyzer`, etc.). Estes Language Servers
      -- são processos independentes que comunicam com um "cliente" - neste caso, o Neovim!
      --
      -- O LSP fornece ao Neovim funcionalidades como:
      --  - Go to definition (Ir para a definição)
      --  - Find references (Encontrar referências)
      --  - Autocompletion (Autocompletar)
      --  - Symbol Search (Busca de símbolos)
      --  - e muito mais!
      --
      -- Assim, os Language Servers são ferramentas externas que devem ser instaladas separadamente do
      -- Neovim. É aqui que o `mason` e plugins relacionados entram em cena.

      -- Esta função é executada quando um LSP se conecta (attach) a um buffer específico.
      -- Ou seja, toda vez que um novo arquivo é aberto e associado a um LSP (ex: abrir `main.rs`
      -- associado ao `rust_analyzer`), esta função será executada para configurar o buffer atual.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Lembre-se que Lua é uma linguagem de programação real, e por isso é possível
          -- definir pequenas funções utilitárias para não precisar se repetir.
          --
          -- Neste caso, criamos uma função que facilita a definição de mappings específicos do LSP.
          -- Ela define o modo, o buffer e a descrição para nós automaticamente.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Renomear a variável sob o cursor (Rename).
          -- A maioria dos servidores LSP suporta renomeação em múltiplos arquivos, etc.
          map('grn', vim.lsp.buf.rename, 'Rename')

          -- Executa uma Code Action (Ação de Código), geralmente o cursor precisa estar sobre
          -- um erro ou uma sugestão do LSP para que isso seja ativado.
          map('gra', vim.lsp.buf.code_action, 'Goto Code Action', { 'n', 'x' })

          -- AVISO: Isto não é Goto Definition, isto é Goto Declaration.
          -- Por exemplo, em C, isso levaria você para o arquivo de header (.h).
          map('grD', vim.lsp.buf.declaration, 'Goto Declaration')

          -- Os dois autocomandos seguintes são usados para destacar (highlight) referências da
          -- palavra sob o seu cursor quando ele para por um curto período.
          -- Veja `:help CursorHold` para informações sobre quando isto é executado.
          -- Quando você move o cursor, os destaques serão limpos (segundo autocomando).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            -- Limpa os destaques quando o LSP se desconecta (detach)
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- O código seguinte cria um atalho para alternar Inlay Hints (Dicas em linha)
          -- no seu código, se o servidor de linguagem que você está usando as suportar.
          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, 'Toggle Inlay Hints')
          end

          vim.keymap.set('n', '<leader>tl', function()
            local new_config = not vim.diagnostic.config().virtual_lines
            vim.diagnostic.config { virtual_lines = new_config }
          end, { desc = 'Toggle Diagnostic Virtual Lines' })

          vim.keymap.set('n', '<leader>tt', function()
            local cfg = vim.diagnostic.config()
            vim.diagnostic.config { virtual_text = not cfg.virtual_text }
          end, { desc = 'Toggle Diagnostic Virtual Text' })
        end,
      })

      -- Ative os seguintes servidores de linguagem (LSPs)
      -- Sinta-se à vontade para adicionar/remover LSPs aqui. Eles serão instalados automaticamente.
      -- Veja `:help lsp-config` para informações sobre chaves e como configurar.
      ---@type table
      local servers = {
        -- clangd = {},
        -- gopls = {},
        pyright = {},
        basedpyright = {},
        ruff = {},
        vtsls = {},
        html = {},
        cssls = {},
        jsonls = {},
        ts_ls = {},
        marksman = {},
        -- rust_analyzer = {},

        stylua = {}, -- Usado para formatar código Lua

        -- Configuração especial do Lua LSP, conforme recomendado pela documentação do Neovim
        lua_ls = {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
              },
              workspace = {
                checkThirdParty = false,
                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                  '${3rd}/luv/library',
                  '${3rd}/busted/library',
                }),
              },
            })
          end,
          settings = {
            Lua = {},
          },
        },
      }

      -- Garante que os servidores e ferramentas acima sejam instalados via Mason
      -- Para checar o status atual ou instalar manualmente, execute:
      --    :Mason
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Você pode adicionar outras ferramentas aqui (formatadores, linters, etc)
        'pyright',
        'basedpyright',
        'ruff',
        'ts_ls',
        'eslint_d',
        'pylint',
        'debugpy',
        'lua_ls',
        'marksman',
        'markdown-toc',
        'prettier',
        'prettierd',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Configura e habilita os servidores
      for name, server in pairs(servers) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
