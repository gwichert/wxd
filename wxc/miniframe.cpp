//-----------------------------------------------------------------------------
// wxD - miniframe.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
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
bool wxMiniFrame_Create(wxMiniFrame* self, wxWindow* parent, wxWindowID id, dstr title, const wxPoint* pos, const wxSize* size, int style, dstr name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (name.data==NULL)
        name = dstr("miniFrame");

    return self->Create(parent, id, wxString(title.data, wxConvUTF8, title.length), *pos, *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

