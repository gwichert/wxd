//-----------------------------------------------------------------------------
// wxD - tabctrl.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - tabctrl.cxx
// 
// The wxTabCtrl proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#ifdef __WXMSW__  

#include <wx/wx.h>
#include "common.h"
#include <wx/tabctrl.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _TabCtrl : public wxTabCtrl
{
public:
	_TabCtrl()
		: wxTabCtrl() {}
		
	_TabCtrl(wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxString& name)
		: wxTabCtrl(parent, id, pos, size, style, name) {}

	DECLARE_OBJECTDELETED(_TabCtrl)
};

extern "C" WXEXPORT
wxTabCtrl* wxTabCtrl_ctor()
{
	return new _TabCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTabCtrl* wxTabCtrl_ctor2(wxWindow *parent, wxWindowID id, const wxPoint* pos, const wxSize* size,
            long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("tabctrl");

	return new _TabCtrl(parent, id, *pos, *size, style, wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_Create(wxTabCtrl* self, wxWindow *parent, wxWindowID id, const wxPoint* pos, const wxSize* size,
            long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("tabctrl");

	return self->Create(parent, id, *pos, *size, style, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabCtrl_GetSelection(wxTabCtrl* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabCtrl_GetCurFocus(wxTabCtrl* self)
{
	return self->GetCurFocus();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageList* wxTabCtrl_GetImageList(wxTabCtrl* self)
{
	return self->GetImageList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabCtrl_GetItemCount(wxTabCtrl* self)
{
	return self->GetItemCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_GetItemRect(wxTabCtrl* self, int item, wxRect* rect)
{
	return self->GetItemRect(item, *rect)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabCtrl_GetRowCount(wxTabCtrl* self)
{
	return self->GetRowCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxTabCtrl_GetItemText(wxTabCtrl* self, int item)
{
	return new wxString(self->GetItemText(item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabCtrl_GetItemImage(wxTabCtrl* self, int item)
{
	return self->GetItemImage(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void* wxTabCtrl_GetItemData(wxTabCtrl* self, int item)
{
	return self->GetItemData(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabCtrl_SetSelection(wxTabCtrl* self, int item)
{
	return self->SetSelection(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTabCtrl_SetImageList(wxTabCtrl* self, wxImageList* imageList)
{
	self->SetImageList(imageList);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_SetItemText(wxTabCtrl* self, int item, wxc_string text)
{
	return self->SetItemText(item, wxstr(text))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_SetItemImage(wxTabCtrl* self, int item, int image)
{
	return self->SetItemImage(item, image)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_SetItemData(wxTabCtrl* self, int item, void* data)
{
	return self->SetItemData(item, data)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTabCtrl_SetItemSize(wxTabCtrl* self, const wxSize* size)
{
	self->SetItemSize(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTabCtrl_SetPadding(wxTabCtrl* self, const wxSize* padding)
{
	self->SetPadding(*padding);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_DeleteAllItems(wxTabCtrl* self)
{
	return self->DeleteAllItems()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_DeleteItem(wxTabCtrl* self, int item)
{
	return self->DeleteItem(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabCtrl_HitTest(wxTabCtrl* self, const wxPoint* pt, long* flags)
{
	return self->HitTest(*pt, *flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabCtrl_InsertItem(wxTabCtrl* self, int item, wxc_string text, int imageId, void* data)
{
	return self->InsertItem(item, wxstr(text), imageId, data)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTabEvent* wxTabEvent_ctor(wxEventType commandType, int id, int nSel, int nOldSel)
{
    return new wxTabEvent(commandType, id, nSel, nOldSel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabEvent_GetSelection(wxTabEvent* self)
{
    return self->GetSelection();
}

extern "C" WXEXPORT
void wxTabEvent_SetSelection(wxTabEvent* self, int nSel)
{
    self->SetSelection(nSel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTabEvent_GetOldSelection(wxTabEvent* self)
{
    return self->GetOldSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTabEvent_SetOldSelection(wxTabEvent* self, int nOldSel)
{
    self->SetOldSelection(nOldSel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTabEvent_Veto(wxTabEvent* self)
{
    self->Veto();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTabEvent_Allow(wxTabEvent* self)
{
    self->Allow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTabEvent_IsAllowed(wxTabEvent* self)
{
    return self->IsAllowed()?1:0;
}

extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TAB_SEL_CHANGED()		{ return wxEVT_COMMAND_TAB_SEL_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TAB_SEL_CHANGING()		{ return wxEVT_COMMAND_TAB_SEL_CHANGING; }

#endif
 
