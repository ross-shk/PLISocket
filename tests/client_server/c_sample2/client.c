#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define PORT 8090
#define BUFFER_SIZE 4096

int main() {
    int sock_fd;
    struct sockaddr_in addr;
    char *message = "hello from c_sample2";
    char buffer[BUFFER_SIZE];
    ssize_t bytes;

    /* create socket */
    sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (sock_fd < 0) {
        perror("socket");
        return 1;
    }

    /* connect to server */
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(PORT);
    if (inet_pton(AF_INET, "127.0.0.1", &addr.sin_addr) <= 0) {
        perror("inet_pton");
        close(sock_fd);
        return 1;
    }

    if (connect(sock_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("connect");
        close(sock_fd);
        return 1;
    }

    printf("Connected to server\n");

    /* send message */
    bytes = write(sock_fd, message, strlen(message));
    if (bytes < 0) {
        perror("write");
        close(sock_fd);
        return 1;
    }

    printf("Sent: %s\n", message);

    /* read echo response */
    bytes = read(sock_fd, buffer, BUFFER_SIZE - 1);
    if (bytes < 0) {
        perror("read");
        close(sock_fd);
        return 1;
    }

    buffer[bytes] = '\0';
    printf("Received echo: %s\n", buffer);

    close(sock_fd);
    return 0;
}
