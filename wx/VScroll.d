//-----------------------------------------------------------------------------
// wx.NET - VScroll.cs
//
// The wxVScrolledWindow wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public abstract class VScrolledWindow : Panel
	{
		private delegate int Virtual_IntInt(int n);

		private Virtual_IntInt onGetLineHeight;
		
		//-----------------------------------------------------------------------------
		
		[DllImport("wx-c")] static extern IntPtr wxVScrolledWindow_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void wxVScrolledWindow_RegisterVirtual(IntPtr self, Virtual_IntInt onGetLineHeight);
		[DllImport("wx-c")] static extern bool wxVScrolledWindow_Create(IntPtr self,IntPtr parent, int id, ref Point pos, ref Size size, int style, string name);
		[DllImport("wx-c")] static extern void wxVScrolledWindow_SetLineCount(IntPtr self, int count);
		[DllImport("wx-c")] static extern bool wxVScrolledWindow_ScrollToLine(IntPtr self, int line);
		[DllImport("wx-c")] static extern bool wxVScrolledWindow_ScrollLines(IntPtr self, int lines);
		[DllImport("wx-c")] static extern bool wxVScrolledWindow_ScrollPages(IntPtr self, int pages);
		[DllImport("wx-c")] static extern void wxVScrolledWindow_RefreshLine(IntPtr self, int line);
		[DllImport("wx-c")] static extern void wxVScrolledWindow_RefreshLines(IntPtr self, int from, int to);
		[DllImport("wx-c")] static extern int wxVScrolledWindow_HitTest(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern int wxVScrolledWindow_HitTest2(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern void wxVScrolledWindow_RefreshAll(IntPtr self);
		[DllImport("wx-c")] static extern int wxVScrolledWindow_GetLineCount(IntPtr self);
		[DllImport("wx-c")] static extern int wxVScrolledWindow_GetFirstVisibleLine(IntPtr self);
		[DllImport("wx-c")] static extern int wxVScrolledWindow_GetLastVisibleLine(IntPtr self);
		[DllImport("wx-c")] static extern bool wxVScrolledWindow_IsVisible(IntPtr self, int line);
		
		//-----------------------------------------------------------------------------
		
		public VScrolledWindow(IntPtr wxObject)
			: base(wxObject) { }
			
		public VScrolledWindow()
			: this(null, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "") {}	
			
		public VScrolledWindow(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, "") {}	
			
		public VScrolledWindow(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, "") {}	
			
		public VScrolledWindow(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, "") {}	
			
		public VScrolledWindow(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "") {}	
		
		public VScrolledWindow(Window parent, int id, Point pos, Size size, long style, string name)
			: this(wxVScrolledWindow_ctor(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name))
		{
			onGetLineHeight = new Virtual_IntInt(OnGetLineHeight);

			wxVScrolledWindow_RegisterVirtual(wxObject, onGetLineHeight);
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public VScrolledWindow(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "") {}	
			
		public VScrolledWindow(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, "") {}	
			
		public VScrolledWindow(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, "") {}	
			
		public VScrolledWindow(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "") {}	
		
		public VScrolledWindow(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------
		
		public bool Create(Window parent, int id, Point pos, Size size, int style, string name)
		{
			return wxVScrolledWindow_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, style, name); 
		}
		
		//-----------------------------------------------------------------------------
		
		protected abstract int OnGetLineHeight(int n);
		
		public int LineCount
		{
			set { wxVScrolledWindow_SetLineCount(wxObject, value); }
			get { return wxVScrolledWindow_GetLineCount(wxObject); }
		}
		
		public void ScrollToLine(int line)
		{
			wxVScrolledWindow_ScrollToLine(wxObject, line);
		}
		
		public override bool ScrollLines(int lines)
		{
			return wxVScrolledWindow_ScrollLines(wxObject, lines);
		}
		
		public override bool ScrollPages(int pages)
		{
			return wxVScrolledWindow_ScrollPages(wxObject, pages);
		}
		
		public void RefreshLine(int line)
		{
			wxVScrolledWindow_RefreshLine(wxObject, line);
		}
		
		public void RefreshLines(int from, int to)
		{
			wxVScrolledWindow_RefreshLines(wxObject, from, to);
		}
		
		public int HitTest(int x, int y)
		{
			return wxVScrolledWindow_HitTest(wxObject, x, y);
		}
		
		public int HitTest(Point pt)
		{
			return wxVScrolledWindow_HitTest2(wxObject, ref pt);
		}
		
		public virtual void RefreshAll()
		{
			wxVScrolledWindow_RefreshAll(wxObject);
		}
		
		public int GetFirstVisibleLine()
		{
			return wxVScrolledWindow_GetFirstVisibleLine(wxObject);
		}
		
		public int GetLastVisibleLine()
		{
			return wxVScrolledWindow_GetLastVisibleLine(wxObject);
		}	
		
		public bool IsVisible(int line)
		{
			return wxVScrolledWindow_IsVisible(wxObject, line);
		}
	}
}
