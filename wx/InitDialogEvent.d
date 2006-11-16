//-----------------------------------------------------------------------------
// wxD - InitDialogEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - InitDialogEvent.cs
//
// The wxInitDialogEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.InitDialogEvent;
import wx.common;
import wx.Event;

		static extern (C) IntPtr wxInitDialogEvent_ctor(int Id);
		
		//-----------------------------------------------------------------------------

	public class InitDialogEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }
			
		public this()
			{ super(wxInitDialogEvent_ctor(0));}

		public this(int Id)
			{ this(wxInitDialogEvent_ctor(Id)); }

		private static Event New(IntPtr obj) { return new InitDialogEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_INIT_DIALOG,				&InitDialogEvent.New);
		}
	}
