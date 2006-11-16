//-----------------------------------------------------------------------------
// wxD - PaintEvent.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - PaintEvent.cs
//
// The wxPaintEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.PaintEvent;
import wx.common;
import wx.Event;

		static extern (C) IntPtr wxPaintEvent_ctor(int Id);
		
		//-----------------------------------------------------------------------------

	public class PaintEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(int Id)
			{ this(wxPaintEvent_ctor(Id)); }
	}
