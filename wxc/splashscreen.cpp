//-----------------------------------------------------------------------------
// wxD - splashscreen.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - splashscreen.cxx
//
// The wxSplashScreen proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/splash.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _SplashScreen : public wxSplashScreen
{
public:
    _SplashScreen(const wxBitmap& bitmap, int splashStyle, int milliseconds,
                  wxWindow* parent, wxWindowID id, const wxPoint& pos, 
                  const wxSize& size, int style)
        : wxSplashScreen(bitmap, splashStyle, milliseconds, parent, id, pos, 
                         size, style) { }

    DECLARE_OBJECTDELETED(_SplashScreen)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSplashScreen* wxSplashScreen_ctor(wxBitmap* bitmap, int splashStyle, int milliseconds, wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, int style)
{
    return new _SplashScreen(*bitmap, splashStyle, milliseconds, parent, id, *pos, *size, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSplashScreen_GetSplashStyle(wxSplashScreen* self)
{
    return self->GetSplashStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSplashScreenWindow* wxSplashScreen_GetSplashWindow(wxSplashScreen* self)
{
    return self->GetSplashWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSplashScreen_GetTimeout(wxSplashScreen* self)
{
    return self->GetTimeout();
}

//-----------------------------------------------------------------------------

class _SplashScreenWindow : public wxSplashScreenWindow
{
public:
    _SplashScreenWindow(const wxBitmap& bitmap, wxWindow* parent, 
                        wxWindowID id, const wxPoint& pos, const wxSize& size,
                        int style)
        : wxSplashScreenWindow(bitmap, parent, id, pos, size, style) { }

    DECLARE_OBJECTDELETED(_SplashScreenWindow)
};



//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSplashScreenWindow* wxSplashScreenWindow_ctor(wxBitmap* bitmap, wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, int style)
{
    return new _SplashScreenWindow(*bitmap, parent, id, *pos, *size, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSplashScreenWindow_SetBitmap(wxSplashScreenWindow* self, wxBitmap* bitmap)
{
    self->SetBitmap(*bitmap);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBitmap* wxSplashScreenWindow_GetBitmap(wxSplashScreenWindow* self)
{
    return &(self->GetBitmap());
}

