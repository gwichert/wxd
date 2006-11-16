//-----------------------------------------------------------------------------
// wxD - Gauge.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - Gauge.cs
//
// The wxGauge wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Gauge;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxGauge_ctor();
		static extern (C) void   wxGauge_dtor(IntPtr self);
		static extern (C) bool   wxGauge_Create(IntPtr self, IntPtr parent, int id, int range, inout Point pos, inout Size size, uint style, IntPtr validator, string name);
		static extern (C) void   wxGauge_SetRange(IntPtr self, int range);
		static extern (C) int    wxGauge_GetRange(IntPtr self);
		static extern (C) void   wxGauge_SetValue(IntPtr self, int pos);
		static extern (C) int    wxGauge_GetValue(IntPtr self);
		static extern (C) void   wxGauge_SetShadowWidth(IntPtr self, int w);
		static extern (C) int    wxGauge_GetShadowWidth(IntPtr self);
		static extern (C) void   wxGauge_SetBezelFace(IntPtr self, int w);
		static extern (C) int    wxGauge_GetBezelFace(IntPtr self);
		static extern (C) bool   wxGauge_AcceptsFocus(IntPtr self);
		static extern (C) bool   wxGauge_IsVertical(IntPtr self);
	
		//---------------------------------------------------------------------
		
	public class Gauge :  Control
	{
		public const int wxGA_HORIZONTAL       = Orientation.wxHORIZONTAL;
		public const int wxGA_VERTICAL         = Orientation.wxVERTICAL;
		public const int wxGA_PROGRESSBAR      = 0x0010;
	
		// Windows only
		public const int wxGA_SMOOTH           = 0x0020;
	
		//---------------------------------------------------------------------
		
		public this(IntPtr wxobj) 
			{ super(wxobj);}

		public this()
			{ super(wxGauge_ctor()); }

		public this(Window parent, int id, int range, Point pos, Size size)
			{ this(parent, id, range, pos, size, 0, null, null); }

		public this(Window parent, int id, int range, Point pos, Size size, int style)
			{ this(parent, id, range, pos, size, style, null, null); }

		public this(Window parent, int id, int range, Point pos, Size size, int style, Validator val)
			{ this(parent, id, range, pos, size, style, val, null); }

		public this(Window parent, int id, int range, Point pos, Size size, 
				int style, Validator validator, string name)
		{	
			super(wxGauge_ctor());
			if (!Create(parent, id, range, pos, size, style, validator, name)) 
			{
				throw new InvalidOperationException("Failed to create Gauge");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, int range, Point pos, Size size)
			{ this(parent, Window.UniqueID, range, pos, size, 0, null, null); }

		public this(Window parent, int range, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, range, pos, size, style, null, null); }

		public this(Window parent, int range, Point pos, Size size, int style, Validator val)
			{ this(parent, Window.UniqueID, range, pos, size, style, val, null); }

		public this(Window parent, int range, Point pos, Size size, 
				int style, Validator validator, string name)
			{ this(parent, Window.UniqueID, range, pos, size, style, validator, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, int range, Point pos, 
				Size size, int style, Validator validator, 
				string name)
		{
			return wxGauge_Create(wxobj, wxObject.SafePtr(parent), id, range, 
					pos, size, cast(uint)style, 
					wxObject.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------

		public int Range() { return wxGauge_GetRange(wxobj); }
		public void Range(int value) { wxGauge_SetRange(wxobj, value); }

		//---------------------------------------------------------------------
        
		public int Value() { return wxGauge_GetValue(wxobj); }
		public void Value(int value) { wxGauge_SetValue(wxobj, value); }

		//---------------------------------------------------------------------

		public int ShadowWidth() { return wxGauge_GetShadowWidth(wxobj); }
		public void ShadowWidth(int value) { wxGauge_SetShadowWidth(wxobj, value); }

		//---------------------------------------------------------------------

		public int BezelFace() { return wxGauge_GetBezelFace(wxobj); }
		public void BezelFace(int value) { wxGauge_SetBezelFace(wxobj, value); }

		//---------------------------------------------------------------------

		public override bool AcceptsFocus()
		{
			return wxGauge_AcceptsFocus(wxobj);
		}
		
		//---------------------------------------------------------------------
		
		public bool IsVertical() { return wxGauge_IsVertical(wxobj); }
	}
