//-----------------------------------------------------------------------------
// wx.NET - region.cxx
// 
// The wxRegion proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/region.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxRegion* wxRegion_ctor()
{
	return new wxRegion();
}

extern "C" WXEXPORT
wxRegion* wxRegion_ctorByCoords(wxCoord x, wxCoord y, wxCoord w, wxCoord h)
{
	return new wxRegion(x, y, w, h);
}

extern "C" WXEXPORT
wxRegion* wxRegion_ctorByCorners(const wxPoint* topLeft, const wxPoint* bottomRight)
{
	return new wxRegion(*topLeft, *bottomRight);
}

extern "C" WXEXPORT
wxRegion* wxRegion_ctorByRect(const wxRect* rect)
{
	return new wxRegion(*rect);
}

#ifndef __WXMAC__
extern "C" WXEXPORT
wxRegion* wxRegion_ctorByPoly(size_t n, const wxPoint *points, int fillStyle)
{
	return new wxRegion(n, points, fillStyle);
}
#endif

extern "C" WXEXPORT
wxRegion* wxRegion_ctorByBitmap(const wxBitmap* bmp, const wxColour* transColour, int tolerance)
{
	if (transColour == NULL)
		transColour = &wxNullColour;

	return new wxRegion(*bmp, *transColour, tolerance);
}

extern "C" WXEXPORT
wxRegion* wxRegion_ctorByRegion(const wxRegion* region)
{
	return new wxRegion(*region);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRegion_dtor(wxRegion* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRegion_Clear(wxRegion* self)
{
	self->Clear();
}

//-----------------------------------------------------------------------------

#ifndef __WXMAC__
extern "C" WXEXPORT
bool wxRegion_Offset(wxRegion* self, wxCoord x, wxCoord y)
{
	return self->Offset(x, y)?1:0;
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRegion_Union(wxRegion* self, wxCoord x, wxCoord y, wxCoord width, wxCoord height)
{
	return self->Union(x, y, width, height)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_UnionRect(wxRegion* self, const wxRect* rect)
{
	return self->Union(*rect)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_UnionRegion(wxRegion* self, const wxRegion* region)
{
	return self->Union(*region)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRegion_Intersect(wxRegion* self, wxCoord x, wxCoord y, wxCoord width, wxCoord height)
{
	return self->Intersect(x, y, width, height)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_IntersectRect(wxRegion* self, const wxRect* rect)
{
	return self->Intersect(*rect)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_IntersectRegion(wxRegion* self, const wxRegion* region)
{
	return self->Intersect(*region)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRegion_Subtract(wxRegion* self, wxCoord x, wxCoord y, wxCoord width, wxCoord height)
{
	return self->Subtract(x, y, width, height)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_SubtractRect(wxRegion* self, const wxRect* rect)
{
	return self->Subtract(*rect)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_SubtractRegion(wxRegion* self, const wxRegion* region)
{
	return self->Subtract(*region)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRegion_Xor(wxRegion* self, wxCoord x, wxCoord y, wxCoord width, wxCoord height)
{
	return self->Xor(x, y, width, height)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_XorRect(wxRegion* self, const wxRect* rect)
{
	return self->Xor(*rect)?1:0;
}

extern "C" WXEXPORT
bool wxRegion_XorRegion(wxRegion* self, const wxRegion* region)
{
	return self->Xor(*region)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxRegionContain wxRegion_ContainsCoords(wxRegion* self, int x, int y)
{
    return self->Contains(x, y);
}

extern "C" WXEXPORT
wxRegionContain wxRegion_ContainsPoint(wxRegion* self, const wxPoint* pt)
{
    return self->Contains(*pt);
}

extern "C" WXEXPORT
wxRegionContain wxRegion_ContainsRectCoords(wxRegion* self, int x, int y, int width, int height)
{
    return self->Contains(x, y, width, height);
}

extern "C" WXEXPORT
wxRegionContain wxRegion_ContainsRect(wxRegion* self, wxRect* rect)
{
    return self->Contains(*rect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRegion_GetBox(wxRegion* self, wxRect* rect)
{
	*rect = self->GetBox();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRegion_IsEmpty(wxRegion* self)
{
	return self->IsEmpty()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBitmap* wxRegion_ConvertToBitmap(wxRegion* self)
{
	return new wxBitmap(self->ConvertToBitmap());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRegion_UnionBitmap(wxRegion* self, const wxBitmap* bmp, const wxColour* transColour, int tolerance)
{
	if (transColour == NULL)
		transColour = &wxNullColour;

	return self->Union(*bmp, *transColour, tolerance)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxRegionIterator* wxRegionIterator_ctor()
{
	return new wxRegionIterator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxRegionIterator* wxRegionIterator_ctorByRegion(const wxRegion* region)
{
	return new wxRegionIterator(*region);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRegionIterator_Reset(wxRegionIterator* self)
{
	self->Reset();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRegionIterator_ResetToRegion(wxRegionIterator* self, const wxRegion* region)
{
	self->Reset(*region);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxRegionIterator_HaveRects(wxRegionIterator* self)
{
	return self->HaveRects()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxRegionIterator_GetX(wxRegionIterator* self)
{
	return self->GetX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxRegionIterator_GetY(wxRegionIterator* self)
{
	return self->GetY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxRegionIterator_GetW(wxRegionIterator* self)
{
	return self->GetW();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxRegionIterator_GetWidth(wxRegionIterator* self)
{
	return self->GetWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxRegionIterator_GetH(wxRegionIterator* self)
{
	return self->GetH();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxRegionIterator_GetHeight(wxRegionIterator* self)
{
	return self->GetHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxRegionIterator_GetRect(wxRegionIterator* self, wxRect* rect)
{
	*rect = self->GetRect();
}

