-- debug.lua
--
-- Mostra como usar o plugin DAP para depurar seu código.
--
-- Focado primariamente na configuração do debugger para Go, mas pode
-- ser estendido para outras linguagens também. É por isso que se chama
-- kickstart.nvim e não kitchen-sink.nvim ;)

---@module 'lazy'
---@type LazySpec
return {
  -- NOTE: Sim, você pode instalar novos plugins aqui!
  'mfussenegger/nvim-dap',
  -- NOTE: E você também pode especificar dependências
  dependencies = {
    -- Cria uma UI pro debugger
    'rcarriga/nvim-dap-ui',

    -- Dependência obrigatória para o nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Instala os debug adapters para você via Mason
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Adicione seus próprios debuggers aqui (ex: nvim-dap-go para a linguagem Go)
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Atalhos básicos de debugging, sinta-se à vontade para mudar como preferir!
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Iniciar/Continuar' },
    { '<F11>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F10>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F12>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Alternar Breakpoint' },
    { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Condição do Breakpoint: ') end, desc = 'Debug: Definir Breakpoint Condicional' },
    -- Alterna para ver o resultado da última sessão. Sem isso, você não consegue ver o output em caso de exception não tratada.
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Ver resultado da última sessão.' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Tenta configurar automaticamente os diversos debuggers com
      -- configurações de debug padrão
      automatic_installation = true,

      -- Você pode fornecer configurações adicionais aos handlers,
      -- veja o README do mason-nvim-dap para mais informações
      handlers = {},

      -- Você precisará verificar online o que precisa ter instalado no sistema,
      ensure_installed = {
        -- Atualize isto para garantir que você tenha os debuggers para as linguagens que deseja
        'delve', -- Debugger para Go
      },
    }

    -- Configuração da UI do Dap
    -- Para mais informações, veja |:help nvim-dap-ui|
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      -- Define ícones para caracteres que têm mais chance de funcionar em qualquer terminal.
      -- Sinta-se à vontade para remover ou usar os que você mais gostar! :)
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Configuração para abrir/fechar a UI automaticamente ao iniciar/parar o debug
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Instala configuração específica para golang
    require('dap-go').setup {
      delve = {
        -- No Windows, o delve deve ser executado em modo "attached" ou ele trava.
        -- Veja https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
