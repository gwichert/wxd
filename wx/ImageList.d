//-----------------------------------------------------------------------------
// wx.NET - ImageList.cs
//
// The wxImageList wrapper class.
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
	public enum wxImageList
	{
		wxIMAGE_LIST_NORMAL, // Normal icons
		wxIMAGE_LIST_SMALL,  // Small icons
		wxIMAGE_LIST_STATE   // State icons: unimplemented (see WIN32 documentation)
	}
	
	//---------------------------------------------------------------------

	public class ImageList : Object
	{
		public const int wxIMAGELIST_DRAW_NORMAL	= 0x0001;
		public const int wxIMAGELIST_DRAW_TRANSPARENT	= 0x0002;
		public const int wxIMAGELIST_DRAW_SELECTED	= 0x0004;
		public const int wxIMAGELIST_DRAW_FOCUSED	= 0x0008;
		
		//---------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxImageList_ctor(int width, int height, bool mask, int initialCount);
		[DllImport("wx-c")] static extern IntPtr wxImageList_ctor2();
		[DllImport("wx-c")] static extern int    wxImageList_AddBitmap1(IntPtr self, IntPtr bmp, IntPtr mask);
		[DllImport("wx-c")] static extern int    wxImageList_AddBitmap(IntPtr self, IntPtr bmp, IntPtr maskColour);
		[DllImport("wx-c")] static extern int    wxImageList_AddIcon(IntPtr self, IntPtr icon);
		[DllImport("wx-c")] static extern int    wxImageList_GetImageCount(IntPtr self);
		
		[DllImport("wx-c")] static extern bool   wxImageList_Draw(IntPtr self, int index, IntPtr dc, int x, int y, int flags, bool solidBackground);
		
		[DllImport("wx-c")] static extern bool   wxImageList_Create(IntPtr self, int width, int height, bool mask, int initialCount);
		
		[DllImport("wx-c")] static extern bool   wxImageList_Replace(IntPtr self, int index, IntPtr bitmap);
		
		[DllImport("wx-c")] static extern bool   wxImageList_Remove(IntPtr self, int index);
		[DllImport("wx-c")] static extern bool   wxImageList_RemoveAll(IntPtr self);
		
		//[DllImport("wx-c")] static extern IntPtr wxImageList_GetBitmap(IntPtr self, int index);
		
		[DllImport("wx-c")] static extern bool   wxImageList_GetSize(IntPtr self, int index, ref int width, ref int height);

		//---------------------------------------------------------------------

		public ImageList(int width, int height)
			: this(width, height, true, 1) {}
			
		public ImageList(int width, int height, bool mask)
			: this(width, height, mask, 1) {}

		public ImageList(int width, int height, bool mask, int initialCount)
			: base(wxImageList_ctor(width, height, mask, initialCount)) {}

		public ImageList(IntPtr wxObject) 
			: base(wxObject) {}
			
		public ImageList()
			: base(wxImageList_ctor2()) {}

		//---------------------------------------------------------------------

		public int Add(Bitmap bitmap)
		{
			return wxImageList_AddBitmap1(wxObject, Object.SafePtr(bitmap), IntPtr.Zero);
		}
		
		public int Add(Bitmap bitmap, Bitmap mask)
		{
			return wxImageList_AddBitmap1(wxObject, Object.SafePtr(bitmap), Object.SafePtr(mask));
		}

		public int Add(Icon icon)
		{
			return wxImageList_AddIcon(wxObject, Object.SafePtr(icon));
		}
		
		public int Add(Bitmap bmp, Colour maskColour)
		{
			return wxImageList_AddBitmap(wxObject, Object.SafePtr(bmp), Object.SafePtr(maskColour));
		}

		//---------------------------------------------------------------------
		
		public bool Create(int width, int height)
		{
			return Create(width, height, true, 1);
		}
		
		public bool Create(int width, int height, bool mask)
		{
			return Create(width, height, mask, 1);
		}
		
		public bool Create(int width, int height, bool mask, int initialCount)
		{
			return wxImageList_Create(wxObject, width, height, mask, initialCount);
		}
		
		//---------------------------------------------------------------------
		
		public int ImageCount
		{
			get { return wxImageList_GetImageCount(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool Draw(int index, DC dc, int x, int y)
		{
			return Draw(index, dc, x, y, wxIMAGELIST_DRAW_NORMAL, false);
		}
		
		public bool Draw(int index, DC dc, int x, int y, int flags)
		{
			return Draw(index, dc, x, y, flags, false);
		}
		
		public bool Draw(int index, DC dc, int x, int y, int flags, bool solidBackground)
		{
			return wxImageList_Draw(wxObject, index, Object.SafePtr(dc), x, y, flags, solidBackground);
		}
		
		//---------------------------------------------------------------------
		
		public bool Replace(int index, Bitmap bitmap)
		{
			return wxImageList_Replace(wxObject, index, Object.SafePtr(bitmap));
		}
		
		//---------------------------------------------------------------------
		
		public bool Remove(int index)
		{
			return wxImageList_Remove(wxObject, index);
		}
		
		//---------------------------------------------------------------------
		
		public bool RemoveAll()
		{
			return wxImageList_RemoveAll(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		/*public Bitmap GetBitmap(int index)
		{
			return (Bitmap)FindObject(wxImageList_GetBitmap(wxObject, index), typeof(Bitmap));
		}*/
		
		//---------------------------------------------------------------------
		
		public bool GetSize(int index, ref int width, ref int height)
		{
			return wxImageList_GetSize(wxObject, index, ref width, ref height);
		}
	}
}
