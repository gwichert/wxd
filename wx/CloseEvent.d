//-----------------------------------------------------------------------------
// wx.NET - CloseEvent.cs
//
// The wxCloseEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace wx
{
	public class CloseEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxCloseEvent_ctor(int type);
		[DllImport("wx-c")] static extern void wxCloseEvent_SetLoggingOff(IntPtr self, bool logOff);
		[DllImport("wx-c")] static extern bool wxCloseEvent_GetLoggingOff(IntPtr self);
		[DllImport("wx-c")] static extern void wxCloseEvent_Veto(IntPtr self, bool veto);
		[DllImport("wx-c")] static extern void wxCloseEvent_SetCanVeto(IntPtr self, bool canVeto);
		[DllImport("wx-c")] static extern bool wxCloseEvent_CanVeto(IntPtr self);
		[DllImport("wx-c")] static extern bool wxCloseEvent_GetVeto(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public CloseEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public CloseEvent(int type)
			: this(wxCloseEvent_ctor(type)) { }

		//-----------------------------------------------------------------------------
		
		public bool LoggingOff
		{
			get { return wxCloseEvent_GetLoggingOff(wxObject); }
			set { wxCloseEvent_SetLoggingOff(wxObject, value); } 
		}
		
		public void Veto()
		{
			Veto(true);
		}
		
		public void Veto(bool veto)
		{
			wxCloseEvent_Veto(wxObject, veto);
		}
		
		public bool CanVeto
		{
			set { wxCloseEvent_SetCanVeto(wxObject, value); }
			get { return wxCloseEvent_CanVeto(wxObject); }
		}
		
		public bool GetVeto
		{
			get { return wxCloseEvent_GetVeto(wxObject); }
		}
	}
}