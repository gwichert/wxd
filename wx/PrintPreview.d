//-----------------------------------------------------------------------------
// wxD - PrintPreview.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.PrintPreview;
import wx.common;
import wx.Panel;
import wx.Frame;
import wx.ScrolledWindow;
import wx.PrintData;
import wx.Printer;

        static extern (C) IntPtr wxPrintPreview_ctor(IntPtr printout, IntPtr printoutForPrinting, IntPtr data);
        static extern (C) IntPtr wxPrintPreview_ctorPrintData(IntPtr printout, IntPtr printoutForPrinting, IntPtr data);
        static extern (C) bool   wxPrintPreview_SetCurrentPage(IntPtr self, int pageNum);
        static extern (C) int    wxPrintPreview_GetCurrentPage(IntPtr self);
        static extern (C) void   wxPrintPreview_SetPrintout(IntPtr self, IntPtr printout);
        static extern (C) IntPtr wxPrintPreview_GetPrintout(IntPtr self);
        static extern (C) IntPtr wxPrintPreview_GetPrintoutForPrinting(IntPtr self);
        static extern (C) void   wxPrintPreview_SetFrame(IntPtr self, IntPtr frame);
        static extern (C) void   wxPrintPreview_SetCanvas(IntPtr self, IntPtr canvas);
        static extern (C) IntPtr wxPrintPreview_GetFrame(IntPtr self);
        static extern (C) IntPtr wxPrintPreview_GetCanvas(IntPtr self);
        static extern (C) bool   wxPrintPreview_PaintPage(IntPtr self, IntPtr canvas, IntPtr dc);
        static extern (C) bool   wxPrintPreview_DrawBlankPage(IntPtr self, IntPtr canvas, IntPtr dc);
        static extern (C) bool   wxPrintPreview_RenderPage(IntPtr self, int pageNum);
        static extern (C) IntPtr wxPrintPreview_GetPrintDialogData(IntPtr self);
        static extern (C) void   wxPrintPreview_SetZoom(IntPtr self, int percent);
        static extern (C) int    wxPrintPreview_GetZoom(IntPtr self);
        static extern (C) int    wxPrintPreview_GetMaxPage(IntPtr self);
        static extern (C) int    wxPrintPreview_GetMinPage(IntPtr self);
        static extern (C) bool   wxPrintPreview_Ok(IntPtr self);
        static extern (C) void   wxPrintPreview_SetOk(IntPtr self, bool ok);
        static extern (C) bool   wxPrintPreview_Print(IntPtr self, bool interactive);
        static extern (C) void   wxPrintPreview_DetermineScaling(IntPtr self);

        //-----------------------------------------------------------------------------

    public class PrintPreview : wxObject
    {
        private this(IntPtr wxobj)
            { super(wxobj); }

        public this(Printout printout, Printout printoutForPrinting, PrintDialogData data)
            { this(wxPrintPreview_ctor(wxObject.SafePtr(printout), wxObject.SafePtr(printoutForPrinting), wxObject.SafePtr(data))); }

        public this(Printout printout, Printout printoutForPrinting)
            { this(printout, printoutForPrinting, cast(PrintData)null); }
        public this(Printout printout, Printout printoutForPrinting, PrintData data)
            { this(wxPrintPreview_ctor(wxObject.SafePtr(printout), wxObject.SafePtr(printoutForPrinting), wxObject.SafePtr(data))); }

	public static wxObject New(IntPtr ptr) { return new PrintPreview(ptr); }
        //-----------------------------------------------------------------------------

        public bool SetCurrentPage(int pageNum)
        {
            return wxPrintPreview_SetCurrentPage(wxobj, pageNum);
        }

        public int CurrentPage() { return wxPrintPreview_GetCurrentPage(wxobj); }
        public void CurrentPage(int value) { SetCurrentPage(value); }

        //-----------------------------------------------------------------------------

        public void printout(Printout value) { wxPrintPreview_SetPrintout(wxobj, wxObject.SafePtr(value)); }
        public Printout printout() { return cast(Printout)FindObject(wxPrintPreview_GetPrintout(wxobj)/*, &Printout.New*/); }

        //-----------------------------------------------------------------------------

        public Printout PrintoutForPrinting() { return cast(Printout)FindObject(wxPrintPreview_GetPrintoutForPrinting(wxobj)/*, &Printout.New*/); }

        //-----------------------------------------------------------------------------

        public void frame(Frame value) { wxPrintPreview_SetFrame(wxobj, wxObject.SafePtr(value)); }
        public Frame frame() { return cast(Frame)FindObject(wxPrintPreview_GetFrame(wxobj), &Frame.New); }

        //-----------------------------------------------------------------------------

        public Window Canvas() { return cast(Window)FindObject(wxPrintPreview_GetCanvas(wxobj), &Window.New); }
        public void Canvas(Window value) { wxPrintPreview_SetCanvas(wxobj, wxObject.SafePtr(value)); }

        //-----------------------------------------------------------------------------

        public bool PaintPage(Window canvas, inout DC dc)
        {
            return wxPrintPreview_PaintPage(wxobj, wxObject.SafePtr(canvas), wxObject.SafePtr(dc));
        }

        //-----------------------------------------------------------------------------

        public bool DrawBlankPage(Window canvas, inout DC dc)
        {
            return wxPrintPreview_DrawBlankPage(wxobj, wxObject.SafePtr(canvas), wxObject.SafePtr(dc));
        }

        //-----------------------------------------------------------------------------

        public bool RenderPage(int pageNum)
        {
            return wxPrintPreview_RenderPage(wxobj, pageNum);
        }

        //-----------------------------------------------------------------------------

        public PrintDialogData printDialogData() { return cast(PrintDialogData)FindObject(wxPrintPreview_GetPrintDialogData(wxobj), &PrintDialogData.New); }

        //-----------------------------------------------------------------------------

        public void Zoom(int value) { wxPrintPreview_SetZoom(wxobj, value); }
        public int Zoom() { return wxPrintPreview_GetZoom(wxobj); }

        //-----------------------------------------------------------------------------

        public int MaxPage() { return wxPrintPreview_GetMaxPage(wxobj); }

        public int MinPage() { return wxPrintPreview_GetMinPage(wxobj); }

        //-----------------------------------------------------------------------------

        public bool Ok() { return wxPrintPreview_Ok(wxobj); }
        public void Ok(bool value) { wxPrintPreview_SetOk(wxobj, value); }

        //-----------------------------------------------------------------------------

        public bool Print(bool interactive)
        {
            return wxPrintPreview_Print(wxobj, interactive);
        }

        //-----------------------------------------------------------------------------

        public void DetermineScaling()
        {
            wxPrintPreview_DetermineScaling(wxobj);
        }
    }

        static extern (C) IntPtr wxPreviewFrame_ctor(IntPtr preview, IntPtr parent, string title, inout Point pos, inout Size size, uint style, string name);
        static extern (C) void   wxPreviewFrame_Initialize(IntPtr self);
        static extern (C) void   wxPreviewFrame_CreateCanvas(IntPtr self);
        static extern (C) void   wxPreviewFrame_CreateControlBar(IntPtr self);

        //-----------------------------------------------------------------------------

    public class PreviewFrame : Frame
    {
        private this(IntPtr wxobj) 
            { super(wxobj); }

        public this(PrintPreview preview, Frame parent, string title)
            { this(preview, parent, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "PreviewFrame"); }
        public this(PrintPreview preview, Frame parent, string title, Point pos)
            { this(preview, parent, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "PreviewFrame"); }
        public this(PrintPreview preview, Frame parent, string title, Point pos, Size size)
            { this(preview, parent, title, pos, size, wxDEFAULT_FRAME_STYLE, "PreviewFrame"); }
        public this(PrintPreview preview, Frame parent, string title, Point pos, Size size, int style)
            { this(preview, parent, title, pos, size, style, "PreviewFrame"); }
        public this(PrintPreview preview, Frame parent, string title, Point pos, Size size, int style, string name)
            { this(wxPreviewFrame_ctor(wxObject.SafePtr(preview), wxObject.SafePtr(parent), title, pos, size, cast(uint)style, name)); }

        //-----------------------------------------------------------------------------

        public void Initialize()
        {
            wxPreviewFrame_Initialize(wxobj);
        }

        //-----------------------------------------------------------------------------

        public void CreateCanvas()
        {
            wxPreviewFrame_CreateCanvas(wxobj);
        }

        //-----------------------------------------------------------------------------

        public void CreateControlBar()
        {
            wxPreviewFrame_CreateControlBar(wxobj);
        }
    }

        static extern (C) IntPtr wxPreviewControlBar_ctor(IntPtr preview, int buttons, IntPtr parent, inout Point pos, inout Size size, uint style, string name);
        static extern (C) void   wxPreviewControlBar_CreateButtons(IntPtr self);
        static extern (C) void   wxPreviewControlBar_SetZoomControl(IntPtr self, int zoom);
        static extern (C) int    wxPreviewControlBar_GetZoomControl(IntPtr self);
        static extern (C) IntPtr wxPreviewControlBar_GetPrintPreview(IntPtr self);

        //-----------------------------------------------------------------------------

    public class PreviewControlBar : Panel
    {
        private this(IntPtr wxobj)
            { super(wxobj); }

        public this(PrintPreview preview, int buttons, Window parent)
            { this(preview, buttons, parent, wxDefaultPosition, wxDefaultSize, 0, "PreviewControlBar"); }
        public this(PrintPreview preview, int buttons, Window parent, Point pos)
            { this(preview, buttons, parent, pos, wxDefaultSize, 0, "PreviewControlBar"); }
        public this(PrintPreview preview, int buttons, Window parent, Point pos, Size size)
            { this(preview, buttons, parent, pos, size, 0, "PreviewControlBar"); }
        public this(PrintPreview preview, int buttons, Window parent, Point pos, Size size, int style)
            { this(preview, buttons, parent, pos, size, style, "PreviewControlBar"); }
        public this(PrintPreview preview, int buttons, Window parent, Point pos, Size size, int style, string name)
            { this(wxPreviewControlBar_ctor(wxObject.SafePtr(preview), buttons, wxObject.SafePtr(parent), pos, size, cast(uint)style, name)); }

        //-----------------------------------------------------------------------------

        public void CreateButtons()
        {
            wxPreviewControlBar_CreateButtons(wxobj);
        }

        //-----------------------------------------------------------------------------

        public int ZoomControl() { return wxPreviewControlBar_GetZoomControl(wxobj); }
        public void ZoomControl(int value) { wxPreviewControlBar_SetZoomControl(wxobj, value); }

        //-----------------------------------------------------------------------------

        public PrintPreview printPreview() { return cast(PrintPreview)FindObject(wxPreviewControlBar_GetPrintPreview(wxobj), &PrintPreview.New); }
    }

        static extern (C) IntPtr wxPreviewCanvas_ctor(IntPtr preview, IntPtr parent, inout Point pos, inout Size size, uint style, string name);

        //-----------------------------------------------------------------------------

    public class PreviewCanvas : ScrolledWindow
    {
        private this(IntPtr wxobj) 
            { super(wxobj); }

        public this(PrintPreview preview, Window parent)
            { this(preview, parent, wxDefaultPosition, wxDefaultSize, 0, "PreviewCanvas"); }
        public this(PrintPreview preview, Window parent, Point pos)
            { this(preview, parent, pos, wxDefaultSize, 0, "PreviewCanvas"); }
        public this(PrintPreview preview, Window parent, Point pos, Size size, int style)
            { this(preview, parent, pos, size, style, "PreviewCanvas"); }
        public this(PrintPreview preview, Window parent, Point pos, Size size, int style, string name)
            { this(wxPreviewCanvas_ctor(wxObject.SafePtr(preview), wxObject.SafePtr(parent), pos, size, cast(uint)style, name)); }
    }
