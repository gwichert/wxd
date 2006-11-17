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
import wx.common;

//! \cond STD
private import std.string;
//! \endcond

		// ------------------------------------------------------
		//! \cond EXTERN
		static extern (C) bool wxPlatform_WXMSW();
		static extern (C) bool wxPlatform_WXGTK();
		static extern (C) bool wxPlatform_WXMAC();

		static extern (C) char *wxPlatform_wxGetOsDescription();
		static extern (C) int wxPlatform_wxGetOsVersion(inout int major, inout int minor);

		static extern (C) int wxPlatform_wxUNKNOWN_PLATFORM();
		static extern (C) int wxPlatform_wxWIN95();
		static extern (C) int wxPlatform_wxWINDOWS_NT();
		static extern (C) int wxPlatform_wxGTK();
		static extern (C) int wxPlatform_wxGTK_WIN32();
		static extern (C) int wxPlatform_wxMAC();
		static extern (C) int wxPlatform_wxMAC_DARWIN();
		//! \endcond
		// ------------------------------------------------------

/// Win platform
public bool __WXMSW__;
/// GTK platform
public bool __WXGTK__;
/// Mac platform
public bool __WXMAC__;

public char[] wxGetOsDescription()
{
	return toString(wxPlatform_wxGetOsDescription());
}

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

	wxUNKNOWN_PLATFORM = wxPlatform_wxUNKNOWN_PLATFORM();
	wxWIN95 = wxPlatform_wxWIN95();
	wxWINDOWS_NT = wxPlatform_wxWINDOWS_NT();
	wxGTK = wxPlatform_wxGTK();
	wxGTK_WIN32 = wxPlatform_wxGTK_WIN32();
	wxMAC = wxPlatform_wxMAC();
	wxMAC_DARWIN = wxPlatform_wxMAC_DARWIN();
}

