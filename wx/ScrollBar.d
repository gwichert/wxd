//-----------------------------------------------------------------------------
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

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class ScrollBar : Control
	{
		public const long wxSB_HORIZONTAL   = Orientation.wxHORIZONTAL;
		public const long wxSB_VERTICAL     = Orientation.wxVERTICAL;

		//-----------------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxScrollBar_ctor();
		[DllImport("wx-c")] static extern bool   wxScrollBar_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern int    wxScrollBar_GetThumbPosition(IntPtr self);
		[DllImport("wx-c")] static extern int    wxScrollBar_GetThumbSize(IntPtr self);
		[DllImport("wx-c")] static extern int    wxScrollBar_GetPageSize(IntPtr self);
		[DllImport("wx-c")] static extern int    wxScrollBar_GetRange(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxScrollBar_IsVertical(IntPtr self);
		[DllImport("wx-c")] static extern void   wxScrollBar_SetThumbPosition(IntPtr self, int viewStart);
		[DllImport("wx-c")] static extern void   wxScrollBar_SetScrollbar(IntPtr self, int position, int thumbSize, int range, int pageSize, bool refresh);

		//-----------------------------------------------------------------------------

		public ScrollBar(IntPtr wxObject)
			: base(wxObject) { }

		public ScrollBar()
			: base(wxScrollBar_ctor()) { }
	    
		public ScrollBar(Window parent, int id)
			: this (parent, id, wxDefaultPosition, wxDefaultSize, wxSB_HORIZONTAL, null, "" ) {}
			
		public ScrollBar(Window parent, int id, Point pos)
			: this (parent, id, pos, wxDefaultSize, wxSB_HORIZONTAL, null, "" ) {}
			
		public ScrollBar(Window parent, int id, Point pos, Size size)
			: this (parent, id, pos, size, wxSB_HORIZONTAL, null, "" ) {}
			
		public ScrollBar(Window parent, int id, Point pos, Size size, long style)
			: this (parent, id, pos, size, style, null, "" ) {}
			
		public ScrollBar(Window parent, int id, Point pos, Size size, long style, Validator validator)
			: this (parent, id, pos, size, style, validator, "" ) {}
			
		public ScrollBar(Window parent, int id, Point pos, Size size, long style, Validator validator, string name)
			: base (wxScrollBar_ctor() )
		{
			if (!Create(parent, id, pos, size, style, validator, name)) 
			{
				throw new InvalidOperationException("Failed to create ScrollBar");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public ScrollBar(Window parent)
			: this (parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxSB_HORIZONTAL, null, "" ) {}
			
		public ScrollBar(Window parent, Point pos)
			: this (parent, Window.UniqueID, pos, wxDefaultSize, wxSB_HORIZONTAL, null, "" ) {}
			
		public ScrollBar(Window parent, Point pos, Size size)
			: this (parent, Window.UniqueID, pos, size, wxSB_HORIZONTAL, null, "" ) {}
			
		public ScrollBar(Window parent, Point pos, Size size, long style)
			: this (parent, Window.UniqueID, pos, size, style, null, "" ) {}
			
		public ScrollBar(Window parent, Point pos, Size size, long style, Validator validator)
			: this (parent, Window.UniqueID, pos, size, style, validator, "" ) {}
			
		public ScrollBar(Window parent, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, pos, size, style, validator, name) {}
		
		//-----------------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size, long style, Validator validator, string name)
		{
			return wxScrollBar_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, Object.SafePtr(validator), name);
		}

		//-----------------------------------------------------------------------------

		public int ThumbPosition
		{
			get { return wxScrollBar_GetThumbPosition(wxObject); }
			set { wxScrollBar_SetThumbPosition(wxObject, value); }
		}

		//-----------------------------------------------------------------------------

		public int ThumbSize
		{
			get { return wxScrollBar_GetThumbSize(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public int PageSize
		{
			get { return wxScrollBar_GetPageSize(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public int Range
		{
			get { return wxScrollBar_GetRange(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public bool IsVertical
		{
			get { return wxScrollBar_IsVertical(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public override void SetScrollbar(int position, int thumbSize, int range, int pageSize, bool refresh)
		{
			wxScrollBar_SetScrollbar(wxObject, position, thumbSize, range, pageSize, refresh);
		}
	}
}
