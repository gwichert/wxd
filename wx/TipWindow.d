//-----------------------------------------------------------------------------
// wx.NET - tipwin.h
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class TipWindow : Window
    {
        [DllImport("wx-c")] static extern IntPtr wxTipWindow_ctor(IntPtr parent, string text, int maxLength, ref Rectangle rectBound);
        [DllImport("wx-c")] static extern IntPtr wxTipWindow_ctorNoRect(IntPtr parent, string text, int maxLength);
        //[DllImport("wx-c")] static extern void   wxTipWindow_SetTipWindowPtr(IntPtr self, IntPtr wxTipWindow* windowPtr);
        [DllImport("wx-c")] static extern void   wxTipWindow_SetBoundingRect(IntPtr self, ref Rectangle rectBound);
        [DllImport("wx-c")] static extern void   wxTipWindow_Close(IntPtr self);

        //-----------------------------------------------------------------------------

        public TipWindow(IntPtr wxObject)
            : base(wxObject) { }

        public TipWindow(Window parent, string text)
            : this(parent, text, 100) { }
        public TipWindow(Window parent, string text, int maxLength)
            : this(wxTipWindow_ctorNoRect(Object.SafePtr(parent), text, maxLength)) { }

        public TipWindow(Window parent, string text, int maxLength, Rectangle rectBound)
            : this(wxTipWindow_ctor(Object.SafePtr(parent), text, maxLength, ref rectBound)) { }

        //-----------------------------------------------------------------------------

        /*public void SetTipWindowPtr( TipWindow* windowPtr)
        {
            wxTipWindow_SetTipWindowPtr(wxObject, Object.SafePtr(TipWindow* windowPtr));
        }*/

        //-----------------------------------------------------------------------------

        public Rectangle BoundingRect
        {
            set { wxTipWindow_SetBoundingRect(wxObject, ref value); }
        }
    }
}
