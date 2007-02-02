//-----------------------------------------------------------------------------
// wxD - window.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - window.cxx
//
// The wxWindow proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"

//-----------------------------------------------------------------------------
// Define new event types for virtual functions

DEFINE_LOCAL_EVENT_TYPE(wxEVT_TRANSFERDATAFROMWINDOW)

extern "C" WXEXPORT
int wxWindow_EVT_TRANSFERDATAFROMWINDOW()
{
    return wxEVT_TRANSFERDATAFROMWINDOW;
}

DEFINE_LOCAL_EVENT_TYPE(wxEVT_TRANSFERDATATOWINDOW)

extern "C" WXEXPORT
int wxWindow_EVT_TRANSFERDATATOWINDOW()
{
    return wxEVT_TRANSFERDATATOWINDOW;
}

//-----------------------------------------------------------------------------
// The proxy class

class _Window : public wxWindow
{
public:
	_Window(wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxChar* name)
		: wxWindow(parent, id, pos, size, style, name)
	{
	}

    DECLARE_OBJECTDELETED(_Window)

#include "window.inc"
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxWindow* wxWindow_ctor(wxWindow *parent, wxWindowID id, const wxPoint* pos,
					const wxSize* size, int style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

/*
	if (name.data==NULL)
		name = wxPanelNameStr;
*/

	return new _Window(parent, id, *pos, *size, style,
	           (name.data != NULL) ? wxstr(name) : wxString(wxPanelNameStr));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_Close(wxWindow* self, wxc_bool force)
{
	return self->Close(force)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetClientSize(wxWindow* self, wxSize* size)
{
	self->GetClientSize(&size->x, &size->y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetSize(wxWindow* self, int x, int y, int width, int height, int flags)
{
	self->SetSize(x, y, width, height, flags);
}

extern "C" WXEXPORT
void wxWindow_SetSize2(wxWindow* self, int width, int height)
{
	self->SetSize(width, height);
}

extern "C" WXEXPORT
void wxWindow_SetSize3(wxWindow* self, wxSize* size)
{
	self->SetSize(*size);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Move(wxWindow* self, int x, int y, int flags)
{
	self->Move(x, y, flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_Show(wxWindow* self, wxc_bool show)
{
	return self->Show(show)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetBestSize(wxWindow* self, wxSize* size)
{
	*size = self->GetBestSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindow_GetId(wxWindow *self)
{
	return self->GetId();
}

extern "C" WXEXPORT
void wxWindow_SetId(wxWindow *self, int id)
{
	self->SetId(id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindow_GetWindowStyleFlag(wxWindow* self)
{
	return self->GetWindowStyleFlag();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Layout(wxWindow* self)
{
	self->Layout();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetAutoLayout(wxWindow* self, wxc_bool autoLayout)
{
	self->SetAutoLayout(autoLayout);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetBackgroundColour(wxWindow* self, wxColour* colour)
{
	self->SetBackgroundColour(*colour);
}

extern "C" WXEXPORT
void wxWindow_SetForegroundColour(wxWindow* self, wxColour* colour)
{
	self->SetForegroundColour(*colour);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetCursor(wxWindow* self, wxCursor* cursor)
{
	self->SetCursor(*cursor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetSizer(wxWindow *self, wxSizer *sizer, wxc_bool deleteOld)
{
	self->SetSizer(sizer, deleteOld);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetWindowStyleFlag(wxWindow* self, int style)
{
	self->SetWindowStyleFlag(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_SetFont(wxWindow* self, wxFont* font)
{
	return self->SetFont(*font)?1:0;
}

extern "C" WXEXPORT
wxFont *wxWindow_GetFont(wxWindow* self)
{
	return new wxFont(self->GetFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetToolTip(wxWindow* self, wxc_string tip)
{
	self->SetToolTip(wxstr(tip));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_Enable(wxWindow* self, wxc_bool enable)
{
	return self->Enable(enable)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxWindow_IsEnabled(wxWindow* self)
{
	return self->IsEnabled()?1:0;
}

//-----------------------------------------------------------------------------

#if 0
extern "C" WXEXPORT
wxc_bool wxWindow_LoadFromResource(wxWindow* self, wxWindow *parent, wxc_string resourceName, const wxResourceTable *table)
{
	return self->LoadFromResource(parent, wxstr(resourceName), table);
}
#endif

//-----------------------------------------------------------------------------

#if 0
extern "C" WXEXPORT
wxControl* wxWindow_CreateItem(wxWindow* self, const wxItemResource* childResource, const wxItemResource* parentResource, const wxResourceTable *table)
{
	return self->CreateItem(childResource, parentResource, table);
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_Destroy(wxWindow* self)
{
	return self->Destroy()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_DestroyChildren(wxWindow* self)
{
	return self->DestroyChildren()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetTitle(wxWindow* self, wxc_string title)
{
#if wxABI_VERSION < 20700
	self->SetTitle(wxstr(title));
#else
    if ((self->GetClassInfo())->IsKindOf(CLASSINFO(wxTopLevelWindow)))
    {
	wxTopLevelWindow *wind = (wxTopLevelWindow *) self;
	wind->SetTitle(wxstr(title));
    }
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxWindow_GetTitle(wxWindow* self)
{
#if wxABI_VERSION < 20700
	return new wxString(self->GetTitle().c_str());
#else
    if ((self->GetClassInfo())->IsKindOf(CLASSINFO(wxTopLevelWindow)))
    {
	wxTopLevelWindow *wind = (wxTopLevelWindow *) self;
	return new wxString(wind->GetTitle().c_str());
    }
    else
        return new wxString(wxString());
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetName(wxWindow* self, wxc_string name)
{
	self->SetName(wxstr(name));
}

extern "C" WXEXPORT
wxString* wxWindow_GetName(wxWindow* self)
{
	return new wxString(self->GetName().c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindow_NewControlId()
{
	return wxWindow::NewControlId();
}

extern "C" WXEXPORT
int wxWindow_NextControlId(int id)
{
	return wxWindow::NextControlId(id);
}

extern "C" WXEXPORT
int wxWindow_PrevControlId(int id)
{
	return wxWindow::PrevControlId(id);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Raise(wxWindow* self)
{
	self->Raise();
}

extern "C" WXEXPORT
void wxWindow_Lower(wxWindow* self)
{
	self->Lower();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetClientSize(wxWindow* self, int width, int height)
{
	self->SetClientSize(width, height);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetPosition(wxWindow* self, wxPoint *point)
{
	*point = self->GetPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetSize(wxWindow* self, wxSize* size)
{
	*size = self->GetSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetRect(wxWindow* self, wxRect* rect)
{
	*rect = self->GetRect();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetClientAreaOrigin(wxWindow* self, wxPoint* point)
{
	*point = self->GetClientAreaOrigin();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetClientRect(wxWindow* self, wxRect* rect)
{
	*rect = self->GetClientRect();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetAdjustedBestSize(wxWindow* self, wxSize* size)
{
#if wxABI_VERSION < 20700
	*size = self->GetAdjustedBestSize();
#else
	*size = self->GetEffectiveMinSize();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Center(wxWindow* self, int direction)
{
	self->Center(direction);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_CenterOnScreen(wxWindow* self, int dir)
{
#if wxABI_VERSION < 20700
	self->CenterOnScreen(dir);
#else
    if ((self->GetClassInfo())->IsKindOf(CLASSINFO(wxTopLevelWindow)))
    {
	wxTopLevelWindow *wind = (wxTopLevelWindow *) self;
	wind->CenterOnScreen(dir);
    }
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_CenterOnParent(wxWindow* self, int dir)
{
	self->CenterOnParent(dir);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Fit(wxWindow* self)
{
	self->Fit();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_FitInside(wxWindow* self)
{
	self->FitInside();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetSizeHints(wxWindow* self, int minW, int minH, int maxW, int maxH, int incW, int incH)
{
	self->SetSizeHints(minW, minH, maxW, maxH, incW, incH);
}

extern "C" WXEXPORT
void wxWindow_SetVirtualSizeHints(wxWindow* self, int minW, int minH, int maxW, int maxH)
{
	self->SetVirtualSizeHints(minW, minH, maxW, maxH);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindow_GetMinWidth(wxWindow* self)
{
	return self->GetMinWidth();
}

extern "C" WXEXPORT
int wxWindow_GetMinHeight(wxWindow* self)
{
	return self->GetMinHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindow_GetMaxWidth(wxWindow* self)
{
	return self->GetMaxWidth();
}

extern "C" WXEXPORT
int wxWindow_GetMaxHeight(wxWindow* self)
{
	return self->GetMaxHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetMinSize(wxWindow* self, const wxSize *size)
{
	self->SetMinSize(*size);
}

extern "C" WXEXPORT
void wxWindow_GetMinSize(wxWindow* self, wxSize* size)
{
	*size = self->GetMinSize();
}

extern "C" WXEXPORT
void wxWindow_SetMaxSize(wxWindow* self, const wxSize *size)
{
	self->SetMaxSize(*size);
}

extern "C" WXEXPORT
void wxWindow_GetMaxSize(wxWindow* self, wxSize* size)
{
	*size = self->GetMaxSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetVirtualSize(wxWindow* self, const wxSize *size)
{
	self->SetVirtualSize(*size);
}

extern "C" WXEXPORT
void wxWindow_GetVirtualSize(wxWindow* self, wxSize* size)
{
	*size = self->GetVirtualSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetBestVirtualSize(wxWindow* self, wxSize* size)
{
	*size = self->GetBestVirtualSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_Hide(wxWindow* self)
{
	return self->Hide()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_Disable(wxWindow* self)
{
	return self->Disable()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_IsShown(wxWindow* self)
{
	return self->IsShown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetWindowStyle(wxWindow* self, long style)
{
	self->SetWindowStyle(style);
}

extern "C" WXEXPORT
long wxWindow_GetWindowStyle(wxWindow* self)
{
	return self->GetWindowStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_HasFlag(wxWindow* self, int flag)
{
	return self->HasFlag(flag)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_IsRetained(wxWindow* self)
{
	return self->IsRetained()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetExtraStyle(wxWindow* self, long exStyle)
{
	self->SetExtraStyle(exStyle);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
long wxWindow_GetExtraStyle(wxWindow* self)
{
	return self->GetExtraStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_MakeModal(wxWindow* self, wxc_bool modal)
{
	self->MakeModal(modal);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetThemeEnabled(wxWindow* self, wxc_bool enableTheme)
{
	self->SetThemeEnabled(enableTheme);
}

extern "C" WXEXPORT
wxc_bool wxWindow_GetThemeEnabled(wxWindow* self)
{
	return self->GetThemeEnabled()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetFocus(wxWindow* self)
{
	self->SetFocus();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetFocusFromKbd(wxWindow* self)
{
	self->SetFocusFromKbd();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_FindFocus()
{
	return wxWindow::FindFocus();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_AcceptsFocus(wxWindow* self)
{
	return self->AcceptsFocus()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_AcceptsFocusFromKeyboard(wxWindow* self)
{
	return self->AcceptsFocusFromKeyboard()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_GetDefaultItem(wxWindow* self)
{
#if wxABI_VERSION < 20700
	return self->GetDefaultItem();
#else
    if ((self->GetClassInfo())->IsKindOf(CLASSINFO(wxTopLevelWindow)))
    {
	wxTopLevelWindow *wind = (wxTopLevelWindow *) self;
	return wind->GetDefaultItem();
    }
    else
	return NULL;
#endif
}

extern "C" WXEXPORT
wxWindow* wxWindow_SetDefaultItem(wxWindow* self, wxWindow *child)
{
#if wxABI_VERSION < 20700
	return self->SetDefaultItem(child);
#else
    if ((self->GetClassInfo())->IsKindOf(CLASSINFO(wxTopLevelWindow)))
    {
	wxTopLevelWindow *wind = (wxTopLevelWindow *) self;
	return wind->SetDefaultItem(child);
    }
    else
	return NULL;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetTmpDefaultItem(wxWindow* self, wxWindow *win)
{
#if wxABI_VERSION < 20700
	self->SetTmpDefaultItem(win);
#else
    if ((self->GetClassInfo())->IsKindOf(CLASSINFO(wxTopLevelWindow)))
    {
	wxTopLevelWindow *wind = (wxTopLevelWindow *) self;
	wind->SetTmpDefaultItem(win);
    }
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_GetParent(wxWindow* self)
{
	return self->GetParent();
}

extern "C" WXEXPORT
wxWindow* wxWindow_GetGrandParent(wxWindow* self)
{
	return self->GetGrandParent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_IsTopLevel(wxWindow* self)
{
	return self->IsTopLevel()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetParent(wxWindow* self, wxWindow *parent)
{
	self->SetParent(parent);
}

extern "C" WXEXPORT
wxc_bool wxWindow_Reparent(wxWindow* self, wxWindow *newParent)
{
	return self->Reparent(newParent)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_AddChild(wxWindow* self, wxWindow *child)
{
	self->AddChild(child);
}

extern "C" WXEXPORT
void wxWindow_RemoveChild(wxWindow* self, wxWindow *child)
{
	self->RemoveChild(child);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_FindWindowId(wxWindow* self, long id)
{
	return self->FindWindow(id);
}

extern "C" WXEXPORT
wxWindow* wxWindow_FindWindowName(wxWindow* self, wxc_string name)
{
	return self->FindWindow(wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_FindWindowById(long id, const wxWindow *parent)
{
	return wxWindow::FindWindowById(id, parent);
}

extern "C" WXEXPORT
wxWindow* wxWindow_FindWindowByName(wxc_string name, const wxWindow *parent)
{
	return wxWindow::FindWindowByName(wxstr(name), parent);
}

extern "C" WXEXPORT
wxWindow* wxWindow_FindWindowByLabel(wxc_string label, const wxWindow *parent)
{
	return wxWindow::FindWindowByLabel(wxstr(label), parent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxEvtHandler* wxWindow_GetEventHandler(wxWindow* self)
{
	return self->GetEventHandler();
}

extern "C" WXEXPORT
void wxWindow_SetEventHandler(wxWindow* self, wxEvtHandler *handler)
{
	self->SetEventHandler(handler);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_PushEventHandler(wxWindow* self, wxEvtHandler *handler)
{
	self->PushEventHandler(handler);
}

extern "C" WXEXPORT
wxEvtHandler* wxWindow_PopEventHandler(wxWindow* self, wxc_bool deleteHandler)
{
	return self->PopEventHandler(deleteHandler);
}

extern "C" WXEXPORT
wxc_bool wxWindow_RemoveEventHandler(wxWindow* self, wxEvtHandler *handler)
{
	return self->RemoveEventHandler(handler)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetValidator(wxWindow* self, const wxValidator *validator)
{
	self->SetValidator(*validator);
}

extern "C" WXEXPORT
const wxValidator* wxWindow_GetValidator(wxWindow* self)
{
    if (self == NULL)
            return &wxDefaultValidator;
	return self->GetValidator();
}

extern "C" WXEXPORT
wxc_bool wxWindow_Validate(wxWindow* self)
{
	return self->Validate()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_TransferDataToWindow(wxWindow* self)
{
	return self->TransferDataToWindow()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxWindow_TransferDataFromWindow(wxWindow* self)
{
	return self->TransferDataFromWindow()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_InitDialog(wxWindow* self)
{
	self->InitDialog();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetAcceleratorTable(wxWindow* self, const wxAcceleratorTable* accel)
{
	self->SetAcceleratorTable(*accel);
}

extern "C" WXEXPORT
wxAcceleratorTable* wxWindow_GetAcceleratorTable(wxWindow* self)
{
	return self->GetAcceleratorTable();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_ConvertPixelsToDialogPoint(wxWindow* self, const wxPoint* pt, wxPoint *point)
{
	*point = self->ConvertPixelsToDialog(*pt);
}

extern "C" WXEXPORT
void wxWindow_ConvertDialogToPixelsPoint(wxWindow* self, const wxPoint* pt, wxPoint* point)
{
	*point = self->ConvertDialogToPixels(*pt);
}

extern "C" WXEXPORT
void wxWindow_ConvertPixelsToDialogSize(wxWindow* self, const wxSize* sz, wxSize* size)
{
	*size = self->ConvertPixelsToDialog(*sz);
}

extern "C" WXEXPORT
void wxWindow_ConvertDialogToPixelsSize(wxWindow* self, const wxSize* sz, wxSize* size)
{
	*size = self->ConvertDialogToPixels(*sz);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_WarpPointer(wxWindow* self, int x, int y)
{
	self->WarpPointer(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_CaptureMouse(wxWindow* self)
{
	self->CaptureMouse();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_ReleaseMouse(wxWindow* self)
{
	self->ReleaseMouse();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_GetCapture()
{
	return wxWindow::GetCapture();
}

extern "C" WXEXPORT
wxc_bool wxWindow_HasCapture(wxWindow* self)
{
	return self->HasCapture()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Refresh(wxWindow* self, wxc_bool eraseBackground, const wxRect *rect)
{
	self->Refresh(eraseBackground, rect);
}

extern "C" WXEXPORT
void wxWindow_RefreshRect(wxWindow* self, const wxRect* rect)
{
	self->RefreshRect(*rect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Update(wxWindow* self)
{
	self->Update();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_ClearBackground(wxWindow* self)
{
	self->ClearBackground();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Freeze(wxWindow* self)
{
	self->Freeze();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_Thaw(wxWindow* self)
{
	self->Thaw();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_PrepareDC(wxWindow* self, wxDC *dc)
{
	self->PrepareDC(*dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_IsExposed(wxWindow* self, int x, int y, int w, int h)
{
	return self->IsExposed(x, y, w, h)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxWindow_GetBackgroundColour(wxWindow* self)
{
	return new wxColour(self->GetBackgroundColour());
}

extern "C" WXEXPORT
wxColour* wxWindow_GetForegroundColour(wxWindow* self)
{
	return new wxColour(self->GetForegroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetCaret(wxWindow* self, wxCaret *caret)
{
	self->SetCaret(caret);
}

extern "C" WXEXPORT
wxCaret* wxWindow_GetCaret(wxWindow* self)
{
	return self->GetCaret();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindow_GetCharHeight(wxWindow* self)
{
	return self->GetCharHeight();
}

extern "C" WXEXPORT
int wxWindow_GetCharWidth(wxWindow* self)
{
	return self->GetCharWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_GetTextExtent(wxWindow* self, wxc_string string, int *x, int *y, int *descent, int *externalLeading, const wxFont *theFont)
{
	self->GetTextExtent(wxstr(string), x, y, descent, externalLeading, theFont);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_ClientToScreen(wxWindow* self, const wxPoint* pt, wxPoint *point)
{
	*point = self->ClientToScreen(*pt);
}

extern "C" WXEXPORT
void wxWindow_ScreenToClient(wxWindow* self, const wxPoint* pt, wxPoint* point)
{
	*point = self->ScreenToClient(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_HitTest(wxWindow* self, const wxPoint* pt, wxHitTest* hittest)
{
	*hittest = self->HitTest(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBorder wxWindow_GetBorder(wxWindow* self)
{
	return self->GetBorder();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBorder wxWindow_GetBorderByFlags(wxWindow* self, long flags)
{
	return self->GetBorder(flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_UpdateWindowUI(wxWindow* self)
{
	self->UpdateWindowUI();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_PopupMenu(wxWindow* self, wxMenu *menu, const wxPoint* pos)
{
	return self->PopupMenu(menu, *pos)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_HasScrollbar(wxWindow* self, int orient)
{
	return self->HasScrollbar(orient)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetScrollbar(wxWindow* self, int orient, int pos, int thumbvisible, int range, wxc_bool refresh)
{
	self->SetScrollbar(orient, pos, thumbvisible, range, refresh);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetScrollPos(wxWindow* self, int orient, int pos, wxc_bool refresh)
{
	self->SetScrollPos(orient, pos, refresh);
}

extern "C" WXEXPORT
int wxWindow_GetScrollPos(wxWindow* self, int orient)
{
	return self->GetScrollPos(orient);
}

extern "C" WXEXPORT
int wxWindow_GetScrollThumb(wxWindow* self, int orient)
{
	return self->GetScrollThumb(orient);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxWindow_GetScrollRange(wxWindow* self, int orient)
{
	return self->GetScrollRange(orient);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_ScrollWindow(wxWindow* self, int dx, int dy, const wxRect* rect)
{
	self->ScrollWindow(dx, dy, rect);
}

extern "C" WXEXPORT
wxc_bool wxWindow_ScrollLines(wxWindow* self, int lines)
{
	return self->ScrollLines(lines)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxWindow_ScrollPages(wxWindow* self, int pages)
{
	return self->ScrollPages(pages)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_LineUp(wxWindow* self)
{
	return self->LineUp()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxWindow_LineDown(wxWindow* self)
{
	return self->LineDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_PageUp(wxWindow* self)
{
	return self->PageUp()?1:0;
}

extern "C" WXEXPORT
wxc_bool wxWindow_PageDown(wxWindow* self)
{
	return self->PageDown()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetHelpText(wxWindow* self, wxc_string text)
{
	self->SetHelpText(wxstr(text));
}

extern "C" WXEXPORT
void wxWindow_SetHelpTextForId(wxWindow* self, wxc_string text)
{
	self->SetHelpTextForId(wxstr(text));
}

extern "C" WXEXPORT
wxString* wxWindow_GetHelpText(wxWindow* self)
{
	return new wxString(self->GetHelpText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxToolTip* wxWindow_GetToolTip(wxWindow* self)
{
	return self->GetToolTip();
}

//-----------------------------------------------------------------------------

// TODO Not available in OS X
#if 0
extern "C" WXEXPORT
wxString* wxWindow_GetToolTipText(wxWindow* self)
{
	return new wxString(self->GetToolTipText());
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_GetAncestorWithCustomPalette(wxWindow* self)
{
	return self->GetAncestorWithCustomPalette();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetDropTarget(wxWindow* self, wxDropTarget *dropTarget)
{
	self->SetDropTarget(dropTarget);
}

extern "C" WXEXPORT
wxDropTarget* wxWindow_GetDropTarget(wxWindow* self)
{
	return self->GetDropTarget();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetConstraints(wxWindow* self, wxLayoutConstraints *constraints)
{
	self->SetConstraints(constraints);
}

extern "C" WXEXPORT
wxLayoutConstraints* wxWindow_GetConstraints(wxWindow* self)
{
	return self->GetConstraints();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_GetAutoLayout(wxWindow* self)
{
	return self->GetAutoLayout()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetSizerAndFit(wxWindow* self, wxSizer *sizer, wxc_bool deleteOld)
{
	self->SetSizerAndFit(sizer, deleteOld);
}

extern "C" WXEXPORT
wxSizer* wxWindow_GetSizer(wxWindow* self)
{
	return self->GetSizer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetContainingSizer(wxWindow* self, wxSizer* sizer)
{
	self->SetContainingSizer(sizer);
}

extern "C" WXEXPORT
wxSizer* wxWindow_GetContainingSizer(wxWindow* self)
{
	return self->GetContainingSizer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPalette* wxWindow_GetPalette(wxWindow* self)
{
	return new wxPalette(self->GetPalette());
}

extern "C" WXEXPORT
void wxWindow_SetPalette(wxWindow* self, const wxPalette* pal)
{
	self->SetPalette(*pal);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_HasCustomPalette(wxWindow* self)
{
	return self->HasCustomPalette()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxRegion* wxWindow_GetUpdateRegion(wxWindow* self)
{
    return new wxRegion(self->GetUpdateRegion());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetWindowVariant(wxWindow* self, wxWindowVariant variant)
{
	self->SetWindowVariant(variant);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindowVariant wxWindow_GetWindowVariant(wxWindow* self)
{
	return self->GetWindowVariant();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_IsBeingDeleted(wxWindow* self)
{
	return self->IsBeingDeleted()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_InvalidateBestSize(wxWindow* self)
{
	self->InvalidateBestSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_CacheBestSize(wxWindow* self, wxSize* size)
{
	self->CacheBestSize(*size);
}

//-----------------------------------------------------------------------------

#ifdef WXWIN_COMPATIBILITY_2_6
extern "C" WXEXPORT
void wxWindow_GetBestFittingSize(wxWindow* self, wxSize* size)
{
	*size = self->GetBestFittingSize();
}
#endif

//-----------------------------------------------------------------------------

#ifdef WXWIN_COMPATIBILITY_2_6
extern "C" WXEXPORT
void wxWindow_SetBestFittingSize(wxWindow* self, wxSize* size)
{
	self->SetBestFittingSize(*size);
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxWindow* wxWindow_GetChildren(wxWindow* self, int num)
{
	if (num >= (int)self->GetChildren().GetCount())
		return NULL;

	wxWindowListNode* node = self->GetChildren().Item(num);
	return node->GetData();
}

extern "C" WXEXPORT
int wxWindow_GetChildrenCount(wxWindow* self)
{
	return self->GetChildren().GetCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxVisualAttributes* wxWindow_GetDefaultAttributes(wxWindow* self)
{
	return new wxVisualAttributes(self->GetDefaultAttributes());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxVisualAttributes* wxWindow_GetClassDefaultAttributes(wxWindowVariant variant)
{
	return new wxVisualAttributes(wxWindow::GetClassDefaultAttributes(variant));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_SetBackgroundStyle(wxWindow* self, wxBackgroundStyle style)
{
	self->SetBackgroundStyle(style);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxBackgroundStyle wxWindow_GetBackgroundStyle(wxWindow* self)
{
	return self->GetBackgroundStyle();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxWindow_InheritAttributes(wxWindow* self)
{
	self->InheritAttributes();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxWindow_ShouldInheritColours(wxWindow* self)
{
	return self->ShouldInheritColours()?1:0;
}

//-----------------------------------------------------------------------------
// wxVisualAttributes

struct _VisualAttributes : public wxVisualAttributes
{
public:
	_VisualAttributes()
		: wxVisualAttributes() {}

	DECLARE_DISPOSABLE(_VisualAttributes)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxVisualAttributes* wxVisualAttributes_ctor()
{
	return new _VisualAttributes();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVisualAttributes_dtor(wxVisualAttributes* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVisualAttributes_RegisterDisposable(_VisualAttributes* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVisualAttributes_SetFont(wxVisualAttributes* self, wxFont* font)
{
	self->font = *font;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxVisualAttributes_GetFont(wxVisualAttributes* self)
{
	return new wxFont(self->font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVisualAttributes_SetColourFg(wxVisualAttributes* self, wxColour* colour)
{
	self->colFg = *colour;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxVisualAttributes_GetColourFg(wxVisualAttributes* self)
{
	return new wxColour(self->colFg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVisualAttributes_SetColourBg(wxVisualAttributes* self, wxColour* colour)
{
	self->colBg = *colour;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxVisualAttributes_GetColourBg(wxVisualAttributes* self)
{
	return new wxColour(self->colBg);
}




