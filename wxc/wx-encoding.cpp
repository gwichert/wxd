
/* Outputs the current wxWidgets encoding */

#include <stdio.h>

#include "wx/defs.h"

int main(int argc, char *argv[])
{
    if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'v') 
        printf("ENCODING = ");
#if wxUSE_UNICODE
    puts("UNICODE");
#else
    puts("ANSI");
#endif
    return 0;
}
