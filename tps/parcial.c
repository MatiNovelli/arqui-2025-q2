#include <stdio.h>
#include <unistd.h>

void print_message() {
    char buffer[16];
    printf("Ingrese su nombre: ");
    gets(buffer);
    printf("Hola %s\n", buffer);
}

int run_shell() {
    printf("Sos un hacker\n");
}

int main() {
    print_message();
    return 0;
}
