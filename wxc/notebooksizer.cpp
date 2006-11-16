//-----------------------------------------------------------------------------
// wxD - notebooksizer.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - notebooksizer.cxx
//
// The wxNotebookSizer proxy interface
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
wxNotebookSizer* wxNotebookSizer_ctor(wxNotebook *nb)
{
	return new wxNotebookSizer(nb);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebookSizer_RecalcSizes(wxNotebookSizer* self)
{
	self->RecalcSizes();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebookSizer_CalcMin(wxNotebookSizer* self, wxSize* size)
{
	*size = self->CalcMin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxNotebook* wxNotebookSizer_GetNotebook(wxNotebookSizer* self)
{
	return self->GetNotebook();
}

//-----------------------------------------------------------------------------
