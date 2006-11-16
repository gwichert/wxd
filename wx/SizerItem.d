//-----------------------------------------------------------------------------
// wx.NET - SizerItem.cs
//
// The wxSizerItem wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class SizerItem : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxSizerItem_ctorSpace(int width, int height, int proportion, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern IntPtr wxSizerItem_ctorWindow(IntPtr window, int proportion, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern IntPtr wxSizerItem_ctorSizer(IntPtr sizer, int proportion, int flag, int border, IntPtr userData);
        [DllImport("wx-c")] static extern IntPtr wxSizerItem_ctor();
        [DllImport("wx-c")] static extern void   wxSizerItem_DeleteWindows(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_DetachSizer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_GetSize(IntPtr self, ref Size size);
        [DllImport("wx-c")] static extern void   wxSizerItem_CalcMin(IntPtr self, ref Size min);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetDimension(IntPtr self, ref Point pos, ref Size size);
        [DllImport("wx-c")] static extern void   wxSizerItem_GetMinSize(IntPtr self, ref Size size);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetInitSize(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetRatioSize(IntPtr self, int width, int height);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetRatioFloat(IntPtr self, float ratio);
        [DllImport("wx-c")] static extern float  wxSizerItem_GetRatioFloat(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxSizerItem_IsWindow(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxSizerItem_IsSizer(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxSizerItem_IsSpacer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetProportion(IntPtr self, int proportion);
        [DllImport("wx-c")] static extern int    wxSizerItem_GetProportion(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetFlag(IntPtr self, int flag);
        [DllImport("wx-c")] static extern int    wxSizerItem_GetFlag(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetBorder(IntPtr self, int border);
        [DllImport("wx-c")] static extern int    wxSizerItem_GetBorder(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxSizerItem_GetWindow(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetWindow(IntPtr self, IntPtr window);
        [DllImport("wx-c")] static extern IntPtr wxSizerItem_GetSizer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetSizer(IntPtr self, IntPtr sizer);
        [DllImport("wx-c")] static extern void   wxSizerItem_GetSpacer(IntPtr self, ref Size size);
        [DllImport("wx-c")] static extern void   wxSizerItem_SetSpacer(IntPtr self, ref Size size);
        [DllImport("wx-c")] static extern void   wxSizerItem_Show(IntPtr self, bool show);
        [DllImport("wx-c")] static extern bool   wxSizerItem_IsShown(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxSizerItem_GetUserData(IntPtr self);
        [DllImport("wx-c")] static extern void   wxSizerItem_GetPosition(IntPtr self, ref Point pos);

        //-----------------------------------------------------------------------------

        public SizerItem(int width, int height, int proportion, int flag, int border, Object userData)
            : this(wxSizerItem_ctorSpace(width, height, proportion, flag, border, Object.SafePtr(userData))) { }

        public SizerItem(Window window, int proportion, int flag, int border, Object userData)
            : this(wxSizerItem_ctorWindow(Object.SafePtr(window), proportion, flag, border, Object.SafePtr(userData))) { }

        public SizerItem(Sizer sizer, int proportion, int flag, int border, Object userData)
            : this(wxSizerItem_ctorSizer(Object.SafePtr(sizer), proportion, flag, border, Object.SafePtr(userData))) { }

        public SizerItem()
            : this(wxSizerItem_ctor()) { }

        public SizerItem(IntPtr wxObject)
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        public void DeleteWindows()
        {
            wxSizerItem_DeleteWindows(wxObject);
        }

        public void DetachSizer()
        {
            wxSizerItem_DetachSizer(wxObject);
        }

        //-----------------------------------------------------------------------------

        public Size Size
        {
            get { 
                Size size = new Size();
                wxSizerItem_GetSize(wxObject, ref size);
                return size; 
            }
        }

        //-----------------------------------------------------------------------------

        public Size CalcMin()
        { 
            Size min = new Size();
            wxSizerItem_CalcMin(wxObject, ref min);
            return min;
        }

        //-----------------------------------------------------------------------------

        public void SetDimension(Point pos, Size size)
        {
            wxSizerItem_SetDimension(wxObject, ref pos, ref size);
        }

        //-----------------------------------------------------------------------------

        public Size MinSize
        {
            get { 
                Size size = new Size();
                wxSizerItem_GetMinSize(wxObject, ref size);
                return size;
            }
        }

        //-----------------------------------------------------------------------------

        public void SetInitSize(int x, int y)
        {
            wxSizerItem_SetInitSize(wxObject, x, y);
        }

        //-----------------------------------------------------------------------------

        public void SetRatio(Size size)
            { SetRatio(size.Width, size.Height); }
       
        public void SetRatio(int width, int height)
        {
            wxSizerItem_SetRatioSize(wxObject, width, height);
        }

        public float Ratio
        {
            set { wxSizerItem_SetRatioFloat(wxObject, value); }
            get { return wxSizerItem_GetRatioFloat(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool IsWindow
        {
            get { return wxSizerItem_IsWindow(wxObject); }
        }

        public bool IsSizer
        {
            get { return wxSizerItem_IsSizer(wxObject); }
        }

        public bool IsSpacer
        {
            get { return wxSizerItem_IsSpacer(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Proportion
        {
            set { wxSizerItem_SetProportion(wxObject, value); }
            get { return wxSizerItem_GetProportion(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Flag
        {
            set { wxSizerItem_SetFlag(wxObject, value); }
            get { return wxSizerItem_GetFlag(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Border
        {
            set { wxSizerItem_SetBorder(wxObject, value); }
            get { return wxSizerItem_GetBorder(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public Window Window
        {
            get { return (Window)FindObject(wxSizerItem_GetWindow(wxObject)); }
            set { wxSizerItem_SetWindow(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public Sizer Sizer
        {
            get { return (Sizer)FindObject(wxSizerItem_GetSizer(wxObject)); }
            set { wxSizerItem_SetSizer(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public Size Spacer
        {
            get { 
                Size spacer = new Size();
                wxSizerItem_GetSpacer(wxObject, ref spacer);
                return spacer;
            }
            set { wxSizerItem_SetSpacer(wxObject, ref value); }
        }

        //-----------------------------------------------------------------------------

        public void Show(bool show)
        {
            wxSizerItem_Show(wxObject, show);
        }

        public bool IsShown
        {
            get { return wxSizerItem_IsShown(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public Object UserData
        {
            get { return (Object)FindObject(wxSizerItem_GetUserData(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public Point Position
        {
            get {
                Point pos = new Point();
                wxSizerItem_GetPosition(wxObject, ref pos);
                return pos;
            }
        }
    }
}

