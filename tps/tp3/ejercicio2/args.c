#include <stdio.h>

int main(int argc, char* argv[]) 
{
    printf("Cantidad de argumentos %d\n", argc);

    for(int i = 0; argc != i; i++) 
    {
        printf("argv[%d]: %s\n", i, argv[i]);
    }

    return 0;

}