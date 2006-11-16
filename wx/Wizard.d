//-----------------------------------------------------------------------------
// wxD - Wizard.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.Wizard;
import wx.common;
import wx.Dialog;
import wx.WizardPage;

		static extern (C) IntPtr wxWizard_ctor(IntPtr parent, int id, string title, IntPtr bitmap, inout Point pos);
		static extern (C) bool   wxWizard_RunWizard(IntPtr self, IntPtr firstPage);
		static extern (C) void   wxWizard_SetPageSize(IntPtr self, inout Size size);

		//---------------------------------------------------------------------
		
	public class Wizard : Dialog
	{
		public this(IntPtr wxobj) 
			{ super(wxobj);}

		public this(Window parent, int id, string title, Bitmap bitmap)
			{ super(wxWizard_ctor(parent !== null ? parent.wxobj : IntPtr.init, id, title, bitmap !== null ? bitmap.wxobj : IntPtr.init, wxDefaultPosition));}

		//---------------------------------------------------------------------

		public bool RunWizard(WizardPage firstPage)
		{
			if (firstPage === null)
				throw new ArgumentNullException("firstPage");

			return wxWizard_RunWizard(wxobj, firstPage.wxobj);
		}

		//---------------------------------------------------------------------

		public void PageSize(Size value) { wxWizard_SetPageSize(wxobj, value); }
	}
