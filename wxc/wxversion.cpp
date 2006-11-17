//-----------------------------------------------------------------------------
// wxD - wxversion.cpp
// (C) 2005 afb <afb@users.sourceforge.net>
//
// Various wx version constants
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

#include <wx/version.h>

extern "C" WXEXPORT
long wxVersion_MAJOR_VERSION()
{
	return wxMAJOR_VERSION;
}

extern "C" WXEXPORT
long wxVersion_MINOR_VERSION()
{
	return wxMINOR_VERSION;
}

extern "C" WXEXPORT
long wxVersion_RELEASE_NUMBER()
{
	return wxRELEASE_NUMBER;
}

extern "C" WXEXPORT
long wxVersion_SUBRELEASE_NUMBER()
{
	return wxSUBRELEASE_NUMBER;
}

extern "C" WXEXPORT
const char *wxVersion_VERSION_STRING()
{
	static wxString vers = wxVERSION_STRING;
#if wxUSE_UNICODE
	return vers.mb_str(wxConvUTF8).data();
#else // ANSI
	return vers.data();
#endif
}

//-----------------------------------------------------------------------------
