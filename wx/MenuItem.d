//-----------------------------------------------------------------------------
// wx.NET - MenuItem.cs
//
// The wxMenuItem wrapper class.
//
// Written by Achim Breunig(achim.breunig@web.de)
// (C) 2003 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class MenuItem : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetMenu(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetMenu(IntPtr self, IntPtr menu);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetId(IntPtr self, int id);
		[DllImport("wx-c")] static extern int    wxMenuItem_GetId(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxMenuItem_IsSeparator(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetText(IntPtr self, string str);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetLabel(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetText(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetLabelFromText(IntPtr self, string text);
		[DllImport("wx-c")] static extern int    wxMenuItem_GetKind(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetCheckable(IntPtr self, bool checkable);
		[DllImport("wx-c")] static extern bool   wxMenuItem_IsCheckable(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxMenuItem_IsSubMenu(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetSubMenu(IntPtr self, IntPtr menu);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetSubMenu(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_Enable(IntPtr self, bool enable);
		[DllImport("wx-c")] static extern bool   wxMenuItem_IsEnabled(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_Check(IntPtr self, bool check);
		[DllImport("wx-c")] static extern bool   wxMenuItem_IsChecked(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_Toggle(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetHelp(IntPtr self, string str);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetHelp(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetAccel(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetAccel(IntPtr self, IntPtr accel);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetName(IntPtr self, string str);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetName(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_NewCheck(IntPtr parentMenu, int id, string text, string help, bool isCheckable, IntPtr subMenu);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_New(IntPtr parentMenu, int id, string text, string help, int kind, IntPtr subMenu);
		[DllImport("wx-c")] static extern void   wxMenuItem_SetBitmap(IntPtr self, IntPtr bitmap);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_GetBitmap(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuItem_ctor(IntPtr parentMenu, int id, string text, string help, int kind, IntPtr subMenu);

		//-----------------------------------------------------------------------------

		public MenuItem(IntPtr wxObject) 
			: base(wxObject) { }

		public  MenuItem()
			: this(null, -1, "", "", ItemKind.wxITEM_NORMAL, null) { }
		public  MenuItem(Menu parentMenu)
			: this(parentMenu, -1, "", "", ItemKind.wxITEM_NORMAL, null) { }
		public  MenuItem(Menu parentMenu, int id)
			: this(parentMenu, id, "", "", ItemKind.wxITEM_NORMAL, null) { }
		public  MenuItem(Menu parentMenu, int id, string text)
			: this(parentMenu, id, text, "", ItemKind.wxITEM_NORMAL, null) { }
		public  MenuItem(Menu parentMenu, int id, string text, string help)
			: this(parentMenu, id, text, help, ItemKind.wxITEM_NORMAL, null) { }
		public  MenuItem(Menu parentMenu, int id, string text, string help, ItemKind kind)
			: this(parentMenu, id, text, help, kind, null) { }
		public  MenuItem(Menu parentMenu, int id, string text, string help, ItemKind kind, Menu subMenu)
			: this(wxMenuItem_ctor(Object.SafePtr(parentMenu), id, text, help, (int)kind, Object.SafePtr(subMenu))) { }
			
		//-----------------------------------------------------------------------------

		public static MenuItem New(Menu parentMenu, int id, string text, string help, ItemKind kind, Menu subMenu)
		{
			return new MenuItem(wxMenuItem_New(Object.SafePtr(parentMenu), id, text, help, (int)kind, Object.SafePtr(subMenu)));
		}
	
		public static MenuItem New(Menu parentMenu, int id, string text, string help, bool isCheckable, Menu subMenu)
		{
			return new MenuItem(wxMenuItem_NewCheck(Object.SafePtr(parentMenu), id, text, help, isCheckable, Object.SafePtr(subMenu)));
		}

		//-----------------------------------------------------------------------------

		public Menu Menu
		{
			get { return (Menu)FindObject(wxMenuItem_GetMenu(wxObject), typeof(Menu)); }
			set { wxMenuItem_SetMenu(wxObject, Object.SafePtr(value)); }
		}

		//-----------------------------------------------------------------------------

		public int ID
		{
			get { return wxMenuItem_GetId(wxObject); }
			set { wxMenuItem_SetId(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool IsSeparator
		{
			get { return wxMenuItem_IsSeparator(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public string Text
		{
			set { wxMenuItem_SetText(wxObject, value); } 
			get { return new wxString(wxMenuItem_GetText(wxObject), true); }
		}

		//-----------------------------------------------------------------------------

		public string Label
		{
			get { return new wxString(wxMenuItem_GetLabel(wxObject), true); }
		}

		//-----------------------------------------------------------------------------

		public string GetLabelFromText(string text)
		{
			return new wxString(wxMenuItem_GetLabelFromText(wxObject, text), true);
		}

		//-----------------------------------------------------------------------------

		public ItemKind Kind
		{
			get { return (ItemKind)wxMenuItem_GetKind(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public bool Checkable
		{
			set { wxMenuItem_SetCheckable(wxObject, value); }
			get { return wxMenuItem_IsCheckable(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public bool IsSubMenu
		{
			get { return wxMenuItem_IsSubMenu(wxObject); }
		}

		public Menu SubMenu
		{
			set { wxMenuItem_SetSubMenu(wxObject, Object.SafePtr(value)); }
			get { return (Menu)FindObject(wxMenuItem_GetSubMenu(wxObject), typeof(Menu)); }
		}

		//-----------------------------------------------------------------------------

		public bool Enabled
		{
			set { wxMenuItem_Enable(wxObject, value); }
			get { return wxMenuItem_IsEnabled(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public bool Checked
		{
			set { wxMenuItem_Check(wxObject, value); }
			get { return wxMenuItem_IsChecked(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public void Toggle()
		{
			wxMenuItem_Toggle(wxObject);
		}

		//-----------------------------------------------------------------------------

		public string Help
		{
			set { wxMenuItem_SetHelp(wxObject, value); }
			get { return new wxString(wxMenuItem_GetHelp(wxObject), true); }
		}

		//-----------------------------------------------------------------------------

		public AcceleratorEntry Accel
		{
			get { return (AcceleratorEntry)Object.FindObject(wxMenuItem_GetAccel(wxObject), typeof(AcceleratorEntry)); }
			set { wxMenuItem_SetAccel(wxObject, Object.SafePtr(value)); }
		}

		//-----------------------------------------------------------------------------
		
		public string Name
		{
			set { wxMenuItem_SetName(wxObject, value); }
			get { return new wxString(wxMenuItem_GetName(wxObject), true); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Bitmap Bitmap
		{
			set { wxMenuItem_SetBitmap(wxObject, Object.SafePtr(value)); }
			get { return (Bitmap)FindObject(wxMenuItem_GetBitmap(wxObject), typeof(Bitmap)); }
		}
		
		//---------------------------------------------------------------------
		
		public event EventListener Click
		{
            // We have to add the EventListener through the Menu which this item belongs to
			add { this.Menu.AddEvent(ID, value, this); }
			remove { }
		}

        public event EventListener Select
        {
			add { this.Menu.AddEvent(ID, value, this); }
			remove { }
        }
	}
}

