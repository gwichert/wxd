//-----------------------------------------------------------------------------
// wxD - Button.d
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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

module wx.Button;
import wx.common;
import wx.Control;
import wx.Bitmap;

		static extern (C) IntPtr wxButton_ctor();
		static extern (C) bool   wxButton_Create(IntPtr self, IntPtr parent, int id, string label, inout Point pos, inout Size size, uint style, IntPtr validator, string name);
		static extern (C) void   wxButton_SetDefault(IntPtr self);
		static extern (C) void   wxButton_GetDefaultSize(out Size size);
		
		static extern (C) void wxButton_SetImageMargins(IntPtr self, int x, int y);
		static extern (C) void wxButton_SetImageLabel(IntPtr self, IntPtr bitmap);
		
		static extern (C) void wxButton_SetLabel(IntPtr self, string label);

		//---------------------------------------------------------------------

	public class Button : Control
	{
		public const int wxBU_LEFT          =  0x0040;
		public const int wxBU_TOP           =  0x0080;
		public const int wxBU_RIGHT         =  0x0100;
		public const int wxBU_BOTTOM        =  0x0200;
		public const int wxBU_EXACTFIT      =  0x0001;
		
		//---------------------------------------------------------------------
		
		public this(IntPtr wxobj) 
			{ super(wxobj); }

		public this()
			{ this(wxButton_ctor()); }

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
			this(wxButton_ctor());
			if (!Create(parent, id, label, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create Button");
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
		
		public this(Window parent, string label, Point pos, Size size, int style, Validator validator)
			{ this(parent, Window.UniqueID, label, pos, size, style, validator, null); }

		public this(Window parent, string label, Point pos, Size size, int style, Validator validator, string name)
			{ this(parent, Window.UniqueID, label, pos, size, style, validator, null);}
			
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size, int style, Validator validator, string name)
		{
			return wxButton_Create(wxobj, wxObject.SafePtr(parent), id, label, pos, size, cast(uint)style, wxObject.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------

		public void SetDefault()
		{
			wxButton_SetDefault(wxobj);
		}

		//---------------------------------------------------------------------

		public static Size GetDefaultSize()
		{
			Size size;
			wxButton_GetDefaultSize(size);
			return size;
		}
		
		//---------------------------------------------------------------------
		
		public /+virtual+/ void ImageLabel(Bitmap value)
		{
			wxButton_SetImageLabel(wxobj, wxObject.SafePtr(value));
		}
		
		//---------------------------------------------------------------------
		
		public /+virtual+/ void SetImageMargins(int x, int y)
		{
			wxButton_SetImageMargins(wxobj, x, y);
		}
		
		//---------------------------------------------------------------------
		// Do we need get also ?
		
		public void Label(string value)
		{
			wxButton_SetLabel(wxobj, value);
		}
		
		//---------------------------------------------------------------------
		
		public void Click_Add(EventListener value) { AddCommandListener(Event.wxEVT_COMMAND_BUTTON_CLICKED, ID, value, this); }
		public void Click_Remove(EventListener value) { RemoveHandler(value, this); }
	}

