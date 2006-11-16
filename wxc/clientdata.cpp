//-----------------------------------------------------------------------------
// wxD - clientdata.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
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
wxStringClientData* wxStringClientData_ctor(dstr data)
{
	return new wxStringClientData(wxString(data.data, wxConvUTF8, data.length));
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
void wxStringClientData_SetData(wxStringClientData* self, dstr data)
{
	self->SetData(wxString(data.data, wxConvUTF8, data.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxStringClientData_GetData(wxStringClientData* self)
{
	return dstr_ret(self->GetData());
}


