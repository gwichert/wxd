//-----------------------------------------------------------------------------
// wx.NET - Choice.cs
//
// The wxChoice wrapper class.
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
	public class Choice : Control, IControlWithItems
	{
		[DllImport("wx-c")] static extern IntPtr wxChoice_ctor();
		[DllImport("wx-c")] static extern bool   wxChoice_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, int n, string[] choices, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern void   wxChoice_dtor(IntPtr self);

		[DllImport("wx-c")] static extern void   wxChoice_SetSelection(IntPtr self, int n);
		[DllImport("wx-c")] static extern bool   wxChoice_SetStringSelection(IntPtr self, string s);
		[DllImport("wx-c")] static extern IntPtr wxChoice_GetStringSelection(IntPtr self);

		[DllImport("wx-c")] static extern void   wxChoice_SetColumns(IntPtr self, int n);
		[DllImport("wx-c")] static extern int    wxChoice_GetColumns(IntPtr self);

		[DllImport("wx-c")] static extern void   wxChoice_Command(IntPtr self, IntPtr evt);
		[DllImport("wx-c")] static extern int    wxChoice_GetCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxChoice_GetString(IntPtr self, int n);
		[DllImport("wx-c")] static extern int    wxChoice_GetSelection(IntPtr self);

		[DllImport("wx-c")] static extern IntPtr wxChoice_GetClientData(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxChoice_SetClientData(IntPtr self, int n, IntPtr data);

		[DllImport("wx-c")] static extern int    wxChoice_FindString(IntPtr self, string str);
		
		[DllImport("wx-c")] static extern void   wxChoice_Delete(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxChoice_Clear(IntPtr self);

		[DllImport("wx-c")] static extern int   wxChoice_Append(IntPtr self, string item);
		[DllImport("wx-c")] static extern int   wxChoice_AppendData(IntPtr self, string item, IntPtr data);
		
		[DllImport("wx-c")] static extern	void wxChoice_AppendString(IntPtr self, string item);
		
		[DllImport("wx-c")] static extern	void wxChoice_AppendArrayString(IntPtr self, int n, string[] strings);
		
		[DllImport("wx-c")] static extern	int wxChoice_Insert(IntPtr self, string item, int pos);
		[DllImport("wx-c")] static extern	int wxChoice_InsertClientData(IntPtr self, string item, int pos, IntPtr clientData);
		
		[DllImport("wx-c")] static extern	IntPtr wxChoice_GetStrings(IntPtr self);
		
		[DllImport("wx-c")] static extern	void wxChoice_SetClientObject(IntPtr self, int n, IntPtr clientData);
		[DllImport("wx-c")] static extern	IntPtr wxChoice_GetClientObject(IntPtr self, int n);
		[DllImport("wx-c")] static extern	bool wxChoice_HasClientObjectData(IntPtr self);
		[DllImport("wx-c")] static extern	bool wxChoice_HasClientUntypedData(IntPtr self);
		
		[DllImport("wx-c")] static extern void wxChoice_SetString(IntPtr self, int n, string text);
		
		[DllImport("wx-c")] static extern void wxChoice_Select(IntPtr self, int n);
		
		[DllImport("wx-c")] static extern	bool wxChoice_ShouldInheritColours(IntPtr self);
		
		[DllImport("wx-c")] static extern	bool wxChoice_IsEmpty(IntPtr self);

		//---------------------------------------------------------------------
		
		public Choice(IntPtr wxObject) 
			: base(wxObject) {}

		public Choice()
			: base(wxChoice_ctor()) { }

		public Choice(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, new string[] { }, 0, null, null) { }

		public Choice(Window parent, int id, Point pos, Size size, string[] choices)
			: this(parent, id, pos, size, choices, 0, null, null) { }

		public Choice(Window parent, int id, Point pos, Size size, string[] choices, long style)
			: this(parent, id, pos, size, choices, style, null, null) { }

		public Choice(Window parent, int id, Point pos, Size size, string[] choices, long style, Validator val)
			: this(parent, id, pos, size, choices, style, val, null) { }

		public Choice(Window parent, int id, Point pos, Size size, 
					  string[] choices, long style, Validator validator, string name)
			: base(wxChoice_ctor())
		{
			if(!wxChoice_Create(wxObject, Object.SafePtr(parent), id, ref pos,
								ref size, choices.Length, choices, (uint)style, 
								Object.SafePtr(validator), name)) 
			{
				throw new InvalidOperationException("Failed to create ListBox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Choice(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, new string[] { }, 0, null, null) { }

		public Choice(Window parent, Point pos, Size size, string[] choices)
			: this(parent, Window.UniqueID, pos, size, choices, 0, null, null) { }

		public Choice(Window parent, Point pos, Size size, string[] choices, long style)
			: this(parent, Window.UniqueID, pos, size, choices, style, null, null) { }

		public Choice(Window parent, Point pos, Size size, string[] choices, long style, Validator val)
			: this(parent, Window.UniqueID, pos, size, choices, style, val, null) { }

		public Choice(Window parent, Point pos, Size size, string[] choices, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, pos, size, choices, style, validator, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size,
						   string[] choices, long style, Validator validator,
						   string name)
		{
			return wxChoice_Create(wxObject, Object.SafePtr(parent), id,
								   ref pos, ref size, choices.Length, choices, 
								   (uint)style, Object.SafePtr(validator), name);
		}
		
		//-----------------------------------------------------------------------------
		
		public int Append(string item)
		{
			return wxChoice_Append(wxObject, item);
		}
		
		public int Append(string item, ClientData clientData)
		{
			return wxChoice_AppendData(wxObject, item, Object.SafePtr(clientData));
		}
		
		//-----------------------------------------------------------------------------
		
		public void AppendString(string item)
		{
			wxChoice_AppendString(wxObject, item);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Append(string[] strings)
		{
			wxChoice_AppendArrayString(wxObject, strings.Length, strings);
		}
		
		//-----------------------------------------------------------------------------
		
		public int Insert(string item, int pos)
		{
			return wxChoice_Insert(wxObject, item, pos);
		}
		
		public int Insert(string item, int pos, ClientData clientData)
		{
			return wxChoice_InsertClientData(wxObject, item, pos, Object.SafePtr(clientData));
		}
		
		//-----------------------------------------------------------------------------
		
		public string[] GetStrings()
		{
			return new ArrayString(wxChoice_GetStrings(wxObject), true);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetClientObject(int n, ClientData clientData)
		{
			wxChoice_SetClientObject(wxObject, n, Object.SafePtr(clientData));
		}
		
		public ClientData GetClientObject(int n)
		{
			return (ClientData)Object.FindObject(wxChoice_GetClientObject(wxObject, n), typeof(ClientData));
		}
		
		//-----------------------------------------------------------------------------
		
		public bool HasClientObjectData()
		{
			return wxChoice_HasClientObjectData(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool HasClientUntypedData()
		{
			return wxChoice_HasClientUntypedData(wxObject);
		}

		//---------------------------------------------------------------------
		
		public int Selection
		{
			get { return wxChoice_GetSelection(wxObject); }
			set { wxChoice_SetSelection(wxObject, value); }
		}
		
		public int GetSelection()
		{
			return wxChoice_GetSelection(wxObject);
		}

		//---------------------------------------------------------------------

		public string StringSelection
		{
			get { return new wxString(wxChoice_GetStringSelection(wxObject), true); }
			set { wxChoice_SetStringSelection(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public int Columns
		{
			get { return wxChoice_GetColumns(wxObject); }
			set { wxChoice_SetColumns(wxObject, value); }
		}
		
		//---------------------------------------------------------------------

		public void Command(Event evt)
		{
			wxChoice_Command(wxObject, Object.SafePtr(evt));
		}

		//---------------------------------------------------------------------
		
		public int Count
		{
			get { return wxChoice_GetCount(wxObject); }
		}
		
		//---------------------------------------------------------------------

		public string GetString(int n)
		{
			return new wxString(wxChoice_GetString(wxObject, n), true);
		}

		//---------------------------------------------------------------------

		// TODO: Find way to pass data through C# object
		
		public ClientData GetClientData(int n)
		{
			return (ClientData)Object.FindObject(wxChoice_GetClientData(wxObject, n));
		}

		public void SetClientData(int n, ClientData data)
		{
			wxChoice_SetClientData(wxObject, n, Object.SafePtr(data));
		}

		//---------------------------------------------------------------------

		public int FindString(string str)
		{
			return wxChoice_FindString(wxObject, str);
		}

		//---------------------------------------------------------------------

		public void Delete(int n)
		{
			wxChoice_Delete(wxObject, n);
		}
		
		//---------------------------------------------------------------------

		public void Clear()
		{
			wxChoice_Clear(wxObject);
		}

		//---------------------------------------------------------------------

		public void SetString(int n, string str)
		{
			wxChoice_SetString(wxObject, n, str);
		}
		
		//---------------------------------------------------------------------
		
		public void Select(int n)
		{
			wxChoice_Select(wxObject, n);
		}
		
		//-----------------------------------------------------------------------------
		
		public override bool ShouldInheritColours()
		{
			return wxChoice_ShouldInheritColours(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Empty
		{
			get { return wxChoice_IsEmpty(wxObject); }
		}

		//---------------------------------------------------------------------
        
		public event EventListener Selected
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_CHOICE_SELECTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}
