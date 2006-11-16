//-----------------------------------------------------------------------------
// wxD - ShowEvent.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - ShowEvent.cs
//
// The wxShowEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.ShowEvent;
import wx.common;

import wx.Event;

		static extern (C) IntPtr wxShowEvent_ctor(int winid, bool show);
		static extern (C) bool wxShowEvent_GetShow(IntPtr self);
		static extern (C) void wxShowEvent_SetShow(IntPtr self, bool show);
		
		//-----------------------------------------------------------------------------

	public class ShowEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(int winid = 0, bool show = false)
			{ this(wxShowEvent_ctor(winid,show)); }

		//-----------------------------------------------------------------------------	
		
		public bool Show() { return wxShowEvent_GetShow(wxobj); }
		public void Show(bool value) { wxShowEvent_SetShow(wxobj, value); }

		private static Event New(IntPtr obj) { return new ShowEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_SHOW,				&ShowEvent.New);
		}
	}
