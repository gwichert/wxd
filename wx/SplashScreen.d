//-----------------------------------------------------------------------------
// wxD - SplashScreen.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.SplashScreen;
import wx.common;
import wx.Frame;

        static extern (C) IntPtr wxSplashScreen_ctor(IntPtr bitmap, uint splashStyle, int milliseconds, IntPtr parent, int id, inout Point pos, inout Size size, uint style);
        static extern (C) int    wxSplashScreen_GetSplashStyle(IntPtr self);
        static extern (C) IntPtr wxSplashScreen_GetSplashWindow(IntPtr self);
        static extern (C) int    wxSplashScreen_GetTimeout(IntPtr self);

        //-----------------------------------------------------------------------------

    public class SplashScreen : Frame
    {
	enum {
        	wxSPLASH_CENTRE_ON_PARENT   = 0x01,
        	wxSPLASH_CENTRE_ON_SCREEN   = 0x02,
        	wxSPLASH_NO_CENTRE          = 0x00,
        	wxSPLASH_TIMEOUT            = 0x04,
        	wxSPLASH_NO_TIMEOUT         = 0x00,

        	wxSPLASH_DEFAULT =  wxSIMPLE_BORDER | wxFRAME_NO_TASKBAR | wxSTAY_ON_TOP,
        }

        //-----------------------------------------------------------------------------

        public this(IntPtr wxobj) 
            { super(wxobj); }

        public this(Bitmap bitmap, int splashStyle, int milliseconds, Window parent, int id, Point pos=wxDefaultPosition, Size size=wxDefaultSize, int style=wxSPLASH_DEFAULT)
            { super(wxSplashScreen_ctor(wxObject.SafePtr(bitmap), splashStyle, milliseconds, wxObject.SafePtr(parent), id, pos, size, style)); }

        //-----------------------------------------------------------------------------

        public int SplashStyle() { return wxSplashScreen_GetSplashStyle(wxobj); }

        //-----------------------------------------------------------------------------

        public SplashScreenWindow SplashWindow() { return cast(SplashScreenWindow)FindObject(wxSplashScreen_GetSplashWindow(wxobj), &SplashScreenWindow.New); }

        //-----------------------------------------------------------------------------

        public int Timeout() { return wxSplashScreen_GetTimeout(wxobj); }
    }
    
    //-----------------------------------------------------------------------------

        static extern (C) IntPtr wxSplashScreenWindow_ctor(IntPtr bitmap, IntPtr parent, int id, inout Point pos, inout Size size, uint style);
        static extern (C) void   wxSplashScreenWindow_SetBitmap(IntPtr self, IntPtr bitmap);
        static extern (C) IntPtr wxSplashScreenWindow_GetBitmap(IntPtr self);

        //-----------------------------------------------------------------------------

    public class SplashScreenWindow : Window
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

        public this(Bitmap bitmap, Window parent, int id, Point pos=wxDefaultPosition, Size size=wxDefaultSize, int style=wxNO_BORDER)
            { super(wxSplashScreenWindow_ctor(wxObject.SafePtr(bitmap), wxObject.SafePtr(parent), id, pos, size, style)); }

        //-----------------------------------------------------------------------------

        public void bitmap(Bitmap value) { wxSplashScreenWindow_SetBitmap(wxobj, wxObject.SafePtr(value)); }
        public Bitmap bitmap() { return cast(Bitmap)FindObject(wxSplashScreenWindow_GetBitmap(wxobj)); }
    }

