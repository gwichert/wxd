//-----------------------------------------------------------------------------
// wxD - StaticText.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - StaticText.cs
//
/// The wxStaticText wrapper class.
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

		//! \cond EXTERN
		static extern (C) IntPtr wxStaticText_ctor();
		static extern (C) bool wxStaticText_Create(IntPtr self, IntPtr parent, int id, string label, inout Point pos, inout Size size, uint style, string name);
		//! \endcond

		//---------------------------------------------------------------------
		
	alias StaticText wxStaticText;
	public class StaticText : Control
	{
		public const int wxST_NO_AUTORESIZE = 0x0001;
	
		public const string wxStaticTextNameStr = "message";
	
		public this(IntPtr wxobj) 
			{ super(wxobj);}

		public this()
			{ super(wxStaticText_ctor()); }

		public this(Window parent, int id, string label, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = 0, string name = wxStaticTextNameStr)
		{
			super(wxStaticText_ctor());
			if (!Create(parent, id, label, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create StaticText");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, string label, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = 0, string name = wxStaticTextNameStr)
			{ this(parent, Window.UniqueID, label, pos, size, style, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, string label, inout Point pos, inout Size size, int style, string name)
		{
			return wxStaticText_Create(wxobj, wxObject.SafePtr(parent), id, label, pos, size, cast(uint)style, name);
		}
	}
