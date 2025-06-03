## MTProto-Proxy Docker Installer

Simple one-shot script that installs Docker, Docker Compose and launches an
MTProto (non-TLS) proxy container.

## Usage

### On a fresh Ubuntu / Debian x86 VPS
```bash
curl -sSL https://raw.githubusercontent.com/hongson4477/mtproxy-docker/main/install-mtproxy.sh
```

The script will ask for:

- Public IP – press Enter to auto-detect

- Port – default 443

- Secret – press Enter to generate a random 16-byte hex string

When finished you will get a ready-to-share link like:

```
tg://proxy?server=<IP>&port=<PORT>&secret=dd<SECRET>
```

Updating or Removing

Stop and remove the container:

``` cd ~/telegram-proxy
sudo docker-compose down
```

Feel free to fork or open issues.
