# DESIGN — Meu Setup Architecture & Design Rules

## 1. Arquitetura de Provisionamento

```mermaid
graph TD
    Entry["install.sh (Ponto de Entrada)"] --> Detect["Detecção de OS (Linux / Darwin / Win)"]
    Detect --> PkgManager["Leitura de packages.yaml"]
    PkgManager --> Linux["linux/install.sh (Apt + Flatpak)"]
    PkgManager --> Mac["macos/install.sh (Homebrew)"]
    PkgManager --> Win["windows/install.ps1 (Winget)"]
    Linux --> Links["Criação de Symlinks (dotfiles/ -> $HOME)"]
    Mac --> Links
    Win --> Links
```

---

## 2. Princípios de Design

1. **Declaratividade:**
   - Softwares e extensões devem ser listados em `packages.yaml` antes de serem instalados manualmente.
2. **Não Destrutividade:**
   - Caso um dotfile já exista no destino, deve ser realizado backup automático (`.bak`) antes da substituição por symlink.
