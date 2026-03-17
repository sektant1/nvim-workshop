-- Seta a tecla <space> como leader key
-- See `:help mapleader`
--  NOTE: Deve ser definida antes de carregar plugins (no contrário, será carregada uma tecla diferente/errada)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Caso você tenha uma nerd font instalada no terminal, pode setar como true
vim.g.have_nerd_font = false

-- [[ Opcões ]]
require 'options'

-- [[ Keymaps ]]
require 'keymaps'

-- [[ Carrega o gerenciador de plugins 'Lazy' ]]
require 'lazy-bootstrap'

-- [[ Carrega e instala os plugins em sí ]]
require 'lazy-plugins'

-- vim: ts=2 sts=2 sw=2 et
