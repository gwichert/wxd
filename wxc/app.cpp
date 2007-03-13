//-----------------------------------------------------------------------------
// wxD - app.cpp
// (C) 2005 bero <berobero@users.sourceforge.net>
// (C) 2005 afb <afb@users.sourceforge.net>
// based on
// wx.NET - app.cxx
//
// The wxApp proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

DEFINE_LOCAL_EVENT_TYPE(wxEVT_APPINIT)    

#include <stdio.h>

typedef wxc_bool (CALLBACK* Virtual_Initialize) (wxc_object obj,int* argc,char** argv);
typedef wxc_bool (CALLBACK* Virtual_OnInit) (wxc_object obj);
typedef int (CALLBACK* Virtual_OnRun) (wxc_object obj);
typedef int (CALLBACK* Virtual_OnExit) (wxc_object obj);

//-----------------------------------------------------------------------------
// The proxy class

class _App : public wxApp
{
public:
	bool Initialize(int& argc, wxChar **argv)
	{
		const char* cargv[argc];
		for (int i=0; i < argc; i++)
		{
		const wxWX2MBbuf buf = wxString(argv[i]).mb_str(wxConvUTF8);
		cargv[i] = (const char*) buf;
		}
		
		return m_Initialize(m_dobj,&argc,(char**)cargv); 
	}

	bool OnInit()
	{ return m_OnInit(m_dobj); }
	
	int OnRun()
	{ return m_OnRun(m_dobj); }
	
	int OnExit()
	{ return m_OnExit(m_dobj); }
	
	void RegisterVirtual(wxc_object obj, Virtual_OnInit onInit, Virtual_OnRun onRun, Virtual_OnExit onExit, Virtual_Initialize initialize)
	{
		m_dobj = obj;
		m_OnInit = onInit;
		m_OnRun = onRun;
		m_OnExit = onExit;
		m_Initialize = initialize;
	}
	
private:
	Virtual_OnInit m_OnInit;
	Virtual_OnRun m_OnRun;
	Virtual_OnExit m_OnExit;
	Virtual_Initialize m_Initialize;
	wxc_object m_dobj;
};

//-----------------------------------------------------------------------------
// Replacement code for IMPLEMENT_APP_NO_MAIN()

#if wxABI_VERSION < 20700
static _App* _app = NULL;
wxAppConsole* wxCreateApp() { return _app; }

wxAppInitializer wxTheAppInitializer((wxAppInitializerFunction)wxCreateApp);
#else
DECLARE_APP(_App)
IMPLEMENT_APP_NO_MAIN(_App)
static _App* _app = NULL;
#endif

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
_App* wxApp_ctor()
{
	_app = new _App();
	return _app;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxApp_RegisterVirtual(_App* self, wxc_object obj, Virtual_OnInit onInit, Virtual_OnRun onRun, Virtual_OnExit onExit,Virtual_Initialize initialize)
{
	self->RegisterVirtual(obj, onInit, onRun, onExit, initialize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxApp_OnInit(_App* self)
{
	return self->wxApp::OnInit()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxApp_OnRun(_App* self)
{
	return self->wxApp::OnRun();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxApp_OnExit(_App* self)
{
	return self->wxApp::OnExit();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxApp_Initialize(_App* self,int *argc, char **argv)
{

	const wxChar** wargv = new const wxChar*[*argc+1];
        for (int i=0; i < *argc+1; i++)
            wargv[i] = argv[i] ? wxStrdup(wxString(argv[i],*wxConvCurrent).c_str()) : NULL;
		
	return self->wxApp::Initialize(*argc,wargv)?1:0;
}

//-----------------------------------------------------------------------------

#if defined(__WXMSW__)

	extern "C" WXEXPORT 
	void wxApp_Run(int argc, char* argv[])
	{
		wxEntry(GetModuleHandle(NULL), NULL, (char*)GetCommandLineW(), SW_SHOWNORMAL);
	}

#else

	extern "C" WXEXPORT 
	void wxApp_Run(int argc, char* argv[])
	{
		wxEntry(argc, argv);
	}

#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
wxString* wxApp_GetVendorName(wxApp* self)
{
    return new wxString(self->GetVendorName());
}

extern "C" WXEXPORT 
void wxApp_SetVendorName(wxApp* self, wxc_string name)
{
    self->SetVendorName(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
wxString* wxApp_GetAppName(wxApp* self)
{
    return new wxString(self->GetAppName());
}

extern "C" WXEXPORT 
void wxApp_SetAppName(wxApp* self, wxc_string name)
{
    self->SetAppName(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
wxWindow* wxApp_GetTopWindow(wxApp* self)
{
    return self->GetTopWindow();
}

extern "C" WXEXPORT 
void wxApp_SetTopWindow(wxApp* self, wxWindow* window)
{
    self->SetTopWindow(window);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
wxc_bool wxApp_SafeYield(wxWindow* win, wxc_bool onlyIfNeeded) 
{
    return ::wxSafeYield(win, onlyIfNeeded)?1:0;
}

#ifdef Yield
    #undef Yield
#endif
extern "C" WXEXPORT
wxc_bool wxApp_Yield(wxApp* self, wxc_bool onlyIfNeeded)
{
    return self->Yield(onlyIfNeeded)?1:0;
}

extern "C" WXEXPORT
void wxApp_WakeUpIdle()
{
    //::wxWakeUpIdle();
}

//-----------------------------------------------------------------------------
