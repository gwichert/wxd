//-----------------------------------------------------------------------------
// wxD - object.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - object.cxx
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
#include "common.h"

#define CLASSNAME(name) \
	(new wxString(CLASSINFO(name)->GetClassName()))

#define OBJECTNAME(obj) \
	(new wxString(obj->GetClassInfo()->GetClassName()))

//-----------------------------------------------------------------------------

// Utility function to grab the C++ typename of a given pointer to a class.
extern "C" WXEXPORT
const wxString* wxObject_GetTypeName(wxObject* obj)
{
	return new wxString(obj->GetClassInfo()->GetClassName());
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
wxString* wxGetTranslation_func(wxc_string str)
{
	return new wxString(wxGetTranslation(wxstr(str)));
}

