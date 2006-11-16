//-----------------------------------------------------------------------------
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

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class WizardPageSimple : WizardPage
	{
		[DllImport("wx-c")] static extern IntPtr wxWizPageSimp_ctor(IntPtr parent, IntPtr prev, IntPtr next);
		[DllImport("wx-c")] static extern void   wxWizPageSimp_Chain(IntPtr first, IntPtr second);

		//---------------------------------------------------------------------

		public WizardPageSimple(Wizard parent)
			: this(parent, null, null)
		{
		}

		public WizardPageSimple(Wizard parent, WizardPage prev, WizardPage next)
			: base(wxWizPageSimp_ctor(parent.wxObject,
			                          prev != null ? prev.wxObject : IntPtr.Zero,
			                          next != null ? next.wxObject : IntPtr.Zero))
		{
		}

		public WizardPageSimple(IntPtr wxObject) : base(wxObject)
		{
		}

		//---------------------------------------------------------------------

		public static void Chain(WizardPageSimple first, WizardPageSimple second)
		{
			wxWizPageSimp_Chain(first.wxObject, second.wxObject);
		}

		//---------------------------------------------------------------------
	}
}
