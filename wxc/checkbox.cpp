//-----------------------------------------------------------------------------
// wxD - checkbox.cxx
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
bool wxCheckBox_Create(wxCheckBox* self, wxWindow* parent, int id,
                       dstr label, const wxPoint* pos,
                       const wxSize* size, int style, const wxValidator* val,
                       dstr name)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

    if (val == NULL)
        val = &wxDefaultValidator;
	
   	if (name.data==NULL)
		name = dstr("checkbox",sizeof("checkbox")-1);


    return self->Create(parent, id, wxString(label.data, wxConvUTF8, label.length), *pos, *size, style,
                        *val, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCheckBox_GetValue(wxCheckBox* self)
{
    return self->GetValue()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCheckBox_SetValue(wxCheckBox* self, bool state)
{
    self->SetValue(state);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCheckBox_IsChecked(wxCheckBox* self)
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
bool wxCheckBox_Is3State(wxCheckBox* self)
{
	return self->Is3State()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCheckBox_Is3rdStateAllowedForUser(wxCheckBox* self)
{
	return self->Is3rdStateAllowedForUser()?1:0;
}

