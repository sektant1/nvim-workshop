-- NOTE: Plugins também podem configurar o Autoformat.
-- O Conform permite configurar formatters externos (como stylua, prettier, etc.)
-- de maneira fácil e com suporte a salvamento automático.

---@module 'lazy'
---@type LazySpec
return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' }, -- Executa antes de salvar o arquivo
    cmd = { 'ConformInfo' }, -- Comando para verificar o status dos formatadores
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = 'Format file',
      },
    },
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Desativa o "format_on_save lsp_fallback" para linguagens que não
        -- possuem um estilo de codificação bem padronizado. Você pode adicionar
        -- outras linguagens aqui ou reativar para as que estão desativadas.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- O Conform também pode executar vários formatadores sequencialmente
        -- Adiciona JS/TS:
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        -- Adiciona Python:
        python = { 'isort', 'black' },
        -- Você pode usar 'stop_after_first' para executar o primeiro formatador disponível da lista
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
