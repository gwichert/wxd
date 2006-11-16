//-----------------------------------------------------------------------------
// wxD - Object.cs
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"

#define CLASSNAME(name) \
	(new wxString(CLASSINFO(name)->GetClassName()))

#define OBJECTNAME(obj) \
	(new wxString(obj->GetClassInfo()->GetClassName()))

//-----------------------------------------------------------------------------

// Utility function to grab the C++ typename of a given pointer to a class.
extern "C" WXEXPORT
const dstr wxObject_GetTypeName(wxObject* obj)
{
	return dstr(obj->GetClassInfo()->GetClassName());
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
dstr wxGetTranslation_func(dstr str)
{
	return dstr(wxGetTranslation(wxString(str.data, wxConvUTF8, str.length)));
}

