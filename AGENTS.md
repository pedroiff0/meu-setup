# AGENTS.md — Meu Setup (Dotfiles & Workstation Configs)

> Diretrizes e regras operacionais para Agentes de IA no repositório `meu-setup`.

---

## 1. Visão Geral
- **Repositório:** `pedroiff0/meu-setup` (`~/Repositorios/pessoal/meu-setup`).
- **Propósito:** Configurações declarativas de ambiente de desenvolvimento, dotfiles, pacotes (`packages.yaml`), scripts de automação e temas para Linux, macOS e Windows.

---

## 2. Regras Operacionais para Agentes
1. **Idempotência de Scripts:**
   - Todo script de instalação em `scripts/`, `linux/`, `macos/` ou `windows/` deve ser idempotente (poder ser executado múltiplas vezes sem quebrar o sistema).
2. **Segurança:**
   - NUNCA commitar chaves SSH privadas, tokens de API ou credenciais de ferramentas nos dotfiles.
3. **CI/CD:**
   - Workflows rápidos de validação sintática de shell e YAML com timeout de 5 minutos (`timeout-minutes: 5`).
