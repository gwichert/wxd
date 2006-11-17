//-----------------------------------------------------------------------------
// wxD - wxPlatform.d
// (C) 2006 afb <afb@users.sourceforge.net>
//
/// The wxPlatform constants
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.wxPlatform;
public import wx.common;

//! \cond STD
private import std.string;
//! \endcond

		// ------------------------------------------------------
		//! \cond EXTERN
		static extern (C) bool wxPlatform_WXMSW();
		static extern (C) bool wxPlatform_WXGTK();
		static extern (C) bool wxPlatform_WXMAC();
		static extern (C) bool wxPlatform_WXX11();
		static extern (C) bool wxPlatform_WXUNIVERSAL();

		static extern (C) bool wxPlatform_WXDEBUG();
		static extern (C) bool wxPlatform_UNIX();
		static extern (C) bool wxPlatform_UNICODE();
		static extern (C) bool wxPlatform_DISPLAY();
		static extern (C) bool wxPlatform_POSTSCRIPT();
		static extern (C) bool wxPlatform_GLCANVAS();
		static extern (C) bool wxPlatform_SOUND();

		static extern (C) string wxPlatform_wxGetOsDescription();
		static extern (C) int wxPlatform_wxGetOsVersion(inout int major, inout int minor);

		static extern (C) int wxPlatform_wxUNKNOWN_PLATFORM();
		static extern (C) int wxPlatform_wxWIN95();
		static extern (C) int wxPlatform_wxWINDOWS_NT();
		static extern (C) int wxPlatform_wxGTK();
		static extern (C) int wxPlatform_wxGTK_WIN32();
		static extern (C) int wxPlatform_wxMAC();
		static extern (C) int wxPlatform_wxMAC_DARWIN();
		static extern (C) int wxPlatform_wxUNIX();
		static extern (C) int wxPlatform_wxX11();
		//! \endcond
		// ------------------------------------------------------

/// Win platform
public bool __WXMSW__;
/// GTK platform
public bool __WXGTK__;
/// Mac platform
public bool __WXMAC__;
/// X11 platform
public bool __WXX11__;

/// Universal widgets
public bool __WXUNIVERSAL__;

/// Get OS description as a user-readable string
public string wxGetOsDescription()
{
	return wxPlatform_wxGetOsDescription();
}

public bool ANSI;
public bool UNICODE;

public bool DEBUG;
public bool UNIX;

/// wxUSE_DISPLAY
public bool DISPLAY;
/// wxUSE_POSTSCRIPT
public bool POSTSCRIPT;
/// wxUSE_GLCANVAS
public bool GLCANVAS;
/// wxUSE_SOUND
public bool SOUND;

// ------------------------------------------------------

/// Unknown Platform
public int wxUNKNOWN_PLATFORM;

/// Windows 95/98/ME
public int wxWIN95;
/// Windows NT/2K/XP
public int wxWINDOWS_NT;

/// GTK on X11
public int wxGTK;
/// GTK on Win32
public int wxGTK_WIN32;

/// Apple Mac OS 8/9/X with Mac paths
public int wxMAC;
/// Apple Mac OS X with Unix paths
public int wxMAC_DARWIN;

/// wxBase under Unix
public int wxUNIX;
/// Plain X11 and Universal widgets
public int wxX11;

/// Get OS version
public int wxGetOsVersion(inout int major, inout int minor)
{
	return wxPlatform_wxGetOsVersion(major, minor);
}

// ------------------------------------------------------

static this()
{
	__WXMSW__ = wxPlatform_WXMSW();
	__WXGTK__ = wxPlatform_WXGTK();
	__WXMAC__ = wxPlatform_WXMAC();
	__WXX11__ = wxPlatform_WXX11();

	__WXUNIVERSAL__ = wxPlatform_WXUNIVERSAL();

	// check that wxc matches wxd:
version(__WXMSW__)
	assert(__WXMSW__);
version(__WXGTK__)
	assert(__WXGTK__);
version(__WXMAC__)
	assert(__WXMAC__);
version(__WXX11__)
	assert(__WXX11__);

	UNICODE = wxPlatform_UNICODE();
	ANSI = !UNICODE;

	DEBUG = wxPlatform_WXDEBUG();
	UNIX = wxPlatform_UNIX();

/+	//currently encoding is not used

	// check that wxc matches wxd:
version(UNICODE)
	assert(UNICODE);
else //version(ANSI)
	assert(ANSI);
+/

	DISPLAY = wxPlatform_DISPLAY();
	POSTSCRIPT = wxPlatform_POSTSCRIPT();
	GLCANVAS = wxPlatform_GLCANVAS();
	SOUND = wxPlatform_SOUND();

	// constants
	wxUNKNOWN_PLATFORM = wxPlatform_wxUNKNOWN_PLATFORM();
	wxWIN95 = wxPlatform_wxWIN95();
	wxWINDOWS_NT = wxPlatform_wxWINDOWS_NT();
	wxGTK = wxPlatform_wxGTK();
	wxGTK_WIN32 = wxPlatform_wxGTK_WIN32();
	wxMAC = wxPlatform_wxMAC();
	wxMAC_DARWIN = wxPlatform_wxMAC_DARWIN();
	wxUNIX = wxPlatform_wxUNIX();
	wxX11 = wxPlatform_wxX11();
}

