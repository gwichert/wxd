//-----------------------------------------------------------------------------
// wxD - boxsizer.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
#include "local_events.h"

typedef void (CALLBACK* Virtual_voidvoid) (dobj obj);
typedef wxSize (CALLBACK* Virtual_sizevoid) (dobj obj);

class _BoxSizer : public wxBoxSizer
{
public:
	_BoxSizer(int orient)
		: wxBoxSizer(orient) {}
		
	void RegisterVirtual(dobj obj, Virtual_voidvoid recalcSizes, Virtual_sizevoid calcMin)
	{
		m_dobj = obj;
		m_RecalcSizes = recalcSizes;
		m_CalcMin = calcMin;
	}
	
	void RecalcSizes()
	{ m_RecalcSizes(m_dobj); }
	
	wxSize CalcMin()
	{ return m_CalcMin(m_dobj); }
	
private:
	Virtual_voidvoid m_RecalcSizes;
	Virtual_sizevoid m_CalcMin;
	dobj m_dobj;

public:
	DECLARE_DISPOSABLE(_BoxSizer)
};

extern "C" WXEXPORT
void wxBoxSizer_RegisterVirtual(_BoxSizer* self, dobj obj,Virtual_voidvoid recalcSizes, Virtual_sizevoid calcMin)
{
	self->RegisterVirtual(obj, recalcSizes, calcMin);
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
wxSize wxBoxSizer_CalcMin(_BoxSizer* self)
{
	return self->wxBoxSizer::CalcMin();
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
