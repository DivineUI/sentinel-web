# Operation Sentinel Web

A monitoring dashboard that collects system telemetry (timestamp, hostname,
uptime, load, memory, disk, and top processes) into a rotating log file and
serves it over nginx on a local web port.

## Architecture

monitor.sh -> systemd (sentinel.service) -> /var/log/sentinel/dashboard.txt
  -> docker bind mount (nginx:alpine) -> nginx -> localhost:8080

## Setup

1. Run `sudo bash deliverables/setup_all.sh` (creates the sentinel user, log
   directory, systemd service, monitor.sh, and the Docker container).

## Verification

- `curl -s http://localhost:8080/dashboard.txt` - a new timestamp appears every 5s.
- `systemctl status sentinel.service` - service active and enabled.

## Troubleshooting

- **systemd not running in WSL** - add `[boot] systemd=true` to /etc/wsl.conf
  and run `wsl --shutdown` from PowerShell.
- **403 on dashboard.txt** - ensure files under /var/log/sentinel are mode 644.
- **Port 8080 busy** - stop the conflicting container/service; do not change the
  published port without instruction.
