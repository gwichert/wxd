//-----------------------------------------------------------------------------
// wx.NET - dataformat.cxx
// 
// wxDataFormat proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/dataobj.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDataFormat* wxDataFormat_ctor()
{
    return new wxDataFormat();
}

extern "C" WXEXPORT
void wxDataFormat_dtor(wxDataFormat* self)
{
	if (self != NULL) 
		delete self;
}

extern "C" WXEXPORT
wxDataFormat* wxDataFormat_ctorByType(wxDataFormatId type)
{
    return new wxDataFormat(type);
}

extern "C" WXEXPORT
wxDataFormat* wxDataFormat_ctorById(char* id)
{
    return new wxDataFormat(wxString(id, wxConvUTF8).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxDataFormat_GetId(wxDataFormat* self)
{
    return new wxString(self->GetId());
}

extern "C" WXEXPORT
void wxDataFormat_SetId(wxDataFormat* self, char* id)
{
    self->SetId(wxString(id, wxConvUTF8).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDataFormatId wxDataFormat_GetType(wxDataFormat* self)
{
    return (wxDataFormatId)self->GetType();
}

extern "C" WXEXPORT
void wxDataFormat_SetType(wxDataFormat* self, wxDataFormatId type)
{
    self->SetType(type);
}

