//-----------------------------------------------------------------------------
// wxD - GDIObject.d
//
// The wxGDIObject wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.GDIObject;
import wx.common;

		static extern (C) void wxGDIObj_dtor(IntPtr self);

		//---------------------------------------------------------------------

	public class GDIObject : wxObject
	{
		public this(IntPtr wxobj) 
			{ super(wxobj);}

		/*public override void Dispose()
		{
			wxobj = IntPtr.init;
			Dispose(false);
		}*/		

		//---------------------------------------------------------------------
	}
