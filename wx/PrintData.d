//-----------------------------------------------------------------------------
// wx.NET - PrintData.cs
//
// The wxPrint data wrapper classes.
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
    public enum PrintMode
    {
        wxPRINT_MODE_NONE =    0,
        wxPRINT_MODE_PREVIEW = 1,   // Preview in external application
        wxPRINT_MODE_FILE =    2,   // Print to file
        wxPRINT_MODE_PRINTER = 3    // Send to printer
    }

    public enum PrintQuality
    {
        wxPRINT_QUALITY_HIGH    = -1,
        wxPRINT_QUALITY_MEDIUM  = -2,
        wxPRINT_QUALITY_LOW     = -3,
        wxPRINT_QUALITY_DRAFT   = -4
    }

    public enum DuplexMode
    {
        wxDUPLEX_SIMPLEX, 
        wxDUPLEX_HORIZONTAL,
        wxDUPLEX_VERTICAL
    }

    public enum PaperSize 
    {
        wxPAPER_NONE,               // Use specific dimensions
        wxPAPER_LETTER,             // Letter, 8 1/2 by 11 inches
        wxPAPER_LEGAL,              // Legal, 8 1/2 by 14 inches
        wxPAPER_A4,                 // A4 Sheet, 210 by 297 millimeters
        wxPAPER_CSHEET,             // C Sheet, 17 by 22 inches
        wxPAPER_DSHEET,             // D Sheet, 22 by 34 inches
        wxPAPER_ESHEET,             // E Sheet, 34 by 44 inches
        wxPAPER_LETTERSMALL,        // Letter Small, 8 1/2 by 11 inches
        wxPAPER_TABLOID,            // Tabloid, 11 by 17 inches
        wxPAPER_LEDGER,             // Ledger, 17 by 11 inches
        wxPAPER_STATEMENT,          // Statement, 5 1/2 by 8 1/2 inches
        wxPAPER_EXECUTIVE,          // Executive, 7 1/4 by 10 1/2 inches
        wxPAPER_A3,                 // A3 sheet, 297 by 420 millimeters
        wxPAPER_A4SMALL,            // A4 small sheet, 210 by 297 millimeters
        wxPAPER_A5,                 // A5 sheet, 148 by 210 millimeters
        wxPAPER_B4,                 // B4 sheet, 250 by 354 millimeters
        wxPAPER_B5,                 // B5 sheet, 182-by-257-millimeter paper
        wxPAPER_FOLIO,              // Folio, 8-1/2-by-13-inch paper
        wxPAPER_QUARTO,             // Quarto, 215-by-275-millimeter paper
        wxPAPER_10X14,              // 10-by-14-inch sheet
        wxPAPER_11X17,              // 11-by-17-inch sheet
        wxPAPER_NOTE,               // Note, 8 1/2 by 11 inches
        wxPAPER_ENV_9,              // #9 Envelope, 3 7/8 by 8 7/8 inches
        wxPAPER_ENV_10,             // #10 Envelope, 4 1/8 by 9 1/2 inches
        wxPAPER_ENV_11,             // #11 Envelope, 4 1/2 by 10 3/8 inches
        wxPAPER_ENV_12,             // #12 Envelope, 4 3/4 by 11 inches
        wxPAPER_ENV_14,             // #14 Envelope, 5 by 11 1/2 inches
        wxPAPER_ENV_DL,             // DL Envelope, 110 by 220 millimeters
        wxPAPER_ENV_C5,             // C5 Envelope, 162 by 229 millimeters
        wxPAPER_ENV_C3,             // C3 Envelope, 324 by 458 millimeters
        wxPAPER_ENV_C4,             // C4 Envelope, 229 by 324 millimeters
        wxPAPER_ENV_C6,             // C6 Envelope, 114 by 162 millimeters
        wxPAPER_ENV_C65,            // C65 Envelope, 114 by 229 millimeters
        wxPAPER_ENV_B4,             // B4 Envelope, 250 by 353 millimeters
        wxPAPER_ENV_B5,             // B5 Envelope, 176 by 250 millimeters
        wxPAPER_ENV_B6,             // B6 Envelope, 176 by 125 millimeters
        wxPAPER_ENV_ITALY,          // Italy Envelope, 110 by 230 millimeters
        wxPAPER_ENV_MONARCH,        // Monarch Envelope, 3 7/8 by 7 1/2 inches
        wxPAPER_ENV_PERSONAL,       // 6 3/4 Envelope, 3 5/8 by 6 1/2 inches
        wxPAPER_FANFOLD_US,         // US Std Fanfold, 14 7/8 by 11 inches
        wxPAPER_FANFOLD_STD_GERMAN, // German Std Fanfold, 8 1/2 by 12 inches
        wxPAPER_FANFOLD_LGL_GERMAN, // German Legal Fanfold, 8 1/2 by 13 inches

        wxPAPER_ISO_B4,             // B4 (ISO) 250 x 353 mm
        wxPAPER_JAPANESE_POSTCARD,  // Japanese Postcard 100 x 148 mm
        wxPAPER_9X11,               // 9 x 11 in
        wxPAPER_10X11,              // 10 x 11 in
        wxPAPER_15X11,              // 15 x 11 in
        wxPAPER_ENV_INVITE,         // Envelope Invite 220 x 220 mm
        wxPAPER_LETTER_EXTRA,       // Letter Extra 9 \275 x 12 in
        wxPAPER_LEGAL_EXTRA,        // Legal Extra 9 \275 x 15 in
        wxPAPER_TABLOID_EXTRA,      // Tabloid Extra 11.69 x 18 in
        wxPAPER_A4_EXTRA,           // A4 Extra 9.27 x 12.69 in
        wxPAPER_LETTER_TRANSVERSE,  // Letter Transverse 8 \275 x 11 in
        wxPAPER_A4_TRANSVERSE,      // A4 Transverse 210 x 297 mm
        wxPAPER_LETTER_EXTRA_TRANSVERSE, // Letter Extra Transverse 9\275 x 12 in
        wxPAPER_A_PLUS,             // SuperA/SuperA/A4 227 x 356 mm
        wxPAPER_B_PLUS,             // SuperB/SuperB/A3 305 x 487 mm
        wxPAPER_LETTER_PLUS,        // Letter Plus 8.5 x 12.69 in
        wxPAPER_A4_PLUS,            // A4 Plus 210 x 330 mm
        wxPAPER_A5_TRANSVERSE,      // A5 Transverse 148 x 210 mm
        wxPAPER_B5_TRANSVERSE,      // B5 (JIS) Transverse 182 x 257 mm
        wxPAPER_A3_EXTRA,           // A3 Extra 322 x 445 mm
        wxPAPER_A5_EXTRA,           // A5 Extra 174 x 235 mm
        wxPAPER_B5_EXTRA,           // B5 (ISO) Extra 201 x 276 mm
        wxPAPER_A2,                 // A2 420 x 594 mm
        wxPAPER_A3_TRANSVERSE,      // A3 Transverse 297 x 420 mm
        wxPAPER_A3_EXTRA_TRANSVERSE // A3 Extra Transverse 322 x 445 mm
    }

    public class PageSetupDialogData : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxPageSetupDialogData_ctor();
        [DllImport("wx-c")] static extern IntPtr wxPageSetupDialogData_ctorPrintSetup(IntPtr dialogData);
        [DllImport("wx-c")] static extern IntPtr wxPageSetupDialogData_ctorPrintData(IntPtr printData);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_GetPaperSize(IntPtr self, ref Size size);
        [DllImport("wx-c")] static extern int wxPageSetupDialogData_GetPaperId(IntPtr self);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_GetMinMarginTopLeft(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_GetMinMarginBottomRight(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_GetMarginTopLeft(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_GetMarginBottomRight(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_GetDefaultMinMargins(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_GetEnableMargins(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_GetEnableOrientation(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_GetEnablePaper(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_GetEnablePrinter(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_GetDefaultInfo(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_GetEnableHelp(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPageSetupDialogData_Ok(IntPtr self);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetPaperSize(IntPtr self, ref Size sz);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetPaperId(IntPtr self, int id);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetPaperSize(IntPtr self, int id);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetMinMarginTopLeft(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetMinMarginBottomRight(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetMarginTopLeft(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetMarginBottomRight(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetDefaultMinMargins(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetDefaultInfo(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_EnableMargins(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_EnableOrientation(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_EnablePaper(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_EnablePrinter(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_EnableHelp(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_CalculateIdFromPaperSize(IntPtr self);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_CalculatePaperSizeFromId(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPageSetupDialogData_GetPrintData(IntPtr self);
        [DllImport("wx-c")] static extern void wxPageSetupDialogData_SetPrintData(IntPtr self, IntPtr printData);

        //-----------------------------------------------------------------------------

        public PageSetupDialogData(IntPtr wxObject) 
            : base(wxObject) { }

        public PageSetupDialogData()
            : this(wxPageSetupDialogData_ctor()) { }
        public  PageSetupDialogData(PageSetupDialogData dialogData)
            : this(wxPageSetupDialogData_ctorPrintSetup(Object.SafePtr(dialogData))) { }
        public  PageSetupDialogData(PrintData printData)
            : this(wxPageSetupDialogData_ctorPrintData(Object.SafePtr(printData))) { }

        //-----------------------------------------------------------------------------

        public Size PaperSize
        {
            get { 
                Size size = new Size();
                wxPageSetupDialogData_GetPaperSize(wxObject, ref size);
                return size;
            }
            set { wxPageSetupDialogData_SetPaperSize(wxObject, ref value); }
        }

        public PaperSize PaperId
        {
            get { return (PaperSize)wxPageSetupDialogData_GetPaperId(wxObject); }
            set { wxPageSetupDialogData_SetPaperId(wxObject, (int)value); }
        }

        //-----------------------------------------------------------------------------

        public Point MinMarginTopLeft
        {
            get { 
                Point pt = new Point();
                wxPageSetupDialogData_GetMinMarginTopLeft(wxObject, ref pt);
                return pt;
            }
            set { wxPageSetupDialogData_SetMinMarginTopLeft(wxObject, ref value); }
        }

        public Point MinMarginBottomRight
        {
            get { 
                Point pt = new Point();
                wxPageSetupDialogData_GetMinMarginBottomRight(wxObject, ref pt);
                return pt;
            }
            set { wxPageSetupDialogData_SetMinMarginBottomRight(wxObject, ref value); }
        }

        public Point MarginTopLeft
        {
            get { 
                Point pt = new Point();
                wxPageSetupDialogData_GetMarginTopLeft(wxObject, ref pt);
                return pt;
            }
            set { wxPageSetupDialogData_SetMarginTopLeft(wxObject, ref value); }
        }

        public Point MarginBottomRight
        {
            get {
                Point pt = new Point();
                wxPageSetupDialogData_GetMarginBottomRight(wxObject, ref pt);
                return pt;
            } 
            set { wxPageSetupDialogData_SetMarginBottomRight(wxObject, ref value); }
        }

        //-----------------------------------------------------------------------------

        public bool DefaultMinMargins
        {
            get { return wxPageSetupDialogData_GetDefaultMinMargins(wxObject); }
            set { wxPageSetupDialogData_SetDefaultMinMargins(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool EnableOrientation
        {
            get { return wxPageSetupDialogData_GetEnableOrientation(wxObject); }
            set { wxPageSetupDialogData_EnableOrientation(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool EnablePaper
        {
            get { return wxPageSetupDialogData_GetEnablePaper(wxObject); }
            set { wxPageSetupDialogData_EnablePaper(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool EnablePrinter
        {
            get { return wxPageSetupDialogData_GetEnablePrinter(wxObject); }
            set { wxPageSetupDialogData_EnablePrinter(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool DefaultInfo
        {
            get { return wxPageSetupDialogData_GetDefaultInfo(wxObject); }
            set { wxPageSetupDialogData_SetDefaultInfo(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool EnableHelp
        {
            get { return wxPageSetupDialogData_GetEnableHelp(wxObject); }
            set { wxPageSetupDialogData_EnableHelp(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool Ok()
        {
            return wxPageSetupDialogData_Ok(wxObject);
        }

        //-----------------------------------------------------------------------------

        public bool EnableMargins
        {
            get { return wxPageSetupDialogData_GetEnableMargins(wxObject); }
            set { wxPageSetupDialogData_EnableMargins(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void CalculateIdFromPaperSize()
        {
            wxPageSetupDialogData_CalculateIdFromPaperSize(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void CalculatePaperSizeFromId()
        {
            wxPageSetupDialogData_CalculatePaperSizeFromId(wxObject);
        }

        //-----------------------------------------------------------------------------

        public PrintData PrintData
        {
            get { return (PrintData)FindObject(wxPageSetupDialogData_GetPrintData(wxObject), typeof(PrintData)); }
            set { wxPageSetupDialogData_SetPrintData(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public static implicit operator PageSetupDialogData (PrintData data)
        {
            return new PageSetupDialogData(data);
        }
    }

    public class PrintDialogData : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxPrintDialogData_ctor();
        [DllImport("wx-c")] static extern IntPtr wxPrintDialogData_ctorDialogData(IntPtr dialogData);
        [DllImport("wx-c")] static extern IntPtr wxPrintDialogData_ctorPrintData(IntPtr printData);
        [DllImport("wx-c")] static extern int wxPrintDialogData_GetFromPage(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintDialogData_GetToPage(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintDialogData_GetMinPage(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintDialogData_GetMaxPage(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintDialogData_GetNoCopies(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetAllPages(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetSelection(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetCollate(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetPrintToFile(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetSetupDialog(IntPtr self);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetFromPage(IntPtr self, int v);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetToPage(IntPtr self, int v);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetMinPage(IntPtr self, int v);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetMaxPage(IntPtr self, int v);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetNoCopies(IntPtr self, int v);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetAllPages(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetSelection(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetCollate(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetPrintToFile(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetSetupDialog(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_EnablePrintToFile(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_EnableSelection(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_EnablePageNumbers(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintDialogData_EnableHelp(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetEnablePrintToFile(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetEnableSelection(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetEnablePageNumbers(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_GetEnableHelp(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintDialogData_Ok(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintDialogData_GetPrintData(IntPtr self);
        [DllImport("wx-c")] static extern void wxPrintDialogData_SetPrintData(IntPtr self, IntPtr printData);

        //-----------------------------------------------------------------------------

        public PrintDialogData(IntPtr wxObject)
            : base(wxObject) { }

        public PrintDialogData()
            : this(wxPrintDialogData_ctor()) { }
        public PrintDialogData(PrintDialogData dialogData)
            : this(wxPrintDialogData_ctorDialogData(Object.SafePtr(dialogData))) { }
        public PrintDialogData(PrintData printData)
            : this(wxPrintDialogData_ctorPrintData(Object.SafePtr(printData))) { }

        //-----------------------------------------------------------------------------

        public int FromPage
        {
            get { return wxPrintDialogData_GetFromPage(wxObject); }
            set { wxPrintDialogData_SetFromPage(wxObject, value); }
        }

        public int ToPage
        {
            get { return wxPrintDialogData_GetToPage(wxObject); }
            set { wxPrintDialogData_SetToPage(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int MinPage
        {
            get { return wxPrintDialogData_GetMinPage(wxObject); }
            set { wxPrintDialogData_SetMinPage(wxObject, value); }
        }

        public int MaxPage
        {
            get { return wxPrintDialogData_GetMaxPage(wxObject); }
            set { wxPrintDialogData_SetMaxPage(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int NoCopies
        {
            get { return wxPrintDialogData_GetNoCopies(wxObject); }
            set { wxPrintDialogData_SetNoCopies(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool AllPages
        {
            get { return wxPrintDialogData_GetAllPages(wxObject); }
            set { wxPrintDialogData_SetAllPages(wxObject, value); }
        }

        public bool Selection
        {
            get { return wxPrintDialogData_GetSelection(wxObject); }
            set { wxPrintDialogData_SetSelection(wxObject, value); }
        }

        public bool Collate
        {
            get { return wxPrintDialogData_GetCollate(wxObject); }
            set { wxPrintDialogData_SetCollate(wxObject, value); }
        }

        public bool PrintToFile
        {
            get { return wxPrintDialogData_GetPrintToFile(wxObject); }
            set { wxPrintDialogData_SetPrintToFile(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool SetupDialog
        {
            get { return wxPrintDialogData_GetSetupDialog(wxObject); }
            set { wxPrintDialogData_SetSetupDialog(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool EnablePrintToFile
        {
            set { wxPrintDialogData_EnablePrintToFile(wxObject, value); }
            get { return wxPrintDialogData_GetEnablePrintToFile(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool EnableSelection
        {
            set { wxPrintDialogData_EnableSelection(wxObject, value); }
            get { return wxPrintDialogData_GetEnableSelection(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool EnablePageNumbers
        {
            set { wxPrintDialogData_EnablePageNumbers(wxObject, value); }
            get { return wxPrintDialogData_GetEnablePageNumbers(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool EnableHelp
        {
            set { wxPrintDialogData_EnableHelp(wxObject, value); }
            get { return wxPrintDialogData_GetEnableHelp(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool Ok()
        {
            return wxPrintDialogData_Ok(wxObject);
        }

        //-----------------------------------------------------------------------------

        public PrintData PrintData
        {
            get { return (PrintData)FindObject(wxPrintDialogData_GetPrintData(wxObject), typeof(PrintData)); }
            set { wxPrintDialogData_SetPrintData(wxObject, Object.SafePtr(value)); }
        }
    }

    public class PrintData : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxPrintData_ctor();
        [DllImport("wx-c")] static extern IntPtr wxPrintData_ctorPrintData(IntPtr printData);
        [DllImport("wx-c")] static extern int wxPrintData_GetNoCopies(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintData_GetCollate(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintData_GetOrientation(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintData_Ok(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintData_GetPrinterName(IntPtr self);
        [DllImport("wx-c")] static extern bool wxPrintData_GetColour(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintData_GetDuplex(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintData_GetPaperId(IntPtr self);
        [DllImport("wx-c")] static extern void wxPrintData_GetPaperSize(IntPtr self, ref Size sz);
        [DllImport("wx-c")] static extern int wxPrintData_GetQuality(IntPtr self);
        [DllImport("wx-c")] static extern void wxPrintData_SetNoCopies(IntPtr self, int v);
        [DllImport("wx-c")] static extern void wxPrintData_SetCollate(IntPtr self, bool flag);
        [DllImport("wx-c")] static extern void wxPrintData_SetOrientation(IntPtr self, int orient);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterName(IntPtr self, string name);
        [DllImport("wx-c")] static extern void wxPrintData_SetColour(IntPtr self, bool colour);
        [DllImport("wx-c")] static extern void wxPrintData_SetDuplex(IntPtr self, int duplex);
        [DllImport("wx-c")] static extern void wxPrintData_SetPaperId(IntPtr self, int sizeId);
        [DllImport("wx-c")] static extern void wxPrintData_SetPaperSize(IntPtr self, ref Size sz);
        [DllImport("wx-c")] static extern void wxPrintData_SetQuality(IntPtr self, int quality);
        [DllImport("wx-c")] static extern IntPtr wxPrintData_GetPrinterCommand(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintData_GetPrinterOptions(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintData_GetPreviewCommand(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintData_GetFilename(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxPrintData_GetFontMetricPath(IntPtr self);
        [DllImport("wx-c")] static extern double wxPrintData_GetPrinterScaleX(IntPtr self);
        [DllImport("wx-c")] static extern double wxPrintData_GetPrinterScaleY(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintData_GetPrinterTranslateX(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintData_GetPrinterTranslateY(IntPtr self);
        [DllImport("wx-c")] static extern int wxPrintData_GetPrintMode(IntPtr self);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterCommand(IntPtr self, string command);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterOptions(IntPtr self, string options);
        [DllImport("wx-c")] static extern void wxPrintData_SetPreviewCommand(IntPtr self, string command);
        [DllImport("wx-c")] static extern void wxPrintData_SetFilename(IntPtr self, string filename);
        [DllImport("wx-c")] static extern void wxPrintData_SetFontMetricPath(IntPtr self, string path);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterScaleX(IntPtr self, double x);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterScaleY(IntPtr self, double y);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterScaling(IntPtr self, double x, double y);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterTranslateX(IntPtr self, int x);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterTranslateY(IntPtr self, int y);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrinterTranslation(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern void wxPrintData_SetPrintMode(IntPtr self, int printMode);

        //-----------------------------------------------------------------------------

        public PrintData(IntPtr wxObject) 
            : base(wxObject) { }

        public PrintData()
            : this(wxPrintData_ctor()) { }
        public PrintData(PrintData printData)
            : this(wxPrintData_ctorPrintData(Object.SafePtr(printData))) { }

        //-----------------------------------------------------------------------------

        public int NoCopies
        {
            get { return wxPrintData_GetNoCopies(wxObject); }
            set { wxPrintData_SetNoCopies(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool Collate
        {
            get { return wxPrintData_GetCollate(wxObject); }
            set { wxPrintData_SetCollate(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Orientation
        {
            get { return wxPrintData_GetOrientation(wxObject); }
            set { wxPrintData_SetOrientation(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool Ok()
        {
            return wxPrintData_Ok(wxObject);
        }

        //-----------------------------------------------------------------------------

        public string PrinterName
        {
            get { return new wxString(wxPrintData_GetPrinterName(wxObject), true); }
            set { wxPrintData_SetPrinterName(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool Colour
        {
            get { return wxPrintData_GetColour(wxObject); }
            set { wxPrintData_SetColour(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public DuplexMode Duplex
        {
            get { return (DuplexMode)wxPrintData_GetDuplex(wxObject); }
            set { wxPrintData_SetDuplex(wxObject, (int)value); }
        }

        //-----------------------------------------------------------------------------

        public PaperSize PaperId
        {
            get { return (PaperSize)wxPrintData_GetPaperId(wxObject); }
            set { wxPrintData_SetPaperId(wxObject, (int)value); }
        }

        //-----------------------------------------------------------------------------

        public Size PaperSize
        {
            get { 
                Size sz = new Size();
                wxPrintData_GetPaperSize(wxObject, ref sz);
                return sz;
            }
            set { wxPrintData_SetPaperSize(wxObject, ref value); }
        }

        //-----------------------------------------------------------------------------

        public PrintQuality Quality
        {
            get { return (PrintQuality)wxPrintData_GetQuality(wxObject); }
            set { wxPrintData_SetQuality(wxObject, (int)value); }
        }

        //-----------------------------------------------------------------------------

        public string PrinterCommand
        {
            get { return new wxString(wxPrintData_GetPrinterCommand(wxObject), true); }
            set { wxPrintData_SetPrinterCommand(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public string PrinterOptions
        {
            get { return new wxString(wxPrintData_GetPrinterOptions(wxObject), true); }
            set { wxPrintData_SetPrinterOptions(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public string PreviewCommand
        {
            get { return new wxString(wxPrintData_GetPreviewCommand(wxObject), true); }
            set { wxPrintData_SetPreviewCommand(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public string Filename
        {
            get { return new wxString(wxPrintData_GetFilename(wxObject), true); }
            set { wxPrintData_SetFilename(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public string FontMetricPath
        {
            get { return new wxString(wxPrintData_GetFontMetricPath(wxObject), true); }
            set { wxPrintData_SetFontMetricPath(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public double PrinterScaleX
        {
            get { return wxPrintData_GetPrinterScaleX(wxObject); }
            set { wxPrintData_SetPrinterScaleX(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public double PrinterScaleY
        {
            get { return wxPrintData_GetPrinterScaleY(wxObject); }
            set { wxPrintData_SetPrinterScaleY(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int PrinterTranslateX
        {
            get { return wxPrintData_GetPrinterTranslateX(wxObject); }
            set { wxPrintData_SetPrinterTranslateX(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int PrinterTranslateY
        {
            get { return wxPrintData_GetPrinterTranslateY(wxObject); }
            set { wxPrintData_SetPrinterTranslateY(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public PrintMode PrintMode
        {
            get { return (PrintMode)wxPrintData_GetPrintMode(wxObject); }
            set { wxPrintData_SetPrintMode(wxObject, (int)value); }
        }

        //-----------------------------------------------------------------------------

        public void SetPrinterScaling(double x, double y)
        {
            wxPrintData_SetPrinterScaling(wxObject, x, y);
        }

        //-----------------------------------------------------------------------------

        public void SetPrinterTranslation(int x, int y)
        {
            wxPrintData_SetPrinterTranslation(wxObject, x, y);
        }
    }
}

