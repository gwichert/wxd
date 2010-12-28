//-----------------------------------------------------------------------------
// wxD - dialog.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - dialog.cxx
//
// The wxDialog proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/dialog.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Dialog : public wxDialog
{
public:
    DECLARE_OBJECTDELETED(_Dialog)
    
#include "panel.inc"
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDialog* wxDialog_ctor()
{
	return new _Dialog();
}

extern "C" WXEXPORT
void wxDialog_dtor(wxDialog* self)
{
	delete self;
}

extern "C" WXEXPORT
wxc_bool wxDialog_Create(wxDialog* self, wxWindow* parent, int id,
				     wxc_string title, const wxPoint* pos, const wxSize* size,
					 long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("dialogBox");

	return self->Create(parent, id, wxstr(title), *pos,
					    *size, style, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDialog_SetReturnCode(wxDialog* self, int returnCode)
{
	self->SetReturnCode(returnCode);
}

extern "C" WXEXPORT
int wxDialog_GetReturnCode(wxDialog* self)
{
	return self->GetReturnCode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxDialog_GetTitle(wxDialog* self)
{
	return new wxString(self->GetTitle());
}

extern "C" WXEXPORT
void wxDialog_SetTitle(wxDialog* self, wxc_string title)
{
	self->SetTitle(wxstr(title));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDialog_EndModal(wxDialog* self, int retCode)
{
	self->EndModal(retCode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxDialog_IsModal(wxDialog* self)
{
	return self->IsModal()?1:0;
}
    
extern "C" WXEXPORT
void wxDialog_SetModal(wxDialog* self, wxc_bool modal)
{
#if wxABI_VERSION < 20900
	self->SetModal(modal);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDialog_SetIcon(wxDialog* self, wxIcon* icon)
{
	self->SetIcon(*icon);
}

extern "C" WXEXPORT
void wxDialog_SetIcons(wxDialog* self, wxIconBundle* icons)
{
	self->SetIcons(*icons);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDialog_ShowModal(wxDialog* self)
{
	return self->ShowModal();
}

//-----------------------------------------------------------------------------
