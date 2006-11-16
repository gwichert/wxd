//-----------------------------------------------------------------------------
// wx.NET - SetCursorEvent.cs
//
// The wxSetCursorEvent wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class SetCursorEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr	wxSetCursorEvent_ctor(int type);
		[DllImport("wx-c")] static extern int		wxSetCursorEvent_GetX(IntPtr self);
		[DllImport("wx-c")] static extern int		wxSetCursorEvent_GetY(IntPtr self);
		[DllImport("wx-c")] static extern void		wxSetCursorEvent_SetCursor(IntPtr self, IntPtr cursor);
		[DllImport("wx-c")] static extern IntPtr	wxSetCursorEvent_GetCursor(IntPtr self);
		[DllImport("wx-c")] static extern bool		wxSetCursorEvent_HasCursor(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public SetCursorEvent(IntPtr wxObject) 
			: base(wxObject) { }

		public SetCursorEvent(int type)
			: this(wxSetCursorEvent_ctor(type)) { }

		//-----------------------------------------------------------------------------	
		
		public int X
		{
			get { return wxSetCursorEvent_GetX(wxObject); }
		}
		
		//-----------------------------------------------------------------------------	
		
		public int Y
		{
			get { return wxSetCursorEvent_GetY(wxObject); }
		}
		
		//-----------------------------------------------------------------------------	
		
		public Cursor Cursor
		{
			get { return (Cursor)FindObject(wxSetCursorEvent_GetCursor(wxObject), typeof(Cursor)); }
			set { wxSetCursorEvent_SetCursor(wxObject, Object.SafePtr(value)); }
		}
		
		//-----------------------------------------------------------------------------	
		
		public bool HasCursor
		{
			get { return wxSetCursorEvent_HasCursor(wxObject); }
		}
	}
}
