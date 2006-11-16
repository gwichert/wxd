//-----------------------------------------------------------------------------
// wx.NET - MaximizeEvent.cs
//
// The wxMaximizeEvent wrapper class.
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
	public class MaximizeEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxMaximizeEvent_ctor(int Id);
		
		//-----------------------------------------------------------------------------

		public MaximizeEvent(IntPtr wxObject) 
			: base(wxObject) { }
			
		public MaximizeEvent()
			: base(wxMaximizeEvent_ctor(0)) {}

		public MaximizeEvent(int Id)
			: this(wxMaximizeEvent_ctor(Id)) { }
	}
}
