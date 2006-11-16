//-----------------------------------------------------------------------------
// wx.NET - ChildFocusEvent.cs
//
// The wxChildFocusEvent wrapper class.
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
	public class ChildFocusEvent : CommandEvent
	{
		[DllImport("wx-c")] static extern IntPtr wxChildFocusEvent_ctor(IntPtr win);
		[DllImport("wx-c")] static extern IntPtr wxChildFocusEvent_GetWindow(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public ChildFocusEvent(IntPtr wxObject) 
			: base(wxObject) { }
			
		public ChildFocusEvent()
			: this(null) {}

		public ChildFocusEvent(Window win)
			: base(wxChildFocusEvent_ctor(Object.SafePtr(win))) { }

		//-----------------------------------------------------------------------------	
		
		public Window Window
		{
			get { return (Window)FindObject(wxChildFocusEvent_GetWindow(wxObject), typeof(Window)); }
		}
	}
}
