#!/bin/bash
cd "$(dirname "$0")" || exit 1

PORT="${1:-8080}"

echo "正在启动局域网访问服务..."
echo "请保持这个窗口开启，然后在同一 Wi-Fi 下用其他设备访问："
echo "http://你的电脑局域网IP:${PORT}/"
echo

python3 -m http.server "$PORT" --bind 0.0.0.0
