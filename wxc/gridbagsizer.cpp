//-----------------------------------------------------------------------------
// wxD - gridbagsizer.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - gridbagsizer.cxx
//
// The wxGridBagSizer proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/gbsizer.h>

//-----------------------------------------------------------------------------
// wxGBSizerItem

extern "C" WXEXPORT
wxGBSizerItem* wxGBSizerItem_ctor(int width, int height, wxGBPosition* pos, wxGBSpan* span, int flag, int border, wxObject* userData)
{
    return new wxGBSizerItem(width, height, *pos, *span, flag, border, userData);
}

extern "C" WXEXPORT
wxGBSizerItem* wxGBSizerItem_ctorWindow(wxWindow* window, wxGBPosition* pos, wxGBSpan* span, int flag, int border, wxObject* userData)
{
    return new wxGBSizerItem(window, *pos, *span, flag, border, userData);
}

extern "C" WXEXPORT
wxGBSizerItem* wxGBSizerItem_ctorSizer(wxSizer* sizer, wxGBPosition* pos, wxGBSpan* span, int flag, int border, wxObject* userData)
{
    return new wxGBSizerItem(sizer, *pos, *span, flag, border, userData);
}

extern "C" WXEXPORT
wxGBSizerItem* wxGBSizerItem_ctorDefault()
{
    return new wxGBSizerItem();
}

extern "C" WXEXPORT
wxGBPosition* wxGBSizerItem_GetPos(wxGBSizerItem* self)
{
    return new wxGBPosition(self->GetPos());
}

extern "C" WXEXPORT
wxGBSpan* wxGBSizerItem_GetSpan(wxGBSizerItem* self)
{
    return new wxGBSpan(self->GetSpan());
}

