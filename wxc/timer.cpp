//-----------------------------------------------------------------------------
// wxD - timer.cpp
// (C) 2006 afb <afb@users.sourceforge.net> (thanks to Matrix for updates)
// 
// wxTimer, for timers
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/timer.h>
#include "local_events.h"

typedef void (CALLBACK* Virtual_Notify) (wxc_object);

//-----------------------------------------------------------------------------

class _Timer : public wxTimer
{
protected:
    void Notify()
        { m_notify(m_dobj); }
        
public:
	_Timer()
	:wxTimer()
	{}
	
	_Timer(wxEvtHandler* owner, int id)
	:wxTimer(owner, id)
	{}
	
    void RegisterVirtual(wxc_object obj, Virtual_Notify notify)
    {
        m_dobj = obj;
        m_notify = notify;
    }
	
	void BaseNotify() //Calls the implementation in wxTimerBase
		{ wxTimer::Notify(); }

private:
    Virtual_Notify m_notify;
    wxc_object m_dobj;

public:
    DECLARE_OBJECTDELETED(_Timer)
};

#if wxUSE_TIMER

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxTimer* wxTimer_ctor()
{
	return new _Timer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTimer* wxTimer_ctor2(wxEvtHandler* owner, int id)
{
	return new _Timer(owner, id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTimer_RegisterVirtual(_Timer* self, wxc_object obj, 
	Virtual_Notify notify)
{
    self->RegisterVirtual(obj, notify);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTimer_dtor(wxTimer* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxTimer_GetInterval(wxTimer* self)
{
	return self->GetInterval();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTimer_IsOneShot(wxTimer* self)
{
	return self->IsOneShot();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxTimer_IsRunning(wxTimer* self)
{
	return self->IsRunning();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTimer_BaseNotify(_Timer* self)
{
	return self->BaseNotify();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTimer_SetOwner(wxTimer* self, wxEvtHandler* owner, int id)
{
	self->SetOwner(owner, id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTimer_Start(wxTimer* self, int milliseconds, wxc_bool oneShot)
{
	self->Start(milliseconds, oneShot);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTimer_Stop(wxTimer* self)
{
	self->Stop();
}

#else
#ifdef __GNUC__
#warning "wxUSE_TIMER is not set"
#endif
#endif
