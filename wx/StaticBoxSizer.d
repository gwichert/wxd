//-----------------------------------------------------------------------------
// wx.NET - StaticBoxSizer.cs
//
// The wxStaticBoxSizer proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class StaticBoxSizer : BoxSizer
	{
		[DllImport("wx-c")] static extern IntPtr wxStaticBoxSizer_ctor(IntPtr box, int orient);
		[DllImport("wx-c")] static extern IntPtr wxStaticBoxSizer_GetStaticBox(IntPtr self);

		//---------------------------------------------------------------------

		public StaticBoxSizer(IntPtr wxObject)
			: base(wxObject)
		{
		}

		public StaticBoxSizer(StaticBox box, int orient)
			: base(wxStaticBoxSizer_ctor(Object.SafePtr(box), orient))
		{
		}

		//---------------------------------------------------------------------

		public StaticBox StaticBox
		{
			get
			{
				return (StaticBox)FindObject(
                                    wxStaticBoxSizer_GetStaticBox(wxObject)
                                );
			}
		}

		//---------------------------------------------------------------------
	}
}
