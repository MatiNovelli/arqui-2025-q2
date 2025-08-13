#include <stdio.h>

#define DIMENSION 1024

int matriz[DIMENSION][DIMENSION] = {1};

int main(void) 
{
    for(int i = 0; i < DIMENSION; i++)
    {
        for(int j = 0; j < DIMENSION; j++)
        {
            matriz[i][j] = 1;
        }
    }
    printf("Hello World!\n");

    return 0;
} 

