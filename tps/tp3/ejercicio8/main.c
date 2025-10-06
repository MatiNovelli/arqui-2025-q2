#include <stdio.h>

#define READ_ONLY 0
#define BUFFER_SIZE 1024
#define STDOUT 1
#define PATH "./hola.txt"

void sys_exit(int error_code);
unsigned int sys_read(int fd, void *buf, unsigned int count);
unsigned int sys_write(int fd, void *buf, unsigned int count);
int sys_open(const char *pathname, int flags);
int sys_close(int fd);

void print_line_count(int line_count, char * buf);



int main() {
    char buffer[BUFFER_SIZE];
    int fd;
    unsigned int bytes_read;
    int line_count = 1;
    char line_count_buf[14];
    line_count_buf[0] = ' ';
    line_count_buf[1] = '[';

    // abrimos el amigo
    fd = sys_open(PATH, READ_ONLY);
    if (fd < 0) {
        char error_msg[] = "Error opening file\n";
        sys_write(STDOUT, error_msg, sizeof(error_msg) - 1);
        sys_exit(1);
    }

    // por si no entra en el buff, leemos varias veces
    while (bytes_read = sys_read(fd, buffer, BUFFER_SIZE)) {
        // hacemos una sliding window
        int i = 0;
        while (i < bytes_read) {
            int j = i;
            while (j < bytes_read && buffer[j] != '\n') {
                j++;
            }
            sys_write(STDOUT, buffer+i, j-i);
            
            // ya esta escrita la linea, ahora a escribir el numero
            // chequeamos que sea un enter y no que se termino el buffer
            if (j < bytes_read && buffer[j] == '\n') {
                print_line_count(line_count++, line_count_buf);
            }
            

            i = j+1;
        }
    }

    print_line_count(line_count, line_count_buf);

    // cerramos el amigo y nos vamos
    sys_close(fd);
    return 0;
    
    
}

void print_line_count(int line_count, char * buf) {
    int temp = line_count;
    int digits = 1;
    while ((temp /= 10) > 0) {
        digits++;
    }
    temp = line_count;
    for (int k = digits-1; k >= 0; k-- ) {
        buf[2+k] = '0' + (temp % 10);
        temp /= 10;
    }
    buf[digits+2] = ']'; // offset de 2 por ' ' y '['
    buf[digits+3] = '\n';

    sys_write(STDOUT, buf, digits+4); // digitos + ' ', [, ]
}