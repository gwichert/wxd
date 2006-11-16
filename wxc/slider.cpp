//-----------------------------------------------------------------------------
// wxD - slider.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - slider.cxx
//
// The wxSlider proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/slider.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Slider : public wxSlider
{
public:
    DECLARE_OBJECTDELETED(_Slider)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSlider* wxSlider_ctor()
{
	return new _Slider();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxSlider_Create(wxSlider* self, wxWindow *parent, wxWindowID id, int value, int minValue, int maxValue, const wxPoint* pos, const wxSize* size, long style, const wxValidator* validator, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;
		
	if (name.data==NULL)
		name = dstr("slider",sizeof("slider")-1);

	if (validator == NULL)
	{
		return self->Create(parent, id, value, minValue, maxValue, *pos, *size, style, wxDefaultValidator, wxString(name.data, wxConvUTF8, name.length));
	}

	return self->Create(parent, id, value, minValue, maxValue, *pos, *size, style, *validator, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetValue(wxSlider* self)
{
	return self->GetValue();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetValue(wxSlider* self, int value)
{
	self->SetValue(value);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetRange(wxSlider* self, int minValue, int maxValue)
{
	self->SetRange(minValue, maxValue);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetMin(wxSlider* self)
{
	return self->GetMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetMax(wxSlider* self)
{
	return self->GetMax();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetLineSize(wxSlider* self, int lineSize)
{
	self->SetLineSize(lineSize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetPageSize(wxSlider* self, int pageSize)
{
	self->SetPageSize(pageSize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetLineSize(wxSlider* self)
{
	return self->GetLineSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetPageSize(wxSlider* self)
{
	return self->GetPageSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetThumbLength(wxSlider* self, int lenPixels)
{
	self->SetThumbLength(lenPixels);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetThumbLength(wxSlider* self)
{
	return self->GetThumbLength();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetTickFreq(wxSlider* self, int n, int pos)
{
	self->SetTickFreq(n, pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetTickFreq(wxSlider* self)
{
	return self->GetTickFreq();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_ClearTicks(wxSlider* self)
{
	self->ClearTicks();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetTick(wxSlider* self, int tickPos)
{
	self->SetTick(tickPos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_ClearSel(wxSlider* self)
{
	self->ClearSel();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetSelEnd(wxSlider* self)
{
	return self->GetSelEnd();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSlider_GetSelStart(wxSlider* self)
{
	return self->GetSelStart();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSlider_SetSelection(wxSlider* self, int min, int max)
{
	self->SetSelection(min, max);
}

