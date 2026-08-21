# 🎨 Guia de Temas & Estilização Multi-Sistema

O ecossistema visual do **`meu-setup`** é centralizado na identidade **DevSpace Cósmico (Astronomia & Dev)** combinada com suporte a temas modernos de desktop como o **WhiteSur (macOS look)**.

---

## 🌌 1. Terminal Cósmico DevSpace

### Paleta de Cores
A paleta foi desenhada para oferecer máximo contraste (WCAG AA) e harmonia visual:
- **Roxo Principal**: `#d384d3` / `#a855f7` (Inspiração cósmica / Solo Leveling Shadow Monarch)
- **Magenta**: `#d384d8`
- **Ciano Hacker**: `#75c8d3`
- **Verde Aurora**: `#9ed788`
- **Amarelo Crema**: `#fdbb68`
- **Fundo Escuro**: `#120d22` / `#1e2028`
- **Texto Principal**: `#f1f5f9` / `#d3c8d3`

### Componentes Ativos
1. **Prompt Dinâmico Planck**:
   - Ícone de café ☕ com nome de usuário em magenta.
   - Caminho do diretório atual em ciano.
   - Ramo e status do Git (`🌿 main ✚`) em verde e rosa.
   - Relógio em tempo real em amarelo (`[14:30:15]`).
   - Seta `❯` (roxa para sucesso, vermelha com exit-code para erros).
2. **Statusline do Antigravity CLI**:
   - Telemetria de contexto e tokens integrada.
3. **Aliasing Moderno**:
   - `lg` ➔ `lazygit`
   - `ld` ➔ `lazydocker`
   - `ls` ➔ `eza --icons`
   - `ll` ➔ `eza -la --icons --git`
   - `cat` ➔ `bat -p`
   - `du` ➔ `duf`
   - `fetch` ➔ `fastfetch`

### Como Aplicar
```bash
# Via instalador interativo
./install.sh --themes

# Ou diretamente pelo script
bash themes/devspace/install-devspace.sh
```

---

## 🍎 2. WhiteSur macOS Look (Desktop Linux)

O tema WhiteSur traz o refinamento visual do macOS Big Sur / Sonoma para ambientes Linux (GNOME, XFCE e KDE Plasma 6):
- **GTK Theme**: Variante Dark Purple com botões arredondados no estilo traffic lights (`close,minimize,maximize:`).
- **Ícones**: WhiteSur-Dark Icons com cobertura completa de aplicativos modernos.
- **Cursores**: WhiteSur-cursors suaves e de alta precisão.
- **Dock**: Configuração automática para o Plank dock com transparência e zoom.

### Como Aplicar
```bash
bash themes/whitesur/install-whitesur.sh
```

---

## 🦊 3. Firefox DevSpace Cósmico

Customização profunda do Mozilla Firefox via `userChrome.css`, `userContent.css` e `user.js`:
- Abas compactas com cantos arredondados e gradiente cósmico.
- Barra de abas posicionada de forma fluida sem desperdício de espaço vertical.
- Cores de seleção e destaques alinhados com o DevSpace.

### Como Aplicar
```bash
bash themes/firefox/install-firefox-theme.sh
```

---

## 📟 4. Tmux Cósmico & Persistência

Configuração ultra-estável do Tmux (`.tmux.conf`):
- **Barra de Status Inferior**: Status bar em dark roxo com frases inspiradoras de código/filosofia e data completa em português com separador de bolinha roxa (`●`).
- **Anti-Ghosting Automático**: Script `redraw-pane.sh` que redimensiona sutilmente a janela para forçar redraw limpo em apps Ink/React (como Claude Code, Hermes e Antigravity).
- **Higiene do Resurrect**: Script `resurrect-hygiene.sh` que limpa saves vazios de 0 bytes para evitar falhas de restauração.
- **Atalhos Rápidos**: `Prefix + R` para redraw forçado, `Prefix + k` para limpeza total de scrollback.

### Como Aplicar
```bash
bash themes/tmux/install-tmux-theme.sh
```
