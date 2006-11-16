//-----------------------------------------------------------------------------
// wx.NET - TipDialog.cs
//
// The wxTipProvider proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class TipProvider
    {
	[DllImport("wx-c")] static extern IntPtr wxCreateFileTipProvider_func(string filename, int currentTip);
	[DllImport("wx-c")] static extern bool wxShowTip_func(IntPtr parent, IntPtr tipProvider, bool showAtStartup);
	[DllImport("wx-c")] static extern int wxTipProvider_GetCurrentTip();

	public static IntPtr CreateFileTipProvider(string filename, int currentTip)
	{
		return wxCreateFileTipProvider_func(filename, currentTip);
	}

	public static bool ShowTip(Window parent, IntPtr tipProvider)
	{
		return wxShowTip_func(Object.SafePtr(parent), tipProvider, true);
	}

	public static bool ShowTip(Window parent, IntPtr tipProvider, bool showAtStartup)
	{
		return wxShowTip_func(Object.SafePtr(parent), tipProvider, showAtStartup);
	}

	public static int CurrentTip
	{
		get { return wxTipProvider_GetCurrentTip(); }
	}
    }
}
