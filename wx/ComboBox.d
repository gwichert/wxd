//-----------------------------------------------------------------------------
// wx.NET - ComboBox.cs
//
// The wxComboBox wrapper class.
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
	public class ComboBox : Control
	{
		public const long wxCB_SIMPLE           = 0x0004;
		public const long wxCB_SORT             = 0x0008;
		public const long wxCB_READONLY         = 0x0010;
		public const long wxCB_DROPDOWN         = 0x0020;
		
		//---------------------------------------------------------------------
		
		[DllImport("wx-c")] static extern IntPtr wxComboBox_ctor();
		[DllImport("wx-c")] static extern bool   wxComboBox_Create(IntPtr self, IntPtr window, int id, string value, ref Point pos, ref Size size, int n, string[] choices, uint style, IntPtr validator, string name);
		
		[DllImport("wx-c")] static extern void   wxComboBox_Append(IntPtr self, string item);
		[DllImport("wx-c")] static extern void   wxComboBox_AppendData(IntPtr self, string item, IntPtr data);
		
		[DllImport("wx-c")] static extern void   wxComboBox_Clear(IntPtr self);
		[DllImport("wx-c")] static extern void   wxComboBox_Delete(IntPtr self, int n);
		
		[DllImport("wx-c")] static extern int    wxComboBox_FindString(IntPtr self, string str);
		
		[DllImport("wx-c")] static extern int    wxComboBox_GetCount(IntPtr self);
		[DllImport("wx-c")] static extern int    wxComboBox_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxComboBox_GetString(IntPtr self, int n);
		//[DllImport("wx-c")] static extern void   wxComboBox_SetString(IntPtr self, int n, string text);
		
		[DllImport("wx-c")] static extern IntPtr wxComboBox_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern void   wxComboBox_SetValue(IntPtr self, string text);
		
		[DllImport("wx-c")] static extern IntPtr wxComboBox_GetStringSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxComboBox_SetStringSelection(IntPtr self, string value);
		
		[DllImport("wx-c")] static extern IntPtr wxComboBox_GetClientData(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxComboBox_SetClientData(IntPtr self, int n, IntPtr data);
		
		[DllImport("wx-c")] static extern void   wxComboBox_Copy(IntPtr self);
		[DllImport("wx-c")] static extern void   wxComboBox_Cut(IntPtr self);
		[DllImport("wx-c")] static extern void   wxComboBox_Paste(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxComboBox_SetInsertionPoint(IntPtr self, uint pos);
		[DllImport("wx-c")] static extern uint   wxComboBox_GetInsertionPoint(IntPtr self);
		[DllImport("wx-c")] static extern void   wxComboBox_SetInsertionPointEnd(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxComboBox_GetLastPosition(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxComboBox_Replace(IntPtr self, uint from, uint to, string value);
		[DllImport("wx-c")] static extern void   wxComboBox_SetSelectionSingle(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxComboBox_SetSelectionMult(IntPtr self, uint from, uint to);
		[DllImport("wx-c")] static extern void   wxComboBox_SetEditable(IntPtr self, bool editable);
		[DllImport("wx-c")] static extern void   wxComboBox_Remove(IntPtr self, uint from, uint to);
		
		[DllImport("wx-c")] static extern void wxComboBox_SetSelection(IntPtr self, int n);
		
		[DllImport("wx-c")] static extern void wxComboBox_Select(IntPtr self, int n);
		
		//---------------------------------------------------------------------
	
		public ComboBox(IntPtr wxObject) 
			: base(wxObject) { }

		public ComboBox()
			: base(wxComboBox_ctor()) { }

		public ComboBox(Window parent, int id)
			: this(parent, id, "", wxDefaultPosition, wxDefaultSize, new string[] { }, 0, null, null) { }

		public ComboBox(Window parent, int id, string value, Point pos, Size size, string[] choices)
			: this(parent, id, value, pos, size, choices, 0, null, null) { }

		public ComboBox(Window parent, int id, string value, Point pos, Size size, string[] choices, long style)
			: this(parent, id, value, pos, size, choices, style, null, null) { }

		public ComboBox(Window parent, int id, string value, Point pos, Size size, string[] choices, long style, Validator val)
			: this(parent, id, value, pos, size, choices, style, val, null) { }

		public ComboBox(Window parent, int id, 
				string value, Point pos, Size size, 
				string[] choices, long style, Validator validator, 
				string name)
			: base(wxComboBox_ctor())
		{
			if(!wxComboBox_Create(wxObject, Object.SafePtr(parent), id, 
						value, ref pos, ref size, 
						choices.Length, choices, (uint)style, 
						Object.SafePtr(validator), name)) 
			{
				throw new InvalidOperationException("Failed to create ListBox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public ComboBox(Window parent)
			: this(parent, Window.UniqueID, "", wxDefaultPosition, wxDefaultSize, new string[] { }, 0, null, null) { }

		public ComboBox(Window parent, string value, Point pos, Size size, string[] choices)
			: this(parent, Window.UniqueID, value, pos, size, choices, 0, null, null) { }

		public ComboBox(Window parent, string value, Point pos, Size size, string[] choices, long style)
			: this(parent, Window.UniqueID, value, pos, size, choices, style, null, null) { }

		public ComboBox(Window parent, string value, Point pos, Size size, string[] choices, long style, Validator val)
			: this(parent, Window.UniqueID, value, pos, size, choices, style, val, null) { }

		public ComboBox(Window parent,  
				string value, Point pos, Size size, 
				string[] choices, long style, Validator validator, 
				string name)
			: this(parent, Window.UniqueID, value, pos, size, choices, style, validator, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string value, 
				Point pos, Size size,
				string[] choices, long style, Validator validator,
				string name)
		{
			return wxComboBox_Create(wxObject, Object.SafePtr(parent), id,
					value, ref pos, ref size, 
					choices.Length, choices, 
					(uint)style, Object.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------
        
		public int Selection
		{
			get { return wxComboBox_GetSelection(wxObject); }
			set { wxComboBox_SetSelectionSingle(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public string StringSelection
		{
			get { return new wxString(wxComboBox_GetStringSelection(wxObject), true); }
			set { wxComboBox_SetStringSelection(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public int Count
		{
			get { return wxComboBox_GetCount(wxObject); }
		}
		
		//---------------------------------------------------------------------

		public string GetString(int n)
		{
			return new wxString(wxComboBox_GetString(wxObject, n), true);
		}

		//---------------------------------------------------------------------

		public ClientData GetClientData(int n)
		{
			return (ClientData)Object.FindObject(wxComboBox_GetClientData(wxObject, n));
		}

		public void SetClientData(int n, ClientData data)
		{
			wxComboBox_SetClientData(wxObject, n, Object.SafePtr(data));
		}

		//---------------------------------------------------------------------

		public int FindString(string str)
		{
			return wxComboBox_FindString(wxObject, str);
		}

		//---------------------------------------------------------------------

		public void Delete(int n)
		{
			wxComboBox_Delete(wxObject, n);
		}

		public void Clear()
		{
			wxComboBox_Clear(wxObject);
		}

		//---------------------------------------------------------------------

		public void Append(string item)
		{
			wxComboBox_Append(wxObject, item);
		}

		public void Append(string item, ClientData data)
		{
			wxComboBox_AppendData(wxObject, item, Object.SafePtr(data));
		}

		//---------------------------------------------------------------------

		public void Copy()
		{
			wxComboBox_Copy(wxObject);
		}
		
		//---------------------------------------------------------------------

		public void Cut()
		{
			wxComboBox_Cut(wxObject);
		}
		
		//---------------------------------------------------------------------

		public void Paste()
		{
			wxComboBox_Paste(wxObject);
		}

		//---------------------------------------------------------------------
        
		public long InsertionPoint
		{
			get { return wxComboBox_GetInsertionPoint(wxObject); }
			set { wxComboBox_SetInsertionPoint(wxObject, (uint)value); }
		}
		
		//---------------------------------------------------------------------

		public void SetInsertionPointEnd()
		{
			wxComboBox_SetInsertionPointEnd(wxObject);
		}
		
		//---------------------------------------------------------------------

		public long GetLastPosition()
		{
			return wxComboBox_GetLastPosition(wxObject);
		}

		//---------------------------------------------------------------------

		public void Replace(long from, long to, string value)
		{
			wxComboBox_Replace(wxObject, (uint)from, (uint)to, value);
		}

		//---------------------------------------------------------------------

		public void SetSelection(long from, long to)
		{
			wxComboBox_SetSelectionMult(wxObject, (uint)from, (uint)to);
		}
		
		public void SetSelection(int n)
		{
			wxComboBox_SetSelection(wxObject, n);
		}

		//---------------------------------------------------------------------

		public bool Editable
		{
			set { wxComboBox_SetEditable(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public void Remove(long from, long to)
		{
			wxComboBox_Remove(wxObject, (uint)from, (uint)to);
		}

		//---------------------------------------------------------------------
        
		public string Value
		{
			get { return new wxString(wxComboBox_GetValue(wxObject), true); }
			set { wxComboBox_SetValue(wxObject, value); }
		}
		
		public void Select(int n)
		{
			wxComboBox_Select(wxObject, n);
		}

		//---------------------------------------------------------------------

		public event EventListener Selected
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_COMBOBOX_SELECTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}

