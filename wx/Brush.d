//-----------------------------------------------------------------------------
// wx.NET - Brush.cs
//
// The wxBrush wrapper class.
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
	public class Brush : GDIObject
	{
        	[DllImport("wx-c")] static extern IntPtr wxBrush_ctor();
		[DllImport("wx-c")] static extern bool   wxBrush_Ok(IntPtr self);
		[DllImport("wx-c")] static extern FillStyle wxBrush_GetStyle(IntPtr self);
		[DllImport("wx-c")] static extern void   wxBrush_SetStyle(IntPtr self, FillStyle style);
		[DllImport("wx-c")] static extern IntPtr wxBrush_GetStipple(IntPtr self);
		[DllImport("wx-c")] static extern void   wxBrush_SetStipple(IntPtr self, IntPtr stipple);
        	[DllImport("wx-c")] static extern IntPtr wxBrush_GetColour(IntPtr self);
		[DllImport("wx-c")] static extern void   wxBrush_SetColour(IntPtr self, IntPtr col);

		//---------------------------------------------------------------------
        
		public Brush()
			: this(wxBrush_ctor()) { }

		public Brush(IntPtr wxObject)
			: base(wxObject) { }

		public Brush(Colour colour) 
			: this(colour, FillStyle.wxSOLID) { }
			
		public Brush(Colour colour, FillStyle style)
			: this()
		{
			Colour = colour;
			Style = style;
		}

		public Brush(Bitmap stippleBitmap) 
			: this()
		{
			Stipple = stippleBitmap;
		}

		public Brush(string name) 
			: this(name, FillStyle.wxSOLID) { }
			
		public Brush(string name, FillStyle style) 
			: this() 
		{ 
			Colour = new Colour(name);
			Style = style;
		}

		//---------------------------------------------------------------------

		public bool Ok() 
		{
			return wxBrush_Ok(wxObject);
		}

		//---------------------------------------------------------------------

		public FillStyle Style
		{
			get { return wxBrush_GetStyle(wxObject); }
			set { wxBrush_SetStyle(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public Bitmap Stipple
		{
			get { return (Bitmap)FindObject(wxBrush_GetStipple(wxObject), typeof(Bitmap)); }
			set { wxBrush_SetStipple(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public Colour Colour
		{
			get { return new Colour(wxBrush_GetColour(wxObject), true); }
			set { wxBrush_SetColour(wxObject, Object.SafePtr(value)); }
		}
	}
}
