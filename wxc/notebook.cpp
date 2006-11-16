//-----------------------------------------------------------------------------
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
bool wxNotebook_AddPage(wxNotebook* self, wxNotebookPage* page, const char* text, bool select, int imageId)
{
	return self->AddPage(page, wxString(text, wxConvUTF8), select, imageId)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxNotebook_Create(wxNotebook* self, wxWindow* parent, int id, const wxPoint* pos,
                       const wxSize* size, long style, const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name == NULL)
		name = "notebook";

	return self->Create(parent, id, *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
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
bool wxNotebook_SetPageText(wxNotebook* self, int nPage, const char* strText)
{
	return self->SetPageText(nPage, wxString(strText, wxConvUTF8))?1:0;
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
bool wxNotebook_SetPageImage(wxNotebook* self, int nPage, int nImage)
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
bool wxNotebook_DeletePage(wxNotebook* self, int nPage)
{
	return self->DeletePage(nPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxNotebook_RemovePage(wxNotebook* self, int nPage)
{
	return self->RemovePage(nPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxNotebook_DeleteAllPages(wxNotebook* self)
{
	return self->DeleteAllPages()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxNotebook_InsertPage(wxNotebook* self, int nPage, wxNotebookPage *pPage, const char* strText, bool bSelect, int imageId)
{
	return self->InsertPage(nPage, pPage, wxString(strText, wxConvUTF8), bSelect, imageId)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxNotebook_SetSelection(wxNotebook* self, int nPage)
{
	return self->SetSelection(nPage);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxNotebook_AdvanceSelection(wxNotebook* self, bool forward)
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
bool wxNotebookEvent_IsAllowed(wxNotebookEvent* self)
{
    return self->IsAllowed()?1:0;
}