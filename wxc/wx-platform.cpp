
/* Outputs the current wxWidgets platform */

#include <stdio.h>

#include "wx/defs.h"

int main(int argc, char *argv[])
{
    int err = 0;
    if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'v') 
        printf("PLATFORM = ");
#if defined(__WXMSW__)
    puts("WXMSW");
#elif defined(__WXGTK__)
    puts("WXGTK");
#elif defined(__WXMAC__)
    puts("WXMAC");
#elif defined(__WXX11__)
    puts("WXX11");
#else
    fputs("unsupported platform", stderr);
    err = 1;
#endif
    return err;
}
