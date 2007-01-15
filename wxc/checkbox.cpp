//-----------------------------------------------------------------------------
// wxD - checkbox.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - checkbox.cxx
//
// The wxCheckBox proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------

class _CheckBox : public wxCheckBox 
{
public:
    DECLARE_OBJECTDELETED(_CheckBox)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxCheckBox* wxCheckBox_ctor()
{
    return new _CheckBox();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCheckBox_Create(wxCheckBox* self, wxWindow* parent, int id,
                       wxc_string label, const wxPoint* pos,
                       const wxSize* size, int style, const wxValidator* val,
                       wxc_string name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (val == NULL)
        val = &wxDefaultValidator;
	
   	if (name.data==NULL)
		name = wxc_string("checkbox");


    return self->Create(parent, id, wxstr(label), *pos, *size, style,
                        *val, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCheckBox_GetValue(wxCheckBox* self)
{
    return self->GetValue()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCheckBox_SetValue(wxCheckBox* self, wxc_bool state)
{
    self->SetValue(state);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCheckBox_IsChecked(wxCheckBox* self)
{
    return self->IsChecked()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCheckBoxState wxCheckBox_Get3StateValue(wxCheckBox* self)
{
	return self->Get3StateValue();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCheckBox_Set3StateValue(wxCheckBox* self, wxCheckBoxState state)
{
	self->Set3StateValue(state);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCheckBox_Is3State(wxCheckBox* self)
{
	return self->Is3State()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxCheckBox_Is3rdStateAllowedForUser(wxCheckBox* self)
{
	return self->Is3rdStateAllowedForUser()?1:0;
}

