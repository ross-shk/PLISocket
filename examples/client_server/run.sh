#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "=== Starting server ==="
./server_app &
SERVER_PID=$!

sleep 1

echo "=== Starting client ==="
./client_app

echo "=== Done ==="
kill $SERVER_PID 2>/dev/null || true
