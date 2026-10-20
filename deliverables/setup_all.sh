#!/usr/bin/env bash
# setup_all.sh
# Reproduces Phases 1 & 2 of Operation Sentinel Web (system config + Docker).
# Run as root:  sudo bash setup_all.sh
set -euo pipefail

LOG_DIR=/var/log/sentinel
DASHBOARD=${LOG_DIR}/dashboard.txt

# --- Phase 1: System configuration ---
echo "== Phase 1: System configuration =="
groupadd --system sentinel 2>/dev/null || true
useradd --system --gid sentinel --shell /usr/sbin/nologin --no-create-home sentinel 2>/dev/null || true
mkdir -p ${LOG_DIR}
chown sentinel:sentinel ${LOG_DIR}
chmod 755 ${LOG_DIR}

# install monitor.sh and systemd unit
cp /home/ingab/sentinel-web/monitor.sh /usr/local/bin/monitor.sh
chown root:root /usr/local/bin/monitor.sh
chmod 755 /usr/local/bin/monitor.sh
cat > /etc/systemd/system/sentinel.service <<EOF
[Unit]
Description=Operation Sentinel dashboard monitor
After=network.target

[Service]
Type=simple
User=sentinel
Group=sentinel
ExecStart=/usr/local/bin/monitor.sh
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable --now sentinel.service
echo "sentinel.service: $(systemctl is-active sentinel.service) (enabled: $(systemctl is-enabled sentinel.service))"

# --- Phase 2: Docker ---
echo "== Phase 2: Docker =="
docker build -t sentinel-web /home/ingab/sentinel-web >/dev/null
docker run -d --name sentinel-web --restart unless-stopped -p 8080:80 -v /var/log/sentinel:/usr/share/nginx/html:ro sentinel-web
echo "container: $(docker ps -q --filter name=sentinel-web)"
echo "curl test: $(curl -s -o /dev/null -w '%{http_code}' http://localhost:8080/dashboard.txt)"
echo "Setup complete."
