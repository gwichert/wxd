//-----------------------------------------------------------------------------
// wxD - App.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// (C) 2006 afb <afb@users.sourceforge.net>
// based on
// wx.NET - App.cs
//
/// The wxApp wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.App;
public import wx.common;
public import wx.EvtHandler;
public import wx.Window;
public import wx.GdiCommon;
public import wx.Clipboard;
public import wx.FontMisc;

//! \cond STD
version (Tango)
{
import tango.stdc.stringz;
alias toUtf8z toStringz;
import tango.text.convert.Utf;
char[] toUTF8( char[] str) { return str; }
char[] toUTF8(wchar[] str) { return toUtf8(str); }
char[] toUTF8(dchar[] str) { return toUtf8(str); }
}
else // Phobos
{
private import std.string;
private import std.utf;
}
//! \endcond

		//! \cond EXTERN
	extern (C) {
	alias bool function(App o) Virtual_OnInit;
	alias int  function(App o) Virtual_OnRun;
	alias int  function(App o) Virtual_OnExit;
	alias bool function(App o,inout int argc,char** argv) Virtual_Initialize;
	}
	
	static extern (C) IntPtr wxApp_ctor();
	static extern (C) void wxApp_RegisterVirtual(IntPtr self, App o, Virtual_OnInit onInit, Virtual_OnRun onRun, Virtual_OnExit onExit, Virtual_Initialize initalize);
	static extern (C) bool wxApp_Initialize(IntPtr self,inout int argc,char** argv);
	static extern (C) bool wxApp_OnInit(IntPtr self);
	static extern (C) bool wxApp_OnRun(IntPtr self);
	static extern (C) int wxApp_OnExit(IntPtr self);
	
        static extern (C) void   wxApp_Run(int argc, char** argv);

        static extern (C) void   wxApp_SetVendorName(IntPtr self, string name);
        static extern (C) IntPtr wxApp_GetVendorName(IntPtr self);

        static extern (C) void   wxApp_SetAppName(IntPtr self, string name);
        static extern (C) IntPtr wxApp_GetAppName(IntPtr self);

        static extern (C) void   wxApp_SetTopWindow(IntPtr self, IntPtr window);
        static extern (C) IntPtr wxApp_GetTopWindow(IntPtr self);

        static extern (C) bool   wxApp_SafeYield(IntPtr win, bool onlyIfNeeded);
        static extern (C) bool   wxApp_Yield(IntPtr self, bool onlyIfNeeded);
        static extern (C) void   wxApp_WakeUpIdle();
		//! \endcond

        //---------------------------------------------------------------------

    alias App wxApp;
	/// The wxApp class represents the application itself.
	/**
	  * It is used to:
	  * - set and get application-wide properties;
	  * - implement the windowing system message or event loop;
	  * - initiate application processing via wxApp::OnInit;
	  * - allow default processing of events not handled by other objects in the application.
	  **/
    public abstract class App : EvtHandler
    {
        
        private static App app;
	private Object m_caughtException=null;
	public void catchException(Object e) {m_caughtException=e;}

        //---------------------------------------------------------------------

        protected this() 
        {
        	super(wxApp_ctor());
            app = this;
		
		FontMapper.initialize();
	    
	    wxApp_RegisterVirtual(wxobj, this, &staticOnInit, &staticOnRun, &staticOnExit, &staticInitialize);
        }

        //---------------------------------------------------------------------

	extern (C) private static bool staticInitialize(App o,inout int argc,char** argv)
 	{
		return o.Initialize(argc,argv);
 	}

 	extern (C) private static bool staticOnInit(App o)
 	{
 		Clipboard.initialize();
		try return o.OnInit();
		catch(Object e) o.catchException(e);
		return false;
 	}

	extern (C) private static int  staticOnRun(App o)
 	{
		return o.OnRun();
 	}

	extern (C) private static int  staticOnExit(App o)
 	{
		return o.OnExit();
 	}

	private bool Initialize(inout int argc,char** argv)
	{
		bool ret = wxApp_Initialize(wxobj, argc,argv);
		InitializeStockObjects();
		return ret;
	}

	public /+virtual+/ bool OnInit()
	{
		return wxApp_OnInit(wxobj);
	}
	
	public /+virtual+/ int OnRun()
	{
		return wxApp_OnRun(wxobj);
	}

	public /+virtual+/ int OnExit()
	{
		return wxApp_OnExit(wxobj);
	}

        //---------------------------------------------------------------------

        public static App GetApp() 
        {
            return app;
        }

        //---------------------------------------------------------------------

        public void Run()
        {
            string[] args; // = Environment.GetCommandLineArgs();
            args.length = 1;
            args[0] = "wx";
            Run(args);
        }

        public void Run(string[] args)
        {
			char*[] c_args = new char*[args.length];
			foreach (int i, string arg; args)
				c_args[i] = toStringz(toUTF8(arg));
			
            wxApp_Run(c_args.length, c_args.ptr);
			
			if(m_caughtException)
			{
				Object e=m_caughtException;
				//Maybe the user catches this exception and runs
				//the app again, so we have to clean up
				m_caughtException=null;
				throw e;
			}
        }

        //---------------------------------------------------------------------
        
        public string VendorName() { return cast(string) new wxString(wxApp_GetVendorName(wxobj), true); }
        public void VendorName(string name) { wxApp_SetVendorName(wxobj, name); }
        public string AppName() { return cast(string) new wxString(wxApp_GetAppName(wxobj), true); }
        public void AppName(string name) { wxApp_SetAppName(wxobj, name); }

        //---------------------------------------------------------------------

        public Window TopWindow() { return cast(Window) FindObject(wxApp_GetTopWindow(wxobj)); }
        public void TopWindow(Window window) { wxApp_SetTopWindow(wxobj, window.wxobj); }

        //---------------------------------------------------------------------

        public static bool SafeYield() 
            { return wxApp_SafeYield(wxObject.SafePtr(null), false); }
        public static bool SafeYield(Window win) 
            { return wxApp_SafeYield(wxObject.SafePtr(win), false); }
        public static bool SafeYield(Window win, bool onlyIfNeeded) 
            { return wxApp_SafeYield(wxObject.SafePtr(win), onlyIfNeeded); }

        public bool Yield() 
            { return wxApp_Yield(wxobj, false); }
        public bool Yield(bool onlyIfNeeded) 
            { return wxApp_Yield(wxobj, onlyIfNeeded); }

        //---------------------------------------------------------------------

        public static void WakeUpIdle()
        {
            wxApp_WakeUpIdle();
        }

        //---------------------------------------------------------------------
    }