extern "C" WXEXPORT
wxc_bool wxGBSizerItem_SetPos(wxGBSizerItem* self, wxGBPosition* pos)
{
    return self->SetPos(*pos)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGBSizerItem_SetSpan(wxGBSizerItem* self, wxGBSpan* span)
{
    return self->SetSpan(*span)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGBSizerItem_IntersectsSizer(wxGBSizerItem* self, wxGBSizerItem* other)
{
    return self->Intersects(*other)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGBSizerItem_IntersectsSpan(wxGBSizerItem* self, wxGBPosition* pos, wxGBSpan* span)
{
    return self->Intersects(*pos, *span)?1:0;
}

extern "C" WXEXPORT
void wxGBSizerItem_GetEndPos(wxGBSizerItem* self, int* row, int* col)
{
    self->GetEndPos(*row, *col);
}

extern "C" WXEXPORT
wxGridBagSizer* wxGBSizerItem_GetGBSizer(wxGBSizerItem* self)
{
    return self->GetGBSizer();
}

extern "C" WXEXPORT
void wxGBSizerItem_SetGBSizer(wxGBSizerItem* self, wxGridBagSizer* sizer)
{
    self->SetGBSizer(sizer);
}

//-----------------------------------------------------------------------------
// wxGBSpan

extern "C" WXEXPORT
wxGBSpan* wxGBSpan_ctorDefault()
{
    return new wxGBSpan();
}

extern "C" WXEXPORT
wxGBSpan* wxGBSpan_ctor(int rowspan, int colspan)
{
    return new wxGBSpan(rowspan, colspan);
}

extern "C" WXEXPORT
int wxGBSpan_GetRowspan(wxGBSpan* self)
{
    return self->GetRowspan();
}

extern "C" WXEXPORT
int wxGBSpan_GetColspan(wxGBSpan* self)
{
    return self->GetColspan();
}

extern "C" WXEXPORT
void wxGBSpan_SetRowspan(wxGBSpan* self, int rowspan)
{
    self->SetRowspan(rowspan);
}

extern "C" WXEXPORT
void wxGBSpan_SetColspan(wxGBSpan* self, int colspan)
{
    self->SetColspan(colspan);
}

//-----------------------------------------------------------------------------
// wxGridBagSizer

extern "C" WXEXPORT
wxGridBagSizer* wxGridBagSizer_ctor(int vgap, int hgap)
{
    return new wxGridBagSizer(vgap, hgap);
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_AddWindow(wxGridBagSizer* self, wxWindow* window, wxGBPosition* pos, wxGBSpan* span, int flag, int border, wxObject* userData)
{
    return self->Add(window, *pos, *span, flag, border, userData)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_AddSizer(wxGridBagSizer* self, wxSizer* sizer, wxGBPosition* pos, wxGBSpan* span, int flag, int border, wxObject* userData)
{
    return self->Add(sizer, *pos, *span, flag, border, userData)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_Add(wxGridBagSizer* self, int width, int height, wxGBPosition* pos, wxGBSpan* span, int flag, int border, wxObject* userData)
{
    return self->Add(width, height, *pos, *span, flag, border, userData)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_AddItem(wxGridBagSizer* self, wxGBSizerItem* item)
{
    return self->Add(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridBagSizer_GetEmptyCellSize(wxGridBagSizer* self, wxSize* size)
{
    *size = self->GetEmptyCellSize();
}

extern "C" WXEXPORT
void wxGridBagSizer_SetEmptyCellSize(wxGridBagSizer* self, wxSize* sz)
{
    self->SetEmptyCellSize(*sz);
}

extern "C" WXEXPORT
void wxGridBagSizer_GetCellSize(wxGridBagSizer* self, int row, int col, wxSize* size)
{
    *size = self->GetCellSize(row, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGBPosition* wxGridBagSizer_GetItemPositionWindow(wxGridBagSizer* self, wxWindow* window)
{
    return new wxGBPosition(self->GetItemPosition(window));
}

extern "C" WXEXPORT
wxGBPosition* wxGridBagSizer_GetItemPositionSizer(wxGridBagSizer* self, wxSizer* sizer)
{
    return new wxGBPosition(self->GetItemPosition(sizer));
}

extern "C" WXEXPORT
wxGBPosition* wxGridBagSizer_GetItemPositionIndex(wxGridBagSizer* self, int index)
{
    return new wxGBPosition(self->GetItemPosition(index));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_SetItemPositionWindow(wxGridBagSizer* self, wxWindow* window, wxGBPosition* pos)
{
    return self->SetItemPosition(window, *pos)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_SetItemPositionSizer(wxGridBagSizer* self, wxSizer* sizer, wxGBPosition* pos)
{
    return self->SetItemPosition(sizer, *pos)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_SetItemPositionIndex(wxGridBagSizer* self, int index, wxGBPosition* pos)
{
    return self->SetItemPosition(index, *pos)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGBSpan* wxGridBagSizer_GetItemSpanWindow(wxGridBagSizer* self, wxWindow* window)
{
    return new wxGBSpan(self->GetItemSpan(window));
}

extern "C" WXEXPORT
wxGBSpan* wxGridBagSizer_GetItemSpanSizer(wxGridBagSizer* self, wxSizer* sizer)
{
    return new wxGBSpan(self->GetItemSpan(sizer));
}

extern "C" WXEXPORT
wxGBSpan* wxGridBagSizer_GetItemSpanIndex(wxGridBagSizer* self, int index)
{
    return new wxGBSpan(self->GetItemSpan(index));
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_SetItemSpanWindow(wxGridBagSizer* self, wxWindow* window, wxGBSpan* span)
{
    return self->SetItemSpan(window, *span)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_SetItemSpanSizer(wxGridBagSizer* self, wxSizer* sizer, wxGBSpan* span)
{
    return self->SetItemSpan(sizer, *span)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_SetItemSpanIndex(wxGridBagSizer* self, int index, wxGBSpan* span)
{
    return self->SetItemSpan(index, *span)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGBSizerItem* wxGridBagSizer_FindItemWindow(wxGridBagSizer* self, wxWindow* window)
{
    return self->FindItem(window);
}

extern "C" WXEXPORT
wxGBSizerItem* wxGridBagSizer_FindItemSizer(wxGridBagSizer* self, wxSizer* sizer)
{
    return self->FindItem(sizer);
}

extern "C" WXEXPORT
wxGBSizerItem* wxGridBagSizer_FindItemAtPosition(wxGridBagSizer* self, wxGBPosition* pos)
{
    return self->FindItemAtPosition(*pos);
}

extern "C" WXEXPORT
wxGBSizerItem* wxGridBagSizer_FindItemAtPoint(wxGridBagSizer* self, wxPoint* pt)
{
    return self->FindItemAtPoint(*pt);
}

extern "C" WXEXPORT
wxGBSizerItem* wxGridBagSizer_FindItemWithData(wxGridBagSizer* self, wxObject* userData)
{
    return self->FindItemWithData(userData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_CheckForIntersectionItem(wxGridBagSizer* self, wxGBSizerItem* item, wxGBSizerItem* excludeItem)
{
    return self->CheckForIntersection(item, excludeItem)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxGridBagSizer_CheckForIntersectionPos(wxGridBagSizer* self, wxGBPosition* pos, wxGBSpan* span, wxGBSizerItem* excludeItem)
{
    return self->CheckForIntersection(*pos, *span, excludeItem)?1:0;
}

//-----------------------------------------------------------------------------
// wxGBPosition

extern "C" WXEXPORT
wxGBPosition* wxGBPosition_ctor()
{
    return new wxGBPosition();
}

extern "C" WXEXPORT
wxGBPosition* wxGBPosition_ctorPos(int row, int col)
{
    return new wxGBPosition(row, col);
}

extern "C" WXEXPORT
int wxGBPosition_GetRow(wxGBPosition* self)
{
    return self->GetRow();
}

extern "C" WXEXPORT
int wxGBPosition_GetCol(wxGBPosition* self)
{
    return self->GetCol();
}

extern "C" WXEXPORT
void wxGBPosition_SetRow(wxGBPosition* self, int row)
{
    self->SetRow(row);
}

extern "C" WXEXPORT
void wxGBPosition_SetCol(wxGBPosition* self, int col)
{
    self->SetCol(col);
}

//-----------------------------------------------------------------------------

