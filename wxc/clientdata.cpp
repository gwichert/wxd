//-----------------------------------------------------------------------------
// wx.NET - clientdata.cxx
//
// The wxClientData proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/textctrl.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _ClientData : public wxClientData
{
public:
	_ClientData()
		: wxClientData() {}

	DECLARE_DISPOSABLE(_ClientData)
};

extern "C" WXEXPORT
wxClientData* wxClientData_ctor()
{
    return new _ClientData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxClientData_dtor(wxClientData* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxClientData_RegisterDisposable(_ClientData* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------
// wxStringClientData

extern "C" WXEXPORT
wxStringClientData* wxStringClientData_ctor(const char* data)
{
	return new wxStringClientData(wxString(data, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStringClientData_dtor(wxStringClientData* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxStringClientData_SetData(wxStringClientData* self, const char* data)
{
	self->SetData(wxString(data, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxStringClientData_GetData(wxStringClientData* self)
{
	return new wxString(self->GetData());
}


