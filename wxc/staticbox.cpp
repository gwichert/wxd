//-----------------------------------------------------------------------------
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
                        const char* label,
                        const wxPoint* pos, const wxSize* size,
                        long style, const char* name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (name == NULL)
        name = "staticBox";

    return self->Create(parent, id, wxString(label, wxConvUTF8),
                        *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------
