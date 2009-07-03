
// "dmd" uses weird LDFLAGS syntax, so we have to wrap params first

#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
    char *param;
    char *libdir;
    for (int i = 1; i < argc; i++)
    {
        if (i != 1)
            printf(" ");
        param = argv[i];
        if (param[0] == '-' && param[1] == 'L')
            libdir = param+2;
        else if (param[0] == '-' && param[1] == 'l')
            printf("%s.lib", param+2);
        else
            printf("-L%s", param);
    }
    printf("\n");
    return 0;
}
