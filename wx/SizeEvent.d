//-----------------------------------------------------------------------------
// wxD - SizeEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.SizeEvent;
import wx.common;
import wx.Event;

		static extern (C) IntPtr wxSizeEvent_ctor();
		static extern (C) void wxSizeEvent_GetSize(IntPtr self, out Size size);
		
		//-----------------------------------------------------------------------------

	public class SizeEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this()
			{ this(wxSizeEvent_ctor()); }

		//-----------------------------------------------------------------------------	
		
		public Size size() {
				Size size;
				wxSizeEvent_GetSize(wxobj, size);
				return size;
			}

		private static Event New(IntPtr obj) { return new SizeEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_SIZE,                            &SizeEvent.New);
		}
	}
