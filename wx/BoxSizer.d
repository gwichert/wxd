//-----------------------------------------------------------------------------
// wxD - Sizer.d
//
// The wxBoxSizer wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.BoxSizer;
import wx.common;
import wx.Sizer;

		extern(C) {
		alias void function(BoxSizer obj) Virtual_voidvoid;
		alias Size function(BoxSizer obj) Virtual_wxSizevoid;
		}
		
		static extern (C) void wxBoxSizer_RegisterVirtual(IntPtr self, BoxSizer obj, Virtual_voidvoid recalcSizes, Virtual_wxSizevoid calcMin);	
		static extern (C) void wxBoxSizer_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
	
		static extern (C) IntPtr wxBoxSizer_ctor(int orient);
		static extern (C) void wxBoxSizer_RecalcSizes(IntPtr self);
		static extern (C) Size wxBoxSizer_CalcMin(IntPtr self);
		static extern (C) int wxBoxSizer_GetOrientation(IntPtr self);
		static extern (C) void wxBoxSizer_SetOrientation(IntPtr self, int orient);

		//---------------------------------------------------------------------

	public class BoxSizer : Sizer
	{
		public this(IntPtr wxobj)
			{ super(wxobj); }
			
		public this(int orient)
		{ 
			this(wxBoxSizer_ctor(cast(int)orient));
			wxBoxSizer_RegisterVirtual(wxobj, this, &staticRecalcSizes, &staticCalcMin);
			wxBoxSizer_RegisterDisposable(wxobj, &VirtualDispose);
		}
			
		//---------------------------------------------------------------------
		extern(C) private static void staticRecalcSizes(BoxSizer obj) { return obj.RecalcSizes(); }
		extern(C) private static Size staticCalcMin(BoxSizer obj) { return obj.CalcMin(); }

		public override void RecalcSizes()
		{
			wxBoxSizer_RecalcSizes(wxobj);
		}
		
		//---------------------------------------------------------------------
		public override Size CalcMin()
		{
			return wxBoxSizer_CalcMin(wxobj);
		}
		
		//---------------------------------------------------------------------
		
		public int Orientation() { return wxBoxSizer_GetOrientation(wxobj); }
		public void Orientation(int value) { wxBoxSizer_SetOrientation(wxobj, value); }
	}
