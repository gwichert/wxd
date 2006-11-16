//-----------------------------------------------------------------------------
// wx.NET - fontdialog.cxx
//
// The wxFontDialog proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/fontdlg.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _FontDialog : public wxFontDialog
{
public:
    DECLARE_OBJECTDELETED(_FontDialog)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFontDialog* wxFontDialog_ctor()
{
    return new _FontDialog();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFontDialog_Create(wxFontDialog* self, wxWindow *parent, const wxFontData* data)
{
    return self->Create(parent, *data)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontDialog_dtor(wxFontDialog* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFontDialog_ShowModal(wxFontDialog* self)
{
    return self->ShowModal();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFontData* wxFontDialog_GetFontData(wxFontDialog* self)
{
    return &(self->GetFontData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFontData* wxFontData_ctor()
{
	return new wxFontData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_dtor(wxFontData* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_SetAllowSymbols(wxFontData* self, bool flag)
{
	self->SetAllowSymbols(flag);
}

extern "C" WXEXPORT
bool wxFontData_GetAllowSymbols(wxFontData* self)
{
	return self->GetAllowSymbols()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_SetColour(wxFontData* self, const wxColour* colour)
{
	self->SetColour(*colour);
}

extern "C" WXEXPORT
wxColour* wxFontData_GetColour(wxFontData* self)
{
    return new wxColour(self->GetColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_SetShowHelp(wxFontData* self, bool flag)
{
	self->SetShowHelp(flag);
}

extern "C" WXEXPORT
bool wxFontData_GetShowHelp(wxFontData* self)
{
	return self->GetShowHelp()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_EnableEffects(wxFontData* self, bool flag)
{
	self->EnableEffects(flag);
}

extern "C" WXEXPORT
bool wxFontData_GetEnableEffects(wxFontData* self)
{
	return self->GetEnableEffects()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_SetInitialFont(wxFontData* self, const wxFont* font)
{
	self->SetInitialFont(*font);
}

extern "C" WXEXPORT
wxFont* wxFontData_GetInitialFont(wxFontData* self)
{
	return new wxFont(self->GetInitialFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_SetChosenFont(wxFontData* self, const wxFont* font)
{
	self->SetChosenFont(*font);
}

extern "C" WXEXPORT
wxFont* wxFontData_GetChosenFont(wxFontData* self)
{
	return new wxFont(self->GetChosenFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFontData_SetRange(wxFontData* self, int minRange, int maxRange)
{
	self->SetRange(minRange, maxRange);
}

//-----------------------------------------------------------------------------

