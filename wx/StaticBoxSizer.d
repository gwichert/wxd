//-----------------------------------------------------------------------------
// wxD - StaticBoxSizer.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - StaticBoxSizer.cs
//
// The wxStaticBoxSizer proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

module wx.StaticBoxSizer;
import wx.common;
import wx.BoxSizer;
import wx.StaticBox;

		static extern (C) IntPtr wxStaticBoxSizer_ctor(IntPtr box, int orient);
		static extern (C) IntPtr wxStaticBoxSizer_GetStaticBox(IntPtr self);

		//---------------------------------------------------------------------

	public class StaticBoxSizer : BoxSizer
	{
		public this(IntPtr wxobj)
		{
			super(wxobj);
		}

		public this(StaticBox box, int orient)
		{
			super(wxStaticBoxSizer_ctor(wxObject.SafePtr(box), orient));
		}

		//---------------------------------------------------------------------

		public StaticBox staticBox() 
			{
				return cast(StaticBox)FindObject(
                                    wxStaticBoxSizer_GetStaticBox(wxobj)
                                );
			}

		//---------------------------------------------------------------------
	}
