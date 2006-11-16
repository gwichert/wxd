//-----------------------------------------------------------------------------
// wx.NET - StaticLine.cs
//
// The wxStaticLine wrapper class.
//
// Written by Robert Roebling
// (C) 2003 by Robert Roebling
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class StaticLine : Control
	{
		[DllImport("wx-c")] static extern IntPtr wxStaticLine_ctor();
		[DllImport("wx-c")] static extern bool wxStaticLine_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern bool wxStaticLine_IsVertical(IntPtr self);
		[DllImport("wx-c")] static extern int  wxStaticLine_GetDefaultSize(IntPtr self);

		//---------------------------------------------------------------------

		public const long wxLI_HORIZONTAL		= Orientation.wxHORIZONTAL;
		public const long wxLI_VERTICAL		= Orientation.wxVERTICAL;
		
		//---------------------------------------------------------------------
		
		public StaticLine(IntPtr wxObject) 
			: base(wxObject) {}
        
		public StaticLine()
			: base(wxStaticLine_ctor())	{ }

		public StaticLine(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public StaticLine(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, null) { }

		public StaticLine(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, null) { }

		public StaticLine(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, null) { }

		public StaticLine(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxStaticLine_ctor())
		{
			if (!Create(parent, id, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticText");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public StaticLine(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public StaticLine(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, null) { }

		public StaticLine(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, null) { }

		public StaticLine(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, null) { }

		public StaticLine(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size, long style, string name)
		{
			return wxStaticLine_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name);
		}
		
		//---------------------------------------------------------------------
		
		public bool IsVertical()
		{
			return wxStaticLine_IsVertical(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public int DefaultSize
		{
			get { return wxStaticLine_GetDefaultSize(wxObject); }
		}
	}
}
