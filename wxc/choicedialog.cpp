//-----------------------------------------------------------------------------
// wx.NET - choicedialog.h
//
// The wxXChoiceDialog proxy interfaces.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/choicdlg.h>
#include "local_events.h"

class _SingleChoiceDialog : public wxSingleChoiceDialog
{
public:
        _SingleChoiceDialog(wxWindow* parent, const wxString message,
                const wxString& caption, int n,
        const wxString *choices,
                char **clientData,
                long style,
                const wxPoint& pos)
        : wxSingleChoiceDialog(parent, message, caption, n, choices, clientData, style, pos)
    {}
    DECLARE_OBJECTDELETED(_SingleChoiceDialog)
};

extern "C" WXEXPORT
wxSingleChoiceDialog* wxSingleChoiceDialog_ctor(wxWindow* parent, char* message,
        char* caption, int n, char* choices[], void * clientData,
        int style, const wxPoint* pos)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    wxString *pchoices = new wxString[n];
    for (int i = 0; i < n; ++i)
        {
            pchoices[i] = wxString(choices[i], wxConvUTF8);
        }

    return new _SingleChoiceDialog(parent, wxString(message, wxConvUTF8), wxString(caption, wxConvUTF8), n,
                pchoices, (char **)clientData, style, *pos);
}

extern "C" WXEXPORT
void wxSingleChoiceDialog_dtor(wxSingleChoiceDialog* self)
{
    delete self;
}

extern "C" WXEXPORT
void wxSingleChoiceDialog_SetSelection(wxSingleChoiceDialog* self, int sel)
{
    self->SetSelection(sel);
}

extern "C" WXEXPORT
int wxSingleChoiceDialog_GetSelection(wxSingleChoiceDialog* self)
{
    return self->GetSelection();
}

extern "C" WXEXPORT
wxString* wxSingleChoiceDialog_GetStringSelection(wxSingleChoiceDialog* self)
{
    return new wxString(self->GetStringSelection());
}

extern "C" WXEXPORT
void* wxSingleChoiceDialog_GetSelectionClientData(wxSingleChoiceDialog* self)
{
    return self->GetSelectionClientData();
}

//-----------------------------------------------------------------------------

class _MultiChoiceDialog : public wxMultiChoiceDialog
{
public:
        _MultiChoiceDialog(wxWindow* parent, const wxString message,
                const wxString& caption, int n,
        const wxString *choices,
                long style,
                const wxPoint& pos)
        : wxMultiChoiceDialog(parent, message, caption, n, choices, style, pos)
    {}
    DECLARE_OBJECTDELETED(_MultiChoiceDialog)
};

extern "C" WXEXPORT
wxMultiChoiceDialog* wxMultiChoiceDialog_ctor(wxWindow* parent, char* message,
        char* caption, int n, char* choices[],
        int style, const wxPoint* pos)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    wxString *pchoices = new wxString[n];
    for (int i = 0; i < n; ++i)
        {
            pchoices[i] = wxString(choices[i], wxConvUTF8);
        }
    return new _MultiChoiceDialog(parent, wxString(message, wxConvUTF8), wxString(caption, wxConvUTF8), n,
                pchoices, style, *pos);
}

extern "C" WXEXPORT
void wxMultiChoiceDialog_dtor(wxMultiChoiceDialog* self)
{
    delete self;
}

extern "C" WXEXPORT
void wxMultiChoiceDialog_SetSelections(wxMultiChoiceDialog* self, int *sel[], int numsel)
{
    wxArrayInt wai;
    for (int i = 0; i < numsel; ++i)
        wai.Add(*sel[i]);
    self->SetSelections(wai);
}

extern "C" WXEXPORT
wxArrayInt* wxMultiChoiceDialog_GetSelections(wxMultiChoiceDialog* self)
{
    return new wxArrayInt(self->GetSelections());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGetSingleChoice_func(char *message, char *caption, int n, const char* choices[],
                wxWindow *parent, int x, int y, bool centre,
                int width, int height)
{
    wxArrayString was;
    for (int i = 0; i < n; ++i)
        {
            wxString ts = wxString(choices[i], wxConvUTF8);
            was.Add(ts);
        }

    return new wxString(wxGetSingleChoice(wxString(message, wxConvUTF8),
                wxString(caption, wxConvUTF8),
                was, parent, x, y, centre,
                width, height));
}

extern "C" WXEXPORT
int wxGetSingleChoiceIndex_func(char *message, char *caption, int n, const char* choices[],
                wxWindow *parent, int x, int y, bool centre,
                int width, int height)
{
    wxArrayString was;
    for (int i = 0; i < n; ++i)
        {
            wxString ts = wxString(choices[i], wxConvUTF8);
            was.Add(ts);
        }

    return wxGetSingleChoiceIndex(wxString(message, wxConvUTF8),
                wxString(caption, wxConvUTF8),
                was, parent, x, y, centre,
                width, height);
}



