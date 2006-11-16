//-----------------------------------------------------------------------------
// wx.NET - StaticBox.cs
//
// The wxStaticBox wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class StaticBox : Control
	{
		[DllImport("wx-c")] static extern IntPtr wxStaticBox_ctor();
		[DllImport("wx-c")] static extern bool wxStaticBox_Create(IntPtr self, IntPtr parent, int id, string label, ref Point pos, ref Size size, uint style, string name);
	
		//---------------------------------------------------------------------

		public StaticBox()
			: base(wxStaticBox_ctor()) { }

		public StaticBox(IntPtr wxObject)
			: base(wxObject) { }
			
		public StaticBox(Window window, int id, string label)
			: this(window, id, label, wxDefaultPosition, wxDefaultSize, 0, null) { }
			
		public StaticBox(Window window, int id, string label, Point pos)
			: this(window, id, label, pos, wxDefaultSize, 0, null) { }

		public StaticBox(Window window, int id, string label, Point pos, Size size)
			: this(window, id, label, pos, size, 0, null) { }

		public StaticBox(Window window, int id, string label, Point pos, Size size, long style)
			: this(window, id, label, pos, size, style, null) { }

		public StaticBox(Window window, int id, string label, Point pos, Size size, long style, string name)
			: this()
		{
			if (!Create(window, id, label, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticBox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public StaticBox(Window window, string label)
			: this(window, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null) { }
			
		public StaticBox(Window window, string label, Point pos)
			: this(window, Window.UniqueID, label, pos, wxDefaultSize, 0, null) { }

		public StaticBox(Window window, string label, Point pos, Size size)
			: this(window, Window.UniqueID, label, pos, size, 0, null) { }

		public StaticBox(Window window, string label, Point pos, Size size, long style)
			: this(window, Window.UniqueID, label, pos, size, style, null) { }

		public StaticBox(Window window, string label, Point pos, Size size, long style, string name)
			: this(window, Window.UniqueID, label, pos, size, style, name) {}

		//---------------------------------------------------------------------

		public bool Create(Window window, int id, string label, Point pos, Size size, long style, string name)
		{
			return wxStaticBox_Create(wxObject, Object.SafePtr(window), 
					id, label, ref pos, ref size, 
					(uint)style, name);
		}
	}
}
