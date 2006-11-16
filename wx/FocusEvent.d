//-----------------------------------------------------------------------------
// wx.NET - FocusEvent.cs
//
// The wxFocusEvent wrapper class.
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
	public class FocusEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxFocusEvent_ctor(int type);
		[DllImport("wx-c")] static extern IntPtr wxFocusEvent_GetWindow(IntPtr self);
		[DllImport("wx-c")] static extern void   wxFocusEvent_SetWindow(IntPtr self, IntPtr win);
		
		//-----------------------------------------------------------------------------

		public FocusEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public FocusEvent(int type)
			: this(wxFocusEvent_ctor(type)) { }

		//-----------------------------------------------------------------------------	
		
		public Window Window
		{
			get { return (Window)FindObject(wxFocusEvent_GetWindow(wxObject), typeof(Window)); }
			set { wxFocusEvent_SetWindow(wxObject, Object.SafePtr(value)); }
		}
	}
}
