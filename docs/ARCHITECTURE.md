# 🏗️ Arquitetura do `meu-setup`

O **`meu-setup`** foi projetado com uma arquitetura **declarativa, modular, idempotente e multi-sistema** para prover configuração completa de estações de trabalho e servidores em **Linux, macOS e Windows**.

```
                           ┌────────────────────────┐
                           │     packages.yaml      │  (Fonte Única de Verdade)
                           └───────────┬────────────┘
                                       │
                ┌──────────────────────┼──────────────────────┐
                ▼                      ▼                      ▼
        ┌───────────────┐      ┌───────────────┐      ┌───────────────┐
        │ Linux / POSIX │      │  macOS / Brew │      │ Windows Winget│
        │  (apt/dnf/pac)│      │ (formulas/csk)│      │  (PowerShell) │
        └───────┬───────┘      └───────┬───────┘      └───────┬───────┘
                │                      │                      │
                └──────────────────────┼──────────────────────┘
                                       ▼
                     ┌──────────────────────────────────┐
                     │   tools/installer.py (TUI / CLI) │
                     └─────────────────┬────────────────┘
                                       │
          ┌────────────────────────────┼────────────────────────────┐
          ▼                            ▼                            ▼
  ┌───────────────┐            ┌───────────────┐            ┌───────────────┐
  │   🎨 Temas    │            │  ⚙️  Tweaks   │            │ 📦 Aplicações │
  │ (DevSpace,    │            │ (Energia 24/7,│            │  (99+ Apps,   │
  │  WhiteSur,    │            │  BBR, Sysctl, │            │  Packs, CLIs, │
  │  Firefox,Tmux)│            │  Docker Root) │            │  AI, LaTeX)   │
  └───────────────┘            └───────────────┘            └───────────────┘
```

---

## 💎 Princípios Fundamentais

### 1. Fonte Única da Verdade (`packages.yaml`)
Todos os mais de 99 softwares utilizados no dia a dia são mantidos no manifesto [`packages.yaml`](../packages.yaml). Cada item define:
- `name`: Identificador canônico.
- `desc`: Descrição concisa e amigável em português.
- `tags`: Categorização funcional (`base`, `dev`, `python`, `js`, `ia`, `infra`, `rede`, `sysadmin`, `latex`, `midia`, etc.).
- `linux`: Receitas nativas por gerenciador (`apt`, `dnf`, `pacman`, `zypper`), bem como `flatpak`, `snap`, repositórios PPA/GPG e scripts de bootstrap.
- `windows`: Identificador oficial do `winget` (Microsoft App Installer).
- `macos`: Nome de fórmula do `brew` ou aplicativo `cask`.

### 2. Idempotência Rigorosa
Nenhuma ação é reexecutada se já tiver sido aplicada:
- Gerenciadores nativos verificam com `dpkg-query`, `rpm -q`, `pacman -Qi`, `brew list` e `winget list`.
- Modificações em arquivos de configuração (`~/.bashrc`, `~/.zshrc`, `sysctl.d`) usam marcadores e guards para evitar duplicações.

### 3. Pipeline de Geração Automática (`tools/gen.py`)
Qualquer alteração em `packages.yaml` é propagada automaticamente através do script `tools/gen.py`:
- `windows/install.ps1`: Script PowerShell standalone usando `winget`.
- `macos/install.sh`: Script Bash standalone usando `Homebrew`.
- `INVENTARIO.md`: Tabela comparativa multiplataforma.
- `docs/PACKAGES_CATALOG.md`: Catálogo completo organizado por categorias.

---

## 📂 Estrutura de Diretórios

| Diretório / Arquivo | Descrição |
|---|---|
| [`install.sh`](../install.sh) | Ponto de entrada universal rápido (`curl \| bash`) com banner cósmico e re-attach de TTY. |
| [`packages.yaml`](../packages.yaml) | Manifesto central com 99+ ferramentas multi-sistema. |
| [`INVENTARIO.md`](../INVENTARIO.md) | Tabela comparativa multiplataforma gerada por `gen.py`. |
| `dotfiles/` | Arquivos brutos de configuração (DevSpace, Firefox, Tmux, Sysctl, Docker, Starship, Alacritty, Kitty). |
| `themes/` | Instaladores modulares de temas e estilização (DevSpace, WhiteSur, Firefox, Tmux, Wallpapers). |
| `configs/` | Receitas de otimização de sistema (Energia 24/7, Laptop Battery, TCP BBR, Docker storage, UFW). |
| `scripts/` | Utilitários standalone para execução pontual. |
| `linux/` | Bootstrap e instalador nativo para distribuições Linux. |
| `macos/` | Instalador Homebrew para macOS Darwin e perfis do iTerm2. |
| `windows/` | Instalador PowerShell e temas para Windows Terminal. |
| `tools/` | Motor TUI interativo (`installer.py`), gerador (`gen.py`) e suíte de testes (`verify.sh`). |
