//-----------------------------------------------------------------------------
// wxD - SplitterWindow.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - SplitterWindow.cs
//
// The wxSplitterWindow wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.SplitterWindow;
import wx.common;
import wx.Window;

	public enum SplitMode
	{
		wxSPLIT_HORIZONTAL	= 1,
		wxSPLIT_VERTICAL
	}
	
	//---------------------------------------------------------------------

		extern (C) {
		alias void function(SplitterWindow obj, int x, int y) Virtual_OnDoubleClickSash;
		alias void function(SplitterWindow obj, IntPtr removed) Virtual_OnUnsplit;
		alias bool function(SplitterWindow obj, int newSashPosition) Virtual_OnSashPositionChange;
		}
		
		//---------------------------------------------------------------------
	
		static extern (C) IntPtr wxSplitWnd_ctor(IntPtr parent, int id, inout Point pos, inout Size size, uint style, string name);
		static extern (C) void   wxSplitWnd_RegisterVirtual(IntPtr self, SplitterWindow obj, Virtual_OnDoubleClickSash onDoubleClickSash, Virtual_OnUnsplit onUnsplit, Virtual_OnSashPositionChange onSashPositionChange);
		static extern (C) void   wxSplitWnd_OnDoubleClickSash(IntPtr self, int x, int y);
		static extern (C) void   wxSplitWnd_OnUnsplit(IntPtr self, IntPtr removed);
		static extern (C) bool   wxSplitWnd_OnSashPositionChange(IntPtr self, int newSashPosition);
		static extern (C) int    wxSplitWnd_GetSplitMode(IntPtr self);
		static extern (C) bool   wxSplitWnd_IsSplit(IntPtr self);
		static extern (C) bool   wxSplitWnd_SplitHorizontally(IntPtr self, IntPtr wnd1, IntPtr wnd2, int sashPos);
		static extern (C) bool   wxSplitWnd_SplitVertically(IntPtr self, IntPtr wnd1, IntPtr wnd2, int sashPos);
		static extern (C) bool   wxSplitWnd_Unsplit(IntPtr self, IntPtr toRemove);
		static extern (C) void   wxSplitWnd_SetSashPosition(IntPtr self, int position, bool redraw);
		static extern (C) int    wxSplitWnd_GetSashPosition(IntPtr self);
		
		static extern (C) int    wxSplitWnd_GetMinimumPaneSize(IntPtr self);
		static extern (C) IntPtr wxSplitWnd_GetWindow1(IntPtr self);
		static extern (C) IntPtr wxSplitWnd_GetWindow2(IntPtr self);
		static extern (C) void   wxSplitWnd_Initialize(IntPtr self, IntPtr window);
		static extern (C) bool   wxSplitWnd_ReplaceWindow(IntPtr self, IntPtr winOld, IntPtr winNew);
		static extern (C) void   wxSplitWnd_SetMinimumPaneSize(IntPtr self, int paneSize);
		static extern (C) void   wxSplitWnd_SetSplitMode(IntPtr self, int mode);
		static extern (C) void   wxSplitWnd_UpdateSize(IntPtr self);

		//---------------------------------------------------------------------

	public class SplitterWindow : Window
	{
		public const int wxSP_3DBORDER		= 0x00000200;
		public const int wxSP_LIVE_UPDATE	= 0x00000080;
		public const int wxSP_3D			= (wxSP_3DBORDER | wxSP_3DSASH);
		public const int wxSP_3DSASH		= 0x00000100;
		
		//---------------------------------------------------------------------

		public this(Window parent)
			{ this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxSP_3D, null); }

		public this(Window parent, int id)
			{ this(parent, id, wxDefaultPosition, wxDefaultSize, wxSP_3D, null); }

		public this(Window parent, int id, Point pos)
			{ this(parent, id, pos, wxDefaultSize, wxSP_3D, null); }

		public this(Window parent, int id, Point pos, Size size)
			{ this(parent, id, pos, size, wxSP_3D, null); }

		public this(Window parent, int id, Point pos, Size size, int style)
			{ this(parent, id, pos, size, style, null); }

		public this(Window parent, int id, Point pos, Size size, int style, string name)
		{ 
			super(wxSplitWnd_ctor(wxObject.SafePtr(parent), id, pos, size, cast(uint)style, name));
			
			wxSplitWnd_RegisterVirtual(wxobj, this, &staticOnDoubleClickSash, &staticDoOnUnsplit, &staticOnSashPositionChange);
		}
			
		//---------------------------------------------------------------------
		// ctors with self created id
			
		public this(Window parent, Point pos)
			{ this(parent, Window.UniqueID, pos, wxDefaultSize, wxSP_3D, null); }

		public this(Window parent, Point pos, Size size)
			{ this(parent, Window.UniqueID, pos, size, wxSP_3D, null); }

		public this(Window parent, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, pos, size, style, null); }

		public this(Window parent, Point pos, Size size, int style, string name)
			{ this(parent, Window.UniqueID, pos, size, style, name);}

		//---------------------------------------------------------------------
		
		static extern(C) private void staticOnDoubleClickSash(SplitterWindow obj, int x, int y)
		{
			obj.OnDoubleClickSash(x, y);
		}
		public /+virtual+/ void OnDoubleClickSash(int x, int y)
		{
			wxSplitWnd_OnDoubleClickSash(wxobj, x, y);
		}
		
		//---------------------------------------------------------------------
		
		static extern(C) private void staticDoOnUnsplit(SplitterWindow obj, IntPtr removed)
		{
			obj.OnUnsplit(cast(Window)FindObject(removed));
		}
		
		public /+virtual+/ void OnUnsplit(Window removed)
		{
			wxSplitWnd_OnUnsplit(wxobj, wxObject.SafePtr(removed));
		}
		
		//---------------------------------------------------------------------
		
		static extern(C) private bool staticOnSashPositionChange(SplitterWindow obj, int newSashPosition)
		{
			return obj.OnSashPositionChange(newSashPosition);
		}
		public /+virtual+/ bool OnSashPositionChange(int newSashPosition)
		{
			return wxSplitWnd_OnSashPositionChange(wxobj, newSashPosition);
		}
		
		//---------------------------------------------------------------------

		public bool IsSplit() { return wxSplitWnd_IsSplit(wxobj); }

		//---------------------------------------------------------------------

		public bool SplitHorizontally(Window wnd1, Window wnd2)
		{
			return this.SplitHorizontally(wnd1, wnd2, 0);
		}

		public bool SplitHorizontally(Window wnd1, Window wnd2, int sashPos)
		{
			return wxSplitWnd_SplitHorizontally(wxobj, wxObject.SafePtr(wnd1), wxObject.SafePtr(wnd2), sashPos);
		}

		//---------------------------------------------------------------------

		public SplitMode splitMode() { return cast(SplitMode)wxSplitWnd_GetSplitMode(wxobj); }
		public void splitMode(SplitMode value) { wxSplitWnd_SetSplitMode(wxobj, cast(int)value); }

		//---------------------------------------------------------------------

		public bool SplitVertically(Window wnd1, Window wnd2)
		{
			return this.SplitVertically(wnd1, wnd2, 0);
		}

		public bool SplitVertically(Window wnd1, Window wnd2, int sashPos)
		{
			return wxSplitWnd_SplitVertically(wxobj, wxObject.SafePtr(wnd1), wxObject.SafePtr(wnd2), sashPos);
		}

		//---------------------------------------------------------------------

		public bool Unsplit()
		{
			return this.Unsplit(null);
		}

		public bool Unsplit(Window toRemove)
		{
			return wxSplitWnd_Unsplit(wxobj, wxObject.SafePtr(toRemove));
		}

		//---------------------------------------------------------------------

		public void SashPosition(int value) { SetSashPosition(value, true); }
		public int SashPosition() { return wxSplitWnd_GetSashPosition(wxobj); }

		public void SetSashPosition(int position, bool redraw)
		{
			wxSplitWnd_SetSashPosition(wxobj, position, redraw);
		}
		
		//---------------------------------------------------------------------
		
		public int MinimumPaneSize() { return wxSplitWnd_GetMinimumPaneSize(wxobj); }
		public void MinimumPaneSize(int value) { wxSplitWnd_SetMinimumPaneSize(wxobj, value); }
		
		//---------------------------------------------------------------------
		
		public static wxObject myNew(IntPtr ptr) { return new Window(ptr); }
		public Window Window1() { return cast(Window)FindObject(wxSplitWnd_GetWindow1(wxobj), &SplitterWindow.myNew); }
		
		//---------------------------------------------------------------------
		
		public Window Window2() { return cast(Window)FindObject(wxSplitWnd_GetWindow2(wxobj), &SplitterWindow.myNew); }
		
		//---------------------------------------------------------------------
		
		public void Initialize(Window window)
		{
			wxSplitWnd_Initialize(wxobj, wxObject.SafePtr(window));
		}
		
		//---------------------------------------------------------------------
		
		public bool ReplaceWindow(Window winOld, Window winNew)
		{
			return wxSplitWnd_ReplaceWindow(wxobj, wxObject.SafePtr(winOld), wxObject.SafePtr(winNew));
		}
		
		//---------------------------------------------------------------------
		
		public void UpdateSize()
		{
			wxSplitWnd_UpdateSize(wxobj);
		}
	}
