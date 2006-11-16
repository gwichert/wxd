//-----------------------------------------------------------------------------
// wxD - StaticText.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - StaticText.cs
//
// The wxStaticText wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.StaticText;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxStaticText_ctor();
		static extern (C) bool wxStaticText_Create(IntPtr self, IntPtr parent, int id, string label, inout Point pos, inout Size size, uint style, string name);

		//---------------------------------------------------------------------
		
	public class StaticText : Control
	{
		public const int wxST_NO_AUTORESIZE = 0x0001;
	
		public this(IntPtr wxobj) 
			{ super(wxobj);}

		public this()
			{ super(wxStaticText_ctor()); }

		public this(Window parent, int id, string label)
			{ this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null); }

		public this(Window parent, int id, string label, Point pos)
			{ this(parent, id, label, pos, wxDefaultSize, 0, null); }

		public this(Window parent, int id, string label, Point pos, Size size)
			{ this(parent, id, label, pos, size, 0, null); }

		public this(Window parent, int id, string label, Point pos, Size size, int style)
			{ this(parent, id, label, pos, size, style, null); }
			
		public this(Window parent, int id, string label, Point pos, Size size, int style, string name)
		{
			super(wxStaticText_ctor());
			if (!Create(parent, id, label, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticText");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, string label)
			{ this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null); }

		public this(Window parent, string label, Point pos)
			{ this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null); }

		public this(Window parent, string label, Point pos, Size size)
			{ this(parent, Window.UniqueID, label, pos, size, 0, null); }

		public this(Window parent, string label, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, label, pos, size, style, null); }
			
		public this(Window parent, string label, Point pos, Size size, int style, string name)
			{ this(parent, Window.UniqueID, label, pos, size, style, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, Point pos, Size size, int style, string name)
		{
			return wxStaticText_Create(wxobj, wxObject.SafePtr(parent), id, label, pos, size, cast(uint)style, name);
		}
	}
