//-----------------------------------------------------------------------------
// wxD - bmpbuttn.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - bmpbuttn.cxx
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/bmpbuttn.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

typedef void (CALLBACK* Virtual_OnSetBitmap) (dobj obj);

class _BitmapButton : public wxBitmapButton
{
public:
	_BitmapButton()
		: wxBitmapButton() {}
		
	void POnSetBitmap()
		{ wxBitmapButton::OnSetBitmap(); }

	void RegisterVirtual(Virtual_OnSetBitmap onSetBitmap)
	{
		m_OnSetBitmap = onSetBitmap;
	}
	
protected:
	void OnSetBitmap()
		{ m_OnSetBitmap(obj); }
		
private:
	Virtual_OnSetBitmap m_OnSetBitmap;
	dobj obj;
public:
	DECLARE_OBJECTDELETED(_BitmapButton)
	
	//DECLARE_DISPOSABLE_AND_OBJECTDELETED(_BitmapButton)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBitmapButton* wxBitmapButton_ctor()
{
	return new _BitmapButton();
}

extern "C" WXEXPORT
void wxBitmapButton_RegisterVirtual(_BitmapButton* self, Virtual_OnSetBitmap onSetBitmap)
{
	self->RegisterVirtual(onSetBitmap);
}

/*extern "C" WXEXPORT
void wxBitmapButton_RegisterDisposable(_BitmapButton* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxBitmapButton_Create(_BitmapButton* self, wxWindow *parent, wxWindowID id, const wxBitmap *bitmap, const wxPoint* pos, const wxSize* size, long style, const wxValidator* validator, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = dstr("bitmapbutton");

	return self->Create(parent, id, *bitmap, *pos, *size, style, *validator, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

extern "C" WXEXPORT
void wxBitmapButton_OnSetBitmap(_BitmapButton* self)
{
	self->POnSetBitmap();
}

//-----------------------------------------------------------------------------

// t9mike: SetLabel is private; use SetBitmapLabel
extern "C" WXEXPORT
void wxBitmapButton_SetLabel(_BitmapButton* self, dstr label)
{
	self->SetBitmapLabel(wxString(label.data, wxConvUTF8, label.length));
}

extern "C" WXEXPORT
dstrret wxBitmapButton_GetLabel(_BitmapButton* self)
{
	return dstr_ret(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxBitmapButton_Enable(_BitmapButton* self, bool enable)
{
	return self->Enable(enable)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapButton_SetBitmapLabel(_BitmapButton* self, const wxBitmap* bitmap)
{
	self->SetBitmapLabel(*bitmap);
}

extern "C" WXEXPORT
wxBitmap* wxBitmapButton_GetBitmapLabel(_BitmapButton* self)
{
    return &(self->GetBitmapLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapButton_SetBitmapSelected(_BitmapButton* self, const wxBitmap* sel)
{
	self->SetBitmapSelected(*sel);
}

extern "C" WXEXPORT
wxBitmap* wxBitmapButton_GetBitmapSelected(_BitmapButton* self)
{
    return &(self->GetBitmapSelected());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapButton_SetBitmapDisabled(_BitmapButton* self, const wxBitmap* disabled)
{
    self->SetBitmapDisabled(*disabled);
}

extern "C" WXEXPORT
wxBitmap* wxBitmapButton_GetBitmapDisabled(_BitmapButton* self)
{
    return &(self->GetBitmapDisabled());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapButton_SetBitmapFocus(_BitmapButton* self, const wxBitmap* focus)
{
	self->SetBitmapFocus(*focus);
}

extern "C" WXEXPORT
wxBitmap* wxBitmapButton_GetBitmapFocus(_BitmapButton* self)
{
    return &(self->GetBitmapFocus());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapButton_SetDefault(_BitmapButton* self)
{
	self->SetDefault();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapButton_SetMargins(_BitmapButton* self, int x, int y)
{
	self->SetMargins(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxBitmapButton_GetMarginX(_BitmapButton* self)
{
	return self->GetMarginX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxBitmapButton_GetMarginY(_BitmapButton* self)
{
	return self->GetMarginY();
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
void wxBitmapButton_ApplyParentThemeBackground(_BitmapButton* self, wxColour* colour)
{
	self->ApplyParentThemeBackground(*colour);
}*/
