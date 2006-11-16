//-----------------------------------------------------------------------------
// wxD - locale.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - locale.cxx
//
// The wxLocale proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"

extern "C" WXEXPORT
wxLocale* wxLocale_ctor()
{
	return new wxLocale();
}

extern "C" WXEXPORT
wxLocale* wxLocale_ctor2(int language, int flags)
{
	return new wxLocale(language, flags);
}

extern "C" WXEXPORT
void wxLocale_dtor(wxLocale* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLocale_Init(wxLocale* self, int language, int flags)
{
	return self->Init(language, flags)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLocale_AddCatalog(wxLocale* self, dstr szDomain)
{
	return self->AddCatalog(wxString(szDomain.data, wxConvUTF8, szDomain.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLocale_AddCatalog2(wxLocale* self, dstr szDomain, wxLanguage msgIdLanguage, dstr msgIdCharset)
{
	return self->AddCatalog(wxString(szDomain.data, wxConvUTF8, szDomain.length), msgIdLanguage, wxString(msgIdCharset.data, wxConvUTF8, msgIdCharset.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLocale_AddCatalogLookupPathPrefix(wxLocale* self, dstr prefix)
{
	self->AddCatalogLookupPathPrefix(wxString(prefix.data, wxConvUTF8, prefix.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLocale_AddLanguage(wxLanguageInfo* info)
{
	wxLocale::AddLanguage(*info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxLanguageInfo* wxLocale_FindLanguageInfo(dstr locale)
{
	return wxLocale::FindLanguageInfo(wxString(locale.data, wxConvUTF8, locale.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetCanonicalName(wxLocale* self)
{
	return dstr_ret(self->GetCanonicalName());
}
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxLocale_GetLanguage(wxLocale* self)
{
	return self->GetLanguage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxLanguageInfo* wxLocale_GetLanguageInfo(int lang)
{
	return wxLocale::GetLanguageInfo(lang);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetLanguageName(int lang)
{
	return dstr_ret(wxLocale::GetLanguageName(lang));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetLocale(wxLocale* self)
{
	return dstr_ret(self->GetLocale());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetName(wxLocale* self)
{
	return dstr_ret(self->GetName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetString(wxLocale* self, dstr szOrigString, dstr szDomain)
{
	return dstr_ret(self->GetString(wxString(szOrigString.data, wxConvUTF8, szOrigString.length), wxString(szDomain.data, wxConvUTF8, szDomain.length)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetHeaderValue(wxLocale* self, dstr szHeader, dstr szDomain)
{
	return dstr_ret(self->GetHeaderValue(wxString(szHeader.data, wxConvUTF8, szHeader.length), wxString(szDomain.data, wxConvUTF8, szDomain.length)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetSysName(wxLocale* self)
{
	return dstr_ret(self->GetSysName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFontEncoding wxLocale_GetSystemEncoding()
{
	return wxLocale::GetSystemEncoding();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetSystemEncodingName()
{
	return dstr_ret(wxLocale::GetSystemEncodingName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxLocale_GetSystemLanguage()
{
	return wxLocale::GetSystemLanguage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLocale_IsLoaded(wxLocale* self, dstr domain)
{
	return self->IsLoaded(wxString(domain.data, wxConvUTF8, domain.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLocale_IsOk(wxLocale* self)
{
	return self->IsOk()?1:0;
}

//-----------------------------------------------------------------------------
// wxLanguageInfo

extern "C" WXEXPORT
wxLanguageInfo* wxLanguageInfo_ctor()
{
	return new wxLanguageInfo();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLanguageInfo_dtor(wxLanguageInfo* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLanguageInfo_SetLanguage(wxLanguageInfo* self, int value)
{
	self->Language = value;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxLanguageInfo_GetLanguage(wxLanguageInfo* self)
{
	return self->Language;
} 

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLanguageInfo_SetCanonicalName(wxLanguageInfo* self, dstr name)
{
	self->CanonicalName = wxString(name.data, wxConvUTF8, name.length);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLanguageInfo_GetCanonicalName(wxLanguageInfo* self)
{
	return dstr_ret(self->CanonicalName);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLanguageInfo_SetDescription(wxLanguageInfo* self, dstr name)
{
	self->Description = wxString(name.data, wxConvUTF8, name.length);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLanguageInfo_GetDescription(wxLanguageInfo* self)
{
	return dstr_ret(self->Description);
}

