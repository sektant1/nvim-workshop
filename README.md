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

E pronto, Lazy vai instalar todos os plugins que você colocou na `lua/custom/plugins/*.lua` + plugins padrão do kickstart de `lua/kickstart/plugins/*.lua`. Use `:Lazy` pra ver os plugins instalados e gerenciar os mesmos. Use `q` pra fechar a janela do Lazy.

## Como Instalar plugins
### **Passo 1**: Acesse a pasta correta

Navegue até o diretório de configurações do seu Neovim. Dependendo do seu sistema operacional, o caminho geralmente é:

  - Linux/macOS: `~/.config/nvim/lua/custom/plugins/`

  - Windows: `~/AppData/Local/nvim/lua/custom/plugins/`

Nota: Se a pasta `lua/custom/plugins/` não existir, você pode criá-la manualmente. Veja se o seu arquivo `/lua/lazy-plugins.lua` tenha a linha `require('lazy').setup({ ..., { import = 'custom.plugins' } })` (no kickstart.nvim ela vem comentada por padrão, mas no nosso caso eu ja deixei ela descomentada).

### **Passo 2**: Crie o arquivo do plugin

Dentro da pasta `lua/plugins/`, crie um arquivo com a extensão `.lua`. O nome do arquivo pode ser o que você quiser, geralmente o nome do plugin/uso.

Vamos usar o plugin `nvim-autopairs` (que fecha parênteses e aspas automaticamente) como exemplo. Crie um arquivo chamado `autopairs.lua`:

```sh
touch ~/.config/nvim/lua/custom/plugins/autopairs.lua
```
### **Passo 3**: Escreva a configuração

Abra o arquivo recém-criado, o arquivo deve sempre dar `return {...}` de uma table (lista) com as informações do plugin.

Coloque isso dentro da `autopairs.lua`:

```lua
return {
  -- 1. O link do repositório no GitHub (usuário/nome-do-repositório)
  "windwp/nvim-autopairs",
  
  -- 2. (Opcional) Evento que faz o plugin carregar. 
  -- "InsertEnter" significa que ele só carrega quando você começa a digitar.
  event = "InsertEnter",
  
  -- 3. (Opcional) A função de configuração. Aqui você coloca os atalhos e opções do plugin.
  config = function()
    require("nvim-autopairs").setup({
      -- Adicione opções específicas do plugin aqui
    })
  end,
}
```

### **Passo 4**: Reinicie o Neovim

Depois de salvar o arquivo `autopairs.lua`:

  - Feche o Neovim e abra-o novamente.

  - O `lazy.nvim` vai detectar automaticamente o novo arquivo, baixar o plugin e instalar (em UNIX, os plugins ficam instalados em `~/.local/share/nvim/...`).

  - Você pode digitar `:Lazy` no modo normal para abrir o painel do lazy e ver se o plugin está na lista de instalados.
