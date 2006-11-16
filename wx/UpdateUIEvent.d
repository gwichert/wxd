//-----------------------------------------------------------------------------
// wx.NET - UpdateUIEvent.cs
//
// The wxUpdateUIEvent wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class UpdateUIEvent : CommandEvent
	{
		[DllImport("wx-c")] static extern IntPtr wxUpdateUIEvent_ctor(int commandId);
		[DllImport("wx-c")] static extern void   wxUpdUIEvt_Enable(IntPtr self, bool enable);
		[DllImport("wx-c")] static extern void   wxUpdUIEvt_Check(IntPtr self, bool check);
		[DllImport("wx-c")] static extern bool   wxUpdateUIEvent_CanUpdate(IntPtr window);
		[DllImport("wx-c")] static extern bool   wxUpdateUIEvent_GetChecked(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxUpdateUIEvent_GetEnabled(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxUpdateUIEvent_GetSetChecked(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxUpdateUIEvent_GetSetEnabled(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxUpdateUIEvent_GetSetText(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxUpdateUIEvent_GetText(IntPtr self);
		[DllImport("wx-c")] static extern int    wxUpdateUIEvent_GetMode();
		[DllImport("wx-c")] static extern uint   wxUpdateUIEvent_GetUpdateInterval();
		[DllImport("wx-c")] static extern void   wxUpdateUIEvent_ResetUpdateTime();
		[DllImport("wx-c")] static extern void   wxUpdateUIEvent_SetMode(int mode);
		[DllImport("wx-c")] static extern void   wxUpdateUIEvent_SetText(IntPtr self, string text);
		[DllImport("wx-c")] static extern void   wxUpdateUIEvent_SetUpdateInterval(uint updateInterval);

		//-----------------------------------------------------------------------------

		public UpdateUIEvent(IntPtr wxObject) 
			: base(wxObject) { }
			
		public UpdateUIEvent() 
			: this(0) { }
			
		public UpdateUIEvent(int commandId) 
			: this(wxUpdateUIEvent_ctor(commandId)) { }

		//-----------------------------------------------------------------------------

		public bool Enabled
		{
			set { wxUpdUIEvt_Enable(wxObject, value); }
		}

		//-----------------------------------------------------------------------------
		
		public bool Check
		{
			set { wxUpdUIEvt_Check(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public static bool CanUpdate(Window window)
		{
			return wxUpdateUIEvent_CanUpdate(Object.SafePtr(window));
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Checked
		{
			get { return wxUpdateUIEvent_GetChecked(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool GetEnabled()
		{
			return wxUpdateUIEvent_GetEnabled(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SetChecked
		{
			get { return wxUpdateUIEvent_GetSetChecked(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SetEnabled
		{
			get { return wxUpdateUIEvent_GetSetEnabled(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SetText
		{
			get { return wxUpdateUIEvent_GetSetText(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public string Text
		{
			get { return new wxString(wxUpdateUIEvent_GetText(wxObject), true); }
			set { wxUpdateUIEvent_SetText(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public static UpdateUIMode Mode
		{
			get { return (UpdateUIMode)wxUpdateUIEvent_GetMode(); }
			set { wxUpdateUIEvent_SetMode((int)value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public static long UpdateInterval
		{
			get { return (long)wxUpdateUIEvent_GetUpdateInterval(); }
			set { wxUpdateUIEvent_SetUpdateInterval((uint)value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public static void ResetUpdateTime()
		{
			wxUpdateUIEvent_ResetUpdateTime();
		}
	}
}
