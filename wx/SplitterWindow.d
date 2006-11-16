//-----------------------------------------------------------------------------
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

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public enum SplitMode
	{
		wxSPLIT_HORIZONTAL	= 1,
		wxSPLIT_VERTICAL
	}
	
	//---------------------------------------------------------------------

	public class SplitterWindow : Window
	{
		private delegate void Virtual_OnDoubleClickSash(int x, int y);
		private delegate void Virtual_OnUnsplit(IntPtr removed);
		private delegate bool Virtual_OnSashPositionChange(int newSashPosition);
		
		private Virtual_OnDoubleClickSash virtualOnDoubleClickSash;
		private Virtual_OnUnsplit virtualOnUnsplit;
		private Virtual_OnSashPositionChange virtualOnSashPositionChange;
		
		//---------------------------------------------------------------------
	
		public const long wxSP_3DBORDER		= 0x00000200;
		public const long wxSP_LIVE_UPDATE	= 0x00000080;
		public const long wxSP_3D			= (wxSP_3DBORDER | wxSP_3DSASH);
		public const long wxSP_3DSASH		= 0x00000100;
		
		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxSplitWnd_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void   wxSplitWnd_RegisterVirtual(IntPtr self, Virtual_OnDoubleClickSash onDoubleClickSash, Virtual_OnUnsplit onUnsplit, Virtual_OnSashPositionChange onSashPositionChange);
		[DllImport("wx-c")] static extern void   wxSplitWnd_OnDoubleClickSash(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void   wxSplitWnd_OnUnsplit(IntPtr self, IntPtr removed);
		[DllImport("wx-c")] static extern bool   wxSplitWnd_OnSashPositionChange(IntPtr self, int newSashPosition);
		[DllImport("wx-c")] static extern int    wxSplitWnd_GetSplitMode(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxSplitWnd_IsSplit(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxSplitWnd_SplitHorizontally(IntPtr self, IntPtr wnd1, IntPtr wnd2, int sashPos);
		[DllImport("wx-c")] static extern bool   wxSplitWnd_SplitVertically(IntPtr self, IntPtr wnd1, IntPtr wnd2, int sashPos);
		[DllImport("wx-c")] static extern bool   wxSplitWnd_Unsplit(IntPtr self, IntPtr toRemove);
		[DllImport("wx-c")] static extern void   wxSplitWnd_SetSashPosition(IntPtr self, int position, bool redraw);
		[DllImport("wx-c")] static extern int    wxSplitWnd_GetSashPosition(IntPtr self);
		
		[DllImport("wx-c")] static extern int    wxSplitWnd_GetMinimumPaneSize(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxSplitWnd_GetWindow1(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxSplitWnd_GetWindow2(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSplitWnd_Initialize(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern bool   wxSplitWnd_ReplaceWindow(IntPtr self, IntPtr winOld, IntPtr winNew);
		[DllImport("wx-c")] static extern void   wxSplitWnd_SetMinimumPaneSize(IntPtr self, int paneSize);
		[DllImport("wx-c")] static extern void   wxSplitWnd_SetSplitMode(IntPtr self, int mode);
		[DllImport("wx-c")] static extern void   wxSplitWnd_UpdateSize(IntPtr self);

		//---------------------------------------------------------------------

		public SplitterWindow(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxSP_3D, null) { }

		public SplitterWindow(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxSP_3D, null) { }

		public SplitterWindow(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxSP_3D, null) { }

		public SplitterWindow(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxSP_3D, null) { }

		public SplitterWindow(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, null) { }

		public SplitterWindow(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxSplitWnd_ctor(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name)) 
		{ 
			virtualOnDoubleClickSash = new Virtual_OnDoubleClickSash(OnDoubleClickSash);
			virtualOnUnsplit = new Virtual_OnUnsplit(DoOnUnsplit);
			virtualOnSashPositionChange = new Virtual_OnSashPositionChange(OnSashPositionChange);
			
			wxSplitWnd_RegisterVirtual(wxObject, virtualOnDoubleClickSash, virtualOnUnsplit, virtualOnSashPositionChange);
		}
			
		//---------------------------------------------------------------------
		// ctors with self created id
			
		public SplitterWindow(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, wxSP_3D, null) { }

		public SplitterWindow(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxSP_3D, null) { }

		public SplitterWindow(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, null) { }

		public SplitterWindow(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}

		//---------------------------------------------------------------------
		
		public virtual void OnDoubleClickSash(int x, int y)
		{
			wxSplitWnd_OnDoubleClickSash(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		private void DoOnUnsplit(IntPtr removed)
		{
			OnUnsplit((Window)FindObject(removed));
		}
		
		public virtual void OnUnsplit(Window removed)
		{
			wxSplitWnd_OnUnsplit(wxObject, Object.SafePtr(removed));
		}
		
		//---------------------------------------------------------------------
		
		public virtual bool OnSashPositionChange(int newSashPosition)
		{
			return wxSplitWnd_OnSashPositionChange(wxObject, newSashPosition);
		}
		
		//---------------------------------------------------------------------

		public bool IsSplit
		{
			get { return wxSplitWnd_IsSplit(wxObject); }
		}

		//---------------------------------------------------------------------

		public bool SplitHorizontally(Window wnd1, Window wnd2)
		{
			return this.SplitHorizontally(wnd1, wnd2, 0);
		}

		public bool SplitHorizontally(Window wnd1, Window wnd2, int sashPos)
		{
			return wxSplitWnd_SplitHorizontally(wxObject, Object.SafePtr(wnd1), Object.SafePtr(wnd2), sashPos);
		}

		//---------------------------------------------------------------------

		public SplitMode SplitMode
		{
			get { return (SplitMode)wxSplitWnd_GetSplitMode(wxObject); }
			set { wxSplitWnd_SetSplitMode(wxObject, (int)value); }
		}

		//---------------------------------------------------------------------

		public bool SplitVertically(Window wnd1, Window wnd2)
		{
			return this.SplitVertically(wnd1, wnd2, 0);
		}

		public bool SplitVertically(Window wnd1, Window wnd2, int sashPos)
		{
			return wxSplitWnd_SplitVertically(wxObject, Object.SafePtr(wnd1), Object.SafePtr(wnd2), sashPos);
		}

		//---------------------------------------------------------------------

		public bool Unsplit()
		{
			return this.Unsplit(null);
		}

		public bool Unsplit(Window toRemove)
		{
			return wxSplitWnd_Unsplit(wxObject, Object.SafePtr(toRemove));
		}

		//---------------------------------------------------------------------

		public int SashPosition
		{
			set { SetSashPosition(value, true); }
			get { return wxSplitWnd_GetSashPosition(wxObject); }
		}

		public void SetSashPosition(int position, bool redraw)
		{
			wxSplitWnd_SetSashPosition(wxObject, position, redraw);
		}
		
		//---------------------------------------------------------------------
		
		public int MinimumPaneSize
		{
			get { return wxSplitWnd_GetMinimumPaneSize(wxObject); }
			set { wxSplitWnd_SetMinimumPaneSize(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public Window Window1
		{
			get { return (Window)FindObject(wxSplitWnd_GetWindow1(wxObject), typeof(Window)); }
		}
		
		//---------------------------------------------------------------------
		
		public Window Window2
		{
			get { return (Window)FindObject(wxSplitWnd_GetWindow2(wxObject), typeof(Window)); }
		}
		
		//---------------------------------------------------------------------
		
		public void Initialize(Window window)
		{
			wxSplitWnd_Initialize(wxObject, Object.SafePtr(window));
		}
		
		//---------------------------------------------------------------------
		
		public bool ReplaceWindow(Window winOld, Window winNew)
		{
			return wxSplitWnd_ReplaceWindow(wxObject, Object.SafePtr(winOld), Object.SafePtr(winNew));
		}
		
		//---------------------------------------------------------------------
		
		public void UpdateSize()
		{
			wxSplitWnd_UpdateSize(wxObject);
		}
	}
}
