//-----------------------------------------------------------------------------
// wx.NET - Control.cs
//
// The wxControl wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class Control : Window
	{
		[DllImport("wx-c")] static extern void   wxControl_Command(IntPtr self, IntPtr evt);
		[DllImport("wx-c")] static extern IntPtr wxControl_GetLabel(IntPtr self);
		[DllImport("wx-c")] static extern void   wxControl_SetLabel(IntPtr self, string label);
		
		[DllImport("wx-c")] static extern int wxControl_GetAlignment(IntPtr self);
		[DllImport("wx-c")] static extern bool wxControl_SetFont(IntPtr self, IntPtr font);

		//---------------------------------------------------------------------

		public Control(IntPtr wxObject) 
			: base(wxObject) {}

		public Control(Window parent, int id, Point pos, Size size, long style, string name)
			: base(parent, id, pos, size, style, name) {}
		
		public Control(Window parent, Point pos, Size size, long style, string name)
			: base(parent, Window.UniqueID, pos, size, style, name) {}

		//---------------------------------------------------------------------

		public void Command() {}

		//---------------------------------------------------------------------

		public string Label 
		{
			get { return new wxString(wxControl_GetLabel(wxObject), true); }
			set { wxControl_SetLabel(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public int GetAlignment()
		{
			return wxControl_GetAlignment(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public bool SetFont(Font font)
		{
			return wxControl_SetFont(wxObject, Object.SafePtr(font));
		}
	}
}

