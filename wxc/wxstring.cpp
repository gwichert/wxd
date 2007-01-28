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
wxString* wxString_ctor(wxc_string str)
{
	return new _wxString(wxstr(str));
}

extern "C" WXEXPORT
wxString* wxString_ctor2(const wxChar* str, size_t len)
{
	return new _wxString(str, *wxConvCurrent, len);
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
	return self->length();
}

extern "C" WXEXPORT
const wxChar* wxString_Data(wxString* self)
{
	return self->c_str();
}

extern "C" WXEXPORT
const wxChar wxString_GetChar(wxString* self, size_t i)
{
	return self->GetChar(i);
}

extern "C" WXEXPORT
void wxString_SetChar(wxString* self, size_t i, wxChar c)
{
	self->SetChar(i, c);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
size_t wxString_ansi_len(wxString* self)
{
#if !wxUSE_UNICODE
	return self->length();
#else
	return wxConvCurrent->WC2MB(NULL, (const wchar_t*) self->c_str(), 0);
#endif
}

// NOTE: buffer should be long enough to hold the converted string and a NUL
extern "C" WXEXPORT
size_t wxString_ansi_str(wxString* self, char *buffer, size_t buflen)
{
	size_t length = self->length();

#if !wxUSE_UNICODE
	memcpy(buffer, (const char*) self->c_str(),
	      ((length > buflen) ? buflen : length) * sizeof(char));
#else
	length = wxConvCurrent->WC2MB(buffer, (const wchar_t*) self->c_str(), buflen);
#endif

	return length;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
size_t wxString_wide_len(wxString* self)
{
#if wxUSE_UNICODE
	return self->length();
#else
	return wxConvCurrent->MB2WC(NULL, (const char*) self->c_str(), 0);
#endif
}

// NOTE: buffer should be long enough to hold the converted string and a NUL
extern "C" WXEXPORT
size_t wxString_wide_str(wxString* self, wchar_t *buffer, size_t buflen)
{
	size_t length = self->length();

#if wxUSE_UNICODE
	memcpy(buffer, (const wchar_t*) self->c_str(),
	      ((length > buflen) ? buflen : length) * sizeof(wchar_t));
#else
	length = wxConvCurrent->MB2WC(buffer, (const char*) self->c_str(), buflen);
#endif

	return length;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
size_t wxString_utf8_len(wxString* self)
{
#if !wxUSE_UNICODE
	if (wxConvCurrent == &wxConvUTF8)
		return self->length();
	else
	    // convert local ansi encoding to wide chars first (fall-through)
#endif
	return wxConvUTF8.WC2MB(NULL, (const wchar_t*) self->wc_str(*wxConvCurrent), 0);
}

// NOTE: buffer should be long enough to hold the converted string and a NUL
extern "C" WXEXPORT
size_t wxString_utf8_str(wxString* self, char *buffer, size_t buflen)
{
	size_t length = self->length();

#if !wxUSE_UNICODE
	if (wxConvCurrent == &wxConvUTF8)
		memcpy(buffer, (const char*) self->c_str(),
		      ((length > buflen) ? buflen : length) * sizeof(char));
	else
	    // convert local ansi encoding to wide chars first (fall-through)
#endif
	length = wxConvUTF8.WC2MB(buffer, (const wchar_t*) self->wc_str(*wxConvCurrent), buflen);
	fprintf(stderr, "Converted %ls to %s\n", (const wchar_t*) self->wc_str(*wxConvCurrent), buffer);

	return length;
}

//-----------------------------------------------------------------------------
