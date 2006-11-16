//-----------------------------------------------------------------------------
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
wxMenuBase* wxMenuBase_ctor1(const char* title, long style)
{
	return new _MenuBase(wxString(title, wxConvUTF8), style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuBase* wxMenuBase_ctor2(long style)
{
	return new _MenuBase(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Append(wxMenuBase* self, int id, const char* item, const char* helpString, wxItemKind kind)
{
	return self->Append(id, wxString(item, wxConvUTF8), wxString(helpString, wxConvUTF8), kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendSeparator(wxMenuBase* self)
{
	return self->AppendSeparator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendCheckItem(wxMenuBase* self, int itemid, const char* text, const char* help)
{
	return self->AppendCheckItem(itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendRadioItem(wxMenuBase* self, int itemid, const char* text, const char* help)
{
	return self->AppendRadioItem(itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_AppendSubMenu(wxMenuBase* self, int id, const char* item, wxMenu* subMenu, const char* helpString)
{
	return self->Append(id, wxString(item, wxConvUTF8), subMenu, wxString(helpString, wxConvUTF8));
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
wxMenuItem* wxMenuBase_Insert2(wxMenuBase* self, size_t pos, int itemid, const char* text, const char* help, wxItemKind kind)
{
	return self->Insert(pos, itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8), kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertSeparator(wxMenuBase* self, size_t pos)
{
	return self->InsertSeparator(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertCheckItem(wxMenuBase* self, size_t pos, int itemid, const char* text, const char* help)
{
	return self->InsertCheckItem(pos, itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertRadioItem(wxMenuBase* self, size_t pos, int itemid, const char* text, const char* help)
{
	return self->InsertRadioItem(pos, itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_InsertSubMenu(wxMenuBase* self, size_t pos, int itemid, const char* text, wxMenu* submenu, const char* help)
{
	return self->Insert(pos, itemid,  wxString(text, wxConvUTF8), submenu, wxString(help, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Prepend(wxMenuBase* self, wxMenuItem* item)
{
	return self->Prepend(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_Prepend2(wxMenuBase* self, int itemid, const char* text, const char* help, wxItemKind kind)
{
	return self->Prepend(itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8), kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependSeparator(wxMenuBase* self)
{
	return self->PrependSeparator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependCheckItem(wxMenuBase* self, int itemid, const char* text, const char* help)
{
	return self->PrependCheckItem(itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependRadioItem(wxMenuBase* self, int itemid, const char* text, const char* help)
{
	return self->PrependRadioItem(itemid, wxString(text, wxConvUTF8), wxString(help, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBase_PrependSubMenu(wxMenuBase* self, int itemid, const char* text, wxMenu* submenu, const char* help)
{
	return self->Prepend(itemid, wxString(text, wxConvUTF8), submenu, wxString(help, wxConvUTF8));
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
bool wxMenuBase_Delete(wxMenuBase* self, int itemid)
{
	return self->Delete(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBase_Delete2(wxMenuBase* self, wxMenuItem* item)
{
	return self->Delete(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBase_Destroy(wxMenuBase* self, int itemid)
{
	return self->Destroy(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBase_Destroy2(wxMenuBase* self, wxMenuItem* item)
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
int wxMenuBase_FindItem(wxMenuBase* self, const char* item)
{
	return self->FindItem(wxString(item, wxConvUTF8));
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
void wxMenuBase_Enable(wxMenuBase* self, int itemid, bool enable)
{
	self->Enable(itemid, enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBase_IsEnabled(wxMenuBase* self, int itemid)
{
	return self->IsEnabled(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_Check(wxMenuBase* self, int itemid, bool check)
{
    self->Check(itemid, check);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBase_IsChecked(wxMenuBase* self, int itemid)
{
	return self->IsChecked(itemid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetLabel(wxMenuBase* self, int itemid, const char* label)
{
	self->SetLabel(itemid, wxString(label, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxMenuBase_GetLabel(wxMenuBase* self, int itemid)
{
	return new wxString(self->GetLabel(itemid));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetHelpString(wxMenuBase* self, int itemid, const char* helpString)
{
	self->SetHelpString(itemid, wxString(helpString, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxMenuBase_GetHelpString(wxMenuBase* self, int itemid)
{
	return new wxString(self->GetHelpString(itemid));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBase_SetTitle(wxMenuBase* self, const char* title)
{
	self->SetTitle(wxString(title, wxConvUTF8));
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
bool wxMenuBase_IsAttached(wxMenuBase* self)
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
bool wxMenuBase_SendEvent(wxMenuBase* self, int itemid, int checked)
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
wxMenu* wxMenu_ctor(const char* titel, long style)
{
	return new _Menu(wxString(titel, wxConvUTF8), style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenu_ctor2(long style)
{
	return new _Menu(style);
}


