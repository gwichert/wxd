//-----------------------------------------------------------------------------
// wx.NET - SpinCtrl.cs
//
// The wxSpinCtrl wrapper class.
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
	public class SpinCtrl : Control 
	{
		// These are duplicated in SpinButton.cs (for easier access)
		public const long wxSP_HORIZONTAL       = Orientation.wxHORIZONTAL;
		public const long wxSP_VERTICAL         = Orientation.wxVERTICAL;
		public const long wxSP_ARROW_KEYS       = 0x1000;
		public const long wxSP_WRAP             = 0x2000;
	
		//---------------------------------------------------------------------
		
		[DllImport("wx-c")] static extern IntPtr wxSpinCtrl_ctor();
		[DllImport("wx-c")] static extern bool   wxSpinCtrl_Create(IntPtr self, IntPtr parent, int id, string value, ref Point pos, ref Size size, uint style, int min, int max, int initial, string name);
		[DllImport("wx-c")] static extern int    wxSpinCtrl_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSpinCtrl_GetMin(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSpinCtrl_GetMax(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSpinCtrl_SetValueStr(IntPtr self, string value);
		[DllImport("wx-c")] static extern void   wxSpinCtrl_SetValue(IntPtr self, int val);
		[DllImport("wx-c")] static extern void   wxSpinCtrl_SetRange(IntPtr self, int min, int max);
	
		//---------------------------------------------------------------------
		
		public SpinCtrl(IntPtr wxObject) 
			: base(wxObject) {}

		public SpinCtrl()
			: base(wxSpinCtrl_ctor()) { }

		public SpinCtrl(Window parent, int id)
			: this(parent, id, "", wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, int id, string value)
			: this(parent, id, value, wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, int id, string value, Point pos, Size size)
			: this(parent, id, value, pos, size, wxSP_ARROW_KEYS, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, int id, string value, Point pos, Size size, long style)
			: this(parent, id, value, pos, size, style, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, int id, string value, Point pos, Size size, long style, int min, int max, int initial)
			: this(parent, id, value, pos, size, style, min, max, initial, null ) { }

		public SpinCtrl(Window parent, int id, string value, Point pos, Size size, long style, int min, int max, int initial, string name)
			: base(wxSpinCtrl_ctor())
		{
			if(!Create(parent, id, value, pos, size, style, min, max, initial, name))
			{
				throw new InvalidOperationException("Failed to create SpinCtrl");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public SpinCtrl(Window parent)
			: this(parent, Window.UniqueID, "", wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, string value)
			: this(parent, Window.UniqueID, value, wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, string value, Point pos, Size size)
			: this(parent, Window.UniqueID, value, pos, size, wxSP_ARROW_KEYS, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, string value, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, value, pos, size, style, 0, 100, 0, null ) { }

		public SpinCtrl(Window parent, string value, Point pos, Size size, long style, int min, int max, int initial)
			: this(parent, Window.UniqueID, value, pos, size, style, min, max, initial, null ) { }

		public SpinCtrl(Window parent, string value, Point pos, Size size, long style, int min, int max, int initial, string name)
			: this(parent, Window.UniqueID, value, pos, size, style, min, max, initial, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string value, Point pos, Size size, long style, int min, int max, int initial, string name)
		{
			return wxSpinCtrl_Create(wxObject, Object.SafePtr(parent), id, 
					value, ref pos, ref size, (uint)style, min,
					max, initial, name);
		}

		//---------------------------------------------------------------------

		public int Value
		{
			get { return wxSpinCtrl_GetValue(wxObject); }
			set { wxSpinCtrl_SetValue(wxObject, value); }
		}

		public void SetValue(string val)
		{
			wxSpinCtrl_SetValueStr(wxObject, val);
		}

		//---------------------------------------------------------------------
        
		public int Max
		{
			get { return wxSpinCtrl_GetMax(wxObject); }
		}

		public int Min
		{
			get { return wxSpinCtrl_GetMin(wxObject); }
		}

		public void SetRange(int min, int max)
		{
			wxSpinCtrl_SetRange(wxObject, min, max);
		}

		//---------------------------------------------------------------------

		public override event EventListener UpdateUI
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_SPINCTRL_UPDATED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}

