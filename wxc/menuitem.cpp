//-----------------------------------------------------------------------------
// wxD - menu.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - menu.cxx
//
// The wxMenu proxy interface.
//
// Written by Achim Breunig(achim.breunig@web.de)
// (C) 2003 by Achim Breunig
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuItem_ctor(wxMenu* parentMenu, int id, dstr text, dstr help, wxItemKind kind, wxMenu* subMenu)
{
    return new wxMenuItem(parentMenu, id, wxString(text.data, wxConvUTF8, text.length), wxString(help.data, wxConvUTF8, help.length), kind, subMenu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenuItem_GetMenu(wxMenuItem* self)
{
    return self->GetMenu();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetMenu(wxMenuItem* self, wxMenu* menu)
{
    self->SetMenu(menu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetId(wxMenuItem* self, int id)
{
    self->SetId(id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMenuItem_GetId(wxMenuItem* self)
{
    return self->GetId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuItem_IsSeparator(wxMenuItem* self)
{
    return self->IsSeparator()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetText(wxMenuItem* self, dstr str)
{
    self->SetText(wxString(str.data, wxConvUTF8, str.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxMenuItem_GetLabel(wxMenuItem* self)
{
    return dstr(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxMenuItem_GetText(wxMenuItem* self)
{
    return dstr(self->GetText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxMenuItem_GetLabelFromText(wxMenuItem* self, dstr text)
{
    return dstr(self->GetLabelFromText(wxString(text.data, wxConvUTF8, text.length)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxItemKind wxMenuItem_GetKind(wxMenuItem* self)
{
    return self->GetKind();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetCheckable(wxMenuItem* self, bool checkable)
{
    self->SetCheckable(checkable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuItem_IsCheckable(wxMenuItem* self)
{
    return self->IsCheckable()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuItem_IsSubMenu(wxMenuItem* self)
{
    return self->IsSubMenu()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetSubMenu(wxMenuItem* self, wxMenu* menu)
{
    self->SetSubMenu(menu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxMenuItem_GetSubMenu(wxMenuItem* self)
{
    return self->GetSubMenu();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_Enable(wxMenuItem* self, bool enable)
{
    self->Enable(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuItem_IsEnabled(wxMenuItem* self)
{
    return self->IsEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_Check(wxMenuItem* self, bool check)
{
    self->Check(check);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMenuItem_IsChecked(wxMenuItem* self)
{
    return self->IsChecked()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_Toggle(wxMenuItem* self)
{
    self->Toggle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetHelp(wxMenuItem* self, dstr str)
{
    self->SetHelp(wxString(str.data, wxConvUTF8, str.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxMenuItem_GetHelp(wxMenuItem* self)
{
    return dstr(self->GetHelp());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxAcceleratorEntry* wxMenuItem_GetAccel(wxMenuItem* self)
{
    return self->GetAccel();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetAccel(wxMenuItem* self, wxAcceleratorEntry* accel)
{
    self->SetAccel(accel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetName(wxMenuItem* self, dstr str)
{
    self->SetText(wxString(str.data, wxConvUTF8, str.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstr wxMenuItem_GetName(wxMenuItem* self)
{
    return dstr(self->GetText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuItem_NewCheck(wxMenu* parentMenu, int id, dstr text, dstr help, bool isCheckable, wxMenu* subMenu)
{
    return wxMenuItem::New(parentMenu, id, wxString(text.data, wxConvUTF8, text.length), wxString(help.data, wxConvUTF8, help.length), isCheckable, subMenu);
}

extern "C" WXEXPORT
wxMenuItem* wxMenuItem_New(wxMenu* parentMenu, int id, dstr text, dstr help, wxItemKind kind, wxMenu* subMenu)
{
    return wxMenuItem::New(parentMenu, id, wxString(text.data, wxConvUTF8, text.length), wxString(help.data, wxConvUTF8, help.length), kind, subMenu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetBitmap(wxMenuItem* self, wxBitmap* bitmap)
{
    self->SetBitmap(*bitmap);
}

extern "C" WXEXPORT
const wxBitmap* wxMenuItem_GetBitmap(wxMenuItem* self)
{
    return &(self->GetBitmap());
}

//-----------------------------------------------------------------------------
