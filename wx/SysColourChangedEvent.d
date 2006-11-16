//-----------------------------------------------------------------------------
// wxD - SysColourChangedEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - SysColourChangedEvent.cs
//
// The wxSysColourChangedEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.SysColourChangedEvent;
import wx.common;
import wx.Event;

		static extern (C) IntPtr wxSysColourChangedEvent_ctor();
		
		//-----------------------------------------------------------------------------

	public class SysColourChangedEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this()
			{ this(wxSysColourChangedEvent_ctor()); }

		private static Event New(IntPtr obj) { return new SysColourChangedEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_SYS_COLOUR_CHANGED,			&SysColourChangedEvent.New);
		}
	}
