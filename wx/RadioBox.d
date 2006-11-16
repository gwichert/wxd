//-----------------------------------------------------------------------------
// wx.NET - RadioBox.cs
//
// The wxRadioBox wrapper class.
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
	public class RadioBox : Control
	{
		public const int wxRA_LEFTTORIGHT    = 0x0001;
		public const int wxRA_TOPTOBOTTOM    = 0x0002;
		public const int wxRA_SPECIFY_COLS   = Orientation.wxHORIZONTAL;
		public const int wxRA_SPECIFY_ROWS   = Orientation.wxVERTICAL;
		public const int wxRA_HORIZONTAL     = Orientation.wxHORIZONTAL;
		public const int wxRA_VERTICAL       = Orientation.wxVERTICAL;

		//---------------------------------------------------------------------
        
		[DllImport("wx-c")] static extern IntPtr wxRadioBox_ctor();
		[DllImport("wx-c")] static extern bool   wxRadioBox_Create(IntPtr self, IntPtr parent, int id,
		                                                           string label, ref Point pos, ref Size size,
		                                                           int n, string[] choices, int majorDimension,
		                                                           uint style, IntPtr val, string name);

		[DllImport("wx-c")] static extern void   wxRadioBox_SetSelection(IntPtr self, int n);
		[DllImport("wx-c")] static extern int    wxRadioBox_GetSelection(IntPtr self);

		[DllImport("wx-c")] static extern IntPtr wxRadioBox_GetStringSelection(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxRadioBox_SetStringSelection(IntPtr self, string s);

		[DllImport("wx-c")] static extern int    wxRadioBox_GetCount(IntPtr self);
		[DllImport("wx-c")] static extern int    wxRadioBox_FindString(IntPtr self, string s);

		[DllImport("wx-c")] static extern IntPtr wxRadioBox_GetString(IntPtr self, int n);
		[DllImport("wx-c")] static extern void   wxRadioBox_SetString(IntPtr self, int n, string label);

		[DllImport("wx-c")] static extern void   wxRadioBox_Enable(IntPtr self, int n, bool enable);
		[DllImport("wx-c")] static extern void   wxRadioBox_Show(IntPtr self, int n, bool show);
		
		[DllImport("wx-c")] static extern IntPtr wxRadioBox_GetLabel(IntPtr self);
		[DllImport("wx-c")] static extern void   wxRadioBox_SetLabel(IntPtr self, string label);

		//---------------------------------------------------------------------
		
		public RadioBox(IntPtr wxObject)
			: base(wxObject) {}
			
		public RadioBox(Window parent, int id, string label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, null, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, int id, string label, Point pos)
			: this(parent, id, label, pos, wxDefaultSize, null, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, int id, string label, Point pos, Size size)
			: this(parent, id, label, pos, size, null, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, int id, string label, Point pos, Size size, string[] choices)
			: this(parent, id, label, pos, size, choices, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, int id, string label, Point pos, Size size, string[] choices, int majorDimension)
			: this(parent, id, label, pos, size, choices, majorDimension, wxRA_SPECIFY_COLS, null, "radioBox") {} 

		public RadioBox(Window parent, int id, string label, Point pos, Size size, string[] choices, int majorDimension, int style)
			: this(parent, id, label, pos, size, choices, majorDimension, style, null, null) { }
			
		public RadioBox(Window parent, int id, string label, Point pos, Size size, string[] choices, int majorDimension, int style, Validator validator)
			: this(parent, id, label, pos, size, choices, majorDimension, style, validator, null) { }

		public RadioBox(Window parent, int id, string label, Point pos, Size size, string[] choices, int majorDimension, int style, Validator val, string name)
			: base(wxRadioBox_ctor())
		{
			if (!wxRadioBox_Create(wxObject, Object.SafePtr(parent), id, label, ref pos, ref size,
			                       choices.Length, choices, majorDimension, (uint)style, Object.SafePtr(val), name))
			{
				throw new InvalidOperationException("failed to create checkbox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public RadioBox(Window parent, string label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, null, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, string label, Point pos)
			: this(parent, Window.UniqueID, label, pos, wxDefaultSize, null, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, string label, Point pos, Size size)
			: this(parent, Window.UniqueID, label, pos, size, null, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, string label, Point pos, Size size, string[] choices)
			: this(parent, Window.UniqueID, label, pos, size, choices, 0, wxRA_SPECIFY_COLS, null, "radioBox") {} 
			
		public RadioBox(Window parent, string label, Point pos, Size size, string[] choices, int majorDimension)
			: this(parent, Window.UniqueID, label, pos, size, choices, majorDimension, wxRA_SPECIFY_COLS, null, "radioBox") {} 

		public RadioBox(Window parent, string label, Point pos, Size size, string[] choices, int majorDimension, int style)
			: this(parent, Window.UniqueID, label, pos, size, choices, majorDimension, style, null, null) { }
			
		public RadioBox(Window parent, string label, Point pos, Size size, string[] choices, int majorDimension, int style, Validator validator)
			: this(parent, Window.UniqueID, label, pos, size, choices, majorDimension, style, validator, null) { }

		public RadioBox(Window parent, string label, Point pos, Size size, string[] choices, int majorDimension, int style, Validator val, string name)
			: this(parent, Window.UniqueID, label, pos, size, choices, majorDimension, style, val, name) {}

		//---------------------------------------------------------------------

		public int Selection
		{
			set { wxRadioBox_SetSelection(wxObject, value); }
			get { return wxRadioBox_GetSelection(wxObject); }
		}

		public string StringSelection
		{
			set { wxRadioBox_SetStringSelection(wxObject, value); }
			get { return new wxString(wxRadioBox_GetStringSelection(wxObject), true); }
		}

		//---------------------------------------------------------------------

		public int Count
		{
			get { return wxRadioBox_GetCount(wxObject); }
		}

		//---------------------------------------------------------------------

		public int FindString(string s)
		{
			return wxRadioBox_FindString(wxObject, s);
		}

		//---------------------------------------------------------------------

		public string GetString(int n)
		{
			return new wxString(wxRadioBox_GetString(wxObject, n), true);
		}

		public void SetString(int n, string label)
		{
			wxRadioBox_SetString(wxObject, n, label);
		}

		//---------------------------------------------------------------------

		public void Enable(int n, bool enable)
		{
			wxRadioBox_Enable(wxObject, n, enable);
		}

		public void Show(int n, bool show)
		{
			wxRadioBox_Show(wxObject, n , show);
		}

		//---------------------------------------------------------------------
		
		public new string Label
		{
			get { return new wxString(wxRadioBox_GetLabel(wxObject), true); }
			set { wxRadioBox_SetLabel(wxObject, value); }
		}
		
		//---------------------------------------------------------------------

		public event EventListener Select
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_RADIOBOX_SELECTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}
