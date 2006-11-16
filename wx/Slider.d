//-----------------------------------------------------------------------------
// wxD - Slider.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - Slider.cs
//
// The wxSlider wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

module wx.Slider;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxSlider_ctor();
		static extern (C) bool   wxSlider_Create(IntPtr self, IntPtr parent, int id, int value, int minValue, int maxValue, inout Point pos, inout Size size, uint style, IntPtr validator, string name);
		static extern (C) int    wxSlider_GetValue(IntPtr self);
		static extern (C) void   wxSlider_SetValue(IntPtr self, int value);
		static extern (C) void   wxSlider_SetRange(IntPtr self, int minValue, int maxValue);
		static extern (C) int    wxSlider_GetMin(IntPtr self);
		static extern (C) int    wxSlider_GetMax(IntPtr self);
		static extern (C) void   wxSlider_SetLineSize(IntPtr self, int lineSize);
		static extern (C) void   wxSlider_SetPageSize(IntPtr self, int pageSize);
		static extern (C) int    wxSlider_GetLineSize(IntPtr self);
		static extern (C) int    wxSlider_GetPageSize(IntPtr self);
		static extern (C) void   wxSlider_SetThumbLength(IntPtr self, int lenPixels);
		static extern (C) int    wxSlider_GetThumbLength(IntPtr self);
		static extern (C) void   wxSlider_SetTickFreq(IntPtr self, int n, int pos);
		static extern (C) int    wxSlider_GetTickFreq(IntPtr self);
		static extern (C) void   wxSlider_ClearTicks(IntPtr self);
		static extern (C) void   wxSlider_SetTick(IntPtr self, int tickPos);
		static extern (C) void   wxSlider_ClearSel(IntPtr self);
		static extern (C) int    wxSlider_GetSelEnd(IntPtr self);
		static extern (C) int    wxSlider_GetSelStart(IntPtr self);
		static extern (C) void   wxSlider_SetSelection(IntPtr self, int min, int max);
	
		//---------------------------------------------------------------------
		
    public class Slider : Control
    {
		public const int wxSL_HORIZONTAL      = Orientation.wxHORIZONTAL;
		public const int wxSL_VERTICAL        = Orientation.wxVERTICAL;

		public const int wxSL_NOTIFY_DRAG     = 0x0000;
		public const int wxSL_TICKS           = 0x0010;
		public const int wxSL_AUTOTICKS       = wxSL_TICKS;
		public const int wxSL_LABELS          = 0x0020;
		public const int wxSL_LEFT            = 0x0040;
		public const int wxSL_TOP             = 0x0080;
		public const int wxSL_RIGHT           = 0x0100;
		public const int wxSL_BOTTOM          = 0x0200;
		public const int wxSL_BOTH            = 0x0400;
		public const int wxSL_SELRANGE        = 0x0800;

		//---------------------------------------------------------------------

		public this(IntPtr wxobj) 
			{ super(wxobj);}

		public this()
			{ super(wxSlider_ctor()); }
			
		public this(Window parent, int id, int value, int minValue, int maxValue)
			{ this(parent, id, value, minValue, maxValue, wxDefaultPosition, wxDefaultSize, 0, null, "slider" ); }
			
		public this(Window parent, int id, int value, int minValue, int maxValue, Point pos)
			{ this(parent, id, value, minValue, maxValue, pos, wxDefaultSize, 0, null, "slider" ); }

		public this(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size)
			{ this(parent, id, value, minValue, maxValue, pos, size, 0, null, "slider" ); }
			
		public this(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, int style)
			{ this(parent, id, value, minValue, maxValue, pos, size, style, null, "slider" ); }

		public this(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, int style, Validator validator)
			{ this(parent, id, value, minValue, maxValue, pos, size, style, validator, "slider" ); }

		public this(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, int style, Validator validator, string name)
		{
			super(wxSlider_ctor());
			if(!Create(parent, id, value, minValue, maxValue, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create Slider");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, int value, int minValue, int maxValue)
			{ this(parent, Window.UniqueID, value, minValue, maxValue, wxDefaultPosition, wxDefaultSize, 0, null, "slider" ); }
			
		public this(Window parent, int value, int minValue, int maxValue, Point pos)
			{ this(parent, Window.UniqueID, value, minValue, maxValue, pos, wxDefaultSize, 0, null, "slider" ); }

		public this(Window parent, int value, int minValue, int maxValue, Point pos, Size size)
			{ this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, 0, null, "slider" ); }
			
		public this(Window parent, int value, int minValue, int maxValue, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, style, null, "slider" ); }

		public this(Window parent, int value, int minValue, int maxValue, Point pos, Size size, int style, Validator validator)
			{ this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, style, validator, "slider" ); }

		public this(Window parent, int value, int minValue, int maxValue, Point pos, Size size, int style, Validator validator, string name)
			{ this(parent, Window.UniqueID, value, minValue, maxValue, pos, size, style, validator, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, int value, int minValue, int maxValue, Point pos, Size size, int style, Validator validator, string name)
		{
			return wxSlider_Create(wxobj, wxObject.SafePtr(parent), id, value, minValue, maxValue, pos, size, cast(uint)style, wxObject.SafePtr(validator), name);
		}


		//---------------------------------------------------------------------

		public int Value() { return wxSlider_GetValue(wxobj); }
		public void Value(int value) { wxSlider_SetValue(wxobj, value); }

		//---------------------------------------------------------------------

		public void SetRange(int minValue, int maxValue)
		{
			wxSlider_SetRange(wxobj, minValue, maxValue);
		}

		public int Max() { return wxSlider_GetMax(wxobj); }

		public int Min() { return wxSlider_GetMin(wxobj); }

		//---------------------------------------------------------------------

		public int LineSize() { return wxSlider_GetLineSize(wxobj); }
		public void LineSize(int value) { wxSlider_SetLineSize(wxobj, value); }
		
		//---------------------------------------------------------------------

		public int PageSize() { return wxSlider_GetPageSize(wxobj); }
		public void PageSize(int value) { wxSlider_SetPageSize(wxobj, value); }

		//---------------------------------------------------------------------

		public int ThumbLength() { return wxSlider_GetThumbLength(wxobj); }
		public void ThumbLength(int value) { wxSlider_SetThumbLength(wxobj, value); }

		//---------------------------------------------------------------------

		public int TickFreq() { return wxSlider_GetTickFreq(wxobj); }

		public void SetTickFreq(int n, int pos)
		{
			wxSlider_SetTickFreq(wxobj, n, pos);
		}

		//---------------------------------------------------------------------

		public void SetTick(int tickPos)
		{
			wxSlider_SetTick(wxobj, tickPos);
		}

		public void ClearTicks()
		{
			wxSlider_ClearTicks(wxobj);
		}

		public void ClearSel()
		{
			wxSlider_ClearSel(wxobj);
		}

		//---------------------------------------------------------------------

		public int SelEnd() { return wxSlider_GetSelEnd(wxobj); }

		public int SelStart() { return wxSlider_GetSelStart(wxobj); }

		public void SetSelection(int min, int max)
		{
			wxSlider_SetSelection(wxobj, min, max);
		}

		//---------------------------------------------------------------------

		public void UpdateUI_Add(EventListener value) { AddCommandListener(Event.wxEVT_COMMAND_SLIDER_UPDATED, ID, value, this); }
		public void UpdateUI_Remove(EventListener value) { RemoveHandler(value, this); }
    }
