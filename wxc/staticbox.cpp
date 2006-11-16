//-----------------------------------------------------------------------------
// wxD - staticbox.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - staticbox.cxx
//
// The wxStaticBox proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/statbox.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _StaticBox : public wxStaticBox
{
public:
    DECLARE_OBJECTDELETED(_StaticBox)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStaticBox* wxStaticBox_ctor()
{
    return new _StaticBox();
}

extern "C" WXEXPORT
void wxStaticBox_dtor(wxStaticBox* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStaticBox_Create(wxStaticBox* self, wxWindow* parent, wxWindowID id,
                        dstr label,
                        const wxPoint* pos, const wxSize* size,
                        long style, dstr name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (name.data==NULL)
        name = dstr("staticBox");

    return self->Create(parent, id, wxString(label.data, wxConvUTF8, label.length),
                        *pos, *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------
