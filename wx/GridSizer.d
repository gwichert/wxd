//-----------------------------------------------------------------------------
// wx.NET - GridSizer.cs
//
// The wxGridSizer proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class GridSizer : Sizer
	{
		[DllImport("wx-c")] static extern IntPtr wxGridSizer_ctor(int rows, int cols, int vgap, int hgap);
		[DllImport("wx-c")] static extern void wxGridSizer_RecalcSizes(IntPtr self);
		[DllImport("wx-c")] static extern void wxGridSizer_CalcMin(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void wxGridSizer_SetCols(IntPtr self, int cols);
		[DllImport("wx-c")] static extern void wxGridSizer_SetRows(IntPtr self, int rows);
		[DllImport("wx-c")] static extern void wxGridSizer_SetVGap(IntPtr self, int gap);
		[DllImport("wx-c")] static extern void wxGridSizer_SetHGap(IntPtr self, int gap);
		[DllImport("wx-c")] static extern int wxGridSizer_GetCols(IntPtr self);
		[DllImport("wx-c")] static extern int wxGridSizer_GetRows(IntPtr self);
		[DllImport("wx-c")] static extern int wxGridSizer_GetVGap(IntPtr self);
		[DllImport("wx-c")] static extern int wxGridSizer_GetHGap(IntPtr self);

		//---------------------------------------------------------------------

		public GridSizer(IntPtr wxObject)
			: base(wxObject)
		{
		}

		public GridSizer(int rows, int cols, int vgap, int hgap)
			: base(wxGridSizer_ctor(rows, cols, vgap, hgap))
		{
		}

		//---------------------------------------------------------------------

		public override void RecalcSizes()
		{
			wxGridSizer_RecalcSizes(wxObject);
		}

		//---------------------------------------------------------------------

		public override Size CalcMin()
		{
			Size size = new Size();
			wxGridSizer_CalcMin(wxObject, ref size);
			return size;
		}

		//---------------------------------------------------------------------

		public int Cols
		{
			set
			{
				wxGridSizer_SetCols(wxObject, value);
			}
			get
			{
				return wxGridSizer_GetCols(wxObject);
			}
		}

		public int Rows
		{
			set
			{
				wxGridSizer_SetRows(wxObject, value);
			}
			get
			{
				return wxGridSizer_GetRows(wxObject);
			}
		}

		//---------------------------------------------------------------------

		public int VGap
		{
			set
			{
				wxGridSizer_SetVGap(wxObject, value);
			}
			get
			{
				return wxGridSizer_GetVGap(wxObject);
			}
		}

		public int HGap
		{
			set
			{
				wxGridSizer_SetHGap(wxObject, value);
			}
			get
			{
				return wxGridSizer_GetHGap(wxObject);
			}
		}

		//---------------------------------------------------------------------
	}
}
