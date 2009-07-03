
// "dmd" uses weird LDFLAGS syntax, so we have to wrap params first

#include <stdio.h>

int main(int argc, char *argv[])
{
    for (int i = 1; i < argc; i++)
    {
        if (argv[i][0] == '-' && argv[i][1] == 'L')
            continue;
        if (i != 1)
            printf(" ");
        printf("-L%s", argv[i]);
    }
    printf("\n");
    return 0;
}
