//-----------------------------------------------------------------------------
// wxD - wxstring.cxx
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
    _wxString(const char* psz, wxMBConv& conv)
        : wxString(psz, conv) { }
    _wxString(const char* psz, wxMBConv& conv,size_t length)
        : wxString(psz, conv, length) { }
};

//-----------------------------------------------------------------------------


extern "C" WXEXPORT
wxString* wxString_ctor(const char* str)
{
	return new _wxString(str, wxConvUTF8);
}

extern "C" WXEXPORT
wxString* wxString_ctor2(dstr str)
{
	return new _wxString(str.data, wxConvUTF8, str.length);
}

extern "C" WXEXPORT
void wxString_dtor(wxString *self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

/*
extern "C" WXEXPORT
dstrret wxString_mb_str(wxString* self)
{
	return dstr_ret((const char*)self->mb_str(wxConvUTF8),self->length());
}
*/

extern "C" WXEXPORT
const size_t wxString_Length(wxString* self)
{
	return self->Length();
}

extern "C" WXEXPORT
const char wxString_CharAt(wxString* self, size_t i)
{
	return (const char)self->GetChar(i);
}

extern "C" WXEXPORT
int wxString_CharAtInt(wxString* self, size_t i)
{
		return (int)self->GetChar(i);
}

extern "C" WXEXPORT
const char* wxString_c_str(wxString* self, size_t i)
{
	return self->c_str();
}

extern "C" WXEXPORT
dstrret wxString_d_str(wxString* self, size_t i)
{
	return dstr_ret(self);
}

//-----------------------------------------------------------------------------
