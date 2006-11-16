//-----------------------------------------------------------------------------
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

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class ToggleButton : Control
	{
		[DllImport("wx-c")] static extern IntPtr wxToggleButton_ctor();
		[DllImport("wx-c")] static extern bool   wxToggleButton_Create(IntPtr self, IntPtr parent,
			int id, string label, ref Point pos, ref Size size, uint style,
			IntPtr validator, string name);
		[DllImport("wx-c")] static extern bool wxToggleButton_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern bool wxToggleButton_SetValue(IntPtr self, bool state);

		//---------------------------------------------------------------------
		
		public ToggleButton(IntPtr wxObject) 
			: base(wxObject) { }

		public ToggleButton()
			: base(wxToggleButton_ctor())	{ }

		public ToggleButton(Window parent, int id, string label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public ToggleButton(Window parent, int id, string label, Point pos)
			: this(parent, id, label, pos, wxDefaultSize, 0, null, null) { }

		public ToggleButton(Window parent, int id, string label, Point pos, Size size)
			: this(parent, id, label, pos, size, 0, null, null) { }

		public ToggleButton(Window parent, int id, string label, Point pos, Size size, long style)
			: this(parent, id, label, pos, size, style, null, null) { }

		public ToggleButton(Window parent, int id, string label, Point pos, Size size, long style, Validator validator)
			: this(parent, id, label, pos, size, style, validator, null) { }

		public ToggleButton(Window parent, int id, string label, Point pos, Size size, long style, Validator validator, string name)
			: base(wxToggleButton_ctor())
		{
			if (!Create(parent, id, label, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create ToggleButton");
			}
		}
		
		//---------------------------------------------------------------------
		
		public ToggleButton(Window parent, string label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public ToggleButton(Window parent, string label, Point pos)
			: this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null, null) { }

		public ToggleButton(Window parent, string label, Point pos, Size size)
			: this(parent, Window.UniqueID, label, pos, size, 0, null, null) { }

		public ToggleButton(Window parent, string label, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, label, pos, size, style, null, null) { }

		public ToggleButton(Window parent, string label, Point pos, Size size, long style, Validator validator)
			: this(parent, Window.UniqueID, label, pos, size, style, validator, null) { }

		public ToggleButton(Window parent, string label, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, label, pos, size, style, validator, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size,
			long style, Validator validator, string name)
		{
			return wxToggleButton_Create(wxObject, Object.SafePtr(parent), id, label, ref pos, ref size,
				(uint)style, Object.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------

		public bool State
		{
			get { return wxToggleButton_GetValue(wxObject); }
			set { wxToggleButton_SetValue(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public event EventListener Click
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}

