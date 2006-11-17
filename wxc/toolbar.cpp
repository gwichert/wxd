//-----------------------------------------------------------------------------
// wxD - toolbar.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - toolbar.cxx
// 
// The wxToolBar proxy interface
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/toolbar.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBarToolBase_ctor(wxToolBar *tbar, int toolid, dstr label, const wxBitmap* bmpNormal, const wxBitmap* bmpDisabled, wxItemKind kind, wxObject *clientData, dstr shortHelpString, dstr longHelpString)
{
	if (bmpNormal == NULL)
		bmpNormal = &wxNullBitmap;

	if (bmpDisabled == NULL)
		bmpDisabled = &wxNullBitmap;

	return new wxToolBarToolBase(tbar, toolid, wxString(label.data, wxConvUTF8, label.length), *bmpNormal, *bmpDisabled, kind, clientData, wxString(shortHelpString.data, wxConvUTF8, shortHelpString.length), wxString(longHelpString.data, wxConvUTF8, longHelpString.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBarToolBase_ctorCtrl(wxToolBar *tbar, wxControl *control)
{
	return new wxToolBarToolBase(tbar, control);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxToolBarToolBase_GetId(wxToolBarToolBase* self)
{
	return self->GetId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxControl* wxToolBarToolBase_GetControl(wxToolBarToolBase* self)
{
	return self->GetControl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBar* wxToolBarToolBase_GetToolBar(wxToolBarToolBase* self)
{
	return (wxToolBar*)self->GetToolBar();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_IsButton(wxToolBarToolBase* self)
{
	return self->IsButton()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_IsControl(wxToolBarToolBase* self)
{
	return self->IsControl()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_IsSeparator(wxToolBarToolBase* self)
{
	return self->IsSeparator()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxToolBarToolBase_GetStyle(wxToolBarToolBase* self)
{
	return self->GetStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxItemKind wxToolBarToolBase_GetKind(wxToolBarToolBase* self)
{
	return self->GetKind();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_IsEnabled(wxToolBarToolBase* self)
{
	return self->IsEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_IsToggled(wxToolBarToolBase* self)
{
	return self->IsToggled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_CanBeToggled(wxToolBarToolBase* self)
{
	return self->CanBeToggled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxToolBarToolBase_GetLabel(wxToolBarToolBase* self)
{
	return dstr_ret(self->GetLabel());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxToolBarToolBase_GetShortHelp(wxToolBarToolBase* self)
{
	return dstr_ret(self->GetShortHelp());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxToolBarToolBase_GetLongHelp(wxToolBarToolBase* self)
{
	return dstr_ret(self->GetLongHelp());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxToolBarToolBase_GetClientData(wxToolBarToolBase* self)
{
	return self->GetClientData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_Enable(wxToolBarToolBase* self, dbit enable)
{
	return self->Enable(enable)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_Toggle(wxToolBarToolBase* self, dbit toggle)
{
	return self->Toggle(toggle)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_SetToggle(wxToolBarToolBase* self, dbit toggle)
{
	return self->SetToggle(toggle)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_SetShortHelp(wxToolBarToolBase* self, dstr help)
{
	return self->SetShortHelp(wxString(help.data, wxConvUTF8, help.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBarToolBase_SetLongHelp(wxToolBarToolBase* self, dstr help)
{
	return self->SetLongHelp(wxString(help.data, wxConvUTF8, help.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBarToolBase_SetNormalBitmap(wxToolBarToolBase* self, const wxBitmap* bmp)
{
	self->SetNormalBitmap(*bmp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBarToolBase_SetDisabledBitmap(wxToolBarToolBase* self, const wxBitmap* bmp)
{
	self->SetDisabledBitmap(*bmp);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBarToolBase_SetLabel(wxToolBarToolBase* self, dstr label)
{
	self->SetLabel(wxString(label.data, wxConvUTF8, label.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBarToolBase_SetClientData(wxToolBarToolBase* self, wxObject *clientData)
{
	self->SetClientData(clientData);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBarToolBase_Detach(wxToolBarToolBase* self)
{
	self->Detach();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBarToolBase_Attach(wxToolBarToolBase* self, wxToolBar *tbar)
{
	self->Attach(tbar);
}

//-----------------------------------------------------------------------------

class _ToolBar : public wxToolBar
{
public:
    _ToolBar(wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, int style)
        : wxToolBar(parent, id, pos, size, style) { }

    DECLARE_OBJECTDELETED(_ToolBar)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBar* wxToolBar_ctor(wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, int style)
{
    if (pos == NULL)
        pos = &wxDefaultPosition;

    if (size == NULL)
        size = &wxDefaultSize;

	return new _ToolBar(parent, id, *pos, *size, style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddTool1(wxToolBar* self, int toolid, dstr label, const wxBitmap* bitmap, const wxBitmap* bmpDisabled, wxItemKind kind, dstr shortHelp, dstr longHelp, wxObject *data)
{
	return self->AddTool(toolid, wxString(label.data, wxConvUTF8, label.length), *bitmap, *bmpDisabled, kind, wxString(shortHelp.data, wxConvUTF8, shortHelp.length), wxString(longHelp.data, wxConvUTF8, longHelp.length), data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddTool2(wxToolBar* self, int toolid, dstr label, const wxBitmap* bitmap, dstr shortHelp, wxItemKind kind)
{
	return self->AddTool(toolid, wxString(label.data, wxConvUTF8, label.length), *bitmap, wxString(shortHelp.data, wxConvUTF8, shortHelp.length), kind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddCheckTool(wxToolBar* self, int toolid, dstr label, const wxBitmap* bitmap, const wxBitmap* bmpDisabled, dstr shortHelp, dstr longHelp, wxObject *data)
{
	if (bmpDisabled == NULL)
		bmpDisabled = &wxNullBitmap;

	return self->AddCheckTool(toolid, wxString(label.data, wxConvUTF8, label.length), *bitmap, *bmpDisabled, wxString(shortHelp.data, wxConvUTF8, shortHelp.length), wxString(longHelp.data, wxConvUTF8, longHelp.length), data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddRadioTool(wxToolBar* self, int toolid, dstr label, const wxBitmap* bitmap, const wxBitmap* bmpDisabled, dstr shortHelp, dstr longHelp, wxObject *data)
{
	if (bmpDisabled == NULL)
		bmpDisabled = &wxNullBitmap;

	return self->AddRadioTool(toolid, wxString(label.data, wxConvUTF8, label.length), *bitmap, *bmpDisabled, wxString(shortHelp.data, wxConvUTF8, shortHelp.length), wxString(longHelp.data, wxConvUTF8, longHelp.length), data);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddControl(wxToolBar* self, wxControl *control)
{
	return self->AddControl(control);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_InsertControl(wxToolBar* self, size_t pos, wxControl *control)
{
	return self->InsertControl(pos, control);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxControl* wxToolBar_FindControl(wxToolBar* self, int toolid)
{
	return self->FindControl(toolid);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddSeparator(wxToolBar* self)
{
	return self->AddSeparator();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_InsertSeparator(wxToolBar* self, size_t pos)
{
	return self->InsertSeparator(pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_RemoveTool(wxToolBar* self, int toolid)
{
	return self->RemoveTool(toolid);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBar_DeleteToolByPos(wxToolBar* self, size_t pos)
{
	return self->DeleteToolByPos(pos)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBar_DeleteTool(wxToolBar* self, int toolid)
{
	return self->DeleteTool(toolid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_ClearTools(wxToolBar* self)
{
	self->ClearTools();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBar_Realize(wxToolBar* self)
{
	return self->Realize()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_EnableTool(wxToolBar* self, int toolid, dbit enable)
{
	self->EnableTool(toolid, enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_ToggleTool(wxToolBar* self, int toolid, dbit toggle)
{
	self->ToggleTool(toolid, toggle);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxToolBar_GetToolClientData(wxToolBar* self, int toolid)
{
	return self->GetToolClientData(toolid);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetToolClientData(wxToolBar* self, int toolid, wxObject *clientData)
{
	self->SetToolClientData(toolid, clientData);
}

//-----------------------------------------------------------------------------

#if 0
extern "C" WXEXPORT
int wxToolBar_GetToolPos(wxToolBar* self, int id)
{
	return self->GetToolPos(id);
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBar_GetToolState(wxToolBar* self, int toolid)
{
	return self->GetToolState(toolid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBar_GetToolEnabled(wxToolBar* self, int toolid)
{
	return self->GetToolEnabled(toolid)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetToolShortHelp(wxToolBar* self, int toolid, dstr helpString)
{
	self->SetToolShortHelp(toolid, wxString(helpString.data, wxConvUTF8, helpString.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxToolBar_GetToolShortHelp(wxToolBar* self, int toolid)
{
	return dstr_ret(self->GetToolShortHelp(toolid).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetToolLongHelp(wxToolBar* self, int toolid, dstr helpString)
{
	self->SetToolLongHelp(toolid, wxString(helpString.data, wxConvUTF8, helpString.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxToolBar_GetToolLongHelp(wxToolBar* self, int toolid)
{
	return dstr_ret(self->GetToolLongHelp(toolid).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetMargins(wxToolBar* self, int x, int y)
{
	self->SetMargins(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetToolPacking(wxToolBar* self, int packing)
{
	self->SetToolPacking(packing);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetToolSeparation(wxToolBar* self, int separation)
{
	self->SetToolSeparation(separation);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_GetToolMargins(wxToolBar* self, wxSize* size)
{
	*size = self->GetToolMargins();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxToolBar_GetToolPacking(wxToolBar* self)
{
	return self->GetToolPacking();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxToolBar_GetToolSeparation(wxToolBar* self)
{
	return self->GetToolSeparation();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetRows(wxToolBar* self, int nRows)
{
	self->SetRows(nRows);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetMaxRowsCols(wxToolBar* self, int rows, int cols)
{
	self->SetMaxRowsCols(rows, cols);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxToolBar_GetMaxRows(wxToolBar* self)
{
	return self->GetMaxRows();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxToolBar_GetMaxCols(wxToolBar* self)
{
	return self->GetMaxCols();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_SetToolBitmapSize(wxToolBar* self, const wxSize* size)
{
	self->SetToolBitmapSize(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_GetToolBitmapSize(wxToolBar* self, wxSize* size)
{
	*size = self->GetToolBitmapSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_GetToolSize(wxToolBar* self, wxSize* size)
{
	*size = self->GetToolSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_FindToolForPosition(wxToolBar* self, wxCoord x, wxCoord y)
{
	return self->FindToolForPosition(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBar_IsVertical(wxToolBar* self)
{
	return self->IsVertical()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddTool3(wxToolBar* self, int toolid, const wxBitmap* bitmap, const wxBitmap* bmpDisabled, dbit toggle, wxObject *clientData, dstr shortHelpString, dstr longHelpString)
{
	return self->AddTool(toolid, *bitmap, *bmpDisabled, toggle, clientData, wxString(shortHelpString.data, wxConvUTF8, shortHelpString.length), wxString(longHelpString.data, wxConvUTF8, longHelpString.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddTool4(wxToolBar* self, int toolid, const wxBitmap* bitmap, dstr shortHelpString, dstr longHelpString)
{
	return self->AddTool(toolid, *bitmap, wxString(shortHelpString.data, wxConvUTF8, shortHelpString.length), wxString(longHelpString.data, wxConvUTF8, longHelpString.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_AddTool5(wxToolBar* self, int toolid, const wxBitmap* bitmap, const wxBitmap* bmpDisabled, dbit toggle, wxCoord xPos, wxCoord yPos, wxObject *clientData, dstr shortHelp, dstr longHelp)
{
	return self->AddTool(toolid, *bitmap, *bmpDisabled, toggle, xPos, yPos, clientData, wxString(shortHelp.data, wxConvUTF8, shortHelp.length), wxString(longHelp.data, wxConvUTF8, longHelp.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolBarToolBase* wxToolBar_InsertTool(wxToolBar* self, size_t pos, int toolid, const wxBitmap* bitmap, const wxBitmap* bmpDisabled, dbit toggle, wxObject *clientData, dstr shortHelp, dstr longHelp)
{
	if (bmpDisabled == NULL)
		bmpDisabled = &wxNullBitmap;

	return self->InsertTool(pos, toolid, *bitmap, *bmpDisabled, toggle, clientData, wxString(shortHelp.data, wxConvUTF8, shortHelp.length), wxString(longHelp.data, wxConvUTF8, longHelp.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxToolBar_GetMargins(wxToolBar* self, wxSize* size)
{
	*size = self->GetMargins();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
size_t wxToolBar_GetToolsCount(wxToolBar* self)
{
	return self->GetToolsCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxToolBar_AcceptsFocus(wxToolBar* self)
{
	return self->AcceptsFocus()?1:0;
}

