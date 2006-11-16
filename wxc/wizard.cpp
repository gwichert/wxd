//-----------------------------------------------------------------------------
// wx.NET - wizard.cxx
//
// The wxWizard proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/wizard.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Wizard : public wxWizard
{
public:
	_Wizard(wxWindow* parent, wxWindowID id, const wxString& title,
			const wxBitmap& bitmap, const wxPoint& pos)
		: wxWizard(parent, id, title, bitmap, pos) { }

    DECLARE_OBJECTDELETED(_Wizard)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxWizard* wxWizard_ctor(wxWindow* parent, int id, const char* title, const wxBitmap* bitmap, const wxPoint* pos)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (bitmap == NULL)
		bitmap = &wxNullBitmap;

	return new _Wizard(parent, id, wxString(title, wxConvUTF8), *bitmap, *pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxWizard_RunWizard(wxWizard* self, wxWizardPage* firstPage)
{
	return self->RunWizard(firstPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWizard_SetPageSize(wxWizard* self, const wxSize* size)
{
	self->SetPageSize(*size);
}

