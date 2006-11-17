//-----------------------------------------------------------------------------
// wxD - document.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - document.cxx
//
// The wxDocument proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/docview.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDocument* wxDocument_ctor(wxDocument* parent)
{
    return new wxDocument(parent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_SetFilename(wxDocument* self, dstr filename, dbit notifyViews)
{
    self->SetFilename(wxString(filename.data, wxConvUTF8, filename.length), notifyViews);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxDocument_GetFilename(wxDocument* self)
{
    return dstr_ret(self->GetFilename());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_SetTitle(wxDocument* self, dstr title)
{
    self->SetTitle(wxString(title.data, wxConvUTF8, title.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxDocument_GetTitle(wxDocument* self)
{
    return dstr_ret(self->GetTitle());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_SetDocumentName(wxDocument* self, dstr name)
{
    self->SetDocumentName(wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxDocument_GetDocumentName(wxDocument* self)
{
    return dstr_ret(self->GetDocumentName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_GetDocumentSaved(wxDocument* self)
{
    return self->GetDocumentSaved();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_SetDocumentSaved(wxDocument* self, dbit saved)
{
    self->SetDocumentSaved(saved);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_Close(wxDocument* self)
{
    return self->Close();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_Save(wxDocument* self)
{
    return self->Save();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_SaveAs(wxDocument* self)
{
    return self->SaveAs();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_Revert(wxDocument* self)
{
    return self->Revert();
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
wxOutputStream* wxDocument_SaveObject(wxDocument* self, wxOutputStream* stream)
{
    return &(self->SaveObject(*stream));
}

extern "C" WXEXPORT
wxInputStream* wxDocument_LoadObject(wxDocument* self, wxInputStream* stream)
{
    return &(self->LoadObject(*stream));
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCommandProcessor* wxDocument_GetCommandProcessor(wxDocument* self)
{
    return self->GetCommandProcessor();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_SetCommandProcessor(wxDocument* self, wxCommandProcessor* proc)
{
    self->SetCommandProcessor(proc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_DeleteContents(wxDocument* self)
{
    return self->DeleteContents();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_Draw(wxDocument* self, wxDC* dc)
{
    return self->Draw(*dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_IsModified(wxDocument* self)
{
    return self->IsModified();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_Modify(wxDocument* self, dbit mod)
{
    self->Modify(mod);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_AddView(wxDocument* self, wxView* view)
{
    return self->AddView(view);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_RemoveView(wxDocument* self, wxView* view)
{
    return self->RemoveView(view);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxList* wxDocument_GetViews(wxDocument* self)
{
    return &(self->GetViews());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxView* wxDocument_GetFirstView(wxDocument* self)
{
    return self->GetFirstView();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_UpdateAllViews(wxDocument* self, wxView* sender, wxObject* hint)
{
    self->UpdateAllViews(sender, hint);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_NotifyClosing(wxDocument* self)
{
    self->NotifyClosing();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_DeleteAllViews(wxDocument* self)
{
    return self->DeleteAllViews();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDocManager* wxDocument_GetDocumentManager(wxDocument* self)
{
    return self->GetDocumentManager();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDocTemplate* wxDocument_GetDocumentTemplate(wxDocument* self)
{
    return self->GetDocumentTemplate();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDocument_SetDocumentTemplate(wxDocument* self, wxDocTemplate* temp)
{
    self->SetDocumentTemplate(temp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxDocument_GetPrintableName(wxDocument* self, wxString* name)
{
    return self->GetPrintableName(*name);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxDocument_GetDocumentWindow(wxDocument* self)
{
    return self->GetDocumentWindow();
}

//-----------------------------------------------------------------------------
