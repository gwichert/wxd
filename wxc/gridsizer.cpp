//-----------------------------------------------------------------------------
// wxD - gridsizer.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - gridsizer.cxx
//
// The wxGridSizer proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/sizer.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxGridSizer* wxGridSizer_ctor(int rows, int cols, int vgap, int hgap)
{
	return new wxGridSizer(rows, cols, vgap, hgap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizer_RecalcSizes(wxGridSizer* self)
{
	self->RecalcSizes();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizer_CalcMin(wxGridSizer* self, wxSize* size)
{
	*size = self->CalcMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizer_SetCols(wxGridSizer* self, int cols)
{
	self->SetCols(cols);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizer_SetRows(wxGridSizer* self, int rows)
{
	self->SetRows(rows);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizer_SetVGap(wxGridSizer* self, int gap)
{
	self->SetVGap(gap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxGridSizer_SetHGap(wxGridSizer* self, int gap)
{
	self->SetHGap(gap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridSizer_GetCols(wxGridSizer* self)
{
	return self->GetCols();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridSizer_GetRows(wxGridSizer* self)
{
	return self->GetRows();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridSizer_GetVGap(wxGridSizer* self)
{
	return self->GetVGap();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxGridSizer_GetHGap(wxGridSizer* self)
{
	return self->GetHGap();
}

//-----------------------------------------------------------------------------
