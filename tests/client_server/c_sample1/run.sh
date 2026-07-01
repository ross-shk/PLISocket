#!/bin/bash
cd "$(dirname "$0")"
./server &
sleep 3
./client
# kill $!
