//-----------------------------------------------------------------------------
// wxD - wizard.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - wizard.cxx
//
// The wxWizard proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/wizard.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _Wizard : public wxWizard
{
public:
	_Wizard(wxWindow* parent, wxWindowID id, const wxString& title,
			const wxBitmap& bitmap, const wxPoint& pos, long style)
		: wxWizard(parent, id, title, bitmap, pos, style) { }

    DECLARE_OBJECTDELETED(_Wizard)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxWizard* wxWizard_ctor(wxWindow* parent, int id, wxc_string title, const wxBitmap* bitmap, const wxPoint* pos, long style)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (bitmap == NULL)
		bitmap = &wxNullBitmap;

	return new _Wizard(parent, id, wxstr(title), *bitmap, *pos, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWizard_RunWizard(wxWizard* self, wxWizardPage* firstPage)
{
	return self->RunWizard(firstPage)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWizard_SetPageSize(wxWizard* self, const wxSize* size)
{
	self->SetPageSize(*size);
}

//-----------------------------------------------------------------------------
// The proxy class

class _WizardPageSimple : public wxWizardPageSimple
{
public:
#if wxABI_VERSION < 20900
	_WizardPageSimple(wxWizard* parent, wxWizardPage* prev, wxWizardPage* next,const wxBitmap& bitmap,const wxChar* resource)
		: wxWizardPageSimple(parent, prev, next, bitmap, resource)
#else
	_WizardPageSimple(wxWizard* parent, wxWizardPage* prev, wxWizardPage* next,const wxBitmap& bitmap)
		: wxWizardPageSimple(parent, prev, next, bitmap)
#endif
	{
	}

	DECLARE_OBJECTDELETED(_WizardPageSimple)

#include "panel.inc"
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxWizardPageSimple* wxWizardPageSimple_ctor(wxWizard* parent, wxWizardPage* prev, wxWizardPage* next, const wxBitmap* bitmap, wxc_string resource)
{
	wxString wxresource = wxstr(resource);
#if wxABI_VERSION < 20900
	return new _WizardPageSimple(parent, prev, next, *bitmap, wxresource.c_str());
#else
	return new _WizardPageSimple(parent, prev, next, *bitmap);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWizardPageSimple_Chain(wxWizardPageSimple* page1, wxWizardPageSimple* page2)
{
	wxWizardPageSimple::Chain(page1, page2);
}


extern "C" WXEXPORT
wxWizardEvent* wxWizardEvent_ctor(wxEventType type,int id,wxc_bool direction, wxWizardPage* page)
{
	return new wxWizardEvent(type,id,direction,page);
}

extern "C" WXEXPORT
wxc_bool wxWizardEvent_GetDirection(wxWizardEvent* self)
{
	return self->GetDirection();
}

extern "C" WXEXPORT
wxWizardPage* wxWizardEvent_GetPage(wxWizardEvent* self)
{
	return self->GetPage();
}

extern "C" WXEXPORT int wxEvent_WIZARD_PAGE_CHANGED() { return wxEVT_WIZARD_PAGE_CHANGED; }
extern "C" WXEXPORT int wxEvent_WIZARD_PAGE_CHANGING() { return wxEVT_WIZARD_PAGE_CHANGING; }
extern "C" WXEXPORT int wxEvent_WIZARD_CANCEL() { return wxEVT_WIZARD_CANCEL; }
extern "C" WXEXPORT int wxEvent_WIZARD_HELP() { return wxEVT_WIZARD_HELP; }
extern "C" WXEXPORT int wxEvent_WIZARD_FINISHED() { return wxEVT_WIZARD_FINISHED; }
