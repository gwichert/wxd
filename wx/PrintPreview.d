//-----------------------------------------------------------------------------
// wx.NET - PrintPreview.cs
//
// The wxPrintPreview wrapper class.
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
    public class PrintPreview : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxPrintPreview_ctor(IntPtr printout, IntPtr printoutForPrinting, IntPtr data);
        [DllImport("wx-c")] static extern IntPtr wxPrintPreview_ctorPrintData(IntPtr printout, IntPtr printoutForPrinting, IntPtr data);
        [DllImport("wx-c")] static extern bool   wxPrintPreview_SetCurrentPage(IntPtr self, int pageNum);
        [DllImport("wx-c")] static extern int    wxPrintPreview_GetCurrentPage(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintPreview_SetPrintout(IntPtr self, IntPtr printout);
        [DllImport("wx-c")] static extern IntPtr wxPrintPreview_GetPrintout(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintPreview_GetPrintoutForPrinting(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintPreview_SetFrame(IntPtr self, IntPtr frame);
        [DllImport("wx-c")] static extern void   wxPrintPreview_SetCanvas(IntPtr self, IntPtr canvas);
        [DllImport("wx-c")] static extern IntPtr wxPrintPreview_GetFrame(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintPreview_GetCanvas(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxPrintPreview_PaintPage(IntPtr self, IntPtr canvas, IntPtr dc);
        [DllImport("wx-c")] static extern bool   wxPrintPreview_DrawBlankPage(IntPtr self, IntPtr canvas, IntPtr dc);
        [DllImport("wx-c")] static extern bool   wxPrintPreview_RenderPage(IntPtr self, int pageNum);
        [DllImport("wx-c")] static extern IntPtr wxPrintPreview_GetPrintDialogData(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintPreview_SetZoom(IntPtr self, int percent);
        [DllImport("wx-c")] static extern int    wxPrintPreview_GetZoom(IntPtr self);
        [DllImport("wx-c")] static extern int    wxPrintPreview_GetMaxPage(IntPtr self);
        [DllImport("wx-c")] static extern int    wxPrintPreview_GetMinPage(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxPrintPreview_Ok(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPrintPreview_SetOk(IntPtr self, bool ok);
        [DllImport("wx-c")] static extern bool   wxPrintPreview_Print(IntPtr self, bool interactive);
        [DllImport("wx-c")] static extern void   wxPrintPreview_DetermineScaling(IntPtr self);

        //-----------------------------------------------------------------------------

        internal PrintPreview(IntPtr wxObject)
            : base(wxObject) { }

        public PrintPreview(Printout printout, Printout printoutForPrinting, PrintDialogData data)
            : this(wxPrintPreview_ctor(Object.SafePtr(printout), Object.SafePtr(printoutForPrinting), Object.SafePtr(data))) { }

        public PrintPreview(Printout printout, Printout printoutForPrinting)
            : this(printout, printoutForPrinting, (PrintData)null) { }
        public PrintPreview(Printout printout, Printout printoutForPrinting, PrintData data)
            : this(wxPrintPreview_ctor(Object.SafePtr(printout), Object.SafePtr(printoutForPrinting), Object.SafePtr(data))) { }

        //-----------------------------------------------------------------------------

        public bool SetCurrentPage(int pageNum)
        {
            return wxPrintPreview_SetCurrentPage(wxObject, pageNum);
        }

        public int CurrentPage
        {
            get { return wxPrintPreview_GetCurrentPage(wxObject); }
            set { SetCurrentPage(value); }
        }

        //-----------------------------------------------------------------------------

        public Printout Printout
        {
            set { wxPrintPreview_SetPrintout(wxObject, Object.SafePtr(value)); }
            get { return (Printout)FindObject(wxPrintPreview_GetPrintout(wxObject), typeof(Printout)); }
        }

        //-----------------------------------------------------------------------------

        public Printout PrintoutForPrinting
        {
            get { return (Printout)FindObject(wxPrintPreview_GetPrintoutForPrinting(wxObject), typeof(Printout)); }
        }

        //-----------------------------------------------------------------------------

        public Frame Frame
        {
            set { wxPrintPreview_SetFrame(wxObject, Object.SafePtr(value)); }
            get { return (Frame)FindObject(wxPrintPreview_GetFrame(wxObject), typeof(Frame)); }
        }

        //-----------------------------------------------------------------------------

        public Window Canvas
        {
            get { return (Window)FindObject(wxPrintPreview_GetCanvas(wxObject), typeof(Window)); }
            set { wxPrintPreview_SetCanvas(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public bool PaintPage(Window canvas, ref DC dc)
        {
            return wxPrintPreview_PaintPage(wxObject, Object.SafePtr(canvas), Object.SafePtr(dc));
        }

        //-----------------------------------------------------------------------------

        public bool DrawBlankPage(Window canvas, ref DC dc)
        {
            return wxPrintPreview_DrawBlankPage(wxObject, Object.SafePtr(canvas), Object.SafePtr(dc));
        }

        //-----------------------------------------------------------------------------

        public bool RenderPage(int pageNum)
        {
            return wxPrintPreview_RenderPage(wxObject, pageNum);
        }

        //-----------------------------------------------------------------------------

        public PrintDialogData PrintDialogData
        {
            get { return (PrintDialogData)FindObject(wxPrintPreview_GetPrintDialogData(wxObject), typeof(PrintDialogData)); }
        }

        //-----------------------------------------------------------------------------

        public int Zoom
        {
            set { wxPrintPreview_SetZoom(wxObject, value); }
            get { return wxPrintPreview_GetZoom(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int MaxPage
        {
            get { return wxPrintPreview_GetMaxPage(wxObject); }
        }

        public int MinPage
        {
            get { return wxPrintPreview_GetMinPage(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool Ok
        {
            get { return wxPrintPreview_Ok(wxObject); }
            set { wxPrintPreview_SetOk(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool Print(bool interactive)
        {
            return wxPrintPreview_Print(wxObject, interactive);
        }

        //-----------------------------------------------------------------------------

        public void DetermineScaling()
        {
            wxPrintPreview_DetermineScaling(wxObject);
        }
    }

    public class PreviewFrame : Frame
    {
        [DllImport("wx-c")] static extern IntPtr wxPreviewFrame_ctor(IntPtr preview, IntPtr parent, string title, ref Point pos, ref Size size, uint style, string name);
        [DllImport("wx-c")] static extern void   wxPreviewFrame_Initialize(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPreviewFrame_CreateCanvas(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPreviewFrame_CreateControlBar(IntPtr self);

        //-----------------------------------------------------------------------------

        internal PreviewFrame(IntPtr wxObject) 
            : base(wxObject) { }

        public PreviewFrame(PrintPreview preview, Frame parent, string title)
            : this(preview, parent, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "PreviewFrame") { }
        public PreviewFrame(PrintPreview preview, Frame parent, string title, Point pos)
            : this(preview, parent, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "PreviewFrame") { }
        public PreviewFrame(PrintPreview preview, Frame parent, string title, Point pos, Size size)
            : this(preview, parent, title, pos, size, wxDEFAULT_FRAME_STYLE, "PreviewFrame") { }
        public PreviewFrame(PrintPreview preview, Frame parent, string title, Point pos, Size size, long style)
            : this(preview, parent, title, pos, size, style, "PreviewFrame") { }
        public PreviewFrame(PrintPreview preview, Frame parent, string title, Point pos, Size size, long style, string name)
            : this(wxPreviewFrame_ctor(Object.SafePtr(preview), Object.SafePtr(parent), title, ref pos, ref size, (uint)style, name)) { }

        //-----------------------------------------------------------------------------

        public void Initialize()
        {
            wxPreviewFrame_Initialize(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void CreateCanvas()
        {
            wxPreviewFrame_CreateCanvas(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void CreateControlBar()
        {
            wxPreviewFrame_CreateControlBar(wxObject);
        }
    }

    public class PreviewControlBar : Panel
    {
        [DllImport("wx-c")] static extern IntPtr wxPreviewControlBar_ctor(IntPtr preview, int buttons, IntPtr parent, ref Point pos, ref Size size, uint style, string name);
        [DllImport("wx-c")] static extern void   wxPreviewControlBar_CreateButtons(IntPtr self);
        [DllImport("wx-c")] static extern void   wxPreviewControlBar_SetZoomControl(IntPtr self, int zoom);
        [DllImport("wx-c")] static extern int    wxPreviewControlBar_GetZoomControl(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPreviewControlBar_GetPrintPreview(IntPtr self);

        //-----------------------------------------------------------------------------

        internal PreviewControlBar(IntPtr wxObject)
            : base(wxObject) { }

        public PreviewControlBar(PrintPreview preview, int buttons, Window parent)
            : this(preview, buttons, parent, wxDefaultPosition, wxDefaultSize, 0, "PreviewControlBar") { }
        public PreviewControlBar(PrintPreview preview, int buttons, Window parent, Point pos)
            : this(preview, buttons, parent, pos, wxDefaultSize, 0, "PreviewControlBar") { }
        public PreviewControlBar(PrintPreview preview, int buttons, Window parent, Point pos, Size size)
            : this(preview, buttons, parent, pos, size, 0, "PreviewControlBar") { }
        public PreviewControlBar(PrintPreview preview, int buttons, Window parent, Point pos, Size size, long style)
            : this(preview, buttons, parent, pos, size, style, "PreviewControlBar") { }
        public PreviewControlBar(PrintPreview preview, int buttons, Window parent, Point pos, Size size, long style, string name)
            : this(wxPreviewControlBar_ctor(Object.SafePtr(preview), buttons, Object.SafePtr(parent), ref pos, ref size, (uint)style, name)) { }

        //-----------------------------------------------------------------------------

        public void CreateButtons()
        {
            wxPreviewControlBar_CreateButtons(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int ZoomControl
        {
            get { return wxPreviewControlBar_GetZoomControl(wxObject); }
            set { wxPreviewControlBar_SetZoomControl(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public PrintPreview PrintPreview
        {
            get { return (PrintPreview)FindObject(wxPreviewControlBar_GetPrintPreview(wxObject), typeof(PrintPreview)); }
        }
    }

    public class PreviewCanvas : ScrolledWindow
    {
        [DllImport("wx-c")] static extern IntPtr wxPreviewCanvas_ctor(IntPtr preview, IntPtr parent, ref Point pos, ref Size size, uint style, string name);

        //-----------------------------------------------------------------------------

        internal PreviewCanvas(IntPtr wxObject) 
            : base(wxObject) { }

        public PreviewCanvas(PrintPreview preview, Window parent)
            : this(preview, parent, wxDefaultPosition, wxDefaultSize, 0, "PreviewCanvas") { }
        public PreviewCanvas(PrintPreview preview, Window parent, Point pos)
            : this(preview, parent, pos, wxDefaultSize, 0, "PreviewCanvas") { }
        public PreviewCanvas(PrintPreview preview, Window parent, Point pos, Size size, long style)
            : this(preview, parent, pos, size, style, "PreviewCanvas") { }
        public PreviewCanvas(PrintPreview preview, Window parent, Point pos, Size size, long style, string name)
            : this(wxPreviewCanvas_ctor(Object.SafePtr(preview), Object.SafePtr(parent), ref pos, ref size, (uint)style, name)) { }
    }
}
