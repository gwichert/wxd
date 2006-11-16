//-----------------------------------------------------------------------------
// wx.NET - FlexGridSizer.cs
//
// The wxFlexGridSizer proxy interface.
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
	public class FlexGridSizer : GridSizer
	{
		[DllImport("wx-c")] static extern IntPtr wxFlexGridSizer_ctor(int rows, int cols, int vgap, int hgap);
		[DllImport("wx-c")] static extern void wxFlexGridSizer_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxFlexGridSizer_RecalcSizes(IntPtr self);
		[DllImport("wx-c")] static extern void wxFlexGridSizer_CalcMin(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void wxFlexGridSizer_AddGrowableRow(IntPtr self, uint idx);
		[DllImport("wx-c")] static extern void wxFlexGridSizer_RemoveGrowableRow(IntPtr self, uint idx);
		[DllImport("wx-c")] static extern void wxFlexGridSizer_AddGrowableCol(IntPtr self, uint idx);
		[DllImport("wx-c")] static extern void wxFlexGridSizer_RemoveGrowableCol(IntPtr self, uint idx);

		//---------------------------------------------------------------------

		public FlexGridSizer(IntPtr wxObject)
			: base(wxObject) { }

        public FlexGridSizer(int cols, int vgap, int hgap)
            : this(0, cols, vgap, hgap) { }

		public FlexGridSizer(int rows, int cols, int vgap, int hgap)
			: base(wxFlexGridSizer_ctor(rows, cols, vgap, hgap)) { }

		//---------------------------------------------------------------------

		public override void RecalcSizes()
		{
			wxFlexGridSizer_RecalcSizes(wxObject);
		}

		//---------------------------------------------------------------------

		public override Size CalcMin()
		{
			Size size = new Size();
			wxFlexGridSizer_CalcMin(wxObject, ref size);
			return size;
		}

		//---------------------------------------------------------------------

		public void AddGrowableRow(long idx)
		{
			wxFlexGridSizer_AddGrowableRow(wxObject, (uint)idx);
		}

		public void RemoveGrowableRow(long idx)
		{
			wxFlexGridSizer_RemoveGrowableRow(wxObject, (uint)idx);
		}

		//---------------------------------------------------------------------

		public void AddGrowableCol(long idx)
		{
			wxFlexGridSizer_AddGrowableCol(wxObject, (uint)idx);
		}

		public void RemoveGrowableCol(long idx)
		{
			wxFlexGridSizer_RemoveGrowableCol(wxObject, (uint)idx);
		}

		//---------------------------------------------------------------------
	}
}
