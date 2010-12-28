//-----------------------------------------------------------------------------
// wxD - printer.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - printer.cxx
//
// The wxPrinter proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// 
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/print.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrinter* wxPrinter_ctor(wxPrintDialogData* data)
{
    return new wxPrinter(data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxPrinter_CreateAbortWindow(wxPrinter* self, wxWindow* parent, wxPrintout* printout)
{
    return self->CreateAbortWindow(parent, printout);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrinter_ReportError(wxPrinter* self, wxWindow* parent, wxPrintout* printout, wxc_string message)
{
    self->ReportError(parent, printout, wxstr(message));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintDialogData* wxPrinter_GetPrintDialogData(wxPrinter* self)
{
    return &(self->GetPrintDialogData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrinter_GetAbort(wxPrinter* self)
{
    return self->GetAbort()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrinterError wxPrinter_GetLastError(wxPrinter* self)
{
    return self->GetLastError();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrinter_Setup(wxPrinter* self, wxWindow* parent)
{
    return self->Setup(parent)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrinter_Print(wxPrinter* self, wxWindow* parent, wxPrintout* printout, wxc_bool prompt)
{
    return self->Print(parent, printout, prompt)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDC* wxPrinter_PrintDialog(wxPrinter* self, wxWindow* parent)
{
    return self->PrintDialog(parent);
}

//-----------------------------------------------------------------------------

// Virtual method delegate pointer types
typedef void (CALLBACK* Virtual_NoParams)(wxc_object);
typedef wxc_bool (CALLBACK* Virtual_ParamsInt)(wxc_object, int);
typedef wxc_bool (CALLBACK* Virtual_OnBeginDocument)(wxc_object, int, int);
typedef void (CALLBACK* Virtual_GetPageInfo)(wxc_object, int*, int*, int*, int*);

class _Printout : public wxPrintout
{
public:
    _Printout(const wxString& title) 
        : wxPrintout(title) { }

    bool OnBeginDocument(int startPage, int endPage) { return m_onBeginDocument(m_dobj, startPage, endPage); }
    void OnEndDocument() { m_onEndDocument(m_dobj); }
    void OnBeginPrinting() { m_onBeginPrinting(m_dobj); }
    void OnEndPrinting() { m_onEndPrinting(m_dobj); }
    void OnPreparePrinting() { m_onPreparePrinting(m_dobj); }
    bool HasPage(int page) { return m_hasPage(m_dobj, page); }
    bool OnPrintPage(int pageNum) { return m_onPrintPage(m_dobj, pageNum); }
    void GetPageInfo(int *minPage, int *maxPage, int *pageFrom, int *pageTo)
        { m_getPageInfo(m_dobj, minPage, maxPage, pageFrom, pageTo); }

    void RegisterVirtual(wxc_object obj, Virtual_OnBeginDocument onBeginDocument,
                         Virtual_NoParams onEndDocument, 
                         Virtual_NoParams onBeginPrinting,
                         Virtual_NoParams onEndPrinting,
                         Virtual_NoParams onPreparePrinting, 
                         Virtual_ParamsInt hasPage,
                         Virtual_ParamsInt onPrintPage,
                         Virtual_GetPageInfo getPageInfo)
    {
        m_dobj = obj;

        m_onBeginDocument   = onBeginDocument;

        m_onEndDocument     = onEndDocument;
        m_onBeginPrinting   = onBeginPrinting;
        m_onEndPrinting     = onEndPrinting;
        m_onPreparePrinting = onPreparePrinting;

        m_hasPage           = hasPage;
        m_onPrintPage       = onPrintPage;

        m_getPageInfo       = getPageInfo;
    }

private:
    Virtual_NoParams m_onEndDocument, m_onBeginPrinting,
                     m_onEndPrinting, m_onPreparePrinting;
    Virtual_ParamsInt m_hasPage, m_onPrintPage;
    Virtual_OnBeginDocument m_onBeginDocument;
    Virtual_GetPageInfo m_getPageInfo;
    wxc_object m_dobj;
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintout* wxPrintout_ctor(wxc_string title)
{
    if (title.data==NULL)
        title = wxc_string("Printout");

    return new _Printout(wxstr(title));
}

extern "C" WXEXPORT
void wxPrintout_RegisterVirtual(_Printout *self,wxc_object obj,
        Virtual_OnBeginDocument onBeginDocument, Virtual_NoParams onEndDocument, 
        Virtual_NoParams onBeginPrinting, Virtual_NoParams onEndPrinting,
        Virtual_NoParams onPreparePrinting, Virtual_ParamsInt hasPage,
        Virtual_ParamsInt onPrintPage, Virtual_GetPageInfo getPageInfo)
{
    self->RegisterVirtual(obj, onBeginDocument, onEndDocument, 
                          onBeginPrinting, onEndPrinting, onPreparePrinting,
                          hasPage, onPrintPage, getPageInfo);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintout_OnBeginDocument(_Printout* self, int startPage, int endPage)
{
    return self->wxPrintout::OnBeginDocument(startPage, endPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_OnEndDocument(_Printout* self)
{
    self->wxPrintout::OnEndDocument();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_OnBeginPrinting(_Printout* self)
{
    self->wxPrintout::OnBeginPrinting();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_OnEndPrinting(_Printout* self)
{
    self->wxPrintout::OnEndPrinting();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_OnPreparePrinting(_Printout* self)
{
    self->wxPrintout::OnPreparePrinting();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintout_HasPage(_Printout* self, int page)
{
    return self->wxPrintout::HasPage(page)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_GetPageInfo(_Printout* self, int* minPage, int* maxPage, int* pageFrom, int* pageTo)
{
    self->wxPrintout::GetPageInfo(minPage, maxPage, pageFrom, pageTo);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxPrintout_GetTitle(_Printout* self)
{
    return new wxString(self->GetTitle().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDC* wxPrintout_GetDC(_Printout* self)
{
    return self->GetDC();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_SetDC(_Printout* self, wxDC* dc)
{
    self->SetDC(dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_SetPageSizePixels(_Printout* self, int w, int h)
{
    self->SetPageSizePixels(w, h);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_GetPageSizePixels(_Printout* self, int* w, int* h)
{
    self->GetPageSizePixels(w, h);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_SetPageSizeMM(_Printout* self, int w, int h)
{
    self->SetPageSizeMM(w, h);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_GetPageSizeMM(_Printout* self, int* w, int* h)
{
    self->GetPageSizeMM(w, h);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_SetPPIScreen(_Printout* self, int x, int y)
{
    self->SetPPIScreen(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_GetPPIScreen(_Printout* self, int* x, int* y)
{
    self->GetPPIScreen(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_SetPPIPrinter(_Printout* self, int x, int y)
{
    self->SetPPIPrinter(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_GetPPIPrinter(_Printout* self, int* x, int* y)
{
    self->GetPPIPrinter(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPrintout_IsPreview(_Printout* self)
{
    return self->IsPreview()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintout_SetIsPreview(_Printout* self, wxc_bool p)
{
#if wxABI_VERSION < 20900
    self->SetIsPreview(p);
#endif
}


