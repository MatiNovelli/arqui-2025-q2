#include<stdio.h>

int checkLong(char *msg, char len);

int main()
{
    extern char msg[];
    extern char len;

    int num = checkLong(msg, len);

    if(num == 0)
    {
        printf("Son iguales\n");
    }
    else
    {
        printf("La diferencia entre ambos es: %d\n", num);
    }
    
    return 0;
}