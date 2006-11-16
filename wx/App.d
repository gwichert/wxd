//-----------------------------------------------------------------------------
// wxD - App.d
// (C) 2005 bero <berobero.sourceforge.net>
// (C) 2005 afb <afb.sourceforge.net>
// based on
// wx.NET - App.cs
//
// The wxApp wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgtes license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.App;
import wx.common;
import wx.EvtHandler;
import wx.Window;
import wx.GdiCommon;

import std.string;

	extern (C) {
	alias bool function(App o) Virtual_OnInit;
	alias int  function(App o) Virtual_OnExit;
	alias bool function(App o,inout int argc,char** argv) Virtual_Initialize;
	}

        static extern (C) IntPtr wxApp_ctor();
	
	static extern (C) void wxApp_RegisterVirtual(IntPtr self, App o, Virtual_OnInit onInit, Virtual_OnExit onExit, Virtual_Initialize initalize);
	static extern (C) bool wxApp_Initialize(IntPtr self,inout int argc,char** argv);
	static extern (C) bool wxApp_OnInit(IntPtr self);
	static extern (C) int wxApp_OnExit(IntPtr self);
	
        static extern (C) void   wxApp_Run(int argc, char** argv);

        static extern (C) void   wxApp_SetVendorName(IntPtr self, string name);
        static extern (C) string wxApp_GetVendorName(IntPtr self);

        static extern (C) void   wxApp_SetAppName(IntPtr self, string name);
        static extern (C) string wxApp_GetAppName(IntPtr self);

        static extern (C) bool   wxApp_SafeYield(IntPtr win, bool onlyIfNeeded);
        static extern (C) bool   wxApp_Yield(IntPtr self, bool onlyIfNeeded);
        static extern (C) void   wxApp_WakeUpIdle();

        //---------------------------------------------------------------------

    public abstract class App : EvtHandler
    {
        
        private static App app;

        //---------------------------------------------------------------------

        protected this() 
        {
        	super(wxApp_ctor());
            app = this;
	    
	    wxApp_RegisterVirtual(wxobj, this, &staticOnInit, &staticOnExit, &staticInitalize);
        }

        //---------------------------------------------------------------------

	extern (C) private static bool staticInitalize(App o,inout int argc,char** argv) { return o.Initalize(argc,argv); }
	extern (C) private static bool staticOnInit(App o) { return o.OnInit(); }
	extern (C) private static int  staticOnExit(App o) { return o.OnExit(); }

	private bool Initalize(inout int argc,char** argv)
	{
		bool ret = wxApp_Initialize(wxobj, argc,argv);
		InitializeStockObjects();
		return ret;
	}

	public /+virtual+/ bool OnInit()
	{
		return wxApp_OnInit(wxobj);
	}
	
	//---------------------------------------------------------------------
	
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
            Run(args);
        }

        public void Run(string[] args)
        {
			char*[] c_args = new char*[args.length];
			foreach (int i, char[] arg; args)
				c_args[i] = toStringz(arg);
			
            wxApp_Run(c_args.length, c_args.ptr);
        }

        //---------------------------------------------------------------------
        
        public string VendorName() { return wxApp_GetVendorName(wxobj).dup; }
        public string AppName() { return wxApp_GetAppName(wxobj).dup; }
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
