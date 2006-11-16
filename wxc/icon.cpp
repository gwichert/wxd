//-----------------------------------------------------------------------------
// wx.NET - icon.cxx
//
// The wxIcon proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxIcon* wxIcon_ctor()
{
	return new wxIcon();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxIcon_CopyFromBitmap(wxIcon* self, const wxBitmap* bitmap)
{
	self->CopyFromBitmap(*bitmap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxIcon_LoadFile(wxIcon* self, const char* name, wxBitmapType type)
{
	return self->LoadFile(wxString(name, wxConvUTF8), type)?1:0;
}
