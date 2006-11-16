//-----------------------------------------------------------------------------
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
bool wxLocale_AddCatalog(wxLocale* self, const char* szDomain)
{
	return self->AddCatalog(wxString(szDomain, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLocale_AddCatalog2(wxLocale* self, const char* szDomain, wxLanguage msgIdLanguage, const char* msgIdCharset)
{
	return self->AddCatalog(wxString(szDomain, wxConvUTF8), msgIdLanguage, wxString(msgIdCharset, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLocale_AddCatalogLookupPathPrefix(wxLocale* self, const char* prefix)
{
	self->AddCatalogLookupPathPrefix(wxString(prefix, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLocale_AddLanguage(wxLanguageInfo* info)
{
	wxLocale::AddLanguage(*info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxLanguageInfo* wxLocale_FindLanguageInfo(const char* locale)
{
	return wxLocale::FindLanguageInfo(wxString(locale, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLocale_GetCanonicalName(wxLocale* self)
{
	return new wxString(self->GetCanonicalName());
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
wxString* wxLocale_GetLanguageName(int lang)
{
	return new wxString(wxLocale::GetLanguageName(lang));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLocale_GetLocale(wxLocale* self)
{
	return new wxString(self->GetLocale());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLocale_GetName(wxLocale* self)
{
	return new wxString(self->GetName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLocale_GetString(wxLocale* self, const char* szOrigString, const char* szDomain)
{
	return new wxString(self->GetString(wxString(szOrigString, wxConvUTF8), wxString(szDomain, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLocale_GetHeaderValue(wxLocale* self, const char* szHeader, const char* szDomain)
{
	return new wxString(self->GetHeaderValue(wxString(szHeader, wxConvUTF8), wxString(szDomain, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLocale_GetSysName(wxLocale* self)
{
	return new wxString(self->GetSysName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFontEncoding wxLocale_GetSystemEncoding()
{
	return wxLocale::GetSystemEncoding();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLocale_GetSystemEncodingName()
{
	return new wxString(wxLocale::GetSystemEncodingName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxLocale_GetSystemLanguage()
{
	return wxLocale::GetSystemLanguage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxLocale_IsLoaded(wxLocale* self, const char* domain)
{
	return self->IsLoaded(wxString(domain, wxConvUTF8))?1:0;
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
void wxLanguageInfo_SetCanonicalName(wxLanguageInfo* self, const char* name)
{
	self->CanonicalName = wxString(name, wxConvUTF8);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLanguageInfo_GetCanonicalName(wxLanguageInfo* self)
{
	return new wxString(self->CanonicalName);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxLanguageInfo_SetDescription(wxLanguageInfo* self, const char* name)
{
	self->Description = wxString(name, wxConvUTF8);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxLanguageInfo_GetDescription(wxLanguageInfo* self)
{
	return new wxString(self->Description);
}

