//-----------------------------------------------------------------------------
// wxD - Icon.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - Icon.cs
//
/// The wxIcon wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Icon;
public import wx.common;
public import wx.Bitmap;

		//! \cond EXTERN
		static extern (C) IntPtr wxIcon_ctor();
		static extern (C) void   wxIcon_CopyFromBitmap(IntPtr self, IntPtr bitmap);
		static extern (C) bool   wxIcon_LoadFile(IntPtr self, string name, BitmapType type);
		//! \endcond

		//---------------------------------------------------------------------

	alias Icon wxIcon;
	public class Icon : Bitmap
	{
		public static Icon wxNullIcon;
		public this(string name)
		{
			this();
			Image img = new Image();
			if (!img.LoadFile(name))
				throw new ArgumentException("file '" ~ name ~ "' not found");

			Bitmap bmp = new Bitmap(img);
			wxIcon_CopyFromBitmap(wxobj, bmp.wxobj);
		}

		public this(string name, BitmapType type)
		{
			this();
//			if (type == BitmapType.wxBITMAP_TYPE_RESOURCE)
//			else
			if (!wxIcon_LoadFile(wxobj, name, type))
				throw new ArgumentException("file '" ~ name ~ "' can't load");
		}

		public this()
		{
			super(wxIcon_ctor());
		}
		
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		//---------------------------------------------------------------------

		public void CopyFromBitmap(Bitmap bitmap)
		{
			wxIcon_CopyFromBitmap(wxobj, wxObject.SafePtr(bitmap));
		}

		//---------------------------------------------------------------------
	}
