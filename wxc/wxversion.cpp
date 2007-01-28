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
wxString* wxVersion_VERSION_STRING()
{
	return new wxString(wxVERSION_STRING);
}

/* Users can pre-define wxABI_VERSION to a lower value in their
 * makefile/project settings to compile code that will be binary compatible
 * with earlier versions of the ABI within the same minor version (between
 * minor versions binary compatibility breaks anyway). The default is the
 * version of wxWidgets being used. A single number with two decimal digits
 * for each component, e.g. 20603 for 2.6.3 */
extern "C" WXEXPORT
long wxVersion_ABI_VERSION()
{
#ifdef wxABI_VERSION
	return wxABI_VERSION;
#else
	return wxVERSION_NUMBER;
#endif
}

//-----------------------------------------------------------------------------
