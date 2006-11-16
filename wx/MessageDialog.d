//-----------------------------------------------------------------------------
// wx.NET - MessageDialog.cs
//
// The wxMessageDialog wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	// The MessageDialog class implements the interface for wxWidgets' 
	// wxMessageDialog class and wxMessageBox.

	public class MessageDialog : Dialog
	{
		// MessageBox function
		[DllImport("wx-c")] static extern int    wxMsgBox(IntPtr parent, string msg, string cap, uint style, ref Point pos);

		// Message dialog methods
		[DllImport("wx-c")] static extern IntPtr wxMessageDialog_ctor(IntPtr parent, string message, string caption, uint style, ref Point pos);
		[DllImport("wx-c")] static extern int    wxMessageDialog_ShowModal(IntPtr self);

		//---------------------------------------------------------------------
	
		internal MessageDialog(IntPtr wxObject) 
			: base(wxObject) { }

		public MessageDialog(Window parent, string msg)
			: this(parent, msg, "Message box", wxOK | wxCANCEL | wxCENTRE, wxDefaultPosition) { }

		public MessageDialog(Window parent, string msg, string caption)
			: this(parent, msg, caption, wxOK | wxCANCEL | wxCENTRE, wxDefaultPosition) { }

		public MessageDialog(Window parent, string msg, string caption, long style)
			: this(parent, msg, caption, style, wxDefaultPosition) { }

		public MessageDialog(Window parent, string msg, string caption, long style, Point pos)
			: this(wxMessageDialog_ctor(Object.SafePtr(parent), msg, caption, (uint)style, ref pos)) { } 

		//---------------------------------------------------------------------

		public override int ShowModal()
		{
			return wxMessageDialog_ShowModal(wxObject);
		}

		//---------------------------------------------------------------------

		// MessageBox interface

		public static int ShowModal(string msg, string caption, long style)
		{
			return ShowModal(null, msg, caption, style, new Point(-1, -1));
		}

		public static int ShowModal(Window parent, string msg, string caption, long style)
		{
			return ShowModal(parent, msg, caption, (uint)style, new Point(-1, -1));
		}	

		public static int ShowModal(Window parent, string msg, string caption, long style, Point pos)
		{
			IntPtr hParent = (parent != null) ? parent.wxObject : IntPtr.Zero;
			return wxMsgBox(hParent, msg, caption, (uint)style, ref pos);
		}
		
		public static int MessageBox(string msg)
		{
			return ShowModal(null, msg, "Message", wxOK, new Point(-1, -1));
		}
		
		public static int MessageBox(string msg, string caption)
		{
			return ShowModal(null, msg, caption, wxOK, new Point(-1, -1));
		}
		
		public static int MessageBox(string msg, string caption, long style)
		{
			return ShowModal(null, msg, caption, style, new Point(-1, -1));
		}
		
		public static int MessageBox(string msg, string caption, long style, Window parent)
		{
			return ShowModal(parent, msg, caption, style, new Point(-1, -1));
		}
		
		public static int MessageBox(string msg, string caption, long style, Window parent, Point pos)
		{
			return ShowModal(parent, msg, caption, style, pos);
		}
	}
}
