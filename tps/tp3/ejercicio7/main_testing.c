#include <stdio.h>

int main(int argc, char *argv[]) 
{
    printf("%d \n", argc);
    for (int i = 0; i < 1000; i++) 
    {
        if(argv[i] == NULL)
        {
            continue;
        }
        puts(argv[i]);
    }

    return 0;
}
