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
wxc_bool wxLocale_Init(wxLocale* self, int language, int flags)
{
	return self->Init(language, flags)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxLocale_AddCatalog(wxLocale* self, wxc_string szDomain)
{
	return self->AddCatalog(wxstr(szDomain))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxLocale_AddCatalog2(wxLocale* self, wxc_string szDomain, wxLanguage msgIdLanguage, wxc_string msgIdCharset)
{
	return self->AddCatalog(wxstr(szDomain), msgIdLanguage, wxstr(msgIdCharset));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLocale_AddCatalogLookupPathPrefix(wxLocale* self, wxc_string prefix)
{
	self->AddCatalogLookupPathPrefix(wxstr(prefix));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLocale_AddLanguage(wxLanguageInfo* info)
{
	wxLocale::AddLanguage(*info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxLanguageInfo* wxLocale_FindLanguageInfo(wxc_string locale)
{
	return wxLocale::FindLanguageInfo(wxstr(locale));
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
dstrret wxLocale_GetString(wxLocale* self, wxc_string szOrigString, wxc_string szDomain)
{
	return dstr_ret(self->GetString(wxstr(szOrigString), wxstr(szDomain)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLocale_GetHeaderValue(wxLocale* self, wxc_string szHeader, wxc_string szDomain)
{
	return dstr_ret(self->GetHeaderValue(wxstr(szHeader), wxstr(szDomain)));
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
wxc_bool wxLocale_IsLoaded(wxLocale* self, wxc_string domain)
{
	return self->IsLoaded(wxstr(domain))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxLocale_IsOk(wxLocale* self)
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
void wxLanguageInfo_SetCanonicalName(wxLanguageInfo* self, wxc_string name)
{
	self->CanonicalName = wxstr(name);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLanguageInfo_GetCanonicalName(wxLanguageInfo* self)
{
	return dstr_ret(self->CanonicalName);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLanguageInfo_SetDescription(wxLanguageInfo* self, wxc_string name)
{
	self->Description = wxstr(name);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxLanguageInfo_GetDescription(wxLanguageInfo* self)
{
	return dstr_ret(self->Description);
}

