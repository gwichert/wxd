//-----------------------------------------------------------------------------
// wxD - listbook.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - listbook.cxx
//
// The wxListbook proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/listbook.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Listbook : public wxListbook
{
public:
    DECLARE_OBJECTDELETED(_Listbook)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxListbook* wxListbook_ctor()
{
	return new _Listbook();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_Create(wxListbook *self, wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("listbook");

	return self->Create(parent, id, *pos, *size, style, wxstr(name))?1:0;
}
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListbook_GetSelection(wxListbook* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_SetPageText(wxListbook* self, size_t n, wxc_string strText)
{
	return self->SetPageText(n, wxstr(strText))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxListbook_GetPageText(wxListbook* self, size_t n)
{
	return dstr_ret(self->GetPageText(n));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListbook_GetPageImage(wxListbook* self, size_t n)
{
	return self->GetPageImage(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_SetPageImage(wxListbook* self, size_t n, int imageId)
{
	return self->SetPageImage(n, imageId)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListbook_CalcSizeFromPage(wxListbook* self, const wxSize* sizePage, wxSize* outSize)
{
	*outSize = self->CalcSizeFromPage(*sizePage);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_InsertPage(wxListbook* self, size_t n, wxWindow* page, wxc_string text, wxc_bool bSelect, int imageId)
{
	return self->InsertPage(n, page, wxstr(text), bSelect, imageId)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListbook_SetSelection(wxListbook* self, size_t n)
{
	return self->SetSelection(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListbook_SetImageList(wxListbook* self, wxImageList* imageList)
{
	self->SetImageList(imageList);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_IsVertical(wxListbook* self)
{
	return self->IsVertical()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListbook_GetPageCount(wxListbook* self)
{
	return self->GetPageCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxListbook_GetPage(wxListbook* self, size_t n)
{
	return self->GetPage(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListbook_AssignImageList(wxListbook* self, wxImageList* imageList)
{
	self->AssignImageList(imageList);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageList* wxListbook_GetImageList(wxListbook* self)
{
	return self->GetImageList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListbook_SetPageSize(wxListbook* self, const wxSize* size)
{
	self->SetPageSize(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_DeletePage(wxListbook* self, int nPage)
{
	return self->DeletePage(nPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_RemovePage(wxListbook* self, int nPage)
{
	return self->RemovePage(nPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_DeleteAllPages(wxListbook* self)
{
	return self->DeleteAllPages()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListbook_AddPage(wxListbook* self, wxWindow* page, wxc_string text, wxc_bool bselect, int imageId)
{
	return self->AddPage(page, wxstr(text), bselect, imageId)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListbook_AdvanceSelection(wxListbook* self, wxc_bool forward)
{
	self->AdvanceSelection(forward);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxListbookEvent* wxListbookEvent_ctor(wxEventType commandType, int id, int nSel, int nOldSel)
{
    return new wxListbookEvent(commandType, id, nSel, nOldSel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListbookEvent_GetSelection(wxListbookEvent* self)
{
    return self->GetSelection();
}

extern "C" WXEXPORT
void wxListbookEvent_SetSelection(wxListbookEvent* self, int nSel)
{
    self->SetSelection(nSel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListbookEvent_GetOldSelection(wxListbookEvent* self)
{
    return self->GetOldSelection();
}

extern "C" WXEXPORT
void wxListbookEvent_SetOldSelection(wxListbookEvent* self, int nOldSel)
{
    self->SetOldSelection(nOldSel);
}

extern "C" WXEXPORT
void wxListbookEvent_Veto(wxListbookEvent* self)
{
    self->Veto();
}

extern "C" WXEXPORT
void wxListbookEvent_Allow(wxListbookEvent* self)
{
    self->Allow();
}

extern "C" WXEXPORT
wxc_bool wxListbookEvent_IsAllowed(wxListbookEvent* self)
{
    return self->IsAllowed()?1:0;
}

extern "C" WXEXPORT int wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGED()       { return wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_LISTBOOK_PAGE_CHANGING()      { return wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING; }

