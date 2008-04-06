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
wxc_bool wxListBox_Create(wxListBox* self, wxWindow *parent, wxWindowID id,
					  const wxPoint* pos, const wxSize* size, int n,
					  wxc_string items[], long style,
					  const wxValidator* validator, wxc_string name)
{
	int i;

	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = wxc_string("listbox");

	wxString* strings = NULL;

    if (items != NULL) {
        strings = new wxString[n];
        for (i = 0; i < n; ++i)
            strings[i] = wxstr(items[i]);
    }

	return self->Create(parent, id, *pos, *size, n, strings, style,
						*validator, wxstr(name))?1:0;
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
wxString* wxListBox_GetSingleString(wxListBox* self, int n)
{
	return new wxString(self->GetString(n).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetSingleString(wxListBox* self, int n, wxc_string s)
{
	self->SetString(n, wxstr(s));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxListBox_FindString(wxListBox* self, wxc_string s)
{
	return self->FindString(wxstr(s));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetSelection(wxListBox* self, int n, wxc_bool select)
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
void wxListBox_InsertText(wxListBox* self, wxc_string item, int pos)
{
	self->Insert(wxstr(item), pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_InsertTextData(wxListBox* self, wxc_string item, int pos, void *clientData)
{
	self->Insert(wxstr(item), pos, clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_InsertTextClientData(wxListBox* self, wxc_string item, int pos, wxClientData *clientData)
{
	self->Insert(wxstr(item), pos, clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_InsertItems(wxListBox* self, int nItems, wxc_string items[], int pos)
{
	int i;

	wxString* strings = new wxString[nItems];
	for (i = 0; i < nItems; ++i)
		strings[i] = wxstr(items[i]);

	self->InsertItems(nItems, strings, pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Set(wxListBox* self, int n, wxc_string items[], void *clientData)
{
	int i;

	wxString* strings = new wxString[n];
	for (i = 0; i < n; ++i)
		strings[i] = wxstr(items[i]);

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
wxc_bool wxListBox_SetStringSelection(wxListBox* self, wxc_string s, wxc_bool select)
{
	return self->SetStringSelection(wxstr(s), select)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetFirstItem(wxListBox* self, int n)
{
	self->SetFirstItem(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_SetFirstItemText(wxListBox* self, wxc_string s)
{
	self->SetFirstItem(wxstr(s));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListBox_HasMultipleSelection(wxListBox* self)
{
	return self->HasMultipleSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxListBox_IsSorted(wxListBox* self)
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
wxc_bool wxListBox_Selected(wxListBox* self, int n)
{
#if wxABI_VERSION < 20700
	return self->Selected(n)?1:0;
#else
	return self->IsSelected(n)?1:0;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxString* wxListBox_GetStringSelection(wxListBox* self)
{
	return new wxString(self->GetStringSelection());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_Append(wxListBox* self, wxc_string item)
{
	self->Append(wxstr(item));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxListBox_AppendClientData(wxListBox* self, wxc_string item, void* clientData)
{
	self->Append(wxstr(item), clientData);
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
	int nStrings, wxc_string choices[], long style, const wxValidator* validator, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = wxc_string("checklistbox");

	wxString* strings = NULL;

	if (choices != NULL) 
	{
		strings = new wxString[nStrings];
		for (int i = 0; i < nStrings; ++i)
			strings[i] = wxstr(choices[i]);
    	}
	
	return new _CheckListBox(parent, id, *pos, *size, nStrings, strings, style, *validator, wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCheckListBox_IsChecked(wxCheckListBox* self, int index)
{
	return self->IsChecked(index)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCheckListBox_Check(wxCheckListBox* self, int index, wxc_bool check)
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
#else
extern "C" WXEXPORT
int wxCheckListBox_GetItemHeight(wxCheckListBox* self)
{
	return 0; /* dummy symbol for library */
}
#endif
