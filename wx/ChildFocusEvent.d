//-----------------------------------------------------------------------------
// wxD - ChildFocusEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - ChildFocusEvent.cs
//
// The wxChildFocusEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.ChildFocusEvent;
import wx.common;
import wx.CommandEvent;
import wx.Window;

		static extern (C) IntPtr wxChildFocusEvent_ctor(IntPtr win);
		static extern (C) IntPtr wxChildFocusEvent_GetWindow(IntPtr self);
		
		//-----------------------------------------------------------------------------

	public class ChildFocusEvent : CommandEvent
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }
			
		public this(Window win)
			{ super(wxChildFocusEvent_ctor(wxObject.SafePtr(win))); }

		//-----------------------------------------------------------------------------	
		
		public Window window() { return cast(Window)FindObject(wxChildFocusEvent_GetWindow(wxobj), &Window.New); }

		private static Event New(IntPtr obj) { return new ChildFocusEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_CHILD_FOCUS,				&ChildFocusEvent.New);
		}
	}
