//-----------------------------------------------------------------------------
// wxD - fontmisc.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - fontmisc.cxx
//
// Misc font proxy interfaces
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/fontmap.h>
#include <wx/encconv.h>
#include <wx/fontenum.h>
#include "local_events.h"

extern "C" WXEXPORT
wxFontMapper* wxFontMapper_ctor()
{
	return new wxFontMapper();
}

extern "C" WXEXPORT
void wxFontMapper_dtor(wxFontMapper* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
wxFontMapper* wxFontMapper_Get()
{
	return wxFontMapper::Get();
}

extern "C" WXEXPORT
wxFontMapper* wxFontMapper_Set(wxFontMapper* mapper)
{
	return wxFontMapper::Set(mapper);
}

extern "C" WXEXPORT
size_t wxFontMapper_GetSupportedEncodingsCount()
{
	return wxFontMapper::GetSupportedEncodingsCount();
}

extern "C" WXEXPORT
wxFontEncoding wxFontMapper_GetEncoding(size_t n)
{
	return wxFontMapper::GetEncoding(n);
}

extern "C" WXEXPORT
dstrret wxFontMapper_GetEncodingName(wxFontEncoding encoding)
{
	return dstr_ret(wxFontMapper::GetEncodingName(encoding));
}

extern "C" WXEXPORT
wxFontEncoding wxFontMapper_GetEncodingFromName(wxc_string name)
{
	return wxFontMapper::GetEncodingFromName(wxstr(name));
}

extern "C" WXEXPORT
wxFontEncoding wxFontMapper_CharsetToEncoding(wxFontMapper* self, wxc_string charset, wxc_bool interactive)
{
	return self->CharsetToEncoding(wxstr(charset), interactive);
}

extern "C" WXEXPORT
wxc_bool wxFontMapper_IsEncodingAvailable(wxFontMapper* self, wxFontEncoding encoding, wxc_string facename)
{
	return self->IsEncodingAvailable(encoding, wxstr(facename));
}

extern "C" WXEXPORT
wxc_bool wxFontMapper_GetAltForEncoding(wxFontMapper* self, wxFontEncoding encoding, wxFontEncoding *alt_encoding, wxc_string facename, wxc_bool interactive)
{
	return self->GetAltForEncoding(encoding, alt_encoding, wxstr(facename), interactive);
}

extern "C" WXEXPORT
dstrret wxFontMapper_GetEncodingDescription(wxFontEncoding encoding)
{
	return dstr_ret(wxFontMapper::GetEncodingDescription(encoding));
}

extern "C" WXEXPORT
void wxFontMapper_SetDialogParent(wxFontMapper* self, wxWindow* parent)
{
	self->SetDialogParent(parent);
}

extern "C" WXEXPORT
void wxFontMapper_SetDialogTitle(wxFontMapper* self, wxc_string title)
{
	self->SetDialogTitle(wxstr(title));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxEncodingConverter* wxEncodingConverter_ctor()
{
	return new wxEncodingConverter();
}

extern "C" WXEXPORT
wxc_bool wxEncodingConverter_Init(wxEncodingConverter* self, wxFontEncoding input_enc, wxFontEncoding output_enc, int method)
{
	return self->Init(input_enc, output_enc, method);
}

extern "C" WXEXPORT
dstrret wxEncodingConverter_Convert(wxEncodingConverter* self, wxc_string input)
{
	return dstr_ret(self->Convert(wxstr(input)));
}

//-----------------------------------------------------------------------------

typedef wxc_bool (CALLBACK* Virtual_EnumerateFacenames) (wxc_object, wxFontEncoding, wxc_bool);
typedef wxc_bool (CALLBACK* Virtual_EnumerateEncodings)(wxc_object, wxc_string);
typedef wxc_bool (CALLBACK* Virtual_OnFacename) (wxc_object, wxc_string);
typedef wxc_bool (CALLBACK* Virtual_OnFontEncoding) (wxc_object, wxc_string, wxc_string);

class _FontEnumerator : public wxFontEnumerator
{
public:
	_FontEnumerator()
		: wxFontEnumerator() {}
		
	bool EnumerateFacenames(wxFontEncoding encoding, wxc_bool fixedWidthOnly)
		{ return m_EnumerateFacenames(m_dobj, encoding, fixedWidthOnly); }
		
	bool EnumerateEncodings(const wxString& facename)
		{ return m_EnumerateEncodings(m_dobj, wxc_string(facename)); }
		
	bool OnFacename(const wxString& facename)
		{ return m_OnFacename(m_dobj, wxc_string(facename)); }
		
	bool OnFontEncoding(const wxString& facename, const wxString& encoding)
		{ return m_OnFontEncoding(m_dobj, wxc_string(facename), wxc_string(encoding)); }

	void RegisterVirtual(wxc_object obj,
		Virtual_EnumerateFacenames enumerateFacenames, 
		Virtual_EnumerateEncodings enumerateEncodings,
		Virtual_OnFacename onFacename,
		Virtual_OnFontEncoding onFontEncoding)
	{
		m_dobj = obj;
		m_EnumerateFacenames = enumerateFacenames;
		m_EnumerateEncodings = enumerateEncodings;
		m_OnFacename = onFacename;
		m_OnFontEncoding = onFontEncoding;
	}

private:
	Virtual_EnumerateFacenames m_EnumerateFacenames;
	Virtual_EnumerateEncodings m_EnumerateEncodings;
	Virtual_OnFacename m_OnFacename;
	Virtual_OnFontEncoding m_OnFontEncoding;
	wxc_object m_dobj;
};

extern "C" WXEXPORT
wxFontEnumerator* wxFontEnumerator_ctor()
{
	return new _FontEnumerator();
}

extern "C" WXEXPORT
void wxFontEnumerator_dtor(_FontEnumerator* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxFontEnumerator_RegisterVirtual(_FontEnumerator *self,wxc_object obj,
			Virtual_EnumerateFacenames enumerateFacenames,
			Virtual_EnumerateEncodings enumerateEncodings,
			Virtual_OnFacename onFacename,
			Virtual_OnFontEncoding onFontEncoding)
{
	self->RegisterVirtual(obj, enumerateFacenames, enumerateEncodings, onFacename, onFontEncoding);
}

extern "C" WXEXPORT
wxArrayString* wxFontEnumerator_GetFacenames(_FontEnumerator* self)
{
#if wxABI_VERSION < 20700
	wxArrayString* was = new wxArrayString();
	was = self->GetFacenames();
#else
	wxArrayString* was = new wxArrayString(self->GetFacenames());
#endif
	return was;
}

extern "C" WXEXPORT
wxArrayString* wxFontEnumerator_GetEncodings(_FontEnumerator* self)
{
#if wxABI_VERSION < 20700
	wxArrayString* was = new wxArrayString();
	was = self->GetEncodings();
#else
	wxArrayString* was = new wxArrayString(self->GetEncodings());
#endif
	return was;
}

extern "C" WXEXPORT
wxc_bool wxFontEnumerator_OnFacename(_FontEnumerator* self, wxc_string facename )
{
	return self->wxFontEnumerator::OnFacename(wxstr(facename));
}

extern "C" WXEXPORT
wxc_bool wxFontEnumerator_OnFontEncoding(_FontEnumerator* self, wxc_string facename, wxc_string encoding)
{
	return self->wxFontEnumerator::OnFontEncoding(wxstr(facename), wxstr(encoding));
}

extern "C" WXEXPORT
wxc_bool wxFontEnumerator_EnumerateFacenames(_FontEnumerator* self, wxFontEncoding encoding, wxc_bool fixedWidthOnly)
{
	return self->wxFontEnumerator::EnumerateFacenames(encoding, fixedWidthOnly);
}

extern "C" WXEXPORT
wxc_bool wxFontEnumerator_EnumerateEncodings(_FontEnumerator* self, wxc_string facename)
{
	return self->wxFontEnumerator::EnumerateEncodings(wxstr(facename));
}

