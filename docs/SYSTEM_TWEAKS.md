# ⚙️ Guia de Otimizações de Sistema, Energia & Kernel

O **`meu-setup`** inclui um conjunto completo de configurações comprovadas para servidores 24/7 e estações de desenvolvimento de alta performance.

---

## ⚡ 1. Modo Servidor 24/7 (Anti-Sleep & No-Suspend)

Em máquinas dedicadas a rodar containers, servidores web e modelos de IA locais, qualquer suspensão acidental interrompe fluxos de trabalho.

### O que é configurado:
1. **Systemd Target Masking**:
   - `sleep.target`, `suspend.target`, `hibernate.target` e `hybrid-sleep.target` são mascarados (`systemctl mask`), impedindo qualquer transição para estados de baixo consumo.
2. **GNOME Power Settings**:
   - `sleep-inactive-ac-type = 'nothing'`
   - `sleep-inactive-ac-timeout = 0`
3. **Logind Lid Switch**:
   - Cria `/etc/systemd/logind.conf.d/24-7-server.conf` para ignorar o fechamento da tampa do notebook (`HandleLidSwitch=ignore`).

### Como Aplicar:
```bash
bash configs/power/server-24-7.sh
```

---

## 🌐 2. TCP BBR v2 + Fair Queuing (FQ)

O algoritmo de controle de congestionamento **BBR (Bottleneck Bandwidth and RTT)** desenvolvido pelo Google maximiza a vazão e reduz a latência através de gargalos de rede.

### Parâmetros Aplicados em `/etc/sysctl.d/99-bbr.conf`:
```ini
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr
```

### Como Validar:
```bash
sysctl net.ipv4.tcp_congestion_control
# Retorno esperado: net.ipv4.tcp_congestion_control = bbr
```

---

## ⚙️ 3. Sysctl Tuning Avançado

Otimizações cruciais para desenvolvedores com múltiplas compilações, watchers e containers em execução.

### Principais Chaves em `/etc/sysctl.d/99-sysctl-tuning.conf`:
- `fs.inotify.max_user_watches = 524288`: Evita o erro `"ENOSPC: System limit for number of file watchers reached"` em projetos Node.js, Vite e IDEs.
- `fs.file-max = 2097152`: Limite amplo de descritores de arquivos abertos.
- `vm.swappiness = 10`: Prefere manter dados na memória RAM antes de fazer swap no disco.
- `vm.vfs_cache_pressure = 50`: Mantém caches de arquivos e diretórios em memória para leituras instantâneas no Git.

---

## 🐳 4. Armazenamento do Docker (Data-Root & Logs)

Evita o esgotamento da partição raiz (`/`) redirecionando o armazenamento do Docker para partições maiores (`/home/docker-data`) e limitando o tamanho dos logs dos contêineres.

### Configuração em `/etc/docker/daemon.json`:
```json
{
  "data-root": "/home/docker-data",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "50m",
    "max-file": "3"
  },
  "live-restore": true
}
```

---

## 🛡️ 5. AdGuard Home (DNS Sinkhole em Docker)

Bloqueio centralizado de anúncios, rastreadores e telemetria na camada de rede:
- Porta 53 (DNS TCP/UDP)
- Interface de gerenciamento web: `http://localhost:8085` (ou `http://localhost:3000` na primeira execução).

### Como Iniciar:
```bash
bash configs/network/setup-adguard.sh
```

---

## 💾 6. SSD TRIM Automático (`fstrim.timer`)

Mantém a performance de escrita e a vida útil de unidades de estado sólido (NVMe/SATA SSD):
```bash
bash configs/storage/setup-fstrim.sh
```
