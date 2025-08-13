#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MIN_LEN 2     // Cantidad mínima de caracteres imprimibles para mostrar la secuencia

int is_printable(char c) {
    return (c >= 32 && c <= 126); // también podrías usar isprint(c) de ctype.h
}

void extract_strings_from_file(const char *filename) {
    FILE *file = fopen(filename, "rb"); // Abrimos el archivo en modo binario

    if (!file) {
        perror("Error al abrir el archivo");
        return;
    }

    char buffer[BUFSIZ];
    char str[BUFSIZ];
    size_t str_len = 0;

    int c;
    while ((c = fgetc(file)) != EOF) {
        if (is_printable(c)) {
            // Si es imprimible, lo guardamos en el buffer temporal
            if (str_len < sizeof(str) - 1) {
                str[str_len++] = (char)c;
            }
        } else {
            // Si NO es imprimible, verificamos si la secuencia actual es válida
            if (str_len >= MIN_LEN) {
                str[str_len] = '\0';  // Aseguramos que esté terminada en null
                printf("%s\n", str);  // Imprimimos la cadena encontrada
            }
            str_len = 0;  // Reiniciamos el buffer de cadena
        }
    }

    // Verificamos si al final del archivo quedó una cadena sin imprimir
    if (str_len >= MIN_LEN) {
        str[str_len] = '\0';
        printf("%s\n", str);
    }

    fclose(file); // Cerramos el archivo
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <archivo>\n", argv[0]);
        return 1;
    }

    extract_strings_from_file(argv[1]);

    return 0;
}
