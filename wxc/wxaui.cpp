//-----------------------------------------------------------------------------
// wxD - wxaui.cpp
// (C) 2006 David Gileadi
//
// The wxAUI proxy interface.
//
// Written by David Gileadi (gileadis@gmail.com)
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include "local_events.h"
#if wxABI_VERSION < 20700
#define wxUSE_AUI 1
#include "manager.h"
#else
#include <wx/aui/aui.h>
#endif

#if wxUSE_AUI

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_ctor()
{
  return new wxPaneInfo();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxPaneInfo_Copy(wxPaneInfo* self, const wxPaneInfo* c)
{
  *self = *c;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsOk(wxPaneInfo* self)
{
  return self->IsOk();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsFixed(wxPaneInfo* self)
{
  return self->IsFixed();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsResizable(wxPaneInfo* self)
{
  return self->IsResizable();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsShown(wxPaneInfo* self)
{
  return self->IsShown();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsFloating(wxPaneInfo* self)
{
  return self->IsFloating();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsDocked(wxPaneInfo* self)
{
  return self->IsDocked();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsToolbar(wxPaneInfo* self)
{
  return self->IsToolbar();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsTopDockable(wxPaneInfo* self)
{
  return self->IsTopDockable();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsBottomDockable(wxPaneInfo* self)
{
  return self->IsBottomDockable();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsLeftDockable(wxPaneInfo* self)
{
  return self->IsLeftDockable();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsRightDockable(wxPaneInfo* self)
{
  return self->IsRightDockable();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsFloatable(wxPaneInfo* self)
{
  return self->IsFloatable();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_IsMovable(wxPaneInfo* self)
{
  return self->IsMovable();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasCaption(wxPaneInfo* self)
{
  return self->HasCaption();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasGripper(wxPaneInfo* self)
{
  return self->HasGripper();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasBorder(wxPaneInfo* self)
{
  return self->HasBorder();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasCloseButton(wxPaneInfo* self)
{
  return self->HasCloseButton();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasMaximizeButton(wxPaneInfo* self)
{
  return self->HasMaximizeButton();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasMinimizeButton(wxPaneInfo* self)
{
  return self->HasMinimizeButton();
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasPinButton(wxPaneInfo* self)
{
  return self->HasPinButton();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Window(wxPaneInfo* self, wxWindow* w)
{
  return &self->Window(w);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Name(wxPaneInfo* self, const wxc_string n)
{
  return &self->Name(wxstr(n));
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Caption(wxPaneInfo* self, const wxc_string c)
{
  return &self->Caption(wxstr(c));
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Left(wxPaneInfo* self)
{
  return &self->Left();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Right(wxPaneInfo* self)
{
  return &self->Right();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Top(wxPaneInfo* self)
{
  return &self->Top();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Bottom(wxPaneInfo* self)
{
  return &self->Bottom();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Center(wxPaneInfo* self)
{
  return &self->Center();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Centre(wxPaneInfo* self)
{
  return &self->Centre();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Direction(wxPaneInfo* self, int direction)
{
  return &self->Direction(direction);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Layer(wxPaneInfo* self, int layer)
{
  return &self->Layer(layer);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Row(wxPaneInfo* self, int row)
{
  return &self->Row(row);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Position(wxPaneInfo* self, int pos)
{
  return &self->Position(pos);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_BestSize(wxPaneInfo* self, const wxSize* size)
{
  return &self->BestSize(*size);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_MinSize(wxPaneInfo* self, const wxSize* size)
{
  return &self->MinSize(*size);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_MaxSize(wxPaneInfo* self, const wxSize* size)
{
  return &self->MaxSize(*size);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_BestSizeXY(wxPaneInfo* self, int x, int y)
{
  return &self->BestSize(x, y);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_MinSizeXY(wxPaneInfo* self, int x, int y)
{
  return &self->MinSize(x, y);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_MaxSizeXY(wxPaneInfo* self, int x, int y)
{
  return &self->MaxSize(x, y);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_FloatingPosition(wxPaneInfo* self, const wxPoint* pos)
{
  return &self->FloatingPosition(*pos);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_FloatingPositionXY(wxPaneInfo* self, int x, int y)
{
  return &self->FloatingPosition(x, y);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_FloatingSize(wxPaneInfo* self, const wxSize* size)
{
  return &self->FloatingSize(*size);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_FloatingSizeXY(wxPaneInfo* self, int x, int y)
{
  return &self->FloatingSize(x, y);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Fixed(wxPaneInfo* self)
{
  return &self->Fixed();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Resizable(wxPaneInfo* self, wxc_bool resizable = true)
{
  return &self->Resizable(resizable);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Dock(wxPaneInfo* self)
{
  return &self->Dock();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Float(wxPaneInfo* self)
{
  return &self->Float();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Hide(wxPaneInfo* self)
{
  return &self->Hide();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Show(wxPaneInfo* self, wxc_bool show = true)
{
  return &self->Show(show);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_CaptionVisible(wxPaneInfo* self, wxc_bool visible = true)
{
  return &self->CaptionVisible(visible);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_PaneBorder(wxPaneInfo* self, wxc_bool visible = true)
{
  return &self->PaneBorder(visible);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Gripper(wxPaneInfo* self, wxc_bool visible = true)
{
  return &self->Gripper(visible);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_CloseButton(wxPaneInfo* self, wxc_bool visible = true)
{
  return &self->CloseButton(visible);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_MaximizeButton(wxPaneInfo* self, wxc_bool visible = true)
{
  return &self->MaximizeButton(visible);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_MinimizeButton(wxPaneInfo* self, wxc_bool visible = true)
{
  return &self->MinimizeButton(visible);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_PinButton(wxPaneInfo* self, wxc_bool visible = true)
{
  return &self->PinButton(visible);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_DestroyOnClose(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->DestroyOnClose(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_TopDockable(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->TopDockable(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_BottomDockable(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->BottomDockable(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_LeftDockable(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->LeftDockable(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_RightDockable(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->RightDockable(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Floatable(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->Floatable(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Movable(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->Movable(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_Dockable(wxPaneInfo* self, wxc_bool b = true)
{
  return &self->Dockable(b);
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_DefaultPane(wxPaneInfo* self)
{
  return &self->DefaultPane();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_CentrePane(wxPaneInfo* self)
{
  return &self->CentrePane();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_CenterPane(wxPaneInfo* self)
{
  return &self->CenterPane();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_ToolbarPane(wxPaneInfo* self)
{
  return &self->ToolbarPane();
}

extern "C" WXEXPORT
wxPaneInfo* wxPaneInfo_SetFlag(wxPaneInfo* self, unsigned int flag, wxc_bool option_state)

{
  return &self->SetFlag(flag, option_state);
}

extern "C" WXEXPORT
wxc_bool wxPaneInfo_HasFlag(wxPaneInfo* self, unsigned int flag)

{
  return self->HasFlag(flag)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxPaneInfo_GetName(wxPaneInfo* self)
{
  return dstr_ret(self->name.c_str());
}

extern "C" WXEXPORT
dstrret wxPaneInfo_GetCaption(wxPaneInfo* self)
{
  return dstr_ret(self->caption.c_str());
}

extern "C" WXEXPORT
wxWindow* wxPaneInfo_GetWindow(wxPaneInfo* self)
{
  return self->window;
}

extern "C" WXEXPORT
wxWindow* wxPaneInfo_GetFrame(wxPaneInfo* self)
{
  return self->frame;
}

extern "C" WXEXPORT
unsigned int wxPaneInfo_GetState(wxPaneInfo* self)
{
  return self->state;
}

extern "C" WXEXPORT
int wxPaneInfo_GetDock_Direction(wxPaneInfo* self)
{
  return self->dock_direction;
}

extern "C" WXEXPORT
int wxPaneInfo_GetDock_Layer(wxPaneInfo* self)
{
  return self->dock_layer;
}

extern "C" WXEXPORT
int wxPaneInfo_GetDock_Row(wxPaneInfo* self)
{
  return self->dock_row;
}

extern "C" WXEXPORT
int wxPaneInfo_GetDock_Pos(wxPaneInfo* self)
{
  return self->dock_pos;
}

extern "C" WXEXPORT
void wxPaneInfo_GetBest_Size(wxPaneInfo* self, wxSize* size)
{
  *size = self->best_size;
}

extern "C" WXEXPORT
void wxPaneInfo_GetMin_Size(wxPaneInfo* self, wxSize* size)
{
  *size = self->min_size;
}

extern "C" WXEXPORT
void wxPaneInfo_GetMax_Size(wxPaneInfo* self, wxSize* size)
{
  *size = self->max_size;
}

extern "C" WXEXPORT
void wxPaneInfo_GetFloating_Pos(wxPaneInfo* self, wxPoint* point)
{
  *point = self->floating_pos;
}

extern "C" WXEXPORT
void wxPaneInfo_GetFloating_Size(wxPaneInfo* self, wxSize* size)
{
  *size = self->floating_size;
}

extern "C" WXEXPORT
int wxPaneInfo_GetDock_Proportion(wxPaneInfo* self)
{
  return self->dock_proportion;
}

extern "C" WXEXPORT
void wxPaneInfo_GetRect(wxPaneInfo* self, wxRect* rect)
{
  *rect = self->rect;
}

//-----------------------------------------------------------------------------


extern "C" WXEXPORT
wxFrameManager* wxFrameManager_ctor(wxFrame* frame = NULL, unsigned int flags = wxAUI_MGR_DEFAULT)
{
  return new wxFrameManager(frame, flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrameManager_dtor(wxFrameManager* self)
{
  delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrameManager_UnInit(wxFrameManager* self)
{
  self->UnInit();
}

extern "C" WXEXPORT
void wxFrameManager_SetFlags(wxFrameManager* self, unsigned int flags)
{
  self->SetFlags(flags);
}

extern "C" WXEXPORT
unsigned int wxFrameManager_GetFlags(wxFrameManager* self)
{
  return self->GetFlags();
}


extern "C" WXEXPORT
void wxFrameManager_SetFrame(wxFrameManager* self, wxFrame* frame)
{
  self->SetFrame(frame);
}

extern "C" WXEXPORT
wxFrame* wxFrameManager_GetFrame(wxFrameManager* self)
{
  return self->GetFrame();
}

extern "C" WXEXPORT
void wxFrameManager_SetArtProvider(wxFrameManager* self, wxDockArt* art_provider)
{
  self->SetArtProvider(art_provider);
}

extern "C" WXEXPORT
wxDockArt* wxFrameManager_GetArtProvider(wxFrameManager* self)
{
  return self->GetArtProvider();
}

extern "C" WXEXPORT
wxPaneInfo* wxFrameManager_GetPaneByWindow(wxFrameManager* self, wxWindow* window)
{
  return &self->GetPane(window);
}

extern "C" WXEXPORT
wxPaneInfo* wxFrameManager_GetPaneByName(wxFrameManager* self, const wxc_string name)
{
  return &self->GetPane(wxstr(name));
}

extern "C" WXEXPORT
int wxFrameManager_GetPaneCount(wxFrameManager* self)
{
  return self->GetAllPanes().GetCount();
}

extern "C" WXEXPORT
wxPaneInfo* wxFrameManager_GetPane(wxFrameManager* self, int index)
{
  return &self->GetAllPanes().Item(index);
}

extern "C" WXEXPORT
wxc_bool wxFrameManager_AddPane(wxFrameManager* self, wxWindow* window,
             const wxPaneInfo* pane_info)
{
  return self->AddPane(window, *pane_info)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxFrameManager_AddPane2(wxFrameManager* self, wxWindow* window,
             int direction,
             const wxc_string caption)
{
  return self->AddPane(window, direction, wxstr(caption))?1:0;
}

extern "C" WXEXPORT
wxc_bool wxFrameManager_InsertPane(wxFrameManager* self, wxWindow* window,
             const wxPaneInfo* pane_info,
             int insert_level = wxAUI_INSERT_PANE)
{
  return self->InsertPane(window, *pane_info, insert_level)?1:0;
}

extern "C" WXEXPORT
wxc_bool wxFrameManager_DetachPane(wxFrameManager* self, wxWindow* window)
{
  return self->DetachPane(window)?1:0;
}

extern "C" WXEXPORT
dstrret wxFrameManager_SavePerspective(wxFrameManager* self)
{
  return dstr_ret(self->SavePerspective().c_str());
}

extern "C" WXEXPORT
wxc_bool wxFrameManager_LoadPerspective(wxFrameManager* self, const wxc_string perspective,
             wxc_bool update = true)
{
  return self->LoadPerspective(wxstr(perspective), update)?1:0;
}

extern "C" WXEXPORT
void wxFrameManager_Update(wxFrameManager* self)
{
  self->Update();
}

extern "C" WXEXPORT int wxEvent_EVT_AUI_PANEBUTTON()        { return wxEVT_AUI_PANEBUTTON; }

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrameManagerEvent_SetPane(wxFrameManagerEvent* self, wxPaneInfo* p)
{
  self->SetPane(p);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPaneInfo* wxFrameManagerEvent_GetPane(wxFrameManagerEvent* self)
{
  return self->GetPane();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxFrameManagerEvent_SetButton(wxFrameManagerEvent* self, int b)
{
  self->SetButton(b);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxFrameManagerEvent_GetButton(wxFrameManagerEvent* self)
{
  return self->GetButton();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxEvent* wxFrameManagerEvent_Clone(wxFrameManagerEvent* self)
{
  return self->Clone();
}

//-----------------------------------------------------------------------------

typedef int (CALLBACK* Virtual_GetMetric) (wxc_object obj, int id);
typedef void (CALLBACK* Virtual_SetMetric) (wxc_object obj, int id, int new_val);
typedef void (CALLBACK* Virtual_SetFont) (wxc_object obj, int id, const wxFont* font);
typedef wxFont* (CALLBACK* Virtual_GetFont) (wxc_object obj, int id);
typedef wxColour* (CALLBACK* Virtual_GetColour) (wxc_object obj, int id);
typedef void (CALLBACK* Virtual_SetColour) (wxc_object obj, int id, const wxColor* colour);
typedef wxColour* (CALLBACK* Virtual_GetColor) (wxc_object obj, int id);
typedef void (CALLBACK* Virtual_SetColor) (wxc_object obj, int id, const wxColor* color);
typedef void (CALLBACK* Virtual_DrawSash) (wxc_object obj, wxDC* dc,
                      int orientation,
                      const wxRect* rect);
typedef void (CALLBACK* Virtual_DrawBackground) (wxc_object obj, wxDC* dc,
                      int orientation,
                      const wxRect* rect);
typedef void (CALLBACK* Virtual_DrawCaption) (wxc_object obj, wxDC* dc,
                      const wxc_string text,
                      const wxRect* rect,
                      wxPaneInfo* pane);
typedef void (CALLBACK* Virtual_DrawGripper) (wxc_object obj, wxDC* dc,
                      const wxRect* rect,
                      wxPaneInfo* pane);
typedef void (CALLBACK* Virtual_DrawBorder) (wxc_object obj, wxDC* dc,
                      const wxRect* rect,
                      wxPaneInfo* pane);
typedef void (CALLBACK* Virtual_DrawPaneButton) (wxc_object obj, wxDC* dc,
                      int button,
                      int button_state,
                      const wxRect* rect,
                      wxPaneInfo* pane);

//-----------------------------------------------------------------------------

class _DockArt : public wxDockArt
{
public:
  _DockArt() : wxDockArt()
  {}

  int GetMetric(int id)
  {
    return m_GetMetric(m_dobj, id);
  }

  void SetMetric(int id, int new_val)
  {
    m_SetMetric(m_dobj, id, new_val);
  }

  void SetFont(int id, const wxFont& font)
  {
    m_SetFont(m_dobj, id, &font);
  }

  wxFont GetFont(int id)
  {
    return *m_GetFont(m_dobj, id);
  }

  wxColour GetColour(int id)
  {
    return *m_GetColour(m_dobj, id);
  }

  void SetColour(int id, const wxColor& colour)
  {
    m_SetColour(m_dobj, id, &colour);
  }

  wxColour GetColor(int id)
  {
    return *m_GetColor(m_dobj, id);
  }

  void SetColor(int id, const wxColor& color)
  {
    m_SetColor(m_dobj, id, &color);
  }

  void DrawSash(wxDC& dc, int orientation, const wxRect& rect)
  {
    m_DrawSash(m_dobj, &dc, orientation, &rect);
  }

  void DrawBackground(wxDC& dc, int orientation, const wxRect& rect)
  {
    m_DrawBackground(m_dobj, &dc, orientation, &rect);
  }

  void DrawCaption(wxDC& dc, const wxString& text, const wxRect& rect, wxPaneInfo& pane)
  {
    m_DrawCaption(m_dobj, &dc, wxc_string(text), &rect, &pane);
  }

  void DrawGripper(wxDC& dc, const wxRect& rect, wxPaneInfo& pane)
  {
    m_DrawGripper(m_dobj, &dc, &rect, &pane);
  }

  void DrawBorder(wxDC& dc, const wxRect& rect, wxPaneInfo& pane)
  {
    m_DrawBorder(m_dobj, &dc, &rect, &pane);
  }

  void DrawPaneButton(wxDC& dc, int button, int button_state, const wxRect& rect, wxPaneInfo& pane)
  {
    m_DrawPaneButton(m_dobj, &dc, button, button_state, &rect, &pane);
  }

  void RegisterVirtual(wxc_object obj,
                      Virtual_GetMetric getMetric,
                      Virtual_SetMetric setMetric,
                      Virtual_SetFont setFont,
                      Virtual_GetFont getFont,
                      Virtual_GetColour getColour,
                      Virtual_SetColour setColour,
                      Virtual_GetColor getColor,
                      Virtual_SetColor setColor,
                      Virtual_DrawSash drawSash,
                      Virtual_DrawBackground drawBackground,
                      Virtual_DrawCaption drawCaption,
                      Virtual_DrawGripper drawGripper,
                      Virtual_DrawBorder drawBorder,
                      Virtual_DrawPaneButton drawPaneButton)
  {
    m_dobj = obj;
    m_GetMetric = getMetric;
    m_SetMetric = setMetric;
    m_SetFont = setFont;
    m_GetFont = getFont;
    m_GetColour = getColour;
    m_SetColour = setColour;
    m_GetColor = getColor;
    m_SetColor = setColor;
    m_DrawSash = drawSash;
    m_DrawBackground = drawBackground;
    m_DrawCaption = drawCaption;
    m_DrawGripper = drawGripper;
    m_DrawBorder = drawBorder;
    m_DrawPaneButton = drawPaneButton;
  }

private:
  Virtual_GetMetric m_GetMetric;
  Virtual_SetMetric m_SetMetric;
  Virtual_SetFont m_SetFont;
  Virtual_GetFont m_GetFont;
  Virtual_GetColour m_GetColour;
  Virtual_SetColour m_SetColour;
  Virtual_GetColor m_GetColor;
  Virtual_SetColor m_SetColor;
  Virtual_DrawSash m_DrawSash;
  Virtual_DrawBackground m_DrawBackground;
  Virtual_DrawCaption m_DrawCaption;
  Virtual_DrawGripper m_DrawGripper;
  Virtual_DrawBorder m_DrawBorder;
  Virtual_DrawPaneButton m_DrawPaneButton;
  wxc_object m_dobj;
};

extern "C" WXEXPORT
wxDockArt* wxDockArt_ctor()
{
  return new _DockArt();
}

extern "C" WXEXPORT
void wxDockArt_dtor(wxDockArt* self)
{
  if (self != NULL)
    delete self;
}

extern "C" WXEXPORT
void wxDockArt_RegisterVirtual(_DockArt* self, wxc_object obj,
                      Virtual_GetMetric getMetric,
                      Virtual_SetMetric setMetric,
                      Virtual_SetFont setFont,
                      Virtual_GetFont getFont,
                      Virtual_GetColour getColour,
                      Virtual_SetColour setColour,
                      Virtual_GetColor getColor,
                      Virtual_SetColor setColor,
                      Virtual_DrawSash drawSash,
                      Virtual_DrawBackground drawBackground,
                      Virtual_DrawCaption drawCaption,
                      Virtual_DrawGripper drawGripper,
                      Virtual_DrawBorder drawBorder,
                      Virtual_DrawPaneButton drawPaneButton)
{
  self->RegisterVirtual(obj,
                      getMetric,
                      setMetric,
                      setFont,
                      getFont,
                      getColour,
                      setColour,
                      getColor,
                      setColor,
                      drawSash,
                      drawBackground,
                      drawCaption,
                      drawGripper,
                      drawBorder,
                      drawPaneButton);
}

//-----------------------------------------------------------------------------

class _DefaultDockArt : public wxDefaultDockArt
{
public:
  _DefaultDockArt() : wxDefaultDockArt()
  {}
};

extern "C" WXEXPORT
wxDefaultDockArt* wxDefaultDockArt_ctor()
{
  return new _DefaultDockArt();
}

extern "C" WXEXPORT
void wxDefaultDockArt_dtor(wxDefaultDockArt* self)
{
  if (self != NULL)
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxDockArt_GetMetric(wxDockArt* self, int id)
{
  return self->GetMetric(id);
}

extern "C" WXEXPORT
void wxDockArt_SetMetric(wxDockArt* self, int id, int new_val)
{
  self->SetMetric(id, new_val);
}

extern "C" WXEXPORT
void wxDockArt_SetFont(wxDockArt* self, int id, const wxFont* font)
{
  self->SetFont(id, *font);
}

extern "C" WXEXPORT
wxFont* wxDockArt_GetFont(wxDockArt* self, int id)
{
  return new wxFont(self->GetFont(id));
}

extern "C" WXEXPORT
wxColour* wxDockArt_GetColour(wxDockArt* self, int id)
{
  return new wxColour(self->GetColour(id));
}

extern "C" WXEXPORT
void wxDockArt_SetColour(wxDockArt* self, int id, const wxColor* colour)
{
  self->SetColour(id, *colour);
}

extern "C" WXEXPORT
wxColour* wxDockArt_GetColor(wxDockArt* self, int id)
{
  return new wxColour(self->GetColor(id));
}

extern "C" WXEXPORT
void wxDockArt_SetColor(wxDockArt* self, int id, const wxColor* color)
{
  self->SetColor(id, *color);
}

extern "C" WXEXPORT
void wxDockArt_DrawSash(wxDockArt* self, wxDC* dc,
                      int orientation,
                      const wxRect* rect)
{
  self->DrawSash(*dc, orientation, *rect);
}

extern "C" WXEXPORT
void wxDockArt_DrawBackground(wxDockArt* self, wxDC* dc,
                      int orientation,
                      const wxRect* rect)
{
  self->DrawBackground(*dc, orientation, *rect);
}

extern "C" WXEXPORT
void wxDockArt_DrawCaption(wxDockArt* self, wxDC* dc,
                      const wxc_string text,
                      const wxRect* rect,
                      wxPaneInfo* pane)
{
  self->DrawCaption(*dc, wxstr(text), *rect, *pane);
}

extern "C" WXEXPORT
void wxDockArt_DrawGripper(wxDockArt* self, wxDC* dc,
                      const wxRect* rect,
                      wxPaneInfo* pane)
{
  self->DrawGripper(*dc, *rect, *pane);
}

extern "C" WXEXPORT
void wxDockArt_DrawBorder(wxDockArt* self, wxDC* dc,
                      const wxRect* rect,
                      wxPaneInfo* pane)
{
  self->DrawBorder(*dc, *rect, *pane);
}

extern "C" WXEXPORT
void wxDockArt_DrawPaneButton(wxDockArt* self, wxDC* dc,
                      int button,
                      int button_state,
                      const wxRect* rect,
                      wxPaneInfo* pane)
{
  self->DrawPaneButton(*dc, button, button_state, *rect, *pane);
}

//-----------------------------------------------------------------------------

#else
#ifdef __GNUC__
#warning "wxUSE_AUI is not set"
#endif
#endif
