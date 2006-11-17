//-----------------------------------------------------------------------------
// wxD - clipboard.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - clipboard.cxx
//
// The wxClipBoard proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/clipbrd.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxClipboard* wxClipboard_ctor()
{
    return new wxClipboard();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboard_Open(wxClipboard* self)
{
    return self->Open()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxClipboard_Close(wxClipboard* self)
{
    self->Close();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboard_IsOpened(wxClipboard* self)
{
    return self->IsOpened()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboard_AddData(wxClipboard* self, wxDataObject* data)
{
    return self->AddData(data)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboard_SetData(wxClipboard* self, wxDataObject* data)
{
    return self->SetData(data)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboard_IsSupported(wxClipboard* self, wxDataFormat* format)
{
    return self->IsSupported(*format)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboard_GetData(wxClipboard* self, wxDataObject* data)
{
    return self->GetData(*data)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxClipboard_Clear(wxClipboard* self)
{
    self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboard_Flush(wxClipboard* self)
{
    return self->Flush()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxClipboard_UsePrimarySelection(wxClipboard* self, dbit primary)
{
	self->UsePrimarySelection(primary);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxClipboard* wxTheClipboard_static()
{
	return wxTheClipboard;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxClipboard* wxClipboard_Get()
{
	return wxClipboard::Get();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxClipboardLocker* wxClipBoardLocker_ctor(wxClipboard* clipboard)
{
	return new wxClipboardLocker(clipboard);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxClipBoardLocker_dtor(wxClipboardLocker* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxClipboardLocker_IsOpen(wxClipboardLocker* self)
{
	return !(*self)?1:0;
}
