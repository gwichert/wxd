//-----------------------------------------------------------------------------
// wxD - accel.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - accel.cxx
//
// The wxAccelerator* proxy interfaces
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

class _AcceleratorEntry : public wxAcceleratorEntry
{
public:
	_AcceleratorEntry(int flags, int keyCode, int cmd, wxMenuItem* item)
		: wxAcceleratorEntry(flags, keyCode, cmd, item) {}

	DECLARE_DISPOSABLE(_AcceleratorEntry)
};

extern "C" WXEXPORT
wxAcceleratorEntry* wxAcceleratorEntry_ctor(int flags, int keyCode, int cmd, wxMenuItem* item)
{
	return new _AcceleratorEntry(flags, keyCode, cmd, item);
}

extern "C" WXEXPORT
void wxAcceleratorEntry_RegisterDisposable(_AcceleratorEntry* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxAcceleratorEntry_dtor(wxAcceleratorEntry* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxAcceleratorEntry_Set(wxAcceleratorEntry* self, int flags, int keyCode, int cmd, wxMenuItem* item)
{
	self->Set(flags, keyCode, cmd, item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxAcceleratorEntry_SetMenuItem(wxAcceleratorEntry* self, wxMenuItem* item)
{
	self->SetMenuItem(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxAcceleratorEntry_GetFlags(wxAcceleratorEntry* self)
{
	return self->GetFlags();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxAcceleratorEntry_GetKeyCode(wxAcceleratorEntry* self)
{
	return self->GetKeyCode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxAcceleratorEntry_GetCommand(wxAcceleratorEntry* self)
{
	return self->GetCommand();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenuItem* wxAcceleratorEntry_GetMenuItem(wxAcceleratorEntry* self)
{
	return self->GetMenuItem();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxAcceleratorEntry* wxAcceleratorEntry_GetAccelFromString(wxc_string label)
{
#if wxABI_VERSION < 20700
	return wxGetAccelFromString(wxstr(label));
#else
	return wxAcceleratorEntry::Create(wxstr(label));
#endif
}

//-----------------------------------------------------------------------------
// wxAcceleratorTable

extern "C" WXEXPORT
wxAcceleratorTable* wxAcceleratorTable_ctor()
{
	return new wxAcceleratorTable();
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
wxAcceleratorTable* wxAcceleratorTable_ctor2(int n, wxAcceleratorEntry* entries)
{
	wxAcceleratorTable(n, entries);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxAcceleratorTable_Ok(wxAcceleratorTable* self)
{
	return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
int wxAcceleratorTable_GetCommand(wxAcceleratorTable* self, wxKeyEvent* event)
{
	return self->GetCommand(*event);
}*/

//-----------------------------------------------------------------------------

#ifndef __WXMAC__
/*extern "C" WXEXPORT
void wxAcceleratorTable_Add(wxAcceleratorTable* self, wxAcceleratorEntry* entry)
{
	self->Add(*entry);
}*/

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
void wxAcceleratorTable_Remove(wxAcceleratorTable* self, wxAcceleratorEntry* entry)
{
	self->Remove(*entry);
}*/

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
wxMenuItem* wxAcceleratorTable_GetMenuItem(wxAcceleratorTable* self, wxKeyEvent* event)
{
	return self->GetMenuItem(*event);
}*/

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
const wxAcceleratorEntry* wxAcceleratorTable_GetEntry(wxAcceleratorTable* self, wxKeyEvent* event)
{
	return self->GetEntry(*event);
}*/

#endif

