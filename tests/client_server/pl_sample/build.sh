#!/bin/bash
set -e
cd "$(dirname "$0")"

SRC=../../../source
INC="-i../../../include"
LIBS="-lprf"
LD_FLAGS="-m32 -no-pie -z muldefs -Wl,-M -Wl,--oformat=elf32-i386 -static-libgcc -nostartfiles -e main"

echo "=== Building C bridge ==="
gcc -m32 -c $SRC/web_socket_lib.c -o web_socket_lib.o

echo "=== Building server ==="
plic -C -dELF -ew -O server.pli $INC -o server.o

echo "=== Building client ==="
plic -C -dELF -ew -O client.pli $INC -o client.o

echo "=== Linking server ==="
gcc $LD_FLAGS -o server server.o web_socket_lib.o $LIBS > server.map

echo "=== Linking client ==="
gcc $LD_FLAGS -o client client.o web_socket_lib.o $LIBS > client.map

echo "Build complete. Run:"
echo "  ./run.sh"
