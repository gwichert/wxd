
// Eventually this might be a real wx-config implementation
// for now, everything in Xcode configuration is hard-coded

#include <cstdio>

#include "wx/defs.h"

#if defined(__APPLE__) && !(wxCHECK_VERSION(2,6,1)) // will be 2.6.4 eventually
    /* don't support the broken 2.5.3, in Mac OS X 10.4 */
    #error "unsupported wxWidgets version, please upgrade"
#endif

int main()
{
        printf("WX_RELEASE_NODOT = ");
    printf("%d%d\n", wxMAJOR_VERSION, wxMINOR_VERSION);

        printf("WX_VERSION = ");
    puts(wxVERSION_NUM_DOT_STRING);

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
   #error "unsupported platform"
#endif

#if __WXUNIVERSAL__
    puts("__WXUNIVERSAL__");
#endif

        printf("ENCODING = ");
#if wxUSE_UNICODE
    puts("UNICODE");
#else
    puts("ANSI");
#endif

#if __WXDEBUG__
    puts("__WXDEBUG__");
#endif

    return 0;
}
