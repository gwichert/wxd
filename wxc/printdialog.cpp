//-----------------------------------------------------------------------------
// wxD - printdialog.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - printdialog.cxx
//
// The wxPrintDialog proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/printdlg.h>
//#include "local_events.h"

/*class _PageSetupDialog : public wxPageSetupDialog 
{
public:
	_PageSetupDialog(wxWindow* parent, wxPageSetupDialogData* data)
		: wxPageSetupDialog(parent, data) {}

	DECLARE_OBJECTDELETED(_PageSetupDialog)
};*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPageSetupDialog* wxPageSetupDialog_ctor(wxWindow* parent, wxPageSetupData* data)
{
    return new wxPageSetupDialog(parent, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPageSetupData* wxPageSetupDialog_GetPageSetupData(wxPageSetupDialog* self)
{
    return &(self->GetPageSetupData());
}

//-----------------------------------------------------------------------------
// wxPrintDialog

/*class _PrintDialog : public wxPrintDialog 
{
public:
	_PrintDialog(wxWindow* parent, wxPrintDialogData* data)
		: wxPrintDialog(parent, data) {}

	DECLARE_OBJECTDELETED(_PrintDialog)
};*/

extern "C" WXEXPORT
wxPrintDialog* wxPrintDialog_ctor(wxWindow* parent, wxPrintDialogData* data)
{
    return new wxPrintDialog(parent, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintDialog* wxPrintDialog_ctorPrintData(wxWindow* parent, wxPrintData* data)
{
    return new wxPrintDialog(parent, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPrintDialog_ShowModal(wxPrintDialog* self)
{
    return self->ShowModal();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintData* wxPrintDialog_GetPrintData(wxPrintDialog* self)
{
    return &(self->GetPrintData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintDialogData* wxPrintDialog_GetPrintDialogData(wxPrintDialog* self)
{
    return &(self->GetPrintDialogData());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDC* wxPrintDialog_GetPrintDC(wxPrintDialog* self)
{
    return self->GetPrintDC();
}

//-----------------------------------------------------------------------------

#if 0 /*defined(__WXGTK__)*/

extern "C" WXEXPORT
wxPrintSetupDialog* wxPrintSetupDialog_ctorPrintData(wxWindow* parent, wxPrintData* data)
{
    return new wxPrintSetupDialog(parent, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintSetupDialog* wxPrintSetupDialog_ctor(wxWindow* parent, wxPrintSetupData* data)
{
    return new wxPrintSetupDialog(parent, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPrintSetupDialog_Init(wxPrintSetupDialog* self, wxPrintData* data)
{
    self->Init(data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintSetupDialog_TransferDataFromWindow(wxPrintSetupDialog* self)
{
    return self->TransferDataFromWindow()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPrintSetupDialog_TransferDataToWindow(wxPrintSetupDialog* self)
{
    return self->TransferDataToWindow()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintData* wxPrintSetupDialog_GetPrintData(wxPrintSetupDialog* self)
{
    return &(self->GetPrintData());
}

#endif

