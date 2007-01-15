//-----------------------------------------------------------------------------
// wxD - htmlhelpctrl.cpp
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
void wxHtmlHelpController_SetTitleFormat(wxHtmlHelpController* self, wxc_string format)
{
	self->SetTitleFormat(wxstr(format));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_SetTempDir(wxHtmlHelpController* self, wxc_string path)
{
	self->SetTempDir(wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxHtmlHelpController_AddBook(wxHtmlHelpController* self, wxc_string book_url)
{
	return self->AddBook(wxstr(book_url))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxHtmlHelpController_Display(wxHtmlHelpController* self, wxc_string x)
{
	return self->Display(wxstr(x))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxHtmlHelpController_DisplayInt(wxHtmlHelpController* self, int id)
{
	return self->Display(id)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxHtmlHelpController_DisplayContents(wxHtmlHelpController* self)
{
	return self->DisplayContents()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxHtmlHelpController_DisplayIndex(wxHtmlHelpController* self)
{
	return self->DisplayIndex()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxHtmlHelpController_KeywordSearch(wxHtmlHelpController* self, wxc_string keyword, wxHelpSearchMode mode)
{
	return self->KeywordSearch(wxstr(keyword), mode)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_UseConfig(wxHtmlHelpController* self, wxConfigBase* config, wxc_string rootpath)
{
	self->UseConfig(config, wxstr(rootpath));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_ReadCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, wxc_string path)
{
	self->ReadCustomization(cfg, wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_WriteCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, wxc_string path)
{
	self->WriteCustomization(cfg, wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlHelpFrame* wxHtmlHelpController_GetFrame(wxHtmlHelpController* self)
{
	return self->GetFrame();
}




