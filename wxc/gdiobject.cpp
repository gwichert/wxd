//-----------------------------------------------------------------------------
// wxD - gdiobject.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - gdiobject.cxx
//
// The wxGDIObject proxy interface.
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
void wxGDIObj_dtor(wxGDIObject* self)
{
	delete self;
}


