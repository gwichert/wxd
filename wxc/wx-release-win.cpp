#include <stdio.h>

#include "wx/defs.h"

int main(void)
{
    printf("WX_RELEASE_NODOT=%d%d\n",
            wxMAJOR_VERSION, wxMINOR_VERSION);
    return 0;
}
