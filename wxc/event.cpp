//-----------------------------------------------------------------------------
// wxD - event.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - event.cxx
//
// The wxEvent proxy interface.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/tglbtn.h>
#include <wx/calctrl.h>
#include <wx/fdrepdlg.h>
#include <wx/treectrl.h>
#include <wx/listctrl.h>
#include <wx/notebook.h>
#include <wx/listbook.h>
#include <wx/grid.h>
#include <wx/sashwin.h>
#include <wx/laywin.h>
#ifndef __WXGTK__
#include <wx/tabctrl.h>
#endif
#include "local_events.h"

//-----------------------------------------------------------------------------
// Event type for virtual destructors

DEFINE_EVENT_TYPE(wxEVT_OBJECTDELETED)    

extern "C" WXEXPORT int wxEvent_EVT_NULL()        { return wxEVT_NULL; }

//-----------------------------------------------------------------------------

extern "C" WXEXPORT int wxEvent_EVT_COMMAND_BUTTON_CLICKED()        { return wxEVT_COMMAND_BUTTON_CLICKED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_CHECKBOX_CLICKED()      { return wxEVT_COMMAND_CHECKBOX_CLICKED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_CHOICE_SELECTED()       { return wxEVT_COMMAND_CHOICE_SELECTED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_LISTBOX_SELECTED()      { return wxEVT_COMMAND_LISTBOX_SELECTED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_LISTBOX_DOUBLECLICKED() { return wxEVT_COMMAND_LISTBOX_DOUBLECLICKED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_CHECKLISTBOX_TOGGLED()  { return wxEVT_COMMAND_CHECKLISTBOX_TOGGLED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TEXT_UPDATED()          { return wxEVT_COMMAND_TEXT_UPDATED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TEXT_ENTER()            { return wxEVT_COMMAND_TEXT_ENTER; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TEXT_URL()              { return wxEVT_COMMAND_TEXT_URL; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TEXT_MAXLEN()           { return wxEVT_COMMAND_TEXT_MAXLEN; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_MENU_SELECTED()         { return wxEVT_COMMAND_MENU_SELECTED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_SLIDER_UPDATED()        { return wxEVT_COMMAND_SLIDER_UPDATED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_RADIOBOX_SELECTED()     { return wxEVT_COMMAND_RADIOBOX_SELECTED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_RADIOBUTTON_SELECTED()  { return wxEVT_COMMAND_RADIOBUTTON_SELECTED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_SCROLLBAR_UPDATED()     { return wxEVT_COMMAND_SCROLLBAR_UPDATED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_VLBOX_SELECTED()        { return wxEVT_COMMAND_VLBOX_SELECTED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_COMBOBOX_SELECTED()     { return wxEVT_COMMAND_COMBOBOX_SELECTED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TOOL_RCLICKED()         { return wxEVT_COMMAND_TOOL_RCLICKED; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TOOL_ENTER()            { return wxEVT_COMMAND_TOOL_ENTER; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_SPINCTRL_UPDATED()      { return wxEVT_COMMAND_SPINCTRL_UPDATED; }
extern "C" WXEXPORT int wxEvent_EVT_SOCKET()                        { return wxEVT_SOCKET; }
extern "C" WXEXPORT int wxEvent_EVT_TIMER()                         { return wxEVT_TIMER ; }
extern "C" WXEXPORT int wxEvent_EVT_LEFT_DOWN()                     { return wxEVT_LEFT_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_LEFT_UP()                       { return wxEVT_LEFT_UP; }
extern "C" WXEXPORT int wxEvent_EVT_MIDDLE_DOWN()                   { return wxEVT_MIDDLE_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_MIDDLE_UP()                     { return wxEVT_MIDDLE_UP; }
extern "C" WXEXPORT int wxEvent_EVT_RIGHT_DOWN()                    { return wxEVT_RIGHT_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_RIGHT_UP()                      { return wxEVT_RIGHT_UP; }
extern "C" WXEXPORT int wxEvent_EVT_MOTION()                        { return wxEVT_MOTION; }
extern "C" WXEXPORT int wxEvent_EVT_ENTER_WINDOW()                  { return wxEVT_ENTER_WINDOW; }
extern "C" WXEXPORT int wxEvent_EVT_LEAVE_WINDOW()                  { return wxEVT_LEAVE_WINDOW; }
extern "C" WXEXPORT int wxEvent_EVT_LEFT_DCLICK()                   { return wxEVT_LEFT_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_MIDDLE_DCLICK()                 { return wxEVT_MIDDLE_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_RIGHT_DCLICK()                  { return wxEVT_RIGHT_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_SET_FOCUS()                     { return wxEVT_SET_FOCUS; }
extern "C" WXEXPORT int wxEvent_EVT_KILL_FOCUS()                    { return wxEVT_KILL_FOCUS; }
extern "C" WXEXPORT int wxEvent_EVT_CHILD_FOCUS()                   { return wxEVT_CHILD_FOCUS; }
extern "C" WXEXPORT int wxEvent_EVT_MOUSEWHEEL()                    { return wxEVT_MOUSEWHEEL; }
extern "C" WXEXPORT int wxEvent_EVT_NC_LEFT_DOWN()                  { return wxEVT_NC_LEFT_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_NC_LEFT_UP()                    { return wxEVT_NC_LEFT_UP; }
extern "C" WXEXPORT int wxEvent_EVT_NC_MIDDLE_DOWN()                { return wxEVT_NC_MIDDLE_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_NC_MIDDLE_UP()                  { return wxEVT_NC_MIDDLE_UP; }
extern "C" WXEXPORT int wxEvent_EVT_NC_RIGHT_DOWN()                 { return wxEVT_NC_RIGHT_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_NC_RIGHT_UP()                   { return wxEVT_NC_RIGHT_UP; }
extern "C" WXEXPORT int wxEvent_EVT_NC_MOTION()                     { return wxEVT_NC_MOTION; }
extern "C" WXEXPORT int wxEvent_EVT_NC_ENTER_WINDOW()               { return wxEVT_NC_ENTER_WINDOW; }
extern "C" WXEXPORT int wxEvent_EVT_NC_LEAVE_WINDOW()               { return wxEVT_NC_LEAVE_WINDOW; }
extern "C" WXEXPORT int wxEvent_EVT_NC_LEFT_DCLICK()                { return wxEVT_NC_LEFT_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_NC_MIDDLE_DCLICK()              { return wxEVT_NC_MIDDLE_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_NC_RIGHT_DCLICK()               { return wxEVT_NC_RIGHT_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_CHAR()                          { return wxEVT_CHAR; }
extern "C" WXEXPORT int wxEvent_EVT_CHAR_HOOK()                     { return wxEVT_CHAR_HOOK; }
extern "C" WXEXPORT int wxEvent_EVT_NAVIGATION_KEY()                { return wxEVT_NAVIGATION_KEY; }
extern "C" WXEXPORT int wxEvent_EVT_KEY_DOWN()                      { return wxEVT_KEY_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_KEY_UP()                        { return wxEVT_KEY_UP; }
extern "C" WXEXPORT int wxEvent_EVT_SET_CURSOR()                    { return wxEVT_SET_CURSOR; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_TOP()                    { return wxEVT_SCROLL_TOP; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_BOTTOM()                 { return wxEVT_SCROLL_BOTTOM; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_LINEUP()                 { return wxEVT_SCROLL_LINEUP; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_LINEDOWN()               { return wxEVT_SCROLL_LINEDOWN; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_PAGEUP()                 { return wxEVT_SCROLL_PAGEUP; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_PAGEDOWN()               { return wxEVT_SCROLL_PAGEDOWN; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_THUMBTRACK()             { return wxEVT_SCROLL_THUMBTRACK; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_THUMBRELEASE()           { return wxEVT_SCROLL_THUMBRELEASE; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLL_ENDSCROLL()              { return wxEVT_SCROLL_ENDSCROLL; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_TOP()                 { return wxEVT_SCROLLWIN_TOP; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_BOTTOM()              { return wxEVT_SCROLLWIN_BOTTOM; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_LINEUP()              { return wxEVT_SCROLLWIN_LINEUP; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_LINEDOWN()            { return wxEVT_SCROLLWIN_LINEDOWN; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_PAGEUP()              { return wxEVT_SCROLLWIN_PAGEUP; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_PAGEDOWN()            { return wxEVT_SCROLLWIN_PAGEDOWN; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_THUMBTRACK()          { return wxEVT_SCROLLWIN_THUMBTRACK; }
extern "C" WXEXPORT int wxEvent_EVT_SCROLLWIN_THUMBRELEASE()        { return wxEVT_SCROLLWIN_THUMBRELEASE; }
extern "C" WXEXPORT int wxEvent_EVT_SIZE()                          { return wxEVT_SIZE; }
extern "C" WXEXPORT int wxEvent_EVT_MOVE()                          { return wxEVT_MOVE; }
extern "C" WXEXPORT int wxEvent_EVT_CLOSE_WINDOW()                  { return wxEVT_CLOSE_WINDOW; }
extern "C" WXEXPORT int wxEvent_EVT_END_SESSION()                   { return wxEVT_END_SESSION; }
extern "C" WXEXPORT int wxEvent_EVT_QUERY_END_SESSION()             { return wxEVT_QUERY_END_SESSION; }
extern "C" WXEXPORT int wxEvent_EVT_ACTIVATE_APP()                  { return wxEVT_ACTIVATE_APP; }
extern "C" WXEXPORT int wxEvent_EVT_POWER()                         { return wxEVT_POWER; }
extern "C" WXEXPORT int wxEvent_EVT_ACTIVATE()                      { return wxEVT_ACTIVATE; }
extern "C" WXEXPORT int wxEvent_EVT_CREATE()                        { return wxEVT_CREATE; }
extern "C" WXEXPORT int wxEvent_EVT_DESTROY()                       { return wxEVT_DESTROY; }
extern "C" WXEXPORT int wxEvent_EVT_SHOW()                          { return wxEVT_SHOW; }
extern "C" WXEXPORT int wxEvent_EVT_ICONIZE()                       { return wxEVT_ICONIZE; }
extern "C" WXEXPORT int wxEvent_EVT_MAXIMIZE()                      { return wxEVT_MAXIMIZE; }
extern "C" WXEXPORT int wxEvent_EVT_MOUSE_CAPTURE_CHANGED()         { return wxEVT_MOUSE_CAPTURE_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_PAINT()                         { return wxEVT_PAINT; }
extern "C" WXEXPORT int wxEvent_EVT_ERASE_BACKGROUND()              { return wxEVT_ERASE_BACKGROUND; }
extern "C" WXEXPORT int wxEvent_EVT_NC_PAINT()                      { return wxEVT_NC_PAINT; }
extern "C" WXEXPORT int wxEvent_EVT_PAINT_ICON()                    { return wxEVT_PAINT_ICON; }
extern "C" WXEXPORT int wxEvent_EVT_MENU_OPEN()                     { return wxEVT_MENU_OPEN; }
extern "C" WXEXPORT int wxEvent_EVT_MENU_CLOSE()                    { return wxEVT_MENU_CLOSE; }
extern "C" WXEXPORT int wxEvent_EVT_MENU_HIGHLIGHT()                { return wxEVT_MENU_HIGHLIGHT; }
extern "C" WXEXPORT int wxEvent_EVT_CONTEXT_MENU()                  { return wxEVT_CONTEXT_MENU; }
extern "C" WXEXPORT int wxEvent_EVT_SYS_COLOUR_CHANGED()            { return wxEVT_SYS_COLOUR_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_DISPLAY_CHANGED()               { return wxEVT_DISPLAY_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_SETTING_CHANGED()               { return wxEVT_SETTING_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_QUERY_NEW_PALETTE()             { return wxEVT_QUERY_NEW_PALETTE; }
extern "C" WXEXPORT int wxEvent_EVT_PALETTE_CHANGED()               { return wxEVT_PALETTE_CHANGED; }
extern "C" WXEXPORT int wxEvent_EVT_JOY_BUTTON_DOWN()               { return wxEVT_JOY_BUTTON_DOWN; }
extern "C" WXEXPORT int wxEvent_EVT_JOY_BUTTON_UP()                 { return wxEVT_JOY_BUTTON_UP; }
extern "C" WXEXPORT int wxEvent_EVT_JOY_MOVE()                      { return wxEVT_JOY_MOVE; }
extern "C" WXEXPORT int wxEvent_EVT_JOY_ZMOVE()                     { return wxEVT_JOY_ZMOVE; }
extern "C" WXEXPORT int wxEvent_EVT_DROP_FILES()                    { return wxEVT_DROP_FILES; }
extern "C" WXEXPORT int wxEvent_EVT_DRAW_ITEM()                     { return wxEVT_DRAW_ITEM; }
extern "C" WXEXPORT int wxEvent_EVT_MEASURE_ITEM()                  { return wxEVT_MEASURE_ITEM; }
extern "C" WXEXPORT int wxEvent_EVT_COMPARE_ITEM()                  { return wxEVT_COMPARE_ITEM; }
extern "C" WXEXPORT int wxEvent_EVT_INIT_DIALOG()                   { return wxEVT_INIT_DIALOG; }
extern "C" WXEXPORT int wxEvent_EVT_IDLE()                          { return wxEVT_IDLE; }
extern "C" WXEXPORT int wxEvent_EVT_UPDATE_UI()                     { return wxEVT_UPDATE_UI; }
extern "C" WXEXPORT int wxEvent_EVT_SIZING()                        { return wxEVT_SIZING; }
extern "C" WXEXPORT int wxEvent_EVT_MOVING()                        { return wxEVT_MOVING; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_LEFT_CLICK()            { return wxEVT_COMMAND_LEFT_CLICK; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_LEFT_DCLICK()           { return wxEVT_COMMAND_LEFT_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_RIGHT_CLICK()           { return wxEVT_COMMAND_RIGHT_CLICK; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_RIGHT_DCLICK()          { return wxEVT_COMMAND_RIGHT_DCLICK; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_SET_FOCUS()             { return wxEVT_COMMAND_SET_FOCUS; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_KILL_FOCUS()            { return wxEVT_COMMAND_KILL_FOCUS; }
extern "C" WXEXPORT int wxEvent_EVT_COMMAND_ENTER()                 { return wxEVT_COMMAND_ENTER; }
extern "C" WXEXPORT int wxEvent_EVT_HELP()                          { return wxEVT_HELP; }
extern "C" WXEXPORT int wxEvent_EVT_DETAILED_HELP()                 { return wxEVT_DETAILED_HELP; }
//extern "C" WXEXPORT int wxEvent_EVT_COMMAND_TOGGLEBUTTON_CLICKED()  { return wxEVT_COMMAND_TOGGLEBUTTON_CLICKED; }
extern "C" WXEXPORT int wxEvent_EVT_OBJECTDELETED()                 { return wxEVT_OBJECTDELETED; }


//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxEvent_GetEventType(wxEvent* self)
{
    return self->GetEventType();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxEvent_GetId(wxEvent* self)
{
    return self->GetId();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxEvent_GetSkipped(wxEvent* self)
{
    return self->GetSkipped();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxEvent_GetTimestamp(wxEvent* self)
{
    return self->GetTimestamp();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxEvent_Skip(wxEvent* self, dbit skip)
{
    self->Skip(skip);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxEvent_GetEventObject(wxEvent* self)
{
    return self->GetEventObject();
}
