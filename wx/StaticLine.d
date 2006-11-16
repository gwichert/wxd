//-----------------------------------------------------------------------------
// wxD - StaticLine.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.StaticLine;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxStaticLine_ctor();
		static extern (C) bool wxStaticLine_Create(IntPtr self, IntPtr parent, int id, inout Point pos, inout Size size, uint style, string name);
		static extern (C) bool wxStaticLine_IsVertical(IntPtr self);
		static extern (C) int  wxStaticLine_GetDefaultSize(IntPtr self);

		//---------------------------------------------------------------------

	public class StaticLine : Control
	{
		public const int wxLI_HORIZONTAL		= Orientation.wxHORIZONTAL;
		public const int wxLI_VERTICAL		= Orientation.wxVERTICAL;
		
		//---------------------------------------------------------------------
		
		public this(IntPtr wxobj) 
			{ super(wxobj);}
        
		public this()
			{ super(wxStaticLine_ctor()); }

		public this(Window parent, int id)
			{ this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null); }

		public this(Window parent, int id, Point pos)
			{ this(parent, id, pos, wxDefaultSize, 0, null); }

		public this(Window parent, int id, Point pos, Size size)
			{ this(parent, id, pos, size, 0, null); }

		public this(Window parent, int id, Point pos, Size size, int style)
			{ this(parent, id, pos, size, style, null); }

		public this(Window parent, int id, Point pos, Size size, int style, string name)
		{
			super(wxStaticLine_ctor());
			if (!Create(parent, id, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticText");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent)
			{ this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null); }

		public this(Window parent, Point pos)
			{ this(parent, Window.UniqueID, pos, wxDefaultSize, 0, null); }

		public this(Window parent, Point pos, Size size)
			{ this(parent, Window.UniqueID, pos, size, 0, null); }

		public this(Window parent, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, pos, size, style, null); }

		public this(Window parent, Point pos, Size size, int style, string name)
			{ this(parent, Window.UniqueID, pos, size, style, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size, int style, string name)
		{
			return wxStaticLine_Create(wxobj, wxObject.SafePtr(parent), id, pos, size, cast(uint)style, name);
		}
		
		//---------------------------------------------------------------------
		
		public bool IsVertical()
		{
			return wxStaticLine_IsVertical(wxobj);
		}
		
		//---------------------------------------------------------------------
		
		public int DefaultSize() { return wxStaticLine_GetDefaultSize(wxobj); }
	}
