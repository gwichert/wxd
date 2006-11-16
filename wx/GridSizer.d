//-----------------------------------------------------------------------------
// wxD - GridSizer.d
//
// The wxGridSizer proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.GridSizer;
import wx.common;
import wx.Sizer;

		static extern (C) IntPtr wxGridSizer_ctor(int rows, int cols, int vgap, int hgap);
		static extern (C) void wxGridSizer_RecalcSizes(IntPtr self);
		static extern (C) void wxGridSizer_CalcMin(IntPtr self, inout Size size);
		static extern (C) void wxGridSizer_SetCols(IntPtr self, int cols);
		static extern (C) void wxGridSizer_SetRows(IntPtr self, int rows);
		static extern (C) void wxGridSizer_SetVGap(IntPtr self, int gap);
		static extern (C) void wxGridSizer_SetHGap(IntPtr self, int gap);
		static extern (C) int wxGridSizer_GetCols(IntPtr self);
		static extern (C) int wxGridSizer_GetRows(IntPtr self);
		static extern (C) int wxGridSizer_GetVGap(IntPtr self);
		static extern (C) int wxGridSizer_GetHGap(IntPtr self);

		//---------------------------------------------------------------------

	public class GridSizer : Sizer
	{
		public this(IntPtr wxobj)
		{
			super(wxobj);
		}

		public this(int rows, int cols, int vgap, int hgap)
		{
			super(wxGridSizer_ctor(rows, cols, vgap, hgap));
		}

		//---------------------------------------------------------------------

		public override void RecalcSizes()
		{
			wxGridSizer_RecalcSizes(wxobj);
		}

		//---------------------------------------------------------------------

		public override Size CalcMin()
		{
			Size size;
			wxGridSizer_CalcMin(wxobj, size);
			return size;
		}

		//---------------------------------------------------------------------

		public void Cols(int value) 
			{
				wxGridSizer_SetCols(wxobj, value);
			}
		public int Cols() 
			{
				return wxGridSizer_GetCols(wxobj);
			}

		public void Rows(int value) 
			{
				wxGridSizer_SetRows(wxobj, value);
			}
		public int Rows() 
			{
				return wxGridSizer_GetRows(wxobj);
			}

		//---------------------------------------------------------------------

		public void VGap(int value) 
			{
				wxGridSizer_SetVGap(wxobj, value);
			}
		public int VGap() 
			{
				return wxGridSizer_GetVGap(wxobj);
			}

		public void HGap(int value) 
			{
				wxGridSizer_SetHGap(wxobj, value);
			}
		public int HGap() 
			{
				return wxGridSizer_GetHGap(wxobj);
			}

		//---------------------------------------------------------------------
	}
