# meu-setup

Mapa de **todos os programas que eu uso** — Linux, Windows e macOS — com
instaladores automáticos. Uma única fonte de verdade: [`packages.yaml`](packages.yaml).

Depois de formatar a máquina, um comando repopula tudo.

---

## Linux — repopular depois de formatar

Um comando, do zero:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/pedroiff0/meu-setup/main/linux/bootstrap.sh)
```

O bootstrap instala git/python3/pyyaml, clona este repo em `~/meu-setup` e roda
um dry-run. Para instalar de verdade:

```bash
cd ~/meu-setup
python3 linux/install.py --dry-run     # ver o que faria (sempre faça isso antes)
python3 linux/install.py               # instalar tudo (pede confirmação)
python3 linux/install.py --yes         # sem confirmação
python3 linux/install.py --group dev --group ia
python3 linux/install.py --only docker,ollama
python3 linux/install.py --list        # listar pacotes e grupos
```

### O que o instalador faz

- **Detecta a distro** e escolhe o gerenciador: `apt`, `dnf`, `pacman` ou `zypper`.
- **É idempotente**: pula o que já está instalado (`dpkg-query`/`rpm -q`/`pacman -Qi`).
- **Cadeia de fallback**: pacote nativo → flatpak → snap → script oficial.
- **Adiciona repositórios** quando necessário (GitHub CLI, Chrome, Caddy).
- **Roda ações pós-instalação** (ex.: habilitar o docker e adicionar o usuário ao grupo).
- **Resumo final** com instalados / já presentes / falhas.

### Grupos disponíveis

`base` `dev` `python` `js` `infra` `rede` `sysadmin` `security` `ia` `gpu`
`driver` `navegador` `escritorio` `latex` `midia` `design` `pdf` `notas`
`produtividade` `desktop` `tema` `fontes` `compat` `cli` `web` `arquivos`
`linux-only`

---

## Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\install.ps1 -DryRun
powershell -ExecutionPolicy Bypass -File .\windows\install.ps1
```

Usa `winget` (App Installer da Microsoft Store). Pula o que já está instalado.

## macOS

```bash
DRY_RUN=1 ./macos/install.sh
./macos/install.sh
```

Instala o Homebrew se faltar, depois formulas e casks.

---

## Estrutura

```
packages.yaml        <- FONTE DE VERDADE: todos os programas
INVENTARIO.md        <- tabela gerada (Linux/Windows/macOS lado a lado)
linux/
  bootstrap.sh       <- entrada pós-formatação (curl | bash)
  install.py         <- instalador multi-distro
windows/
  install.ps1        <- GERADO por tools/gen.py (winget)
macos/
  install.sh         <- GERADO por tools/gen.py (brew)
tools/
  gen.py             <- regenera windows/, macos/ e INVENTARIO.md
```

## Adicionando um programa novo

1. Edite `packages.yaml`:

```yaml
  - name: meu-programa
    desc: Para que serve
    tags: [dev]
    linux: {apt: pacote-debian, dnf: pacote-fedora, pacman: pacote-arch}
    windows: Publisher.AppId          # id do winget
    macos: {brew: formula}            # ou {cask: nome}
```

Chaves aceitas em `linux`: `apt`, `dnf`, `pacman`, `zypper`, `flatpak`, `snap`
(+ `classic: true`), `script`, `repo` (por gerenciador) e `post`.

2. Regenere os artefatos:

```bash
python3 tools/gen.py
```

3. Valide e commit:

```bash
python3 linux/install.py --only meu-programa --dry-run
git add -A && git commit -m "add: meu-programa" && git push
```

---

## Aviso

Vários itens rodam `curl | sh` de fornecedores oficiais (Ollama, Tailscale,
Netdata, nvm). Sempre rode com `--dry-run` primeiro e leia o que vai executar.

## Verificação

```bash
bash tools/verify.sh   # 22 checagens: sintaxe, manifesto, geradores, flags do install.py, segredos
```
