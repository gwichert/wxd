//-----------------------------------------------------------------------------
// wxD - printdata.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - printdata.cxx
//
// The wxPrint data classes proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/cmndata.h>
#include <wx/generic/prntdlgg.h>

#if wxUSE_POSTSCRIPT
#if WXWIN_COMPATIBILITY_2_4
    typedef wxPrintData PostScriptData;
    static wxPrintData* PSData(wxPrintData *self) { return self; }
#else
    typedef wxPostScriptPrintNativeData PostScriptData;
    static PostScriptData* PSData(wxPrintData *self) {
	wxPostScriptPrintNativeData* data = (wxPostScriptPrintNativeData*)
	wxCheckDynamicCast(self->GetNativeData(), CLASSINFO(wxPostScriptPrintNativeData));
	return data;
    }
#endif // WXWIN_COMPATIBILITY
#endif
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPageSetupDialogData* wxPageSetupDialogData_ctor()
{
    return new wxPageSetupDialogData();
}

extern "C" WXEXPORT
wxPageSetupDialogData* wxPageSetupDialogData_ctorPrintSetup(wxPageSetupDialogData* dialogData)
{
    return new wxPageSetupDialogData(*dialogData);
}

extern "C" WXEXPORT
wxPageSetupDialogData* wxPageSetupDialogData_ctorPrintData(wxPrintData* printData)
{
    return new wxPageSetupDialogData(*printData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_GetPaperSize(wxPageSetupDialogData* self, wxSize* size)
{
    *size = self->GetPaperSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPaperSize wxPageSetupDialogData_GetPaperId(wxPageSetupDialogData* self)
{
    return self->GetPaperId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_GetMinMarginTopLeft(wxPageSetupDialogData* self, wxPoint* pt)
{
    *pt = self->GetMinMarginTopLeft();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_GetMinMarginBottomRight(wxPageSetupDialogData* self, wxPoint* pt)
{
    *pt = self->GetMinMarginBottomRight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_GetMarginTopLeft(wxPageSetupDialogData* self, wxPoint* pt)
{
    *pt = self->GetMarginTopLeft();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_GetMarginBottomRight(wxPageSetupDialogData* self, wxPoint* pt)
{
    *pt = self->GetMarginBottomRight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_GetDefaultMinMargins(wxPageSetupDialogData* self)
{
    return self->GetDefaultMinMargins()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_GetEnableMargins(wxPageSetupDialogData* self)
{
    return self->GetEnableMargins()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_GetEnableOrientation(wxPageSetupDialogData* self)
{
    return self->GetEnableOrientation()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_GetEnablePaper(wxPageSetupDialogData* self)
{
    return self->GetEnablePaper()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_GetEnablePrinter(wxPageSetupDialogData* self)
{
    return self->GetEnablePrinter()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_GetDefaultInfo(wxPageSetupDialogData* self)
{
    return self->GetDefaultInfo()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_GetEnableHelp(wxPageSetupDialogData* self)
{
    return self->GetEnableHelp()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPageSetupDialogData_Ok(wxPageSetupDialogData* self)
{
    return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetPaperSizeSize(wxPageSetupDialogData* self, wxSize* sz)
{
    self->SetPaperSize(*sz);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetPaperId(wxPageSetupDialogData* self, wxPaperSize id)
{
    self->SetPaperId(id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetPaperSize(wxPageSetupDialogData* self, wxPaperSize id)
{
    self->SetPaperSize(id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetMinMarginTopLeft(wxPageSetupDialogData* self, wxPoint* pt)
{
    self->SetMinMarginTopLeft(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetMinMarginBottomRight(wxPageSetupDialogData* self, wxPoint* pt)
{
    self->SetMinMarginBottomRight(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetMarginTopLeft(wxPageSetupDialogData* self, wxPoint* pt)
{
    self->SetMarginTopLeft(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetMarginBottomRight(wxPageSetupDialogData* self, wxPoint* pt)
{
    self->SetMarginBottomRight(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetDefaultMinMargins(wxPageSetupDialogData* self, wxc_bool flag)
{
    self->SetDefaultMinMargins(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetDefaultInfo(wxPageSetupDialogData* self, wxc_bool flag)
{
    self->SetDefaultInfo(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnableMargins(wxPageSetupDialogData* self, wxc_bool flag)
{
    self->EnableMargins(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnableOrientation(wxPageSetupDialogData* self, wxc_bool flag)
{
    self->EnableOrientation(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnablePaper(wxPageSetupDialogData* self, wxc_bool flag)
{
    self->EnablePaper(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnablePrinter(wxPageSetupDialogData* self, wxc_bool flag)
{
    self->EnablePrinter(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnableHelp(wxPageSetupDialogData* self, wxc_bool flag)
{
    self->EnableHelp(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_CalculateIdFromPaperSize(wxPageSetupDialogData* self)
{
    self->CalculateIdFromPaperSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_CalculatePaperSizeFromId(wxPageSetupDialogData* self)
{
    self->CalculatePaperSizeFromId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintData* wxPageSetupDialogData_GetPrintData(wxPageSetupDialogData* self)
{
    return &(self->GetPrintData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetPrintData(wxPageSetupDialogData* self, wxPrintData* printData)
{
    self->SetPrintData(*printData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintDialogData* wxPrintDialogData_ctor()
{
    return new wxPrintDialogData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintDialogData* wxPrintDialogData_ctorDialogData(wxPrintDialogData* dialogData)
{
    return new wxPrintDialogData(*dialogData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintDialogData* wxPrintDialogData_ctorPrintData(wxPrintData* printData)
{
    return new wxPrintDialogData(*printData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintDialogData_GetFromPage(wxPrintDialogData* self)
{
    return self->GetFromPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintDialogData_GetToPage(wxPrintDialogData* self)
{
    return self->GetToPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintDialogData_GetMinPage(wxPrintDialogData* self)
{
    return self->GetMinPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintDialogData_GetMaxPage(wxPrintDialogData* self)
{
    return self->GetMaxPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintDialogData_GetNoCopies(wxPrintDialogData* self)
{
    return self->GetNoCopies();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetAllPages(wxPrintDialogData* self)
{
    return self->GetAllPages()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetSelection(wxPrintDialogData* self)
{
    return self->GetSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetCollate(wxPrintDialogData* self)
{
    return self->GetCollate()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetPrintToFile(wxPrintDialogData* self)
{
    return self->GetPrintToFile()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetSetupDialog(wxPrintDialogData* self)
{
#if WXWIN_COMPATIBILITY_2_4
    return self->GetSetupDialog()?1:0;
#else
    return false;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetFromPage(wxPrintDialogData* self, int v)
{
    self->SetFromPage(v);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetToPage(wxPrintDialogData* self, int v)
{
    self->SetToPage(v);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetMinPage(wxPrintDialogData* self, int v)
{
    self->SetMinPage(v);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetMaxPage(wxPrintDialogData* self, int v)
{
    self->SetMaxPage(v);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetNoCopies(wxPrintDialogData* self, int v)
{
    self->SetNoCopies(v);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetAllPages(wxPrintDialogData* self, wxc_bool flag)
{
    self->SetAllPages(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetSelection(wxPrintDialogData* self, wxc_bool flag)
{
    self->SetSelection(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetCollate(wxPrintDialogData* self, wxc_bool flag)
{
    self->SetCollate(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetPrintToFile(wxPrintDialogData* self, wxc_bool flag)
{
    self->SetPrintToFile(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetSetupDialog(wxPrintDialogData* self, wxc_bool flag)
{
#if WXWIN_COMPATIBILITY_2_4
    self->SetSetupDialog(flag);
#else
    (void) flag;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnablePrintToFile(wxPrintDialogData* self, wxc_bool flag)
{
    self->EnablePrintToFile(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnableSelection(wxPrintDialogData* self, wxc_bool flag)
{
    self->EnableSelection(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnablePageNumbers(wxPrintDialogData* self, wxc_bool flag)
{
    self->EnablePageNumbers(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnableHelp(wxPrintDialogData* self, wxc_bool flag)
{
    self->EnableHelp(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetEnablePrintToFile(wxPrintDialogData* self)
{
    return self->GetEnablePrintToFile()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetEnableSelection(wxPrintDialogData* self)
{
    return self->GetEnableSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetEnablePageNumbers(wxPrintDialogData* self)
{
    return self->GetEnablePageNumbers()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_GetEnableHelp(wxPrintDialogData* self)
{
    return self->GetEnableHelp()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintDialogData_Ok(wxPrintDialogData* self)
{
    return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintData* wxPrintDialogData_GetPrintData(wxPrintDialogData* self)
{
    return &(self->GetPrintData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetPrintData(wxPrintDialogData* self, wxPrintData* printData)
{
    self->SetPrintData(*printData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintData* wxPrintData_ctor()
{
    return new wxPrintData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintData* wxPrintData_ctorPrintData(wxPrintData* printData)
{
    return new wxPrintData(*printData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintData_GetNoCopies(wxPrintData* self)
{
    return self->GetNoCopies();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintData_GetCollate(wxPrintData* self)
{
    return self->GetCollate()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintData_GetOrientation(wxPrintData* self)
{
    return self->GetOrientation();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintData_Ok(wxPrintData* self)
{
    return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPrintData_GetPrinterName(wxPrintData* self)
{
    return new wxString(self->GetPrinterName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintData_GetColour(wxPrintData* self)
{
    return self->GetColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDuplexMode wxPrintData_GetDuplex(wxPrintData* self)
{
    return self->GetDuplex();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPaperSize wxPrintData_GetPaperId(wxPrintData* self)
{
    return self->GetPaperId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_GetPaperSize(wxPrintData* self, wxSize* size)
{
    *size = self->GetPaperSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintQuality wxPrintData_GetQuality(wxPrintData* self)
{
    return self->GetQuality();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetNoCopies(wxPrintData* self, int v)
{
    self->SetNoCopies(v);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetCollate(wxPrintData* self, wxc_bool flag)
{
    self->SetCollate(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetOrientation(wxPrintData* self, int orient)
{
    self->SetOrientation(orient);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterName(wxPrintData* self, wxc_string name)
{
    self->SetPrinterName(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetColour(wxPrintData* self, wxc_bool colour)
{
    self->SetColour(colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetDuplex(wxPrintData* self, wxDuplexMode duplex)
{
    self->SetDuplex(duplex);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPaperId(wxPrintData* self, wxPaperSize sizeId)
{
    self->SetPaperId(sizeId);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPaperSize(wxPrintData* self, wxSize* sz)
{
    self->SetPaperSize(*sz);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetQuality(wxPrintData* self, wxPrintQuality quality)
{
    self->SetQuality(quality);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPrintData_GetPrinterCommand(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return new wxString(data->GetPrinterCommand());
#endif
    return new wxString(wxString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPrintData_GetPrinterOptions(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return new wxString(data->GetPrinterOptions());
#endif
    return new wxString(wxString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPrintData_GetPreviewCommand(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return new wxString(data->GetPreviewCommand());
#endif
    return new wxString(wxString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPrintData_GetFilename(wxPrintData* self)
{
    return new wxString(self->GetFilename());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPrintData_GetFontMetricPath(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return new wxString(data->GetFontMetricPath());
#endif
    return new wxString(wxString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
double wxPrintData_GetPrinterScaleX(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return data->GetPrinterScaleX();
#endif
    return 1.0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
double wxPrintData_GetPrinterScaleY(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return data->GetPrinterScaleY();
#endif
    return 1.0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintData_GetPrinterTranslateX(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return data->GetPrinterTranslateX();
#endif
    return 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintData_GetPrinterTranslateY(wxPrintData* self)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    return data->GetPrinterTranslateY();
#endif
    return 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintMode wxPrintData_GetPrintMode(wxPrintData* self)
{
    return self->GetPrintMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterCommand(wxPrintData* self, wxc_string command)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterCommand(wxstr(command));
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterOptions(wxPrintData* self, wxc_string options)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterOptions(wxstr(options));
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPreviewCommand(wxPrintData* self, wxc_string command)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPreviewCommand(wxstr(command));
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetFilename(wxPrintData* self, wxc_string filename)
{
    self->SetFilename(wxstr(filename));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetFontMetricPath(wxPrintData* self, wxc_string path)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetFontMetricPath(wxstr(path));
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterScaleX(wxPrintData* self, double x)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterScaleX(x);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterScaleY(wxPrintData* self, double y)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterScaleY(y);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterScaling(wxPrintData* self, double x, double y)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterScaling(x, y);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterTranslateX(wxPrintData* self, int x)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterTranslateX(x);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterTranslateY(wxPrintData* self, int y)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterTranslateY(y);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterTranslation(wxPrintData* self, int x, int y)
{
#if wxUSE_POSTSCRIPT
    PostScriptData* data = PSData(self);
    if (data != NULL)
    data->SetPrinterTranslation(x, y);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrintMode(wxPrintData* self, wxPrintMode printMode)
{
    self->SetPrintMode(printMode);
}

