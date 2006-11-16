//-----------------------------------------------------------------------------
// wxD - PaletteChangedEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.PaletteChangedEvent;
import wx.common;
import wx.Event;
import wx.Window;

		static extern (C) IntPtr wxPaletteChangedEvent_ctor(int type);
		static extern (C) void wxPaletteChangedEvent_SetChangedWindow(IntPtr self, IntPtr win);
		static extern (C) IntPtr wxPaletteChangedEvent_GetChangedWindow(IntPtr self);
		
		//-----------------------------------------------------------------------------

	public class PaletteChangedEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(int type)
			{ this(wxPaletteChangedEvent_ctor(type)); }

		//-----------------------------------------------------------------------------	
		
		public Window ChangedWindow() { return cast(Window)FindObject(wxPaletteChangedEvent_GetChangedWindow(wxobj), &Window.New); }
		public void ChangedWindow(Window value) { wxPaletteChangedEvent_SetChangedWindow(wxobj, wxObject.SafePtr(value)); }

		private static Event New(IntPtr obj) { return new PaletteChangedEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_PALETTE_CHANGED,			&PaletteChangedEvent.New);
		}
	}
