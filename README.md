# kickstart-certi-workshop

## Introdução

*Este é um fork do [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) que move de um único arquivo para uma configuração com múltiplos arquivos.*

Um ponto de partida pra aprender Neovim que é:

* Pequeno
* Simples de customizar
* Pronto pra uso
* Modular
* Documentado

**NÃO** é uma distro Neovim, mas sim um ponto de partida para sua configuração. 

## Instalação

### Instalar Neovim (Ubuntu)

```sh
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```

### Instalar Dependências

Requisitos:
- Utilitários básicos: `git`, `make`, `unzip`, C Compiler (`gcc`), `ripgrep`, `fd-find`
```sh
  sudo apt install git make unzip gcc ripgrep fd-find
```

- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation)
```sh
  npm install -g tree-sitter-cli
```

- Uma [Nerd Font](https://www.nerdfonts.com/): opcional, fornece diversos ícones
  - se você a tiver, defina `vim.g.have_nerd_font` em `init.lua` como **true**
  
- Fontes de Emoji (apenas Ubuntu, e somente se você quiser emoji) 
```sh
sudo apt install fonts-noto-color-emoji
```

- Configuração de Linguagem:
  - Se você quer codar em Typescript, precisa de `npm`...
  - Se você quer codar em Python, precisa de `pip`, `venv`...
  - Se você quer codar em C/C++, precisa de `clang`...
  - etc.

### Instalar o Kickstart CERTI

As configurações do Neovim estão localizadas nesses paths, dependendo do seu OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Clonar o repo

<details><summary> Linux e Mac </summary>

```sh
git clone https://github.com/sektant1/nvim-workshop.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

Caso use `cmd.exe`:

```
git clone https://github.com/sektant1/nvim-workshop.git "%localappdata%\nvim"
```

Caso use `powershell.exe`:

```
git clone https://github.com/sektant1/nvim-workshop.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post-Install

Abra o Neovim

```sh
nvim
```

E pronto, Lazy vai instalar todos os plugins que você colocou na `lua/custom/plugins` + os plugins padrão do kickstart em `lua/kickstart/plugins`. Use `:Lazy` pra ver os plugins instalados e gerenciar os mesmos. Use `q` pra fechar a janela do Lazy.
