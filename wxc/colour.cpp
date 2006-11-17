//-----------------------------------------------------------------------------
// wxD - colour.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - colour.cxx
//
// The wxColour proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------

/*class _Colour : public wxColour
{
public:
	_Colour()
		: wxColour() {}
		
	_Colour(const wxString& colourNname)
		: wxColour(colourNname) {}
		
	_Colour(const unsigned char red, const unsigned char green, const unsigned char blue)	
		: wxColour(red, green, blue) {}

	DECLARE_DISPOSABLE(_Colour)
};*/

extern "C" WXEXPORT
wxColour* wxColour_ctor()
{
	return new wxColour();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColour_dtor(wxColour* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxColour_ctorByName(dstr name)
{
	return new wxColour(wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxColour_ctorByParts(unsigned char red, unsigned char green, unsigned char blue)
{
	return new wxColour(red, green, blue);
}

/*extern "C" WXEXPORT
void wxColour_RegisterDisposable(_Colour* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxColour_Blue(wxColour* self)
{
	return self->Blue();
}

extern "C" WXEXPORT
unsigned char wxColour_Red(wxColour* self)
{
	return self->Red();
}

extern "C" WXEXPORT
unsigned char wxColour_Green(wxColour* self)
{
	return self->Green();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxColour_Ok(wxColour* self)
{
	return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxColour_Set(wxColour* self, unsigned char red, unsigned char green, unsigned char blue)
{
	self->Set(red, green, blue);
}

//-----------------------------------------------------------------------------

#ifdef __WXGTK__
extern "C" WXEXPORT
wxColour* wxColour_CreateByName(dstr name)
{
	return new wxColour(wxColour::CreateByName(wxString(name.data, wxConvUTF8, name.length)));
}
#endif
