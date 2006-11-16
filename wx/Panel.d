//-----------------------------------------------------------------------------
// wxD - Panel.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - Panel.cs
//
// The wxPanel wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Panel;
import wx.common;
import wx.Window;
import wx.Button;

		static extern (C) IntPtr wxPanel_ctor();
		static extern (C) IntPtr wxPanel_ctor2(IntPtr parent, int id, inout Point pos, inout Size size, uint style, string name);
		static extern (C) bool wxPanel_Create(IntPtr self, IntPtr parent, int id, inout Point pos, inout Size size, uint style, string name);
		static extern (C) void wxPanel_InitDialog(IntPtr self);
		static extern (C) IntPtr wxPanel_GetDefaultItem(IntPtr self);
		static extern (C) void wxPanel_SetDefaultItem(IntPtr self, IntPtr btn);

	public class Panel : Window
	{
		//---------------------------------------------------------------------
		
		public this(IntPtr wxobj) 
			{ super(wxobj);}
		
		public this()
			{ super(wxPanel_ctor());}

		public this(Window parent)
			{ this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL|wxNO_BORDER, "panel"); }

		public this(Window parent, int id)
			{ this(parent, id, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL|wxNO_BORDER, "panel"); }

		public this(Window parent, int id, Point pos, Size size)
			{ this(parent, id, pos, size, wxTAB_TRAVERSAL|wxNO_BORDER, "panel"); }

		public this(Window parent, int id, Point pos, Size size, int style)
			{ this(parent, id, pos, size, style, "panel"); }

		public this(Window parent, int id, Point pos, Size size, int style, string name)
			{ super(wxPanel_ctor2(wxObject.SafePtr(parent), id, pos, size, cast(uint)style, name));}
			
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, Point pos, Size size)
			{ this(parent, Window.UniqueID, pos, size, wxTAB_TRAVERSAL|wxNO_BORDER, "panel"); }

		public this(Window parent, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, pos, size, style, "panel"); }

		public this(Window parent, Point pos, Size size, int style, string name)
			{ this(parent, Window.UniqueID, pos, size, style, name);}
		
		//---------------------------------------------------------------------
		
		public bool Create(Window parent, int id, Point pos, Size size, int style, string name)
		{
			return wxPanel_Create(wxobj, wxObject.SafePtr(parent), id, pos, size, cast(uint)style, name);
		}

		//---------------------------------------------------------------------

		public Button DefaultItem() 
			{
				IntPtr btn = wxPanel_GetDefaultItem(wxobj);
				return (btn != IntPtr.init) ? new Button(btn) : null;
			}
		public void DefaultItem(Button value) 
			{
				wxPanel_SetDefaultItem(wxobj, value.wxobj);
			}

		//---------------------------------------------------------------------

		public override void InitDialog()
		{
			wxPanel_InitDialog(wxobj);
		}

		//---------------------------------------------------------------------
	}
