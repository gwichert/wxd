//-----------------------------------------------------------------------------
// wx.NET - boxsizer.cxx
//
// The wxBoxSizer proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "local_events.h"

#if defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif

typedef void (CALLBACK* Virtual_voidvoid) ();
typedef wxSize* (CALLBACK* Virtual_sizevoid) ();

class _BoxSizer : public wxBoxSizer
{
public:
	_BoxSizer(int orient)
		: wxBoxSizer(orient) {}
		
	void RegisterVirtual(Virtual_voidvoid recalcSizes, Virtual_sizevoid calcMin)
	{
		m_RecalcSizes = recalcSizes;
		m_CalcMin = calcMin;
	}
	
	void RecalcSizes()
	{ m_RecalcSizes(); }
	
	wxSize CalcMin()
	{ return wxSize(*m_CalcMin()); }
	
private:
	Virtual_voidvoid m_RecalcSizes;
	Virtual_sizevoid m_CalcMin;
	
public:
	DECLARE_DISPOSABLE(_BoxSizer)
};

extern "C" WXEXPORT
void wxBoxSizer_RegisterVirtual(_BoxSizer* self, Virtual_voidvoid recalcSizes, Virtual_sizevoid calcMin)
{
	self->RegisterVirtual(recalcSizes, calcMin);
}

extern "C" WXEXPORT
wxBoxSizer* wxBoxSizer_ctor(int orient)
{
	return new _BoxSizer(orient);
}

extern "C" WXEXPORT
void wxBoxSizer_RegisterDisposable(_BoxSizer* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBoxSizer_RecalcSizes(_BoxSizer* self)
{
	self->wxBoxSizer::RecalcSizes();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxSize* wxBoxSizer_CalcMin(_BoxSizer* self)
{
	return new wxSize(self->wxBoxSizer::CalcMin());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxBoxSizer_GetOrientation(_BoxSizer* self)
{
	return self->GetOrientation();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxBoxSizer_SetOrientation(_BoxSizer* self, int orient)
{
	self->SetOrientation(orient);
}
