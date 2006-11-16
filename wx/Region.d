//-----------------------------------------------------------------------------
// wx.NET - Region.cs
//
// The wxRegion wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public enum RegionContain {
        wxOutRegion = 0,
        wxPartRegion,
        wxInRegion
    }

    public class Region : GDIObject
    {

        [DllImport("wx-c")] static extern IntPtr wxRegion_ctor();
        [DllImport("wx-c")] static extern IntPtr wxRegion_ctorByCoords(int x, int y, int w, int h);
        [DllImport("wx-c")] static extern IntPtr wxRegion_ctorByCorners(ref Point topLeft, ref Point bottomRight);
        [DllImport("wx-c")] static extern IntPtr wxRegion_ctorByRect(ref Rectangle rect);
        [DllImport("wx-c")] static extern IntPtr wxRegion_ctorByPoly(int n, ref Point[] points, int fillStyle);
        [DllImport("wx-c")] static extern IntPtr wxRegion_ctorByBitmap(IntPtr bmp, IntPtr transColour, int tolerance);
        [DllImport("wx-c")] static extern IntPtr wxRegion_ctorByRegion(IntPtr region);

        [DllImport("wx-c")] static extern void   wxRegion_dtor(IntPtr self);

        [DllImport("wx-c")] static extern void   wxRegion_Clear(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxRegion_Offset(IntPtr self, int x, int y);

        [DllImport("wx-c")] static extern bool   wxRegion_Union(IntPtr self, int x, int y, int width, int height);
        [DllImport("wx-c")] static extern bool   wxRegion_UnionRect(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern bool   wxRegion_UnionRegion(IntPtr self, IntPtr region);
        [DllImport("wx-c")] static extern bool   wxRegion_UnionBitmap(IntPtr self, IntPtr bmp, IntPtr transColour, int tolerance);

        [DllImport("wx-c")] static extern bool   wxRegion_Intersect(IntPtr self, int x, int y, int width, int height);
        [DllImport("wx-c")] static extern bool   wxRegion_IntersectRect(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern bool   wxRegion_IntersectRegion(IntPtr self, IntPtr region);

        [DllImport("wx-c")] static extern bool   wxRegion_Subtract(IntPtr self, int x, int y, int width, int height);
        [DllImport("wx-c")] static extern bool   wxRegion_SubtractRect(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern bool   wxRegion_SubtractRegion(IntPtr self, IntPtr region);

        [DllImport("wx-c")] static extern bool   wxRegion_Xor(IntPtr self, int x, int y, int width, int height);
        [DllImport("wx-c")] static extern bool   wxRegion_XorRect(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern bool   wxRegion_XorRegion(IntPtr self, IntPtr region);

        [DllImport("wx-c")] static extern RegionContain wxRegion_ContainsCoords(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern RegionContain wxRegion_ContainsPoint(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern RegionContain wxRegion_ContainsRectCoords(IntPtr self, int x, int y, int width, int height);
        [DllImport("wx-c")] static extern RegionContain wxRegion_ContainsRect(IntPtr self, ref Rectangle rect);

        [DllImport("wx-c")] static extern void   wxRegion_GetBox(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern bool   wxRegion_IsEmpty(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxRegion_ConvertToBitmap(IntPtr self);

        //---------------------------------------------------------------------

        public Region(IntPtr wxObject) 
            : base(wxObject) { }

        public Region()
            : this(wxRegion_ctor()) { }

        public Region(int x, int y, int w, int h)
            : this(wxRegion_ctorByCoords(x, y, w, h)) { }

        public Region(Point topLeft, Point bottomRight)
            : this(wxRegion_ctorByCorners(ref topLeft, ref bottomRight)) { }

        public Region(Rectangle rect)
            : this(wxRegion_ctorByRect(ref rect)) { }

        public Region(Point[] points, int fillStyle)
            : this(wxRegion_ctorByPoly(points.Length, ref points, fillStyle)) { }

        public Region(Bitmap bmp, Colour transColour, int tolerance)
            : this(wxRegion_ctorByBitmap(Object.SafePtr(bmp), Object.SafePtr(transColour), tolerance)) { }

        public Region(Region reg)
            : this(wxRegion_ctorByRegion(Object.SafePtr(reg))) { }

        //---------------------------------------------------------------------

        public void Clear()
        {
            wxRegion_Clear(wxObject);
        }

        public bool Offset(int x, int y)
        {
            return wxRegion_Offset(wxObject, x, y);
        }

        //---------------------------------------------------------------------

        public bool Union(int x, int y, int width, int height) 
        {
            return wxRegion_Union(wxObject, x, y, width, height);
        }

        public bool Union(Rectangle rect)
        {
            return wxRegion_UnionRect(wxObject, ref rect);
        }

        public bool Union(Region reg)
        {
            return wxRegion_UnionRegion(wxObject, Object.SafePtr(reg));
        }

        public bool Union(Bitmap bmp, Colour transColour, int tolerance)
        {
            return wxRegion_UnionBitmap(wxObject, Object.SafePtr(bmp), Object.SafePtr(transColour), tolerance);
        }

        //---------------------------------------------------------------------

        public bool Intersect(int x, int y, int width, int height)
        {
            return wxRegion_Intersect(wxObject, x, y, width, height);
        }

        public bool Intersect(Rectangle rect)
        {
            return wxRegion_IntersectRect(wxObject, ref rect);
        }

        public bool Intersect(Region region)
        {
            return wxRegion_IntersectRegion(wxObject, Object.SafePtr(region));
        }

        //---------------------------------------------------------------------

        public bool Subtract(int x, int y, int width, int height)
        {
            return wxRegion_Subtract(wxObject, x, y, width, height);
        }

        public bool Subtract(Rectangle rect)
        {
            return wxRegion_SubtractRect(wxObject, ref rect);
        }

        public bool Subtract(Region region)
        {
            return wxRegion_SubtractRegion(wxObject, Object.SafePtr(region));
        }

        //---------------------------------------------------------------------

        public bool Xor(int x, int y, int width, int height)
        {
            return wxRegion_Xor(wxObject, x, y, width, height);
        }

        public bool Xor(Rectangle rect)
        {
            return wxRegion_XorRect(wxObject, ref rect);
        }

        public bool Xor(Region region)
        {
            return wxRegion_XorRegion(wxObject, Object.SafePtr(region));
        }

        //---------------------------------------------------------------------

        public RegionContain Contains(int x, int y)
        {
            return wxRegion_ContainsCoords(wxObject, x, y);
        }

        public RegionContain Contains(Point pt)
        {
            return wxRegion_ContainsPoint(wxObject, ref pt);
        }

        public RegionContain Contains(int x, int y, int width, int height)
        {
            return wxRegion_ContainsRectCoords(wxObject, x, y, width, height);
        }

        public RegionContain Contains(Rectangle rect)
        {
            return wxRegion_ContainsRect(wxObject, ref rect);
        }

        //---------------------------------------------------------------------
        
        public Rectangle GetBox()
        {
            Rectangle rect = new Rectangle();
            wxRegion_GetBox(wxObject, ref rect);
            return rect;
        }

        public bool IsEmpty
        {
            get { return wxRegion_IsEmpty(wxObject); }
        }

        public Bitmap ConvertToBitmap()
        {
            return new Bitmap(wxRegion_ConvertToBitmap(wxObject));
        }
    }

    public class RegionIterator : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxRegionIterator_ctor();
        [DllImport("wx-c")] static extern IntPtr wxRegionIterator_ctorByRegion(IntPtr region);

        [DllImport("wx-c")] static extern void   wxRegionIterator_Reset(IntPtr self);
        [DllImport("wx-c")] static extern void   wxRegionIterator_ResetToRegion(IntPtr self, IntPtr region);

        [DllImport("wx-c")] static extern bool   wxRegionIterator_HaveRects(IntPtr self);
        
        [DllImport("wx-c")] static extern int    wxRegionIterator_GetX(IntPtr self);
        [DllImport("wx-c")] static extern int    wxRegionIterator_GetY(IntPtr self);

        [DllImport("wx-c")] static extern int    wxRegionIterator_GetW(IntPtr self);
        [DllImport("wx-c")] static extern int    wxRegionIterator_GetWidth(IntPtr self);
        [DllImport("wx-c")] static extern int    wxRegionIterator_GetH(IntPtr self);
        [DllImport("wx-c")] static extern int    wxRegionIterator_GetHeight(IntPtr self);

        [DllImport("wx-c")] static extern void   wxRegionIterator_GetRect(IntPtr self, ref Rectangle rect);

        //---------------------------------------------------------------------

        public RegionIterator(IntPtr wxObject) 
            : base(wxObject) { }

        public RegionIterator()
            : this(wxRegionIterator_ctor()) { }

        public RegionIterator(Region reg)
            : this(wxRegionIterator_ctorByRegion(Object.SafePtr(reg))) { }

        //---------------------------------------------------------------------

        public void Reset()
        {
            wxRegionIterator_Reset(wxObject);
        }

        public void ResetToRegion(Region region)
        {
            wxRegionIterator_ResetToRegion(wxObject, Object.SafePtr(region));
        }

        //---------------------------------------------------------------------

        public bool HaveRects()
        {
            return wxRegionIterator_HaveRects(wxObject);
        }

        //---------------------------------------------------------------------
        
        public int X
        {
            get { return wxRegionIterator_GetX(wxObject); }
        }

        public int Y
        {
            get { return wxRegionIterator_GetY(wxObject); }
        }

        //---------------------------------------------------------------------

        public int Width
        {
            get { return wxRegionIterator_GetWidth(wxObject); }
        }

        public int Height 
        {
            get { return wxRegionIterator_GetHeight(wxObject); }
        }

        //---------------------------------------------------------------------

        public Rectangle Rect
        {
            get { 
                Rectangle rect = new Rectangle();
                wxRegionIterator_GetRect(wxObject, ref rect);
                return rect;
            }
        }
    }
}
