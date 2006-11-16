//-----------------------------------------------------------------------------
// wx.NET - Palette.cs
//
// The wxPalette wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------


using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class Palette : GDIObject
	{
		[DllImport("wx-c")] static extern IntPtr wxPalette_ctor();
		[DllImport("wx-c")] static extern void wxPalette_dtor(IntPtr self);
		[DllImport("wx-c")] static extern bool wxPalette_Ok(IntPtr self);
		[DllImport("wx-c")] static extern bool wxPalette_Create(IntPtr self, int n, char[] red, char[] green, char[] blue);
		[DllImport("wx-c")] static extern int wxPalette_GetPixel(IntPtr self, char red, char green, char blue);
		[DllImport("wx-c")] static extern bool wxPalette_GetRGB(IntPtr self, int pixel, out char red, out char green, out char blue);

		//---------------------------------------------------------------------

		public Palette()
			: this(wxPalette_ctor()) {}

		public Palette(IntPtr wxObject)
			: base(wxObject) {}

		public Palette(int n, char[] r, char[] g, char[] b)
			: this(wxPalette_ctor())
		{
			if (!wxPalette_Create(wxObject, n, r, g, b))
			{
				throw new InvalidOperationException("Failed to create Palette");
			}
		}

		public bool Create(int n, char[] r, char[] g, char[] b)
		{
			return wxPalette_Create(wxObject, n, r, g, b);
		}

		//---------------------------------------------------------------------

		public bool Ok()
		{
			return wxPalette_Ok(wxObject);
		}

		//---------------------------------------------------------------------

		public int GetPixel(char red, char green, char blue)
		{
			return wxPalette_GetPixel(wxObject, red, green, blue);
		}

		public bool GetRGB(int pixel, out char red, out char green, out char blue)
		{
			return wxPalette_GetRGB(wxObject, pixel, out red, out green, out blue);
		}

		//---------------------------------------------------------------------
	}

}
