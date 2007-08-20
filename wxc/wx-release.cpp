
// Outputs the current wxWidgets release

#include <stdio.h>

#include "wx/defs.h"

#if defined(__APPLE__) && !(wxCHECK_VERSION(2,6,1)) // will be 2.6.4 eventually
    /* don't support the broken 2.5.3, in Mac OS X 10.4 */
    #error "unsupported wxWidgets version, please upgrade"
#endif

int main(int argc, char *argv[])
{
    if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'v') 
        printf("WX_RELEASE_NODOT = ");
    printf("%d%d\n", wxMAJOR_VERSION, wxMINOR_VERSION);
    return 0;
}
