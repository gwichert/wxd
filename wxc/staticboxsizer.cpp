//-----------------------------------------------------------------------------
// wxD - staticboxsizer.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - staticboxsizer.cxx
//
// The wxStaticBoxSizer proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/sizer.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStaticBoxSizer* wxStaticBoxSizer_ctor(wxStaticBox *box, int orient)
{
	return new wxStaticBoxSizer(box, orient);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxStaticBox* wxStaticBoxSizer_GetStaticBox(wxStaticBoxSizer* self)
{
	return self->GetStaticBox();
}

//-----------------------------------------------------------------------------
