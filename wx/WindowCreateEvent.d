//-----------------------------------------------------------------------------
// wxD - WindowCreateEvent.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - WindowCreateEvent.cs
//
// The wxWindowCreateEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.WindowCreateEvent;
import wx.common;

import wx.CommandEvent;

import wx.Window;

		static extern (C) IntPtr wxWindowCreateEvent_ctor(IntPtr type);
		static extern (C) IntPtr wxWindowCreateEvent_GetWindow(IntPtr self);
		
		//-----------------------------------------------------------------------------

	public class WindowCreateEvent : CommandEvent
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(Window win = null)
			{ this(wxWindowCreateEvent_ctor(wxObject.SafePtr(win))); }

		//-----------------------------------------------------------------------------	
		
		public Window Active() { return cast(Window)FindObject(wxWindowCreateEvent_GetWindow(wxobj), &Window.New); }

		private static Event New(IntPtr obj) { return new WindowCreateEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_CREATE,				&WindowCreateEvent.New);
		}
	}
