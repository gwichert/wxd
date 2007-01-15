//-----------------------------------------------------------------------------
// wxD - caret.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - caret.cxx
//
// The wxCaret proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/caret.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCaret* wxCaret_ctor()
{
	return new wxCaret();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_dtor(wxCaret* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCaret_Create(wxCaret* self, wxWindow *window, int width, int height)
{
	return self->Create(window, width, height)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCaret_IsOk(wxCaret* self)
{
	return self->IsOk()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCaret_IsVisible(wxCaret* self)
{
	return self->IsVisible()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_GetPosition(wxCaret* self, int *x, int *y)
{
	self->GetPosition(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_GetSize(wxCaret* self, int *width, int *height)
{
	self->GetSize(width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxCaret_GetWindow(wxCaret* self)
{
	return self->GetWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_SetSize(wxCaret* self, int width, int height)
{
	self->SetSize(width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_Move(wxCaret* self, int x, int y)
{
	self->Move(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_Show(wxCaret* self, wxc_bool show)
{
	self->Show(show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_Hide(wxCaret* self)
{
	self->Hide();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxCaret_GetBlinkTime()
{
	return wxCaret::GetBlinkTime();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaret_SetBlinkTime(int milliseconds)
{
	wxCaret::SetBlinkTime(milliseconds);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCaretSuspend* wxCaretSuspend_ctor(wxWindow *win)
{
	return new wxCaretSuspend(win);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCaretSuspend_dtor(wxCaretSuspend* self)
{
	delete self;
}
