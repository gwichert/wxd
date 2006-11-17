//-----------------------------------------------------------------------------
// wxD - spinbutton.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - spinbutton.cxx
//
// The wxSpinButton proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/spinbutt.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _SpinButton : public wxSpinButton
{
public:
    DECLARE_OBJECTDELETED(_SpinButton)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSpinButton* wxSpinButton_ctor()
{
	return new _SpinButton();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxSpinButton_Create(wxSpinButton* self, wxWindow *parent, wxWindowID id, const wxPoint* pos, const wxSize* size, long style, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("spinbutton");

	return self->Create(parent, id, *pos, *size, style, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSpinButton_GetValue(wxSpinButton* self)
{
	return self->GetValue();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSpinButton_GetMin(wxSpinButton* self)
{
	return self->GetMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSpinButton_GetMax(wxSpinButton* self)
{
	return self->GetMax();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSpinButton_SetValue(wxSpinButton* self, int val)
{
	self->SetValue(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSpinButton_SetRange(wxSpinButton* self, int minVal, int maxVal)
{
	self->SetRange(minVal, maxVal);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSpinEvent* wxSpinEvent_ctor(wxEventType commandType, int id)
{
    return new wxSpinEvent(commandType, id);
}

extern "C" WXEXPORT
int wxSpinEvent_GetPosition(wxSpinEvent* self)
{
    return self->GetPosition();
}

extern "C" WXEXPORT
void wxSpinEvent_SetPosition(wxSpinEvent* self, int pos)
{
    self->SetPosition(pos);
}

extern "C" WXEXPORT
void wxSpinEvent_Veto(wxSpinEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void wxSpinEvent_Allow(wxSpinEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
dbit wxSpinEvent_IsAllowed(wxSpinEvent* self)
{
    return self->IsAllowed()?1:0;
}
