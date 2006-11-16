//-----------------------------------------------------------------------------
// wx.NET - DC.cs
//
// The wxDC wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------


using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class DC : Object
	{
		[DllImport("wx-c")] static extern void   wxDC_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDC_DrawBitmap(IntPtr self, IntPtr bmp, int x, int y, bool transparent);
		[DllImport("wx-c")] static extern void   wxDC_DrawPolygon(IntPtr self, int n, Point[] points, int xoffset, int yoffset, int fill_style);
		[DllImport("wx-c")] static extern void   wxDC_DrawLine(IntPtr self, int x1, int y1, int x2, int y2);
		[DllImport("wx-c")] static extern void   wxDC_DrawRectangle(IntPtr self, int x1, int y1, int x2, int y2);
		[DllImport("wx-c")] static extern void   wxDC_DrawText(IntPtr self, string text, int x, int y);
		[DllImport("wx-c")] static extern void   wxDC_DrawEllipse(IntPtr self, int x, int y, int width, int height);
		[DllImport("wx-c")] static extern void   wxDC_DrawPoint(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void   wxDC_DrawRoundedRectangle(IntPtr self, int x, int y, int width, int height, double radius);
	
		[DllImport("wx-c")] static extern void   wxDC_SetBackgroundMode(IntPtr self, FillStyle mode);
	
		[DllImport("wx-c")] static extern void   wxDC_SetTextBackground(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxDC_GetTextBackground(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxDC_SetBrush(IntPtr self, IntPtr brush);
		[DllImport("wx-c")] static extern IntPtr wxDC_GetBrush(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxDC_SetBackground(IntPtr self, IntPtr brush);
		[DllImport("wx-c")] static extern IntPtr wxDC_GetBackground(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxDC_SetPen(IntPtr self, IntPtr pen);
		[DllImport("wx-c")] static extern IntPtr wxDC_GetPen(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxDC_SetTextForeground(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxDC_GetTextForeground(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxDC_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern IntPtr wxDC_GetFont(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxDC_GetTextExtent(IntPtr self, string str, out int x, out int y, out int descent, out int externalLeading, IntPtr theFont);
		[DllImport("wx-c")] static extern void   wxDC_Clear(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxDC_DestroyClippingRegion(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDC_SetClippingRegion(IntPtr self, int x, int y, int width, int height);
		[DllImport("wx-c")] static extern void   wxDC_SetClippingRegionPos(IntPtr self, ref Point pos, ref Size size);
		[DllImport("wx-c")] static extern void   wxDC_SetClippingRegionRect(IntPtr self, ref Rectangle rect);
		[DllImport("wx-c")] static extern void   wxDC_SetClippingRegionReg(IntPtr self, IntPtr reg);
	
		[DllImport("wx-c")] static extern int    wxDC_GetLogicalFunction(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDC_SetLogicalFunction(IntPtr self, int function);
	
		[DllImport("wx-c")] static extern bool   wxDC_BeginDrawing(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxDC_Blit(IntPtr self, int xdest, int ydest, int width, int height, IntPtr source, int xsrc, int ysrc, int rop, bool useMask, int xsrcMask, int ysrcMask);
		[DllImport("wx-c")] static extern void   wxDC_EndDrawing(IntPtr self);
		
		[DllImport("wx-c")] static extern bool   wxDC_FloodFill(IntPtr self, int x, int y, IntPtr col, int style);
		
		[DllImport("wx-c")] static extern bool   wxDC_GetPixel(IntPtr self, int x, int y, IntPtr col);
		
		[DllImport("wx-c")] static extern void   wxDC_CrossHair(IntPtr self, int x, int y);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawArc(IntPtr self, int x1, int y1, int x2, int y2, int xc, int yc);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawCheckMark(IntPtr self, int x, int y, int width, int height);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawEllipticArc(IntPtr self, int x, int y, int w, int h, double sa, double ea);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawLines(IntPtr self, int n, Point[] points, int xoffset, int yoffset);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawCircle(IntPtr self, int x, int y, int radius);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawIcon(IntPtr self, IntPtr icon, int x, int y);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawRotatedText(IntPtr self, string text, int x, int y, double angle);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawLabel(IntPtr self, string text, IntPtr image, ref Rectangle rect, int alignment, int indexAccel, ref Rectangle rectBounding);
		[DllImport("wx-c")] static extern void   wxDC_DrawLabel2(IntPtr self, string text, ref Rectangle rect, int alignment, int indexAccel);
		
		[DllImport("wx-c")] static extern void   wxDC_DrawSpline(IntPtr self, int x1, int y1, int x2, int y2, int x3, int y3);
		[DllImport("wx-c")] static extern void   wxDC_DrawSpline2(IntPtr self, int n, Point[] points);
		
		[DllImport("wx-c")] static extern bool   wxDC_StartDoc(IntPtr self, string message);
		[DllImport("wx-c")] static extern void   wxDC_EndDoc(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDC_StartPage(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDC_EndPage(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxDC_GetClippingBox(IntPtr self, out int x, out int y, out int w, out int h);
		[DllImport("wx-c")] static extern void   wxDC_GetClippingBox2(IntPtr self, out Rectangle rect);
		
		[DllImport("wx-c")] static extern void   wxDC_GetMultiLineTextExtent(IntPtr self, string text, out int width, out int height, out int heightline, IntPtr font);
		
		[DllImport("wx-c")] static extern bool   wxDC_GetPartialTextExtents(IntPtr self, string text, IntPtr widths);
		
		[DllImport("wx-c")] static extern void   wxDC_GetSize(IntPtr self, out int width, out int height);
		[DllImport("wx-c")] static extern void   wxDC_GetSize2(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxDC_GetSizeMM(IntPtr self, out int width, out int height);
		[DllImport("wx-c")] static extern void   wxDC_GetSizeMM2(IntPtr self, ref Size size);
		
		[DllImport("wx-c")] static extern int    wxDC_DeviceToLogicalX(IntPtr self, int x);
		[DllImport("wx-c")] static extern int    wxDC_DeviceToLogicalY(IntPtr self, int y);
		[DllImport("wx-c")] static extern int    wxDC_DeviceToLogicalXRel(IntPtr self, int x);
		[DllImport("wx-c")] static extern int    wxDC_DeviceToLogicalYRel(IntPtr self, int y);
		[DllImport("wx-c")] static extern int    wxDC_LogicalToDeviceX(IntPtr self, int x);
		[DllImport("wx-c")] static extern int    wxDC_LogicalToDeviceY(IntPtr self, int y);
		[DllImport("wx-c")] static extern int    wxDC_LogicalToDeviceXRel(IntPtr self, int x);
		[DllImport("wx-c")] static extern int    wxDC_LogicalToDeviceYRel(IntPtr self, int y);
		
		[DllImport("wx-c")] static extern bool   wxDC_Ok(IntPtr self);
		
		[DllImport("wx-c")] static extern int    wxDC_GetBackgroundMode(IntPtr self);
		
		[DllImport("wx-c")] static extern int    wxDC_GetMapMode(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDC_SetMapMode(IntPtr self, int mode);
		
		[DllImport("wx-c")] static extern void   wxDC_GetUserScale(IntPtr self, out double x, out double y);
		[DllImport("wx-c")] static extern void   wxDC_SetUserScale(IntPtr self, double x, double y);
		
		[DllImport("wx-c")] static extern void   wxDC_GetLogicalScale(IntPtr self, out double x, out double y);
		[DllImport("wx-c")] static extern void   wxDC_SetLogicalScale(IntPtr self, double x, double y);
		
		[DllImport("wx-c")] static extern void   wxDC_GetLogicalOrigin(IntPtr self, out int x, out int y);
		[DllImport("wx-c")] static extern void   wxDC_GetLogicalOrigin2(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern void   wxDC_SetLogicalOrigin(IntPtr self, int x, int y);
		
		[DllImport("wx-c")] static extern void   wxDC_GetDeviceOrigin(IntPtr self, out int x, out int y);
		[DllImport("wx-c")] static extern void   wxDC_GetDeviceOrigin2(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern void   wxDC_SetDeviceOrigin(IntPtr self, int x, int y);
		
		[DllImport("wx-c")] static extern void   wxDC_SetAxisOrientation(IntPtr self, bool xLeftRight, bool yBottomUp);
		
		[DllImport("wx-c")] static extern void   wxDC_CalcBoundingBox(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void   wxDC_ResetBoundingBox(IntPtr self);
		
		[DllImport("wx-c")] static extern int    wxDC_MinX(IntPtr self);
		[DllImport("wx-c")] static extern int    wxDC_MaxX(IntPtr self);
		[DllImport("wx-c")] static extern int    wxDC_MinY(IntPtr self);
		[DllImport("wx-c")] static extern int    wxDC_MaxY(IntPtr self);

		//---------------------------------------------------------------------

		public DC(IntPtr wxObject) 
			: base(wxObject) {}

		//---------------------------------------------------------------------

		public FillStyle BackgroundMode
		{
			set { wxDC_SetBackgroundMode(wxObject, value); }
			get { return (FillStyle)wxDC_GetBackgroundMode(wxObject); }
		}

		//---------------------------------------------------------------------

		public Brush Brush
		{
			set { wxDC_SetBrush(wxObject, Object.SafePtr(value)); }
			get { return new Brush(wxDC_GetBrush(wxObject)); }
		}

		public Brush Background
		{
			set { wxDC_SetBackground(wxObject, Object.SafePtr(value)); }
			get { return new Brush(wxDC_GetBackground(wxObject)); }
		}

		//---------------------------------------------------------------------

		public void DrawBitmap(Bitmap bmp, int x, int y, bool useMask)
		{
			wxDC_DrawBitmap(wxObject, Object.SafePtr(bmp), x, y, useMask);
		}
		
		public void DrawBitmap(Bitmap bmp, int x, int y)
		{
			DrawBitmap(bmp, x, y, false);
		}
		
		public void DrawBitmap(Bitmap bmp, Point pt, bool useMask)
		{
			DrawBitmap(bmp, pt.X, pt.Y, useMask);
		}
		
		public void DrawBitmap(Bitmap bmp, Point pt)
		{
			DrawBitmap(bmp, pt.X, pt.Y, false);
		}

		//---------------------------------------------------------------------

		public void DrawEllipse(int x, int y, int width, int height)
		{
			wxDC_DrawEllipse(wxObject, x, y, width, height);
		}
		
		public void DrawEllipse(Point pt, Size sz)
		{
			DrawEllipse(pt.X, pt.Y, sz.Width, sz.Height);
		}
		
		public void DrawEllipse(Rectangle rect)
		{
			DrawEllipse(rect.X, rect.Y, rect.Width, rect.Height);
		}

		//---------------------------------------------------------------------

		public void DrawPoint(int x, int y)
		{
			wxDC_DrawPoint(wxObject, x, y);
		}
		
		public void DrawPoint(Point pt)
		{
			DrawPoint(pt.X, pt.Y);
		}

		//---------------------------------------------------------------------

		public void DrawLine(Point p1, Point p2)
		{ 
			DrawLine(p1.X, p1.Y, p2.X, p2.Y); 
		}

		public void DrawLine(int x1, int y1, int x2, int y2)
		{
			wxDC_DrawLine(wxObject, x1, y1, x2, y2);
		}

		//---------------------------------------------------------------------

		public void DrawPolygon(Point[] points)
		{ 
			DrawPolygon(points.Length, points, 0, 0, FillStyle.wxODDEVEN_RULE); 
		}
		
		public void DrawPolygon(Point[] points, int xoffset, int yoffset)
		{ 
			DrawPolygon(points.Length, points, xoffset, yoffset, FillStyle.wxODDEVEN_RULE); 
		}
		
		public void DrawPolygon(Point[] points, int xoffset, int yoffset, FillStyle fill_style)
		{ 
			DrawPolygon(points.Length, points, xoffset, yoffset, fill_style); 
		}

		public void DrawPolygon(int n, Point[] points)
		{ 
			DrawPolygon(n, points, 0, 0, FillStyle.wxODDEVEN_RULE); 
		}
		
		public void DrawPolygon(int n, Point[] points, int xoffset, int yoffset)
		{ 
			DrawPolygon(n, points, xoffset, yoffset, FillStyle.wxODDEVEN_RULE); 
		}
		
		public void DrawPolygon(int n, Point[] points, int xoffset, int yoffset, FillStyle fill_style)
		{
			wxDC_DrawPolygon(wxObject, n, points, xoffset, yoffset, (int)fill_style);
		}

		//---------------------------------------------------------------------

		public void DrawRectangle(int x1, int y1, int x2, int y2)
		{
			wxDC_DrawRectangle(wxObject, x1, y1, x2, y2);
		}
		
		public void DrawRectangle(Point pt, Size sz)
		{
			DrawRectangle(pt.X, pt.Y, sz.Width, sz.Height);
		} 

		public void DrawRectangle(Rectangle rect)
		{
			wxDC_DrawRectangle(wxObject, rect.X, rect.Y, rect.Width, rect.Height);
		}

		//---------------------------------------------------------------------

		public void DrawText(string text, int x, int y)
		{
			wxDC_DrawText(wxObject, text, x, y);
		}

		public void DrawText(string text, Point pos)
		{
			wxDC_DrawText(wxObject, text, pos.X, pos.Y);
		}
		
		//---------------------------------------------------------------------

		public void DrawRoundedRectangle(int x, int y, int width, int height, double radius)
		{
			wxDC_DrawRoundedRectangle(wxObject, x, y, width, height, radius);
		}
		
		public void DrawRoundedRectangle(Point pt, Size sz, double radius)
		{
			DrawRoundedRectangle(pt.X, pt.Y, sz.Width, sz.Height, radius);
		}
		
		public void DrawRoundedRectangle(Rectangle r, double radius)
		{
			DrawRoundedRectangle(r.X, r.Y, r.Width, r.Height, radius);
		}

		//---------------------------------------------------------------------

		public Pen Pen
		{
			set { wxDC_SetPen(wxObject, value.wxObject); }
			get { return (Pen)FindObject(wxDC_GetPen(wxObject), typeof(Pen)); }
		}

		//---------------------------------------------------------------------

		public Colour TextForeground
		{
			get { return (Colour)FindObject(wxDC_GetTextForeground(wxObject), typeof(Colour)); }
			set { wxDC_SetTextForeground(wxObject, Object.SafePtr(value)); }
		}

		public Colour TextBackground
		{
			get { return (Colour)FindObject(wxDC_GetTextBackground(wxObject), typeof(Colour)); }
			set { wxDC_SetTextBackground(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public Font Font
		{
			get { return (Font)FindObject(wxDC_GetFont(wxObject), typeof(Font)); }
			set { wxDC_SetFont(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------

		public virtual void Clear()
		{
			wxDC_Clear(wxObject);
		}

		//---------------------------------------------------------------------

		public void GetTextExtent(string str, out int x, out int y)
		{ 
			// Ignoring these parameters
			int descent;
			int externalLeading;

			GetTextExtent(str, out x, out y, out descent, out externalLeading, null); 
		}

		public void GetTextExtent(string str, out int x, out int y, out int descent, out int externalLeading, Font theFont)
		{
			wxDC_GetTextExtent(wxObject, str, out x, out y, out descent, out externalLeading, Object.SafePtr(theFont));
		}

		//---------------------------------------------------------------------

		public void DestroyClippingRegion()
		{
			wxDC_DestroyClippingRegion(wxObject);
		}

		//---------------------------------------------------------------------

		public void SetClippingRegion(int x, int y, int width, int height)
		{
			wxDC_SetClippingRegion(wxObject, x, y, width, height);
		}

		public void SetClippingRegion(Point pos, Size size)
		{
			wxDC_SetClippingRegionPos(wxObject, ref pos, ref size);
		}

		public void SetClippingRegion(Rectangle rect)
		{
			wxDC_SetClippingRegionRect(wxObject, ref rect);
		}

		public void SetClippingRegion(Region reg)
		{
			wxDC_SetClippingRegionReg(wxObject, Object.SafePtr(reg));
		}

		//---------------------------------------------------------------------

		public Logic LogicalFunction
		{
			get { return (Logic)wxDC_GetLogicalFunction(wxObject); }
			set { wxDC_SetLogicalFunction(wxObject, (int)value); }
		}

		//---------------------------------------------------------------------

		public void BeginDrawing()
		{
			wxDC_BeginDrawing(wxObject);
		}

		//---------------------------------------------------------------------

		public bool Blit(int xdest, int ydest, int width, int height, DC source, int xsrc, int ysrc, int rop, bool useMask, int xsrcMask, int ysrcMask)
		{
			return wxDC_Blit(wxObject, xdest, ydest, width, height, Object.SafePtr(source), xsrc, ysrc, rop, useMask, xsrcMask, ysrcMask);
		}
		
		public bool Blit(int xdest, int ydest, int width, int height, DC source) 
		{ 
			return Blit(xdest, ydest, width, height, source, 0, 0, (int) wx.Logic.wxCOPY, false, -1, -1); 
		}
		
		public bool Blit(int xdest, int ydest, int width, int height, DC source, int xsrc, int ysrc)
		{
			return Blit(xdest, ydest, width, height, source, xsrc, ysrc, (int)Logic.wxCOPY, false, -1, -1);
		}
		
		public bool Blit(int xdest, int ydest, int width, int height, DC source, int xsrc, int ysrc, int rop)
		{
			return Blit(xdest, ydest, width, height, source, xsrc, ysrc, rop, false, -1, -1);
		}
		
		public bool Blit(int xdest, int ydest, int width, int height, DC source, int xsrc, int ysrc, int rop, bool useMask)
		{
			return Blit(xdest, ydest, width, height, source, xsrc, ysrc, rop, useMask, -1, -1);
		}
		
		public bool Blit(int xdest, int ydest, int width, int height, DC source, int xsrc, int ysrc, int rop, bool useMask, int xsrcMask)
		{
			return Blit(xdest, ydest, width, height, source, xsrc, ysrc, rop, useMask, xsrcMask, -1);
		}
		
		public bool Blit(Point destPt, Size sz, DC source, Point srcPt, int rop, bool useMask, Point srcPtMask)
		{
			return Blit(destPt.X, destPt.Y, sz.Width, sz.Height, source, srcPt.X, srcPt.Y, rop, useMask, srcPtMask.X, srcPtMask.Y);
		}
		
		public bool Blit(Point destPt, Size sz, DC source, Point srcPt)
		{
			return Blit(destPt.X, destPt.Y, sz.Width, sz.Height, source, srcPt.X, srcPt.Y, (int)Logic.wxCOPY, false, -1, -1);
		}
		
		public bool Blit(Point destPt, Size sz, DC source, Point srcPt, int rop)
		{
			return Blit(destPt.X, destPt.Y, sz.Width, sz.Height, source, srcPt.X, srcPt.Y, rop, false, -1, -1);
		}
		
		public bool Blit(Point destPt, Size sz, DC source, Point srcPt, int rop, bool useMask)
		{
			return Blit(destPt.X, destPt.Y, sz.Width, sz.Height, source, srcPt.X, srcPt.Y, rop, useMask, -1, -1);
		}

		//---------------------------------------------------------------------

		public void EndDrawing()
		{
			wxDC_EndDrawing(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public bool FloodFill(int x, int y, Colour col)
		{
			return FloodFill(x, y, col, FloodStyle.wxFLOOD_SURFACE);
		}
		
		public bool FloodFill(int x, int y, Colour col, int style)
		{
			return wxDC_FloodFill(wxObject, x, y, Object.SafePtr(col), style);
		}
		
		public bool FloodFill(Point pt, Colour col)
		{
			return FloodFill(pt, col, FloodStyle.wxFLOOD_SURFACE);
		}
		
		public bool FloodFill(Point pt, Colour col, int style)
		{
			return FloodFill(pt.X, pt.Y, col, style);
		}
		
		//---------------------------------------------------------------------
		
		public bool GetPixel(int x, int y, Colour col)
		{
			return wxDC_GetPixel(wxObject, x, y, Object.SafePtr(col));
		}
		
		public bool GetPixel(Point pt, Colour col)
		{
			return GetPixel(pt.X, pt.Y, col);
		}
		
		//---------------------------------------------------------------------
		
		public void CrossHair(int x, int y)
		{
			wxDC_CrossHair(wxObject, x, y);
		}
		
		public void CrossHair(Point pt)
		{
			CrossHair(pt.X, pt.Y);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawArc(int x1, int y1, int x2, int y2, int xc, int yc)
		{
			wxDC_DrawArc(wxObject, x1, y1, x2, y2, xc, yc);
		}
		
		public void DrawArc(Point pt1, Point pt2, Point centre)
		{
			DrawArc(pt1.X, pt1.Y, pt2.X, pt2.Y, centre.X, centre.Y);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawCheckMark(int x, int y, int width, int height)
		{
			wxDC_DrawCheckMark(wxObject, x, y, width, height);
		}
		
		public void DrawCheckMark(Rectangle rect)
		{
			DrawCheckMark(rect.X, rect.Y, rect.Width, rect.Height);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawEllipticArc(int x, int y, int w, int h, double sa, double ea)
		{
			wxDC_DrawEllipticArc(wxObject, x, y, w, h, sa, ea);
		}
		
		public void DrawEllipticArc(Point pt, Size sz, double sa, double ea)
		{
			DrawEllipticArc(pt.X, pt.Y, sz.Width, sz.Height, sa, ea);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawLines(Point[] points, int xoffset, int yoffset)
		{
			wxDC_DrawLines(wxObject, points.Length, points, xoffset, yoffset);
		}
		
		public void DrawLines(Point[] points)
		{
			DrawLines(points, 0, 0);
		}
		
		public void DrawLines(Point[] points, int xoffset)
		{
			DrawLines(points, xoffset, 0);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawCircle(int x, int y, int radius)
		{
			wxDC_DrawCircle(wxObject, x, y, radius);
		}
		
		public void DrawCircle(Point pt, int radius)
		{
			DrawCircle(pt.X, pt.Y, radius);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawIcon(Icon icon, int x, int y)
		{
			wxDC_DrawIcon(wxObject, Object.SafePtr(icon), x, y);
		}
		
		public void DrawIcon(Icon icon, Point pt)
		{
			DrawIcon(icon, pt.X, pt.Y);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawRotatedText(string text, int x, int y, double angle)
		{
			wxDC_DrawRotatedText(wxObject, text, x, y, angle);
		}
		
		public void DrawRotatedText(string text, Point pt, double angle)
		{
			DrawRotatedText(text, pt.X, pt.Y, angle);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void DrawLabel(string text, Bitmap image, Rectangle rect, int alignment, int indexAccel, ref Rectangle rectBounding)
		{
			wxDC_DrawLabel(wxObject, text, Object.SafePtr(image), ref rect, alignment, indexAccel, ref rectBounding);
		}
		
		public virtual void DrawLabel(string text, Bitmap image, Rectangle rect)
		{
			Rectangle dummy = new Rectangle();
			DrawLabel(text, image, rect, (int)(Alignment.wxALIGN_LEFT | Alignment.wxALIGN_TOP), -1, ref dummy);
		}
		
		public virtual void DrawLabel(string text, Bitmap image, Rectangle rect, int alignment)
		{
			Rectangle dummy = new Rectangle();
			DrawLabel(text, image, rect, alignment, -1, ref dummy);
		}
		
		public virtual void DrawLabel(string text, Bitmap image, Rectangle rect, int alignment, int indexAccel)
		{
			Rectangle dummy = new Rectangle();
			DrawLabel(text, image, rect, alignment, indexAccel, ref dummy);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawLabel(string text, Rectangle rect, int alignment, int indexAccel)
		{
			wxDC_DrawLabel2(wxObject, text, ref rect, alignment, indexAccel);
		}
		
		public void DrawLabel(string text, Rectangle rect)
		{
			DrawLabel(text, rect, (int)(Alignment.wxALIGN_LEFT | Alignment.wxALIGN_TOP), -1);
		}
		
		public void DrawLabel(string text, Rectangle rect, int alignment)
		{
			DrawLabel(text, rect, alignment, -1);
		}
		
		//---------------------------------------------------------------------
		
		public void DrawSpline(int x1, int y1, int x2, int y2, int x3, int y3)
		{
			wxDC_DrawSpline(wxObject, x1, y1, x2, y2, x3, y3);
		}
		
		public void DrawSpline(Point[] points)
		{
			wxDC_DrawSpline2(wxObject, points.Length, points);
		}
		
		//---------------------------------------------------------------------
		
		public virtual bool StartDoc(string message)
		{
			return wxDC_StartDoc(wxObject, message);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void EndDoc()
		{
			wxDC_EndDoc(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void StartPage()
		{
			wxDC_StartPage(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void EndPage()
		{
			wxDC_EndPage(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public void GetClippingBox(out int x, out int y, out int w, out int h)
		{
			wxDC_GetClippingBox(wxObject, out x, out y, out w, out h);
		}
		
		public void GetClippingBox(out Rectangle rect)
		{
			wxDC_GetClippingBox2(wxObject, out rect);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void GetMultiLineTextExtent(string text, out int width, out int height, out int heightline, Font font)
		{
			wxDC_GetMultiLineTextExtent(wxObject, text, out width, out height, out heightline, Object.SafePtr(font));
		}
		
		public virtual void GetMultiLineTextExtent(string text, out int width, out int height)
		{	
			int heightline;
			
			GetMultiLineTextExtent(text, out width, out height, out heightline, null);
		}
		
		public virtual void GetMultiLineTextExtent(string text, out int width, out int height, out int heightline)
		{	
			GetMultiLineTextExtent(text, out width, out height, out heightline, null);
		}
		
		//---------------------------------------------------------------------
		
		public bool GetPartialTextExtents(string text, int[] widths)
		{
			ArrayInt ai = new ArrayInt();
			
			for(int i = 0; i < widths.Length; ++i)
				ai.Add(widths[i]);
				
			return wxDC_GetPartialTextExtents(wxObject, text, ArrayInt.SafePtr(ai));
		}
		
		//---------------------------------------------------------------------
		
		public void GetSize(out int width, out int height)
		{
			wxDC_GetSize(wxObject, out width, out height);
		}
		
		public Size Size
		{
			get { 
				Size size = new Size();
				wxDC_GetSize2(wxObject, ref size);
				return size;
			}
		}
		
		//---------------------------------------------------------------------
		
		public void GetSizeMM(out int width, out int height)
		{
			wxDC_GetSizeMM(wxObject, out width, out height);
		}
		
		public Size SizeMM
		{
			get { 
				Size size = new Size();
				wxDC_GetSizeMM2(wxObject, ref size);
				return size;
			}
		}
		
		//---------------------------------------------------------------------
		
		public int DeviceToLogicalX(int x)
		{
			return wxDC_DeviceToLogicalX(wxObject, x);
		}
		
		//---------------------------------------------------------------------
		
		public int DeviceToLogicalY(int y)
		{
			return wxDC_DeviceToLogicalY(wxObject, y);
		}
		
		//---------------------------------------------------------------------
		
		public int DeviceToLogicalXRel(int x)
		{
			return wxDC_DeviceToLogicalXRel(wxObject, x);
		}
		
		//---------------------------------------------------------------------
		
		public int DeviceToLogicalYRel(int y)
		{
			return wxDC_DeviceToLogicalYRel(wxObject, y);
		}
		
		//---------------------------------------------------------------------
		
		public int LogicalToDeviceX(int x)
		{
			return wxDC_LogicalToDeviceX(wxObject, x);
		}
		
		//---------------------------------------------------------------------
		
		public int LogicalToDeviceY(int y)
		{
			return wxDC_LogicalToDeviceY(wxObject, y);
		}
		
		//---------------------------------------------------------------------
		
		public int LogicalToDeviceXRel(int x)
		{
			return wxDC_LogicalToDeviceXRel(wxObject, x);
		}
		
		//---------------------------------------------------------------------
		
		public int LogicalToDeviceYRel(int y)
		{
			return wxDC_LogicalToDeviceYRel(wxObject, y);
		}
		
		//---------------------------------------------------------------------
		
		public virtual bool Ok
		{
			get { return wxDC_Ok(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public int MapMode
		{
			get { return wxDC_GetMapMode(wxObject); }
			set { wxDC_SetMapMode(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public virtual void GetUserScale(out double x, out double y)
		{
			wxDC_GetUserScale(wxObject, out x, out y);
		}
		
		public virtual void SetUserScale(double x, double y)
		{
			wxDC_SetUserScale(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void GetLogicalScale(out double x, out double y)
		{
			wxDC_GetLogicalScale(wxObject, out x, out y);
		}
		
		public virtual void SetLogicalScale(double x, double y)
		{
			wxDC_SetLogicalScale(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public void GetLogicalOrigin(out int x, out int y)
		{
			wxDC_GetLogicalOrigin(wxObject, out x, out y);
		}
		
		public Point LogicalOrigin
		{
			get {
				Point pt = new Point();
				wxDC_GetLogicalOrigin2(wxObject, ref pt);
				return pt;
			}
		}
		
		public void SetLogicalOrigin(int x, int y)
		{
			wxDC_SetLogicalOrigin(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public void GetDeviceOrigin(out int x, out int y)
		{
			wxDC_GetDeviceOrigin(wxObject, out x, out y);
		}
		
		public Point DeviceOrigin
		{
			get {
				Point pt = new Point();
				wxDC_GetDeviceOrigin2(wxObject, ref pt);
				return pt;
			}
		}
		
		public void SetDeviceOrigin(int x, int y)
		{
			wxDC_SetDeviceOrigin(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public void SetAxisOrientation(bool xLeftRight, bool yBottomUp)
		{
			wxDC_SetAxisOrientation(wxObject, xLeftRight, yBottomUp);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void CalcBoundingBox(int x, int y)
		{
			wxDC_CalcBoundingBox(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public void ResetBoundingBox()
		{
			wxDC_ResetBoundingBox(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public int MinX
		{
			get { return wxDC_MinX(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public int MaxX
		{
			get { return wxDC_MaxX(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public int MinY
		{
			get { return wxDC_MinY(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public int MaxY
		{
			get { return wxDC_MaxY(wxObject); }
		}
	}
	
	//---------------------------------------------------------------------

	public class WindowDC : DC
	{
		[DllImport("wx-c")] static extern IntPtr wxWindowDC_ctor();
		[DllImport("wx-c")] static extern IntPtr wxWindowDC_ctor2(IntPtr win);
		[DllImport("wx-c")] static extern bool wxWindowDC_CanDrawBitmap(IntPtr self);
		[DllImport("wx-c")] static extern bool wxWindowDC_CanGetTextExtent(IntPtr self);
		[DllImport("wx-c")] static extern int wxWindowDC_GetCharWidth(IntPtr self);
		[DllImport("wx-c")] static extern int wxWindowDC_GetCharHeight(IntPtr self);
		[DllImport("wx-c")] static extern void wxWindowDC_Clear(IntPtr self);
		[DllImport("wx-c")] static extern void wxWindowDC_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern void wxWindowDC_SetPen(IntPtr self, IntPtr pen);
		[DllImport("wx-c")] static extern void wxWindowDC_SetBrush(IntPtr self, IntPtr brush);
		[DllImport("wx-c")] static extern void wxWindowDC_SetBackground(IntPtr self, IntPtr brush);
		[DllImport("wx-c")] static extern void wxWindowDC_SetLogicalFunction(IntPtr self, int function);
		[DllImport("wx-c")] static extern void wxWindowDC_SetTextForeground(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern void wxWindowDC_SetTextBackground(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern void wxWindowDC_SetBackgroundMode(IntPtr self, int mode);
		[DllImport("wx-c")] static extern void wxWindowDC_SetPalette(IntPtr self, IntPtr palette);
		[DllImport("wx-c")] static extern void wxWindowDC_GetPPI(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern int wxWindowDC_GetDepth(IntPtr self);
		
		//---------------------------------------------------------------------
	
		public WindowDC(IntPtr wxObject) 
			: base(wxObject) { }
			
		internal WindowDC(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
		
		public WindowDC()
			: this(wxWindowDC_ctor(), true) {}
			
		public WindowDC(Window win)
			: this(wxWindowDC_ctor2(Object.SafePtr(win)), true) {}
			
		~WindowDC()
		{
			Dispose();
		}
			
		//---------------------------------------------------------------------
		
		public bool CanDrawBitmap()
		{
			return wxWindowDC_CanDrawBitmap(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public bool CanGetTextExtent()
		{
			return wxWindowDC_CanGetTextExtent(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public int GetCharWidth()
		{
			return wxWindowDC_GetCharWidth(wxObject); 
		}
		
		//---------------------------------------------------------------------
		
		public int GetCharHeight()
		{
			return wxWindowDC_GetCharHeight(wxObject); 
		}
		
		//---------------------------------------------------------------------
		
		public int CharHeight
		{
			get { return wxWindowDC_GetCharHeight(wxObject); }
		}
		
		//---------------------------------------------------------------------

		public int CharWidth
		{
			get { return wxWindowDC_GetCharWidth(wxObject); }
		}	
		
		//---------------------------------------------------------------------
		
		public override void Clear()
		{
			wxWindowDC_Clear(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public void SetFont(Font font)
		{
			wxWindowDC_SetFont(wxObject, Object.SafePtr(font));
		}
		
		//---------------------------------------------------------------------
		
		public void SetPen(Pen pen)
		{
			wxWindowDC_SetPen(wxObject, Object.SafePtr(pen));
		}
		
		//---------------------------------------------------------------------
		
		public void SetBrush(Brush brush)
		{
			wxWindowDC_SetBrush(wxObject, Object.SafePtr(brush));
		}
		
		//---------------------------------------------------------------------
		
		public void SetBackground(Brush brush)
		{
			wxWindowDC_SetBackground(wxObject, Object.SafePtr(brush));
		}
		
		//---------------------------------------------------------------------
		
		public void SetLogicalFunction(int function)
		{
			wxWindowDC_SetLogicalFunction(wxObject, function);
		}
		
		//---------------------------------------------------------------------
		
		public void SetTextForeground(Colour colour)
		{
			wxWindowDC_SetTextForeground(wxObject, Object.SafePtr(colour));
		}
		
		//---------------------------------------------------------------------
		
		public void SetTextBackground(Colour colour)
		{
			wxWindowDC_SetTextBackground(wxObject, Object.SafePtr(colour));
		}
		
		//---------------------------------------------------------------------
		
		public void SetBackgroundMode(int mode)	
		{
			wxWindowDC_SetBackgroundMode(wxObject, mode);
		}
		
		//---------------------------------------------------------------------
		
		public void SetPalette(Palette palette)
		{
			wxWindowDC_SetPalette(wxObject, Object.SafePtr(palette));
		}
		
		//---------------------------------------------------------------------
		
		public Size GetPPI()
		{
			Size sz = new Size();
			wxWindowDC_GetPPI(wxObject, ref sz);
			return sz;
		}
		
		//---------------------------------------------------------------------
		
		public int GetDepth()
		{
			return wxWindowDC_GetDepth(wxObject);
		}
	}
	
		//---------------------------------------------------------------------

	public class ClientDC : WindowDC
	{
		[DllImport("wx-c")] static extern IntPtr wxClientDC_ctor();
		[DllImport("wx-c")] static extern IntPtr wxClientDC_ctor2(IntPtr window);

		//---------------------------------------------------------------------
		
		public ClientDC(IntPtr wxObject) 
			: base(wxObject) { }
			
		internal ClientDC(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public ClientDC()
			: this(wxClientDC_ctor(), true) {}

		public ClientDC(Window window)
			: this(wxClientDC_ctor2(Object.SafePtr(window)), true) { }
			
		~ClientDC()
		{
			Dispose();
		}
	}
    
	//---------------------------------------------------------------------

	public class PaintDC : WindowDC
	{
		[DllImport("wx-c")] static extern IntPtr wxPaintDC_ctor();
		[DllImport("wx-c")] static extern IntPtr wxPaintDC_ctor2(IntPtr window);

		//---------------------------------------------------------------------

		public PaintDC(IntPtr wxObject) 
			: base(wxObject) { }
			
		internal PaintDC(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public PaintDC()
			: this(wxPaintDC_ctor(), true) { }
			
		public PaintDC(Window window)
			: this(wxPaintDC_ctor2(Object.SafePtr(window)), true) { }
			
		~PaintDC()
		{
			Dispose();
		}
	}
}
