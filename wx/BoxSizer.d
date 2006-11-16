//-----------------------------------------------------------------------------
// wx.NET - Sizer.cs
//
// The wxBoxSizer wrapper class.
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
	public class BoxSizer : Sizer
	{
		private delegate void Virtual_voidvoid();
		private delegate IntPtr Virtual_wxSizevoid();
		
		private Virtual_voidvoid recalcSizes;
		private Virtual_wxSizevoid calcMin;
		
		[DllImport("wx-c")] static extern void wxBoxSizer_RegisterVirtual(IntPtr self, Virtual_voidvoid recalcSizes, Virtual_wxSizevoid calcMin);	
		[DllImport("wx-c")] static extern void wxBoxSizer_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
	
		[DllImport("wx-c")] static extern IntPtr wxBoxSizer_ctor(int orient);
		[DllImport("wx-c")] static extern void wxBoxSizer_RecalcSizes(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxBoxSizer_CalcMin(IntPtr self);
		[DllImport("wx-c")] static extern int wxBoxSizer_GetOrientation(IntPtr self);
		[DllImport("wx-c")] static extern void wxBoxSizer_SetOrientation(IntPtr self, int orient);

		//---------------------------------------------------------------------

		public BoxSizer(IntPtr wxObject)
			: base(wxObject) { }
			
		public BoxSizer(int orient)
			: this(wxBoxSizer_ctor((int)orient)) 
		{ 
			recalcSizes = new Virtual_voidvoid(RecalcSizes);
			calcMin = new Virtual_wxSizevoid(DoCalcMin);
			wxBoxSizer_RegisterVirtual(wxObject, recalcSizes, calcMin);
			
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxBoxSizer_RegisterDisposable(wxObject, virtual_Dispose);
		}
			
		//---------------------------------------------------------------------
		
		public override void RecalcSizes()
		{
			wxBoxSizer_RecalcSizes(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		private IntPtr DoCalcMin()
		{
			return wxSize.SafePtr(new wxSize(CalcMin()));
		}
		
		public override Size CalcMin()
		{
			return new wxSize(wxBoxSizer_CalcMin(wxObject));
		}
		
		//---------------------------------------------------------------------
		
		public int Orientation
		{
			get { return wxBoxSizer_GetOrientation(wxObject); }
			set { wxBoxSizer_SetOrientation(wxObject, value); }
		}
	}
}
