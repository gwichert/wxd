//-----------------------------------------------------------------------------
// wx.NET - xmlresource.cxx
//
// The wxXmlResource proxy interface.
//
// Written by Achim Breunig (achim.breunig@web.de)
// (C) 2003 Achim Breunig
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/xrc/xmlres.h>
#include <wx/fontenum.h>
#include <wx/fs_mem.h>
#include "local_events.h"

//-----------------------------------------------------------------------------
// C stubs for class methods

typedef wxObject* (CALLBACK* XmlSubclassCreate) (wxString*);

class XmlSubclassFactoryCS : public wxXmlSubclassFactory
{
public:
    XmlSubclassFactoryCS() { }

    wxObject *Create(const wxString& className)
        { return m_create(new wxString(className)); }

    void RegisterVirtual(XmlSubclassCreate create)
        { m_create = create; }

private:
    XmlSubclassCreate m_create;
};

extern "C" WXEXPORT
void wxXmlSubclassFactory_ctor(XmlSubclassCreate create)
{
    XmlSubclassFactoryCS *s_factory = new XmlSubclassFactoryCS();
    s_factory->RegisterVirtual(create);
    wxXmlResource::AddSubclassFactory(s_factory);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxXmlResource* wxXmlResource_ctorByFilemask(const char* filemask, int flags = wxXRC_USE_LOCALE)
{
	return new wxXmlResource(wxString(filemask, wxConvUTF8),flags);
}

extern "C" WXEXPORT
wxXmlResource* wxXmlResource_ctor(int flags)
{
	return new wxXmlResource(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxXmlResource_InitAllHandlers(wxXmlResource* self)
{
	self->InitAllHandlers();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxXmlResource_Load(wxXmlResource* self, const char* filemask)
{
	return self->Load(wxString(filemask, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxXmlResource_LoadFromByteArray(wxXmlResource* self, const char* filemask, char* data, size_t length)
{
	wxFileSystem::AddHandler(new wxMemoryFSHandler());
	wxMemoryFSHandler::AddFile(wxString(filemask, wxConvUTF8), data, length);

	wxString mem_name = wxString("memory:", wxConvUTF8) + wxString(filemask, wxConvUTF8) ;

	return self->Load(mem_name)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDialog* wxXmlResource_LoadDialog(wxXmlResource* self, wxWindow* parent, const char* name)
{
	return self->LoadDialog(parent, wxString(name, wxConvUTF8));
}

extern "C" WXEXPORT
bool wxXmlResource_LoadDialogDlg(wxXmlResource* self, wxDialog* dlg, wxWindow* parent, const char* name)
{
	return self->LoadDialog(dlg, parent, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxXmlResource_GetXRCID(const char* str_id)
{
	return wxXmlResource::GetXRCID(wxString(str_id, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxXmlResource_GetVersion(wxXmlResource* self)
{
	return self->GetVersion();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxXmlResource_LoadFrameWithFrame(wxXmlResource* self, wxFrame* frame, wxWindow* parent, const char* name)
{
	return self->LoadFrame(frame, parent, wxString(name, wxConvUTF8))?1:0;
}

extern "C" WXEXPORT
wxFrame* wxXmlResource_LoadFrame(wxXmlResource* self, wxWindow* parent, const char* name)
{
	return self->LoadFrame(parent, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBitmap* wxXmlResource_LoadBitmap(wxXmlResource* self, const char* name)
{
	return new wxBitmap(self->LoadBitmap(wxString(name, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxIcon* wxXmlResource_LoadIcon(wxXmlResource* self, const char* name)
{
	return new wxIcon(self->LoadIcon(wxString(name, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxXmlResource_LoadMenu(wxXmlResource* self, const char* name)
{
	return self->LoadMenu(wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuBar* wxXmlResource_LoadMenuBarWithParent(wxXmlResource* self, wxWindow* parent, const char* name)
{
	return self->LoadMenuBar(parent,wxString(name, wxConvUTF8));
}

extern "C" WXEXPORT
wxMenuBar* wxXmlResource_LoadMenuBar(wxXmlResource* self, const char* name)
{
	return self->LoadMenuBar(wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxXmlResource_LoadPanelWithPanel(wxXmlResource* self, wxPanel* panel, wxWindow* parent, const char* name)
{
	return self->LoadPanel(panel, parent, wxString(name, wxConvUTF8))?1:0;
}

extern "C" WXEXPORT
wxPanel* wxXmlResource_LoadPanel(wxXmlResource* self, wxWindow* parent, const char* name)
{
	return self->LoadPanel(parent, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBar* wxXmlResource_LoadToolBar(wxXmlResource* self, wxWindow* parent, const char* name)
{
	return self->LoadToolBar(parent, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxXmlResource_SetFlags(wxXmlResource* self, int flags)
{
	self->SetFlags(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxXmlResource_GetFlags(wxXmlResource* self)
{
	return self->GetFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxXmlResource_CompareVersion(wxXmlResource* self, int major, int minor, int release, int revision)
{
	return self->CompareVersion(major, minor, release, revision);
}

//-----------------------------------------------------------------------------

/*
extern "C" WXEXPORT
void wxXmlResource_UpdateResources(wxXmlResource* self)
{
	self->UpdateResources();
}
*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxXmlResource_AttachUnknownControl(wxXmlResource* self, const char* name, wxWindow* control, wxWindow* parent)
{
	return self->AttachUnknownControl(wxString(name, wxConvUTF8), control, parent)?1:0;
}

