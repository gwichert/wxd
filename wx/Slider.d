//-----------------------------------------------------------------------------
// wx.NET - Slider.cs
//
// The wxSlider wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class Slider : Control
    {
		public const long wxSL_HORIZONTAL      = Orientation.wxHORIZONTAL;
		public const long wxSL_VERTICAL        = Orientation.wxVERTICAL;

		public const long wxSL_NOTIFY_DRAG     = 0x0000;
		public const long wxSL_TICKS           = 0x0010;
		public const long wxSL_AUTOTICKS       = wxSL_TICKS;
		public const long wxSL_LABELS          = 0x0020;
		public const long wxSL_LEFT            = 0x0040;
		public const long wxSL_TOP             = 0x0080;
		public const long wxSL_RIGHT           = 0x0100;
		public const long wxSL_BOTTOM          = 0x0200;
		public const long wxSL_BOTH            = 0x0400;
		public const long wxSL_SELRANGE        = 0x0800;

		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxSlider_ctor();
		[DllImport("wx-c")] static extern bool   wxSlider_Create(IntPtr self, IntPtr parent, int id, int value, int minValue, int maxValue, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern int    wxSlider_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSlider_SetValue(IntPtr self, int value);
		[DllImport("wx-c")] static extern void   wxSlider_SetRange(IntPtr self, int minValue, int maxValue);
		[DllImport("wx-c")] static extern int    wxSlider_GetMin(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSlider_GetMax(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSlider_SetLineSize(IntPtr self, int lineSize);
		[DllImport("wx-c")] static extern void   wxSlider_SetPageSize(IntPtr self, int pageSize);
		[DllImport("wx-c")] static extern int    wxSlider_GetLineSize(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSlider_GetPageSize(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSlider_SetThumbLength(IntPtr self, int lenPixels);
		[DllImport("wx-c")] static extern int    wxSlider_GetThumbLength(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSlider_SetTickFreq(IntPtr self, int n, int pos);
		[DllImport("wx-c")] static extern int    wxSlider_GetTickFreq(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSlider_ClearTicks(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSlider_SetTick(IntPtr self, int tickPos);
		[DllImport("wx-c")] static extern void   wxSlider_ClearSel(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSlider_GetSelEnd(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSlider_GetSelStart(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSlider_SetSelection(IntPtr self, int min, int max);
	
		//---------------------------------------------------------------------
		
		public Slider(IntPtr wxObject) 
			: base(wxObject) {}

		public Slider()
			: base(wxSlider_ctor()) { }
			
		public Slider(Window parent, int id, int value, int minValue, int maxValue)
			: this(parent, id, value, minValue, maxValue, wxDefaultPosition, wxDefaultSize, 0, null, "slider" ) { }
			
		public Slider(Window parent, int id, int value, int minValue, int maxValue, Point pos)
			: this(parent, id, value, minValue, maxValue, pos, wxDefaultSize, 0, null, "slider" ) { }

		public Slider(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size)
			: this(parent, id, value, minValue, maxValue, pos, size, 0, null, "slider" ) { }
			
		public Slider(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, long style)
			: this(parent, id, value, minValue, maxValue, pos, size, style, null, "slider" ) { }

		public Slider(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, long style, Validator validator)
			: this(parent, id, value, minValue, maxValue, pos, size, style, validator, "slider" ) { }

		public Slider(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, long style, Validator validator, string name)
			: base(wxSlider_ctor())
		{
			if(!Create(parent, id, value, minValue, maxValue, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create Slider");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Slider(Window parent, int value, int minValue, int maxValue)
			: this(parent, Window.UniqueID, value, minValue, maxValue, wxDefaultPosition, wxDefaultSize, 0, null, "slider" ) { }
			
		public Slider(Window parent, int value, int minValue, int maxValue, Point pos)
			: this(parent, Window.UniqueID, value, minValue, maxValue, pos, wxDefaultSize, 0, null, "slider" ) { }

		public Slider(Window parent, int value, int minValue, int maxValue, Point pos, Size size)
			: this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, 0, null, "slider" ) { }
			
		public Slider(Window parent, int value, int minValue, int maxValue, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, style, null, "slider" ) { }

		public Slider(Window parent, int value, int minValue, int maxValue, Point pos, Size size, long style, Validator validator)
			: this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, style, validator, "slider" ) { }

		public Slider(Window parent, int value, int minValue, int maxValue, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, style, validator, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, long style, Validator validator, string name)
		{
			return wxSlider_Create(wxObject, Object.SafePtr(parent), id, value, minValue, maxValue, ref pos, ref size, (uint)style, Object.SafePtr(validator), name);
		}


		//---------------------------------------------------------------------

		public int Value
		{
			get { return wxSlider_GetValue(wxObject); }
			set { wxSlider_SetValue(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public void SetRange(int minValue, int maxValue)
		{
			wxSlider_SetRange(wxObject, minValue, maxValue);
		}

		public int Max
		{
			get { return wxSlider_GetMax(wxObject); }
		}

		public int Min
		{
			get { return wxSlider_GetMin(wxObject); }
		}

		//---------------------------------------------------------------------

		public int LineSize
		{
			get { return wxSlider_GetLineSize(wxObject); }
			set { wxSlider_SetLineSize(wxObject, value); }
		}
		
		//---------------------------------------------------------------------

		public int PageSize
		{
			get { return wxSlider_GetPageSize(wxObject); }
			set { wxSlider_SetPageSize(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public int ThumbLength
		{
			get { return wxSlider_GetThumbLength(wxObject); }
			set { wxSlider_SetThumbLength(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public int TickFreq
		{
			get { return wxSlider_GetTickFreq(wxObject); }
		}

		public void SetTickFreq(int n, int pos)
		{
			wxSlider_SetTickFreq(wxObject, n, pos);
		}

		//---------------------------------------------------------------------

		public void SetTick(int tickPos)
		{
			wxSlider_SetTick(wxObject, tickPos);
		}

		public void ClearTicks()
		{
			wxSlider_ClearTicks(wxObject);
		}

		public void ClearSel()
		{
			wxSlider_ClearSel(wxObject);
		}

		//---------------------------------------------------------------------

		public int SelEnd
		{
			get { return wxSlider_GetSelEnd(wxObject); }
		}

		public int SelStart
		{
			get { return wxSlider_GetSelStart(wxObject); }
		}

		public void SetSelection(int min, int max)
		{
			wxSlider_SetSelection(wxObject, min, max);
		}

		//---------------------------------------------------------------------

		public override event EventListener UpdateUI
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_SLIDER_UPDATED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
    }
}
