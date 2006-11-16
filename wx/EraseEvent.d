//-----------------------------------------------------------------------------
// wx.NET - EraseEvent.cs
//
// The wxEraseEvent wrapper class.
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
	public class EraseEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxEraseEvent_ctor(int type);
		[DllImport("wx-c")] static extern IntPtr wxEraseEvent_GetDC(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public EraseEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public EraseEvent(int type)
			: this(wxEraseEvent_ctor(type)) { }

		//-----------------------------------------------------------------------------	
		
		public DC DC
		{
			get { return (DC)FindObject(wxEraseEvent_GetDC(wxObject), typeof(DC)); }
		}
	}
}
