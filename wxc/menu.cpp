//-----------------------------------------------------------------------------
// wxD - menu.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - menu.cxx
//
// The wxMenu proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------
// wxMenuBase

class _MenuBase : public wxMenuBase
{
public:
	_MenuBase(const wxString& title, long style)
		: wxMenuBase(title, style) {}
		
	_MenuBase(long style)
		: wxMenuBase(style) {}
		
	DECLARE_OBJECTDELETED(_MenuBase)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuBase* wxMenuBase_ctor1(wxc_string title, long style)
{
	return new _MenuBase(wxstr(title), style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuBase* wxMenuBase_ctor2(long style)
{
	return new _MenuBase(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Append(wxMenuBase* self, int id, wxc_string item, wxc_string helpString, wxItemKind kind)
{
	return self->Append(id, wxstr(item), wxstr(helpString), kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendSeparator(wxMenuBase* self)
{
	return self->AppendSeparator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendCheckItem(wxMenuBase* self, int itemid, wxc_string text, wxc_string help)
{
	return self->AppendCheckItem(itemid, wxstr(text), wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendRadioItem(wxMenuBase* self, int itemid, wxc_string text, wxc_string help)
{
	return self->AppendRadioItem(itemid, wxstr(text), wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendSubMenu(wxMenuBase* self, int id, wxc_string item, wxMenu* subMenu, wxc_string helpString)
{
	return self->Append(id, wxstr(item), subMenu, wxstr(helpString));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendItem(wxMenuBase* self, wxMenuItem* item)
{
	return self->Append(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_Break(wxMenuBase* self)
{
	self->Break();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Insert(wxMenuBase* self, size_t pos, wxMenuItem* item)
{
	return self->Insert(pos, item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Insert2(wxMenuBase* self, size_t pos, int itemid, wxc_string text, wxc_string help, wxItemKind kind)
{
	return self->Insert(pos, itemid, wxstr(text), wxstr(help), kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertSeparator(wxMenuBase* self, size_t pos)
{
	return self->InsertSeparator(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertCheckItem(wxMenuBase* self, size_t pos, int itemid, wxc_string text, wxc_string help)
{
	return self->InsertCheckItem(pos, itemid, wxstr(text), wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertRadioItem(wxMenuBase* self, size_t pos, int itemid, wxc_string text, wxc_string help)
{
	return self->InsertRadioItem(pos, itemid, wxstr(text), wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertSubMenu(wxMenuBase* self, size_t pos, int itemid, wxc_string text, wxMenu* submenu, wxc_string help)
{
	return self->Insert(pos, itemid,  wxstr(text), submenu, wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Prepend(wxMenuBase* self, wxMenuItem* item)
{
	return self->Prepend(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Prepend2(wxMenuBase* self, int itemid, wxc_string text, wxc_string help, wxItemKind kind)
{
	return self->Prepend(itemid, wxstr(text), wxstr(help), kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependSeparator(wxMenuBase* self)
{
	return self->PrependSeparator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependCheckItem(wxMenuBase* self, int itemid, wxc_string text, wxc_string help)
{
	return self->PrependCheckItem(itemid, wxstr(text), wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependRadioItem(wxMenuBase* self, int itemid, wxc_string text, wxc_string help)
{
	return self->PrependRadioItem(itemid, wxstr(text), wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependSubMenu(wxMenuBase* self, int itemid, wxc_string text, wxMenu* submenu, wxc_string help)
{
	return self->Prepend(itemid, wxstr(text), submenu, wxstr(help));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Remove(wxMenuBase* self, int itemid)
{
	return self->Remove(itemid);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Remove2(wxMenuBase* self, wxMenuItem* item)
{
	return self->Remove(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_Delete(wxMenuBase* self, int itemid)
{
	return self->Delete(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_Delete2(wxMenuBase* self, wxMenuItem* item)
{
	return self->Delete(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_Destroy(wxMenuBase* self, int itemid)
{
	return self->Destroy(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_Destroy2(wxMenuBase* self, wxMenuItem* item)
{
	return self->Destroy(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMenuBase_GetMenuItemCount(wxMenuBase* self)
{
    return self->GetMenuItemCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_GetMenuItem(wxMenuBase* self,int index)
{
    return self->GetMenuItems().Item(index)->GetData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMenuBase_FindItem(wxMenuBase* self, wxc_string item)
{
	return self->FindItem(wxstr(item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_FindItem2(wxMenuBase* self, int itemid, wxMenu** menu)
{
	return self->FindItem(itemid, menu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_FindItemByPosition(wxMenuBase* self, size_t position)
{
	return self->FindItemByPosition(position);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_Enable(wxMenuBase* self, int itemid, wxc_bool enable)
{
	self->Enable(itemid, enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_IsEnabled(wxMenuBase* self, int itemid)
{
	return self->IsEnabled(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_Check(wxMenuBase* self, int itemid, wxc_bool check)
{
    self->Check(itemid, check);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_IsChecked(wxMenuBase* self, int itemid)
{
	return self->IsChecked(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetLabel(wxMenuBase* self, int itemid, wxc_string label)
{
	self->SetLabel(itemid, wxstr(label));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxMenuBase_GetLabel(wxMenuBase* self, int itemid)
{
	return new wxString(self->GetLabel(itemid));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetHelpString(wxMenuBase* self, int itemid, wxc_string helpString)
{
	self->SetHelpString(itemid, wxstr(helpString));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxMenuBase_GetHelpString(wxMenuBase* self, int itemid)
{
	return new wxString(self->GetHelpString(itemid));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetTitle(wxMenuBase* self, wxc_string title)
{
	self->SetTitle(wxstr(title));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxMenuBase_GetTitle(wxMenuBase* self)
{
	return new wxString(self->GetTitle());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetEventHandler(wxMenuBase* self, wxEvtHandler* handler)
{
	self->SetEventHandler(handler);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxEvtHandler* wxMenuBase_GetEventHandler(wxMenuBase* self)
{
	return self->GetEventHandler();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetInvokingWindow(wxMenuBase* self, wxWindow* win)
{
	self->SetInvokingWindow(win);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxMenuBase_GetInvokingWindow(wxMenuBase* self)
{
	return self->GetInvokingWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxMenuBase_GetStyle(wxMenuBase* self)
{
	return self->GetStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_UpdateUI(wxMenuBase* self, wxEvtHandler* source)
{
	self->UpdateUI(source);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuBar* wxMenuBase_GetMenuBar(wxMenuBase* self)
{
	return self->GetMenuBar();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_IsAttached(wxMenuBase* self)
{
	return self->IsAttached()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetParent(wxMenuBase* self, wxMenu* parent)
{
	self->SetParent(parent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenuBase_GetParent(wxMenuBase* self)
{
	return self->GetParent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_FindChildItem(wxMenuBase* self, int itemid, size_t *pos)
{
	return self->FindChildItem(itemid, pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_FindChildItem2(wxMenuBase* self, int itemid)
{
	return self->FindChildItem(itemid);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuBase_SendEvent(wxMenuBase* self, int itemid, int checked)
{
	return self->SendEvent(itemid, checked)?1:0;
}

//-----------------------------------------------------------------------------
// wxMenu

class _Menu : public wxMenu
{
public:
	_Menu(const wxString message, long style)
		: wxMenu(message, style) {}
		
	_Menu(long style)
		: wxMenu(style) {}
		
    DECLARE_OBJECTDELETED(_Menu)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenu_ctor(wxc_string titel, long style)
{
	return new _Menu(wxstr(titel), style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenu_ctor2(long style)
{
	return new _Menu(style);
}



