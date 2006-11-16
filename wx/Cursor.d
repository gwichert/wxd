//-----------------------------------------------------------------------------
// wx.NET - Cursor.cs
//
// The wxCursor wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public enum StockCursor
	{
		wxCURSOR_NONE,
		wxCURSOR_ARROW,
		wxCURSOR_RIGHT_ARROW,
		wxCURSOR_BULLSEYE,
		wxCURSOR_CHAR,
		wxCURSOR_CROSS,
		wxCURSOR_HAND,
		wxCURSOR_IBEAM,
		wxCURSOR_LEFT_BUTTON,
		wxCURSOR_MAGNIFIER,
		wxCURSOR_MIDDLE_BUTTON,
		wxCURSOR_NO_ENTRY,
		wxCURSOR_PAINT_BRUSH,
		wxCURSOR_PENCIL,
		wxCURSOR_POINT_LEFT,
		wxCURSOR_POINT_RIGHT,
		wxCURSOR_QUESTION_ARROW,
		wxCURSOR_RIGHT_BUTTON,
		wxCURSOR_SIZENESW,
		wxCURSOR_SIZENS,
		wxCURSOR_SIZENWSE,
		wxCURSOR_SIZEWE,
		wxCURSOR_SIZING,
		wxCURSOR_SPRAYCAN,
		wxCURSOR_WAIT,
		wxCURSOR_WATCH,
		wxCURSOR_BLANK,
		wxCURSOR_ARROWWAIT,
		wxCURSOR_MAX
	}

	public class Cursor : Bitmap
	{
		[DllImport("wx-c")] static extern IntPtr wxCursor_ctorById(StockCursor id);
		[DllImport("wx-c")] static extern IntPtr wxCursor_ctorImage(IntPtr image);
		[DllImport("wx-c")] static extern IntPtr wxCursor_ctorCopy(IntPtr cursor);

		[DllImport("wx-c")] static extern bool   wxCursor_Ok(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxCursor_SetCursor(IntPtr cursor);

		//---------------------------------------------------------------------
		
		public Cursor(IntPtr wxObject)
			: base(wxObject) {}

		public Cursor(StockCursor id)
			: base(wxCursor_ctorById(id))
		{
		}

		public Cursor(Image image)
			: base(wxCursor_ctorImage(Object.SafePtr(image)))
		{
		}

		public Cursor(Cursor cursor)
			: base(wxCursor_ctorCopy(Object.SafePtr(cursor)))
		{
		}

		//---------------------------------------------------------------------

		public override bool Ok()
		{
			return wxCursor_Ok(wxObject);
		}

		//---------------------------------------------------------------------
		
		public static void SetCursor(Cursor cursor)
		{
			wxCursor_SetCursor(Object.SafePtr(cursor));
		}
	}
}
