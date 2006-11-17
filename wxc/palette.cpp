//-----------------------------------------------------------------------------
// wxD - palette.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - palette.cxx
//
// The wxPalette proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/palette.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPalette* wxPalette_ctor()
{
	return new wxPalette();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPalette_dtor(wxPalette* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPalette_Ok(wxPalette* self)
{
	return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPalette_Create(wxPalette* self, int n, const unsigned char *red,
					  const unsigned char *green, const unsigned char *blue)
{
	return self->Create(n, red, green, blue)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxPalette_GetPixel(wxPalette* self, const unsigned char red,
					   const unsigned char green, const unsigned char blue)
{
	return self->GetPixel(red, green, blue);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxPalette_GetRGB(wxPalette* self, int pixel, unsigned char *red,
					  unsigned char *green, unsigned char *blue)
{
	return self->GetRGB(pixel, red, green, blue)?1:0;
}
