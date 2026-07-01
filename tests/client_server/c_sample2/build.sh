#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "=== Building server ==="
gcc -o server server.c

echo "=== Building client ==="
gcc -o client client.c

echo "Build complete. Run:"
echo "  ./run.sh"
