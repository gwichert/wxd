//-----------------------------------------------------------------------------
// wxD - sizer.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - sizer.cxx
//
// The wxSizer proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"


extern "C" WXEXPORT
void wxSizer_AddWindow(wxSizer* self, wxWindow* window, int proportion, int flag,
		int border, wxObject* userData)
{
	self->Add(window, proportion, flag, border, userData);
}

extern "C" WXEXPORT
void wxSizer_AddSizer(wxSizer* self, wxSizer* sizer, int proportion, int flag,
					int border,	wxObject* userData)
{
	self->Add(sizer, proportion, flag, border, userData);
}

extern "C" WXEXPORT
void wxSizer_Add(wxSizer* self, int width, int height, int proportion,
				int flag, int border, wxObject* userData)
{
	self->Add(width, height, proportion, flag, border, userData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_Fit(wxSizer* self, wxWindow *window, wxSize* size)
{
	*size = self->Fit(window);
}

extern "C" WXEXPORT
void wxSizer_FitInside(wxSizer* self, wxWindow *window)
{
	self->FitInside(window);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_InsertWindow(wxSizer* self, int before, wxWindow *window,
						  int option, int flag, int border, wxObject* userData)
{
	self->Insert(before, window, option, flag, border, userData);
}

extern "C" WXEXPORT
void wxSizer_InsertSizer(wxSizer* self, int before, wxSizer *sizer,
						 int option, int flag, int border, wxObject* userData)
{
	self->Insert(before, sizer, option, flag, border, userData);
}

extern "C" WXEXPORT
void wxSizer_Insert(wxSizer* self, int before, int width, int height,
					int option, int flag, int border, wxObject* userData)
{
	self->Insert(before, width, height, option, flag, border, userData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_PrependWindow(wxSizer* self, wxWindow *window, int option,
						   int flag, int border, wxObject* userData)
{
	self->Prepend(window, option, flag, border, userData);
}

extern "C" WXEXPORT
void wxSizer_PrependSizer(wxSizer* self, wxSizer *sizer, int option, int flag,
						  int border, wxObject* userData)
{
	self->Prepend(sizer, option, flag, border, userData);
}

extern "C" WXEXPORT
void wxSizer_Prepend(wxSizer* self, int width, int height, int option,
					 int flag, int border, wxObject* userData)
{
	self->Prepend(width, height, option, flag, border, userData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSizer_RemoveWindow(wxSizer* self, wxWindow *window)
{
#if wxABI_VERSION < 20900
	return self->Remove(window)?1:0;
#else
	return self->Detach(window)?1:0;
#endif
}

extern "C" WXEXPORT
wxc_bool wxSizer_RemoveSizer(wxSizer* self, wxSizer *sizer)
{
	return self->Remove(sizer)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxSizer_Remove(wxSizer* self, int pos)
{
	return self->Remove(pos)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_Clear(wxSizer* self, wxc_bool delete_windows)
{
	self->Clear(delete_windows);
}

extern "C" WXEXPORT
void wxSizer_DeleteWindows(wxSizer* self)
{
	self->DeleteWindows();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_SetMinSize(wxSizer* self, wxSize* size)
{
	self->SetMinSize(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSizer_SetItemMinSizeWindow(wxSizer* self, wxWindow *window, wxSize* size)
{
	return self->SetItemMinSize(window, *size)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxSizer_SetItemMinSizeSizer(wxSizer* self, wxSizer *sizer, wxSize* size)
{
	return self->SetItemMinSize(sizer, *size)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxSizer_SetItemMinSize(wxSizer* self, int pos, wxSize* size)
{
	return self->SetItemMinSize(pos, *size)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_GetSize(wxSizer* self, wxSize* size)
{
	*size = self->GetSize();
}

extern "C" WXEXPORT
void wxSizer_GetPosition(wxSizer* self, wxPoint *pt)
{
	*pt = self->GetPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_GetMinSize(wxSizer* self, wxSize* size)
{
	*size = self->GetMinSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_RecalcSizes(wxSizer* self)
{
	self->RecalcSizes();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_CalcMin(wxSizer* self, wxSize* size)
{
	*size = self->CalcMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_Layout(wxSizer* self)
{
	self->Layout();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_SetSizeHints(wxSizer* self, wxWindow *window)
{
	self->SetSizeHints(window);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_SetVirtualSizeHints(wxSizer* self, wxWindow *window)
{
	self->SetVirtualSizeHints(window);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_SetDimension(wxSizer* self, int x, int y, int width, int height)
{
	self->SetDimension(x, y, width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizer_ShowWindow(wxSizer* self, wxWindow *window, wxc_bool show)
{
	self->Show(window, show);
}

extern "C" WXEXPORT
void wxSizer_HideWindow(wxSizer* self, wxWindow *window)
{
	self->Hide(window);
}

extern "C" WXEXPORT
void wxSizer_ShowSizer(wxSizer* self, wxSizer *sizer, wxc_bool show)
{
	self->Show(sizer, show);
}

extern "C" WXEXPORT
void wxSizer_HideSizer(wxSizer* self, wxSizer *sizer)
{
	self->Hide(sizer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSizer_IsShownWindow(wxSizer* self, wxWindow *window)
{
	return self->IsShown(window)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxSizer_IsShownSizer(wxSizer* self, wxSizer *sizer)
{
	return self->IsShown(sizer)?1:0;
}


extern "C" WXEXPORT
wxc_bool wxSizer_DetachWindow(wxSizer* self, wxWindow* window)
{
	return self->Detach(window)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxSizer_DetachSizer(wxSizer* self, wxSizer* sizer)
{
	return self->Detach(sizer)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxSizer_Detach(wxSizer* self, int index)
{
	return self->Detach(index)?1:0;
}

