//-----------------------------------------------------------------------------
// wx.NET - CommandEvent.cs
//
// The wxCommandEvent wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class CommandEvent : Event
	{

		[DllImport("wx-c")] static extern int    wxCommandEvent_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxCommandEvent_GetString(IntPtr self);
		[DllImport("wx-c")] static extern void wxCommandEvent_SetString(IntPtr self, string s);
		[DllImport("wx-c")] static extern bool   wxCommandEvent_IsChecked(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxCommandEvent_IsSelection(IntPtr self);
		[DllImport("wx-c")] static extern int    wxCommandEvent_GetInt(IntPtr self);
		[DllImport("wx-c")] static extern void wxCommandEvent_SetInt(IntPtr self, int i);

		[DllImport("wx-c")] static extern IntPtr wxCommandEvent_GetClientObject(IntPtr self);
		[DllImport("wx-c")] static extern void   wxCommandEvent_SetClientObject(IntPtr self, IntPtr data);
		
		[DllImport("wx-c")] static extern void wxCommandEvent_SetExtraLong(IntPtr self, uint extralong);
		[DllImport("wx-c")] static extern uint wxCommandEvent_GetExtraLong(IntPtr self);

		//-----------------------------------------------------------------------------

		public CommandEvent(IntPtr wxObject) 
			: base(wxObject) { }

		//-----------------------------------------------------------------------------

		public int Selection
		{
			get { return wxCommandEvent_GetSelection(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public string String
		{
			get { return new wxString(wxCommandEvent_GetString(wxObject), true); }
			set { wxCommandEvent_SetString(wxObject, value); }
		}

		//-----------------------------------------------------------------------------

		public bool IsChecked
		{
			get { return wxCommandEvent_IsChecked(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public bool IsSelection
		{
			get { return wxCommandEvent_IsSelection(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public int Int
		{
			get { return wxCommandEvent_GetInt(wxObject); }
			set { wxCommandEvent_SetInt(wxObject, value); }
		}

		//-----------------------------------------------------------------------------

		public ClientData ClientObject
		{
			get { return (ClientData)Object.FindObject(wxCommandEvent_GetClientObject(wxObject)); }
			set { wxCommandEvent_SetClientObject(wxObject, Object.SafePtr(value)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public long ExtraLong
		{
			get { return (long)wxCommandEvent_GetExtraLong(wxObject); }
			set { wxCommandEvent_SetExtraLong(wxObject, (uint)value); }
		}
	}
}
