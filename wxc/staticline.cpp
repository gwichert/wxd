//-----------------------------------------------------------------------------
// wx.NET - staticline.cxx
//
// The wxStaticLine proxy interface.
//
// Written by Robert Roebling
// (C) 2003 by Robert Roebling
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/statline.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _StaticLine : public wxStaticLine
{
public:
    DECLARE_OBJECTDELETED(_StaticLine)
};

//-----------------------------------------------------------------------------
// C stubs for class methods
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStaticLine* wxStaticLine_ctor()
{
	return new _StaticLine();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStaticLine_Create(wxStaticLine *self, wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, long style, const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name == NULL)
		name = "staticLine";

	return self->Create(parent, id, *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStaticLine_IsVertical(wxStaticLine* self)
{
	return self->IsVertical()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxStaticLine_GetDefaultSize(wxStaticLine* self)
{
	return self->GetDefaultSize();
}


