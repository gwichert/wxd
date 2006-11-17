//-----------------------------------------------------------------------------
// wxD - HelpEvent.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - HelpEvent.cs
//
// The wxHelpEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.HelpEvent;
import wx.common;
import wx.CommandEvent;
import wx.Window;

		//! \cond EXTERN
		static extern (C) IntPtr wxHelpEvent_ctor(int type,int winid, inout Point pos);
		static extern (C) void   wxHelpEvent_GetPosition(IntPtr self, inout Point pos);
		static extern (C) void   wxHelpEvent_SetPosition(IntPtr self, inout Point pos);
		static extern (C) string wxHelpEvent_GetLink(IntPtr self);
		static extern (C) void   wxHelpEvent_SetLink(IntPtr self, string link);
		static extern (C) string wxHelpEvent_GetTarget(IntPtr self);
		static extern (C) void   wxHelpEvent_SetTarget(IntPtr self, string target);
		//! \endcond
		
		//-----------------------------------------------------------------------------

	public class HelpEvent : CommandEvent
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(EventType type = wxEVT_NULL, int winid = 0, Point pos = Window.wxDefaultPosition)
			{ this(wxHelpEvent_ctor(type,winid,pos)); }

		//-----------------------------------------------------------------------------	
		
		public Point Position() { 
				Point p;
				wxHelpEvent_GetPosition(wxobj, p); 
				return p;
			}
			
		public void Position(Point value) { wxHelpEvent_SetPosition(wxobj, value); }
		
		//-----------------------------------------------------------------------------	
		
		public string Link() { return wxHelpEvent_GetLink(wxobj).dup; }
		public void Link(string value) { wxHelpEvent_SetLink(wxobj, value); }
		
		//-----------------------------------------------------------------------------	
		
		public string Target() { return wxHelpEvent_GetTarget(wxobj).dup; }
		public void Target(string value) { wxHelpEvent_SetTarget(wxobj, value); }


		private static Event New(IntPtr obj) { return new HelpEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_HELP,				&HelpEvent.New);
			AddEventType(wxEVT_DETAILED_HELP,			&HelpEvent.New);
		}
	}
