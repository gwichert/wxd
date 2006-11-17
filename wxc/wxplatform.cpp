//-----------------------------------------------------------------------------
// wxD - wxplatform.cpp
// (C) 2006 afb <afb@users.sourceforge.net>
//
// Various wx platform constants
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

#include <wx/platform.h>
#include <wx/utils.h>

extern "C" WXEXPORT
dbit wxPlatform_WXMSW()
{
#ifdef __WXMSW__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
dbit wxPlatform_WXGTK()
{
#ifdef __WXGTK__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
dbit wxPlatform_WXMAC()
{
#ifdef __WXMAC__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
dbit wxPlatform_WXX11()
{
#ifdef __WXX11__
	return true;
#else
	return false;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const char *wxPlatform_wxGetOsDescription()
{
	static wxString os = wxGetOsDescription();
#if wxUSE_UNICODE
	return os.mb_str(wxConvUTF8).data();
#else // ANSI
	return os.data();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPlatform_wxGetOsVersion(int *majorVsn, int *minorVsn)
{
	return wxGetOsVersion(majorVsn, minorVsn);
}

extern "C" WXEXPORT int wxPlatform_wxUNKNOWN_PLATFORM() { return wxUNKNOWN_PLATFORM; }

extern "C" WXEXPORT int wxPlatform_wxWIN95()      { return wxWIN95; } /*  Windows 95 */
extern "C" WXEXPORT int wxPlatform_wxWINDOWS_NT() { return wxWINDOWS_NT; } /*  Windows NT */

extern "C" WXEXPORT int wxPlatform_wxGTK()        { return wxGTK; } /*  GTK on X */
extern "C" WXEXPORT int wxPlatform_wxGTK_WIN32()  { return wxGTK_WIN32; } /*  GTK on Win32 */

extern "C" WXEXPORT int wxPlatform_wxMAC()        { return wxMAC; } /*  Apple Mac OS 8/9/X with Mac paths */
extern "C" WXEXPORT int wxPlatform_wxMAC_DARWIN() { return wxMAC_DARWIN; } /*  Apple Mac OS X with Unix paths */

extern "C" WXEXPORT int wxPlatform_wxUNIX()       { return wxUNIX; } /* wxBase under Unix */
extern "C" WXEXPORT int wxPlatform_wxX11()        { return wxX11; } /* Plain X11 and Universal widgets */

