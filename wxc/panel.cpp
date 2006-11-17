//-----------------------------------------------------------------------------
// wxD - panel.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - panel.cxx
//
// The wxPanel proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/panel.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Panel : public wxPanel
{
public:
	_Panel()
		: wxPanel() {}
		
	_Panel(wxWindow *parent,
            wxWindowID winid,
            const wxPoint& pos,
            const wxSize& size,
            long style)//,
            //const wxString& name)
	    	: wxPanel(parent, winid, pos, size, style) {} //, name) {}

    DECLARE_OBJECTDELETED(_Panel)
    
#include "panel.inc"
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxPanel* wxPanel_ctor()
{
	return new _Panel();
}

extern "C" WXEXPORT
wxPanel* wxPanel_ctor2(wxWindow *parent, wxWindowID id, const wxPoint* pos,
                    const wxSize* size, long style, dstr name)
{
	if (pos == NULL)
	pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("panel");

	return new _Panel(parent, id, *pos, *size, style);//, wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPanel_Create(wxPanel* self, wxWindow *parent, wxWindowID id, const wxPoint* pos,
                    const wxSize* size, long style, dstr name)
{
	if (pos == NULL)
	pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("panel");

	return self->Create(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPanel_InitDialog(wxPanel* self)
{
	self->InitDialog();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPanel_SetDefaultItem(wxPanel* self, wxButton* btn)
{
	self->SetDefaultItem(btn);
}

extern "C" WXEXPORT
wxButton* wxPanel_GetDefaultItem(wxPanel* self)
{
	return (wxButton*)self->GetDefaultItem();
}
