//-----------------------------------------------------------------------------
// wxD - sizeritem.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - sizeritem.cxx
//
// The wxSizerItem proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSizerItem* wxSizerItem_ctorSpace(int width, int height, int proportion, int flag, int border, wxObject* userData)
{
    return new wxSizerItem(width, height, proportion, flag, border, userData);
}

extern "C" WXEXPORT
wxSizerItem* wxSizerItem_ctorWindow(wxWindow* window, int proportion, int flag, int border, wxObject* userData)
{
    return new wxSizerItem(window, proportion, flag, border, userData);
}

extern "C" WXEXPORT
wxSizerItem* wxSizerItem_ctorSizer(wxSizer* sizer, int proportion, int flag, int border, wxObject* userData)
{
    return new wxSizerItem(sizer, proportion, flag, border, userData);
}

extern "C" WXEXPORT
wxSizerItem* wxSizerItem_ctor()
{
    return new wxSizerItem();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_DeleteWindows(wxSizerItem* self)
{
    self->DeleteWindows();
}

extern "C" WXEXPORT
void wxSizerItem_DetachSizer(wxSizerItem* self)
{
    self->DetachSizer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_GetSize(wxSizerItem* self, wxSize* size)
{
    *size = self->GetSize();
}

extern "C" WXEXPORT
void wxSizerItem_CalcMin(wxSizerItem* self, wxSize* min)
{
    *min = self->CalcMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_SetDimension(wxSizerItem* self, wxPoint pos, wxSize size)
{
    self->SetDimension(pos, size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_GetMinSize(wxSizerItem* self, wxSize* size)
{
    *size = self->GetMinSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_SetInitSize(wxSizerItem* self, int x, int y)
{
    self->SetInitSize(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_SetRatio(wxSizerItem* self, int width, int height)
{
    self->SetRatio(width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_SetRatioFloat(wxSizerItem* self, float ratio)
{
    self->SetRatio(ratio);
}

extern "C" WXEXPORT
float wxSizerItem_GetRatioFloat(wxSizerItem* self)
{
    return self->GetRatio();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSizerItem_IsWindow(wxSizerItem* self)
{
    return self->IsWindow()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSizerItem_IsSizer(wxSizerItem* self)
{
    return self->IsSizer()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSizerItem_IsSpacer(wxSizerItem* self)
{
    return self->IsSpacer()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_SetProportion(wxSizerItem* self, int proportion)
{
    self->SetProportion(proportion);
}

extern "C" WXEXPORT
int wxSizerItem_GetProportion(wxSizerItem* self)
{
    return self->GetProportion();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_SetFlag(wxSizerItem* self, int flag)
{
    self->SetFlag(flag);
}

extern "C" WXEXPORT
int wxSizerItem_GetFlag(wxSizerItem* self)
{
    return self->GetFlag();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_SetBorder(wxSizerItem* self, int border)
{
    self->SetBorder(border);
}

extern "C" WXEXPORT
int wxSizerItem_GetBorder(wxSizerItem* self)
{
    return self->GetBorder();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxSizerItem_GetWindow(wxSizerItem* self)
{
    return self->GetWindow();
}

extern "C" WXEXPORT
void wxSizerItem_SetWindow(wxSizerItem* self, wxWindow* window)
{
    self->SetWindow(window);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSizer* wxSizerItem_GetSizer(wxSizerItem* self)
{
    return self->GetSizer();
}

extern "C" WXEXPORT
void wxSizerItem_SetSizer(wxSizerItem* self, wxSizer* sizer)
{
    self->SetSizer(sizer);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_GetSpacer(wxSizerItem* self, wxSize* size)
{
    *size = self->GetSpacer();
}

extern "C" WXEXPORT
void wxSizerItem_SetSpacer(wxSizerItem* self, wxSize* size)
{
    self->SetSpacer(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_Show(wxSizerItem* self, wxc_bool show)
{
    self->Show(show);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSizerItem_IsShown(wxSizerItem* self)
{
    return self->IsShown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxSizerItem_GetUserData(wxSizerItem* self)
{
    return self->GetUserData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSizerItem_GetPosition(wxSizerItem* self, wxPoint* pos)
{
    *pos = self->GetPosition();
}

