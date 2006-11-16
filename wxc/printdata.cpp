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
bool wxPageSetupDialogData_GetDefaultMinMargins(wxPageSetupDialogData* self)
{
    return self->GetDefaultMinMargins()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPageSetupDialogData_GetEnableMargins(wxPageSetupDialogData* self)
{
    return self->GetEnableMargins()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPageSetupDialogData_GetEnableOrientation(wxPageSetupDialogData* self)
{
    return self->GetEnableOrientation()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPageSetupDialogData_GetEnablePaper(wxPageSetupDialogData* self)
{
    return self->GetEnablePaper()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPageSetupDialogData_GetEnablePrinter(wxPageSetupDialogData* self)
{
    return self->GetEnablePrinter()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPageSetupDialogData_GetDefaultInfo(wxPageSetupDialogData* self)
{
    return self->GetDefaultInfo()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPageSetupDialogData_GetEnableHelp(wxPageSetupDialogData* self)
{
    return self->GetEnableHelp()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPageSetupDialogData_Ok(wxPageSetupDialogData* self)
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
void wxPageSetupDialogData_SetDefaultMinMargins(wxPageSetupDialogData* self, bool flag)
{
    self->SetDefaultMinMargins(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_SetDefaultInfo(wxPageSetupDialogData* self, bool flag)
{
    self->SetDefaultInfo(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnableMargins(wxPageSetupDialogData* self, bool flag)
{
    self->EnableMargins(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnableOrientation(wxPageSetupDialogData* self, bool flag)
{
    self->EnableOrientation(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnablePaper(wxPageSetupDialogData* self, bool flag)
{
    self->EnablePaper(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnablePrinter(wxPageSetupDialogData* self, bool flag)
{
    self->EnablePrinter(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPageSetupDialogData_EnableHelp(wxPageSetupDialogData* self, bool flag)
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
bool wxPrintDialogData_GetAllPages(wxPrintDialogData* self)
{
    return self->GetAllPages()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetSelection(wxPrintDialogData* self)
{
    return self->GetSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetCollate(wxPrintDialogData* self)
{
    return self->GetCollate()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetPrintToFile(wxPrintDialogData* self)
{
    return self->GetPrintToFile()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetSetupDialog(wxPrintDialogData* self)
{
    return self->GetSetupDialog()?1:0;
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
void wxPrintDialogData_SetAllPages(wxPrintDialogData* self, bool flag)
{
    self->SetAllPages(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetSelection(wxPrintDialogData* self, bool flag)
{
    self->SetSelection(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetCollate(wxPrintDialogData* self, bool flag)
{
    self->SetCollate(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetPrintToFile(wxPrintDialogData* self, bool flag)
{
    self->SetPrintToFile(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_SetSetupDialog(wxPrintDialogData* self, bool flag)
{
    self->SetSetupDialog(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnablePrintToFile(wxPrintDialogData* self, bool flag)
{
    self->EnablePrintToFile(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnableSelection(wxPrintDialogData* self, bool flag)
{
    self->EnableSelection(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnablePageNumbers(wxPrintDialogData* self, bool flag)
{
    self->EnablePageNumbers(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintDialogData_EnableHelp(wxPrintDialogData* self, bool flag)
{
    self->EnableHelp(flag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetEnablePrintToFile(wxPrintDialogData* self)
{
    return self->GetEnablePrintToFile()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetEnableSelection(wxPrintDialogData* self)
{
    return self->GetEnableSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetEnablePageNumbers(wxPrintDialogData* self)
{
    return self->GetEnablePageNumbers()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_GetEnableHelp(wxPrintDialogData* self)
{
    return self->GetEnableHelp()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintDialogData_Ok(wxPrintDialogData* self)
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
bool wxPrintData_GetCollate(wxPrintData* self)
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
bool wxPrintData_Ok(wxPrintData* self)
{
    return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxPrintData_GetPrinterName(wxPrintData* self)
{
    return dstr_ret(self->GetPrinterName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxPrintData_GetColour(wxPrintData* self)
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
void wxPrintData_SetCollate(wxPrintData* self, bool flag)
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
void wxPrintData_SetPrinterName(wxPrintData* self, dstr name)
{
    self->SetPrinterName(wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetColour(wxPrintData* self, bool colour)
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
dstrret wxPrintData_GetPrinterCommand(wxPrintData* self)
{
    return dstr_ret(self->GetPrinterCommand());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxPrintData_GetPrinterOptions(wxPrintData* self)
{
    return dstr_ret(self->GetPrinterOptions());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxPrintData_GetPreviewCommand(wxPrintData* self)
{
    return dstr_ret(self->GetPreviewCommand());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxPrintData_GetFilename(wxPrintData* self)
{
    return dstr_ret(self->GetFilename());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxPrintData_GetFontMetricPath(wxPrintData* self)
{
    return dstr_ret(self->GetFontMetricPath());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
double wxPrintData_GetPrinterScaleX(wxPrintData* self)
{
    return self->GetPrinterScaleX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
double wxPrintData_GetPrinterScaleY(wxPrintData* self)
{
    return self->GetPrinterScaleY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintData_GetPrinterTranslateX(wxPrintData* self)
{
    return self->GetPrinterTranslateX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintData_GetPrinterTranslateY(wxPrintData* self)
{
    return self->GetPrinterTranslateY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintMode wxPrintData_GetPrintMode(wxPrintData* self)
{
    return self->GetPrintMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterCommand(wxPrintData* self, dstr command)
{
    self->SetPrinterCommand(wxString(command.data, wxConvUTF8, command.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterOptions(wxPrintData* self, dstr options)
{
    self->SetPrinterOptions(wxString(options.data, wxConvUTF8, options.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPreviewCommand(wxPrintData* self, dstr command)
{
    self->SetPreviewCommand(wxString(command.data, wxConvUTF8, command.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetFilename(wxPrintData* self, dstr filename)
{
    self->SetFilename(wxString(filename.data, wxConvUTF8, filename.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetFontMetricPath(wxPrintData* self, dstr path)
{
    self->SetFontMetricPath(wxString(path.data, wxConvUTF8, path.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterScaleX(wxPrintData* self, double x)
{
    self->SetPrinterScaleX(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterScaleY(wxPrintData* self, double y)
{
    self->SetPrinterScaleY(y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterScaling(wxPrintData* self, double x, double y)
{
    self->SetPrinterScaling(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterTranslateX(wxPrintData* self, int x)
{
    self->SetPrinterTranslateX(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterTranslateY(wxPrintData* self, int y)
{
    self->SetPrinterTranslateY(y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrinterTranslation(wxPrintData* self, int x, int y)
{
    self->SetPrinterTranslation(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintData_SetPrintMode(wxPrintData* self, wxPrintMode printMode)
{
    self->SetPrintMode(printMode);
}

