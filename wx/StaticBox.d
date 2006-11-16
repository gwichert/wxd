//-----------------------------------------------------------------------------
// wxD - StaticBox.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - StaticBox.cs
//
// The wxStaticBox wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

module wx.StaticBox;
import wx.common;
import wx.Control;

		static extern (C) IntPtr wxStaticBox_ctor();
		static extern (C) bool wxStaticBox_Create(IntPtr self, IntPtr parent, int id, string label, inout Point pos, inout Size size, uint style, string name);
	
		//---------------------------------------------------------------------

	public class StaticBox : Control
	{
		public this()
			{ super(wxStaticBox_ctor()); }

		public this(IntPtr wxobj)
			{ super(wxobj); }
			
		public this(Window window, int id, string label)
			{ this(window, id, label, wxDefaultPosition, wxDefaultSize, 0, null); }
			
		public this(Window window, int id, string label, Point pos)
			{ this(window, id, label, pos, wxDefaultSize, 0, null); }

		public this(Window window, int id, string label, Point pos, Size size)
			{ this(window, id, label, pos, size, 0, null); }

		public this(Window window, int id, string label, Point pos, Size size, int style)
			{ this(window, id, label, pos, size, style, null); }

		public this(Window window, int id, string label, Point pos, Size size, int style, string name)
		{
			this();
			if (!Create(window, id, label, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticBox");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window window, string label)
			{ this(window, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null); }
			
		public this(Window window, string label, Point pos)
			{ this(window, Window.UniqueID, label, pos, wxDefaultSize, 0, null); }

		public this(Window window, string label, Point pos, Size size)
			{ this(window, Window.UniqueID, label, pos, size, 0, null); }

		public this(Window window, string label, Point pos, Size size, int style)
			{ this(window, Window.UniqueID, label, pos, size, style, null); }

		public this(Window window, string label, Point pos, Size size, int style, string name)
			{ this(window, Window.UniqueID, label, pos, size, style, name);}

		//---------------------------------------------------------------------

		public bool Create(Window window, int id, string label, Point pos, Size size, int style, string name)
		{
			return wxStaticBox_Create(wxobj, wxObject.SafePtr(window), 
					id, label, pos, size, 
					cast(uint)style, name);
		}
	}
