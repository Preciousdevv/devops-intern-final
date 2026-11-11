
#!/usr/bin/env bash
set -euo pipefail

echo "=================================="
echo "       SYSTEM INFORMATION"
echo "=================================="

echo "Current User: $(id -un)"
echo "Effective UID: $(id -u)"
echo "Hostname: $(hostname)"
echo "Kernel Release: $(uname -r)"
echo "System Date: $(date -Iseconds)"

echo ""
echo "========== DISK USAGE =========="
df -h

echo ""
echo "========== MEMORY USAGE =========="
if command -v free >/dev/null 2>&1; then
    free -h
elif [[ -r /proc/meminfo ]]; then
    cat /proc/meminfo
else
    echo "Memory information is unavailable."
fi

echo ""
echo "========== DOCKER STATUS =========="
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker: Not installed"
elif docker info >/dev/null 2>&1; then
    echo "Docker daemon: Running"
else
    echo "Docker daemon: Not running"
fi

echo ""
echo "System information collection completed."
