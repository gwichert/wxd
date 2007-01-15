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
#include <wx/image.h>
#include <wx/mstream.h>

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_ctor()
{
	return new wxImage();
}

extern "C" WXEXPORT
wxImage* wxImage_ctorByName(wxc_string name, int type)
{
	return new wxImage(wxstr(name), type);
}

extern "C" WXEXPORT
wxImage* wxImage_ctorByByteArray(const char* data, int length, int type)
{
	wxMemoryInputStream* image_stream;
	
	image_stream = new wxMemoryInputStream(data, length);

	return new wxImage(*image_stream, type);
}

extern "C" WXEXPORT
wxImage* wxImage_ctorintintbool(int width, int height, wxc_bool clear)
{
	return new wxImage(width, height, (bool) clear);
}

extern "C" WXEXPORT
wxImage* wxImage_ctorByData(int width, int height, unsigned char* data, wxc_bool static_data)
{
	return new wxImage(width, height, data, static_data);
}

extern "C" WXEXPORT
wxImage* wxImage_ctorByDataAlpha(int width, int height, unsigned char* data, unsigned char* alpha, wxc_bool static_data)
{
	return new wxImage(width, height, data, alpha, static_data);
}

extern "C" WXEXPORT
wxImage* wxImage_ctorByImage(wxImage* image)
{
#if wxABI_VERSION < 20700
	return new wxImage(image);
#else
	wxImage* copy = new wxImage();
	*copy = image->Copy();
	return copy;
#endif
}

