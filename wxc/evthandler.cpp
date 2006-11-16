//-----------------------------------------------------------------------------
// wx.NET - evthandler.cxx
//
// The wxEvtHandler proxy interface.
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

#if defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif

typedef void (CALLBACK* EventListener)(wxEvent* event, int iListener);

//-----------------------------------------------------------------------------

struct wxProxyData : public wxObject
{
	int iListener;
};

class wxEvtProxy : public wxEvtHandler
{
public:
	void ForwardEvent(wxEvent& event)
	{
		wxProxyData* data = (wxProxyData*)event.m_callbackUserData;

		EventListener el = (EventListener)GetClientData();
		el(&event, data->iListener);
	}
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxEvtHandler_proxy(wxEvtHandler* self, EventListener listener)
{
	self->SetClientData((void*)listener);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxEvtHandler_Connect(wxEvtHandler* self, int evtType, int id, int lastId, int iListener)
{
	wxProxyData* data = new wxProxyData;
	data->iListener = iListener;
	
	self->Connect(id, lastId, evtType, (wxObjectEventFunction)&wxEvtProxy::ForwardEvent, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxEvtHandler_ProcessEvent(wxEvtHandler* self, wxEvent* event)
{
    return self->ProcessEvent(*event);
}

//-----------------------------------------------------------------------------


extern "C" WXEXPORT
void wxEvtHandler_AddPendingEvent(wxEvtHandler* self, wxEvent* event)
{
	self->AddPendingEvent(*event);
}

