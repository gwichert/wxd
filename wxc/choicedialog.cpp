//-----------------------------------------------------------------------------
// wxD - choicedialog.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - choicedialog.cxx
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
#include "common.h"
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
wxSingleChoiceDialog* wxSingleChoiceDialog_ctor(wxWindow* parent, dstr message,
        dstr caption, int n, dstr choices[], void * clientData,
        int style, const wxPoint* pos)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    wxString *pchoices = new wxString[n];
    for (int i = 0; i < n; ++i)
        {
            pchoices[i] = wxstr(choices[i]);
        }

    return new _SingleChoiceDialog(parent, wxstr(message), wxstr(caption), n,
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
dstrret wxSingleChoiceDialog_GetStringSelection(wxSingleChoiceDialog* self)
{
    return dstr_ret(self->GetStringSelection());
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
wxMultiChoiceDialog* wxMultiChoiceDialog_ctor(wxWindow* parent, dstr message,
        dstr caption, int n, dstr choices[],
        int style, const wxPoint* pos)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    wxString *pchoices = new wxString[n];
    for (int i = 0; i < n; ++i)
        {
            pchoices[i] = wxstr(choices[i]);
        }
    return new _MultiChoiceDialog(parent, wxstr(message), wxstr(caption), n,
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
dstrret wxGetSingleChoice_func(dstr message, dstr caption, int n, dstr choices[],
                wxWindow *parent, int x, int y, dbit centre,
                int width, int height)
{
    wxArrayString was;
    was.Alloc(n);
    for (int i = 0; i < n; ++i)
        {
            wxString ts = wxstr(choices[i]);
            was.Add(ts);
        }

    return dstr_ret(wxGetSingleChoice(wxstr(message),
                wxstr(caption),
                was, parent, x, y, centre,
                width, height));
}

extern "C" WXEXPORT
int wxGetSingleChoiceIndex_func(dstr message, dstr caption, int n, dstr choices[],
                wxWindow *parent, int x, int y, dbit centre,
                int width, int height)
{
    wxArrayString was;
    was.Alloc(n);
    for (int i = 0; i < n; ++i)
        {
            wxString ts = wxstr(choices[i]);
            was.Add(ts);
        }

    return wxGetSingleChoiceIndex(wxstr(message),
                wxstr(caption),
                was, parent, x, y, centre,
                width, height);
}

extern "C" WXEXPORT
void* wxGetSingleChoiceData_func(dstr message, dstr caption, int n, dstr choices[],
                void** client_data,
                wxWindow *parent, int x, int y, dbit centre,
                int width, int height)
{
    wxArrayString was;
    was.Alloc(n);
    for (int i = 0; i < n; ++i)
        {
            wxString ts = wxstr(choices[i]);
            was.Add(ts);
        }

    return wxGetSingleChoiceData(wxstr(message),
                wxstr(caption),
                was, client_data, parent, x, y, centre,
                width, height);
}

extern "C" WXEXPORT
size_t wxGetMultipleChoices_func(wxArrayInt* selections,dstr message, dstr caption, int n, dstr choices[],
                wxWindow *parent, int x, int y, dbit centre,
                int width, int height)
{
    wxArrayString was;
    was.Alloc(n);
    for (int i = 0; i < n; ++i)
        {
            wxString ts = wxstr(choices[i]);
            was.Add(ts);
        }

    return wxGetMultipleChoices(*selections, wxstr(message),
                wxstr(caption),
                was, parent, x, y, centre,
                width, height);

}
