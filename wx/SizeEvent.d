//-----------------------------------------------------------------------------
// wx.NET - SizeEvent.cs
//
// The wxSizeEvent wrapper class.
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
	public class SizeEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxSizeEvent_ctor();
		[DllImport("wx-c")] static extern void wxSizeEvent_GetSize(IntPtr self, out Size size);
		
		//-----------------------------------------------------------------------------

		public SizeEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public SizeEvent()
			: this(wxSizeEvent_ctor()) { }

		//-----------------------------------------------------------------------------	
		
		public Size Size
		{
			get {
				Size size = new Size();
				wxSizeEvent_GetSize(wxObject, out size);
				return size;
			}
		}		
	}
}
