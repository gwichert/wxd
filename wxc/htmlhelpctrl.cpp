//-----------------------------------------------------------------------------
// wxD - htmlhelpctrl.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
#include <wx/html/helpctrl.h>

extern "C" WXEXPORT
wxHtmlHelpController* wxHtmlHelpController_ctor(int style)
{
	return new wxHtmlHelpController(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_SetTitleFormat(wxHtmlHelpController* self, dstr format)
{
	self->SetTitleFormat(wxString(format.data, wxConvUTF8, format.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_SetTempDir(wxHtmlHelpController* self, dstr path)
{
	self->SetTempDir(wxString(path.data, wxConvUTF8, path.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_AddBook(wxHtmlHelpController* self, dstr book_url)
{
	return self->AddBook(wxString(book_url.data, wxConvUTF8, book_url.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlHelpController_Display(wxHtmlHelpController* self, dstr x)
{
	return self->Display(wxString(x.data, wxConvUTF8, x.length))?1:0;
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
bool wxHtmlHelpController_KeywordSearch(wxHtmlHelpController* self, dstr keyword, wxHelpSearchMode mode)
{
	return self->KeywordSearch(wxString(keyword.data, wxConvUTF8, keyword.length), mode)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_UseConfig(wxHtmlHelpController* self, wxConfigBase* config, dstr rootpath)
{
	self->UseConfig(config, wxString(rootpath.data, wxConvUTF8, rootpath.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_ReadCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, dstr path)
{
	self->ReadCustomization(cfg, wxString(path.data, wxConvUTF8, path.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_WriteCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, dstr path)
{
	self->WriteCustomization(cfg, wxString(path.data, wxConvUTF8, path.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlHelpFrame* wxHtmlHelpController_GetFrame(wxHtmlHelpController* self)
{
	return self->GetFrame();
}




