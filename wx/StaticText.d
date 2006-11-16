//-----------------------------------------------------------------------------
// wx.NET - StaticText.cs
//
// The wxStaticText wrapper class.
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
	public class StaticText : Control
	{
		public const long wxST_NO_AUTORESIZE = 0x0001;
	
		[DllImport("wx-c")] static extern IntPtr wxStaticText_ctor();
		[DllImport("wx-c")] static extern bool wxStaticText_Create(IntPtr self, IntPtr parent, int id, string label, ref Point pos, ref Size size, uint style, string name);

		//---------------------------------------------------------------------
		
		public StaticText(IntPtr wxObject) 
			: base(wxObject) {}

		public StaticText()
			: base(wxStaticText_ctor())	{ }

		public StaticText(Window parent, int id, string label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public StaticText(Window parent, int id, string label, Point pos)
			: this(parent, id, label, pos, wxDefaultSize, 0, null) { }

		public StaticText(Window parent, int id, string label, Point pos, Size size)
			: this(parent, id, label, pos, size, 0, null) { }

		public StaticText(Window parent, int id, string label, Point pos, Size size, long style)
			: this(parent, id, label, pos, size, style, null) { }
			
		public StaticText(Window parent, int id, string label, Point pos, Size size, long style, string name)
			: base(wxStaticText_ctor())
		{
			if (!Create(parent, id, label, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticText");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public StaticText(Window parent, string label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public StaticText(Window parent, string label, Point pos)
			: this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null) { }

		public StaticText(Window parent, string label, Point pos, Size size)
			: this(parent, Window.UniqueID, label, pos, size, 0, null) { }

		public StaticText(Window parent, string label, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, label, pos, size, style, null) { }
			
		public StaticText(Window parent, string label, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, label, pos, size, style, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size, long style, string name)
		{
			return wxStaticText_Create(wxObject, Object.SafePtr(parent), id, label, ref pos, ref size, (uint)style, name);
		}
	}
}
