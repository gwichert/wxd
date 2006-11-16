//-----------------------------------------------------------------------------
// wx.NET - gbsizer.h
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class GBSizerItem : SizerItem
    {
        [DllImport("wx-c")] static extern IntPtr wxGBSizerItem_ctor(int width, int height, IntPtr pos, IntPtr span, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern IntPtr wxGBSizerItem_ctorWindow(IntPtr window, IntPtr pos, IntPtr span, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern IntPtr wxGBSizerItem_ctorSizer(IntPtr sizer, IntPtr pos, IntPtr span, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern IntPtr wxGBSizerItem_ctorDefault();

        [DllImport("wx-c")] static extern IntPtr wxGBSizerItem_GetPos(IntPtr self);

        [DllImport("wx-c")] static extern IntPtr wxGBSizerItem_GetSpan(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGBSizerItem_GetSpan(IntPtr self, IntPtr rowspan, IntPtr colspan);

        [DllImport("wx-c")] static extern bool   wxGBSizerItem_SetPos(IntPtr self, IntPtr pos);
        [DllImport("wx-c")] static extern bool   wxGBSizerItem_SetSpan(IntPtr self, IntPtr span);

        [DllImport("wx-c")] static extern bool   wxGBSizerItem_IntersectsSizer(IntPtr self, IntPtr other);
        [DllImport("wx-c")] static extern bool   wxGBSizerItem_IntersectsSpan(IntPtr self, IntPtr pos, IntPtr span);

        [DllImport("wx-c")] static extern void   wxGBSizerItem_GetEndPos(IntPtr self, ref int row, ref int col);
        [DllImport("wx-c")] static extern IntPtr wxGBSizerItem_GetGBSizer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGBSizerItem_SetGBSizer(IntPtr self, IntPtr sizer);

        //-----------------------------------------------------------------------------

        public GBSizerItem(int width, int height, GBPosition pos, GBSpan span, int flag, int border, Object userData)
            : this(wxGBSizerItem_ctor(width, height, Object.SafePtr(pos), Object.SafePtr(span), flag, border, Object.SafePtr(userData))) { }

        public GBSizerItem(Window window, GBPosition pos, GBSpan span, int flag, int border, Object userData)
            : this(wxGBSizerItem_ctorWindow(Object.SafePtr(window), Object.SafePtr(pos), Object.SafePtr(span), flag, border, Object.SafePtr(userData))) { }

        public GBSizerItem(Sizer sizer, GBPosition pos, GBSpan span, int flag, int border, Object userData)
            : this(wxGBSizerItem_ctorSizer(Object.SafePtr(sizer), Object.SafePtr(pos), Object.SafePtr(span), flag, border, Object.SafePtr(userData))) { }

        public GBSizerItem()
            : this(wxGBSizerItem_ctorDefault()) { }

        public GBSizerItem(IntPtr wxObject) 
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        public GBPosition Pos
        {
            get { return (GBPosition)FindObject(wxGBSizerItem_GetPos(wxObject), typeof(GBPosition)); }
            set { wxGBSizerItem_SetPos(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public GBSpan Span
        {
            get { return (GBSpan)FindObject(wxGBSizerItem_GetSpan(wxObject), typeof(GBSpan)); }
            set { wxGBSizerItem_SetSpan(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public bool Intersects(GBSizerItem other)
        {
            return wxGBSizerItem_IntersectsSizer(wxObject, Object.SafePtr(other));
        }

        public bool Intersects(GBPosition pos, GBSpan span)
        {
            return wxGBSizerItem_IntersectsSpan(wxObject, Object.SafePtr(pos), Object.SafePtr(span));
        }

        //-----------------------------------------------------------------------------

        public void GetEndPos(ref int row, ref int col)
        {
            wxGBSizerItem_GetEndPos(wxObject, ref row, ref col);
        }

        //-----------------------------------------------------------------------------

        public GridBagSizer GBSizer
        {
            get { return (GridBagSizer)FindObject(wxGBSizerItem_GetGBSizer(wxObject), typeof(GBSizerItem)); }
            set { wxGBSizerItem_SetGBSizer(wxObject, Object.SafePtr(value)); }
        }
    }

    public class GBSpan : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxGBSpan_ctorDefault();
        [DllImport("wx-c")] static extern IntPtr wxGBSpan_ctor(int rowspan, int colspan);

        [DllImport("wx-c")] static extern void   wxGBSpan_SetRowspan(IntPtr self, int rowspan);
        [DllImport("wx-c")] static extern int    wxGBSpan_GetRowspan(IntPtr self);
        [DllImport("wx-c")] static extern int    wxGBSpan_GetColspan(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGBSpan_SetColspan(IntPtr self, int colspan);

        //-----------------------------------------------------------------------------

        public GBSpan()
            : base(wxGBSpan_ctorDefault()) { }

        public GBSpan(int rowspan, int colspan)
            : base(wxGBSpan_ctor(rowspan, colspan)) { }

        //-----------------------------------------------------------------------------

        public int Rowspan
        {
            get { return wxGBSpan_GetRowspan(wxObject); }
            set { wxGBSpan_SetRowspan(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Colspan
        {
            get { return wxGBSpan_GetColspan(wxObject); }
            set { wxGBSpan_SetColspan(wxObject, value); }
        }
    }

    public class GridBagSizer : FlexGridSizer
    {
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_ctor(int vgap, int hgap);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_AddWindow(IntPtr self, IntPtr window, IntPtr pos, IntPtr span, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_AddSizer(IntPtr self, IntPtr sizer, IntPtr pos, IntPtr span, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_Add(IntPtr self, int width, int height, IntPtr pos, IntPtr span, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_AddItem(IntPtr self, IntPtr item);

        [DllImport("wx-c")] static extern void   wxGridBagSizer_GetEmptyCellSize(IntPtr self, ref Size size);
        [DllImport("wx-c")] static extern void   wxGridBagSizer_SetEmptyCellSize(IntPtr self, ref Size sz);
        [DllImport("wx-c")] static extern void   wxGridBagSizer_GetCellSize(IntPtr self, int row, int col, ref Size size);

        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_GetItemPositionWindow(IntPtr self, IntPtr window);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_GetItemPositionSizer(IntPtr self, IntPtr sizer);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_GetItemPositionIndex(IntPtr self, int index);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_SetItemPositionWindow(IntPtr self, IntPtr window, IntPtr pos);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_SetItemPositionSizer(IntPtr self, IntPtr sizer, IntPtr pos);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_SetItemPositionIndex(IntPtr self, int index, IntPtr pos);

        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_GetItemSpanWindow(IntPtr self, IntPtr window);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_GetItemSpanSizer(IntPtr self, IntPtr sizer);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_GetItemSpanIndex(IntPtr self, int index);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_SetItemSpanWindow(IntPtr self, IntPtr window, IntPtr span);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_SetItemSpanSizer(IntPtr self, IntPtr sizer, IntPtr span);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_SetItemSpanIndex(IntPtr self, int index, IntPtr span);

        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_FindItemWindow(IntPtr self, IntPtr window);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_FindItemSizer(IntPtr self, IntPtr sizer);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_FindItemAtPosition(IntPtr self, IntPtr pos);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_FindItemAtPoint(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern IntPtr wxGridBagSizer_FindItemWithData(IntPtr self, IntPtr userData);

        [DllImport("wx-c")] static extern bool   wxGridBagSizer_CheckForIntersectionItem(IntPtr self, IntPtr item, IntPtr excludeItem);
        [DllImport("wx-c")] static extern bool   wxGridBagSizer_CheckForIntersectionPos(IntPtr self, IntPtr pos, IntPtr span, IntPtr excludeItem);

        //-----------------------------------------------------------------------------

        public GridBagSizer(int vgap, int hgap)
            : base(wxGridBagSizer_ctor(vgap, hgap)) { }

        //-----------------------------------------------------------------------------

        public bool Add(Window window, GBPosition pos, GBSpan span, int flag, int border, Object userData)
        {
            return wxGridBagSizer_AddWindow(wxObject, Object.SafePtr(window), Object.SafePtr(pos), Object.SafePtr(span), flag, border, Object.SafePtr(userData));
        }

        public bool Add(Sizer sizer, GBPosition pos, GBSpan span, int flag, int border, Object userData)
        {
            return wxGridBagSizer_AddSizer(wxObject, Object.SafePtr(sizer), Object.SafePtr(pos), Object.SafePtr(span), flag, border, Object.SafePtr(userData));
        }

        public bool Add(int width, int height, GBPosition pos, GBSpan span, int flag, int border, Object userData)
        {
            return wxGridBagSizer_Add(wxObject, width, height, Object.SafePtr(pos), Object.SafePtr(span), flag, border, Object.SafePtr(userData));
        }

        public bool Add(GBSizerItem item)
        {
            return wxGridBagSizer_AddItem(wxObject, Object.SafePtr(item));
        }

        //-----------------------------------------------------------------------------

        public Size EmptyCellSize
        {
            get { 
                Size size = new Size();
                wxGridBagSizer_GetEmptyCellSize(wxObject, ref size);
                return size;
            }
            set { wxGridBagSizer_SetEmptyCellSize(wxObject, ref value); }
        }

        //-----------------------------------------------------------------------------

        public Size GetCellSize(int row, int col)
        {
            Size size = new Size();
            wxGridBagSizer_GetCellSize(wxObject, row, col, ref size);
            return size;
        }

        //-----------------------------------------------------------------------------

        public GBPosition GetItemPosition(Window window)
        {
            return (GBPosition)FindObject(wxGridBagSizer_GetItemPositionWindow(wxObject, Object.SafePtr(window)), typeof(GBPosition));
        }

        public GBPosition GetItemPosition(Sizer sizer)
        {
            return (GBPosition)FindObject(wxGridBagSizer_GetItemPositionSizer(wxObject, Object.SafePtr(sizer)), typeof(GBPosition));
        }

        public GBPosition GetItemPosition(int index)
        {
            return (GBPosition)FindObject(wxGridBagSizer_GetItemPositionIndex(wxObject, index), typeof(GBPosition));
        }

        //-----------------------------------------------------------------------------

        public bool SetItemPosition(Window window, GBPosition pos)
        {
            return wxGridBagSizer_SetItemPositionWindow(wxObject, Object.SafePtr(window), Object.SafePtr(pos));
        }

        public bool SetItemPosition(Sizer sizer, GBPosition pos)
        {
            return wxGridBagSizer_SetItemPositionSizer(wxObject, Object.SafePtr(sizer), Object.SafePtr(pos));
        }

        public bool SetItemPosition(int index, GBPosition pos)
        {
            return wxGridBagSizer_SetItemPositionIndex(wxObject, index, Object.SafePtr(pos));
        }

        //-----------------------------------------------------------------------------

        public GBSpan GetItemSpan(Window window)
        {
            return (GBSpan)FindObject(wxGridBagSizer_GetItemSpanWindow(wxObject, Object.SafePtr(window)), typeof(GBSpan));
        }

        public GBSpan GetItemSpan(Sizer sizer)
        {
            return (GBSpan)FindObject(wxGridBagSizer_GetItemSpanSizer(wxObject, Object.SafePtr(sizer)), typeof(GBSpan));
        }

        public GBSpan GetItemSpan(int index)
        {
            return (GBSpan)FindObject(wxGridBagSizer_GetItemSpanIndex(wxObject, index), typeof(GBSpan));
        }

        //-----------------------------------------------------------------------------

        public bool SetItemSpan(Window window, GBSpan span)
        {
            return wxGridBagSizer_SetItemSpanWindow(wxObject, Object.SafePtr(window), Object.SafePtr(span));
        }

        public bool SetItemSpan(Sizer sizer, GBSpan span)
        {
            return wxGridBagSizer_SetItemSpanSizer(wxObject, Object.SafePtr(sizer), Object.SafePtr(span));
        }

        public bool SetItemSpan(int index, GBSpan span)
        {
            return wxGridBagSizer_SetItemSpanIndex(wxObject, index, Object.SafePtr(span));
        }

        //-----------------------------------------------------------------------------

        public GBSizerItem FindItem(Window window)
        {
            return (GBSizerItem)FindObject(wxGridBagSizer_FindItemWindow(wxObject, Object.SafePtr(window)), typeof(GBSizerItem));
        }

        public GBSizerItem FindItem(Sizer sizer)
        {
            return (GBSizerItem)FindObject(wxGridBagSizer_FindItemSizer(wxObject, Object.SafePtr(sizer)), typeof(GBSizerItem));
        }

        public GBSizerItem FindItemAtPosition(GBPosition pos)
        {
            return (GBSizerItem)FindObject(wxGridBagSizer_FindItemAtPosition(wxObject, Object.SafePtr(pos)), typeof(GBSizerItem));
        }

        public GBSizerItem FindItemAtPoint(Point pt)
        {
            return (GBSizerItem)FindObject(wxGridBagSizer_FindItemAtPoint(wxObject, ref pt), typeof(GBSizerItem));
        }

        public GBSizerItem FindItemWithData(Object userData)
        {
            return (GBSizerItem)FindObject(wxGridBagSizer_FindItemWithData(wxObject, Object.SafePtr(userData)), typeof(GBSizerItem));
        }

        //-----------------------------------------------------------------------------

        public bool CheckForIntersection(GBSizerItem item, GBSizerItem excludeItem)
        {
            return wxGridBagSizer_CheckForIntersectionItem(wxObject, Object.SafePtr(item), Object.SafePtr(excludeItem));
        }

        public bool CheckForIntersection(GBPosition pos, GBSpan span, GBSizerItem excludeItem)
        {
            return wxGridBagSizer_CheckForIntersectionPos(wxObject, Object.SafePtr(pos), Object.SafePtr(span), Object.SafePtr(excludeItem));
        }
    }

    public class GBPosition : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxGBPosition_ctor();
        [DllImport("wx-c")] static extern IntPtr wxGBPosition_ctor(int row, int col);
        [DllImport("wx-c")] static extern int    wxGBPosition_GetRow(IntPtr self);
        [DllImport("wx-c")] static extern int    wxGBPosition_GetCol(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGBPosition_SetRow(IntPtr self, int row);
        [DllImport("wx-c")] static extern void   wxGBPosition_SetCol(IntPtr self, int col);

        //-----------------------------------------------------------------------------

        public GBPosition()
            : base(wxGBPosition_ctor()) { }

        //-----------------------------------------------------------------------------

        public GBPosition(int row, int col)
            : base(wxGBPosition_ctor(row, col)) { }

        //-----------------------------------------------------------------------------

        public int GetRow()
        {
            return wxGBPosition_GetRow(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int GetCol()
        {
            return wxGBPosition_GetCol(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void SetRow(int row)
        {
            wxGBPosition_SetRow(wxObject, row);
        }

        //-----------------------------------------------------------------------------

        public void SetCol(int col)
        {
            wxGBPosition_SetCol(wxObject, col);
        }
    }
}

