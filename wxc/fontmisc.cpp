//-----------------------------------------------------------------------------
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
#include <wx/fontmap.h>
#include <wx/encconv.h>
#include <wx/fontenum.h>

#if defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif

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
wxString* wxFontMapper_GetEncodingName(wxFontEncoding encoding)
{
	return new wxString(wxFontMapper::GetEncodingName(encoding));
}

extern "C" WXEXPORT
wxFontEncoding wxFontMapper_GetEncodingFromName(const char* name)
{
	return wxFontMapper::GetEncodingFromName(wxString(name, wxConvUTF8));
}

extern "C" WXEXPORT
wxFontEncoding wxFontMapper_CharsetToEncoding(wxFontMapper* self, const char * charset, bool interactive)
{
	return self->CharsetToEncoding(wxString(charset, wxConvUTF8), interactive);
}

extern "C" WXEXPORT
bool wxFontMapper_IsEncodingAvailable(wxFontMapper* self, wxFontEncoding encoding, const char * facename)
{
	return self->IsEncodingAvailable(encoding, wxString(facename, wxConvUTF8));
}

extern "C" WXEXPORT
bool wxFontMapper_GetAltForEncoding(wxFontMapper* self, wxFontEncoding encoding, wxFontEncoding *alt_encoding, const char * facename, bool interactive)
{
	return self->GetAltForEncoding(encoding, alt_encoding, wxString(facename, wxConvUTF8), interactive);
}

extern "C" WXEXPORT
wxString* wxFontMapper_GetEncodingDescription(wxFontEncoding encoding)
{
	return new wxString(wxFontMapper::GetEncodingDescription(encoding));
}

extern "C" WXEXPORT
void wxFontMapper_SetDialogParent(wxFontMapper* self, wxWindow* parent)
{
	self->SetDialogParent(parent);
}

extern "C" WXEXPORT
void wxFontMapper_SetDialogTitle(wxFontMapper* self, const char* title)
{
	self->SetDialogTitle(wxString(title, wxConvUTF8));
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
wxString* wxEncodingConverter_Convert(wxEncodingConverter* self, const char * input)
{
	return new wxString(self->Convert(wxString(input, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

typedef bool (CALLBACK* Virtual_EnumerateFacenames) (wxFontEncoding, bool);
typedef bool (CALLBACK* Virtual_EnumerateEncodings)(wxString*);
typedef bool (CALLBACK* Virtual_OnFacename) (wxString*);
typedef bool (CALLBACK* Virtual_OnFontEncoding) (wxString*, wxString*);

class _FontEnumerator : public wxFontEnumerator
{
public:
	_FontEnumerator()
		: wxFontEnumerator() {}
		
	bool EnumerateFacenames(wxFontEncoding encoding, bool fixedWidthOnly)
		{ return m_EnumerateFacenames(encoding, fixedWidthOnly); }
		
	bool EnumerateEncodings(const wxString& facename)
		{ return m_EnumerateEncodings(new wxString(facename)); }
		
	bool OnFacename(const wxString& facename)
		{ return m_OnFacename(new wxString(facename)); }
		
	bool OnFontEncoding(const wxString& facename, const wxString& encoding)
		{ return m_OnFontEncoding(new wxString(facename), new wxString(encoding)); }

	void RegisterVirtual(Virtual_EnumerateFacenames enumerateFacenames, 
		Virtual_EnumerateEncodings enumerateEncodings,
		Virtual_OnFacename onFacename,
		Virtual_OnFontEncoding onFontEncoding)
	{
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
void wxFontEnumerator_RegisterVirtual(_FontEnumerator *self,
			Virtual_EnumerateFacenames enumerateFacenames,
			Virtual_EnumerateEncodings enumerateEncodings,
			Virtual_OnFacename onFacename,
			Virtual_OnFontEncoding onFontEncoding)
{
	self->RegisterVirtual(enumerateFacenames, enumerateEncodings, onFacename, onFontEncoding);
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
bool wxFontEnumerator_OnFacename(_FontEnumerator* self, const char * facename )
{
	return self->wxFontEnumerator::OnFacename(wxString(facename, wxConvUTF8));
}

extern "C" WXEXPORT
bool wxFontEnumerator_OnFontEncoding(_FontEnumerator* self, const char* facename, const char* encoding)
{
	return self->wxFontEnumerator::OnFontEncoding(wxString(facename, wxConvUTF8), wxString(encoding, wxConvUTF8));
}

extern "C" WXEXPORT
bool wxFontEnumerator_EnumerateFacenames(_FontEnumerator* self, wxFontEncoding encoding, bool fixedWidthOnly)
{
	return self->wxFontEnumerator::EnumerateFacenames(encoding, fixedWidthOnly);
}

extern "C" WXEXPORT
bool wxFontEnumerator_EnumerateEncodings(_FontEnumerator* self, const char* facename)
{
	return self->wxFontEnumerator::EnumerateEncodings(wxString(facename, wxConvUTF8));
}

