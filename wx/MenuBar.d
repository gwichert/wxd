//-----------------------------------------------------------------------------
// wx.NET - MenuBar.cs
//
// The wxMenuBar wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class MenuBar : EvtHandler
	{
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_ctor();
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_ctor2(uint style);
		[DllImport("wx-c")] static extern bool   wxMenuBar_Append(IntPtr self, IntPtr menu, string title);
		[DllImport("wx-c")] static extern void   wxMenuBar_Check(IntPtr self, int id, bool check);
		[DllImport("wx-c")] static extern bool   wxMenuBar_IsChecked(IntPtr self, int id);
        	[DllImport("wx-c")] static extern bool   wxMenuBar_Insert(IntPtr self, int pos, IntPtr menu, string title);
        	[DllImport("wx-c")] static extern IntPtr wxMenuBar_FindItem(IntPtr self, int id, ref IntPtr menu);
		
		[DllImport("wx-c")] static extern int    wxMenuBar_GetMenuCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_GetMenu(IntPtr self, int pos);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_Replace(IntPtr self, int pos, IntPtr menu, string title);
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_Remove(IntPtr self, int pos);
		
		[DllImport("wx-c")] static extern void   wxMenuBar_EnableTop(IntPtr self, int pos, bool enable);
		
		[DllImport("wx-c")] static extern void   wxMenuBar_Enable(IntPtr self, int id, bool enable);
		
		[DllImport("wx-c")] static extern int    wxMenuBar_FindMenu(IntPtr self, string title);
		[DllImport("wx-c")] static extern int    wxMenuBar_FindMenuItem(IntPtr self, string menustring, string itemString);
		
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_GetHelpString(IntPtr self, int id);
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_GetLabel(IntPtr self, int id);
		[DllImport("wx-c")] static extern IntPtr wxMenuBar_GetLabelTop(IntPtr self, int pos);
		
		[DllImport("wx-c")] static extern bool   wxMenuBar_IsEnabled(IntPtr self, int id);
		
		[DllImport("wx-c")] static extern void   wxMenuBar_Refresh(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxMenuBar_SetHelpString(IntPtr self, int id, string helpstring);
		[DllImport("wx-c")] static extern void   wxMenuBar_SetLabel(IntPtr self, int id, string label);
		[DllImport("wx-c")] static extern void   wxMenuBar_SetLabelTop(IntPtr self, int pos, string label);

		//---------------------------------------------------------------------

		public MenuBar()
			: this(wxMenuBar_ctor()) { }
			
		public MenuBar(long style)
			: this(wxMenuBar_ctor2((uint)style)) {}

		public MenuBar(IntPtr wxObject)
			: base(wxObject) { }

		//---------------------------------------------------------------------

		public bool Append(Menu menu, string title)
		{
			return wxMenuBar_Append(wxObject, menu.wxObject, title);
		}

		//---------------------------------------------------------------------

		public void Check(int id, bool check)
		{
			wxMenuBar_Check(wxObject, id, check);
		}

		//---------------------------------------------------------------------

		public bool IsChecked(int id)
		{
			return wxMenuBar_IsChecked(wxObject, id); 
		}

		public bool Insert(int pos, Menu menu, string title)
		{
			return wxMenuBar_Insert(wxObject, pos, Object.SafePtr(menu), title);
		}
		
		//-----------------------------------------------------------------------------
		
		public MenuItem FindItem(int id)
		{ 
			Menu menu = null;
			return FindItem(id, ref menu); 
		}
		
		public MenuItem FindItem(int id, ref Menu menu)
		{
			IntPtr menuRef = IntPtr.Zero;
			if (menu != null) 
			{
				menuRef = Object.SafePtr(menu);
			}
		
			return (MenuItem)FindObject(wxMenuBar_FindItem(wxObject, id, ref menuRef), typeof(MenuItem));
		}
		
		//-----------------------------------------------------------------------------
		
		public int MenuCount
		{
			get { return wxMenuBar_GetMenuCount(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Menu GetMenu(int pos)
		{
			return (Menu)FindObject(wxMenuBar_GetMenu(wxObject, pos), typeof(Menu));
		}
		
		//-----------------------------------------------------------------------------
		
		public Menu Replace(int pos, Menu menu, string title)
		{
			return (Menu)FindObject(wxMenuBar_Replace(wxObject, pos, Object.SafePtr(menu), title), typeof(Menu));
		}
		
		//-----------------------------------------------------------------------------
		
		public Menu Remove(int pos)
		{
			return (Menu)FindObject(wxMenuBar_Remove(wxObject, pos), typeof(Menu));
		}
		
		//-----------------------------------------------------------------------------
		
		public void EnableTop(int pos, bool enable)
		{
			wxMenuBar_EnableTop(wxObject, pos, enable);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Enable(int id, bool enable)
		{
			wxMenuBar_Enable(wxObject, id, enable);
		}
		
		//-----------------------------------------------------------------------------
		
		public int FindMenu(string title)
		{
			return wxMenuBar_FindMenu(wxObject, title);
		}
		
		//-----------------------------------------------------------------------------
		
		public int FindMenuItem(string menustring, string itemString)
		{
			return wxMenuBar_FindMenuItem(wxObject, menustring, itemString);
		}
		
		//-----------------------------------------------------------------------------
		
		public string GetHelpString(int id)
		{
			return new wxString(wxMenuBar_GetHelpString(wxObject, id), true);
		}
		
		//-----------------------------------------------------------------------------
		
		public string GetLabel(int id)
		{
			return new wxString(wxMenuBar_GetLabel(wxObject, id), true);
		}
		
		//-----------------------------------------------------------------------------
		
		public string GetLabelTop(int pos)
		{
			return new wxString(wxMenuBar_GetLabelTop(wxObject, pos), true);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool IsEnabled(int id)
		{
			return wxMenuBar_IsEnabled(wxObject, id);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Refresh()
		{
			wxMenuBar_Refresh(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetHelpString(int id, string helpstring)
		{
			wxMenuBar_SetHelpString(wxObject, id, helpstring);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetLabel(int id, string label)
		{
			wxMenuBar_SetLabel(wxObject, id, label);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetLabelTop(int pos, string label)
		{
			wxMenuBar_SetLabelTop(wxObject, pos, label);
		}
	}
}
