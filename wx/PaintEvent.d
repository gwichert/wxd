//-----------------------------------------------------------------------------
// wx.NET - PaintEvent.cs
//
// The wxPaintEvent wrapper class.
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
	public class PaintEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxPaintEvent_ctor(int Id);
		
		//-----------------------------------------------------------------------------

		public PaintEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public PaintEvent(int Id)
			: this(wxPaintEvent_ctor(Id)) { }
	}
}
