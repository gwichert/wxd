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
bool wxDialog_Create(wxDialog* self, wxWindow* parent, int id,
				     dstr title, const wxPoint* pos, const wxSize* size,
					 long style, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("dialogBox");

	return self->Create(parent, id, wxString(title.data, wxConvUTF8, title.length), *pos,
					    *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
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
dstrret wxDialog_GetTitle(wxDialog* self)
{
	return dstr_ret(self->GetTitle());
}

extern "C" WXEXPORT
void wxDialog_SetTitle(wxDialog* self, dstr title)
{
	self->SetTitle(wxString(title.data, wxConvUTF8, title.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDialog_EndModal(wxDialog* self, int retCode)
{
	self->EndModal(retCode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDialog_IsModal(wxDialog* self)
{
	return self->IsModal()?1:0;
}
    
extern "C" WXEXPORT
void wxDialog_SetModal(wxDialog* self, bool modal)
{
	self->SetModal(modal);
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
