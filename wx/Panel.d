//-----------------------------------------------------------------------------
// wx.NET - Panel.cs
//
// The wxPanel wrapper class.
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
	public class Panel : Window
	{
		[DllImport("wx-c")] static extern IntPtr wxPanel_ctor();
		[DllImport("wx-c")] static extern IntPtr wxPanel_ctor2(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern bool wxPanel_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void wxPanel_InitDialog(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxPanel_GetDefaultItem(IntPtr self);
		[DllImport("wx-c")] static extern void wxPanel_SetDefaultItem(IntPtr self, IntPtr btn);

		//---------------------------------------------------------------------
		
		public Panel(IntPtr wxObject) 
			: base(wxObject) {}
		
		public Panel()
			: base(wxPanel_ctor()) {}

		public Panel(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL|wxNO_BORDER, "panel") { }

		public Panel(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL|wxNO_BORDER, "panel") { }

		public Panel(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxTAB_TRAVERSAL|wxNO_BORDER, "panel") { }

		public Panel(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "panel") { }

		public Panel(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxPanel_ctor2(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name)) {}
			
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Panel(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxTAB_TRAVERSAL|wxNO_BORDER, "panel") { }

		public Panel(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "panel") { }

		public Panel(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//---------------------------------------------------------------------
		
		public bool Create(Window parent, int id, Point pos, Size size, long style, string name)
		{
			return wxPanel_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name);
		}

		//---------------------------------------------------------------------

		public Button DefaultItem
		{
			get
			{
				IntPtr btn = wxPanel_GetDefaultItem(wxObject);
				return (btn != IntPtr.Zero) ? new Button(btn) : null;
			}
			set
			{
				wxPanel_SetDefaultItem(wxObject, value.wxObject);
			}
		}

		//---------------------------------------------------------------------

		public override void InitDialog()
		{
			wxPanel_InitDialog(wxObject);
		}

		//---------------------------------------------------------------------
	}
}
