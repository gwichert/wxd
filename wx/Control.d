//-----------------------------------------------------------------------------
// wxD - Control.d
//
// The wxControl wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Control;
import wx.common;
import wx.Window;

		static extern (C) void   wxControl_Command(IntPtr self, IntPtr evt);
		static extern (C) string wxControl_GetLabel(IntPtr self);
		static extern (C) void   wxControl_SetLabel(IntPtr self, string label);
		
		static extern (C) int wxControl_GetAlignment(IntPtr self);
		static extern (C) bool wxControl_SetFont(IntPtr self, IntPtr font);

		//---------------------------------------------------------------------

	public class Control : Window
	{
		public this(IntPtr wxobj) 
			{ super(wxobj);}

		public this(Window parent, int id, Point pos, Size size, int style, string name)
			{ super(parent, id, pos, size, style, name);}
		
		public this(Window parent, Point pos, Size size, int style, string name)
			{ super(parent, Window.UniqueID, pos, size, style, name);}

		//---------------------------------------------------------------------

		public void Command() {}

		//---------------------------------------------------------------------

		public string Label() { return wxControl_GetLabel(wxobj).dup; }
		public void Label(string value) { wxControl_SetLabel(wxobj, value); }
		
		//---------------------------------------------------------------------
		
		public int GetAlignment()
		{
			return wxControl_GetAlignment(wxobj);
		}
		
		//---------------------------------------------------------------------
		
		public bool SetFont(Font font)
		{
			return wxControl_SetFont(wxobj, wxObject.SafePtr(font));
		}
	}

