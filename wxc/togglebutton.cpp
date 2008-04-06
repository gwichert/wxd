//-----------------------------------------------------------------------------
// wxD - togglebutton.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - togglebutton.cxx
//
// The wxToggleButton proxy interface.
//
// Written by Florian Fankhauser (f.fankhauser@gmx.at)
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/tglbtn.h>
#include "local_events.h"

#if wxUSE_TOGGLEBTN

//-----------------------------------------------------------------------------

class _ToggleButton : public wxToggleButton
{
public:
    DECLARE_OBJECTDELETED(_ToggleButton)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToggleButton* wxToggleButton_ctor()
{
	return new _ToggleButton();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxToggleButton_Create(wxToggleButton *self, wxWindow* parent, wxWindowID id, wxc_string label, const wxPoint* pos, const wxSize* size, long style, const wxValidator* validator, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = wxc_string("check");

	return self->Create(parent, id, wxstr(label), *pos, *size, style, *validator, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxToggleButton_GetValue(wxToggleButton* self)
{
	return self->GetValue()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToggleButton_SetValue(wxToggleButton* self, const wxc_bool state)
{
	self->SetValue(state);
}

extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED()  { return wxEVT_COMMAND_TOGGLEBUTTON_CLICKED; }

#else
#ifdef __GNUC__
#warning "wxUSE_TOGGLEBTN is not set"
#endif

extern "C" WXEXPORT void* wxToggleButton_ctor() { return NULL; /* dummy symbol for library */ }
extern "C" WXEXPORT wxc_bool wxToggleButton_Create(void *self, wxWindow* parent, wxWindowID id, wxc_string label, const wxPoint* pos, const wxSize* size, long style, const wxValidator* validator, wxc_string name) { return false; }
extern "C" WXEXPORT wxc_bool wxToggleButton_GetValue(void* self) { return false;}
extern "C" WXEXPORT void wxToggleButton_SetValue(void* self, const wxc_bool state) {}

extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED()  { return -1; /* dummy symbol for library */ }
#endif
