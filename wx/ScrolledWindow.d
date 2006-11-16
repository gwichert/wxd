//-----------------------------------------------------------------------------
// wx.NET - ScrolledWindow.cs
//
// The wxScrolledWindow wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class ScrolledWindow : Panel
	{
		[DllImport("wx-c")] static extern IntPtr wxScrollWnd_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void   wxScrollWnd_PrepareDC(IntPtr self, IntPtr dc);
		[DllImport("wx-c")] static extern void   wxScrollWnd_SetScrollbars(IntPtr self, int pixX, int pixY, int numX, int numY, int x, int y, bool noRefresh);
		[DllImport("wx-c")] static extern void   wxScrollWnd_GetViewStart(IntPtr self, ref int x, ref int y);
		[DllImport("wx-c")] static extern void   wxScrollWnd_GetScrollPixelsPerUnit(IntPtr self, ref int xUnit, ref int yUnit);
		
		[DllImport("wx-c")] static extern void   wxScrollWnd_CalcScrolledPosition(IntPtr self, int x, int y, ref int xx, ref int yy);
		[DllImport("wx-c")] static extern void   wxScrollWnd_CalcUnscrolledPosition(IntPtr self, int x, int y, ref int xx, ref int yy);
		[DllImport("wx-c")] static extern void   wxScrollWnd_GetVirtualSize(IntPtr self, ref int x, ref int y);
		[DllImport("wx-c")] static extern void   wxScrollWnd_Scroll(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void   wxScrollWnd_SetScrollRate(IntPtr self, int xstep, int ystep);
		[DllImport("wx-c")] static extern void   wxScrollWnd_SetTargetWindow(IntPtr self, IntPtr window);

		//---------------------------------------------------------------------

		public ScrolledWindow(IntPtr wxObject) 
			: base(wxObject) { }

		public ScrolledWindow(Window parent)
			: this(parent, -1, wxDefaultPosition, wxDefaultSize, wxHSCROLL | wxVSCROLL) { }
			
		public ScrolledWindow(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxHSCROLL | wxVSCROLL) { }
			
		public ScrolledWindow(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxHSCROLL | wxVSCROLL) { }
			
		public ScrolledWindow(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxHSCROLL | wxVSCROLL) { }
			
		public ScrolledWindow(Window parent, int id, Point pos, Size size, long style)
			: base(wxScrollWnd_ctor(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, null))
		{
			EVT_PAINT(new EventListener(OnPaint));
		}

		//---------------------------------------------------------------------

		public virtual void OnDraw(DC dc)
		{
		}

		//---------------------------------------------------------------------

		public override void PrepareDC(DC dc)
		{
			wxScrollWnd_PrepareDC(wxObject, dc.wxObject);
		}

		//---------------------------------------------------------------------

		public void SetScrollbars(int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY)
		{ 
			SetScrollbars(pixelsPerUnitY, pixelsPerUnitY, noUnitsY, noUnitsY, 0, 0, false); 
		}
		
		public void SetScrollbars(int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY, int x, int y)
		{ 
			SetScrollbars(pixelsPerUnitY, pixelsPerUnitY, noUnitsY, noUnitsY, x, y, false); 
		}
		
		public void SetScrollbars(int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY, int x, int y, bool noRefresh)
		{
			wxScrollWnd_SetScrollbars(wxObject, pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY, x, y, noRefresh);
		}

		//---------------------------------------------------------------------

		private void OnPaint(object sender, Event e)
		{
			PaintDC dc = new PaintDC(this);
			PrepareDC(dc);
			OnDraw(dc);
			dc.Dispose();
		}

		//---------------------------------------------------------------------

		public Point ViewStart
		{
			get {
				int x = new int(), 
				y = new int();
				GetViewStart(ref x, ref y);
				return new Point(x, y);
			}
		}

		public void GetViewStart(ref int x, ref int y)
		{
			wxScrollWnd_GetViewStart(wxObject, ref x, ref y);
		}

		//---------------------------------------------------------------------

		public void GetScrollPixelsPerUnit(ref int xUnit, ref int yUnit)
		{
			wxScrollWnd_GetScrollPixelsPerUnit(wxObject, ref xUnit, ref yUnit);
		}
		
		//---------------------------------------------------------------------
		
		public void CalcScrolledPosition(int x, int y, ref int xx, ref int yy)
		{
			wxScrollWnd_CalcScrolledPosition(wxObject, x, y, ref xx, ref yy);
		}
		
		//---------------------------------------------------------------------
		
		public void CalcUnscrolledPosition(int x, int y, ref int xx, ref int yy)
		{
			wxScrollWnd_CalcUnscrolledPosition(wxObject, x, y, ref xx, ref yy);
		}
		
		//---------------------------------------------------------------------
		
		public void GetVirtualSize(ref int x, ref int y)
		{
			wxScrollWnd_GetVirtualSize(wxObject, ref x, ref y);
		}
		
		//---------------------------------------------------------------------
		
		public void Scroll(int x, int y)
		{
			wxScrollWnd_Scroll(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public void SetScrollRate(int xstep, int ystep)
		{
			wxScrollWnd_SetScrollRate(wxObject, xstep, ystep);
		}
		
		//---------------------------------------------------------------------
		
		public Window TargetWindow
		{
			set { wxScrollWnd_SetTargetWindow(wxObject, Object.SafePtr(value)); }
		}
	}
}
