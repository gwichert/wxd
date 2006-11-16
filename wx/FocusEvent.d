//-----------------------------------------------------------------------------
// wxD - FocusEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - FocusEvent.cs
//
// The wxFocusEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.FocusEvent;
import wx.common;
import wx.Window;
import wx.Event;

		static extern (C) IntPtr wxFocusEvent_ctor(int type);
		static extern (C) IntPtr wxFocusEvent_GetWindow(IntPtr self);
		static extern (C) void   wxFocusEvent_SetWindow(IntPtr self, IntPtr win);
		
		//-----------------------------------------------------------------------------

	public class FocusEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(int type)
			{ this(wxFocusEvent_ctor(type)); }

		//-----------------------------------------------------------------------------	
		
		public Window window() { return cast(Window)FindObject(wxFocusEvent_GetWindow(wxobj), &Window.New); }
		public void window(Window value) { wxFocusEvent_SetWindow(wxobj, wxObject.SafePtr(value)); }

		private static Event New(IntPtr obj) { return new FocusEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_SET_FOCUS,				&FocusEvent.New);
			AddEventType(wxEVT_KILL_FOCUS,				&FocusEvent.New);
		}
	}
