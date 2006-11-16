//-----------------------------------------------------------------------------
// wxD - WizardPageSimple.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - WizardPageSimple.cs
//
// The wxWizardPageSimple wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.WizardPageSimple;
import wx.common;
import wx.Wizard;
import wx.WizardPage;

		static extern (C) IntPtr wxWizPageSimp_ctor(IntPtr parent, IntPtr prev, IntPtr next);
		static extern (C) void   wxWizPageSimp_Chain(IntPtr first, IntPtr second);

		//---------------------------------------------------------------------

	public class WizardPageSimple : WizardPage
	{
		public this(Wizard parent)
		{
			this(parent, null, null);
		}

		public this(Wizard parent, WizardPage prev, WizardPage next)
		{
			super(wxWizPageSimp_ctor(parent.wxobj,
			                          prev !== null ? prev.wxobj : IntPtr.init,
			                          next !== null ? next.wxobj : IntPtr.init));
		}

		public this(IntPtr wxobj) 
		{
			super(wxobj);
		}

		//---------------------------------------------------------------------

		public static void Chain(WizardPageSimple first, WizardPageSimple second)
		{
			wxWizPageSimp_Chain(first.wxobj, second.wxobj);
		}

		//---------------------------------------------------------------------
	}
