//-----------------------------------------------------------------------------
// wxD - ToggleButton.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - ToggleButton.cs
//
// The wxToggleToggleButton wrapper class.
//
// Written by Florian Fankhauser (f.fankhauser@gmx.at)
// (C) 2003 Florian Fankhauser
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.ToggleButton;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxToggleButton_ctor();
		static extern (C) bool   wxToggleButton_Create(IntPtr self, IntPtr parent,
			int id, string label, inout Point pos, inout Size size, uint style,
			IntPtr validator, string name);
		static extern (C) bool wxToggleButton_GetValue(IntPtr self);
		static extern (C) bool wxToggleButton_SetValue(IntPtr self, bool state);

		//---------------------------------------------------------------------
		
	public class ToggleButton : Control
	{
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this()
			{ super(wxToggleButton_ctor()); }

		public this(Window parent, int id, string label)
			{ this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null, null); }

		public this(Window parent, int id, string label, Point pos)
			{ this(parent, id, label, pos, wxDefaultSize, 0, null, null); }

		public this(Window parent, int id, string label, Point pos, Size size)
			{ this(parent, id, label, pos, size, 0, null, null); }

		public this(Window parent, int id, string label, Point pos, Size size, int style)
			{ this(parent, id, label, pos, size, style, null, null); }

		public this(Window parent, int id, string label, Point pos, Size size, int style, Validator validator)
			{ this(parent, id, label, pos, size, style, validator, null); }

		public this(Window parent, int id, string label, Point pos, Size size, int style, Validator validator, string name)
		{
			super(wxToggleButton_ctor());
			if (!Create(parent, id, label, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create ToggleButton");
			}
		}
		
		//---------------------------------------------------------------------
		
		public this(Window parent, string label)
			{ this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null, null); }

		public this(Window parent, string label, Point pos)
			{ this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null, null); }

		public this(Window parent, string label, Point pos, Size size)
			{ this(parent, Window.UniqueID, label, pos, size, 0, null, null); }

		public this(Window parent, string label, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, label, pos, size, style, null, null); }

		public this(Window parent, string label, Point pos, Size size, int style, Validator validator)
			{ this(parent, Window.UniqueID, label, pos, size, style, validator, null); }

		public this(Window parent, string label, Point pos, Size size, int style, Validator validator, string name)
			{ this(parent, Window.UniqueID, label, pos, size, style, validator, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size,
			int style, Validator validator, string name)
		{
			return wxToggleButton_Create(wxobj, wxObject.SafePtr(parent), id, label, pos, size,
				cast(uint)style, wxObject.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------

		public bool State() { return wxToggleButton_GetValue(wxobj); }
		public void State(bool value) { wxToggleButton_SetValue(wxobj, value); }

		//---------------------------------------------------------------------

		public void Click_Add(EventListener value) { AddCommandListener(Event.wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, ID, value, this); }
		public void Click_Remove(EventListener value) { RemoveHandler(value, this); }
	}

