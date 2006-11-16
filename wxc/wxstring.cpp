//-----------------------------------------------------------------------------
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

class _wxString : public wxString
{
public:
    _wxString(const char *psz, wxMBConv& conv)
        : wxString(psz, conv) { }
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxString_ctor(char* str)
{
	return new _wxString(str, wxConvUTF8);
}

extern "C" WXEXPORT
void wxString_dtor(wxString *self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const char* wxString_mb_str(wxString* self)
{
	return (const char*)self->mb_str(wxConvUTF8);
}

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

//-----------------------------------------------------------------------------
