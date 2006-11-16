//-----------------------------------------------------------------------------
// wxD - ListBox.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.ListBox;
import wx.common;
import wx.Control;
import wx.ClientData;

		static extern (C) IntPtr wxListBox_ctor();
		static extern (C) void   wxListBox_dtor(IntPtr self);
		static extern (C) void   wxListBox_Clear(IntPtr self);
		static extern (C) bool   wxListBox_Create(IntPtr self, IntPtr parent, int id, inout Point pos, inout Size size, int n, string* choices, uint style, IntPtr validator, string name);
		static extern (C) void   wxListBox_InsertText(IntPtr self, string item, int pos);
		static extern (C) void   wxListBox_InsertTextData(IntPtr self, string item, int pos, IntPtr data);
		static extern (C) void   wxListBox_InsertTextClientData(IntPtr self, string item, int pos, IntPtr clientData);
		static extern (C) void   wxListBox_InsertItems(IntPtr self, int nItems, string* items, int pos);
		static extern (C) void   wxListBox_Set(IntPtr self, int n, string* items, IntPtr clientData);
		static extern (C) void   wxListBox_SetSelection(IntPtr self, int n, bool select);
		static extern (C) void   wxListBox_Select(IntPtr self, int n);
		static extern (C) void   wxListBox_Deselect(IntPtr self, int n);
		static extern (C) void   wxListBox_DeselectAll(IntPtr self, int itemToLeaveSelected);
		static extern (C) bool   wxListBox_SetStringSelection(IntPtr self, string s, bool select);
		static extern (C) IntPtr wxListBox_GetSelections(IntPtr self);
		static extern (C) void   wxListBox_SetFirstItem(IntPtr self, int n);
		static extern (C) void   wxListBox_SetFirstItemText(IntPtr self, string s);
		static extern (C) bool   wxListBox_HasMultipleSelection(IntPtr self);
		static extern (C) bool   wxListBox_IsSorted(IntPtr self);
		static extern (C) void   wxListBox_Command(IntPtr self, IntPtr evt);
		static extern (C) bool   wxListBox_Selected(IntPtr self, int n);
		static extern (C) int    wxListBox_GetSelection(IntPtr self);
		static extern (C) string wxListBox_GetStringSelection(IntPtr self);
		static extern (C) void   wxListBox_SetSingleString(IntPtr self, int n, string s);
		static extern (C) string wxListBox_GetSingleString(IntPtr self, int n);
		static extern (C) void   wxListBox_Append(IntPtr self, string item);
		static extern (C) void   wxListBox_AppendClientData(IntPtr self, string item, IntPtr cliendData);
		static extern (C) void   wxListBox_Delete(IntPtr self, int n);
		static extern (C) int    wxListBox_GetCount(IntPtr self);
	
		//---------------------------------------------------------------------
	
	public class ListBox : Control
	{
		public const int wxLB_SORT             = 0x0010;
		public const int wxLB_SINGLE           = 0x0020;
		public const int wxLB_MULTIPLE         = 0x0040;
		public const int wxLB_EXTENDED         = 0x0080;
		public const int wxLB_OWNERDRAW        = 0x0100;
		public const int wxLB_NEED_SB          = 0x0200;
		public const int wxLB_ALWAYS_SB        = 0x0400;
		public const int wxLB_HSCROLL          = wxHSCROLL;
		public const int wxLB_INT_HEIGHT       = 0x0800;
	
		//---------------------------------------------------------------------
		
		public this(IntPtr wxobj) 
			{ super(wxobj); }
	
		public this()
			{ super(wxListBox_ctor()); }

		public this(Window parent, int id)
			{ this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, null); }
	
		public this(Window parent, int id, Point pos)
			{ this(parent, id, pos, wxDefaultSize, 0, null, 0, null, null); }
	
		public this(Window parent, int id, Point pos, Size size)
			{ this(parent, id, pos, size, 0, null, 0, null, null); }
	
		public this(Window parent, int id, Point pos, Size size, int n, string[] choices)
			{ this(parent, id, pos, size, n, choices, 0, null, null); }
	
		public this(Window parent, int id, Point pos, Size size, int n, string[] choices, int style)
			{ this(parent, id, pos, size, n, choices, style, null, null); }
	
		public this(Window parent, int id, Point pos, Size size, int n, string[] choices, int style, Validator val)
			{ this(parent, id, pos, size, n, choices, style, val, null); }
	
		public this(Window parent, int id, Point pos, Size size, int n,
			string[] choices, int style, Validator validator, string name)
		{
			super(wxListBox_ctor());
			if(!wxListBox_Create(wxobj, wxObject.SafePtr(parent), id,
					pos, size, n, choices, cast(uint)style,
					wxObject.SafePtr(validator), name))
			{
				throw new InvalidOperationException("Failed to create ListBox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent)
			{ this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, null); }
	
		public this(Window parent, Point pos)
			{ this(parent, Window.UniqueID, pos, wxDefaultSize, 0, null, 0, null, null); }
	
		public this(Window parent, Point pos, Size size)
			{ this(parent, Window.UniqueID, pos, size, 0, null, 0, null, null); }
	
		public this(Window parent, Point pos, Size size, int n, string[] choices)
			{ this(parent, Window.UniqueID, pos, size, n, choices, 0, null, null); }
	
		public this(Window parent, Point pos, Size size, int n, string[] choices, int style)
			{ this(parent, Window.UniqueID, pos, size, n, choices, style, null, null); }
	
		public this(Window parent, Point pos, Size size, int n, string[] choices, int style, Validator val)
			{ this(parent, Window.UniqueID, pos, size, n, choices, style, val, null); }
	
		public this(Window parent, Point pos, Size size, int n,
			string[] choices, int style, Validator validator, string name)
			{ this( parent, Window.UniqueID, pos, size, n, choices, style, validator, name);}
		
		//---------------------------------------------------------------------
	
		public bool Create(Window parent, int id, Point pos, Size size, int n,
				string[] choices, int style, Validator validator, string name)
		{
			return wxListBox_Create(wxobj, wxObject.SafePtr(parent), id,
					pos, size, n, choices, cast(uint)style,
					wxObject.SafePtr(validator), name);
		}
		
		//---------------------------------------------------------------------
	
		public int Selection() { return wxListBox_GetSelection(wxobj); }
		public void Selection(int value) { wxListBox_Select(wxobj, value); }
		
		//---------------------------------------------------------------------
	
		public string StringSelection() { return wxListBox_GetStringSelection(wxobj).dup; }
		public void StringSelection(string value) { wxListBox_SetStringSelection(wxobj, value, true); }
		
		//---------------------------------------------------------------------
	
		public void SetSelection(int n, bool select)
		{
			wxListBox_SetSelection(wxobj, n, select);
		}
	
		public void SetSelection(string item, bool select)
		{
			wxListBox_SetStringSelection(wxobj, item, select);
		}
	
		//---------------------------------------------------------------------
	
		public void Clear()
		{
			wxListBox_Clear(wxobj);
		}
	
		//---------------------------------------------------------------------
	
		public string GetString(int n) 
		{
			return wxListBox_GetSingleString(wxobj, n).dup;
		}
	
		public void SetString(int n, string str)
		{
			wxListBox_SetSingleString(wxobj, n, str);
		}
	
		//---------------------------------------------------------------------
	
		public void Append(string item)
		{
			wxListBox_Append(wxobj, item);
		}
	
		public void Append(string item, ClientData data)
		{
			wxListBox_AppendClientData(wxobj, item, wxObject.SafePtr(data));
		}
		
		//---------------------------------------------------------------------
	
		public void Delete(int n)
		{
			wxListBox_Delete(wxobj, n);
		}
	
		//---------------------------------------------------------------------
	
		public void Insert(string item, int pos)
		{
			wxListBox_InsertText(wxobj, item, pos);
		}
	
		public void Insert(string item, int pos, ClientData data)
		{
			wxListBox_InsertTextData(wxobj, item, pos, wxObject.SafePtr(data));
		}
	
		/*public void Insert(string item, int pos, ClientData data)
		{
		wxListBox_InsertTextClientData(wxobj, item, pos, wxObject.SafePtr(data));
		}*/
		
		//---------------------------------------------------------------------
	
		public void InsertItems(string[] items, int pos)
		{
			wxListBox_InsertItems(wxobj, items.length, items, pos);
		}
	
		//---------------------------------------------------------------------
	
		public void Set(string[] items, ClientData data)
		{
			wxListBox_Set(wxobj, items.length, items, wxObject.SafePtr(data));
		}
	
		public void Set(string[] items)
		{
			wxListBox_Set(wxobj, items.length, items, wxObject.SafePtr(null));
		}
	
		//---------------------------------------------------------------------
	
		public bool Selected(int n)
		{
			return wxListBox_Selected(wxobj, n);
		}
		
		//---------------------------------------------------------------------
	
		public bool Sorted() { return wxListBox_IsSorted(wxobj); }
	
		//---------------------------------------------------------------------
	
		public bool HasMultipleSelection()
		{
			return wxListBox_HasMultipleSelection(wxobj);
		}
	
		//---------------------------------------------------------------------
	
		public void Deselect(int n)
		{
			wxListBox_Deselect(wxobj, n);
		}
	
		public void DeselectAll(int itemToLeaveSelected)
		{
			wxListBox_DeselectAll(wxobj, itemToLeaveSelected);
		}
	
		//---------------------------------------------------------------------
	
		public int[] Selections()
		{
			return (new ArrayInt(wxListBox_GetSelections(wxobj),true)).toArray();
		}
	
		//---------------------------------------------------------------------
	
		public void SetFirstItem(int n)
		{
			wxListBox_SetFirstItem(wxobj, n);
		}
	
		public void SetFirstItem(string s)
		{
			wxListBox_SetFirstItemText(wxobj, s);
		}
	
		//---------------------------------------------------------------------
	
		public void Command(Event evt)
		{
			wxListBox_Command(wxobj, wxObject.SafePtr(evt));
		}
	
		//---------------------------------------------------------------------
	
		public int Count() { return wxListBox_GetCount(wxobj); }
	
		//---------------------------------------------------------------------
	
		public void Select_Add(EventListener value) { AddCommandListener(Event.wxEVT_COMMAND_LISTBOX_SELECTED, ID, value, this); }
		public void Select_Remove(EventListener value) { RemoveHandler(value, this); }
	
		public void DoubleClick_Add(EventListener value) { AddCommandListener(Event.wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, ID, value, this); }
		public void DoubleClick_Remove(EventListener value) { RemoveHandler(value, this); }
	}
	
	//---------------------------------------------------------------------
	
		static extern (C) IntPtr wxCheckListBox_ctor1();
		static extern (C) IntPtr wxCheckListBox_ctor2(IntPtr parent, 
			int id,
			inout Point pos,
			inout Size size,
			int nStrings,
			string[] choices,
			uint style,
			IntPtr validator,
			string name);
		static extern (C) bool wxCheckListBox_IsChecked(IntPtr self, int index);
		static extern (C) void wxCheckListBox_Check(IntPtr self, int index, bool check);
		static extern (C) int wxCheckListBox_GetItemHeight(IntPtr self);
		
	public class CheckListBox : ListBox
	{
		//---------------------------------------------------------------------
	
		public this(IntPtr wxobj)
			{ super(wxobj);}
			
		public this()
			{ super(wxCheckListBox_ctor1());}
			
		public this(Window parent, int id)
			{ this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, "");}
			
		public this(Window parent, int id, Point pos)
			{ this(parent, id, pos, wxDefaultSize, 0, null, 0, null, "");}
			
		public this(Window parent, int id, Point pos, Size size)
			{ this(parent, id, pos, size, 0, null, 0, null, "");}
			
		public this(Window parent, int id, Point pos, Size size, string[] choices)
			{ this(parent, id, pos, size, choices.length, choices, 0, null, "");}
			
		public this(Window parent, int id, Point pos, Size size, string[] choices, int style)
			{ this(parent, id, pos, size, choices.length, choices, style, null, "");}
			
		public this(Window parent, int id, Point pos, Size size, string[] choices, int style, Validator validator)
			{ this(parent, id, pos, size, choices.length, choices, style, validator, "");}
			
		public this(Window parent, int id, Point pos, Size size, string[] choices, int style, Validator validator, string name)
			{ this(parent, id, pos, size, choices.length, choices, style, validator, name);}
			
		public this(Window parent, int id, Point pos, Size size, int n, string[] choices, int style, Validator validator, string name)
			{ super(wxCheckListBox_ctor2(wxObject.SafePtr(parent), id, pos, size, n, choices, cast(uint)style, wxObject.SafePtr(validator), name));}
			
		//---------------------------------------------------------------------
		// ctors with self created id
			
		public this(Window parent)
			{ this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null, 0, null, "");}
			
		public this(Window parent, Point pos)
			{ this(parent, Window.UniqueID, pos, wxDefaultSize, 0, null, 0, null, "");}
			
		public this(Window parent, Point pos, Size size)
			{ this(parent, Window.UniqueID, pos, size, 0, null, 0, null, "");}
			
		public this(Window parent, Point pos, Size size, string[] choices)
			{ this(parent, Window.UniqueID, pos, size, choices.length, choices, 0, null, "");}
			
		public this(Window parent, Point pos, Size size, string[] choices, int style)
			{ this(parent, Window.UniqueID, pos, size, choices.length, choices, style, null, "");}
			
		public this(Window parent, Point pos, Size size, string[] choices, int style, Validator validator)
			{ this(parent, Window.UniqueID, pos, size, choices.length, choices, style, validator, "");}
			
		public this(Window parent, Point pos, Size size, string[] choices, int style, Validator validator, string name)
			{ this(parent, Window.UniqueID, pos, size, choices.length, choices, style, validator, name);}
			
		public this(Window parent, Point pos, Size size, int n, string[] choices, int style, Validator validator, string name)
			{ this(parent, Window.UniqueID, pos, size, n, choices, style, validator, name);}

		//--------------------------------------------------------------------
		
		public bool IsChecked(int index)
		{
			return wxCheckListBox_IsChecked(wxobj, index);
		}
		
		//---------------------------------------------------------------------
		
		public void Check(int index)
		{
			Check(index, true);
		}
		
		public void Check(int index, bool check)
		{
			wxCheckListBox_Check(wxobj, index, check);
		}
		
		//---------------------------------------------------------------------
		
		version(__WXMAC__) {
		} else {
		public int ItemHeight() { return wxCheckListBox_GetItemHeight(wxobj); }
		} // version()
		
		//---------------------------------------------------------------------
		
		public void Checked_Add(EventListener value) { AddCommandListener(Event.wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, ID, value, this); }
		public void Checked_Remove(EventListener value) { RemoveHandler(value, this); }
	}
