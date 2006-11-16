//-----------------------------------------------------------------------------
// wx.NET - ListBox.cs
//
// wxListBox wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class ListBox : Control
	{
		public const long wxLB_SORT             = 0x0010;
		public const long wxLB_SINGLE           = 0x0020;
		public const long wxLB_MULTIPLE         = 0x0040;
		public const long wxLB_EXTENDED         = 0x0080;
		public const long wxLB_OWNERDRAW        = 0x0100;
		public const long wxLB_NEED_SB          = 0x0200;
		public const long wxLB_ALWAYS_SB        = 0x0400;
		public const long wxLB_HSCROLL          = wxHSCROLL;
		public const long wxLB_INT_HEIGHT       = 0x0800;
	
		//---------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxListBox_ctor();
		[DllImport("wx-c")] static extern void   wxListBox_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListBox_Clear(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListBox_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, int n, string[] choices, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern void   wxListBox_InsertText(IntPtr self, string item, int pos);
		[DllImport("wx-c")] static extern void   wxListBox_InsertTextData(IntPtr self, string item, int pos, IntPtr data);
		[DllImport("wx-c")] static extern void   wxListBox_InsertTextClientData(IntPtr self, string item, int pos, IntPtr clientData);
		[DllImport("wx-c")] static extern void   wxListBox_InsertItems(IntPtr self, int nItems, string[] items, int pos);
		[DllImport("wx-c")] static extern void   wxListBox_Set(IntPtr self, int n, string[] items, IntPtr clientData);
		[DllImport("wx-c")] static extern void   wxListBox_SetSelection(IntPtr self, int n, bool select);
		[DllImport("wx-c")] static extern void   wxListBox_Select(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxListBox_Deselect(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxListBox_DeselectAll(IntPtr self, int itemToLeaveSelected);
		[DllImport("wx-c")] static extern bool   wxListBox_SetStringSelection(IntPtr self, string s, bool select);
		[DllImport("wx-c")] static extern IntPtr wxListBox_GetSelections(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListBox_SetFirstItem(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxListBox_SetFirstItemText(IntPtr self, string s);
		[DllImport("wx-c")] static extern bool   wxListBox_HasMultipleSelection(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListBox_IsSorted(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListBox_Command(IntPtr self, IntPtr evt);
		[DllImport("wx-c")] static extern bool   wxListBox_Selected(IntPtr self, int n);
		[DllImport("wx-c")] static extern int    wxListBox_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListBox_GetStringSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListBox_SetSingleString(IntPtr self, int n, string s);
		[DllImport("wx-c")] static extern IntPtr wxListBox_GetSingleString(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxListBox_Append(IntPtr self, string item);
		[DllImport("wx-c")] static extern void   wxListBox_AppendClientData(IntPtr self, string item, IntPtr cliendData);
		[DllImport("wx-c")] static extern void   wxListBox_Delete(IntPtr self, int n);
		[DllImport("wx-c")] static extern int    wxListBox_GetCount(IntPtr self);
	
		//---------------------------------------------------------------------
		
		public ListBox(IntPtr wxObject) 
			: base(wxObject) { }
	
		public ListBox()
			: base(wxListBox_ctor()) { }

		public ListBox(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, null) { }
	
		public ListBox(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, null, 0, null, null) { }
	
		public ListBox(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, null, 0, null, null) { }
	
		public ListBox(Window parent, int id, Point pos, Size size, int n, string[] choices)
			: this(parent, id, pos, size, n, choices, 0, null, null) { }
	
		public ListBox(Window parent, int id, Point pos, Size size, int n, string[] choices, long style)
			: this(parent, id, pos, size, n, choices, style, null, null) { }
	
		public ListBox(Window parent, int id, Point pos, Size size, int n, string[] choices, long style, Validator val)
			: this(parent, id, pos, size, n, choices, style, val, null) { }
	
		public ListBox(Window parent, int id, Point pos, Size size, int n,
			string[] choices, long style, Validator validator, string name)
			: base(wxListBox_ctor())
		{
			if(!wxListBox_Create(wxObject, Object.SafePtr(parent), id,
					ref pos, ref size, n, choices, (uint)style,
					Object.SafePtr(validator), name))
			{
				throw new InvalidOperationException("Failed to create ListBox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public ListBox(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, null) { }
	
		public ListBox(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, null, 0, null, null) { }
	
		public ListBox(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, null, 0, null, null) { }
	
		public ListBox(Window parent, Point pos, Size size, int n, string[] choices)
			: this(parent, Window.UniqueID, pos, size, n, choices, 0, null, null) { }
	
		public ListBox(Window parent, Point pos, Size size, int n, string[] choices, long style)
			: this(parent, Window.UniqueID, pos, size, n, choices, style, null, null) { }
	
		public ListBox(Window parent, Point pos, Size size, int n, string[] choices, long style, Validator val)
			: this(parent, Window.UniqueID, pos, size, n, choices, style, val, null) { }
	
		public ListBox(Window parent, Point pos, Size size, int n,
			string[] choices, long style, Validator validator, string name)
			: this( parent, Window.UniqueID, pos, size, n, choices, style, validator, name) {}
		
		//---------------------------------------------------------------------
	
		public bool Create(Window parent, int id, Point pos, Size size, int n,
				string[] choices, long style, Validator validator, string name)
		{
			return wxListBox_Create(wxObject, Object.SafePtr(parent), id,
					ref pos, ref size, n, choices, (uint)style,
					Object.SafePtr(validator), name);
		}
		
		//---------------------------------------------------------------------
	
		public int Selection
		{
			get { return wxListBox_GetSelection(wxObject); }
			set { wxListBox_Select(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
	
		public string StringSelection
		{
			get { return new wxString(wxListBox_GetStringSelection(wxObject), true); }
			set { wxListBox_SetStringSelection(wxObject, value, true); }
		}
		
		//---------------------------------------------------------------------
	
		public void SetSelection(int n, bool select)
		{
			wxListBox_SetSelection(wxObject, n, select);
		}
	
		public void SetSelection(string item, bool select)
		{
			wxListBox_SetStringSelection(wxObject, item, select);
		}
	
		//---------------------------------------------------------------------
	
		public void Clear()
		{
			wxListBox_Clear(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public string GetString(int n) 
		{
			return new wxString(wxListBox_GetSingleString(wxObject, n), true);
		}
	
		public void SetString(int n, string str)
		{
			wxListBox_SetSingleString(wxObject, n, str);
		}
	
		//---------------------------------------------------------------------
	
		public void Append(string item)
		{
			wxListBox_Append(wxObject, item);
		}
	
		public void Append(string item, ClientData data)
		{
			wxListBox_AppendClientData(wxObject, item, Object.SafePtr(data));
		}
		
		//---------------------------------------------------------------------
	
		public void Delete(int n)
		{
			wxListBox_Delete(wxObject, n);
		}
	
		//---------------------------------------------------------------------
	
		public void Insert(string item, int pos)
		{
			wxListBox_InsertText(wxObject, item, pos);
		}
	
		public void Insert(string item, int pos, ClientData data)
		{
			wxListBox_InsertTextData(wxObject, item, pos, Object.SafePtr(data));
		}
	
		/*public void Insert(string item, int pos, ClientData data)
		{
		wxListBox_InsertTextClientData(wxObject, item, pos, Object.SafePtr(data));
		}*/
		
		//---------------------------------------------------------------------
	
		public void InsertItems(string[] items, int pos)
		{
			wxListBox_InsertItems(wxObject, items.Length, items, pos);
		}
	
		//---------------------------------------------------------------------
	
		public void Set(string[] items, ClientData data)
		{
			wxListBox_Set(wxObject, items.Length, items, Object.SafePtr(data));
		}
	
		public void Set(string[] items)
		{
			wxListBox_Set(wxObject, items.Length, items, Object.SafePtr(null));
		}
	
		//---------------------------------------------------------------------
	
		public bool Selected(int n)
		{
			return wxListBox_Selected(wxObject, n);
		}
		
		//---------------------------------------------------------------------
	
		public bool Sorted
		{
			get { return wxListBox_IsSorted(wxObject); }
		}
	
		//---------------------------------------------------------------------
	
		public bool HasMultipleSelection()
		{
			return wxListBox_HasMultipleSelection(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public void Deselect(int n)
		{
			wxListBox_Deselect(wxObject, n);
		}
	
		public void DeselectAll(int itemToLeaveSelected)
		{
			wxListBox_DeselectAll(wxObject, itemToLeaveSelected);
		}
	
		//---------------------------------------------------------------------
	
		public int[] Selections
		{
			get { return new ArrayInt(wxListBox_GetSelections(wxObject), true); }
		}
	
		//---------------------------------------------------------------------
	
		public void SetFirstItem(int n)
		{
			wxListBox_SetFirstItem(wxObject, n);
		}
	
		public void SetFirstItem(string s)
		{
			wxListBox_SetFirstItemText(wxObject, s);
		}
	
		//---------------------------------------------------------------------
	
		public void Command(Event evt)
		{
			wxListBox_Command(wxObject, Object.SafePtr(evt));
		}
	
		//---------------------------------------------------------------------
	
		public int Count 
		{
			get { return wxListBox_GetCount(wxObject); }
		}
	
		//---------------------------------------------------------------------
	
		public event EventListener Select
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LISTBOX_SELECTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	
		public event EventListener DoubleClick
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
	
	//---------------------------------------------------------------------
	
	public class CheckListBox : ListBox
	{
		[DllImport("wx-c")] static extern IntPtr wxCheckListBox_ctor1();
		[DllImport("wx-c")] static extern IntPtr wxCheckListBox_ctor2(IntPtr parent, 
			int id,
			ref Point pos,
			ref Size size,
			int nStrings,
			string[] choices,
			uint style,
			IntPtr validator,
			string name);
		[DllImport("wx-c")] static extern bool wxCheckListBox_IsChecked(IntPtr self, int index);
		[DllImport("wx-c")] static extern void wxCheckListBox_Check(IntPtr self, int index, bool check);
		[DllImport("wx-c")] static extern int wxCheckListBox_GetItemHeight(IntPtr self);
		
		//---------------------------------------------------------------------
	
		public CheckListBox(IntPtr wxObject)
			: base(wxObject) {}
			
		public CheckListBox()
			: base(wxCheckListBox_ctor1()) {}
			
		public CheckListBox(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, "") {}
			
		public CheckListBox(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, null, 0, null, "") {}
			
		public CheckListBox(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, null, 0, null, "") {}
			
		public CheckListBox(Window parent, int id, Point pos, Size size, string[] choices)
			: this(parent, id, pos, size, choices.Length, choices, 0, null, "") {}
			
		public CheckListBox(Window parent, int id, Point pos, Size size, string[] choices, long style)
			: this(parent, id, pos, size, choices.Length, choices, style, null, "") {}
			
		public CheckListBox(Window parent, int id, Point pos, Size size, string[] choices, long style, Validator validator)
			: this(parent, id, pos, size, choices.Length, choices, style, validator, "") {}
			
		public CheckListBox(Window parent, int id, Point pos, Size size, string[] choices, long style, Validator validator, string name)
			: this(parent, id, pos, size, choices.Length, choices, style, validator, name) {}
			
		public CheckListBox(Window parent, int id, Point pos, Size size, int n, string[] choices, long style, Validator validator, string name)
			: base(wxCheckListBox_ctor2(Object.SafePtr(parent), id, ref pos, ref size, n, choices, (uint)style, Object.SafePtr(validator), name)) {}
			
		//---------------------------------------------------------------------
		// ctors with self created id
			
		public CheckListBox(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, "") {}
			
		public CheckListBox(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, null, 0, null, "") {}
			
		public CheckListBox(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, null, 0, null, "") {}
			
		public CheckListBox(Window parent, Point pos, Size size, string[] choices)
			: this(parent, Window.UniqueID, pos, size, choices.Length, choices, 0, null, "") {}
			
		public CheckListBox(Window parent, Point pos, Size size, string[] choices, long style)
			: this(parent, Window.UniqueID, pos, size, choices.Length, choices, style, null, "") {}
			
		public CheckListBox(Window parent, Point pos, Size size, string[] choices, long style, Validator validator)
			: this(parent, Window.UniqueID, pos, size, choices.Length, choices, style, validator, "") {}
			
		public CheckListBox(Window parent, Point pos, Size size, string[] choices, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, pos, size, choices.Length, choices, style, validator, name) {}
			
		public CheckListBox(Window parent, Point pos, Size size, int n, string[] choices, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, pos, size, n, choices, style, validator, name) {}

		//--------------------------------------------------------------------
		
		public bool IsChecked(int index)
		{
			return wxCheckListBox_IsChecked(wxObject, index);
		}
		
		//---------------------------------------------------------------------
		
		public void Check(int index)
		{
			Check(index, true);
		}
		
		public void Check(int index, bool check)
		{
			wxCheckListBox_Check(wxObject, index, check);
		}
		
		//---------------------------------------------------------------------
		
		#if ! __WXMAC__
		public int ItemHeight
		{
			get { return wxCheckListBox_GetItemHeight(wxObject); }
		}
		#endif
		
		//---------------------------------------------------------------------
		
		public event EventListener Checked
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}
