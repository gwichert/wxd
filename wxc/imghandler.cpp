//-----------------------------------------------------------------------------
// wxD - imghandler.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - imghandler.cxx
//
// The wxImageHandlers proxy interfaces.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/image.h>

extern "C" WXEXPORT
wxImageHandler* BMPHandler_ctor() 
{
    return new wxBMPHandler();
}

extern "C" WXEXPORT
wxImageHandler* ICOHandler_ctor() 
{
    return new wxICOHandler();
}

extern "C" WXEXPORT
wxImageHandler* CURHandler_ctor() 
{
    return new wxCURHandler();
}

extern "C" WXEXPORT
wxImageHandler* ANIHandler_ctor() 
{
    return new wxANIHandler();
}

extern "C" WXEXPORT
wxImageHandler* PNGHandler_ctor() 
{
    return new wxPNGHandler();
}

extern "C" WXEXPORT
wxImageHandler* GIFHandler_ctor() 
{
    return new wxGIFHandler();
}

extern "C" WXEXPORT
wxImageHandler* PCXHandler_ctor() 
{
    return new wxPCXHandler();
}

extern "C" WXEXPORT
wxImageHandler* JPEGHandler_ctor() 
{
    return new wxJPEGHandler();
}

extern "C" WXEXPORT
wxImageHandler* PNMHandler_ctor() 
{
    return new wxPNMHandler();
}

extern "C" WXEXPORT
wxImageHandler* XPMHandler_ctor() 
{
    return new wxXPMHandler();
}

extern "C" WXEXPORT
wxImageHandler* TIFFHandler_ctor() 
{
    return new wxTIFFHandler();
}

