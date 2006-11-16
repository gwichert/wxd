//-----------------------------------------------------------------------------
// wxD - ContextMenuEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - ContextMenuEvent.cs
//
// The wxContextMenuEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.ContextMenuEvent;
import wx.common;
import wx.CommandEvent;

		static extern (C) IntPtr wxContextMenuEvent_ctor(int type);
		static extern (C) void   wxContextMenuEvent_GetPosition(IntPtr self, inout Point pos);
		static extern (C) void   wxContextMenuEvent_SetPosition(IntPtr self, inout Point pos);
		
		//-----------------------------------------------------------------------------

	public class ContextMenuEvent : CommandEvent
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(int type)
			{ this(wxContextMenuEvent_ctor(type)); }

		//-----------------------------------------------------------------------------	
		
		public Point Position() { 
				Point p;
				wxContextMenuEvent_GetPosition(wxobj, p); 
				return p;
			}
			
		public void Position(Point value) { wxContextMenuEvent_SetPosition(wxobj, value); }

		private static Event New(IntPtr obj) { return new ContextMenuEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_CONTEXT_MENU,			&ContextMenuEvent.New);
		}
	}
