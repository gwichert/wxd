//-----------------------------------------------------------------------------
// wx.NET - ShowEvent.cs
//
// The wxShowEvent wrapper class.
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
	public class ShowEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxShowEvent_ctor(int type);
		[DllImport("wx-c")] static extern bool wxShowEvent_GetShow(IntPtr self);
		[DllImport("wx-c")] static extern void wxShowEvent_SetShow(IntPtr self, bool show);
		
		//-----------------------------------------------------------------------------

		public ShowEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public ShowEvent(int type)
			: this(wxShowEvent_ctor(type)) { }

		//-----------------------------------------------------------------------------	
		
		public bool Show
		{
			get { return wxShowEvent_GetShow(wxObject); }
			set { wxShowEvent_SetShow(wxObject, value); }
		}
	}
}
