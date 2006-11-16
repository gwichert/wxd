//-----------------------------------------------------------------------------
// wx.NET - NavigationKeyEvent.cs
//
// The wxNavigationKeyEvent wrapper class.
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
	public class NavigationKeyEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxNavigationKeyEvent_ctor();
		[DllImport("wx-c")] static extern bool wxNavigationKeyEvent_GetDirection(IntPtr self);
		[DllImport("wx-c")] static extern void wxNavigationKeyEvent_SetDirection(IntPtr self, bool bForward);
		[DllImport("wx-c")] static extern bool wxNavigationKeyEvent_IsWindowChange(IntPtr self);
		[DllImport("wx-c")] static extern void wxNavigationKeyEvent_SetWindowChange(IntPtr self, bool bIs);
		[DllImport("wx-c")] static extern IntPtr wxNavigationKeyEvent_GetCurrentFocus(IntPtr self);
		[DllImport("wx-c")] static extern void wxNavigationKeyEvent_SetCurrentFocus(IntPtr self, IntPtr win);
		[DllImport("wx-c")] static extern void wxNavigationKeyEvent_SetFlags(IntPtr self, uint flags);
		
		//-----------------------------------------------------------------------------

		public NavigationKeyEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public NavigationKeyEvent()
			: this(wxNavigationKeyEvent_ctor()) { }
			
		//-----------------------------------------------------------------------------
		
		public bool Direction
		{
			get { return wxNavigationKeyEvent_GetDirection(wxObject); }
			set { wxNavigationKeyEvent_SetDirection(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool WindowChange
		{
			get { return wxNavigationKeyEvent_IsWindowChange(wxObject); }
			set { wxNavigationKeyEvent_SetWindowChange(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Window CurrentFocus
		{
			get { return (Window)FindObject(wxNavigationKeyEvent_GetCurrentFocus(wxObject), typeof(Window)); }
			set { wxNavigationKeyEvent_SetCurrentFocus(wxObject, Object.SafePtr(value)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public long Flags
		{
			set { wxNavigationKeyEvent_SetFlags(wxObject, (uint)value); }
		}
	}
}
