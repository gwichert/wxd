
// "dmd" uses weird LDFLAGS syntax, so we have to wrap params first

#include <stdio.h>

int main(int argc, char *argv[])
{
    char *param;
    for (int i = 1; i < argc; i++)
    {
        if (i != 1)
            printf(" ");
        param = argv[i];
        printf("-L%s", param);
    }
    printf("\n");
    return 0;
}
