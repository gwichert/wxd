//-----------------------------------------------------------------------------
// wxD - MaximizeEvent.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - MaximizeEvent.cs
//
// The wxMaximizeEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.MaximizeEvent;
import wx.common;

import wx.Event;

		//! \cond EXTERN
		static extern (C) IntPtr wxMaximizeEvent_ctor(int Id);
		//! \endcond
		
		//-----------------------------------------------------------------------------

	public class MaximizeEvent : Event
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }
			
		public this(int Id = 0)
			{ this(wxMaximizeEvent_ctor(Id)); }

		private static Event New(IntPtr obj) { return new MaximizeEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_MAXIMIZE,				&MaximizeEvent.New);		}
	}
