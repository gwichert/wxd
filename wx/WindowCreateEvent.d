//-----------------------------------------------------------------------------
// wx.NET - WindowCreateEvent.cs
//
// The wxWindowCreateEvent wrapper class.
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
	public class WindowCreateEvent : CommandEvent
	{
		[DllImport("wx-c")] static extern IntPtr wxWindowCreateEvent_ctor(IntPtr type);
		[DllImport("wx-c")] static extern IntPtr wxWindowCreateEvent_GetWindow(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public WindowCreateEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public WindowCreateEvent(Window win)
			: this(wxWindowCreateEvent_ctor(Object.SafePtr(win))) { }

		//-----------------------------------------------------------------------------	
		
		public Window Active
		{
			get { return (Window)FindObject(wxWindowCreateEvent_GetWindow(wxObject), typeof(Window)); }
		}
	}
}
