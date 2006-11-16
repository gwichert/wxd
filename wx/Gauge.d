//-----------------------------------------------------------------------------
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

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class Gauge :  Control
	{
		public const long wxGA_HORIZONTAL       = Orientation.wxHORIZONTAL;
		public const long wxGA_VERTICAL         = Orientation.wxVERTICAL;
		public const long wxGA_PROGRESSBAR      = 0x0010;
	
		// Windows only
		public const long wxGA_SMOOTH           = 0x0020;
	
		//---------------------------------------------------------------------
		
		[DllImport("wx-c")] static extern IntPtr wxGauge_ctor();
		[DllImport("wx-c")] static extern void   wxGauge_dtor(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxGauge_Create(IntPtr self, IntPtr parent, int id, int range, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern void   wxGauge_SetRange(IntPtr self, int range);
		[DllImport("wx-c")] static extern int    wxGauge_GetRange(IntPtr self);
		[DllImport("wx-c")] static extern void   wxGauge_SetValue(IntPtr self, int pos);
		[DllImport("wx-c")] static extern int    wxGauge_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern void   wxGauge_SetShadowWidth(IntPtr self, int w);
		[DllImport("wx-c")] static extern int    wxGauge_GetShadowWidth(IntPtr self);
		[DllImport("wx-c")] static extern void   wxGauge_SetBezelFace(IntPtr self, int w);
		[DllImport("wx-c")] static extern int    wxGauge_GetBezelFace(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxGauge_AcceptsFocus(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxGauge_IsVertical(IntPtr self);
	
		//---------------------------------------------------------------------
		
		public Gauge(IntPtr wxObject) 
			: base(wxObject) {}

		public Gauge()
			: base(wxGauge_ctor()) { }

		public Gauge(Window parent, int id, int range, Point pos, Size size)
			: this(parent, id, range, pos, size, 0, null, null) { }

		public Gauge(Window parent, int id, int range, Point pos, Size size, long style)
			: this(parent, id, range, pos, size, style, null, null) { }

		public Gauge(Window parent, int id, int range, Point pos, Size size, long style, Validator val)
			: this(parent, id, range, pos, size, style, val, null) { }

		public Gauge(Window parent, int id, int range, Point pos, Size size, 
				long style, Validator validator, string name)
			: base(wxGauge_ctor())
		{	
			if (!Create(parent, id, range, pos, size, style, validator, name)) 
			{
				throw new InvalidOperationException("Failed to create Gauge");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Gauge(Window parent, int range, Point pos, Size size)
			: this(parent, Window.UniqueID, range, pos, size, 0, null, null) { }

		public Gauge(Window parent, int range, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, range, pos, size, style, null, null) { }

		public Gauge(Window parent, int range, Point pos, Size size, long style, Validator val)
			: this(parent, Window.UniqueID, range, pos, size, style, val, null) { }

		public Gauge(Window parent, int range, Point pos, Size size, 
				long style, Validator validator, string name)
			: this(parent, Window.UniqueID, range, pos, size, style, validator, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, int range, Point pos, 
				Size size, long style, Validator validator, 
				string name)
		{
			return wxGauge_Create(wxObject, Object.SafePtr(parent), id, range, 
					ref pos, ref size, (uint)style, 
					Object.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------

		public int Range
		{
			get { return wxGauge_GetRange(wxObject); }
			set { wxGauge_SetRange(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public int Value
		{
			get { return wxGauge_GetValue(wxObject); }
			set { wxGauge_SetValue(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public int ShadowWidth
		{
			get { return wxGauge_GetShadowWidth(wxObject); }
			set { wxGauge_SetShadowWidth(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public int BezelFace
		{
			get { return wxGauge_GetBezelFace(wxObject); }
			set { wxGauge_SetBezelFace(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public override bool AcceptsFocus()
		{
			return wxGauge_AcceptsFocus(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public bool IsVertical
		{
			get { return wxGauge_IsVertical(wxObject); }
		}
	}
}
