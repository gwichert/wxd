//-----------------------------------------------------------------------------
// wxD - wxstring.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - wxstring.cxx
//
// The wxString proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

class _wxString : public wxString
{
public:
    _wxString(const wxChar *psz)
        : wxString(psz) { }
    _wxString(const wxChar* psz, wxMBConv& conv,size_t length)
        : wxString(psz, conv, length) { }
    _wxString(const wxString* str)
        : wxString(*str) { }
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxString_ctor(const wxChar* str)
{
	return new _wxString(str);
}

extern "C" WXEXPORT
wxString* wxString_ctor2(dstr str)
{
	return new _wxString(wxstr(str));
}

extern "C" WXEXPORT
void wxString_dtor(wxString *self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const size_t wxString_Length(wxString* self)
{
	return self->Length();
}

extern "C" WXEXPORT
const wxChar wxString_GetChar(wxString* self, size_t i)
{
	return self->GetChar(i);
}

extern "C" WXEXPORT
const wxChar* wxString_c_str(wxString* self)
{
	return self->c_str();
}

extern "C" WXEXPORT
dstrret wxString_d_str(wxString* self)
{
	return dstr_ret(*self);
}

//-----------------------------------------------------------------------------
