//-----------------------------------------------------------------------------
// wxD - scrolbar.h
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - scrolbar.h
//
// The wxScrollBar wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.ScrollBar;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxScrollBar_ctor();
		static extern (C) bool   wxScrollBar_Create(IntPtr self, IntPtr parent, int id, inout Point pos, inout Size size, uint style, IntPtr validator, string name);
		static extern (C) int    wxScrollBar_GetThumbPosition(IntPtr self);
		static extern (C) int    wxScrollBar_GetThumbSize(IntPtr self);
		static extern (C) int    wxScrollBar_GetPageSize(IntPtr self);
		static extern (C) int    wxScrollBar_GetRange(IntPtr self);
		static extern (C) bool   wxScrollBar_IsVertical(IntPtr self);
		static extern (C) void   wxScrollBar_SetThumbPosition(IntPtr self, int viewStart);
		static extern (C) void   wxScrollBar_SetScrollbar(IntPtr self, int position, int thumbSize, int range, int pageSize, bool refresh);

		//-----------------------------------------------------------------------------

	public class ScrollBar : Control
	{
		public const int wxSB_HORIZONTAL   = Orientation.wxHORIZONTAL;
		public const int wxSB_VERTICAL     = Orientation.wxVERTICAL;

		//-----------------------------------------------------------------------------

		public this(IntPtr wxobj)
			{ super(wxobj); }

		public this()
			{ super(wxScrollBar_ctor()); }
	    
		public this(Window parent, int id)
			{ this (parent, id, wxDefaultPosition, wxDefaultSize, wxSB_HORIZONTAL, null, "" ); }
			
		public this(Window parent, int id, Point pos)
			{ this (parent, id, pos, wxDefaultSize, wxSB_HORIZONTAL, null, "" ); }
			
		public this(Window parent, int id, Point pos, Size size)
			{ this (parent, id, pos, size, wxSB_HORIZONTAL, null, "" ); }
			
		public this(Window parent, int id, Point pos, Size size, int style)
			{ this (parent, id, pos, size, style, null, "" ); }
			
		public this(Window parent, int id, Point pos, Size size, int style, Validator validator)
			{ this (parent, id, pos, size, style, validator, "" ); }
			
		public this(Window parent, int id, Point pos, Size size, int style, Validator validator, string name)
		{
			super (wxScrollBar_ctor() );
			if (!Create(parent, id, pos, size, style, validator, name)) 
			{
				throw new InvalidOperationException("Failed to create ScrollBar");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent)
			{ this (parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxSB_HORIZONTAL, null, "" ); }
			
		public this(Window parent, Point pos)
			{ this (parent, Window.UniqueID, pos, wxDefaultSize, wxSB_HORIZONTAL, null, "" ); }
			
		public this(Window parent, Point pos, Size size)
			{ this (parent, Window.UniqueID, pos, size, wxSB_HORIZONTAL, null, "" ); }
			
		public this(Window parent, Point pos, Size size, int style)
			{ this (parent, Window.UniqueID, pos, size, style, null, "" ); }
			
		public this(Window parent, Point pos, Size size, int style, Validator validator)
			{ this (parent, Window.UniqueID, pos, size, style, validator, "" ); }
			
		public this(Window parent, Point pos, Size size, int style, Validator validator, string name)
			{ this(parent, Window.UniqueID, pos, size, style, validator, name); }
		
		//-----------------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size, int style, Validator validator, string name)
		{
			return wxScrollBar_Create(wxobj, wxObject.SafePtr(parent), id, pos, size, cast(uint)style, wxObject.SafePtr(validator), name);
		}

		//-----------------------------------------------------------------------------

		public int ThumbPosition() { return wxScrollBar_GetThumbPosition(wxobj); }
		public void ThumbPosition(int value) { wxScrollBar_SetThumbPosition(wxobj, value); }

		//-----------------------------------------------------------------------------

		public int ThumbSize() { return wxScrollBar_GetThumbSize(wxobj); }

		//-----------------------------------------------------------------------------

		public int PageSize() { return wxScrollBar_GetPageSize(wxobj); }

		//-----------------------------------------------------------------------------

		public int Range() { return wxScrollBar_GetRange(wxobj); }

		//-----------------------------------------------------------------------------

		public bool IsVertical() { return wxScrollBar_IsVertical(wxobj); }

		//-----------------------------------------------------------------------------

		public override void SetScrollbar(int position, int thumbSize, int range, int pageSize, bool refresh)
		{
			wxScrollBar_SetScrollbar(wxobj, position, thumbSize, range, pageSize, refresh);
		}
	}
