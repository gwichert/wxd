//-----------------------------------------------------------------------------
// wx.NET - PrintDialog.cs
//
// The wxPrintDialog wrapper classes.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class PageSetupDialog : Dialog
    {
        [DllImport("wx-c")] static extern IntPtr wxPageSetupDialog_ctor(IntPtr parent, IntPtr data);
        [DllImport("wx-c")] static extern IntPtr wxPageSetupDialog_GetPageSetupData(IntPtr self);

        //-----------------------------------------------------------------------------

        internal PageSetupDialog(IntPtr wxObject)
            : base(wxObject) { }

        public PageSetupDialog(Window parent)
            : this(parent, null) { }
        public PageSetupDialog(Window parent, PageSetupDialogData data)
            : this(wxPageSetupDialog_ctor(Object.SafePtr(parent), Object.SafePtr(data))) { }

        //-----------------------------------------------------------------------------

        public PageSetupDialogData PageSetupData
        {
            get { return (PageSetupDialogData)FindObject(wxPageSetupDialog_GetPageSetupData(wxObject), typeof(PageSetupDialogData)); }
        }
    }

    public class PrintDialog : Dialog
    {
        [DllImport("wx-c")] static extern IntPtr wxPrintDialog_ctor(IntPtr parent, IntPtr data);
        [DllImport("wx-c")] static extern IntPtr wxPrintDialog_ctorPrintData(IntPtr parent, IntPtr data);
        [DllImport("wx-c")] static extern IntPtr wxPrintDialog_GetPrintData(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintDialog_GetPrintDialogData(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintDialog_GetPrintDC(IntPtr self);

        //-----------------------------------------------------------------------------

        internal PrintDialog(IntPtr wxObject)
            : base(wxObject) { }

        public PrintDialog(Window parent)
            : this(parent, (PrintDialogData)null) { }
        public PrintDialog(Window parent, PrintDialogData data)
            : this(wxPrintDialog_ctor(Object.SafePtr(parent), Object.SafePtr(data))) { }

        public PrintDialog(Window parent, PrintData data)
            : this(wxPrintDialog_ctorPrintData(Object.SafePtr(parent), Object.SafePtr(data))) { }

        //-----------------------------------------------------------------------------

        public PrintData PrintData
        {
            get { return (PrintData)FindObject(wxPrintDialog_GetPrintData(wxObject), typeof(PrintData)); }
        }

        //-----------------------------------------------------------------------------

        public PrintDialogData PrintDialogData
        {
            get { return (PrintDialogData)FindObject(wxPrintDialog_GetPrintDialogData(wxObject), typeof(PrintDialogData)); }
        }

        //-----------------------------------------------------------------------------

        public DC PrintDC
        {
            get { return (DC)FindObject(wxPrintDialog_GetPrintDC(wxObject), typeof(DC)); }
        }
    }

#if __WXGTK__
    
    public class PrintSetupDialog : Dialog
    {
        [DllImport("wx-c")] static extern IntPtr wxPrintSetupDialog_ctor(IntPtr parent, IntPtr data);
        [DllImport("wx-c")] static extern IntPtr wxPrintSetupDialog_ctorPrintData(IntPtr parent, IntPtr data);
        [DllImport("wx-c")] static extern void wxPrintSetupDialog_Init(IntPtr self, IntPtr data);
        [DllImport("wx-c")] static extern IntPtr wxPrintSetupDialog_GetPrintData(IntPtr self);

        //-----------------------------------------------------------------------------

        internal PrintSetupDialog(IntPtr wxObject)
            : base(wxObject) { }

        public PrintSetupDialog(Window parent) 
            : this(parent, (PrintDialogData)null) { }
        public PrintSetupDialog(Window parent, PrintDialogData data)
            : this(wxPrintSetupDialog_ctor(Object.SafePtr(parent), Object.SafePtr(data))) { }

        public PrintSetupDialog(Window parent, PrintData data)
            : this(wxPrintSetupDialog_ctorPrintData(Object.SafePtr(parent), Object.SafePtr(data))) { }

        //-----------------------------------------------------------------------------

        public void Init(PrintData data)
        {
            wxPrintSetupDialog_Init(wxObject, Object.SafePtr(data));
        }

        //-----------------------------------------------------------------------------

        public PrintData PrintData
        {
            get { return (PrintData)FindObject(wxPrintSetupDialog_GetPrintData(wxObject), typeof(PrintData)); }
        }
    }
    
#endif
}
