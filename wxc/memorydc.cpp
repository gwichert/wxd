//-----------------------------------------------------------------------------
// wx.NET - memorydc.cxx
// 
// The wxBufferedDC and wxMemoryDC proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/dcbuffer.h>
#include <wx/dcmemory.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMemoryDC* wxMemoryDC_ctor()
{
	return new wxMemoryDC();
}

extern "C" WXEXPORT
wxMemoryDC* wxMemoryDC_ctorByDC(wxDC *dc)
{
	return new wxMemoryDC(dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMemoryDC_SelectObject(wxMemoryDC* self, const wxBitmap* bitmap)
{
	self->SelectObject(*bitmap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBufferedDC* wxBufferedDC_ctor()
{
	return new wxBufferedDC();
}

extern "C" WXEXPORT
wxBufferedDC* wxBufferedDC_ctorByBitmap(wxDC *dc, const wxBitmap *buffer)
{
	return new wxBufferedDC(dc, *buffer);
}

extern "C" WXEXPORT
wxBufferedDC* wxBufferedDC_ctorBySize(wxDC *dc, const wxSize *area)
{
	return new wxBufferedDC(dc, *area);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBufferedDC_InitByBitmap(wxBufferedDC* self, wxDC *dc, wxBitmap *bitmap)
{
	self->Init(dc, *bitmap);
}

extern "C" WXEXPORT
void wxBufferedDC_InitBySize(wxBufferedDC* self, wxDC *dc, wxSize *area)
{
	self->Init(dc, *area);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBufferedDC_UnMask(wxBufferedDC* self)
{
	self->UnMask();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBufferedPaintDC* wxBufferedPaintDC_ctor(wxWindow *window, wxBitmap *buffer)
{
	if (buffer == NULL)
		buffer = &wxNullBitmap;

	return new wxBufferedPaintDC(window, *buffer);
}

//-----------------------------------------------------------------------------
