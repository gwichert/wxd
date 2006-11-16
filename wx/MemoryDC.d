//-----------------------------------------------------------------------------
// wx.NET - MemoryDC.cs
// 
// The wxBufferedDC and wxMemoryDC wrapper classes.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class MemoryDC : WindowDC
	{
		[DllImport("wx-c")] static extern IntPtr wxMemoryDC_ctor();
		[DllImport("wx-c")] static extern IntPtr wxMemoryDC_ctorByDC(IntPtr dc);
		[DllImport("wx-c")] static extern void   wxMemoryDC_SelectObject(IntPtr self, IntPtr bitmap);

		//---------------------------------------------------------------------

        public MemoryDC(IntPtr wxObject) 
            : base(wxObject) { }

        public MemoryDC()
            : this(wxMemoryDC_ctor()) { }

        public MemoryDC(DC dc)
            : this(wxMemoryDC_ctorByDC(Object.SafePtr(dc))) { }

		//---------------------------------------------------------------------

        public void SelectObject(Bitmap bitmap)
        {
            wxMemoryDC_SelectObject(wxObject, Object.SafePtr(bitmap));
        }

		//---------------------------------------------------------------------
	}

	public class BufferedDC : MemoryDC
	{
		[DllImport("wx-c")] static extern IntPtr wxBufferedDC_ctor();
		[DllImport("wx-c")] static extern IntPtr wxBufferedDC_ctorByBitmap(IntPtr dc, IntPtr buffer);
		[DllImport("wx-c")] static extern IntPtr wxBufferedDC_ctorBySize(IntPtr dc, ref Size area);

		[DllImport("wx-c")] static extern void   wxBufferedDC_InitByBitmap(IntPtr self, IntPtr dc, IntPtr bitmap);
		[DllImport("wx-c")] static extern void   wxBufferedDC_InitBySize(IntPtr self, IntPtr dc, ref Size area);
		[DllImport("wx-c")] static extern void   wxBufferedDC_UnMask(IntPtr self);

		//---------------------------------------------------------------------

        public BufferedDC(IntPtr wxObject) 
            : base(wxObject) { }

        public BufferedDC()
            : this(wxBufferedDC_ctor()) { }

        public BufferedDC(DC dc, Bitmap bitmap) 
            : this(wxBufferedDC_ctorByBitmap(Object.SafePtr(dc), Object.SafePtr(bitmap))) { }

        public BufferedDC(DC dc, Size size)
            : this(wxBufferedDC_ctorBySize(Object.SafePtr(dc), ref size)) { }

		//---------------------------------------------------------------------

		public void InitByBitmap(DC dc, Bitmap bitmap)
        {
            wxBufferedDC_InitByBitmap(wxObject, Object.SafePtr(dc), Object.SafePtr(bitmap));
        }

		public void InitBySize(DC dc, Size area)
        {
            wxBufferedDC_InitBySize(wxObject, Object.SafePtr(dc), ref area);
        }

		//---------------------------------------------------------------------

        public void UnMask()
        {
            wxBufferedDC_UnMask(wxObject);
        }

		//---------------------------------------------------------------------
	}

	public class BufferedPaintDC : BufferedDC
	{
		[DllImport("wx-c")] static extern IntPtr wxBufferedPaintDC_ctor(IntPtr window, IntPtr buffer);

		//---------------------------------------------------------------------
        
        public BufferedPaintDC(IntPtr wxObject) 
            : base(wxObject) { }

        public BufferedPaintDC(Window window, Bitmap buffer)
            : this(wxBufferedPaintDC_ctor(Object.SafePtr(window), Object.SafePtr(buffer))) { }

		//---------------------------------------------------------------------
	}
}

