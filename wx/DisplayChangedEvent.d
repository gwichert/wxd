//-----------------------------------------------------------------------------
// wx.NET - DisplayChangedEvent.cs
//
// The wxDisplayChangedEvent wrapper class.
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
	public class DisplayChangedEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxDisplayChangedEvent_ctor();
		
		//-----------------------------------------------------------------------------

		public DisplayChangedEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public DisplayChangedEvent()
			: this(wxDisplayChangedEvent_ctor()) { }
	}
}
