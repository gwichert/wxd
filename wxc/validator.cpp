//-----------------------------------------------------------------------------
// wx.NET - validator.cxx
//
// The wxValidator proxy interface
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/validate.h>

extern "C" WXEXPORT
wxValidator* wxValidator_ctor()
{
	return new wxValidator();
}
