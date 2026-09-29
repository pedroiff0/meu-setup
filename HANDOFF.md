# HANDOFF — Meu Setup (Dotfiles & Configs)

## 1. Contexto Rápido
- **Repositório:** `pedroiff0/meu-setup` (`~/Repositorios/pessoal/meu-setup`).
- **Função Principal:** Repositório declarativo de infraestrutura pessoal, dotfiles (Zsh, Bash, Tmux, Git, VSCode), lista de pacotes (`packages.yaml`) e scripts de provisionamento de novos computadores.
- **Sistemas Operacionais Suportados:** Ubuntu/Debian Linux, macOS (Homebrew), Windows 11 (PowerShell/Winget).

## 2. Estrutura de Diretórios
- `dotfiles/`: Arquivos de configuração reais ou templates com symlinks.
- `packages.yaml`: Catálogo central de pacotes CLI, GUI e extensões.
- `install.sh`: Script mestre de bootstrap.
- `linux/`, `macos/`, `windows/`: Scripts específicos por plataforma.

## 3. Estado Atual & Diretrizes Operacionais
- **Governança:** AGENTS.md, DESIGN.md, Makefile e templates do GitHub ativos.
- **Comandos Principais:**
  - `make help`: Exibe comandos disponíveis.
  - `make install`: Executa script de instalação local.
  - `make verify`: Valida sintaxe de scripts de shell e do arquivo `packages.yaml`.
  - `make lint`: Verifica conformidade sintática.
- **Próximos Passos:**
  - Integrar scripts com provisionamento automatizado de containers de desenvolvimento devcontainer.
