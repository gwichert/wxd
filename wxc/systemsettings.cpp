//-----------------------------------------------------------------------------
// wxD - systemsettings.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - systemsettings.cxx
//
// The wxSystemSettings proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/settings.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxSystemSettings_GetColour(wxSystemColour index)
{
    return new wxColour(wxSystemSettings::GetColour(index));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxSystemSettings_GetFont(wxSystemFont index)
{
    return new wxFont(wxSystemSettings::GetFont(index));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSystemSettings_GetMetric(wxSystemMetric index)
{
    return wxSystemSettings::GetMetric(index);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxSystemSettings_HasFeature(wxSystemFeature index)
{
    return wxSystemSettings::HasFeature(index)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSystemScreenType wxSystemSettings_GetScreenType()
{
    return wxSystemSettings::GetScreenType();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSystemSettings_SetScreenType(wxSystemScreenType screen)
{
    wxSystemSettings::SetScreenType(screen);
}

