#!/usr/bin/env bash
# Start the sentinel-web container (Phase 2)
# Bind-mounts /var/log/sentinel (nginx-served dashboard) at /usr/share/nginx/html:ro
docker run -d --name sentinel-web --restart unless-stopped -p 8080:80 -v /var/log/sentinel:/usr/share/nginx/html:ro sentinel-web
