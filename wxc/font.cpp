//-----------------------------------------------------------------------------
// wxD - font.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - font.cxx
//
// The wxFont proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/font.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT wxFont* wxFont_NORMAL_FONT()	{ return wxNORMAL_FONT; }
extern "C" WXEXPORT wxFont* wxFont_SMALL_FONT()		{ return wxSMALL_FONT; }
extern "C" WXEXPORT wxFont* wxFont_ITALIC_FONT()	{ return wxITALIC_FONT; }
extern "C" WXEXPORT wxFont* wxFont_SWISS_FONT()		{ return wxSWISS_FONT; }

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxFont_ctorFromFont(wxFont* font)
{
    return new wxFont(*font);
}

extern "C" WXEXPORT
wxFont* wxFont_ctorDef()
{
    return new wxFont();
}

extern "C" WXEXPORT
wxFont* wxFont_ctor(int pointSize, int family, int style, int weight, const bool underline, dstr faceName, wxFontEncoding encoding)
{
	return new wxFont(pointSize, family, style, weight, underline, wxString(faceName.data, wxConvUTF8, faceName.length), encoding);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_dtor(wxFont* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFont_Ok(wxFont* self)
{
	return self->Ok();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFont_GetPointSize(wxFont* self)
{
	return self->GetPointSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFont_GetFamily(wxFont* self)
{
	return self->GetFamily();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFont_GetStyle(wxFont* self)
{
	return self->GetStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFont_GetWeight(wxFont* self)
{
	return self->GetWeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFont_GetUnderlined(wxFont* self)
{
	return self->GetUnderlined();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFont_GetFaceName(wxFont* self)
{
	return dstr_ret(self->GetFaceName().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFontEncoding wxFont_GetEncoding(wxFont* self)
{
	return self->GetEncoding();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxNativeFontInfo* wxFont_GetNativeFontInfo(wxFont* self)
{
	return self->GetNativeFontInfo();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFont_IsFixedWidth(wxFont* self)
{
	return self->IsFixedWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFont_GetNativeFontInfoDesc(wxFont* self)
{
	return dstr_ret(self->GetNativeFontInfoDesc());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFont_GetNativeFontInfoUserDesc(wxFont* self)
{
	return dstr_ret(self->GetNativeFontInfoUserDesc());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetPointSize(wxFont* self, int pointSize)
{
	self->SetPointSize(pointSize);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetFamily(wxFont* self, int family)
{
	self->SetFamily(family);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetStyle(wxFont* self, int style)
{
	self->SetStyle(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetWeight(wxFont* self, int weight)
{
	self->SetWeight(weight);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetFaceName(wxFont* self, dstr faceName)
{
	self->SetFaceName(wxString(faceName.data, wxConvUTF8, faceName.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetUnderlined(wxFont* self, bool underlined)
{
	self->SetUnderlined(underlined);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetEncoding(wxFont* self, wxFontEncoding encoding)
{
	self->SetEncoding(encoding);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetNativeFontInfoUserDesc(wxFont* self, dstr info)
{
	self->SetNativeFontInfoUserDesc(wxString(info.data, wxConvUTF8, info.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFont_GetFamilyString(wxFont* self)
{
	return dstr_ret(self->GetFamilyString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFont_GetStyleString(wxFont* self)
{
	return dstr_ret(self->GetStyleString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxFont_GetWeightString(wxFont* self)
{
	return dstr_ret(self->GetWeightString());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetNoAntiAliasing(wxFont* self, bool no)
{
	self->SetNoAntiAliasing(no);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxFont_GetNoAntiAliasing(wxFont* self)
{
	return self->GetNoAntiAliasing();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFontEncoding wxFont_GetDefaultEncoding()
{
	return wxFont::GetDefaultEncoding();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFont_SetDefaultEncoding(wxFontEncoding encoding)
{
	wxFont::SetDefaultEncoding(encoding);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxFont_New(dstr strNativeFontDesc)
{
	return wxFont::New(wxString(strNativeFontDesc.data, wxConvUTF8, strNativeFontDesc.length));
}
