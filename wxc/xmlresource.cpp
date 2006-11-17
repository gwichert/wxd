//-----------------------------------------------------------------------------
// wxD - xmlresource.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
#include <wx/xrc/xmlres.h>
#include <wx/fontenum.h>
#include <wx/fs_mem.h>
#include "local_events.h"

//-----------------------------------------------------------------------------
// C stubs for class methods

typedef wxObject* (CALLBACK* XmlSubclassCreate) (dstr);

class XmlSubclassFactoryCS : public wxXmlSubclassFactory
{
public:
    XmlSubclassFactoryCS() { }

    wxObject *Create(const wxString& className)
        { return m_create(dstr(className)); }

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
wxXmlResource* wxXmlResource_ctorByFilemask(dstr filemask, int flags = wxXRC_USE_LOCALE)
{
	return new wxXmlResource(wxString(filemask.data, wxConvUTF8, filemask.length),flags);
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
dbit wxXmlResource_Load(wxXmlResource* self, dstr filemask)
{
	return self->Load(wxString(filemask.data, wxConvUTF8, filemask.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxXmlResource_LoadFromByteArray(wxXmlResource* self, dstr filemask, char* data, size_t length)
{
	wxFileSystem::AddHandler(new wxMemoryFSHandler());
	wxMemoryFSHandler::AddFile(wxString(filemask.data, wxConvUTF8, filemask.length), data, length);

	wxString mem_name = wxString("memory:", wxConvUTF8) + wxString(filemask.data, wxConvUTF8, filemask.length) ;

	return self->Load(mem_name)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDialog* wxXmlResource_LoadDialog(wxXmlResource* self, wxWindow* parent, dstr name)
{
	return self->LoadDialog(parent, wxString(name.data, wxConvUTF8, name.length));
}

extern "C" WXEXPORT
dbit wxXmlResource_LoadDialogDlg(wxXmlResource* self, wxDialog* dlg, wxWindow* parent, dstr name)
{
	return self->LoadDialog(dlg, parent, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxXmlResource_GetXRCID(dstr str_id)
{
	return wxXmlResource::GetXRCID(wxString(str_id.data, wxConvUTF8, str_id.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxXmlResource_GetVersion(wxXmlResource* self)
{
	return self->GetVersion();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxXmlResource_LoadFrameWithFrame(wxXmlResource* self, wxFrame* frame, wxWindow* parent, dstr name)
{
	return self->LoadFrame(frame, parent, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

extern "C" WXEXPORT
wxFrame* wxXmlResource_LoadFrame(wxXmlResource* self, wxWindow* parent, dstr name)
{
	return self->LoadFrame(parent, wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBitmap* wxXmlResource_LoadBitmap(wxXmlResource* self, dstr name)
{
	return new wxBitmap(self->LoadBitmap(wxString(name.data, wxConvUTF8, name.length)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxIcon* wxXmlResource_LoadIcon(wxXmlResource* self, dstr name)
{
	return new wxIcon(self->LoadIcon(wxString(name.data, wxConvUTF8, name.length)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxXmlResource_LoadMenu(wxXmlResource* self, dstr name)
{
	return self->LoadMenu(wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuBar* wxXmlResource_LoadMenuBarWithParent(wxXmlResource* self, wxWindow* parent, dstr name)
{
	return self->LoadMenuBar(parent,wxString(name.data, wxConvUTF8, name.length));
}

extern "C" WXEXPORT
wxMenuBar* wxXmlResource_LoadMenuBar(wxXmlResource* self, dstr name)
{
	return self->LoadMenuBar(wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxXmlResource_LoadPanelWithPanel(wxXmlResource* self, wxPanel* panel, wxWindow* parent, dstr name)
{
	return self->LoadPanel(panel, parent, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

extern "C" WXEXPORT
wxPanel* wxXmlResource_LoadPanel(wxXmlResource* self, wxWindow* parent, dstr name)
{
	return self->LoadPanel(parent, wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBar* wxXmlResource_LoadToolBar(wxXmlResource* self, wxWindow* parent, dstr name)
{
	return self->LoadToolBar(parent, wxString(name.data, wxConvUTF8, name.length));
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
dbit wxXmlResource_AttachUnknownControl(wxXmlResource* self, dstr name, wxWindow* control, wxWindow* parent)
{
	return self->AttachUnknownControl(wxString(name.data, wxConvUTF8, name.length), control, parent)?1:0;
}

