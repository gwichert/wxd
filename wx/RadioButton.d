//-----------------------------------------------------------------------------
// wx.NET - RadioButton.cs
//
// The wxRadioButton wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class RadioButton : Control 
	{
		public const int wxRB_GROUP     = 0x0004;
		public const int wxRB_SINGLE    = 0x0008;
		
		//---------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxRadioButton_ctor();
		[DllImport("wx-c")] static extern bool   wxRadioButton_Create(IntPtr self, IntPtr parent, int id, string label, ref Point pos, ref Size size, uint style, IntPtr val, string name);
		[DllImport("wx-c")] static extern bool   wxRadioButton_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern void   wxRadioButton_SetValue(IntPtr self, bool state);
	
		//---------------------------------------------------------------------
		
		public RadioButton(IntPtr wxObject) 
			: base(wxObject) {}
		
		public RadioButton()
			: base (wxRadioButton_ctor()) { }

		public RadioButton(Window parent, int id, string label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public RadioButton(Window parent, int id, string label, Point pos)
			: this(parent, id, label, pos, wxDefaultSize, 0, null, null) { }

		public RadioButton(Window parent, int id, string label, Point pos, Size size)
			: this(parent, id, label, pos, size, 0, null, null) { }

		public RadioButton(Window parent, int id, string label, Point pos, Size size, int style)
			: this(parent, id, label, pos, size, style, null, null) { }

		public RadioButton(Window parent, int id, string label, Point pos, Size size, int style, Validator val)
			: this(parent, id, label, pos, size, style, val, null) { }

		public RadioButton(Window parent, int id, string label, Point pos, Size size, int style, Validator val, string name)
			: base(wxRadioButton_ctor())
		{
			if (!wxRadioButton_Create(wxObject, Object.SafePtr(parent), id,
					label, ref pos, ref size, (uint)style, Object.SafePtr(val), name))
			{
				throw new InvalidOperationException("Failed to create RadioButton");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public RadioButton(Window parent, string label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public RadioButton(Window parent, string label, Point pos)
			: this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null, null) { }

		public RadioButton(Window parent, string label, Point pos, Size size)
			: this(parent, Window.UniqueID, label, pos, size, 0, null, null) { }

		public RadioButton(Window parent, string label, Point pos, Size size, int style)
			: this(parent, Window.UniqueID, label, pos, size, style, null, null) { }

		public RadioButton(Window parent, string label, Point pos, Size size, int style, Validator val)
			: this(parent, Window.UniqueID, label, pos, size, style, val, null) { }

		public RadioButton(Window parent, string label, Point pos, Size size, int style, Validator val, string name)
			: this(parent, Window.UniqueID, label, pos, size, style, val, name) {}

		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size, int style, Validator val, string name)
		{
			return wxRadioButton_Create(wxObject, Object.SafePtr(parent), id,
					label, ref pos, ref size, (uint)style, Object.SafePtr(val), name);
		}

		//---------------------------------------------------------------------

		public bool Value
		{
			get { return wxRadioButton_GetValue(wxObject); }
			set { wxRadioButton_SetValue(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public event EventListener Select
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_RADIOBUTTON_SELECTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}
