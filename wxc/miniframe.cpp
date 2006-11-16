//-----------------------------------------------------------------------------
// wx.NET - miniframe.cxx
// 
// The wxMiniFrame proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/minifram.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _MiniFrame : public wxMiniFrame
{
public:
    DECLARE_OBJECTDELETED(_MiniFrame)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMiniFrame* wxMiniFrame_ctor()
{
    return new _MiniFrame();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMiniFrame_Create(wxMiniFrame* self, wxWindow* parent, wxWindowID id, char* title, const wxPoint* pos, const wxSize* size, int style, const char* name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (name == NULL)
        name = "miniFrame";

    return self->Create(parent, id, wxString(title, wxConvUTF8), *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------
