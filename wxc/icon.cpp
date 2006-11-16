//-----------------------------------------------------------------------------
// wxD - icon.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"

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
bool wxIcon_LoadFile(wxIcon* self, dstr name, wxBitmapType type)
{
	return self->LoadFile(wxString(name.data, wxConvUTF8, name.length), type)?1:0;
}
