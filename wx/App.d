//-----------------------------------------------------------------------------
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

using System;
using System.Runtime.InteropServices;

namespace wx
{
    public abstract class App : EvtHandler
    {
	private delegate bool Virtual_OnInit();
	private delegate int Virtual_OnExit();
	
	private Virtual_OnInit virtual_OnInit;
	private Virtual_OnExit virtual_OnExit;
    
        [DllImport("wx-c")] static extern IntPtr wxApp_ctor();
	
	[DllImport("wx-c")] static extern void wxApp_RegisterVirtual(IntPtr self, Virtual_OnInit onInit, Virtual_OnExit onExit);
	[DllImport("wx-c")] static extern bool wxApp_OnInit(IntPtr self);
	[DllImport("wx-c")] static extern int wxApp_OnExit(IntPtr self);
	
        [DllImport("wx-c")] static extern void   wxApp_Run(int argc, string[] argv);

        [DllImport("wx-c")] static extern void   wxApp_SetVendorName(IntPtr self, string name);
        [DllImport("wx-c")] static extern IntPtr wxApp_GetVendorName(IntPtr self);

        [DllImport("wx-c")] static extern void   wxApp_SetAppName(IntPtr self, string name);
        [DllImport("wx-c")] static extern IntPtr wxApp_GetAppName(IntPtr self);

        [DllImport("wx-c")] static extern bool   wxApp_SafeYield(IntPtr win, bool onlyIfNeeded);
        [DllImport("wx-c")] static extern bool   wxApp_Yield(IntPtr self, bool onlyIfNeeded);
        [DllImport("wx-c")] static extern void   wxApp_WakeUpIdle();
        
        //---------------------------------------------------------------------

        private static App app;

        //---------------------------------------------------------------------

        protected App() : base(wxApp_ctor())
        {
            app = this;
	    
	    virtual_OnInit = new Virtual_OnInit(OnInit);
	    virtual_OnExit = new Virtual_OnExit(OnExit);
	    
	    wxApp_RegisterVirtual(wxObject, virtual_OnInit, virtual_OnExit);
        }

        //---------------------------------------------------------------------

	public virtual bool OnInit()
	{
		return wxApp_OnInit(wxObject);
	}
	
	//---------------------------------------------------------------------
	
	public virtual int OnExit()
	{
		return wxApp_OnExit(wxObject);
	}

        //---------------------------------------------------------------------

        public static App GetApp() 
        {
            return app;
        }

        //---------------------------------------------------------------------

        public void Run()
        {
            string[] args = Environment.GetCommandLineArgs();
            wxApp_Run(args.Length, args);
        }

        //---------------------------------------------------------------------
        
        public string VendorName
        {
            set { wxApp_SetVendorName(wxObject, value); }
            get { return new wxString(wxApp_GetVendorName(wxObject), true); }
        }

        public string AppName
        {
            set { wxApp_SetAppName(wxObject, value); }
            get { return new wxString(wxApp_GetAppName(wxObject), true); }
        }

        //---------------------------------------------------------------------

        public static bool SafeYield() 
            { return wxApp_SafeYield(Object.SafePtr(null), false); }
        public static bool SafeYield(Window win) 
            { return wxApp_SafeYield(Object.SafePtr(win), false); }
        public static bool SafeYield(Window win, bool onlyIfNeeded) 
            { return wxApp_SafeYield(Object.SafePtr(win), onlyIfNeeded); }

        public bool Yield() 
            { return wxApp_Yield(wxObject, false); }
        public bool Yield(bool onlyIfNeeded) 
            { return wxApp_Yield(wxObject, onlyIfNeeded); }

        //---------------------------------------------------------------------

        public static void WakeUpIdle()
        {
            wxApp_WakeUpIdle();
        }

        //---------------------------------------------------------------------
    }
}
