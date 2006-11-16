//-----------------------------------------------------------------------------
// wx.NET - statictext.cxx
//
// The wxStaticText proxy interface.
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

class _StaticText : public wxStaticText
{
public:
    DECLARE_OBJECTDELETED(_StaticText)
#ifdef __WIN95__
    long MSWWindowProc(WXUINT nMsg, WXWPARAM wParam, WXLPARAM lParam);
#endif
};

//-----------------------------------------------------------------------------
// C stubs for class methods

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStaticText* wxStaticText_ctor()
{
	return new _StaticText();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxStaticText_Create(wxStaticText *self, wxWindow* parent, wxWindowID id, const char* label, const wxPoint* pos, const wxSize* size, long style, const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name == NULL)
		name = "staticText";

	return self->Create(parent, id, wxString(label, wxConvUTF8), *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

// On WIN32 EVT_ENTER_WINDOW and EVT_LEAVE_WINDOW are broken in wxWidgets. And
// it has been that way for a long time. Overloading MSWWindowProc and handling
// WM_NCHITTEST as shown is the workaround.
#ifdef __WIN95__
long _StaticText::MSWWindowProc(WXUINT nMsg, WXWPARAM wParam, WXLPARAM lParam)
{
        if (nMsg == WM_NCHITTEST)
                return (long)HTCLIENT;

        return wxStaticText::MSWWindowProc( nMsg, wParam, lParam );
}
#endif