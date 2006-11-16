//-----------------------------------------------------------------------------
// wxD - DisplayChangedEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - DisplayChangedEvent.cs
//
// The wxDisplayChangedEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.DisplayChangedEvent;
import wx.common;
import wx.Event;

		static extern (C) IntPtr wxDisplayChangedEvent_ctor();
		
		//-----------------------------------------------------------------------------

	public class DisplayChangedEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this()
			{ this(wxDisplayChangedEvent_ctor()); }

		private static Event New(IntPtr obj) { return new DisplayChangedEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_DISPLAY_CHANGED,			&DisplayChangedEvent.New);
		}
	}
