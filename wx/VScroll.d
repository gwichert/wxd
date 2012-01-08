//-----------------------------------------------------------------------------
// wxD - VScroll.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - VScroll.cs
//
/// The wxVScrolledWindow wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.VScroll;
public import wx.common;
public import wx.Panel;
public import wx.SizeEvent;

		//-----------------------------------------------------------------------------
		
		//! \cond EXTERN
		extern (C) {
		alias int function(VScrolledWindow obj, int n) Virtual_IntInt;
        alias int function(VScrolledWindow obj, size_t n) Virtual_IntSizeT;
		}

		static extern (C) IntPtr wxVScrolledWindow_ctor();
		static extern (C) IntPtr wxVScrolledWindow_ctor2(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		static extern (C) void wxVScrolledWindow_RegisterVirtual(IntPtr self, VScrolledWindow obj, Virtual_IntSizeT onGetLineHeight);
		static extern (C) bool wxVScrolledWindow_Create(IntPtr self,IntPtr parent, int id, ref Point pos, ref Size size, int style, string name);
		static extern (C) void wxVScrolledWindow_SetLineCount(IntPtr self, size_t count);
		static extern (C) bool wxVScrolledWindow_ScrollToLine(IntPtr self, size_t line);
		static extern (C) bool wxVScrolledWindow_ScrollLines(IntPtr self, int lines);
		static extern (C) bool wxVScrolledWindow_ScrollPages(IntPtr self, int pages);
		static extern (C) void wxVScrolledWindow_RefreshLine(IntPtr self, size_t line);
		static extern (C) void wxVScrolledWindow_RefreshLines(IntPtr self, size_t from, size_t to);
		static extern (C) int wxVScrolledWindow_HitTest(IntPtr self, int x, int y);
		static extern (C) int wxVScrolledWindow_HitTest2(IntPtr self, ref Point pt);
		static extern (C) void wxVScrolledWindow_RefreshAll(IntPtr self);
		static extern (C) size_t wxVScrolledWindow_GetLineCount(IntPtr self);
		static extern (C) size_t wxVScrolledWindow_GetFirstVisibleLine(IntPtr self);
		static extern (C) size_t wxVScrolledWindow_GetLastVisibleLine(IntPtr self);
		static extern (C) bool wxVScrolledWindow_IsVisible(IntPtr self, size_t line);
		//! \endcond
		
		//-----------------------------------------------------------------------------
		
	public abstract class VScrolledWindow : Panel
	{
		public this(IntPtr wxobj)
			{ super(wxobj); }
			
		public this() {
			this(wxVScrolledWindow_ctor());
			wxVScrolledWindow_RegisterVirtual(wxobj, this, &staticOnGetLineHeight);
		}
			
		public this(Window parent, int id /*= wxID_ANY*/, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style=0, string name = wxPanelNameStr)
		{
			this(wxVScrolledWindow_ctor2(wxObject.SafePtr(parent), id, pos, size, style, name));
			wxVScrolledWindow_RegisterVirtual(wxobj, this, &staticOnGetLineHeight);
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style=0, string name = wxPanelNameStr)
			{ this(parent, Window.UniqueID, pos, size, style, name);}
		
		//-----------------------------------------------------------------------------
		
		public override bool Create(Window parent, int id, ref Point pos, ref Size size, int style, string name)
		{
			return wxVScrolledWindow_Create(wxobj, wxObject.SafePtr(parent), id, pos, size, style, name); 
		//	return super.Create(parent, id, pos, size, style | wxVSCROLL, name);
		}
		
		//-----------------------------------------------------------------------------
		
		static extern(C) private int staticOnGetLineHeight(VScrolledWindow obj, size_t n)
		{
			return obj.OnGetLineHeight(n);
		}
		protected abstract int OnGetLineHeight(size_t n);
		
		public void LineCount(size_t value) { wxVScrolledWindow_SetLineCount(wxobj, value); }
		public size_t LineCount() { return wxVScrolledWindow_GetLineCount(wxobj); }
		
		public void ScrollToLine(size_t line)
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
		
		public void RefreshLine(size_t line)
		{
			wxVScrolledWindow_RefreshLine(wxobj, line);
		}
		
		public void RefreshLines(size_t from, size_t to)
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
		
		public size_t GetFirstVisibleLine()
		{
			return wxVScrolledWindow_GetFirstVisibleLine(wxobj);
		}
		
		public size_t GetLastVisibleLine()
		{
			return wxVScrolledWindow_GetLastVisibleLine(wxobj);
		}	
		
		public bool IsVisible(size_t line)
		{
			return wxVScrolledWindow_IsVisible(wxobj, line);
		}
	}
