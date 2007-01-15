//-----------------------------------------------------------------------------
// wxD - spinctl.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - spinctl.cxx
//
// The wxSpinCtrl proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/spinctrl.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _SpinCtrl : public wxSpinCtrl
{
public:
    DECLARE_OBJECTDELETED(_SpinCtrl)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSpinCtrl* wxSpinCtrl_ctor()
{
	return new _SpinCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSpinCtrl_Create(wxSpinCtrl* self, wxWindow *parent, wxWindowID id, wxc_string value, const wxPoint* pos, const wxSize* size, long style, int min, int max, int initial, wxc_string name)
{
//	if (value == NULL)
//		value = "";

	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("spinctrl");

	return self->Create(parent, id, wxstr(value), *pos, *size, style, min, max, initial, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSpinCtrl_dtor(wxSpinCtrl* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSpinCtrl_SetValue(wxSpinCtrl* self, int val)
{
	self->SetValue(val);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSpinCtrl_SetValueStr(wxSpinCtrl* self, wxc_string text)
{
	self->SetValue(wxstr(text));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSpinCtrl_SetRange(wxSpinCtrl* self, int min, int max)
{
	self->SetRange(min, max);
}

//-----------------------------------------------------------------------------

#if 0
extern "C" WXEXPORT
void wxSpinCtrl_SetSelection(wxSpinCtrl* self, long from, long to)
{
	self->SetSelection(from, to);
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSpinCtrl_GetValue(wxSpinCtrl* self)
{
	return self->GetValue();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSpinCtrl_GetMin(wxSpinCtrl* self)
{
	return self->GetMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSpinCtrl_GetMax(wxSpinCtrl* self)
{
	return self->GetMax();
}
