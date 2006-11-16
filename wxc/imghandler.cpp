//-----------------------------------------------------------------------------
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
#include <wx/image.h>

extern "C" WXEXPORT
void * CSharp_new_BMPHandler() 
{
    void * jresult = 0 ;
    wxBMPHandler *result;
    
    result = (wxBMPHandler *)new wxBMPHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_ICOHandler() 
{
    void * jresult = 0 ;
    wxICOHandler *result;
    
    result = (wxICOHandler *)new wxICOHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_CURHandler() 
{
    void * jresult = 0 ;
    wxCURHandler *result;
    
    result = (wxCURHandler *)new wxCURHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_ANIHandler() 
{
    void * jresult = 0 ;
    wxANIHandler *result;
    
    result = (wxANIHandler *)new wxANIHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_PNGHandler() 
{
    void * jresult = 0 ;
    wxPNGHandler *result;
    
    result = (wxPNGHandler *)new wxPNGHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_GIFHandler() 
{
    void * jresult = 0 ;
    wxGIFHandler *result;
    
    result = (wxGIFHandler *)new wxGIFHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_PCXHandler() 
{
    void * jresult = 0 ;
    wxPCXHandler *result;
    
    result = (wxPCXHandler *)new wxPCXHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_JPEGHandler() 
{
    void * jresult = 0 ;
    wxJPEGHandler *result;
    
    result = (wxJPEGHandler *)new wxJPEGHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_PNMHandler() 
{
    void * jresult = 0 ;
    wxPNMHandler *result;
    
    result = (wxPNMHandler *)new wxPNMHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_XPMHandler() 
{
    void * jresult = 0 ;
    wxXPMHandler *result;
    
    result = (wxXPMHandler *)new wxXPMHandler();
    
    jresult = (void *)result; 
    return jresult;
}

extern "C" WXEXPORT
void * CSharp_new_TIFFHandler() 
{
    void * jresult = 0 ;
    wxTIFFHandler *result;
    
    result = (wxTIFFHandler *)new wxTIFFHandler();
    
    jresult = (void *)result; 
    return jresult;
}

