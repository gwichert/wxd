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
void wxHtmlHelpController_SetTitleFormat(wxHtmlHelpController* self, dstr format)
{
	self->SetTitleFormat(wxstr(format));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_SetTempDir(wxHtmlHelpController* self, dstr path)
{
	self->SetTempDir(wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlHelpController_AddBook(wxHtmlHelpController* self, dstr book_url)
{
	return self->AddBook(wxstr(book_url))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlHelpController_Display(wxHtmlHelpController* self, dstr x)
{
	return self->Display(wxstr(x))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlHelpController_DisplayInt(wxHtmlHelpController* self, int id)
{
	return self->Display(id)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlHelpController_DisplayContents(wxHtmlHelpController* self)
{
	return self->DisplayContents()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlHelpController_DisplayIndex(wxHtmlHelpController* self)
{
	return self->DisplayIndex()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlHelpController_KeywordSearch(wxHtmlHelpController* self, dstr keyword, wxHelpSearchMode mode)
{
	return self->KeywordSearch(wxstr(keyword), mode)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_UseConfig(wxHtmlHelpController* self, wxConfigBase* config, dstr rootpath)
{
	self->UseConfig(config, wxstr(rootpath));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_ReadCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, dstr path)
{
	self->ReadCustomization(cfg, wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlHelpController_WriteCustomization(wxHtmlHelpController* self, wxConfigBase *cfg, dstr path)
{
	self->WriteCustomization(cfg, wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlHelpFrame* wxHtmlHelpController_GetFrame(wxHtmlHelpController* self)
{
	return self->GetFrame();
}




