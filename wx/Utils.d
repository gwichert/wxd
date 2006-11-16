//-----------------------------------------------------------------------------
// wxD - Utils.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - Utils.cs
//
// Common Utils wrapper classes.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Utils;
import wx.common;
import wx.Window;

		static extern (C) string wxGlobal_GetHomeDir();
		static extern (C) void wxSleep_func(int num);
		static extern (C) void wxYield_func();
		static extern (C) void wxBeginBusyCursor_func();
		static extern (C) void wxEndBusyCursor_func();
		static extern (C) void wxMutexGuiEnter_func();
		static extern (C) void wxMutexGuiLeave_func();
		
		
		public static string GetHomeDir()
		{
			return wxGlobal_GetHomeDir().dup;
		}
		
		//---------------------------------------------------------------------

		public static void wxSleep(int num)
		{
			wxSleep_func(num);
		}
		
		//---------------------------------------------------------------------

		public static void wxYield()
		{
			wxYield_func();
		}
		
		//---------------------------------------------------------------------

		public static void BeginBusyCursor()
		{
			wxBeginBusyCursor_func();
		}

		public static void EndBusyCursor()
		{
			wxEndBusyCursor_func();
		}
		
		//---------------------------------------------------------------------
		
		public static void MutexGuiEnter()
		{
			wxMutexGuiEnter_func();
		}
		
		public static void MutexGuiLeave()
		{
			wxMutexGuiLeave_func();
		}
		
			
	//---------------------------------------------------------------------

	public class BusyCursor : IDisposable
	{
		public this()
		{
			BeginBusyCursor();
		}
	
		~this()
		{
			Dispose();
		}
	
		public void Dispose()
		{
			EndBusyCursor();
		}
	}
	
	//---------------------------------------------------------------------

		static extern (C) IntPtr wxWindowDisabler_ctor(IntPtr winToSkip);
		static extern (C) void wxWindowDisabler_dtor(IntPtr self);
		
	public class WindowDisabler : wxObject
	{
		//---------------------------------------------------------------------

		public this(IntPtr wxobj)
		{
			super(wxobj);
		}
		
		private this(IntPtr wxobj, bool memOwn)
		{ 
			super(wxobj);
			this.memOwn = memOwn;
		}

		public this()
			{ this(cast(Window)null);}

		public this(Window winToSkip)
			{ this(wxWindowDisabler_ctor(wxObject.SafePtr(winToSkip)), true);}
			
		//---------------------------------------------------------------------
		
		override private void dtor() { wxWindowDisabler_dtor(wxobj); }
	}
	
	//---------------------------------------------------------------------

		static extern (C) IntPtr wxBusyInfo_ctor(string message, IntPtr parent);
		static extern (C) void   wxBusyInfo_dtor(IntPtr self);
		
	public class BusyInfo : wxObject
	{
		//---------------------------------------------------------------------
	
		public this(IntPtr wxobj)
		{
			super(wxobj);
		}
	
		public this(string message)
			{ this(message, null);}
	
		public this(string message, Window parent)
			{ this(wxBusyInfo_ctor(message, wxObject.SafePtr(parent)), true);}
			
		private this(IntPtr wxobj, bool memOwn)
		{
			super(wxobj);
			this.memOwn = memOwn;
		}
		
		//---------------------------------------------------------------------

		override private void dtor() { wxBusyInfo_dtor(wxobj); }
	}
	
	//---------------------------------------------------------------------
