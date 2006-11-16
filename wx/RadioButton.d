//-----------------------------------------------------------------------------
// wxD - RadioButton.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - RadioButton.cs
//
// The wxRadioButton wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------

module wx.RadioButton;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxRadioButton_ctor();
		static extern (C) bool   wxRadioButton_Create(IntPtr self, IntPtr parent, int id, string label, inout Point pos, inout Size size, uint style, IntPtr val, string name);
		static extern (C) bool   wxRadioButton_GetValue(IntPtr self);
		static extern (C) void   wxRadioButton_SetValue(IntPtr self, bool state);
	
		//---------------------------------------------------------------------
		
	public class RadioButton : Control 
	{
		public const int wxRB_GROUP     = 0x0004;
		public const int wxRB_SINGLE    = 0x0008;
		
		//---------------------------------------------------------------------
	
		public this(IntPtr wxobj) 
			{ super(wxobj);}
		
		public this()
			{ super (wxRadioButton_ctor()); }

		public this(Window parent, int id, string label)
			{ this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null, null); }

		public this(Window parent, int id, string label, Point pos)
			{ this(parent, id, label, pos, wxDefaultSize, 0, null, null); }

		public this(Window parent, int id, string label, Point pos, Size size)
			{ this(parent, id, label, pos, size, 0, null, null); }

		public this(Window parent, int id, string label, Point pos, Size size, int style)
			{ this(parent, id, label, pos, size, style, null, null); }

		public this(Window parent, int id, string label, Point pos, Size size, int style, Validator val)
			{ this(parent, id, label, pos, size, style, val, null); }

		public this(Window parent, int id, string label, Point pos, Size size, int style, Validator val, string name)
		{
			super(wxRadioButton_ctor());
			if (!wxRadioButton_Create(wxobj, wxObject.SafePtr(parent), id,
					label, pos, size, cast(uint)style, wxObject.SafePtr(val), name))
			{
				throw new InvalidOperationException("Failed to create RadioButton");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, string label)
			{ this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null, null); }

		public this(Window parent, string label, Point pos)
			{ this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null, null); }

		public this(Window parent, string label, Point pos, Size size)
			{ this(parent, Window.UniqueID, label, pos, size, 0, null, null); }

		public this(Window parent, string label, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, label, pos, size, style, null, null); }

		public this(Window parent, string label, Point pos, Size size, int style, Validator val)
			{ this(parent, Window.UniqueID, label, pos, size, style, val, null); }

		public this(Window parent, string label, Point pos, Size size, int style, Validator val, string name)
			{ this(parent, Window.UniqueID, label, pos, size, style, val, name);}

		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size, int style, Validator val, string name)
		{
			return wxRadioButton_Create(wxobj, wxObject.SafePtr(parent), id,
					label, pos, size, cast(uint)style, wxObject.SafePtr(val), name);
		}

		//---------------------------------------------------------------------

		public bool Value() { return wxRadioButton_GetValue(wxobj); }
		public void Value(bool value) { wxRadioButton_SetValue(wxobj, value); }

		//---------------------------------------------------------------------

		public void Select_Add(EventListener value) { AddCommandListener(Event.wxEVT_COMMAND_RADIOBUTTON_SELECTED, ID, value, this); }
		public void Select_Remove(EventListener value) { RemoveHandler(value, this); }
	}
