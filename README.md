# a2cloud-minecraft-docker

A production-ready **Paper Minecraft server** on Docker: sane memory limits, healthchecks, automatic restarts and one-command setup. Built for A2Cloud VPS but works on any Docker-capable Linux host.

## What you get

- Paper (Java 21) in a pinned, reproducible image
- `docker-compose.yml` with named volumes — your world survives container rebuilds
- Healthcheck that reports the server as unhealthy instead of silently dying
- `restart: unless-stopped` + `stop_grace_period` so the world saves cleanly
- `scripts/start.sh` with Aikar-style JVM flags to cut lag spikes
- Full firewall notes for UFW and hardware firewalls

## Quick start

```bash
git clone https://github.com/ayushrajdev9-cmyk/a2cloud-minecraft-docker.git
cd a2cloud-minecraft-docker
cp .env.example .env      # set EULA=true, MEMORY=6G, SERVER_NAME
docker compose up -d
docker compose logs -f    # watch it boot
```

Connect to `YOUR_IP:25565`. That's it.

## Memory sizing

| Plan RAM | Heap (`MEMORY`) | Players (Paper) |
|----------|-----------------|-----------------|
| 2 GB     | 1.5G            | 5–10            |
| 4 GB     | 3G              | 15–30           |
| 8 GB     | 6G              | 30–60           |
| 16 GB    | 12G             | 60–100          |

Never give the heap more than ~80% of the host RAM — the OS and world files need the rest.

## Firewall

```bash
ufw allow 25565/tcp
ufw allow 25565/udp
```

If your host has a hardware firewall (every A2Cloud server does, with edge DDoS protection included), allow the port there too.

## Docs

- Full setup guide: [How to Deploy a Minecraft Server on Ubuntu](https://a2cloud.qzz.io/blog/deploy-minecraft-server-ubuntu)
- A2Cloud Minecraft hosting: https://a2cloud.qzz.io/pricing
- A2Cloud documentation: https://a2cloud.qzz.io/docs

MIT licensed. Contributions welcome — open an issue or PR.
