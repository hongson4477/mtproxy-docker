# MTProto-Proxy Docker Installer

Simple one-shot script that installs Docker, Docker Compose and launches an
MTProto (non-TLS) proxy container.

## Usage

```bash
# on a fresh Ubuntu / Debian x86 VPS
curl -sSL https://raw.githubusercontent.com/hongson4477/mtproxy-docker/main/install-mtproxy.sh | bash
The script will ask for:

    Public IP – press Enter to auto-detect.

    Port – default 443.

    Secret – press Enter to generate a random 16-byte hex string.

When finished you will get a ready-to-share link like:

tg://proxy?server=<IP>&port=<PORT>&secret=dd<SECRET>
Updating or Removing

# stop and remove the container
cd ~/telegram-proxy
sudo docker-compose down

Feel free to fork or open issues.


---

## Commit & push

```bash
# from inside your local clone of the repo
git add install-mtproxy.sh README.md
git commit -m "Initial working installer: non-TLS (dd<secret>) output"
git push origin main   # or whichever branch you use

Now anyone can deploy the proxy with one single command:

curl -sSL https://raw.githubusercontent.com/hongson4477/mtproxy-docker/main/install-mtproxy.sh | bash

Let me know if you’d like extra features (multi-secrets, TAG support, ARM64 build, etc.)—I’m happy to extend the script.
