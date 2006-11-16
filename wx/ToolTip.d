//-----------------------------------------------------------------------------
// wxD - ToolTip.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - ToolTip.cs
//
// The wxToolTip wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.ToolTip;
import wx.common;
import wx.Window;

		static extern (C) void   wxToolTip_Enable(bool flag);
		static extern (C) void   wxToolTip_SetDelay(uint msecs);
		static extern (C) IntPtr wxToolTip_ctor(string tip);
		static extern (C) void   wxToolTip_SetTip(IntPtr self, string tip);
		static extern (C) string wxToolTip_GetTip(IntPtr self);
		static extern (C) IntPtr wxToolTip_GetWindow(IntPtr self);

        //---------------------------------------------------------------------

	public class ToolTip : wxObject
	{
        public this(IntPtr wxobj)
            { super(wxobj); }

        public this(string tip)
            { super(wxToolTip_ctor(tip)); }

        //---------------------------------------------------------------------

        static void Enabled(bool value) 
            {
                wxToolTip_Enable(value);
            }

        //---------------------------------------------------------------------
        
        static void Delay(int value) 
            {
                wxToolTip_SetDelay(cast(uint)value);
            }

        //---------------------------------------------------------------------

        public string Tip() 
            {
                return wxToolTip_GetTip(wxobj).dup;
            }
        public void Tip(string value) 
            {
                wxToolTip_SetTip(wxobj, value);
            }

        //---------------------------------------------------------------------

        public Window window() 
            {
                return cast(Window)FindObject(wxToolTip_GetWindow(wxobj));
            }

        //---------------------------------------------------------------------
	}

