//-----------------------------------------------------------------------------
// wxD - pickerbase.cpp
//
// The wxPickerBase proxy interface.
//
// Written by Gerrit Wichert (gwichert@yahoo.com)
// (C) 2013 by Gerrit Wichert
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/pickerbase.h>
//#include "local_events.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPickerBase_SetInternalMargin(wxPickerBase *self, int margin)
{
	self->SetInternalMargin(margin);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPickerBase_GetInternalMargin(wxPickerBase *self)
{
	return self->GetInternalMargin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPickerBase_SetTextCtrlProportion(wxPickerBase *self, int prop)
{
	self->SetTextCtrlProportion(prop);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPickerBase_SetPickerCtrlProportion(wxPickerBase *self, int prop)
{
	self->SetPickerCtrlProportion(prop);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPickerBase_GetTextCtrlProportion(wxPickerBase *self)
{
	return self->GetTextCtrlProportion();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPickerBase_GetPickerCtrlProportion(wxPickerBase *self)
{
    return self->GetPickerCtrlProportion();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPickerBase_HasTextCtrl(wxPickerBase* self)
{
	return self->HasTextCtrl() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTextCtrl* wxPickerBase_GetTextCtrl(wxPickerBase* self)
{
	return self->GetTextCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPickerBase_IsTextCtrlGrowable(wxPickerBase* self)
{
	return self->IsTextCtrlGrowable() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPickerBase_SetTextCtrlGrowable(wxPickerBase* self, wxc_bool grow)
{
	self->SetTextCtrlGrowable(grow);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPickerBase_IsPickerCtrlGrowable(wxPickerBase* self)
{
	return self->IsPickerCtrlGrowable() ? 1 : 0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPickerBase_SetPickerCtrlGrowable(wxPickerBase* self, wxc_bool grow)
{
	self->SetPickerCtrlGrowable( grow);
}
