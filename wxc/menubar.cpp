//-----------------------------------------------------------------------------
// wxD - menubar.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - menubar.cxx
//
// The wxMenuBar proxy interface.
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

class _MenuBar : public wxMenuBar
{
public:
    _MenuBar()
    	: wxMenuBar() {}
	
    _MenuBar(long style)
    	: wxMenuBar(style) {}
	
    DECLARE_OBJECTDELETED(_MenuBar)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuBar* wxMenuBar_ctor()
{
	return new _MenuBar();
}

extern "C" WXEXPORT
wxMenuBar* wxMenuBar_ctor2(long style)
{
	return new _MenuBar(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBar_Append(wxMenuBar* self, wxMenu* menu, dstr title)
{
	return self->Append(menu, wxString(title.data, wxConvUTF8, title.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBar_Check(wxMenuBar* self, int id, bool check)
{
	self->Check(id, check);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBar_IsChecked(wxMenuBar* self, int id)
{
	return self->IsChecked(id)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBar_Insert(wxMenuBar* self, int pos, wxMenu* menu, dstr title)
{
    return self->Insert(pos, menu, wxString(title.data, wxConvUTF8, title.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuBar_FindItem(wxMenuBar* self, int id, wxMenu **menu)
{
    return self->FindItem(id, menu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
size_t wxMenuBar_GetMenuCount(wxMenuBar* self)
{
	return self->GetMenuCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenuBar_GetMenu(wxMenuBar* self, size_t pos)
{
	return self->GetMenu(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenuBar_Replace(wxMenuBar* self, int pos, wxMenu* menu, dstr title)
{
	return self->Replace(pos, menu, wxString(title.data, wxConvUTF8, title.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenuBar_Remove(wxMenuBar* self, int pos)
{
	return self->Remove(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBar_EnableTop(wxMenuBar* self, int pos, bool enable)
{
	self->EnableTop(pos, enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBar_Enable(wxMenuBar* self, int id, const bool enable)
{
	self->Enable(id, enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMenuBar_FindMenu(wxMenuBar* self, dstr title)
{
	return self->FindMenu(wxString(title.data, wxConvUTF8, title.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMenuBar_FindMenuItem(wxMenuBar* self, dstr menustring, dstr itemString)
{
	return self->FindMenuItem(wxString(menustring.data, wxConvUTF8, menustring.length), wxString(itemString.data, wxConvUTF8, itemString.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuBar_GetHelpString(wxMenuBar* self, int id)
{
	return dstr_ret(self->GetHelpString(id));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuBar_GetLabel(wxMenuBar* self, int id)
{
	return dstr_ret(self->GetLabel(id));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuBar_GetLabelTop(wxMenuBar* self, int pos)
{
	return dstr_ret(self->GetLabelTop(pos));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuBar_IsEnabled(wxMenuBar* self, int id)
{
	return self->IsEnabled(id)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBar_Refresh(wxMenuBar* self)
{
	self->Refresh();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBar_SetHelpString(wxMenuBar* self, int id, dstr helpstring)
{
	self->SetHelpString(id, wxString(helpstring.data, wxConvUTF8, helpstring.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBar_SetLabel(wxMenuBar* self, int id, dstr label)
{
	self->SetLabel(id, wxString(label.data, wxConvUTF8, label.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuBar_SetLabelTop(wxMenuBar* self, int pos, dstr label)
{
	self->SetLabelTop(pos, wxString(label.data, wxConvUTF8, label.length));
}
