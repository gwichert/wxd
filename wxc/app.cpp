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

#include <stdio.h>

typedef bool (CALLBACK* Virtual_Initialize) (dobj obj,int* argc,char** argv);
typedef bool (CALLBACK* Virtual_OnInit) (dobj obj);
typedef int (CALLBACK* Virtual_OnExit) (dobj obj);

//-----------------------------------------------------------------------------
// The proxy class

class _App : public wxApp
{
public:
	bool Initialize(int& argc, wxChar **argv)
	{
		const char* cargv[argc];
		for (int i=0; i < argc; i++)
		#if wxUSE_UNICODE
			cargv[i] = wxString(argv[i],wxConvUTF8).mb_str(wxConvUTF8).data();
		#else // ANSI
			cargv[i] = wxString(argv[i]).data();
		#endif

		return m_Initialize(m_dobj,&argc,(char**)cargv); 
	}

	bool OnInit()
	{ return m_OnInit(m_dobj); }
	
	int OnExit()
	{ return m_OnExit(m_dobj); }
	
	void RegisterVirtual(dobj obj, Virtual_OnInit onInit, Virtual_OnExit onExit, Virtual_Initialize initialize)
	{
		m_dobj = obj;
		m_OnInit = onInit;
		m_OnExit = onExit;
		m_Initialize = initialize;
	}
	
private:
	Virtual_OnInit m_OnInit;
	Virtual_OnExit m_OnExit;
	Virtual_Initialize m_Initialize;
	dobj m_dobj;
};

//-----------------------------------------------------------------------------
// Replacement code for IMPLEMENT_APP_NO_MAIN()

static _App* _app = NULL;
wxApp* wxCreateApp() { return _app; }

wxAppInitializer wxTheAppInitializer((wxAppInitializerFunction)wxCreateApp);

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
void wxApp_RegisterVirtual(_App* self, dobj obj, Virtual_OnInit onInit, Virtual_OnExit onExit,Virtual_Initialize initalize)
{
	self->RegisterVirtual(obj, onInit, onExit ,initalize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxApp_OnInit(_App* self)
{
	return self->wxApp::OnInit()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxApp_OnExit(_App* self)
{
	return self->wxApp::OnExit();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxApp_Initialize(_App* self,int& argc, char **argv)
{
	const wxChar* wargv[argc];
        for (int i=0; i < argc; i++)
           wargv[i] = wxString(argv[i],*wxConvCurrent).c_str();

	return self->wxApp::Initialize(argc,(wxChar**)wargv)?1:0;
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
dstrret wxApp_GetVendorName(wxApp* self)
{
    return dstr_ret(self->GetVendorName());
}

extern "C" WXEXPORT 
void wxApp_SetVendorName(wxApp* self, dstr name)
{
    self->SetVendorName(wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
dstrret wxApp_GetAppName(wxApp* self)
{
    return dstr_ret(self->GetAppName());
}

extern "C" WXEXPORT 
void wxApp_SetAppName(wxApp* self, dstr name)
{
    self->SetAppName(wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
bool wxApp_SafeYield(wxWindow* win, bool onlyIfNeeded) 
{
    return ::wxSafeYield(win, onlyIfNeeded)?1:0;
}

#ifdef Yield
    #undef Yield
#endif
extern "C" WXEXPORT
bool wxApp_Yield(wxApp* self, bool onlyIfNeeded)
{
    return self->Yield(onlyIfNeeded)?1:0;
}

extern "C" WXEXPORT
void wxApp_WakeUpIdle()
{
    //::wxWakeUpIdle();
}

//-----------------------------------------------------------------------------
