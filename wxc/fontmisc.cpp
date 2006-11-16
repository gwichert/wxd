//-----------------------------------------------------------------------------
// wxD - fontmisc.cxx
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
wxFontEncoding wxFontMapper_GetEncodingFromName(dstr name)
{
	return wxFontMapper::GetEncodingFromName(wxString(name.data, wxConvUTF8, name.length));
}

extern "C" WXEXPORT
wxFontEncoding wxFontMapper_CharsetToEncoding(wxFontMapper* self, dstr charset, bool interactive)
{
	return self->CharsetToEncoding(wxString(charset.data, wxConvUTF8, charset.length), interactive);
}

extern "C" WXEXPORT
bool wxFontMapper_IsEncodingAvailable(wxFontMapper* self, wxFontEncoding encoding, dstr facename)
{
	return self->IsEncodingAvailable(encoding, wxString(facename.data, wxConvUTF8, facename.length));
}

extern "C" WXEXPORT
bool wxFontMapper_GetAltForEncoding(wxFontMapper* self, wxFontEncoding encoding, wxFontEncoding *alt_encoding, dstr facename, bool interactive)
{
	return self->GetAltForEncoding(encoding, alt_encoding, wxString(facename.data, wxConvUTF8, facename.length), interactive);
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
void wxFontMapper_SetDialogTitle(wxFontMapper* self, dstr title)
{
	self->SetDialogTitle(wxString(title.data, wxConvUTF8, title.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxEncodingConverter* wxEncodingConverter_ctor()
{
	return new wxEncodingConverter();
}

extern "C" WXEXPORT
bool wxEncodingConverter_Init(wxEncodingConverter* self, wxFontEncoding input_enc, wxFontEncoding output_enc, int method)
{
	return self->Init(input_enc, output_enc, method);
}

extern "C" WXEXPORT
dstrret wxEncodingConverter_Convert(wxEncodingConverter* self, dstr input)
{
	return dstr_ret(self->Convert(wxString(input.data, wxConvUTF8, input.length)));
}

//-----------------------------------------------------------------------------

typedef bool (CALLBACK* Virtual_EnumerateFacenames) (dobj, wxFontEncoding, bool);
typedef bool (CALLBACK* Virtual_EnumerateEncodings)(dobj, dstr);
typedef bool (CALLBACK* Virtual_OnFacename) (dobj, dstr);
typedef bool (CALLBACK* Virtual_OnFontEncoding) (dobj, dstr, dstr);

class _FontEnumerator : public wxFontEnumerator
{
public:
	_FontEnumerator()
		: wxFontEnumerator() {}
		
	bool EnumerateFacenames(wxFontEncoding encoding, bool fixedWidthOnly)
		{ return m_EnumerateFacenames(m_dobj, encoding, fixedWidthOnly); }
		
	bool EnumerateEncodings(const wxString& facename)
		{ return m_EnumerateEncodings(m_dobj, dstr(facename)); }
		
	bool OnFacename(const wxString& facename)
		{ return m_OnFacename(m_dobj, dstr(facename)); }
		
	bool OnFontEncoding(const wxString& facename, const wxString& encoding)
		{ return m_OnFontEncoding(m_dobj, dstr(facename), dstr(encoding)); }

	void RegisterVirtual(dobj obj,
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
	dobj m_dobj;
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
void wxFontEnumerator_RegisterVirtual(_FontEnumerator *self,dobj obj,
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
	wxArrayString* was = new wxArrayString();
	was = self->GetFacenames();
	return was;
}

extern "C" WXEXPORT
wxArrayString* wxFontEnumerator_GetEncodings(_FontEnumerator* self)
{
	wxArrayString* was = new wxArrayString();
	was = self->GetEncodings();
	return was;
}

extern "C" WXEXPORT
bool wxFontEnumerator_OnFacename(_FontEnumerator* self, dstr facename )
{
	return self->wxFontEnumerator::OnFacename(wxString(facename.data, wxConvUTF8, facename.length));
}

extern "C" WXEXPORT
bool wxFontEnumerator_OnFontEncoding(_FontEnumerator* self, dstr facename, dstr encoding)
{
	return self->wxFontEnumerator::OnFontEncoding(wxString(facename.data, wxConvUTF8, facename.length), wxString(encoding.data, wxConvUTF8, encoding.length));
}

extern "C" WXEXPORT
bool wxFontEnumerator_EnumerateFacenames(_FontEnumerator* self, wxFontEncoding encoding, bool fixedWidthOnly)
{
	return self->wxFontEnumerator::EnumerateFacenames(encoding, fixedWidthOnly);
}

extern "C" WXEXPORT
bool wxFontEnumerator_EnumerateEncodings(_FontEnumerator* self, dstr facename)
{
	return self->wxFontEnumerator::EnumerateEncodings(wxString(facename.data, wxConvUTF8, facename.length));
}

