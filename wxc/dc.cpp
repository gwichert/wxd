//-----------------------------------------------------------------------------
// wx.NET - dc.cxx
//
// The wxDC proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>

//-----------------------------------------------------------------------------
// wxDC

extern "C" WXEXPORT
void wxDC_dtor(wxDC* dc)
{
    delete dc;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawBitmap(wxDC* self, wxBitmap* bmp, wxCoord x, wxCoord y, bool transparent)
{
    self->DrawBitmap(*bmp, x, y, transparent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawPolygon(wxDC* self, int n, wxPoint points[], wxCoord xoffset, wxCoord yoffset, int fill_style)
{
    self->DrawPolygon(n, points, xoffset, yoffset, fill_style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawLine(wxDC* self, wxCoord x1, wxCoord y1, wxCoord x2, wxCoord y2)
{
    self->DrawLine(x1, y1, x2, y2);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawRectangle(wxDC* self, wxCoord x1, wxCoord y1, wxCoord x2, wxCoord y2)
{
    self->DrawRectangle(x1, y1, x2, y2);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawText(wxDC* self, const char* text, int x, int y)
{
    self->DrawText(wxString(text, wxConvUTF8), x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawEllipse(wxDC* self, int x, int y, int width, int height)
{
    self->DrawEllipse(x, y, width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawPoint(wxDC* self, int x, int y)
{
    self->DrawPoint(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawRoundedRectangle(wxDC* self, int x, int y, int width, int height, double radius)
{
	self->DrawRoundedRectangle(x, y, width, height, radius);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetBackgroundMode(wxDC* self, int mode)
{
    self->SetBackgroundMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetBrush(wxDC* self, wxBrush* brush)
{
    self->SetBrush(*brush);
}

extern "C" WXEXPORT
wxBrush* wxDC_GetBrush(wxDC* self)
{
    return new wxBrush(self->GetBrush());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetBackground(wxDC* self, wxBrush* brush)
{
    self->SetBackground(*brush);
}

extern "C" WXEXPORT
wxBrush* wxDC_GetBackground(wxDC* self)
{
    return new wxBrush(self->GetBackground());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetPen(wxDC* self, wxPen* pen)
{
    self->SetPen(*pen);
}

extern "C" WXEXPORT
wxPen* wxDC_GetPen(wxDC* self)
{
    return new wxPen(self->GetPen());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxDC_GetTextForeground(wxDC* self)
{
    return new wxColour(self->GetTextForeground());
}

extern "C" WXEXPORT
void wxDC_SetTextForeground(wxDC* self, wxColour* colour)
{
    self->SetTextForeground(*colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxDC_GetTextBackground(wxDC* self)
{
    return new wxColour(self->GetTextBackground());
}

extern "C" WXEXPORT
void wxDC_SetTextBackground(wxDC* self, wxColour* colour)
{
    self->SetTextBackground(*colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxDC_GetFont(wxDC* self)
{
    return new wxFont(self->GetFont());
}

extern "C" WXEXPORT
void wxDC_SetFont(wxDC* self, wxFont* font)
{
    self->SetFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetTextExtent(wxDC* self, const char* string, int *x, int *y, int *descent, int *externalLeading, wxFont *theFont)
{
    self->GetTextExtent(wxString(string, wxConvUTF8), x, y, descent, externalLeading, theFont);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_Clear(wxDC* self)
{
    self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DestroyClippingRegion(wxDC* self)
{
    self->DestroyClippingRegion();
}

extern "C" WXEXPORT
void wxDC_SetClippingRegion(wxDC* self, wxCoord x, wxCoord y, wxCoord width, wxCoord height)
{
    self->SetClippingRegion(x, y, width, height);
}

extern "C" WXEXPORT
void wxDC_SetClippingRegionPos(wxDC* self, wxPoint* pos, wxSize* size)
{
    self->SetClippingRegion(*pos, *size);
}

extern "C" WXEXPORT
void wxDC_SetClippingRegionRect(wxDC* self, wxRect* rect)
{
    self->SetClippingRegion(*rect);
}

extern "C" WXEXPORT
void wxDC_SetClippingRegionReg(wxDC* self, wxRegion* reg)
{
    self->SetClippingRegion(*reg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_GetLogicalFunction(wxDC* self)
{
    return self->GetLogicalFunction();
}

extern "C" WXEXPORT
void wxDC_SetLogicalFunction(wxDC* self, int function)
{
    self->SetLogicalFunction(function);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_BeginDrawing(wxDC* self)
{
	self->BeginDrawing();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDC_Blit(wxDC* self, wxCoord xdest, wxCoord ydest, wxCoord width, wxCoord height,
		  wxDC *source, wxCoord xsrc, wxCoord ysrc,
		  int rop = wxCOPY, bool useMask = FALSE, wxCoord xsrcMask = -1, wxCoord ysrcMask = -1)
{
	return self->Blit(xdest, ydest, width, height, source, xsrc, ysrc, rop, useMask, xsrcMask, ysrcMask)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_EndDrawing(wxDC* self)
{
	self->EndDrawing();
}

//---------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDC_FloodFill(wxDC* self, int x, int y, wxColour* col, int style)
{
	return self->FloodFill(x, y, *col, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDC_GetPixel(wxDC* self, int x, int y, wxColour* col)
{
	return self->GetPixel(x, y, col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_CrossHair(wxDC* self, int x, int y)
{
	self->CrossHair(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawArc(wxDC* self, int x1, int y1, int x2, int y2, int xc, int yc)
{
	self->DrawArc(x1, y1, x2, y2, xc, yc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawCheckMark(wxDC* self, int x, int y, int width, int height)
{
	self->DrawCheckMark(x, y, width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawEllipticArc(wxDC* self, int x, int y, int w, int h, double sa, double ea)
{
	self->DrawEllipticArc(x, y, w, h, sa, ea);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawLines(wxDC* self, int n, wxPoint points[], int xoffset, int yoffset)
{
	self->DrawLines(n, points, xoffset, yoffset);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawCircle(wxDC* self, int x, int y, int radius)
{
	self->DrawCircle(x, y, radius);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawIcon(wxDC* self, wxIcon* icon, int x, int y)
{
	self->DrawIcon(*icon, x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawRotatedText(wxDC* self, const char* text, int x, int y, double angle)
{
	self->DrawRotatedText(wxString(text, wxConvUTF8), x, y, angle);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawLabel(wxDC* self, const char* text, wxBitmap* image, wxRect* rect, int alignment, int indexAccel, wxRect* rectBounding)
{
	self->DrawLabel(wxString(text, wxConvUTF8), *image, *rect, alignment, indexAccel, rectBounding);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawLabel2(wxDC* self, const char* text, wxRect* rect, int alignment, int indexAccel)
{
	self->DrawLabel(wxString(text, wxConvUTF8), *rect, alignment, indexAccel);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawSpline(wxDC* self, int x1, int y1, int x2, int y2, int x3, int y3)
{
	self->DrawSpline(x1, y1, x2, y2, x3, y3);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_DrawSpline2(wxDC* self, int n, wxPoint points[])
{
	self->DrawSpline(n, points);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDC_StartDoc(wxDC* self, const char* message)
{
	return self->StartDoc(wxString(message, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_EndDoc(wxDC* self)
{
	self->EndDoc();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_StartPage(wxDC* self)
{
	self->StartPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_EndPage(wxDC* self)
{
	self->EndPage();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetClippingBox(wxDC* self, int *x, int *y, int *w, int *h)
{
	self->GetClippingBox(x, y, w, h);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetClippingBox2(wxDC* self, wxRect* rect)
{
	self->GetClippingBox(*rect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetMultiLineTextExtent(wxDC* self, const char* text, int *width, int *height, int *heightLine, wxFont* font)
{
	self->GetMultiLineTextExtent(wxString(text, wxConvUTF8), width, height, heightLine, font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDC_GetPartialTextExtents(wxDC* self, const char* text, wxArrayInt* widths)
{
	return self->GetPartialTextExtents(wxString(text, wxConvUTF8), *widths);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetSize(wxDC* self, int *width, int* height)
{
	self->GetSize(width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetSize2(wxDC* self, wxSize* size)
{
	*size = self->GetSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetSizeMM(wxDC* self, int* width, int* height)
{
	self->GetSizeMM(width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetSizeMM2(wxDC* self, wxSize* size)
{
	*size = self->GetSizeMM();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_DeviceToLogicalX(wxDC* self, int x)
{
	return self->DeviceToLogicalX(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_DeviceToLogicalY(wxDC* self, int y)
{
	return self->DeviceToLogicalY(y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_DeviceToLogicalXRel(wxDC* self, int x)
{
	return self->DeviceToLogicalXRel(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_DeviceToLogicalYRel(wxDC* self, int y)
{
	return self->DeviceToLogicalYRel(y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_LogicalToDeviceX(wxDC* self, int x)
{
	return self->LogicalToDeviceX(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_LogicalToDeviceY(wxDC* self, int y)
{
	return self->LogicalToDeviceY(y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_LogicalToDeviceXRel(wxDC* self, int x)
{
	return self->LogicalToDeviceXRel(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_LogicalToDeviceYRel(wxDC* self, int y)
{
	return self->LogicalToDeviceYRel(y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxDC_Ok(wxDC* self)
{
	return self->Ok();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_GetBackgroundMode(wxDC* self)
{
	return self->GetBackgroundMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_GetMapMode(wxDC* self)
{
	return self->GetMapMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetMapMode(wxDC* self, int mode)
{
	self->SetMapMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetUserScale(wxDC* self, double* x, double* y)
{
	self->GetUserScale(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetUserScale(wxDC* self, double x, double y)
{
	self->SetUserScale(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetLogicalScale(wxDC* self, double* x, double* y)
{
	self->GetLogicalScale(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetLogicalScale(wxDC* self, double x, double y)
{
	self->SetLogicalScale(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetLogicalOrigin(wxDC* self, int *x, int *y)
{
	self->GetLogicalOrigin(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetLogicalOrigin2(wxDC* self, wxPoint* pt)
{
	*pt = self->GetLogicalOrigin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetLogicalOrigin(wxDC* self, int x, int y)
{
	self->SetLogicalOrigin(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetDeviceOrigin(wxDC* self, int *x, int *y)
{
	self->GetDeviceOrigin(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_GetDeviceOrigin2(wxDC* self, wxPoint* pt)
{
	*pt = self->GetDeviceOrigin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetDeviceOrigin(wxDC* self, int x, int y)
{
	self->SetDeviceOrigin(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_SetAxisOrientation(wxDC* self, bool xLeftRight, bool yBottomUp)
{
	self->SetAxisOrientation(xLeftRight, yBottomUp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_CalcBoundingBox(wxDC* self, int x, int y)
{
	self->CalcBoundingBox(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxDC_ResetBoundingBox(wxDC* self)
{
	self->ResetBoundingBox();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_MinX(wxDC* self)
{
	return self->MinX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_MaxX(wxDC* self)
{
	return self->MaxX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_MinY(wxDC* self)
{
	return self->MinY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDC_MaxY(wxDC* self)
{
	return self->MaxY();
}

//-----------------------------------------------------------------------------
// wxWindowDC

extern "C" WXEXPORT
wxWindowDC* wxWindowDC_ctor()
{
	return new wxWindowDC();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindowDC* wxWindowDC_ctor2(wxWindow* win)
{
	return new wxWindowDC(win);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxWindowDC_CanDrawBitmap(wxWindowDC* self)
{
	return self->CanDrawBitmap()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxWindowDC_CanGetTextExtent(wxWindowDC* self)
{
	return self->CanGetTextExtent()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindowDC_GetCharWidth(wxWindowDC* self)
{
	return self->GetCharWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindowDC_GetCharHeight(wxWindowDC* self)
{
	return self->GetCharHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_Clear(wxWindowDC* self)
{
	self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetFont(wxWindowDC* self, wxFont* font)
{
	self->SetFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxWindowDC_GetFont(wxDCBase* self)
{
	return new wxFont(self->GetFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetPen(wxWindowDC* self, wxPen* pen)
{
	self->SetPen(*pen);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPen* wxWindowDC_GetPen(wxWindowDC* self)
{
	return new wxPen(self->GetPen());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetBrush(wxWindowDC* self, wxBrush* brush)
{
	self->SetBrush(*brush);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetBackground(wxWindowDC* self, wxBrush* brush)
{
	self->SetBackground(*brush);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBrush* wxWindowDC_GetBackground(wxDCBase* self)
{
	return new wxBrush(self->GetBackground());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetLogicalFunction(wxWindowDC* self, int function)
{
	self->SetLogicalFunction(function);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetTextForeground(wxWindowDC* self, wxColour* colour)
{
	self->SetTextForeground(*colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxWindowDC_GetTextForeground(wxDCBase* self)
{
	return new wxColour(self->GetTextForeground());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetTextBackground(wxWindowDC* self, wxColour* colour)
{
	self->SetTextBackground(*colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetBackgroundMode(wxWindowDC* self, int mode)
{
	self->SetBackgroundMode(mode);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindowDC_GetBackgroundMode(wxDCBase* self)
{
	return self->GetBackgroundMode();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_SetPalette(wxWindowDC* self, wxPalette* palette)
{
	self->SetPalette(*palette);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindowDC_GetPPI(wxWindowDC* self, wxSize* size)
{
	*size = self->GetPPI();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindowDC_GetDepth(wxWindowDC* self)
{
	return self->GetDepth();
}

//-----------------------------------------------------------------------------
// wxClientDC

extern "C" WXEXPORT
wxClientDC* wxClientDC_ctor()
{
    return new wxClientDC();
}

extern "C" WXEXPORT
wxClientDC* wxClientDC_ctor2(wxWindow *win)
{
    return new wxClientDC(win);
}

//-----------------------------------------------------------------------------
// wxPaintDC

extern "C" WXEXPORT
wxPaintDC* wxPaintDC_ctor()
{
    return new wxPaintDC();
}

extern "C" WXEXPORT
wxPaintDC* wxPaintDC_ctor2(wxWindow* window)
{
    return new wxPaintDC(window);
}

