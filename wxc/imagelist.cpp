//-----------------------------------------------------------------------------
// wxD - image.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - image.cxx
//
// The wxImage proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/imaglist.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageList* wxImageList_ctor(int width, int height, bool mask, int initialCount)
{
	return new wxImageList(width, height, mask, initialCount);
}

extern "C" WXEXPORT
wxImageList* wxImageList_ctor2()
{
	return new wxImageList();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImageList_AddBitmap1(wxImageList* self, const wxBitmap* bmp, const wxBitmap* mask)
{
	if (mask == NULL)
		mask = &wxNullBitmap;

	return self->Add(*bmp, *mask);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImageList_AddBitmap(wxImageList* self, const wxBitmap* bmp, const wxColour* maskColour)
{
	return self->Add(*bmp, *maskColour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImageList_AddIcon(wxImageList* self, const wxIcon* icon)
{
	return self->Add(*icon);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImageList_GetImageCount(wxImageList* self)
{
	return self->GetImageCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxImageList_Draw(wxImageList* self, int index, wxDC* dc, int x, int y, int flags, bool solidBackground)
{
	return self->Draw(index, *dc, x, y, flags, solidBackground)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxImageList_Create(wxImageList* self, int width, int height, bool mask, int initialCount)
{
	return self->Create(width, height, mask, initialCount)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxImageList_Replace(wxImageList* self, int index, const wxBitmap* bitmap)
{
	return self->Replace(index, *bitmap)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxImageList_Remove(wxImageList* self, int index)
{
	return self->Remove(index)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxImageList_RemoveAll(wxImageList* self)
{
	return self->RemoveAll()?1:0;
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
const wxBitmap* wxImageList_GetBitmap(wxImageList* self, int index)
{
	return self->GetBitmap(index);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxImageList_GetSize(wxImageList* self, int index, int* width, int* height)
{
	return self->GetSize(index, *width, *height)?1:0;
}


