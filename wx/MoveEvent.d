//-----------------------------------------------------------------------------
// wx.NET - MoveEvent.cs
//
// The wxMoveEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class MoveEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxMoveEvent_ctor();
		[DllImport("wx-c")] static extern IntPtr wxMoveEvent_GetPosition(IntPtr self, out Point point);
		
		//-----------------------------------------------------------------------------

		public MoveEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public MoveEvent()
			: this(wxMoveEvent_ctor()) { }

		//-----------------------------------------------------------------------------	
		
		public Point Position
		{
			get {
				Point point = new Point();
				wxMoveEvent_GetPosition(wxObject, out point);
				return point;
			}
		}
	}
}
