-- [[ Legenda das Keymaps ]]
-- Como as teclas são representadas no vim
--
-- <C-x>     => Ctrl + x
-- <C-X>     => Ctrl + Shift + x (o neovim interpreta a maiúscula como shift)
-- <M-x>     => Alt + x (M = "Meta" = "Alt")
-- <S-x>     => Shift + x
-- <leader>  => Leader Key (setada no init.lua como <Space>)
-- <CR>      => Enter ("carriage return")
-- <Esc>     => Esc
-- <BS>      => Backspace
-- <Tab>     => Tab
-- <S-Tab>   => Shift + Tab
-- <Space>   => Espaço
-- <Up>,
-- <Down>,
-- <Left>,
-- <Right>   => Arrow keys

-- [[ Como criar Keymaps ]]
-- vim.keymap.set('Modo', 'Atalho', 'Acão', { desc = 'Descricão' })
-- Modos: 'n' (Normal), 'i' (Insert), 'v' (Visual), 't' (Terminal)

-- Limpa o highlight de busca quando Esc é apertado (Esc sai do modo de INSERT tambem)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- [[ Diagnósticos ]]
-- Configuracão dos diagnosticos de erro/quick fix, assim como no vscode
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' }, -- Configura o estilo da janela do diagnostico q aparece no cursor
  underline = { severity = { min = vim.diagnostic.severity.WARN } }, -- define o tipo de severidade no diagnostico para que apareca uma underline(_)

  -- Mostra o texto do erro/diagnostico no final da linha ou abaixo da linha virtualmente
  virtual_text = true, -- erro/warning/info/hint no final da linha (virtual)
  virtual_lines = false, -- erro/warning/info/hint abaixo da linha (virtual)

  -- Abre a janela de diagnostico automaticamente, assim navegar de erro em erro com '[d' ou ']d' (proximo/anterior) ja mostra o erro automaticamente
  jump = { float = true },
}

vim.keymap.set('n', '<C-q>', ':copen<CR>', { silent = true }) -- Abre a quickfix list padrão do neovim

vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostics on current word' })

-- Keybinds para facilitar salvar arquivos e sair/fechar neovim
-- :w = salva o arquivo atual
-- :q = fechar neovim
-- :q! = fechar neovim ignorando arquivos não salvos
-- :wq = salva arquivo e fecha o neovim
vim.keymap.set('n', '<leader>w', '<Cmd>update<CR>', { desc = 'Save file' })

vim.keymap.set('n', '<leader>q', '<Cmd>quit<CR>', { desc = 'Quit' })

-- Sai do TERMINAL MODE de maneira mais fácil
-- Por padrão, você normalmente usa <C-\><C-n>
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- DICA: Desabilita as arrow keys para aprender/acostumar a usar HJKL para movimentar
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds para deixar a navegacão de janelas mais simples
--  Use CTRL+<hjkl> pra mudar de janelas/splits
--
--  See `:help wincmd` pra ver todos os window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move o foco para a janela esquerda' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move o foco para a janela direita' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move o foco para a janela abaixo' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move o foco para a janela acima' })

-- Mover linhas selecionadas para cima/baixo (VISUAL Mode) estilo vscode: Alt + j/k
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'Move a seleção para cima' })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'Move a seleção para baixo' })

-- Mantem o cursor no meio da tela ao scrollar rápido com Ctrl + D/U
vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Pra baixo
vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Pra cima

-- Manter o cursor centralizado ao buscar termos (n = próximo, N = anterior)
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Indenta blocos no VISUAL mode sem perder a selecão
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Keybinds para melhorar o copy/delete
-- vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank' })
-- vim.keymap.set({ 'n', 'x' }, '<leader>D', '"+d', { desc = 'Delete' })
vim.keymap.set({ 'v', 'x', 'n' }, '<C-y>', '"+y', { desc = 'Yank' }) -- VISUAL Mode
vim.keymap.set('n', 'Y', 'y$', { desc = 'Yank do cursor até o final da linha' })
vim.keymap.set('n', 'D', 'd$', { desc = 'Delete do cursor até o final da linha' })

-- Melhora navegation quando no VISUAL mode
vim.keymap.set('v', 'H', '^', { desc = 'Comeco da linha' })
vim.keymap.set('v', 'L', '$', { desc = 'Final da linha' })

-- o - insere linha em branco na linha de baixo sem sair do NORMAL Mode e da linha atual
-- O - insere linha em branco na linha de cima sem sair do NORMAL Mode e da linha atual
vim.keymap.set('n', 'o', "<cmd>:call append(line('.'), '')<CR>")
vim.keymap.set('n', 'O', "<cmd>:call append(line('.')-1, '')<CR>")

-- tabs
vim.keymap.set({ 'n', 't' }, '<leader>n', '<Cmd>tabnew<CR>', { desc = 'New Tab' })
vim.keymap.set({ 'n', 't' }, '<leader>x', '<Cmd>tabclose<CR>', { desc = 'Close Tab' })
vim.keymap.set({ 'n', 't' }, '<leader><S-Tab>', '<Cmd>tabprevious<CR>', { desc = 'Previous Tab' })
vim.keymap.set({ 'n', 't' }, '<leader><Tab>', '<Cmd>tabnext<CR>', { desc = 'Next Tab' })

-- Mapeia do <leader>1 ao <leader>4 para navegar entre as Tabs abertas
-- (pode mudar o valor caso queira mais tabs) ('which_key_ignore' serve para que o atalho não apareca no menu da leader key)
for i = 1, 4 do
  vim.keymap.set({ 'n', 't' }, '<leader>' .. i, '<Cmd>tabnext ' .. i .. '<CR>', { desc = 'which_key_ignore' })
end

-- Abre o arquivo no File Explorer
vim.keymap.set('n', '<C-f>', '<Cmd>Open .<CR>', { desc = 'Open in OS Finder' })

-- [[ Auto comandos ]]
-- São comandos/funcoes que são executadas automanticamente quando X situacão acontece
--  See `:help lua-guide-autocommands`

-- Mostra o highlight quando você der yank (copiar) alguma coisa (char/palavra/linha/etc)
--  Teste `yap` no normal mode, (yap = [Y]ank [A]round [P]aragraph)
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- vim: ts=2 sts=2 sw=2 et
