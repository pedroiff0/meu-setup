---
name: dotfiles-management
description: Diretrizes para inclusão de pacotes e gestão de symlinks no repositório Meu Setup.
---

# Dotfiles Management — Meu Setup

Instruções para alteração de configurações:

1. **Adição de Novo Pacote:**
   - Adicionar o pacote em `packages.yaml` sob a seção correspondente (`core`, `dev`, `gui`).
2. **Atualização de Dotfiles:**
   - Adicionar ou modificar o arquivo em `dotfiles/` e certificar-se de que o script de symlink aponta para `$HOME`.
