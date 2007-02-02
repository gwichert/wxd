
// Outputs the current wxWidgets version

#include <stdio.h>

#include "wx/defs.h"

int main(int argc, char *argv[])
{
    if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'v') 
        printf("WX_VERSION = ");
    puts(wxVERSION_NUM_DOT_STRING);
    return 0;
}
