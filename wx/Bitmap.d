//-----------------------------------------------------------------------------
// wx.NET - Bitmap.cs
//
// The wxBitmap wrapper class.
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
	public enum BitmapType
	{
		wxBITMAP_TYPE_INVALID               = 0,
		wxBITMAP_TYPE_BMP,
		wxBITMAP_TYPE_BMP_RESOURCE,
		wxBITMAP_TYPE_RESOURCE              = wxBITMAP_TYPE_BMP_RESOURCE,
		wxBITMAP_TYPE_ICO,
		wxBITMAP_TYPE_ICO_RESOURCE,
		wxBITMAP_TYPE_CUR,
		wxBITMAP_TYPE_CUR_RESOURCE,
		wxBITMAP_TYPE_XBM,
		wxBITMAP_TYPE_XBM_DATA,
		wxBITMAP_TYPE_XPM,
		wxBITMAP_TYPE_XPM_DATA,
		wxBITMAP_TYPE_TIF,
		wxBITMAP_TYPE_TIF_RESOURCE,
		wxBITMAP_TYPE_GIF,
		wxBITMAP_TYPE_GIF_RESOURCE,
		wxBITMAP_TYPE_PNG,
		wxBITMAP_TYPE_PNG_RESOURCE,
		wxBITMAP_TYPE_JPEG,
		wxBITMAP_TYPE_JPEG_RESOURCE,
		wxBITMAP_TYPE_PNM,
		wxBITMAP_TYPE_PNM_RESOURCE,
		wxBITMAP_TYPE_PCX,
		wxBITMAP_TYPE_PCX_RESOURCE,
		wxBITMAP_TYPE_PICT,
		wxBITMAP_TYPE_PICT_RESOURCE,
		wxBITMAP_TYPE_ICON,
		wxBITMAP_TYPE_ICON_RESOURCE,
		wxBITMAP_TYPE_ANI,
		wxBITMAP_TYPE_IFF,
		wxBITMAP_TYPE_MACCURSOR,
		wxBITMAP_TYPE_MACCURSOR_RESOURCE,
		wxBITMAP_TYPE_ANY                   = 50
	}

	public class Bitmap : GDIObject
	{
		[DllImport("wx-c")] static extern IntPtr wxBitmap_ctor();
		[DllImport("wx-c")] static extern IntPtr wxBitmap_ctorByImage(IntPtr image, int depth);
		[DllImport("wx-c")] static extern IntPtr wxBitmap_ctorByName(string name, BitmapType type);
		[DllImport("wx-c")] static extern IntPtr wxBitmap_ctorBySize(int width, int height, int depth);
		[DllImport("wx-c")] static extern IntPtr wxBitmap_ctorByBitmap(IntPtr bitmap);
		//[DllImport("wx-c")] static extern void   wxBitmap_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		
		[DllImport("wx-c")] static extern IntPtr wxBitmap_ConvertToImage(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxBitmap_LoadFile(IntPtr self, string name, BitmapType type);
		[DllImport("wx-c")] static extern bool   wxBitmap_SaveFile(IntPtr self, string name, BitmapType type, IntPtr palette);
		[DllImport("wx-c")] static extern bool   wxBitmap_Ok(IntPtr self);
	
		[DllImport("wx-c")] static extern int    wxBitmap_GetHeight(IntPtr self);
		[DllImport("wx-c")] static extern void   wxBitmap_SetHeight(IntPtr self, int height);
	
		[DllImport("wx-c")] static extern int    wxBitmap_GetWidth(IntPtr self);
		[DllImport("wx-c")] static extern void   wxBitmap_SetWidth(IntPtr self, int width);
		
		[DllImport("wx-c")] static extern int    wxBitmap_GetDepth(IntPtr self);
		[DllImport("wx-c")] static extern void   wxBitmap_SetDepth(IntPtr self, int depth);
		
		[DllImport("wx-c")] static extern IntPtr wxBitmap_GetSubBitmap(IntPtr self, ref Rectangle rect);
		
		[DllImport("wx-c")] static extern IntPtr wxBitmap_GetMask(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxBitmap_SetMask(IntPtr self, IntPtr mask);
		
		[DllImport("wx-c")] static extern IntPtr wxBitmap_GetPalette(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxBitmap_CopyFromIcon(IntPtr self, IntPtr icon);
		
		[DllImport("wx-c")] static extern IntPtr wxBitmap_GetColourMap(IntPtr self);
	
		//---------------------------------------------------------------------

		static Bitmap()
		{
			Image.InitAllHandlers();
		}

		public Bitmap()
			: this(wxBitmap_ctor()) { }

		public Bitmap(Image image)
			: this(image, -1) { }

		public Bitmap(Image image, int depth)
			: this(wxBitmap_ctorByImage(image.wxObject, depth)) { }

		public Bitmap(string name)
			: this(wxBitmap_ctorByName(name, BitmapType.wxBITMAP_TYPE_ANY)) { }

		public Bitmap(string name, BitmapType type)
			: this(wxBitmap_ctorByName(name, type)) { }

		public Bitmap(int width, int height)
			: this(width, height, -1) { }

		public Bitmap(int width, int height, int depth)
			: this(wxBitmap_ctorBySize(width, height, depth)) {}
	    
		public Bitmap(Bitmap bitmap)
			: this(wxBitmap_ctorByBitmap(Object.SafePtr(bitmap))) {}

		public Bitmap(IntPtr wxObject) 
			: base(wxObject) { }
			
		//---------------------------------------------------------------------

		public Image ConvertToImage()
		{
			return new Image(wxBitmap_ConvertToImage(wxObject));
		}

		//---------------------------------------------------------------------

		public int Height
		{
			get { return wxBitmap_GetHeight(wxObject); }
			set { wxBitmap_SetHeight(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public bool LoadFile(string name, BitmapType type)
		{
			return wxBitmap_LoadFile(wxObject, name, type);
		}
	
		//---------------------------------------------------------------------
	
		public bool SaveFile(string name, BitmapType type)
		{
			return SaveFile(name, type, null);
		}
	
		public bool SaveFile(string name, BitmapType type, Palette palette)
		{
			return wxBitmap_SaveFile(wxObject, name, type, Object.SafePtr(palette));
		}

		//---------------------------------------------------------------------

		public int Width
		{
			get { return wxBitmap_GetWidth(wxObject); }
			set { wxBitmap_SetWidth(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public virtual bool Ok()
		{
			return wxBitmap_Ok(wxObject);
		}

		//---------------------------------------------------------------------
	
		public int Depth
		{
			get { return wxBitmap_GetDepth(wxObject); }
			set { wxBitmap_SetDepth(wxObject, value); }
		}
	
		//---------------------------------------------------------------------
	
		public Bitmap GetSubBitmap(Rectangle rect)
		{
			return new Bitmap(wxBitmap_GetSubBitmap(wxObject, ref rect));
		}
	
		//---------------------------------------------------------------------
	
		public Mask Mask
		{
			get { return new Mask(wxBitmap_GetMask(wxObject)); }
			set { wxBitmap_SetMask(wxObject, Object.SafePtr(value)); }
		}
	
		//---------------------------------------------------------------------
	
		public Palette Palette
		{
			get { return new Palette(wxBitmap_GetPalette(wxObject)); }
		}
	
		//---------------------------------------------------------------------
	
		public Palette ColourMap
		{
			get { return new Palette(wxBitmap_GetColourMap(wxObject)); }
		}
	
		//---------------------------------------------------------------------
		
		public bool CopyFromIcon(Icon icon)
		{
			return wxBitmap_CopyFromIcon(wxObject, Object.SafePtr(icon));
		}
	}
    
	//---------------------------------------------------------------------
    
	public class Mask : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxMask_ctor();
		[DllImport("wx-c")] static extern IntPtr wxMask_ctorByBitmpaColour(IntPtr bitmap, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxMask_ctorByBitmapIndex(IntPtr bitmap, int paletteIndex);
		[DllImport("wx-c")] static extern IntPtr wxMask_ctorByBitmap(IntPtr bitmap);
		
		[DllImport("wx-c")] static extern bool wxMask_CreateByBitmapColour(IntPtr self, IntPtr bitmap, IntPtr colour);
		[DllImport("wx-c")] static extern bool wxMask_CreateByBitmapIndex(IntPtr self, IntPtr bitmap, int paletteIndex);
		[DllImport("wx-c")] static extern bool wxMask_CreateByBitmap(IntPtr self, IntPtr bitmap);
		
		//---------------------------------------------------------------------
		
		public Mask()
			: this(wxMask_ctor()) {}
			
		public Mask(Bitmap bitmap, Colour colour)
			: this(wxMask_ctorByBitmpaColour(Object.SafePtr(bitmap), Object.SafePtr(colour))) {}
			
		public Mask(Bitmap bitmap, int paletteIndex)
			: this(wxMask_ctorByBitmapIndex(Object.SafePtr(bitmap), paletteIndex)) {}
			
		public Mask(Bitmap bitmap)
			: this(wxMask_ctorByBitmap(Object.SafePtr(bitmap))) {}
		
		public Mask(IntPtr wxObject)
			: base(wxObject) {}
			
		//---------------------------------------------------------------------
			
		public bool Create(Bitmap bitmap, Colour colour)
		{
			return wxMask_CreateByBitmapColour(wxObject, Object.SafePtr(bitmap), Object.SafePtr(colour));
		}
		
		public bool Create(Bitmap bitmap, int paletteIndex)
		{
			return wxMask_CreateByBitmapIndex(wxObject, Object.SafePtr(bitmap), paletteIndex);
		}
		
		public bool Create(Bitmap bitmap)
		{
			return wxMask_CreateByBitmap(wxObject, Object.SafePtr(bitmap));
		}
	}
}
