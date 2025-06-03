#!/bin/bash

# Ghi nội dung script con vào file
cat > install-mtproxy.sh <<'EOF'
#!/bin/bash

echo "=========================="
echo " MTProto Proxy Installer "
echo "=========================="

# Kiểm tra quyền root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Vui lòng chạy script với quyền root: sudo ./install-mtproxy.sh"
  exit
fi

# Nhập thông tin
read -p "🌐 Nhập IP public của VPS (Enter để lấy tự động): " IP
read -p "🔢 Nhập cổng bạn muốn dùng (ví dụ: 443): " PORT
read -p "🔐 Nhập SECRET (hoặc để trống để tạo ngẫu nhiên): " SECRET

if [ -z "$IP" ]; then
  IP=$(curl -s ifconfig.me)
  echo "🌐 IP tự động phát hiện: $IP"
fi

if [ -z "$SECRET" ]; then
  SECRET=$(openssl rand -hex 16)
  echo "🔐 SECRET đã tạo tự động: $SECRET"
fi

echo "🚀 Cài Docker..."
apt update -y && apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt update -y
apt install -y docker-ce docker-ce-cli containerd.io

echo "📦 Cài Docker Compose..."
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p ~/telegram-proxy
cd ~/telegram-proxy

cat > docker-compose.yml <<EOL
version: '3'
services:
  mtproto-proxy:
    image: telegrammessenger/proxy:latest
    container_name: mtproto-proxy
    ports:
      - "${PORT}:443"
    environment:
      - SECRET=${SECRET}
    restart: always
EOL

echo "⚙️ Khởi động MTProto Proxy..."
docker-compose up -d

echo "=============================="
echo "✅ MTProto Proxy đã sẵn sàng!"
echo "🌍 IP VPS: $IP"
echo "📡 Port: $PORT"
echo "🔐 Secret: $SECRET"
echo "🔗 Link Telegram:"
echo "tg://proxy?server=$IP&port=$PORT&secret=dd$SECRET"
echo "=============================="
EOF

# Cấp quyền và chạy
chmod +x install-mtproxy.sh
./install-mtproxy.sh
