//-----------------------------------------------------------------------------
// wx.NET - Frame.cs
//
// The wxFrame wrapper class.
//
// Written by Jason Perkins (jason@379.com), Bryan Bulten (bryan@bulten.ca)
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
	public class Frame : Window
	{
		public const long wxFULLSCREEN_NOMENUBAR   = 0x0001;
		public const long wxFULLSCREEN_NOTOOLBAR   = 0x0002;
		public const long wxFULLSCREEN_NOSTATUSBAR = 0x0004;
		public const long wxFULLSCREEN_NOBORDER    = 0x0008;
		public const long wxFULLSCREEN_NOCAPTION   = 0x0010;
		public const long wxFULLSCREEN_ALL         = 
                    wxFULLSCREEN_NOMENUBAR | wxFULLSCREEN_NOTOOLBAR |
                    wxFULLSCREEN_NOSTATUSBAR | wxFULLSCREEN_NOBORDER |
                    wxFULLSCREEN_NOCAPTION;
		    
		//-----------------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxFrame_ctor();
		[DllImport("wx-c")] static extern bool   wxFrame_Create(IntPtr self, IntPtr parent, int id, string title, ref Point pos, ref Size size, uint style, string name);

		[DllImport("wx-c")] static extern IntPtr wxFrame_CreateStatusBar(IntPtr self, int number, uint style, int id, string name);

		[DllImport("wx-c")] static extern void   wxFrame_SendSizeEvent(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFrame_SetIcon(IntPtr self, IntPtr icon);

		[DllImport("wx-c")] static extern void   wxFrame_SetMenuBar(IntPtr self, IntPtr menuBar);
		[DllImport("wx-c")] static extern IntPtr wxFrame_GetMenuBar(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFrame_SetStatusText(IntPtr self, string text, int number);

		[DllImport("wx-c")] static extern IntPtr wxFrame_CreateToolBar(IntPtr self, uint style, int id, string name);
		[DllImport("wx-c")] static extern IntPtr wxFrame_GetToolBar(IntPtr self);
		[DllImport("wx-c")] static extern void   wxFrame_SetToolBar(IntPtr self, IntPtr toolbar);

		[DllImport("wx-c")] static extern bool   wxFrame_ShowFullScreen(IntPtr self, bool show, uint style);
		[DllImport("wx-c")] static extern bool   wxFrame_IsFullScreen(IntPtr self);

		[DllImport("wx-c")] static extern IntPtr wxFrame_GetStatusBar(IntPtr wxObject); 
		[DllImport("wx-c")] static extern void   wxFrame_SetStatusBar(IntPtr wxObject, IntPtr statusbar);

		[DllImport("wx-c")] static extern int    wxFrame_GetStatusBarPane(IntPtr wxObject); 
		[DllImport("wx-c")] static extern void   wxFrame_SetStatusBarPane(IntPtr wxObject, int n); 

		[DllImport("wx-c")] static extern void   wxFrame_SetStatusWidths(IntPtr self, int n, int[] widths);

		[DllImport("wx-c")] static extern void   wxFrame_Iconize(IntPtr wxObject, bool iconize); 
		[DllImport("wx-c")] static extern bool   wxFrame_IsIconized(IntPtr wxObject); 

		[DllImport("wx-c")] static extern void   wxFrame_Maximize(IntPtr wxObject, bool maximize); 
		[DllImport("wx-c")] static extern bool   wxFrame_IsMaximized(IntPtr wxObject); 

		//[DllImport("wx-c")] static extern bool   wxFrame_SetShape(IntPtr self, IntPtr region);
		
		[DllImport("wx-c")] static extern void   wxFrame_GetClientAreaOrigin(IntPtr self, ref Point pt);
            
		//---------------------------------------------------------------------

		public Frame(IntPtr wxObject)
			: base(wxObject) { }
			
		public Frame()
			: this(wxFrame_ctor()) {}
			
		public Frame(Window parent, int id, string title)
			: this(parent, id, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "frame") { }

		public Frame(Window parent, int id, string title, Point pos)
			: this(parent, id, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "frame") { }

		public Frame(Window parent, int id, string title, Point pos, Size size)
			: this(parent, id, title, pos, size, wxDEFAULT_FRAME_STYLE, "frame") { }

		public Frame(Window parent, int id, string title, Point pos, Size size, long style)
			: this(parent, id, title, pos, size, style, "frame") { }

		public Frame(Window parent, int id, string title, Point pos, Size size, long style, string name)
			: base(wxFrame_ctor()) 
		{
			if (!Create(parent, id, title, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create Frame");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Frame(Window parent, string title)
			: this(parent, Window.UniqueID, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "frame") { }

		public Frame(Window parent, string title, Point pos)
			: this(parent, Window.UniqueID, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "frame") { }

		public Frame(Window parent, string title, Point pos, Size size)
			: this(parent, Window.UniqueID, title, pos, size, wxDEFAULT_FRAME_STYLE, "frame") { }

		public Frame(Window parent, string title, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, title, pos, size, style, "frame") { }

		public Frame(Window parent, string title, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, title, pos, size, style, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string title, Point pos, Size size, long style, string name)
		{
			return wxFrame_Create(wxObject, Object.SafePtr(parent), id, title, ref pos, ref size, (uint)style, name);
		}

		//---------------------------------------------------------------------
        
		// Helper constructors

		public Frame(string title)
			: this(null, -1, title) { }
		public Frame(string title, Point pos, Size size)
			: this(null, -1, title, pos, size) { }
		public Frame(string title, Point pos, Size size, long style)
			: this(null, -1, title, pos, size, style) { }

		//---------------------------------------------------------------------
        
		public bool ShowFullScreen(bool show, long style) 
		{
			return wxFrame_ShowFullScreen(wxObject, show, (uint)style);
		}

		public bool ShowFullScreen(bool show) 
		{
			return ShowFullScreen(show, wxFULLSCREEN_ALL);
		}

		public bool IsFullScreen
		{
			get { return wxFrame_IsFullScreen(wxObject); }
		}

		//---------------------------------------------------------------------

		public StatusBar CreateStatusBar()
		{ 
			return CreateStatusBar(1, 0, -1, "statusBar"); 
		}
		
		public StatusBar CreateStatusBar(int number)
		{ 
			return CreateStatusBar(number, 0, -1, "statusBar"); 
		}
		
		public StatusBar CreateStatusBar(int number, long style)
		{ 
			return CreateStatusBar(number, style, -1, "statusBar"); 
		}
		
		public StatusBar CreateStatusBar(int number, long style, int id)
		{ 
			return CreateStatusBar(number, style, id, "statusBar"); 
		}

		public StatusBar CreateStatusBar(int number, long style, int id, string name)
		{
			return new StatusBar(wxFrame_CreateStatusBar(wxObject, number, (uint)style, id, name));
		}

		public StatusBar StatusBar
		{
			get { return (StatusBar)FindObject(wxFrame_GetStatusBar(wxObject), typeof(StatusBar)); }
			set { wxFrame_SetStatusBar(wxObject, Object.SafePtr(value)); }
		}

		public int StatusBarPane
		{
			get { return wxFrame_GetStatusBarPane(wxObject); }
			set { wxFrame_SetStatusBarPane(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public void SendSizeEvent()
		{
			wxFrame_SendSizeEvent(wxObject);
		}

		//---------------------------------------------------------------------

		public Icon Icon
		{
			set { wxFrame_SetIcon(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public MenuBar MenuBar
		{
			set { 
				wxFrame_SetMenuBar(wxObject, Object.SafePtr(value)); 
				// add menu events...
				for ( int i = 0; i < MenuBar.MenuCount; ++i )
				{
					Menu menu = value.GetMenu(i);
					menu.ConnectEvents(this);
				}
			}
			get { return (MenuBar)FindObject(wxFrame_GetMenuBar(wxObject), typeof(MenuBar)); }
		}

		//---------------------------------------------------------------------

		public string StatusText
		{
			set { SetStatusText(value); }
		}

		public void SetStatusText(string text) 
		{ SetStatusText(text, 0); }

		public void SetStatusText(string text, int number)
		{
			wxFrame_SetStatusText(wxObject, text, number);
		}

		//---------------------------------------------------------------------

		public int[] StatusWidths
		{
			set { SetStatusWidths(value.Length, value); }
		}

		public void SetStatusWidths(int n, int[] widths)
		{
			wxFrame_SetStatusWidths(wxObject, n, widths);
		}

		//---------------------------------------------------------------------

		public ToolBar CreateToolBar()
		{ return CreateToolBar(/*Border.*/wxNO_BORDER | ToolBar.wxTB_HORIZONTAL, -1, "toolBar"); }
		public ToolBar CreateToolBar(long style)
		{ return CreateToolBar(style, -1, "toolBar"); }
		public ToolBar CreateToolBar(long style, int id)
		{ return CreateToolBar(style, id, "toolBar"); }

		public ToolBar CreateToolBar(long style, int id, string name)
		{
			return new ToolBar(wxFrame_CreateToolBar(wxObject, (uint)style, id, name));
		}

		public ToolBar ToolBar
		{
			get { return (ToolBar)FindObject(wxFrame_GetToolBar(wxObject)); }
			set { wxFrame_SetToolBar(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public bool Iconized
		{
			get { return wxFrame_IsIconized(wxObject); }
			set { wxFrame_Iconize(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public bool Maximized
		{
			get { return wxFrame_IsMaximized(wxObject); }
			set { wxFrame_Maximize(wxObject, value); }
		}

		//---------------------------------------------------------------------

		/*public bool SetShape(wx.Region region)
		{
			return wxFrame_SetShape(wxObject, Object.SafePtr(region));
		}*/

		//---------------------------------------------------------------------
		
		public override Point ClientAreaOrigin
		{
			get {
				Point pt = new Point();
				wxFrame_GetClientAreaOrigin(wxObject, ref pt);
				return pt;
			}
		}
	}
}
