#!/bin/bash

set -e
INC="-i../../include"

echo "=== Building C bridge ==="
gcc -m32 -c ../../source/web_socket_lib.c -o web_socket_lib.o

echo "=== Compiling library packages ==="
plic -C -dELF -ew -O ../../source/socket.pli        $INC -o socket.o
plic -C -dELF -ew -O ../../source/server_socket.pli $INC -o server_socket.o

echo "=== Compiling programs ==="
plic -C -dELF -ew -O server_app.pli  $INC -o server_app.o
plic -C -dELF -ew -O client_app.pli  $INC -o client_app.o

LIBS="-lprf"
LD_FLAGS="-m32 -no-pie -z muldefs -Wl,-M -Wl,--oformat=elf32-i386 -static-libgcc -nostartfiles -e main"
OBJS="web_socket_lib.o socket.o server_socket.o"

echo "=== Linking server_app ==="
gcc $LD_FLAGS -o server_app server_app.o $OBJS $LIBS > server_app.map

echo "=== Linking client_app ==="
gcc $LD_FLAGS -o client_app client_app.o $OBJS $LIBS > client_app.map

echo ""
echo "Build complete. Run:"
echo "  ./run.sh"
