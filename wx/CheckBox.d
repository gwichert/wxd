//-----------------------------------------------------------------------------
// wx.NET - CheckBox.cs
//
// The wxCheckBox wrapper class.
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
	public enum CheckBoxState
	{
		wxCHK_UNCHECKED,
		wxCHK_CHECKED,
		wxCHK_UNDETERMINED
	}
	
	//---------------------------------------------------------------------

	public class CheckBox : Control
	{
		public const long wxCHK_2STATE           = 0x0000;
		public const long wxCHK_3STATE           = 0x1000;
		public const long wxCHK_ALLOW_3RD_STATE_FOR_USER           = 0x2000;
	
		[DllImport("wx-c")] static extern IntPtr wxCheckBox_ctor();
		[DllImport("wx-c")] static extern bool   wxCheckBox_Create(IntPtr self, IntPtr parent, int id, string label, ref Point pos, ref Size size, uint style, IntPtr val, string name);
		[DllImport("wx-c")] static extern bool   wxCheckBox_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern void   wxCheckBox_SetValue(IntPtr self, bool state);
		[DllImport("wx-c")] static extern bool   wxCheckBox_IsChecked(IntPtr self);
		
		[DllImport("wx-c")] static extern CheckBoxState wxCheckBox_Get3StateValue(IntPtr self);
		[DllImport("wx-c")] static extern void wxCheckBox_Set3StateValue(IntPtr self, CheckBoxState state);
		[DllImport("wx-c")] static extern bool wxCheckBox_Is3State(IntPtr self);
		[DllImport("wx-c")] static extern bool wxCheckBox_Is3rdStateAllowedForUser(IntPtr self);

		//---------------------------------------------------------------------
		
		public CheckBox(IntPtr wxObject) 
			: base(wxObject) {}
			
		public CheckBox()
			: this(wxCheckBox_ctor()) { }

		public CheckBox(Window parent, int id, string label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public CheckBox(Window parent, int id, string label, Point pos)
        		: this(parent, id, label, pos, wxDefaultSize, 0, null, null) { }

		public CheckBox(Window parent, int id, string label, Point pos, Size size)
        		: this(parent, id, label, pos, size, 0, null, null) { }

		public CheckBox(Window parent, int id, string label, Point pos, Size size, long style)
        		: this(parent, id, label, pos, size, style, null, null) { }

		public CheckBox(Window parent, int id, string label, Point pos, Size size, long style, Validator val)
        		: this(parent, id, label, pos, size, style, val, null) { }

		public CheckBox(Window parent, int id, string label, Point pos, Size size, long style, Validator val, string name)
			: this(wxCheckBox_ctor())
		{
			if (!wxCheckBox_Create(wxObject, Object.SafePtr(parent), id,
			                       label, ref pos, ref size, (uint)style, Object.SafePtr(val), name))
			{
				throw new InvalidOperationException("failed to create checkbox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public CheckBox(Window parent, string label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public CheckBox(Window parent, string label, Point pos)
        		: this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null, null) { }

		public CheckBox(Window parent, string label, Point pos, Size size)
        		: this(parent, Window.UniqueID, label, pos, size, 0, null, null) { }

		public CheckBox(Window parent, string label, Point pos, Size size, long style)
        		: this(parent, Window.UniqueID, label, pos, size, style, null, null) { }

		public CheckBox(Window parent, string label, Point pos, Size size, long style, Validator val)
        		: this(parent, Window.UniqueID, label, pos, size, style, val, null) { }

		public CheckBox(Window parent, string label, Point pos, Size size, long style, Validator val, string name)
			: this(parent, Window.UniqueID, label, pos, size, style, val, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size,
			long style, Validator val, string name)
		{
			return wxCheckBox_Create(wxObject, Object.SafePtr(parent), id,
			                       label, ref pos, ref size, (uint)style, Object.SafePtr(val), name);
		}

		//---------------------------------------------------------------------

		public bool Value
		{
			get { return wxCheckBox_GetValue(wxObject); }
			set { wxCheckBox_SetValue(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public bool IsChecked
		{
			get { return wxCheckBox_IsChecked(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public CheckBoxState ThreeStateValue
		{
			get { return wxCheckBox_Get3StateValue(wxObject); }
			set { wxCheckBox_Set3StateValue(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public bool Is3State()
		{
			return wxCheckBox_Is3State(wxObject);
		}

		//---------------------------------------------------------------------
		
		public bool Is3rdStateAllowedForUser()
		{
			return wxCheckBox_Is3rdStateAllowedForUser(wxObject);
		}
		
		//---------------------------------------------------------------------
        
		public event EventListener Clicked
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_CHECKBOX_CLICKED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}
