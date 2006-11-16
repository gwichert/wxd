//-----------------------------------------------------------------------------
// wxD - colourdialog.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - colourdialog.cxx
//
// The wxColourDialog proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/colordlg.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _ColourDialog : public wxColourDialog
{
public:
    DECLARE_OBJECTDELETED(_ColourDialog)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColourDialog* wxColourDialog_ctor()
{
	return new _ColourDialog();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxColourDialog_Create(wxColourDialog* self, wxWindow *parent, wxColourData *data)
{
	return self->Create(parent, data)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColourData* wxColourDialog_GetColourData(wxColourDialog* self)
{
    return new wxColourData(self->GetColourData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxColourDialog_ShowModal(wxColourDialog* self)
{
	return self->ShowModal();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxColourDialog_GetColourFromUser(wxWindow* parent, const wxColour* colInit)
{
	if (colInit==NULL) colInit= &wxNullColour;
	return new wxColour(wxGetColourFromUser(parent, *colInit));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColourData* wxColourData_ctor()
{
	return new wxColourData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColourData_SetChooseFull(wxColourData* self, bool flag)
{
	self->SetChooseFull(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxColourData_GetChooseFull(wxColourData* self)
{
	return self->GetChooseFull()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColourData_SetColour(wxColourData* self, const wxColour* colour)
{
	self->SetColour(*colour);
}

extern "C" WXEXPORT
wxColour* wxColourData_GetColour(wxColourData* self)
{
    return new wxColour(self->GetColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColourData_SetCustomColour(wxColourData* self, int i, const wxColour* colour)
{
	self->SetCustomColour(i, *colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxColourData_GetCustomColour(wxColourData* self, int i)
{
	return new wxColour(self->GetCustomColour(i));
}

//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
wxColor* wxGetColourFromUser_func(wxWindow *parent, wxColour *colInit)
{
	if (colInit == NULL) colInit = &wxNullColour;
	return new wxColor(wxGetColourFromUser(parent,*colInit));
}
*/
