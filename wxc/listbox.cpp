//-----------------------------------------------------------------------------
// wxD - listbox.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - listbox.cxx
//
// wxListBox proxy inteface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/listbox.h>
#include <wx/checklst.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _ListBox : public wxListBox
{
public:
    DECLARE_OBJECTDELETED(_ListBox)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxListBox* wxListBox_ctor()
{
	return new _ListBox();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_dtor(wxListBox* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxListBox_Create(wxListBox* self, wxWindow *parent, wxWindowID id,
					  const wxPoint* pos, const wxSize* size, int n,
					  dstr items[], long style,
					  const wxValidator* validator, dstr name)
{
	int i;

	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = dstr("listbox");

	wxString* strings = NULL;

    if (items != NULL) {
        strings = new wxString[n];
        for (i = 0; i < n; ++i)
            strings[i] = wxString(items[i].data, wxConvUTF8, items[i].length);
    }

	return self->Create(parent, id, *pos, *size, n, strings, style,
						*validator, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Clear(wxListBox* self)
{
	self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Delete(wxListBox* self, int n)
{
	self->Delete(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListBox_GetCount(wxListBox* self)
{
	return self->GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxListBox_GetSingleString(wxListBox* self, int n)
{
	return dstr_ret(self->GetString(n).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetSingleString(wxListBox* self, int n, dstr s)
{
	self->SetString(n, wxString(s.data, wxConvUTF8, s.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListBox_FindString(wxListBox* self, dstr s)
{
	return self->FindString(wxString(s.data, wxConvUTF8, s.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetSelection(wxListBox* self, int n, dbit select)
{
	self->SetSelection(n, select);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListBox_GetSelection(wxListBox* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxArrayInt* wxListBox_GetSelections(wxListBox* self)
{
    wxArrayInt *ari = new wxArrayInt();
	self->GetSelections(*ari);
    return ari;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_InsertText(wxListBox* self, dstr item, int pos)
{
	self->Insert(wxString(item.data, wxConvUTF8, item.length), pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_InsertTextData(wxListBox* self, dstr item, int pos, void *clientData)
{
	self->Insert(wxString(item.data, wxConvUTF8, item.length), pos, clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_InsertTextClientData(wxListBox* self, dstr item, int pos, wxClientData *clientData)
{
	self->Insert(wxString(item.data, wxConvUTF8, item.length), pos, clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_InsertItems(wxListBox* self, int nItems, dstr items[], int pos)
{
	int i;

	wxString* strings = new wxString[nItems];
	for (i = 0; i < nItems; ++i)
		strings[i] = wxString(items[i].data, wxConvUTF8, items[i].length);

	self->InsertItems(nItems, strings, pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Set(wxListBox* self, int n, dstr items[], void *clientData)
{
	int i;

	wxString* strings = new wxString[n];
	for (i = 0; i < n; ++i)
		strings[i] = wxString(items[i].data, wxConvUTF8, items[i].length);

	self->Set(n, strings, &clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Select(wxListBox* self, int n)
{
	self->Select(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Deselect(wxListBox* self, int n)
{
	self->Deselect(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_DeselectAll(wxListBox* self, int itemToLeaveSelected)
{
	self->DeselectAll(itemToLeaveSelected);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxListBox_SetStringSelection(wxListBox* self, dstr s, dbit select)
{
	return self->SetStringSelection(wxString(s.data, wxConvUTF8, s.length), select)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetFirstItem(wxListBox* self, int n)
{
	self->SetFirstItem(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetFirstItemText(wxListBox* self, dstr s)
{
	self->SetFirstItem(wxString(s.data, wxConvUTF8, s.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxListBox_HasMultipleSelection(wxListBox* self)
{
	return self->HasMultipleSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxListBox_IsSorted(wxListBox* self)
{
	return self->IsSorted()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Command(wxListBox* self, wxCommandEvent* event)
{
	self->Command(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxListBox_Selected(wxListBox* self, int n)
{
	return self->Selected(n)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const dstrret wxListBox_GetStringSelection(wxListBox* self)
{
	return dstr_ret(self->GetStringSelection());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Append(wxListBox* self, dstr item)
{
	self->Append(wxString(item.data, wxConvUTF8, item.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_AppendClientData(wxListBox* self, dstr item, void* clientData)
{
	self->Append(wxString(item.data, wxConvUTF8, item.length), clientData);
}

//-----------------------------------------------------------------------------
// wxCheckListBox

class _CheckListBox : public wxCheckListBox
{
public:
	_CheckListBox()
		: wxCheckListBox() {}
		
	_CheckListBox(wxWindow *parent, wxWindowID id,
            const wxPoint& pos,
            const wxSize& size,
            int nStrings,
            const wxString *choices,
            long style,
            const wxValidator& validator,
            const wxString& name)
	    : wxCheckListBox(parent, id, pos, size, nStrings, choices, style, validator, name) {}
	    
	DECLARE_OBJECTDELETED(_CheckListBox)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCheckListBox* wxCheckListBox_ctor1()
{
	return new _CheckListBox();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCheckListBox* wxCheckListBox_ctor2(wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, 
	int nStrings, dstr choices[], long style, const wxValidator* validator, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = dstr("checklistbox");

	wxString* strings = NULL;

	if (choices != NULL) 
	{
		strings = new wxString[nStrings];
		for (int i = 0; i < nStrings; ++i)
			strings[i] = wxString(choices[i].data, wxConvUTF8, choices[i].length);
    	}
	
	return new _CheckListBox(parent, id, *pos, *size, nStrings, strings, style, *validator, wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxCheckListBox_IsChecked(wxCheckListBox* self, int index)
{
	return self->IsChecked(index)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCheckListBox_Check(wxCheckListBox* self, int index, dbit check)
{
	return self->Check(index, check);
}

//-----------------------------------------------------------------------------

#ifndef __WXMAC__
extern "C" WXEXPORT
int wxCheckListBox_GetItemHeight(wxCheckListBox* self)
{
	return self->GetItemHeight();
}
#endif
