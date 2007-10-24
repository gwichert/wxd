//-----------------------------------------------------------------------------
// wxD - flexgridsizer.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - flexgridsizer.cxx
//
// The wxFlexGridSizer proxy interface
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
wxFlexGridSizer* wxFlexGridSizer_ctor(int rows, int cols, int vgap, int hgap)
{
	return new wxFlexGridSizer(rows, cols, vgap, hgap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_dtor(wxFlexGridSizer* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_RecalcSizes(wxFlexGridSizer* self)
{
	self->RecalcSizes();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_CalcMin(wxFlexGridSizer* self, wxSize* size)
{
	*size = self->CalcMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_AddGrowableRow(wxFlexGridSizer* self, size_t idx)
{
	self->AddGrowableRow(idx);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_RemoveGrowableRow(wxFlexGridSizer* self, size_t idx)
{
	self->RemoveGrowableRow(idx);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_AddGrowableCol(wxFlexGridSizer* self, size_t idx)
{
	self->AddGrowableCol(idx);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_RemoveGrowableCol(wxFlexGridSizer* self, size_t idx)
{
	self->RemoveGrowableCol(idx);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFlexGridSizer_GetFlexibleDirection(wxFlexGridSizer* self)
{
  return self->GetFlexibleDirection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_SetFlexibleDirection(wxFlexGridSizer* self, int direction)
{
  self->SetFlexibleDirection(direction);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFlexGridSizer_SetNonFlexibleGrowMode(wxFlexGridSizer* self, 
					    wxFlexSizerGrowMode mode)
{
  self->SetNonFlexibleGrowMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFlexSizerGrowMode wxFlexGridSizer_GetNonFlexibleGrowMode(wxFlexGridSizer* self)
{
  return self->GetNonFlexibleGrowMode();
}

//-----------------------------------------------------------------------------
