//-----------------------------------------------------------------------------
// wx.NET - Wizard.cs
//
// The wxWizard wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class Wizard : Dialog
	{
		[DllImport("wx-c")] static extern IntPtr wxWizard_ctor(IntPtr parent, int id, string title, IntPtr bitmap, ref Point pos);
		[DllImport("wx-c")] static extern bool   wxWizard_RunWizard(IntPtr self, IntPtr firstPage);
		[DllImport("wx-c")] static extern void   wxWizard_SetPageSize(IntPtr self, ref Size size);

		//---------------------------------------------------------------------
		
		public Wizard(IntPtr wxObject) 
			: base(wxObject) {}

		public Wizard(Window parent, int id, string title, Bitmap bitmap)
			: base(wxWizard_ctor(parent != null ? parent.wxObject : IntPtr.Zero, id, title, bitmap != null ? bitmap.wxObject : IntPtr.Zero, ref wxDefaultPosition)) {}

		//---------------------------------------------------------------------

		public bool RunWizard(WizardPage firstPage)
		{
			if (firstPage == null)
				throw new ArgumentNullException("firstPage");

			return wxWizard_RunWizard(wxObject, firstPage.wxObject);
		}

		//---------------------------------------------------------------------

		public Size PageSize
		{
			set { wxWizard_SetPageSize(wxObject, ref value); }
		}
	}
}
