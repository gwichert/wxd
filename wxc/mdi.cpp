//-----------------------------------------------------------------------------
// wx.NET - mdi.cxx
// 
// The wxMDI* proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/mdi.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

typedef wxMDIClientWindow* (CALLBACK* Virtual_OnCreateClient) ();

class _MDIParentFrame : public wxMDIParentFrame 
{
public:
	_MDIParentFrame()
		: wxMDIParentFrame() {}
	
	wxMDIClientWindow *OnCreateClient()
	{ return m_OnCreateClient(); }
	
	void Register_Virtual(Virtual_OnCreateClient onCreateClient)
	{
		m_OnCreateClient = onCreateClient;
	}
	
private:
	Virtual_OnCreateClient m_OnCreateClient;
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMDIParentFrame* wxMDIParentFrame_ctor()
{
	return new _MDIParentFrame();
}

extern "C" WXEXPORT
void wxMDIParentFrame_RegisterVirtual(_MDIParentFrame* self, Virtual_OnCreateClient onCreateClient)
{
	self->Register_Virtual(onCreateClient);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMDIClientWindow* wxMDIParentFrame_OnCreateClient(_MDIParentFrame* self)
{
	return self->wxMDIParentFrame::OnCreateClient();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMDIParentFrame_Create(_MDIParentFrame* self, wxWindow* parent, wxWindowID id, char* title, const wxPoint* pos, const wxSize* size, int style, const char* name)
{
        if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (name == NULL)
        name = "mdiParentFrame";

    return self->Create(parent, id, wxString(title, wxConvUTF8), *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMDIChildFrame* wxMDIParentFrame_GetActiveChild(_MDIParentFrame* self)
{
    return self->GetActiveChild();
}

//-----------------------------------------------------------------------------

#if 0
extern "C" WXEXPORT
void wxMDIParentFrame_SetActiveChild(wxMDIParentFrame* self, wxMDIChildFrame* pChildFrame)
{
    self->SetActiveChild(pChildFrame);
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMDIClientWindow* wxMDIParentFrame_GetClientWindow(_MDIParentFrame* self)
{
    return self->GetClientWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMDIParentFrame_Cascade(_MDIParentFrame* self)
{
    self->Cascade();
}

extern "C" WXEXPORT
void wxMDIParentFrame_Tile(_MDIParentFrame* self)
{
    self->Tile();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMDIParentFrame_ArrangeIcons(_MDIParentFrame* self)
{
    self->ArrangeIcons();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMDIParentFrame_ActivateNext(_MDIParentFrame* self)
{
    self->ActivateNext();
}

extern "C" WXEXPORT
void wxMDIParentFrame_ActivatePrevious(_MDIParentFrame* self)
{
    self->ActivatePrevious();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMDIParentFrame_GetClientSize(_MDIParentFrame* self, int* width, int* height)
{
	self->GetClientSize(width, height);
}

//-----------------------------------------------------------------------------
// wxMDIChildFrame

class _MDIChildFrame : public wxMDIChildFrame 
{
public:
	DECLARE_OBJECTDELETED(_MDIChildFrame)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMDIChildFrame* wxMDIChildFrame_ctor()
{
    return new _MDIChildFrame();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMDIChildFrame_Activate(wxMDIChildFrame* self)
{
	self->Activate();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMDIChildFrame_Create(wxMDIChildFrame* self, wxMDIParentFrame* parent, wxWindowID id, char* title, const wxPoint* pos, const wxSize* size, long style, const char* name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (name == NULL)
        name = "mdiChildFrame";

    return self->Create(parent, id, wxString(title, wxConvUTF8), *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMDIChildFrame_Restore(wxMDIChildFrame* self)
{
    self->Restore();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMDIChildFrame_Maximize(wxMDIChildFrame* self, bool maximize)
{
    self->Maximize(maximize);
}

//-----------------------------------------------------------------------------
// wxMDIClientWindow

class _MDIClientWindow : public wxMDIClientWindow
{
public:
    DECLARE_OBJECTDELETED(_MDIClientWindow)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMDIClientWindow* wxMDIClientWindow_ctor()
{
    return new _MDIClientWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxMDIClientWindow_CreateClient(wxMDIClientWindow* self, wxMDIParentFrame* parent, int style)
{
    return self->CreateClient(parent, style)?1:0;
}

//-----------------------------------------------------------------------------

