#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>

int main(int argc, char* argv[])
{
    if(argc < 2) 
    {
        printf("Inalid amount of arguments\n");
        return 1;    
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) 
    {
        perror("Error al abrir el archivo");
        return 1;
    }

    unsigned char buffer;
    bool imInWord = false;
    while (fread(&buffer, sizeof(unsigned char), 1, file) == 1) {
        if(isprint(buffer))
        {
            if(buffer == 0)
            {
                imInWord = false;    
            }
            else
            {
                imInWord = true;
                printf("%c", buffer);
            }
        }

        if (!imInWord)
        {
            puts("");
        }
    }

    fclose(file);
    return 0;

}