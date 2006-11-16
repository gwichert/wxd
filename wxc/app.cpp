//-----------------------------------------------------------------------------
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
#include "local_events.h"

typedef bool (CALLBACK* Virtual_OnInit) ();
typedef int (CALLBACK* Virtual_OnExit) ();

//-----------------------------------------------------------------------------
// The proxy class

class _App : public wxApp
{
public:
	bool OnInit()
	{ return m_OnInit(); }
	
	int OnExit()
	{ return m_OnExit(); }
	
	void RegisterVirtual(Virtual_OnInit onInit, Virtual_OnExit onExit)
	{
		m_OnInit = onInit;
		m_OnExit = onExit;
	}
	
private:
	Virtual_OnInit m_OnInit;
	Virtual_OnExit m_OnExit;
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
void wxApp_RegisterVirtual(_App* self, Virtual_OnInit onInit, Virtual_OnExit onExit)
{
	self->RegisterVirtual(onInit, onExit );
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

#if defined(_WINDOWS)

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <wx/msw/private.h>
#include <wx/cmdline.h>

	extern "C" WXEXPORT 
	wxNetEntry(HINSTANCE hInstance, HINSTANCE WXUNUSED(hPrevInstance),
			   char * WXUNUSED(pCmdLine), int nCmdShow)
	{
		// remember the parameters Windows gave us
		wxSetInstance(hInstance);
		wxApp::m_nCmdShow = nCmdShow;

		// parse the command line: we can't use pCmdLine in Unicode build so it is
		// simpler to never use it at all (this also results in a more correct
		// argv[0])

		// break the command line in words
		wxArrayString args;
		const wxChar *cmdLine = ::GetCommandLine();
		if ( cmdLine )
		{
			args = wxCmdLineParser::ConvertStringToArgs(cmdLine);
		}

		int argc = args.GetCount();

		// +1 here for the terminating NULL
		wxChar **argv = new wxChar *[argc + 1];
		for ( int i = 0; i < argc; i++ )
		{
			argv[i] = wxStrdup(args[i]);
		}

		// argv[] must be NULL-terminated
		argv[argc] = NULL;

		return wxEntry(argc, argv);
	}

	static HANDLE thisModule;

	extern "C" WXEXPORT
	void wxApp_Run(int argc, char* argv[])
	{
		wxNetEntry((HINSTANCE)thisModule, NULL, (char*)GetCommandLineW(), 0);
	}

	BOOL APIENTRY DllMain(HANDLE hModule, DWORD ulReasonForCall, LPVOID lpReserved)
	{
		if (ulReasonForCall == DLL_PROCESS_ATTACH)
			thisModule = hModule;
		return TRUE;
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
void wxApp_SetVendorName(wxApp* self, char* name)
{
    self->SetVendorName(wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT 
wxString* wxApp_GetAppName(wxApp* self)
{
    return new wxString(self->GetAppName());
}

extern "C" WXEXPORT 
void wxApp_SetAppName(wxApp* self, char* name)
{
    self->SetAppName(wxString(name, wxConvUTF8));
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
