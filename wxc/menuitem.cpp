//-----------------------------------------------------------------------------
// wxD - menu.cpp
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
wxMenuItem* wxMenuItem_ctor(wxMenu* parentMenu, int id, wxc_string text, wxc_string help, wxItemKind kind, wxMenu* subMenu)
{
    return new wxMenuItem(parentMenu, id, wxstr(text), wxstr(help), kind, subMenu);
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
wxc_bool wxMenuItem_IsSeparator(wxMenuItem* self)
{
    return self->IsSeparator()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetText(wxMenuItem* self, wxc_string str)
{
    self->SetText(wxstr(str));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuItem_GetLabel(wxMenuItem* self)
{
    return dstr_ret(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuItem_GetText(wxMenuItem* self)
{
    return dstr_ret(self->GetText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuItem_GetLabelFromText(wxMenuItem* self, wxc_string text)
{
    return dstr_ret(self->GetLabelFromText(wxstr(text)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxItemKind wxMenuItem_GetKind(wxMenuItem* self)
{
    return self->GetKind();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_SetCheckable(wxMenuItem* self, wxc_bool checkable)
{
    self->SetCheckable(checkable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuItem_IsCheckable(wxMenuItem* self)
{
    return self->IsCheckable()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuItem_IsSubMenu(wxMenuItem* self)
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
void wxMenuItem_Enable(wxMenuItem* self, wxc_bool enable)
{
    self->Enable(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuItem_IsEnabled(wxMenuItem* self)
{
    return self->IsEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMenuItem_Check(wxMenuItem* self, wxc_bool check)
{
    self->Check(check);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMenuItem_IsChecked(wxMenuItem* self)
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
void wxMenuItem_SetHelp(wxMenuItem* self, wxc_string str)
{
    self->SetHelp(wxstr(str));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuItem_GetHelp(wxMenuItem* self)
{
    return dstr_ret(self->GetHelp());
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
void wxMenuItem_SetName(wxMenuItem* self, wxc_string str)
{
    self->SetText(wxstr(str));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxMenuItem_GetName(wxMenuItem* self)
{
    return dstr_ret(self->GetText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxMenuItem_NewCheck(wxMenu* parentMenu, int id, wxc_string text, wxc_string help, wxc_bool isCheckable, wxMenu* subMenu)
{
    return wxMenuItem::New(parentMenu, id, wxstr(text), wxstr(help), isCheckable, subMenu);
}

extern "C" WXEXPORT
wxMenuItem* wxMenuItem_New(wxMenu* parentMenu, int id, wxc_string text, wxc_string help, wxItemKind kind, wxMenu* subMenu)
{
    return wxMenuItem::New(parentMenu, id, wxstr(text), wxstr(help), kind, subMenu);
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
