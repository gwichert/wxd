//-----------------------------------------------------------------------------
// wx.NET - StaticBitmap.cs
//
// The wxStaticBitmap wrapper class.
//
// Written by Robert Roebling
// (C) 2003 Robert Roebling
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class StaticBitmap : Control
	{
		[DllImport("wx-c")] static extern IntPtr wxStaticBitmap_ctor();
		[DllImport("wx-c")] static extern bool wxStaticBitmap_Create(IntPtr self, IntPtr parent, int id, IntPtr label, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void wxStaticBitmap_SetBitmap(IntPtr self, IntPtr bitmap);
		[DllImport("wx-c")] static extern IntPtr wxStaticBitmap_GetBitmap(IntPtr self);

		//---------------------------------------------------------------------

		public StaticBitmap()
			: base(wxStaticBitmap_ctor()) { }

		public StaticBitmap(IntPtr wxObject) 
			: base(wxObject) { }

		public StaticBitmap(Window parent, int id, Bitmap label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public StaticBitmap(Window parent, int id, Bitmap label, Point pos)
			: this(parent, id, label, pos, wxDefaultSize, 0, null) { }

		public StaticBitmap(Window parent, int id, Bitmap label, Point pos, Size size)
			: this(parent, id, label, pos, size, 0, null) { }

		public StaticBitmap(Window parent, int id, Bitmap label, Point pos, Size size, long style)
			: this(parent, id, label, pos, size, style, null) { }

		public StaticBitmap(Window parent, int id, Bitmap label, Point pos, Size size, long style, string name)
		: base(wxStaticBitmap_ctor())
		{
			if (!Create(parent, id, label, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticBitmap");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public StaticBitmap(Window parent, Bitmap label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public StaticBitmap(Window parent, Bitmap label, Point pos)
			: this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null) { }

		public StaticBitmap(Window parent, Bitmap label, Point pos, Size size)
			: this(parent, Window.UniqueID, label, pos, size, 0, null) { }

		public StaticBitmap(Window parent, Bitmap label, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, label, pos, size, style, null) { }

		public StaticBitmap(Window parent, Bitmap label, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, label, pos, size, style, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Bitmap label, Point pos, Size size, long style, string name)
		{
			return wxStaticBitmap_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(label), ref pos, ref size, (uint)style, name);
		}

		//---------------------------------------------------------------------

		public wx.Bitmap Bitmap
		{
			set { wxStaticBitmap_SetBitmap(wxObject, Object.SafePtr(value)); }
			get { return (Bitmap)FindObject(wxStaticBitmap_GetBitmap(wxObject), typeof(Bitmap)); }
		}
	}
}
