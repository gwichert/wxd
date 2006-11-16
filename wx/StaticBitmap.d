//-----------------------------------------------------------------------------
// wxD - StaticBitmap.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.StaticBitmap;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxStaticBitmap_ctor();
		static extern (C) bool wxStaticBitmap_Create(IntPtr self, IntPtr parent, int id, IntPtr label, inout Point pos, inout Size size, uint style, string name);
		static extern (C) void wxStaticBitmap_SetBitmap(IntPtr self, IntPtr bitmap);
		static extern (C) IntPtr wxStaticBitmap_GetBitmap(IntPtr self);

		//---------------------------------------------------------------------

	public class StaticBitmap : Control
	{
		public const string wxStaticBitmapNameStr = "message";

		public this()
			{ super(wxStaticBitmap_ctor()); }

		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this(Window parent, int id, Bitmap label, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = 0, string name = wxStaticBitmapNameStr)
		{
			super(wxStaticBitmap_ctor());
			if (!Create(parent, id, label, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticBitmap");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, Bitmap label, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = 0, string name = wxStaticBitmapNameStr)
			{ this(parent, Window.UniqueID, label, pos, size, style, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Bitmap label, inout Point pos, inout Size size, int style, string name)
		{
			return wxStaticBitmap_Create(wxobj, wxObject.SafePtr(parent), id, wxObject.SafePtr(label), pos, size, cast(uint)style, name);
		}

		//---------------------------------------------------------------------

		public void bitmap(Bitmap value) { wxStaticBitmap_SetBitmap(wxobj, wxObject.SafePtr(value)); }
		public Bitmap bitmap() { return cast(Bitmap)FindObject(wxStaticBitmap_GetBitmap(wxobj), &Bitmap.New); }
	}
