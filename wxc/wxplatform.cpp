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
wxc_bool wxPlatform_WXMSW()
{
#ifdef __WXMSW__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_WXGTK()
{
#ifdef __WXGTK__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_WXMAC()
{
#ifdef __WXMAC__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_WXX11()
{
#ifdef __WXX11__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_WXUNIVERSAL()
{
#ifdef __WXUNIVERSAL__
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_WXDEBUG()
{
#ifdef __WXDEBUG__
	return true;
#else
	return false;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPlatform_UNIX()
{
#if wxUSE_UNIX
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_UNICODE()
{
#if wxUSE_UNICODE
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_DISPLAY()
{
#if wxUSE_DISPLAY
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_POSTSCRIPT()
{
#if wxUSE_POSTSCRIPT
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_GLCANVAS()
{
#if wxUSE_GLCANVAS
	return true;
#else
	return false;
#endif
}

extern "C" WXEXPORT
wxc_bool wxPlatform_SOUND()
{
#if wxUSE_SOUND
	return true;
#else
	return false;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPlatform_wxGetOsDescription()
{
	static wxString os = wxGetOsDescription();
	return new wxString(os);
}

extern "C" WXEXPORT
int wxPlatform_wxGetOsVersion(int *majorVsn, int *minorVsn)
{
	return wxGetOsVersion(majorVsn, minorVsn);
}

//-----------------------------------------------------------------------------

#if wxABI_VERSION < 20700
#define wxOS_UNKNOWN        wxUNKNOWN_PLATFORM
#define wxOS_WINDOWS_9X     wxWIN95
#define wxOS_WINDOWS_NT     wxWINDOWS_NT
#define wxOS_WINDOWS        (wxWIN95|wxWINDOWS_NT)
#define wxOS_MAC_OS         wxMAC
#define wxOS_MAC_OSX_DARWIN wxMAC_DARWIN
#define wxOS_MAC            (wxMAC|wxMAC_DARWIN)
#define wxOS_UNIX_LINUX     0
#define wxOS_UNIX_FREEBSD   0
#define wxOS_UNIX           (0|0)
#endif

extern "C" WXEXPORT int wxPlatform_OS_UNKNOWN()    { return wxOS_UNKNOWN; }

extern "C" WXEXPORT int wxPlatform_OS_WINDOWS()    { return wxOS_WINDOWS; }
extern "C" WXEXPORT int wxPlatform_OS_WINDOWS_9X() { return wxOS_WINDOWS_9X; } /*  Windows 9x family */
extern "C" WXEXPORT int wxPlatform_OS_WINDOWS_NT() { return wxOS_WINDOWS_NT; } /*  Windows NT family */

extern "C" WXEXPORT int wxPlatform_OS_MAC()        { return wxOS_MAC; }
extern "C" WXEXPORT int wxPlatform_OS_MAC_OS()     { return wxOS_MAC_OS; } /*  Apple Mac OS 8/9/X with Mac paths */
extern "C" WXEXPORT int wxPlatform_OS_DARWIN()     { return wxOS_MAC_OSX_DARWIN; } /*  Apple Mac OS X with Unix paths */

extern "C" WXEXPORT int wxPlatform_OS_UNIX()       { return wxOS_UNIX; } 
extern "C" WXEXPORT int wxPlatform_OS_LINUX()      { return wxOS_UNIX_LINUX; }
extern "C" WXEXPORT int wxPlatform_OS_FREEBSD()    { return wxOS_UNIX_FREEBSD; }
