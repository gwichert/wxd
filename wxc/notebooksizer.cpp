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
#include <wx/notebook.h>

#if WXWIN_COMPATIBILITY_2_4
// NB: wxBookCtrlSizer and wxNotebookSizer are deprecated, they
//     don't do anything. wxBookCtrlBase::DoGetBestSize does the job now.

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
#else
extern "C" WXEXPORT
wxSizer* wxNotebookSizer_ctor(wxNotebook *nb)
{
	return nb->GetSizer();
}

extern "C" WXEXPORT
void wxNotebookSizer_RecalcSizes(wxObject* self)
{
}

extern "C" WXEXPORT
void wxNotebookSizer_CalcMin(wxObject* self, wxSize* size)
{
}

extern "C" WXEXPORT
wxNotebook* wxNotebookSizer_GetNotebook(wxSizer* self)
{
	return NULL;
}
#endif // WXWIN_COMPATIBILITY
