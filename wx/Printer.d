//-----------------------------------------------------------------------------
// wx.NET - TextCtrl.cs
//
// The wxTextCtrl wrapper class.
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
    public enum PrinterError 
    {
        wxPRINTER_NO_ERROR = 0,
        wxPRINTER_CANCELLED,
        wxPRINTER_ERROR
    }

    public class Printer : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxPrinter_ctor(IntPtr data);
        [DllImport("wx-c")] static extern IntPtr wxPrinter_CreateAbortWindow(IntPtr self, IntPtr parent, IntPtr printout);
        [DllImport("wx-c")] static extern void   wxPrinter_ReportError(IntPtr self, IntPtr parent, IntPtr printout, string message);
        [DllImport("wx-c")] static extern IntPtr wxPrinter_GetPrintDialogData(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxPrinter_GetAbort(IntPtr self);
        [DllImport("wx-c")] static extern int    wxPrinter_GetLastError(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxPrinter_Setup(IntPtr self, IntPtr parent);
        [DllImport("wx-c")] static extern bool   wxPrinter_Print(IntPtr self, IntPtr parent, IntPtr printout, bool prompt);
        [DllImport("wx-c")] static extern IntPtr wxPrinter_PrintDialog(IntPtr self, IntPtr parent);

        //-----------------------------------------------------------------------------

        internal Printer(IntPtr wxObject) 
            : base(wxObject) { }

        public Printer()
            : this(null) { } 
        public Printer(PrintDialogData data)
            : this(wxPrinter_ctor(Object.SafePtr(data))) { }

        //-----------------------------------------------------------------------------

        public Window CreateAbortWindow(Window parent, Printout printout)
        {
            return (Window)FindObject(wxPrinter_CreateAbortWindow(wxObject, Object.SafePtr(parent), Object.SafePtr(printout)), typeof(Window));
        }

        //-----------------------------------------------------------------------------

        public void ReportError(Window parent, Printout printout, string message)
        {
            wxPrinter_ReportError(wxObject, Object.SafePtr(parent), Object.SafePtr(printout), message);
        }

        //-----------------------------------------------------------------------------

        public PrintDialogData PrintDialogData
        {
            get { return (PrintDialogData)FindObject(wxPrinter_GetPrintDialogData(wxObject), typeof(PrintDialogData)); }
        }

        //-----------------------------------------------------------------------------

        public bool Abort
        {
            get { return wxPrinter_GetAbort(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public PrinterError LastError
        {
            get { return (PrinterError)wxPrinter_GetLastError(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool Setup(Window parent)
        {
            return wxPrinter_Setup(wxObject, Object.SafePtr(parent));
        }

        //-----------------------------------------------------------------------------

        public bool Print(Window parent, Printout printout, bool prompt)
        {
            return wxPrinter_Print(wxObject, Object.SafePtr(parent), Object.SafePtr(printout), prompt);
        }

        //-----------------------------------------------------------------------------

        public DC PrintDialog(Window parent)
        {
            return (DC)FindObject(wxPrinter_PrintDialog(wxObject, Object.SafePtr(parent)), typeof(DC));
        }
    }

    public abstract class Printout : Object
    {
        private delegate void Virtual_NoParams();
        private delegate bool Virtual_ParamsInt(int i);
        private delegate bool Virtual_OnBeginDocument(int startPage, int endPage);
        private delegate void Virtual_GetPageInfo(ref int minPage, ref int maxPage, ref int pageFrom, ref int pageTo);

		private Virtual_OnBeginDocument onBeginDocument;
		private Virtual_NoParams onEndDocument;
		private Virtual_NoParams onBeginPrinting;
		private Virtual_NoParams onEndPrinting;
		private Virtual_NoParams onPreparePrinting;
		private Virtual_ParamsInt hasPage;
		private Virtual_ParamsInt onPrintPage;
		private Virtual_GetPageInfo getPageInfo;

        //-----------------------------------------------------------------------------

        [DllImport("wx-c")] static extern IntPtr wxPrintout_ctor(string title);
        [DllImport("wx-c")] static extern bool   wxPrintout_OnBeginDocument(IntPtr self, int startPage, int endPage);
        [DllImport("wx-c")] static extern void   wxPrintout_OnEndDocument(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintout_OnBeginPrinting(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintout_OnEndPrinting(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintout_OnPreparePrinting(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxPrintout_HasPage(IntPtr self, int page);
        [DllImport("wx-c")] static extern void   wxPrintout_GetPageInfo(IntPtr self, ref int minPage, ref int maxPage, ref int pageFrom, ref int pageTo);
        [DllImport("wx-c")] static extern IntPtr wxPrintout_GetTitle(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintout_GetDC(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintout_SetDC(IntPtr self, IntPtr dc);
        [DllImport("wx-c")] static extern void   wxPrintout_SetPageSizePixels(IntPtr self, int w, int h);
        [DllImport("wx-c")] static extern void   wxPrintout_GetPageSizePixels(IntPtr self, ref int w, ref int h);
        [DllImport("wx-c")] static extern void   wxPrintout_SetPageSizeMM(IntPtr self, int w, int h);
        [DllImport("wx-c")] static extern void   wxPrintout_GetPageSizeMM(IntPtr self, ref int w, ref int h);
        [DllImport("wx-c")] static extern void   wxPrintout_SetPPIScreen(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern void   wxPrintout_GetPPIScreen(IntPtr self, ref int x, ref int y);
        [DllImport("wx-c")] static extern void   wxPrintout_SetPPIPrinter(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern void   wxPrintout_GetPPIPrinter(IntPtr self, ref int x, ref int y);
        [DllImport("wx-c")] static extern bool   wxPrintout_IsPreview(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintout_SetIsPreview(IntPtr self, bool p);

        [DllImport("wx-c")] static extern void   wxPrintout_RegisterVirtual(IntPtr self, Virtual_OnBeginDocument onBeginDocument, Virtual_NoParams onEndDocument, Virtual_NoParams onBeginPrinting, Virtual_NoParams onEndPrinting, Virtual_NoParams onPreparePrinting, Virtual_ParamsInt hasPage, Virtual_ParamsInt onPrintPage, Virtual_GetPageInfo getPageInfo);

        //-----------------------------------------------------------------------------

        internal Printout(IntPtr wxObject) 
            : base(wxObject) 
        { 
			onBeginDocument = new Virtual_OnBeginDocument(OnBeginDocument);
            onEndDocument = new Virtual_NoParams(OnEndDocument);
            onBeginPrinting = new Virtual_NoParams(OnBeginPrinting);
            onEndPrinting = new Virtual_NoParams(OnEndPrinting);
            onPreparePrinting = new Virtual_NoParams(OnPreparePrinting);
            hasPage = new Virtual_ParamsInt(HasPage);
            onPrintPage = new Virtual_ParamsInt(OnPrintPage);
            getPageInfo = new Virtual_GetPageInfo(GetPageInfo);

            wxPrintout_RegisterVirtual(wxObject,
                    onBeginDocument,
                    onEndDocument,
                    onBeginPrinting,
                    onEndPrinting,
                    onPreparePrinting,
                    hasPage,
                    onPrintPage,
                    getPageInfo);
        }

        public Printout(string title)
            : this(wxPrintout_ctor(title)) { }

        //-----------------------------------------------------------------------------

        public virtual bool OnBeginDocument(int startPage, int endPage)
        {
            return wxPrintout_OnBeginDocument(wxObject, startPage, endPage);
        }

        public virtual void OnEndDocument()
        {
            wxPrintout_OnEndDocument(wxObject);
        }

        //-----------------------------------------------------------------------------

        public virtual void OnBeginPrinting()
        {
            wxPrintout_OnBeginPrinting(wxObject);
        }

        public virtual void OnEndPrinting()
        {
            wxPrintout_OnEndPrinting(wxObject);
        }

        public virtual void OnPreparePrinting()
        {
            wxPrintout_OnPreparePrinting(wxObject);
        }

        //-----------------------------------------------------------------------------

        public virtual bool HasPage(int page)
        {
            return wxPrintout_HasPage(wxObject, page);
        }

        //-----------------------------------------------------------------------------

        public abstract bool OnPrintPage(int page);

        //-----------------------------------------------------------------------------

        public virtual void GetPageInfo(ref int minPage, ref int maxPage, ref int pageFrom, ref int pageTo)
        {
            wxPrintout_GetPageInfo(wxObject, ref minPage, ref maxPage, ref pageFrom, ref pageTo);
        }

        //-----------------------------------------------------------------------------

        public string Title
        {
            get { return new wxString(wxPrintout_GetTitle(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public DC DC
        {
            get { return (DC)FindObject(wxPrintout_GetDC(wxObject), typeof(DC)); }
            set { wxPrintout_SetDC(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public void SetPageSizePixels(int w, int h)
        {
            wxPrintout_SetPageSizePixels(wxObject, w, h);
        }

        public void GetPageSizePixels(out int w, out int h)
        {
            w = h = 0;
            wxPrintout_GetPageSizePixels(wxObject, ref w, ref h);
        }

        //-----------------------------------------------------------------------------

        public void SetPageSizeMM(int w, int h)
        {
            wxPrintout_SetPageSizeMM(wxObject, w, h);
        }

        public void GetPageSizeMM(out int w, out int h)
        {
            w = h = 0;
            wxPrintout_GetPageSizeMM(wxObject, ref w, ref h);
        }

        //-----------------------------------------------------------------------------

        public void SetPPIScreen(int x, int y)
        {
            wxPrintout_SetPPIScreen(wxObject, x, y);
        }

        //-----------------------------------------------------------------------------

        public void GetPPIScreen(out int x, out int y)
        {
            x = y = 0;
            wxPrintout_GetPPIScreen(wxObject, ref x, ref y);
        }

        //-----------------------------------------------------------------------------

        public void SetPPIPrinter(int x, int y)
        {
            wxPrintout_SetPPIPrinter(wxObject, x, y);
        }

        //-----------------------------------------------------------------------------

        public void GetPPIPrinter(out int x, out int y)
        {
            x = y = 0;
            wxPrintout_GetPPIPrinter(wxObject, ref x, ref y);
        }

        //-----------------------------------------------------------------------------

        public bool IsPreview
        {
            get { return wxPrintout_IsPreview(wxObject); }
            set { wxPrintout_SetIsPreview(wxObject, value); }
        }
    }
}

