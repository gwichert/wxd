//-----------------------------------------------------------------------------
// wxD - cursor.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - cursor.cxx
//
// The wxCursor proxy interface.
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
wxCursor* wxCursor_ctorImage(wxImage* image)

{
	return new wxCursor(*image);
}

extern "C" WXEXPORT
wxCursor* wxCursor_ctorCopy(wxCursor* cursor)
{
	return new wxCursor(*cursor);
}

extern "C" WXEXPORT
wxCursor* wxCursor_ctorById(int id)
{
	return new wxCursor(id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCursor_Ok(wxCursor* self)
{
	return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCursor_SetCursor(const wxCursor* cursor)
{
	wxSetCursor(*cursor);
}
