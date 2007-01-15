//-----------------------------------------------------------------------------
// wxD - gdicmn.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - gdicmn.cxx
// 
// The GDI common classes proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/gdicmn.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetRedPen()
{
	return wxRED_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetCyanPen()
{
	return wxCYAN_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetGreenPen()
{
	return wxGREEN_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetBlackPen()
{
	return wxBLACK_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetWhitePen()
{
	return wxWHITE_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetTransparentPen()
{
	return wxTRANSPARENT_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetBlackDashedPen()
{
	return wxBLACK_DASHED_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetGreyPen()
{
	return wxGREY_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetMediumGreyPen()
{
	return wxMEDIUM_GREY_PEN;
}

extern "C" WXEXPORT
const wxPen* wxGDIObj_GetLightGreyPen()
{
	return wxLIGHT_GREY_PEN;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBitmap* wxNullBitmap_Get()
{
	return new wxBitmap(wxNullBitmap);
}

extern "C" WXEXPORT
wxIcon* wxNullIcon_Get()
{
	return new wxIcon(wxNullIcon);
}

extern "C" WXEXPORT
wxCursor* wxNullCursor_Get()
{
	return new wxCursor(wxNullCursor);
}

extern "C" WXEXPORT
wxPen* wxNullPen_Get()
{
	return new wxPen(wxNullPen);
}

extern "C" WXEXPORT
wxBrush* wxNullBrush_Get()
{
	return new wxBrush(wxNullBrush);
}

extern "C" WXEXPORT
wxPalette* wxNullPalette_Get()
{
	return new wxPalette(wxNullPalette);
}

extern "C" WXEXPORT
wxFont* wxNullFont_Get()
{
	return new wxFont(wxNullFont);
}

extern "C" WXEXPORT
wxColour* wxNullColour_Get()
{
	return new wxColour(wxNullColour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxBrush* wxBLUE_BRUSH_Get()
{
	return wxBLUE_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxGREEN_BRUSH_Get()
{
	return wxGREEN_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxWHITE_BRUSH_Get()
{
	return wxWHITE_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxBLACK_BRUSH_Get()
{
	return wxBLACK_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxGREY_BRUSH_Get()
{
	return wxGREY_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxMEDIUM_GREY_BRUSH_Get()
{
	return wxMEDIUM_GREY_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxLIGHT_GREY_BRUSH_Get()
{
	return wxLIGHT_GREY_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxTRANSPARENT_BRUSH_Get()
{
	return wxTRANSPARENT_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxCYAN_BRUSH_Get()
{
	return wxCYAN_BRUSH;
}

extern "C" WXEXPORT
const wxBrush* wxRED_BRUSH_Get()
{
	return wxRED_BRUSH;
}

//-----------------------------------------------------------------------------
// wxColourDataBase

extern "C" WXEXPORT
wxColourDatabase* wxColourDatabase_ctor()
{
	return new wxColourDatabase();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColourDataBase_dtor(wxColourDatabase* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxColourDatabase_Find(wxColourDatabase* self, wxc_string name)
{
	return new wxColour(self->Find(wxstr(name)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxColourDatabase_FindName(wxColourDatabase* self, wxColour* colour)
{
	return dstr_ret(self->FindName(*colour));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColourDatabase_AddColour(wxColourDatabase* self, wxc_string name, wxColour* colour)
{
	self->AddColour(wxstr(name), *colour);
}

//-----------------------------------------------------------------------------
// wxPenList

extern "C" WXEXPORT
wxPenList* wxPenList_ctor()
{
	return new wxPenList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPenList_AddPen(wxPenList* self, wxPen* pen)
{
#if wxABI_VERSION < 20700
	self->AddPen(pen);
#else
	self->Append(pen);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPenList_RemovePen(wxPenList* self, wxPen* pen)
{
#if wxABI_VERSION < 20700
	self->RemovePen(pen);
#else
	self->DeleteObject(pen);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPen* wxPenList_FindOrCreatePen(wxPenList* self, wxColour* colour, int width, int style)
{
	return self->FindOrCreatePen(*colour, width, style);
}

//-----------------------------------------------------------------------------
// wxBrushList

extern "C" WXEXPORT
wxBrushList* wxBrushList_ctor()
{
	return new wxBrushList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBrushList_AddBrush(wxBrushList* self, wxBrush* brush)
{
#if wxABI_VERSION < 20700
	self->AddBrush(brush);
#else
	self->Append(brush);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBrushList_RemoveBrush(wxBrushList* self, wxBrush* brush)
{
#if wxABI_VERSION < 20700
	self->RemoveBrush(brush);
#else
	self->DeleteObject(brush);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBrush* wxBrushList_FindOrCreateBrush(wxBrushList* self, wxColour* colour, int style)
{
	return self->FindOrCreateBrush(*colour, style);
}

//-----------------------------------------------------------------------------
// wxFontList

extern "C" WXEXPORT
wxFontList* wxFontList_ctor()
{
	return new wxFontList();
}

extern "C" WXEXPORT
void wxFontList_AddFont(wxFontList* self, wxFont* font)
{
#if wxABI_VERSION < 20700
	self->AddFont(font);
#else
	self->Append(font);
#endif
}

extern "C" WXEXPORT
void wxFontList_RemoveFont(wxFontList* self, wxFont* font)
{
#if wxABI_VERSION < 20700
	self->RemoveFont(font);
#else
	self->DeleteObject(font);
#endif
}

extern "C" WXEXPORT
wxFont* wxFontList_FindOrCreateFont(wxFontList* self, int pointSize, int family, int style, int weight,
                             wxc_bool underline,
                             wxc_string face,
                             wxFontEncoding encoding)
{
	return self->FindOrCreateFont(pointSize, family, style, weight, underline, wxstr(face), encoding);
}

#if wxABI_VERSION < 20700
//-----------------------------------------------------------------------------
// wxBitmapList

extern "C" WXEXPORT
wxBitmapList* wxBitmapList_ctor()
{
	return new wxBitmapList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapList_AddBitmap(wxBitmapList* self, wxBitmap* bitmap)
{
	self->AddBitmap(bitmap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBitmapList_RemoveBitmap(wxBitmapList* self, wxBitmap* bitmap)
{
	self->RemoveBitmap(bitmap);
}

#else
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxList* wxBitmapList_ctor()
{
	return new wxList();
}

extern "C" WXEXPORT
void wxBitmapList_AddBitmap(wxList* self, wxBitmap* bitmap)
{
	self->Append(bitmap);
}

extern "C" WXEXPORT
void wxBitmapList_RemoveBitmap(wxList* self, wxBitmap* bitmap)
{
	self->DeleteObject(bitmap);
}

#endif // wxABI_VERSION

//-----------------------------------------------------------------------------
// Stock cursors types

extern "C" WXEXPORT
const wxCursor* wxSTANDARD_CURSOR_Get()
{
	return wxSTANDARD_CURSOR;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxCursor* wxHOURGLASS_CURSOR_Get()
{
	return wxHOURGLASS_CURSOR;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxCursor* wxCROSS_CURSOR_Get()
{
	return wxCROSS_CURSOR;
}

