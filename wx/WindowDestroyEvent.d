//-----------------------------------------------------------------------------
// wx.NET - WindowDestroyEvent.cs
//
// The wxWindowDestroyEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class WindowDestroyEvent : CommandEvent
	{
		[DllImport("wx-c")] static extern IntPtr wxWindowDestroyEvent_ctor(IntPtr type);
		[DllImport("wx-c")] static extern IntPtr wxWindowDestroyEvent_GetWindow(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public WindowDestroyEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public WindowDestroyEvent(Window win)
			: this(wxWindowDestroyEvent_ctor(Object.SafePtr(win))) { }

		//-----------------------------------------------------------------------------	
		
		public Window Active
		{
			get { return (Window)FindObject(wxWindowDestroyEvent_GetWindow(wxObject), typeof(Window)); }
		}
	}
}
