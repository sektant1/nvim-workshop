# kickstart-modular.nvim

## Introdução

*Este é um fork de [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) que move de um único arquivo para uma configuração com múltiplos arquivos.*

Um ponto de partida para aprender Neovim que é:

* Pequeno o suficiente pra tu deixar do jeito que quer
* Modular
* Completamente Documentado

**NÃO** é uma distribuição Neovim, mas sim um ponto de partida para sua configuração. 

## Instalação

### Instalar Neovim (Ubuntu)

```sh
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```

### Instalar Dependências Externas

Requisitos Externos:
- Utilitários básicos: `git`, `make`, `unzip`, C Compiler (`gcc`), `ripgrep`, `fd-find`
```sh
  sudo apt install git make unzip gcc ripgrep fd-find`
```

- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation)
```sh
  npm install -g tree-sitter-cli`
```

- Uma [Nerd Font](https://www.nerdfonts.com/): opcional, fornece diversos ícones
  - se você a tiver, defina `vim.g.have_nerd_font` em `init.lua` como **true**
- Fontes de Emoji (apenas Ubuntu, e somente se você quiser emoji!) 
```sh
sudo apt install fonts-noto-color-emoji`
```

- Configuração de Linguagem:
  - Se você quer escrever em Typescript, você precisa de `npm`
  - Se você quer escrever em Golang, você precisará de `go`
  - etc.

> [!NOTE]
> Veja [Install Recipes](#Install-Recipes) para notas adicionais específicas do Windows e Linux
> e snippets de instalação rápida

### Instalar Kickstart

> [!NOTE]
> [Faça backup](#FAQ) da sua configuração anterior (se houver)

As configurações do Neovim estão localizadas nos seguintes caminhos, dependendo do seu OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Clonar kickstart.nvim

<details><summary> Linux e Mac </summary>

```sh
git clone https://github.com/sektant1/nvim-workshop.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```