extern "C" WXEXPORT
void wxImage_dtor(wxImage* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_Destroy(wxImage* self)
{
	self->Destroy();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImage_GetHeight(wxImage* self)
{
	return self->GetHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImage_GetWidth(wxImage* self)
{
	return self->GetWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_InitAllHandlers()
{
	wxInitAllImageHandlers();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_LoadFileByTypeId(wxImage* self, wxc_string name, int type, int index)
{
	return self->LoadFile(wxstr(name), type, index)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxImage_LoadFileByMimeTypeId(wxImage* self, wxc_string name, wxc_string mimetype, int index)
{
	return self->LoadFile(wxstr(name), wxstr(mimetype), index)?1:0;
}


extern "C" WXEXPORT
wxc_bool wxImage_SaveFileByType(wxImage* self, wxc_string name, int type)
{
    return self->SaveFile(wxstr(name), type)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxImage_SaveFileByMimeType(wxImage* self, wxc_string name, wxc_string mimetype)
{
    return self->SaveFile(wxstr(name), wxstr(mimetype))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_Rescale(wxImage* self, int width, int height)
{
	return new wxImage(self->Rescale(width, height));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_Scale(wxImage* self, int width, int height)
{
	return new wxImage(self->Scale(width, height));

}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_SetMaskColour(wxImage* self, unsigned char r, unsigned char g, unsigned char b)
{
    self->SetMaskColour(r, g, b);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_SetMask(wxImage* self, wxc_bool mask)
{
    self->SetMask(mask);
}

extern "C" WXEXPORT
wxc_bool wxImage_HasMask(wxImage* self)
{
    return self->HasMask()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_Copy(wxImage* self)
{
	return new wxImage(self->Copy());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_GetSubImage(wxImage* self, wxRect* rect)
{
	return new wxImage(self->GetSubImage(*rect));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_Paste(wxImage* self, wxImage* image, int x, int y)
{
	self->Paste(*image, x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_ShrinkBy(wxImage* self, int xFactor, int yFactor)
{
	return new wxImage(self->ShrinkBy(xFactor, yFactor));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_Rotate(wxImage* self, double angle, wxPoint* centre_of_rotation, wxc_bool interpolating, wxPoint* offset_after_rotation)
{
	return new wxImage(self->Rotate(angle, *centre_of_rotation, interpolating, offset_after_rotation));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_Rotate90(wxImage* self, wxc_bool clockwise)
{
	return new wxImage(self->Rotate90(clockwise));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_Mirror(wxImage* self, wxc_bool horizontally)
{
	return new wxImage(self->Mirror(horizontally));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_Replace(wxImage* self, unsigned char r1, unsigned char g1, unsigned char b1, unsigned char r2, unsigned char g2, unsigned char b2)
{
	self->Replace(r1, g1, b1, r2, g2, b2);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImage* wxImage_ConvertToMono(wxImage* self, unsigned char r, unsigned char g, unsigned char b)
{
	return new wxImage(self->ConvertToMono(r, g, b));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_SetRGB(wxImage* self, int x, int y, unsigned char r, unsigned char g, unsigned char b)
{
	self->SetRGB(x, y, r, g, b);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxImage_GetRed(wxImage* self, int x, int y)
{
	return self->GetRed(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxImage_GetGreen(wxImage* self, int x, int y)
{
	return self->GetGreen(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxImage_GetBlue(wxImage* self, int x, int y)
{
	return self->GetBlue(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_SetAlpha(wxImage* self, int x, int y, unsigned char alpha)
{
	self->SetAlpha(x, y, alpha);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxImage_GetAlpha(wxImage* self, int x, int y)
{
	return self->GetAlpha(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_FindFirstUnusedColour(wxImage* self, unsigned char* r, unsigned char* g, unsigned char* b, unsigned char startR, unsigned char startG, unsigned char startB)
{
	return self->FindFirstUnusedColour(r, g, b, startR, startG, startB)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_SetMaskFromImage(wxImage* self, wxImage* mask, unsigned char mr, unsigned char mg, unsigned char mb)
{
	return self->SetMaskFromImage(*mask, mr, mg, mb)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_ConvertAlphaToMask(wxImage* self, unsigned char threshold)
{
	return self->ConvertAlphaToMask(threshold)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_CanRead(wxc_string name)
{
	return wxImage::CanRead(wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImage_GetImageCount(wxc_string name, int type)
{
	return wxImage::GetImageCount(wxstr(name), type);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_Ok(wxImage* self)
{
	return self->Ok()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxImage_GetMaskRed(wxImage* self)
{
	return self->GetMaskRed();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxImage_GetMaskGreen(wxImage* self)
{
	return self->GetMaskGreen();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned char wxImage_GetMaskBlue(wxImage* self)
{
	return self->GetMaskBlue();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_HasPalette(wxImage* self)
{
	return self->HasPalette()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPalette* wxImage_GetPalette(wxImage* self)
{
	return new wxPalette(self->GetPalette());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_SetPalette(wxImage* self, wxPalette* palette)
{
	self->SetPalette(*palette);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_SetOption(wxImage* self, wxc_string name, wxc_string value)
{
	self->SetOption(wxstr(name), wxstr(value));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_SetOption2(wxImage* self, wxc_string name, int value)
{
	self->SetOption(wxstr(name), value);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxImage_GetOption(wxImage* self, wxc_string name)
{
	return dstr_ret(self->GetOption(wxstr(name)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxImage_GetOptionInt(wxImage* self, wxc_string name)
{
	return self->GetOptionInt(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_HasOption(wxImage* self, wxc_string name)
{
	return self->HasOption(wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned long wxImage_CountColours(wxImage* self, unsigned long stopafter)
{
	return self->CountColours(stopafter);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned long wxImage_ComputeHistogram(wxImage* self, wxImageHistogram* h)
{
	return self->ComputeHistogram(*h);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxList* wxImage_GetHandlers()
{
	return new wxList(wxImage::GetHandlers());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_AddHandler(wxImageHandler* handler)
{
	wxImage::AddHandler(handler);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_InsertHandler(wxImageHandler* handler)
{
	wxImage::InsertHandler(handler);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImage_RemoveHandler(wxc_string name)
{
	return wxImage::RemoveHandler(wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageHandler* wxImage_FindHandler(wxc_string name)
{
	return wxImage::FindHandler(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageHandler* wxImage_FindHandler2(wxc_string name, long imageType)
{
	return wxImage::FindHandler(wxstr(name), imageType);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageHandler* wxImage_FindHandler3(long imageType)
{
	return wxImage::FindHandler(imageType);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxImageHandler* wxImage_FindHandlerMime(wxc_string mimetype)
{
	return wxImage::FindHandlerMime(wxstr(mimetype));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxImage_GetImageExtWildcard()
{
	return dstr_ret(wxImage::GetImageExtWildcard());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_CleanUpHandlers()
{
	wxImage::CleanUpHandlers();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImage_InitStandardHandlers()
{
	wxImage::InitStandardHandlers();
}

//-----------------------------------------------------------------------------
// wxImageHandler


extern "C" WXEXPORT
void wxImageHandler_SetName(wxImageHandler* self, wxc_string name)
{
	self->SetName(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImageHandler_SetExtension(wxImageHandler* self, wxc_string ext)
{
	self->SetExtension(wxstr(ext));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImageHandler_SetType(wxImageHandler* self, long type)
{
	self->SetType(type);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImageHandler_SetMimeType(wxImageHandler* self, wxc_string type)
{
	self->SetMimeType(wxstr(type));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxImageHandler_GetName(wxImageHandler* self)
{
	return dstr_ret(self->GetName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxImageHandler_GetExtension(wxImageHandler* self)
{
	return dstr_ret(self->GetExtension());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxImageHandler_GetType(wxImageHandler* self)
{
	return self->GetType();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxImageHandler_GetMimeType(wxImageHandler* self)
{
	return dstr_ret(self->GetMimeType());
}

//-----------------------------------------------------------------------------
// wxImageHistogramEntry

extern "C" WXEXPORT
wxImageHistogramEntry* wxImageHistogramEntry_ctor()
{
	return new wxImageHistogramEntry();
}

extern "C" WXEXPORT
void wxImageHistogramEntry_dtor(wxImageHistogramEntry* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned long wxImageHistogramEntry_index(wxImageHistogramEntry* self)
{
	return self->index;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImageHistogramEntry_Setindex(wxImageHistogramEntry* self, unsigned long v)
{
	self->index=v;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned long wxImageHistogramEntry_value(wxImageHistogramEntry* self)
{
	return self->value;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxImageHistogramEntry_Setvalue(wxImageHistogramEntry* self, unsigned long v)
{
	self->value=v;
}

//-----------------------------------------------------------------------------
// wxImageHistogram

extern "C" WXEXPORT
wxImageHistogram* wxImageHistogram_ctor()
{
	return new wxImageHistogram();
}

extern "C" WXEXPORT
void wxImageHistogram_dtor(wxImageHistogram* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
unsigned long wxImageHistogram_MakeKey(unsigned char r, unsigned char g, unsigned char b)
{
		return wxImageHistogram::MakeKey(r, g, b);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxImageHistogram_FindFirstUnusedColour(wxImageHistogram* self, unsigned char* r, unsigned char* g, unsigned char* b, unsigned char startR, unsigned char startG, unsigned char startB)
{
	return self->FindFirstUnusedColour(r, g, b, startR, startG, startB)?1:0;
}
