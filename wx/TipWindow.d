//-----------------------------------------------------------------------------
// wxD - tipwin.h
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - tipwin.h
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.TipWindow;
import wx.common;
import wx.Window;

        static extern (C) IntPtr wxTipWindow_ctor(IntPtr parent, string text, int maxLength, inout Rectangle rectBound);
        static extern (C) IntPtr wxTipWindow_ctorNoRect(IntPtr parent, string text, int maxLength);
        //static extern (C) void   wxTipWindow_SetTipWindowPtr(IntPtr self, IntPtr wxTipWindow* windowPtr);
        static extern (C) void   wxTipWindow_SetBoundingRect(IntPtr self, inout Rectangle rectBound);
        static extern (C) void   wxTipWindow_Close(IntPtr self);

        //-----------------------------------------------------------------------------

    public class TipWindow : Window
    {
        public this(IntPtr wxobj)
            { super(wxobj); }

        public this(Window parent, string text)
            { this(parent, text, 100); }
        public this(Window parent, string text, int maxLength)
            { this(wxTipWindow_ctorNoRect(wxObject.SafePtr(parent), text, maxLength)); }

        public this(Window parent, string text, int maxLength, Rectangle rectBound)
            { this(wxTipWindow_ctor(wxObject.SafePtr(parent), text, maxLength, rectBound)); }

        //-----------------------------------------------------------------------------

        /*public void SetTipWindowPtr( TipWindow* windowPtr)
        {
            wxTipWindow_SetTipWindowPtr(wxobj, wxObject.SafePtr(TipWindow* windowPtr));
        }*/

        //-----------------------------------------------------------------------------

        public void BoundingRect(Rectangle value) { wxTipWindow_SetBoundingRect(wxobj, value); }
    }
