#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netinet/in.h>

int main() {
    int s = socket(AF_INET, SOCK_STREAM, 0);
    {struct sockaddr_in a;
    a.sin_family = AF_INET;
    a.sin_addr.s_addr = INADDR_ANY;
    a.sin_port = htons(8090);
    bind(s, (struct sockaddr *)&a, sizeof(a));}
    listen(s, 5);
    printf("Server on 8090\n");

    int cs = accept(s, 0, 0);
    char b[1024];
    read(cs, b, 1024);
    write(cs, b, strlen(b));
    close(cs);
    return 0;
}

