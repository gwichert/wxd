//-----------------------------------------------------------------------------
// wxD - notebook.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - notebook.cxx
//
// The wxNotebook proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/notebook.h>
#include "local_events.h"

//-----------------------------------------------------------------------------
// The proxy class

class _Notebook : public wxNotebook
{
public:
	DECLARE_OBJECTDELETED(_Notebook)

#include "control.inc"
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxNotebook* wxNotebook_ctor()
{
	return new _Notebook();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_AddPage(wxNotebook* self, wxNotebookPage* page, wxc_string text, wxc_bool select, int imageId)
{
	return self->AddPage(page, wxstr(text), select, imageId)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_Create(wxNotebook* self, wxWindow* parent, int id, const wxPoint* pos,
                       const wxSize* size, long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("notebook");

	return self->Create(parent, id, *pos, *size, style, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebook_SetImageList(wxNotebookBase* self, wxImageList* imageList)
{
	self->SetImageList(imageList);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebook_GetPageCount(wxNotebook* self)
{
	return self->GetPageCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxNotebookPage* wxNotebook_GetPage(wxNotebook* self, int nPage)
{
	return self->GetPage(nPage);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebook_GetSelection(wxNotebook* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_SetPageText(wxNotebook* self, int nPage, wxc_string strText)
{
	return self->SetPageText(nPage, wxstr(strText))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxNotebook_GetPageText(wxNotebook* self, int nPage)
{
	return new wxString(self->GetPageText(nPage).c_str());;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebook_AssignImageList(wxNotebook* self, wxImageList* imageList)
{
	self->AssignImageList(imageList);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageList* wxNotebook_GetImageList(wxNotebook* self)
{
	return self->GetImageList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebook_GetPageImage(wxNotebook* self, int nPage)
{
	return self->GetPageImage(nPage);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_SetPageImage(wxNotebook* self, int nPage, int nImage)
{
	return self->SetPageImage(nPage, nImage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebook_GetRowCount(wxNotebook* self)
{
	return self->GetRowCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebook_SetPageSize(wxNotebook* self, const wxSize* size)
{
	self->SetPageSize(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebook_SetPadding(wxNotebook* self, const wxSize* padding)
{
	self->SetPadding(*padding);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebook_SetTabSize(wxNotebook* self, const wxSize* sz)
{
	self->SetTabSize(*sz);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_DeletePage(wxNotebook* self, int nPage)
{
	return self->DeletePage(nPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_RemovePage(wxNotebook* self, int nPage)
{
	return self->RemovePage(nPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_DeleteAllPages(wxNotebook* self)
{
	return self->DeleteAllPages()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxNotebook_InsertPage(wxNotebook* self, int nPage, wxNotebookPage *pPage, wxc_string strText, wxc_bool bSelect, int imageId)
{
	return self->InsertPage(nPage, pPage, wxstr(strText), bSelect, imageId)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebook_SetSelection(wxNotebook* self, int nPage)
{
	return self->SetSelection(nPage);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebook_AdvanceSelection(wxNotebook* self, wxc_bool forward)
{
	self->AdvanceSelection(forward);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxNotebookEvent* wxNotebookEvent_ctor(wxEventType commandType, int id, int nSel, int nOldSel)
{
    return new wxNotebookEvent(commandType, id, nSel, nOldSel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebookEvent_GetSelection(wxNotebookEvent* self)
{
    return self->GetSelection();
}

extern "C" WXEXPORT
void wxNotebookEvent_SetSelection(wxNotebookEvent* self, int nSel)
{
    self->SetSelection(nSel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebookEvent_GetOldSelection(wxNotebookEvent* self)
{
    return self->GetOldSelection();
}

extern "C" WXEXPORT
void wxNotebookEvent_SetOldSelection(wxNotebookEvent* self, int nOldSel)
{
    self->SetOldSelection(nOldSel);
}

extern "C" WXEXPORT
void wxNotebookEvent_Veto(wxNotebookEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void wxNotebookEvent_Allow(wxNotebookEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
wxc_bool wxNotebookEvent_IsAllowed(wxNotebookEvent* self)
{
    return self->IsAllowed()?1:0;
}

extern "C" WXEXPORT int wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGED()       { return wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_NOTEBOOK_PAGE_CHANGING()      { return wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING; }

