//-----------------------------------------------------------------------------
// wxD - NCPaintEvent.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - NCPaintEvent.cs
//
// The wxNCPaintEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.NcPaintEvent;
import wx.common;

import wx.Event;

		//! \cond EXTERN
		static extern (C) IntPtr wxNcPaintEvent_ctor(int Id);
		//! \endcond
		
		//-----------------------------------------------------------------------------

	public class NCPaintEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(int Id=0)
			{ this(wxNcPaintEvent_ctor(Id)); }

		private static Event New(IntPtr obj) { return new NCPaintEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_NC_PAINT,				&NCPaintEvent.New);
		}
	}
