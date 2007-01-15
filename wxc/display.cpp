//-----------------------------------------------------------------------------
// wxD - display.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET -	display.cxx
// 
// Mike	Muegel mike _at_ muegel dot org
//
// Licensed	under the wxWidgets	license, see LICENSE.txt for details.
// $Id$
//
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/display.h>
//#include <iostream>
//using namespace std;


#if wxUSE_DISPLAY

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDisplay* wxDisplay_ctor(int index)
{
	return new wxDisplay(index);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int	wxDisplay_GetCount()
{
	return wxDisplay::GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int	wxDisplay_GetFromPoint(wxPoint*	pt)
{
	return wxDisplay::GetFromPoint(*pt);
}

//-----------------------------------------------------------------------------

// Only WIN32 supports GetFromWindow :-(
#ifdef __WXMSW__
extern "C" WXEXPORT
int	wxDisplay_GetFromWindow(wxWindow* window)
{
	return wxDisplay::GetFromWindow(window);
}
#endif

//-----------------------------------------------------------------------------


extern "C" WXEXPORT
void wxDisplay_GetGeometry(wxDisplay* self,	wxRect*	rect)
{
	*rect =	self->GetGeometry();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxDisplay_GetName(wxDisplay* self)
{
	return dstr_ret(self->GetName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxDisplay_IsPrimary(wxDisplay*	self)
{
	// If I just return IsPrimary() it always returns true. I thought
	// this had something to do with how it is defined:
	//   wxc_bool IsPrimary() const { return m_index == 0; }
	// The const causing problems with Interop? The version
	// below works.
	return self->IsPrimary() == true;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDisplay_GetCurrentMode(wxDisplay* self, wxVideoMode*	mode)
{
	*mode =	self->GetCurrentMode();
}

//-----------------------------------------------------------------------------

// To keep memory management issues simple, getting an array of modes is done in
// two steps. First the C# wrapper determines how many modes there are
// by calling the GetNumModes. Then it can allocate a managed array of wxVideoMod
// structs and pass this to GetModes to fill in.
//
// A VideoMode with all 0 entries is passed to simulate wxDefaultVideoMode.

void FixMode(wxVideoMode& mode)
{
	if ((mode.bpp == 0) && (mode.refresh == 0) && (mode.h == 0) && (mode.w == 0))
		mode = wxDefaultVideoMode;
}

extern "C" WXEXPORT
int wxDisplay_GetNumModes(wxDisplay* self, wxVideoMode mode)
{
	FixMode(mode);
	wxArrayVideoModes tmp_modes = self->GetModes(mode);
	return tmp_modes.GetCount();
}

extern "C" WXEXPORT
void wxDisplay_GetModes(wxDisplay* self, wxVideoMode mode, wxVideoMode modes[])
{
	FixMode(mode);
    wxArrayVideoModes tmp_modes	= self->GetModes(mode);
	int num_modes = tmp_modes.GetCount();
	for	( int i	= 0; i < num_modes; i++ )
	{
		wxVideoMode& mode = tmp_modes[i];
		// cerr << "mode " << i << ", width=" << mode.GetWidth() << endl;
		modes[i] = mode;
	}
}


//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxDisplay_ChangeMode(wxDisplay* self, const wxVideoMode mode)
{
	return self->ChangeMode(mode)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDisplay_ResetMode(wxDisplay*	self)
{
	self->ResetMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDisplay_dtor(wxDisplay* self)
{
	delete self;
}


#else
#ifdef __GNUC__
#warning "wxUSE_DISPLAY is not set"
#endif
#endif

