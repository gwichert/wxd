//-----------------------------------------------------------------------------
// wx.NET - ActivateEvent.cs
//
// The wxActivateEvent wrapper class.
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
	public class ActivateEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxActivateEvent_ctor(int type);
		[DllImport("wx-c")] static extern bool wxActivateEvent_GetActive(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public ActivateEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public ActivateEvent(int type)
			: this(wxActivateEvent_ctor(type)) { }

		//-----------------------------------------------------------------------------	
		
		public bool Active
		{
			get { return wxActivateEvent_GetActive(wxObject); }
		}
	}
}
