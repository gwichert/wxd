//-----------------------------------------------------------------------------
// wxD - choice.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - choice.cxx
//
// The wxChoice wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/choice.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Choice : public wxChoice 
{
public:
    DECLARE_OBJECTDELETED(_Choice)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxChoice* wxChoice_ctor()
{
    return new _Choice();
}

extern "C" WXEXPORT
dbit wxChoice_Create(wxChoice* self, wxWindow* parent, int id, const wxPoint* pos,
                     const wxSize* size, int n, dstr choices[],
                     long style, const wxValidator* validator,
                     dstr name)
{
    int i;

    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (validator == NULL)
        validator = &wxDefaultValidator;

    if (name.data==NULL)
        name = dstr("choice");

    wxString* strings = new wxString[n];
    for (i = 0; i < n; ++i)
        strings[i] = wxString(choices[i].data, wxConvUTF8, choices[i].length);

    return self->Create(parent, id, *pos, *size, n, strings, style, *validator,
                        wxString(name.data, wxConvUTF8, name.length))?1:0;
}

extern "C" WXEXPORT
void wxChoice_dtor(wxChoice* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_SetString(wxChoice* self, int n, dstr text)
{
    self->SetString(n, wxString(text.data, wxConvUTF8, text.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxChoice_GetStringSelection(wxChoice* self)
{
    return dstr_ret(self->GetStringSelection());
}

extern "C" WXEXPORT
dstrret wxChoice_GetString(wxChoice* self, int n)
{
    return dstr_ret(self->GetString(n));
}

extern "C" WXEXPORT
int wxChoice_GetSelection(wxChoice* self)
{
    return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxChoice_GetCount(wxChoice* self)
{
    return self->GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void* wxChoice_GetClientData(wxChoice* self, int n)
{
    return self->GetClientData(n);
}

extern "C" WXEXPORT
void wxChoice_SetClientData(wxChoice* self, int n, void* data)
{
    self->SetClientData(n, data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxChoice_FindString(wxChoice* self, dstr string)
{
    return self->FindString(wxString(string.data, wxConvUTF8, string.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_Delete(wxChoice* self, int n)
{
    self->Delete(n);
}

extern "C" WXEXPORT
void wxChoice_Clear(wxChoice* self)
{
    self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxChoice_Append(wxChoice* self, dstr item)
{
    return self->Append(wxString(item.data, wxConvUTF8, item.length));
}

extern "C" WXEXPORT
int wxChoice_AppendData(wxChoice* self, dstr item, wxClientData* clientData)
{
    return self->Append(wxString(item.data, wxConvUTF8, item.length), clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_AppendString(wxChoice* self, dstr item)
{
	self->AppendString(wxString(item.data, wxConvUTF8, item.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_AppendArrayString(wxChoice* self, int n, dstr strings[])
{
	for (int i = 0; i < n; ++i)
	{
		self->Append(wxString(strings[i].data, wxConvUTF8, strings[i].length));
	}
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxChoice_Insert(wxChoice* self, dstr item, int pos)
{
	return self->Insert(wxString(item.data, wxConvUTF8, item.length), pos);
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
int wxChoice_InsertVoidPointer(wxChoice* self, dstr item, int pos, void* clientData)
{
	return self->Insert(wxString(item.data, wxConvUTF8, item.length), pos, clientData);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxChoice_InsertClientData(wxChoice* self, dstr item, int pos, wxClientData* clientData)
{
	return self->Insert(wxString(item.data, wxConvUTF8, item.length), pos, clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxArrayString* wxChoice_GetStrings(wxChoice* self)
{
	wxArrayString* wai = new wxArrayString();
	*wai = self->GetStrings();
	return wai;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_SetClientObject(wxChoice* self, int n, wxClientData* clientData)
{
	self->SetClientObject(n, clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxClientData* wxChoice_GetClientObject(wxChoice* self, int n)
{
	return self->GetClientObject(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxChoice_HasClientObjectData(wxChoice* self)
{
	return self->HasClientObjectData()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxChoice_HasClientUntypedData(wxChoice* self)
{
	return self->HasClientUntypedData()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_SetSelection(wxChoice* self, int n)
{
    self->SetSelection(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxChoice_SetStringSelection(wxChoice* self, dstr s)
{
    return self->SetStringSelection(wxString(s.data, wxConvUTF8, s.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_SetColumns(wxChoice* self, int n)
{
    self->SetColumns(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxChoice_GetColumns(wxChoice* self)
{
    return self->GetColumns();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_Command(wxChoice* self, wxCommandEvent* event)
{
    self->Command(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxChoice_Select(wxChoice* self, int n)
{
	self->Select(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxChoice_ShouldInheritColours(wxChoice* self)
{
	return self->ShouldInheritColours()?1:0; 
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxChoice_IsEmpty(wxChoice* self)
{
	return self->IsEmpty()?1:0;
}
