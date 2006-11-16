//-----------------------------------------------------------------------------
// wx.NET - events.h
//
// Defines custom events required by wx.NET.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#ifndef WX_C_LOCAL_EVENTS_H
#define WX_C_LOCAL_EVENTS_H

// I use this class to route virtual functions originating from within
// wxWidgets to the .NET framework. The framework will catch the event,
// and then trigger the appropriate function on that side of the wall.

class FunctionEvent : public wxEvent
{
public:
	FunctionEvent(wxEventType type)
		: wxEvent(0, type)
	{ }

	virtual wxEvent* Clone() const
	{
		return new FunctionEvent(this->GetEventType());
	}
};


// Custom event types for all mapped virtual functions

DECLARE_EVENT_TYPE(wxEVT_APPINIT, 0)
DECLARE_EVENT_TYPE(wxEVT_TRANSFERDATAFROMWINDOW, 0)
DECLARE_EVENT_TYPE(wxEVT_TRANSFERDATATOWINDOW, 0)
DECLARE_EVENT_TYPE(wxEVT_OBJECTDELETED, 0)

// Short-cut for virtual destructors

// Creates sends an event when an object is deleted, so that it 
// can be handled elsewhere.

#define DECLARE_OBJECTDELETED(name) \
    virtual ~name() \
    { \
        FunctionEvent e(wxEVT_OBJECTDELETED); \
        ProcessEvent(e); \
    }

// Calls a delegate when an object is deleted internally.

#if 0 //defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif

typedef void (CALLBACK* Virtual_Dispose)(void* obj);

#define DECLARE_DISPOSABLE(name) \
    void RegisterDispose(Virtual_Dispose onDispose) { m_onDispose = onDispose; } \
    virtual ~name() { m_onDispose(this); } \
    Virtual_Dispose m_onDispose;
    
#endif

