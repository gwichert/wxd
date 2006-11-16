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
wxPen* wxGDIObj_GetRedPen()
{
	return wxRED_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetCyanPen()
{
	return wxCYAN_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetGreenPen()
{
	return wxGREEN_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetBlackPen()
{
	return wxBLACK_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetWhitePen()
{
	return wxWHITE_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetTransparentPen()
{
	return wxTRANSPARENT_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetBlackDashedPen()
{
	return wxBLACK_DASHED_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetGreyPen()
{
	return wxGREY_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetMediumGreyPen()
{
	return wxMEDIUM_GREY_PEN;
}

extern "C" WXEXPORT
wxPen* wxGDIObj_GetLightGreyPen()
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
wxBrush* wxBLUE_BRUSH_Get()
{
	return wxBLUE_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxGREEN_BRUSH_Get()
{
	return wxGREEN_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxWHITE_BRUSH_Get()
{
	return wxWHITE_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxBLACK_BRUSH_Get()
{
	return wxBLACK_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxGREY_BRUSH_Get()
{
	return wxGREY_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxMEDIUM_GREY_BRUSH_Get()
{
	return wxMEDIUM_GREY_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxLIGHT_GREY_BRUSH_Get()
{
	return wxLIGHT_GREY_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxTRANSPARENT_BRUSH_Get()
{
	return wxTRANSPARENT_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxCYAN_BRUSH_Get()
{
	return wxCYAN_BRUSH;
}

extern "C" WXEXPORT
wxBrush* wxRED_BRUSH_Get()
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
wxColour* wxColourDatabase_Find(wxColourDatabase* self, dstr name)
{
	return new wxColour(self->Find(wxString(name.data, wxConvUTF8, name.length)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxColourDatabase_FindName(wxColourDatabase* self, wxColour* colour)
{
	return dstr_ret(self->FindName(*colour));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColourDatabase_AddColour(wxColourDatabase* self, dstr name, wxColour* colour)
{
	self->AddColour(wxString(name.data, wxConvUTF8, name.length), *colour);
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
	self->AddPen(pen);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPenList_RemovePen(wxPenList* self, wxPen* pen)
{
	self->RemovePen(pen);
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
	self->AddBrush(brush);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBrushList_RemoveBrush(wxBrushList* self, wxBrush* brush)
{
	self->RemoveBrush(brush);
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
	self->AddFont(font);
}

extern "C" WXEXPORT
void wxFontList_RemoveFont(wxFontList* self, wxFont* font)
{
	self->RemoveFont(font);
}

extern "C" WXEXPORT
wxFont* wxFontList_FindOrCreateFont(wxFontList* self, int pointSize, int family, int style, int weight,
                             bool underline,
                             dstr face,
                             wxFontEncoding encoding)
{
	return self->FindOrCreateFont(pointSize, family, style, weight, underline, wxString(face.data, wxConvUTF8, face.length), encoding);
}

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

//-----------------------------------------------------------------------------
// Stock cursors types

extern "C" WXEXPORT
wxCursor* wxSTANDARD_CURSOR_Get()
{
	return wxSTANDARD_CURSOR;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCursor* wxHOURGLASS_CURSOR_Get()
{
	return wxHOURGLASS_CURSOR;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCursor* wxCROSS_CURSOR_Get()
{
	return wxCROSS_CURSOR;
}

