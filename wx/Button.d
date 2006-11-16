//-----------------------------------------------------------------------------
// wx.NET - Button.cs
//
// The wxButton wrapper class.
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
	public class Button : Control
	{
		[DllImport("wx-c")] static extern IntPtr wxButton_ctor();
		[DllImport("wx-c")] static extern bool   wxButton_Create(IntPtr self, IntPtr parent, int id, string label, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern void   wxButton_SetDefault(IntPtr self);
		[DllImport("wx-c")] static extern void   wxButton_GetDefaultSize(out Size size);
		
		[DllImport("wx-c")] static extern void wxButton_SetImageMargins(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void wxButton_SetImageLabel(IntPtr self, IntPtr bitmap);
		
		[DllImport("wx-c")] static extern void wxButton_SetLabel(IntPtr self, string label);

		//---------------------------------------------------------------------

		public const long wxBU_LEFT          =  0x0040;
		public const long wxBU_TOP           =  0x0080;
		public const long wxBU_RIGHT         =  0x0100;
		public const long wxBU_BOTTOM        =  0x0200;
		public const long wxBU_EXACTFIT      =  0x0001;
		
		//---------------------------------------------------------------------
		
		public Button(IntPtr wxObject) 
			: base(wxObject) { }

		public Button()
			: this(wxButton_ctor()) { }

		public Button(Window parent, int id, string label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public Button(Window parent, int id, string label, Point pos)
			: this(parent, id, label, pos, wxDefaultSize, 0, null, null) { }
		
		public Button(Window parent, int id, string label, Point pos, Size size)
			: this(parent, id, label, pos, size, 0, null, null) { }
		
		public Button(Window parent, int id, string label, Point pos, Size size, long style)
			: this(parent, id, label, pos, size, style, null, null) { }
		
		public Button(Window parent, int id, string label, Point pos, Size size, long style, Validator validator)
			: this(parent, id, label, pos, size, style, validator, null) { }

		public Button(Window parent, int id, string label, Point pos, Size size, long style, Validator validator, string name)
			: this(wxButton_ctor())
		{
			if (!Create(parent, id, label, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create Button");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Button(Window parent, string label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null, null) { }

		public Button(Window parent, string label, Point pos)
			: this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null, null) { }
		
		public Button(Window parent, string label, Point pos, Size size)
			: this(parent, Window.UniqueID, label, pos, size, 0, null, null) { }
		
		public Button(Window parent, string label, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, label, pos, size, style, null, null) { }
		
		public Button(Window parent, string label, Point pos, Size size, long style, Validator validator)
			: this(parent, Window.UniqueID, label, pos, size, style, validator, null) { }

		public Button(Window parent, string label, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, label, pos, size, style, validator, null) {}
			
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size, long style, Validator validator, string name)
		{
			return wxButton_Create(wxObject, Object.SafePtr(parent), id, label, ref pos, ref size, (uint)style, Object.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------

		public void SetDefault()
		{
			wxButton_SetDefault(wxObject);
		}

		//---------------------------------------------------------------------

		public static Size GetDefaultSize()
		{
			Size size = new Size();
			wxButton_GetDefaultSize(out size);
			return size;
		}
		
		//---------------------------------------------------------------------
		
		public virtual Bitmap ImageLabel
		{
			set { wxButton_SetImageLabel(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public virtual void SetImageMargins(int x, int y)
		{
			wxButton_SetImageMargins(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		// Do we need get also ?
		
		public new string Label
		{
			set { wxButton_SetLabel(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public event EventListener Click
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_BUTTON_CLICKED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}

