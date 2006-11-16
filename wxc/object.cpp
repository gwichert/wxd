//-----------------------------------------------------------------------------
// wx.NET - Object.cs
//
// The wxObject wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>

#define CLASSNAME(name) \
	(new wxString(CLASSINFO(name)->GetClassName()))

#define OBJECTNAME(obj) \
	(new wxString(obj->GetClassInfo()->GetClassName()))

//-----------------------------------------------------------------------------

// Utility function to grab the C++ typename of a given pointer to a class.
extern "C" WXEXPORT
const wxString* wxObject_GetTypeName(wxObject* obj)
{
	return OBJECTNAME(obj);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxObject_dtor(wxObject* self)
{
    if (self != NULL) {
        delete self;
    }
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxGetTranslation_func(const char* str)
{
	return new wxString(wxGetTranslation(wxString(str, wxConvUTF8)));
}

