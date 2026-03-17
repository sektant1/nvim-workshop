-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Mostra o número da linha
vim.o.number = true

-- Também existe a opcão de `relative line number`, que ajuda em comandos onde é preciso saltar X numero de linhas.
-- vim.o.relativenumber = true

-- Habilita o mouse dentro neovim, util para ajustar os splits e interagir com a UI
vim.o.mouse = 'a'

-- Isso esconde o `--INSERT--` quando entramos no INSERT mode,
-- como a nossa configuracao ja adiciona na STATUS BAR o modo que estamos, faz sentido desligarmos essa opt
vim.o.showmode = false

-- Sincroniza a clipboard do OS com a do NEOVIM
--  No neovim por padrão o buffer do clipboard é separado entre OS/NEOVIM,
--  e pra que fique mais fácil agora de comeco, deixamos ambas no mesmo BUFFER
--  ex: no neovim, quando deletamos alguma linha/palavra/character, ela vai pro buffer da clipboard, então se usarmos a keybind 'p'(de 'paste') no modo NORMAL,
--    a ultima coisa que deletamos, ou como nesse caso, copiamos fora ou dentro do vim, ira ser colada(paste) no local do cursor.
--  `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Mantem a indentacão quando quebramos uma linha
vim.o.breakindent = true

-- Mantém o histórico de 'Desfazer' (Undo) mesmo após fechar e reabrir o neovim
-- u = undo (desfazer)
-- <C-r> = redo (refazer)
vim.o.undofile = true

-- Desabilita o arquivo temporario
vim.o.swapfile = false

-- Pesquisa insensível a maiusc/minusc, porem se na buscar tiver maiusc: ignore case = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- Mostra a coluna de sinais(erros, warnings, git signs etc) sempre que possivel
vim.o.signcolumn = 'yes'

-- Diminui tempo de atualizacao do neovim, melhora a quality of life em geral
vim.o.updatetime = 250

-- Diiminui o tempo de espera pras keybinds
vim.o.timeoutlen = 300

-- Define como que os splits irão abrir, direita depois abaixo
vim.o.splitright = true
vim.o.splitbelow = true

-- Mostra caracteres invisíveis (tabs e spaces)
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview dos comandos enquanto escreve
vim.o.inccommand = 'split'

-- Mostra em qual linha o cursor está
vim.o.cursorline = true

-- Número mínimo de linhas abaixo do cursor para o scroll da tela ser ativado
vim.o.scrolloff = 10

-- Confirmacão ao tentar sair sem salvar (:w ou <leader>w) o arquivo atual
vim.o.confirm = true

-- vim: ts=2 sts=2 sw=2 et
