//-----------------------------------------------------------------------------
// wx.NET - SplashScreen.cs
//
// The wxSplashScreen wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class SplashScreen : Frame
    {
        public const long wxSPLASH_CENTRE_ON_PARENT   = 0x01;
        public const long wxSPLASH_CENTRE_ON_SCREEN   = 0x02;
        public const long wxSPLASH_NO_CENTRE          = 0x00;
        public const long wxSPLASH_TIMEOUT            = 0x04;
        public const long wxSPLASH_NO_TIMEOUT         = 0x00;

        public const long wxSPLASH_DEFAULT = /*Border.*/wxSIMPLE_BORDER |
                                             wxFRAME_NO_TASKBAR | 
                                             wxSTAY_ON_TOP;

        //-----------------------------------------------------------------------------

        [DllImport("wx-c")] static extern IntPtr wxSplashScreen_ctor(IntPtr bitmap, uint splashStyle, int milliseconds, IntPtr parent, int id, ref Point pos, ref Size size, uint style);
        [DllImport("wx-c")] static extern int    wxSplashScreen_GetSplashStyle(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxSplashScreen_GetSplashWindow(IntPtr self);
        [DllImport("wx-c")] static extern int    wxSplashScreen_GetTimeout(IntPtr self);

        //-----------------------------------------------------------------------------

        public SplashScreen(IntPtr wxObject) 
            : base(wxObject) { }

        public SplashScreen(Bitmap bitmap, long splashStyle, int milliseconds, Window parent, int id)
            : this(bitmap, splashStyle, milliseconds, parent, id, wxDefaultPosition, wxDefaultSize, wxSPLASH_DEFAULT) { }
        public SplashScreen(Bitmap bitmap, long splashStyle, int milliseconds, Window parent, int id, Point pos)
            : this(bitmap, splashStyle, milliseconds, parent, id, pos, wxDefaultSize, wxSPLASH_DEFAULT) { }
        public SplashScreen(Bitmap bitmap, long splashStyle, int milliseconds, Window parent, int id, Point pos, Size size)
            : this(bitmap, splashStyle, milliseconds, parent, id, pos, size, wxSPLASH_DEFAULT) { }

        public SplashScreen(Bitmap bitmap, long splashStyle, int milliseconds, Window parent, int id, Point pos, Size size, long style)
            : base(wxSplashScreen_ctor(Object.SafePtr(bitmap), (uint)splashStyle, milliseconds, Object.SafePtr(parent), id, ref pos, ref size, (uint)style)) { }

        //-----------------------------------------------------------------------------

        public long SplashStyle
        {
            get { return (long)wxSplashScreen_GetSplashStyle(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public SplashScreenWindow SplashWindow
        {
            get { return (SplashScreenWindow)FindObject(wxSplashScreen_GetSplashWindow(wxObject), typeof(SplashScreenWindow)); }
        }

        //-----------------------------------------------------------------------------

        public int Timeout
        {
            get { return wxSplashScreen_GetTimeout(wxObject); }
        }
    }
    
    //-----------------------------------------------------------------------------

    public class SplashScreenWindow : Window
    {
        [DllImport("wx-c")] static extern IntPtr wxSplashScreenWindow_ctor(IntPtr bitmap, IntPtr parent, int id, ref Point pos, ref Size size, uint style);
        [DllImport("wx-c")] static extern void   wxSplashScreenWindow_SetBitmap(IntPtr self, IntPtr bitmap);
        [DllImport("wx-c")] static extern IntPtr wxSplashScreenWindow_GetBitmap(IntPtr self);

        //-----------------------------------------------------------------------------

        public SplashScreenWindow(IntPtr wxObject) 
            : base(wxObject) { }

        public SplashScreenWindow(Bitmap bitmap, Window parent, int id, Point pos, Size size, long style)
            : base(wxSplashScreenWindow_ctor(Object.SafePtr(bitmap), Object.SafePtr(parent), id, ref pos, ref size, (uint)style)) { }

        //-----------------------------------------------------------------------------

        public Bitmap Bitmap
        {
            set { wxSplashScreenWindow_SetBitmap(wxObject, Object.SafePtr(value)); }
            get { return (Bitmap)FindObject(wxSplashScreenWindow_GetBitmap(wxObject)); }
        }
    }
}

