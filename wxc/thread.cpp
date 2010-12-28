//-----------------------------------------------------------------------------
// wxD - thread.cpp
// (C) 2006 afb <afb@users.sourceforge.net>
//
// wxThread, for threading
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/thread.h>
#include "local_events.h"

#if wxUSE_THREADS

typedef void* (CALLBACK* Virtual_void) (wxc_object obj);

//-----------------------------------------------------------------------------
// wxMutex

extern "C" WXEXPORT
wxMutex *wxMutex_ctor(int mutexType)
{
	return new wxMutex((wxMutexType) mutexType);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMutex_dtor(wxMutex* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMutex_IsOk(wxMutex* self)
{
	return self->IsOk() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMutex_Lock(wxMutex* self)
{
	return (int) self->Lock();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMutex_TryLock(wxMutex* self)
{
	return (int) self->TryLock();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxMutex_Unlock(wxMutex* self)
{
	return (int) self->Unlock();
}

//-----------------------------------------------------------------------------
// wxMutexLocker

extern "C" WXEXPORT
wxMutexLocker *wxMutexLocker_ctor(wxMutex& mutex)
{
	return new wxMutexLocker(mutex);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMutexLocker_dtor(wxMutexLocker* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxMutexLocker_IsOk(wxMutexLocker* self)
{
	return self->IsOk() ? 1 : 0;
}

//-----------------------------------------------------------------------------
// wxCriticalSection

extern "C" WXEXPORT
wxCriticalSection *wxCriticalSection_ctor()
{
	return new wxCriticalSection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCriticalSection_dtor(wxCriticalSection* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCriticalSection_Enter(wxCriticalSection* self)
{
	self->Enter();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCriticalSection_Leave(wxCriticalSection* self)
{
	self->Leave();
}

//-----------------------------------------------------------------------------
// wxCriticalSectionLocker

extern "C" WXEXPORT
wxCriticalSectionLocker *wxCriticalSectionLocker_ctor(wxCriticalSection *cs)
{
	return new wxCriticalSectionLocker(*cs);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCriticalSectionLocker_dtor(wxCriticalSectionLocker* self)
{
	delete self;
}

//-----------------------------------------------------------------------------
// wxCondition

extern "C" WXEXPORT
wxCondition *wxCondition_ctor(wxMutex& mutex)
{
	return new wxCondition(mutex);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCondition_dtor(wxCondition* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCondition_IsOk(wxCondition* self)
{
	return self->IsOk() ? 1 : 0;
}

//-----------------------------------------------------------------------------
// wxSemaphore

extern "C" WXEXPORT
wxSemaphore* wxSemaphore_ctor(int initialcount, int maxcount)
{
    return new wxSemaphore(initialcount, maxcount);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSemaphore_dtor(wxSemaphore* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxSemaphore_IsOk(wxSemaphore* self)
{
    return self->IsOk() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSemaError wxSemaphore_Wait(wxSemaphore* self)
{
    return self->Wait();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSemaError wxSemaphore_TryWait(wxSemaphore* self)
{
    return self->TryWait();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSemaError wxSemaphore_WaitTimeout(wxSemaphore* self, unsigned int milliseconds)
{
    return self->WaitTimeout(milliseconds);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSemaError wxSemaphore_Post(wxSemaphore* self)
{
    return self->Post();
}

//-----------------------------------------------------------------------------
// wxThread

class _Thread : public wxThread
{
public:
	_Thread(wxThreadKind kind)
		: wxThread(kind) {}

	void RegisterVirtual(wxc_object obj, Virtual_void entry)
	{
		m_dobj = obj;
		m_Entry = entry;
	}
	
    void *Entry()
	{ return m_Entry(m_dobj); }

private:
	Virtual_void m_Entry;
	wxc_object m_dobj;
};

extern "C" WXEXPORT
void wxThread_RegisterVirtual(_Thread* self, wxc_object obj, Virtual_void entry)
{
	self->RegisterVirtual(obj, entry);
}

extern "C" WXEXPORT
wxThread* wxThread_ctor(wxThreadKind kind)
{
    return new _Thread(kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxThread_dtor(wxThread* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThread* wxThread_This(wxThread* self)
{
    return self->This();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxThread_IsMain(wxThread* self)
{
    return self->IsMain() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxThread_Yield(wxThread* self)
{
    self->Yield();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxThread_Sleep(wxThread* self, unsigned int milliseconds)
{
    self->Sleep(milliseconds);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxThread_GetCPUCount(wxThread* self)
{
    return self->GetCPUCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadIdType wxThread_GetCurrentId(wxThread* self)
{
    return self->GetCurrentId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxThread_SetConcurrency(wxThread* self, int level)
{
    return self->SetConcurrency(level) ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadError wxThread_Create(wxThread* self, unsigned int stackSize)
{
    return self->Create(stackSize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadError wxThread_Run(wxThread* self)
{
    return self->Run();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadError wxThread_Delete(wxThread* self, wxThread::ExitCode* rc)
{
    return self->Delete(rc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThread::ExitCode wxThread_Wait(wxThread* self)
{
    return self->Wait();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadError wxThread_Kill(wxThread* self)
{
    return self->Kill();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadError wxThread_Pause(wxThread* self)
{
    return self->Pause();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadError wxThread_Resume(wxThread* self)
{
    return self->Resume();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxThread_SetPriority(wxThread* self, unsigned int prio)
{
    self->SetPriority(prio);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned int wxThread_GetPriority(wxThread* self)
{
    return self->GetPriority();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxThread_IsAlive(wxThread* self)
{
    return self->IsAlive() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxThread_IsRunning(wxThread* self)
{
    return self->IsRunning() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxThread_IsPaused(wxThread* self)
{
    return self->IsPaused() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxThread_IsDetached(wxThread* self)
{
    return self->IsDetached() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadIdType wxThread_GetId(wxThread* self)
{
    return self->GetId();
}

//-----------------------------------------------------------------------------

#if wxABI_VERSION < 20900
extern "C" WXEXPORT
void wxThread_OnExit(wxThread* self)
{
    self->OnExit();
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxThread_TestDestroy(wxThread* self)
{
    return self->TestDestroy() ? 1 : 0;
}

//-----------------------------------------------------------------------------
// wxThreadHelperThread

extern "C" WXEXPORT
wxThreadHelperThread* wxThreadHelperThread_ctor(wxThreadHelper* owner)
{
#if wxABI_VERSION < 20900
    return new wxThreadHelperThread(*owner);
#else
    return new wxThreadHelperThread(*owner, wxTHREAD_DETACHED);
#endif
}

//-----------------------------------------------------------------------------
// wxThreadHelper


class _ThreadHelper : public wxThreadHelper
{
public:
	_ThreadHelper()
		: wxThreadHelper() {}

	void RegisterVirtual(wxc_object obj, Virtual_void entry)
	{
		m_dobj = obj;
		m_Entry = entry;
	}
	
    void *Entry()
	{ return m_Entry(m_dobj); }

private:
	Virtual_void m_Entry;
	wxc_object m_dobj;
};

extern "C" WXEXPORT
void wxThreadHelper_RegisterVirtual(_ThreadHelper* self, wxc_object obj, Virtual_void entry)
{
	self->RegisterVirtual(obj, entry);
}

extern "C" WXEXPORT
wxThreadHelper* wxThreadHelper_ctor()
{
    return new _ThreadHelper();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxThreadHelper_dtor(wxThreadHelper* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThreadError wxThreadHelper_Create(wxThreadHelper* self, unsigned int stackSize)
{
    return self->Create(stackSize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxThreadHelper_Entry(wxThreadHelper* self)
{
    self->Entry();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxThread* wxThreadHelper_GetThread(wxThreadHelper* self)
{
    return self->GetThread();
}

#else
#ifdef __GNUC__
#warning "wxUSE_THREADS is not set"
#endif
#endif
