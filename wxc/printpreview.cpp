//-----------------------------------------------------------------------------
// wxD - printpreview.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - printpreview.cxx
//
// The wxPrintPreview proxy interface.
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
wxPrintPreview* wxPrintPreview_ctor(wxPrintout* printout, wxPrintout* printoutForPrinting, wxPrintDialogData* data)
{
    return new wxPrintPreview(printout, printoutForPrinting, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintPreview* wxPrintPreview_ctorPrintData(wxPrintout* printout, wxPrintout* printoutForPrinting, wxPrintData* data)
{
    return new wxPrintPreview(printout, printoutForPrinting, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintPreview_SetCurrentPage(wxPrintPreview* self, int pageNum)
{
    return self->SetCurrentPage(pageNum)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintPreview_GetCurrentPage(wxPrintPreview* self)
{
    return self->GetCurrentPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintPreview_SetPrintout(wxPrintPreview* self, wxPrintout* printout)
{
    self->SetPrintout(printout);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintout* wxPrintPreview_GetPrintout(wxPrintPreview* self)
{
    return self->GetPrintout();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintout* wxPrintPreview_GetPrintoutForPrinting(wxPrintPreview* self)
{
    return self->GetPrintoutForPrinting();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintPreview_SetFrame(wxPrintPreview* self, wxFrame* frame)
{
    self->SetFrame(frame);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintPreview_SetCanvas(wxPrintPreview* self, wxPreviewCanvas* canvas)
{
    self->SetCanvas(canvas);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFrame* wxPrintPreview_GetFrame(wxPrintPreview* self)
{
    return self->GetFrame();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxPrintPreview_GetCanvas(wxPrintPreview* self)
{
    return self->GetCanvas();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintPreview_PaintPage(wxPrintPreview* self, wxPreviewCanvas* canvas, wxDC* dc)
{
    return self->PaintPage(canvas, *dc)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintPreview_DrawBlankPage(wxPrintPreview* self, wxPreviewCanvas* canvas, wxDC* dc)
{
    return self->DrawBlankPage(canvas, *dc)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintPreview_RenderPage(wxPrintPreview* self, int pageNum)
{
    return self->RenderPage(pageNum)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintDialogData* wxPrintPreview_GetPrintDialogData(wxPrintPreview* self)
{
    return &(self->GetPrintDialogData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintPreview_SetZoom(wxPrintPreview* self, int percent)
{
    self->SetZoom(percent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintPreview_GetZoom(wxPrintPreview* self)
{
    return self->GetZoom();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintPreview_GetMaxPage(wxPrintPreview* self)
{
    return self->GetMaxPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintPreview_GetMinPage(wxPrintPreview* self)
{
    return self->GetMinPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintPreview_Ok(wxPrintPreview* self)
{
    return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintPreview_SetOk(wxPrintPreview* self, dbit ok)
{
    self->SetOk(ok);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintPreview_Print(wxPrintPreview* self, dbit interactive)
{
    return self->Print(interactive)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintPreview_DetermineScaling(wxPrintPreview* self)
{
    self->DetermineScaling();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPreviewFrame* wxPreviewFrame_ctor(wxPrintPreviewBase* preview, wxFrame* parent, dstr title, wxPoint* pos, wxSize* size, int style, dstr name)
{
    if (name.data==NULL)
        name = dstr("PreviewFrame");

    return new wxPreviewFrame(preview, parent, wxstr(title), *pos, *size, style, wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPreviewFrame_Initialize(wxPreviewFrame* self)
{
    self->Initialize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPreviewFrame_CreateCanvas(wxPreviewFrame* self)
{
    self->CreateCanvas();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPreviewFrame_CreateControlBar(wxPreviewFrame* self)
{
    self->CreateControlBar();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPreviewCanvas* wxPreviewCanvas_ctor(wxPrintPreviewBase* preview, wxWindow* parent, wxPoint* pos, wxSize* size, int style, dstr name)
{
    if (name.data==NULL)
        name = dstr("PreviewCanvas");

    return new wxPreviewCanvas(preview, parent, *pos, *size, style, wxstr(name));
}

//-----------------------------------------------------------------------------

class _PreviewControlBar : public wxPreviewControlBar
{
public:
    _PreviewControlBar(wxPrintPreviewBase *preview,
                        long buttons,
                        wxWindow *parent,
                        const wxPoint& pos,
                        const wxSize& size,
                        long style,
                        const wxString& name)
                : wxPreviewControlBar(preview,buttons,parent,pos,size,style,name) {}

    DECLARE_OBJECTDELETED(_PreviewControlBar)
};

extern "C" WXEXPORT
wxPreviewControlBar* wxPreviewControlBar_ctor(wxPrintPreviewBase *preview,
                        long buttons,
                        wxWindow *parent,
                        const wxPoint* pos,
                        const wxSize* size,
                        long style,
                        dstr name)
{
    if (name.data==NULL)
        name = dstr("panel");

    return new _PreviewControlBar(preview,buttons,parent,*pos,*size,style,wxstr(name));
}

extern "C" WXEXPORT
void wxPreviewControlBar_CreateButtons(wxPreviewControlBar* self)
{
    self->CreateButtons();
}

extern "C" WXEXPORT
void wxPreviewControlBar_SetZoomControl(wxPreviewControlBar* self, int zoom)
{
    self->SetZoomControl(zoom);
}

extern "C" WXEXPORT
int wxPreviewControlBar_GetZoomControl(wxPreviewControlBar* self)
{
    return self->GetZoomControl();
}

extern "C" WXEXPORT
wxPrintPreviewBase* wxPreviewControlBar_GetPrintPreview(wxPreviewControlBar* self)
{
    return self->GetPrintPreview();
}
