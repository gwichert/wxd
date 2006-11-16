//-----------------------------------------------------------------------------
// wx.NET - statusbr.h
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;
using System.Drawing;

namespace wx
{
	public class StatusBar : Window
	{
		public const long wxST_SIZEGRIP         = 0x0010;
		public const long wxST_NO_AUTORESIZE    = 0x0001;
		
		public const int wxSB_NORMAL	= 0x000;
		public const int wxSB_FLAT	= 0x001;
		public const int wxSB_RAISED	= 0x002; 
	
		//-----------------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxStatusBar_ctor();
		[DllImport("wx-c")] static extern bool   wxStatusBar_Create(IntPtr self, IntPtr parent, int id, uint style, string name);
	
		[DllImport("wx-c")] static extern void   wxStatusBar_SetFieldsCount(IntPtr self, int number, int[] widths);
		[DllImport("wx-c")] static extern bool   wxStatusBar_GetFieldRect(IntPtr self, int i, ref Rectangle rect);
		[DllImport("wx-c")] static extern int    wxStatusBar_GetBorderY(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxStatusBar_GetStatusText(IntPtr self, int number);
		[DllImport("wx-c")] static extern int    wxStatusBar_GetBorderX(IntPtr self);
		[DllImport("wx-c")] static extern void   wxStatusBar_SetStatusText(IntPtr self, string text, int number);
		[DllImport("wx-c")] static extern void   wxStatusBar_SetStatusWidths(IntPtr self, int n, int[] widths);
		
		[DllImport("wx-c")] static extern int    wxStatusBar_GetFieldsCount(IntPtr self);
		[DllImport("wx-c")] static extern void   wxStatusBar_PopStatusText(IntPtr self, int field);
		[DllImport("wx-c")] static extern void   wxStatusBar_PushStatusText(IntPtr self, string xstring, int field);
		[DllImport("wx-c")] static extern void   wxStatusBar_SetMinHeight(IntPtr self, int height);
		[DllImport("wx-c")] static extern void   wxStatusBar_SetStatusStyles(IntPtr self, int n, [In,Out] int[] styles);
	
		//-----------------------------------------------------------------------------

		public StatusBar(IntPtr wxObject) 
			: base(wxObject) { }

		public StatusBar()
			: this(wxStatusBar_ctor()) { }

		public StatusBar(Window parent)
			: this(parent, Window.UniqueID, wxST_SIZEGRIP, "statusBar") { }
			
		public StatusBar(Window parent, int id)
			: this(parent, id, wxST_SIZEGRIP, "statusBar") { }
			
		public StatusBar(Window parent, int id, long style)
			: this(parent, id, style, "statusBar") { }

		public StatusBar(Window parent, int id, long style, string name)
		: this()
		{
			if (!Create(parent, id, style, name))
			{
				throw new InvalidOperationException("Failed to create StatusBar");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public StatusBar(Window parent, long style)
			: this(parent, Window.UniqueID, style, "statusBar") { }

		public StatusBar(Window parent, long style, string name)
			: this(parent, Window.UniqueID, style, name) {}
		
		//-----------------------------------------------------------------------------

		public bool Create(Window parent, int id, long style, string name)
		{
			return wxStatusBar_Create(wxObject, Object.SafePtr(parent), id, (uint)style, name);
		}

		//-----------------------------------------------------------------------------
        
		public void SetFieldsCount(int number, int[] widths)
		{
			wxStatusBar_SetFieldsCount(wxObject, number, widths);
		}
		
		public int FieldsCount
		{
			get { return wxStatusBar_GetFieldsCount(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public int BorderY
		{
			get { return wxStatusBar_GetBorderY(wxObject); }
		}

		public int BorderX
		{
			get { return wxStatusBar_GetBorderX(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public bool GetFieldRect(int i, ref Rectangle rect)
		{
			return wxStatusBar_GetFieldRect(wxObject, i, ref rect);
		}

		//-----------------------------------------------------------------------------

		public string StatusText
		{
			set { SetStatusText(value); }
			get { return GetStatusText(0); }
		}

		public void SetStatusText(string text) 
		{ SetStatusText(text, 0); }

		public void SetStatusText(string text, int number)
		{
			wxStatusBar_SetStatusText(wxObject, text, number);
		}

		public string GetStatusText(int number)
		{
			return new wxString(wxStatusBar_GetStatusText(wxObject, number), true);
		}

		//-----------------------------------------------------------------------------

		public int[] StatusWidths
		{
			set { SetStatusWidths(value.Length, value); }
		}

		public void SetStatusWidths(int n, int[] widths)
		{
			wxStatusBar_SetStatusWidths(wxObject, n, widths);
		}
		
		//-----------------------------------------------------------------------------
		
		public void PopStatusText()
		{
			PopStatusText(0);
		}
		
		public void PopStatusText(int field)
		{
			wxStatusBar_PopStatusText(wxObject, field);
		}
		
		//-----------------------------------------------------------------------------
		
		public void PushStatusText(string xstring)
		{
			PushStatusText(xstring, 0);
		}
		
		public void PushStatusText(string xstring, int field)
		{
			wxStatusBar_PushStatusText(wxObject, xstring, field);
		}
		
		//-----------------------------------------------------------------------------
		
		public new int MinHeight
		{
			set { wxStatusBar_SetMinHeight(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int[] StatusStyles
		{
			set { wxStatusBar_SetStatusStyles(wxObject, value.Length, value); }
		}
	}
}

