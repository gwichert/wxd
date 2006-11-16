//-----------------------------------------------------------------------------
// wxD - VScroll.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.VScroll;
import wx.common;
import wx.Panel;
import wx.SizeEvent;

		extern (C) {
		alias int function(VScrolledWindow obj, int n) Virtual_IntInt;
		}

		//-----------------------------------------------------------------------------
		
		static extern (C) IntPtr wxVScrolledWindow_ctor(IntPtr parent, int id, inout Point pos, inout Size size, uint style, string name);
		static extern (C) void wxVScrolledWindow_RegisterVirtual(IntPtr self, VScrolledWindow obj, Virtual_IntInt onGetLineHeight);
		static extern (C) bool wxVScrolledWindow_Create(IntPtr self,IntPtr parent, int id, inout Point pos, inout Size size, int style, string name);
		static extern (C) void wxVScrolledWindow_SetLineCount(IntPtr self, int count);
		static extern (C) bool wxVScrolledWindow_ScrollToLine(IntPtr self, int line);
		static extern (C) bool wxVScrolledWindow_ScrollLines(IntPtr self, int lines);
		static extern (C) bool wxVScrolledWindow_ScrollPages(IntPtr self, int pages);
		static extern (C) void wxVScrolledWindow_RefreshLine(IntPtr self, int line);
		static extern (C) void wxVScrolledWindow_RefreshLines(IntPtr self, int from, int to);
		static extern (C) int wxVScrolledWindow_HitTest(IntPtr self, int x, int y);
		static extern (C) int wxVScrolledWindow_HitTest2(IntPtr self, inout Point pt);
		static extern (C) void wxVScrolledWindow_RefreshAll(IntPtr self);
		static extern (C) int wxVScrolledWindow_GetLineCount(IntPtr self);
		static extern (C) int wxVScrolledWindow_GetFirstVisibleLine(IntPtr self);
		static extern (C) int wxVScrolledWindow_GetLastVisibleLine(IntPtr self);
		static extern (C) bool wxVScrolledWindow_IsVisible(IntPtr self, int line);
		
		//-----------------------------------------------------------------------------
		
	public abstract class VScrolledWindow : Panel
	{
		public this(IntPtr wxobj)
			{ super(wxobj); }
			
		public this()
			{ this(null, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "");}
			
		public this(Window parent, int id)
			{ this(parent, id, wxDefaultPosition, wxDefaultSize, 0, "");}
			
		public this(Window parent, int id, Point pos)
			{ this(parent, id, pos, wxDefaultSize, 0, "");}
			
		public this(Window parent, int id, Point pos, Size size)
			{ this(parent, id, pos, size, 0, "");}
			
		public this(Window parent, int id, Point pos, Size size, int style)
			{ this(parent, id, pos, size, style, "");}
		
		public this(Window parent, int id, Point pos, Size size, int style, string name)
		{
			this(wxVScrolledWindow_ctor(wxObject.SafePtr(parent), id, pos, size, cast(uint)style, name));
			wxVScrolledWindow_RegisterVirtual(wxobj, this, &staticOnGetLineHeight);
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent)
			{ this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "");}
			
		public this(Window parent, Point pos)
			{ this(parent, Window.UniqueID, pos, wxDefaultSize, 0, "");}
			
		public this(Window parent, Point pos, Size size)
			{ this(parent, Window.UniqueID, pos, size, 0, "");}
			
		public this(Window parent, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, pos, size, style, "");}
		
		public this(Window parent, Point pos, Size size, int style, string name)
			{ this(parent, Window.UniqueID, pos, size, style, name);}
		
		//-----------------------------------------------------------------------------
		
		public bool Create(Window parent, int id, Point pos, Size size, int style, string name)
		{
			return wxVScrolledWindow_Create(wxobj, wxObject.SafePtr(parent), id, pos, size, style, name); 
		}
		
		//-----------------------------------------------------------------------------
		
		static extern(C) private int staticOnGetLineHeight(VScrolledWindow obj, int n)
		{
			return obj.OnGetLineHeight(n);
		}
		protected abstract int OnGetLineHeight(int n);
		
		public void LineCount(int value) { wxVScrolledWindow_SetLineCount(wxobj, value); }
		public int LineCount() { return wxVScrolledWindow_GetLineCount(wxobj); }
		
		public void ScrollToLine(int line)
		{
			wxVScrolledWindow_ScrollToLine(wxobj, line);
		}
		
		public override bool ScrollLines(int lines)
		{
			return wxVScrolledWindow_ScrollLines(wxobj, lines);
		}
		
		public override bool ScrollPages(int pages)
		{
			return wxVScrolledWindow_ScrollPages(wxobj, pages);
		}
		
		public void RefreshLine(int line)
		{
			wxVScrolledWindow_RefreshLine(wxobj, line);
		}
		
		public void RefreshLines(int from, int to)
		{
			wxVScrolledWindow_RefreshLines(wxobj, from, to);
		}
		
		public int HitTest(int x, int y)
		{
			return wxVScrolledWindow_HitTest(wxobj, x, y);
		}
		
		public int HitTest(Point pt)
		{
			return wxVScrolledWindow_HitTest2(wxobj, pt);
		}
		
		public /+virtual+/ void RefreshAll()
		{
			wxVScrolledWindow_RefreshAll(wxobj);
		}
		
		public int GetFirstVisibleLine()
		{
			return wxVScrolledWindow_GetFirstVisibleLine(wxobj);
		}
		
		public int GetLastVisibleLine()
		{
			return wxVScrolledWindow_GetLastVisibleLine(wxobj);
		}	
		
		public bool IsVisible(int line)
		{
			return wxVScrolledWindow_IsVisible(wxobj, line);
		}
	}
