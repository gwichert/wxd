//-----------------------------------------------------------------------------
// wx.NET - IdleEvent.cs
//
// The wxIdleEvent wrapper class.
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
	public enum IdleMode
	{
		wxIDLE_PROCESS_ALL,
		wxIDLE_PROCESS_SPECIFIED
	}
	
	//-----------------------------------------------------------------------------

	public class IdleEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxIdleEvent_ctor();
		[DllImport("wx-c")] static extern void   wxIdleEvent_RequestMore(IntPtr self, bool needMore);
		[DllImport("wx-c")] static extern bool   wxIdleEvent_MoreRequested(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxIdleEvent_SetMode(IdleMode mode);
		[DllImport("wx-c")] static extern IdleMode wxIdleEvent_GetMode();
		[DllImport("wx-c")] static extern bool   wxIdleEvent_CanSend(IntPtr win);
		
		//-----------------------------------------------------------------------------

		public IdleEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public IdleEvent()
			: this(wxIdleEvent_ctor()) { }

		//-----------------------------------------------------------------------------	
		
		public void RequestMore()
		{
			RequestMore(true);
		}
		
		public void RequestMore(bool needMore)
		{
			wxIdleEvent_RequestMore(wxObject, needMore);
		}
		
		//-----------------------------------------------------------------------------	
		
		public bool MoreRequested()
		{
			return wxIdleEvent_MoreRequested(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public static IdleMode Mode
		{
			get { return wxIdleEvent_GetMode(); }
			set { wxIdleEvent_SetMode(value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public static bool CanSend(Window win)
		{
			return wxIdleEvent_CanSend(Object.SafePtr(win));
		}
	}
}
