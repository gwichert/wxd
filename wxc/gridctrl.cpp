//-----------------------------------------------------------------------------
// wxD - gridctrl.cxx
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - gridctrl.cxx
// 
// The wxGrid controls proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/grid.h>
#include <wx/generic/gridctrl.h>
#include "local_events.h"

//-----------------------------------------------------------------------------
// wxGridCellDateTimeRenderer

extern "C" WXEXPORT
wxGridCellDateTimeRenderer* wxGridCellDateTimeRenderer_ctor(dstr outformat, dstr informat)
{
	return new wxGridCellDateTimeRenderer(wxString(outformat.data, wxConvUTF8, outformat.length), wxString(informat.data, wxConvUTF8, informat.length));
}

extern "C" WXEXPORT
void wxGridCellDateTimeRenderer_dtor(wxGridCellDateTimeRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellDateTimeRenderer_Draw(wxGridCellDateTimeRenderer* self, wxGrid* grid, wxGridCellAttr* attr,
				wxDC* dc, wxRect* rect, int row, int col, bool isSelected)
{
	self->Draw(*grid, *attr, *dc, *rect, row, col, isSelected);
}

extern "C" WXEXPORT
void wxGridCellDateTimeRenderer_GetBestSize(wxGridCellDateTimeRenderer* self, wxGrid *grid, wxGridCellAttr *attr,
				wxDC* dc, int row, int col, wxSize* size)
{
	*size = self->GetBestSize(*grid, *attr, *dc, row, col);
}

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellDateTimeRenderer_Clone(wxGridCellDateTimeRenderer* self)
{
	return self->Clone();
}

extern "C" WXEXPORT
void wxGridCellDateTimeRenderer_SetParameters(wxGridCellDateTimeRenderer* self, dstr params)
{
	self->SetParameters(wxString(params.data, wxConvUTF8, params.length));
}

//-----------------------------------------------------------------------------
// wxGridCellEnumRenderer

extern "C" WXEXPORT
wxGridCellEnumRenderer* wxGridCellEnumRenderer_ctor(int n, dstr choices[])
{
	wxString *pchoices = new wxString[n];
	for (int i = 0; i < n; ++i)
	{
		pchoices[i] = wxString(choices[i].data, wxConvUTF8, choices[i].length);
        }

	return new wxGridCellEnumRenderer(*pchoices);
}

extern "C" WXEXPORT
void wxGridCellEnumRenderer_dtor(wxGridCellEnumRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellEnumRenderer_Draw(wxGridCellEnumRenderer* self, wxGrid* grid, wxGridCellAttr* attr,
				wxDC* dc, wxRect* rect, int row, int col, bool isSelected)
{
	self->Draw(*grid, *attr, *dc, *rect, row, col, isSelected);
}

extern "C" WXEXPORT
void wxGridCellEnumRenderer_GetBestSize(wxGridCellEnumRenderer* self, wxGrid *grid, wxGridCellAttr *attr,
				wxDC* dc, int row, int col, wxSize* size)
{
	*size = self->GetBestSize(*grid, *attr, *dc, row, col);
}

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellEnumRenderer_Clone(wxGridCellEnumRenderer* self)
{
	return self->Clone();
}

extern "C" WXEXPORT
void wxGridCellEnumRenderer_SetParameters(wxGridCellEnumRenderer* self, dstr params)
{
	self->SetParameters(wxString(params.data, wxConvUTF8, params.length));
}

//-----------------------------------------------------------------------------
// wxGridCellAutoWrapStringRenderer

class _GridCellAutoWrapStringRenderer : public wxGridCellAutoWrapStringRenderer
{
public:
	_GridCellAutoWrapStringRenderer()
		: wxGridCellAutoWrapStringRenderer() {}

	DECLARE_DISPOSABLE(_GridCellAutoWrapStringRenderer)
};

extern "C" WXEXPORT
wxGridCellAutoWrapStringRenderer* wxGridCellAutoWrapStringRenderer_ctor()
{
	return new _GridCellAutoWrapStringRenderer();
}

extern "C" WXEXPORT
void wxGridCellAutoWrapStringRenderer_dtor(wxGridCellAutoWrapStringRenderer* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellAutoWrapStringRenderer_RegisterDisposable(_GridCellAutoWrapStringRenderer* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxGridCellAutoWrapStringRenderer_Draw(wxGridCellAutoWrapStringRenderer* self, wxGrid* grid, wxGridCellAttr* attr,
				wxDC* dc, wxRect* rect, int row, int col, bool isSelected)
{
	self->Draw(*grid, *attr, *dc, *rect, row, col, isSelected);
}

extern "C" WXEXPORT
void wxGridCellAutoWrapStringRenderer_GetBestSize(wxGridCellAutoWrapStringRenderer* self, wxGrid *grid, wxGridCellAttr *attr,
				wxDC* dc, int row, int col, wxSize* size)
{
	*size = self->GetBestSize(*grid, *attr, *dc, row, col);
}

extern "C" WXEXPORT
wxGridCellRenderer* wxGridCellAutoWrapStringRenderer_Clone(wxGridCellAutoWrapStringRenderer* self)
{
	return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellEnumEditor

extern "C" WXEXPORT
wxGridCellEnumEditor* wxGridCellEnumEditor_ctor(int n, dstr choices[])
{
	wxString *pchoices = new wxString[n];
	for (int i = 0; i < n; ++i)
	{
		pchoices[i] = wxString(choices[i].data, wxConvUTF8, choices[i].length);
        }

	return new wxGridCellEnumEditor(* pchoices);
}

extern "C" WXEXPORT
void wxGridCellEnumEditor_dtor(wxGridCellEnumEditor* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellEnumEditor_BeginEdit(wxGridCellEnumEditor* self, int row, int col, wxGrid* grid)
{
	return self->BeginEdit(row, col, grid);
}

extern "C" WXEXPORT
bool wxGridCellEnumEditor_EndEdit(wxGridCellEnumEditor* self, int row, int col, wxGrid* grid)
{
	return self->EndEdit(row, col, grid)?1:0;
}

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellEnumEditor_Clone(wxGridCellEnumEditor* self)
{
	return self->Clone();
}

//-----------------------------------------------------------------------------
// wxGridCellAutoWrapStringEditor

class _GridCellAutoWrapStringEditor : public wxGridCellAutoWrapStringEditor
{
public:
	_GridCellAutoWrapStringEditor()
		: wxGridCellAutoWrapStringEditor() {}

	DECLARE_DISPOSABLE(_GridCellAutoWrapStringEditor)
};

extern "C" WXEXPORT
wxGridCellAutoWrapStringEditor* wxGridCellAutoWrapStringEditor_ctor()
{
	return new _GridCellAutoWrapStringEditor();
}

extern "C" WXEXPORT
void wxGridCellAutoWrapStringEditor_dtor(wxGridCellAutoWrapStringEditor* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxGridCellAutoWrapStringEditor_RegisterDisposable(_GridCellAutoWrapStringEditor* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

extern "C" WXEXPORT
void wxGridCellAutoWrapStringEditor_Create(wxGridCellAutoWrapStringEditor* self, wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
{
	self->Create(parent, id, evtHandler);
}

extern "C" WXEXPORT
wxGridCellEditor* wxGridCellAutoWrapStringEditor_Clone(wxGridCellAutoWrapStringEditor* self)
{
	return self->Clone();
}

