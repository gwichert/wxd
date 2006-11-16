//-----------------------------------------------------------------------------
// wx.NET - htmlhelpctrl.cxx
// 
// The wxHtmlHelpController proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/html/helpctrl.h>

extern "C" WXEXPORT
wxHtmlHelpController* wxHtmlHelpController_ctor(int style)
{
	return new wxHtmlHelpController(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_SetTitleFormat(wxHtmlHelpController* self, const char* format)
{
	self->SetTitleFormat(wxString(format, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_SetTempDir(wxHtmlHelpController* self, const char* path)
{
	self->SetTempDir(wxString(path, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_AddBook(wxHtmlHelpController* self, const char* book_url)
{
	return self->AddBook(wxString(book_url, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_Display(wxHtmlHelpController* self, const char* x)
{
	return self->Display(wxString(x, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_DisplayInt(wxHtmlHelpController* self, int id)
{
	return self->Display(id)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_DisplayContents(wxHtmlHelpController* self)
{
	return self->DisplayContents()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_DisplayIndex(wxHtmlHelpController* self)
{
	return self->DisplayIndex()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_KeywordSearch(wxHtmlHelpController* self, const char* keyword, wxHelpSearchMode mode)
{
	return self->KeywordSearch(wxString(keyword, wxConvUTF8), mode)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_UseConfig(wxHtmlHelpController* self, wxConfigBase* config, const char* rootpath)
{
	self->UseConfig(config, wxString(rootpath, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_ReadCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, const char* path)
{
	self->ReadCustomization(cfg, wxString(path, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_WriteCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, const char* path)
{
	self->WriteCustomization(cfg, wxString(path, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlHelpFrame* wxHtmlHelpController_GetFrame(wxHtmlHelpController* self)
{
	return self->GetFrame();
}




