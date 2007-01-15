//-----------------------------------------------------------------------------
// wxD - global.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - global.cxx
//
// The proxy interface for wxWidgets global methods.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/busyinfo.h>
#include "local_events.h"

//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
int wxGlobal_GetNumberFromUser(
                    wxc_string msg, wxc_string prompt, wxc_string caption,
                    int value, int min, int max, wxWindow* parent,
                    const wxPoint* pos
                )
{
    if (pos == NULL) {
        pos = &wxDefaultPosition;
    }

    return wxGetNumberFromUser(
                    wxstr(msg), wxstr(prompt),
                    wxstr(caption), value, min, max, parent,
                    *pos
                );
}
*/
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxGlobal_GetHomeDir()
{
	return dstr_ret(wxGetHomeDir());
}

extern "C" WXEXPORT
dstrret wxGlobal_GetCwd()
{
	return dstr_ret(wxGetCwd());
}

//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
dstrret wxGlobal_FileSelector(const char* message, const char* default_path,
				const char* default_filename, const char* default_extension,
				const char* wildcard, int flags,
				wxWindow* parent, int x, int y)
{
	return dstr_ret(wxFileSelector(message,
						default_path,
						default_filename,
						default_extension,
						wildcard,
						flags, parent, x, y));
}
*/
//-----------------------------------------------------------------------------

class _ArrayInt : public wxArrayInt
{
public:
	_ArrayInt()
		: wxArrayInt() {}
		
	DECLARE_DISPOSABLE(_ArrayInt)
};

extern "C" WXEXPORT
wxArrayInt* wxArrayInt_ctor()
{
	return new _ArrayInt();
}

extern "C" WXEXPORT
void wxArrayInt_dtor(wxArrayInt* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxArrayInt_RegisterDisposable(_ArrayInt* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxArrayInt_Add(wxArrayInt* self, int toadd)
{
	self->Add(toadd);
}

extern "C" WXEXPORT
void wxArrayInt_Alloc(wxArrayInt* self, int n)
{
	self->Alloc(n);
}

extern "C" WXEXPORT
int wxArrayInt_Item(wxArrayInt* self, int num)
{
	return self->Item(num);
}

extern "C" WXEXPORT
int wxArrayInt_GetCount(wxArrayInt* self)
{
	return self->GetCount();
}

//-----------------------------------------------------------------------------

class _ArrayString : public wxArrayString
{
public:
	_ArrayString()
		: wxArrayString() {}
		
	DECLARE_DISPOSABLE(_ArrayString)
};

extern "C" WXEXPORT
wxArrayString* wxArrayString_ctor()
{
	return new _ArrayString();
}

extern "C" WXEXPORT
void wxArrayString_dtor(wxArrayString* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxArrayString_RegisterDisposable(_ArrayString* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxArrayString_Add(wxArrayString* self, wxc_string toadd)
{
	wxString tmps(wxstr(toadd));
	self->Add(tmps);
}

extern "C" WXEXPORT
void wxArrayString_Alloc(wxArrayString* self, int n)
{
	self->Alloc(n);
}

extern "C" WXEXPORT
dstrret wxArrayString_Item(wxArrayString* self, int num)
{
	return dstr_ret(self->Item(num));
}

extern "C" WXEXPORT
int wxArrayString_GetCount(wxArrayString* self)
{
	return self->GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSleep_func(int num)
{
	wxSleep(num);
}

extern "C" WXEXPORT
void wxMilliSleep_func(unsigned int num)
{
	wxMilliSleep(num);
}

extern "C" WXEXPORT
void wxMicroSleep_func(unsigned int num)
{
	wxMicroSleep(num);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxYield_func()
{
	wxYield();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBeginBusyCursor_func()
{
	// currently only the standard wxHOURGLASS_CURSOR
	wxBeginBusyCursor();
}

extern "C" WXEXPORT
void wxEndBusyCursor_func()
{
	wxEndBusyCursor();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindowDisabler* wxWindowDisabler_ctor(wxWindow* winToSkip)
{
	return new wxWindowDisabler(winToSkip);
}

extern "C" WXEXPORT
void wxWindowDisabler_dtor(wxWindowDisabler* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBusyInfo* wxBusyInfo_ctor(wxc_string message, wxWindow* parent)
{
	return new wxBusyInfo(wxstr(message), parent);
}

extern "C" WXEXPORT
void wxBusyInfo_dtor(wxBusyInfo* self)
{
	delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxMutexGuiEnter_func()
{
		wxMutexGuiEnter();
}

extern "C" WXEXPORT
void wxMutexGuiLeave_func()
{
	wxMutexGuiLeave();
}

/*
//-----------------------------------------------------------------------------
// wxSize

extern "C" WXEXPORT
wxSize* wxSize_ctor(int x, int y)
{
	return new wxSize(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSize_dtor(wxSize* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSize_SetWidth(wxSize* self, int w)
{
	self->SetWidth(w);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxSize_SetHeight(wxSize* self, int h)
{
	self->SetHeight(h);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSize_GetWidth(wxSize* self)
{
	return self->GetWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxSize_GetHeight(wxSize* self)
{
	return self->GetHeight();
}

//-----------------------------------------------------------------------------
// wxRect

class _Rect : public wxRect
{
public:
	_Rect(int x, int y, int w, int h)
		: wxRect(x, y, w, h) {}

	DECLARE_DISPOSABLE(_Rect)
};

extern "C" WXEXPORT
wxRect* wxRect_ctor(int x, int y, int w, int h)
{
	return new _Rect(x, y, w, h);
}

extern "C" WXEXPORT
void wxRect_dtor(wxRect* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxRect_RegisterDisposable(_Rect* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
int wxRect_GetX(wxRect* self)
{
	return self->GetX();
}

extern "C" WXEXPORT
void wxRect_SetX(wxRect* self, int x)
{
	self->SetX(x);
}

extern "C" WXEXPORT
int wxRect_GetY(wxRect* self)
{
	return self->GetY();
}

extern "C" WXEXPORT
void wxRect_SetY(wxRect* self, int y)
{
	self->SetY(y);
}

extern "C" WXEXPORT
int wxRect_GetWidth(wxRect* self)
{
	return self->GetWidth();
}

extern "C" WXEXPORT
void wxRect_SetWidth(wxRect* self, int w)
{
	self->SetWidth(w);
}

extern "C" WXEXPORT
int wxRect_GetHeight(wxRect* self)
{
	return self->GetHeight();
}

extern "C" WXEXPORT
void wxRect_SetHeight(wxRect* self, int h)
{
	self->SetHeight(h);
}
*/
