//-----------------------------------------------------------------------------
// wx.NET - Pen.cs
//
// The wxPen wrapper class.
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
	public class Pen : GDIObject
	{
		[DllImport("wx-c")] static extern IntPtr wxPen_ctor(IntPtr col, int width, FillStyle style);
		[DllImport("wx-c")] static extern IntPtr wxPen_ctorByName(string name, int width, FillStyle style);
	
		[DllImport("wx-c")] static extern IntPtr wxPen_GetColour(IntPtr self);
		[DllImport("wx-c")] static extern void   wxPen_SetColour(IntPtr self, IntPtr col);
	
		[DllImport("wx-c")] static extern void   wxPen_SetWidth(IntPtr self, int width);
		[DllImport("wx-c")] static extern int    wxPen_GetWidth(IntPtr self);
		
		[DllImport("wx-c")] static extern int    wxPen_GetCap(IntPtr self);
		[DllImport("wx-c")] static extern int    wxPen_GetJoin(IntPtr self);
		[DllImport("wx-c")] static extern int    wxPen_GetStyle(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxPen_Ok(IntPtr self);
		[DllImport("wx-c")] static extern void   wxPen_SetCap(IntPtr self, int capStyle);
		[DllImport("wx-c")] static extern void   wxPen_SetJoin(IntPtr self, int join_style);
		[DllImport("wx-c")] static extern void   wxPen_SetStyle(IntPtr self, int style);

		//---------------------------------------------------------------------

		public Pen(IntPtr wxObject) 
			: base(wxObject) { }

		public Pen(string name) 
			: this(name, 1, FillStyle.wxSOLID) { }
			
		public Pen(string name, int width) 
			: this(name, width, FillStyle.wxSOLID) { }
			
		public Pen(string name, int width, FillStyle style) 
			: base(wxPen_ctorByName(name, width, style)) { }

		public Pen(Colour colour) 
			: this(colour, 1, FillStyle.wxSOLID) { }
			
		public Pen(Colour colour, int width) 
			: this(colour, width, FillStyle.wxSOLID) { }
			
		public Pen(Colour col, int width, FillStyle style)
			: base(wxPen_ctor(Object.SafePtr(col), width, style)) { }

		//---------------------------------------------------------------------
        
		public Colour Colour
		{
			get { return (Colour)FindObject(wxPen_GetColour(wxObject), typeof(Colour)); }
			set { wxPen_SetColour(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public int Width 
		{
			get { return wxPen_GetWidth(wxObject); }
			set { wxPen_SetWidth(wxObject, value); }
		}
	
		//---------------------------------------------------------------------
	
		public int Cap
		{
			get { return wxPen_GetCap(wxObject); }
			set { wxPen_SetCap(wxObject, value); }
		}
	
		//---------------------------------------------------------------------
	
		public int Join
		{
			get { return wxPen_GetJoin(wxObject); }
			set { wxPen_SetJoin(wxObject, value); }
		}
	
		//---------------------------------------------------------------------
	
		public int Style
		{
			get { return wxPen_GetStyle(wxObject); }
			set { wxPen_SetStyle(wxObject, value); }
		}
	
		//---------------------------------------------------------------------
	
		public bool Ok
		{
			get { return wxPen_Ok(wxObject); }
		}
	}
}
