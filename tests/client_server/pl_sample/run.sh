#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "=== Starting server ==="
./server &
SERVER_PID=$!

sleep 1

echo "=== Starting client ==="
./client

echo "=== Done ==="
kill $SERVER_PID 2>/dev/null || true
