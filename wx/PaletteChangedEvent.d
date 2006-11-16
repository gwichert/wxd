//-----------------------------------------------------------------------------
// wx.NET - PaletteChangedEvent.cs
//
// The wxPaletteChangedEvent wrapper class.
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
	public class PaletteChangedEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxPaletteChangedEvent_ctor(int type);
		[DllImport("wx-c")] static extern void wxPaletteChangedEvent_SetChangedWindow(IntPtr self, IntPtr win);
		[DllImport("wx-c")] static extern IntPtr wxPaletteChangedEvent_GetChangedWindow(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public PaletteChangedEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public PaletteChangedEvent(int type)
			: this(wxPaletteChangedEvent_ctor(type)) { }

		//-----------------------------------------------------------------------------	
		
		public Window ChangedWindow
		{
			get { return (Window)FindObject(wxPaletteChangedEvent_GetChangedWindow(wxObject), typeof(Window)); }
			set { wxPaletteChangedEvent_SetChangedWindow(wxObject, Object.SafePtr(value)); }
		}
	}
}
