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
  {
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
      'mfussenegger/nvim-dap-python',
    },
    keys = {
      -- Basic debugging keymaps, feel free to change to your liking!
      {
        '<leader>bc',
        function() require('dap').continue() end,
        desc = 'Debug: Start/Continue',
      },
      {
        '<leader>bi',
        function() require('dap').step_into() end,
        desc = 'Debug: Step Into',
      },
      {
        '<leader>bO',
        function() require('dap').step_over() end,
        desc = 'Debug: Step Over',
      },
      {
        '<leader>bo',
        function() require('dap').step_out() end,
        desc = 'Debug: Step Out',
      },
      {
        '<leader>bb',
        function() require('dap').toggle_breakpoint() end,
        desc = 'Debug: Toggle Breakpoint',
      },
      {
        '<leader>bB',
        function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {
        '<leader>br',
        function() require('dapui').toggle() end,
        desc = 'Debug: See last session result.',
      },
      {
        '<leader>bpt',
        function() require('dap-python').test_method() end,
        desc = 'Debug Method',
        ft = 'python',
      },
      {
        '<leader>bpc',
        function() require('dap-python').test_class() end,
        desc = 'Debug Class',
        ft = 'python',
      },
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
          'debugpy', -- Debugger para Python
          'js-debug-adapter', -- Debugger para TS/JS
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

      -- Instala as configs do python
      require('dap-python').setup 'debugpy-adapter'
      -- Instala configuração específica para golang
      require('dap-go').setup {
        delve = {
          -- No Windows, o delve deve ser executado em modo "attached" ou ele trava.
          -- Veja https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          detached = vim.fn.has 'win32' == 0,
        },
      }
    end,
  },

  -- Instala o plugin de selecionar a venv para python
  {
    'linux-cultist/venv-selector.nvim',
    cmd = 'VenvSelect',
    opts = {
      options = {
        notify_user_on_venv_activation = true,
        override_notify = false,
      },
    },
    --  Call config for Python files and load the cached venv automatically
    ft = 'python',
    keys = { { '<leader>bpv', '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' } },
  },
}
