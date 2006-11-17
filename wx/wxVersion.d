//-----------------------------------------------------------------------------
// wxD - wxVersion.d
// (C) 2005 afb <afb@users.sourceforge.net>
//
/// The wxVersion constants
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.wxVersion;
public import wx.common;

//! \cond STD
private import std.string;
//! \endcond

		//! \cond EXTERN
		static extern (C) int wxVersion_MAJOR_VERSION();
		static extern (C) int wxVersion_MINOR_VERSION();
		static extern (C) int wxVersion_RELEASE_NUMBER();
		static extern (C) int wxVersion_SUBRELEASE_NUMBER();
		static extern (C) string wxVersion_VERSION_STRING();
		static extern (C) int wxVersion_ABI_VERSION();
		//! \endcond

public int wxMAJOR_VERSION() { return wxVersion_MAJOR_VERSION(); }
public int wxMINOR_VERSION() { return wxVersion_MINOR_VERSION(); }
public int wxRELEASE_NUMBER() { return wxVersion_RELEASE_NUMBER(); }
public int wxSUBRELEASE_NUMBER() { return wxVersion_SUBRELEASE_NUMBER(); }

public string wxVERSION_STRING() { return wxVersion_VERSION_STRING(); }

public int wxABI_VERSION() { return wxVersion_ABI_VERSION(); }

