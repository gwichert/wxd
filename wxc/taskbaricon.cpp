//-----------------------------------------------------------------------------
// wxD - taskbaricon.cpp
// (C) 2007
// 
// wxTaskBarIcon, represents a taskbar icon.
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/taskbar.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

// Event types
extern "C" WXEXPORT int wxTaskBarIcon_EVT_TASKBAR_MOVE()         { return wxEVT_TASKBAR_MOVE; }
extern "C" WXEXPORT int wxTaskBarIcon_EVT_TASKBAR_LEFT_DOWN()    { return wxEVT_TASKBAR_LEFT_DOWN; }
extern "C" WXEXPORT int wxTaskBarIcon_EVT_TASKBAR_LEFT_UP()      { return wxEVT_TASKBAR_LEFT_UP; }
extern "C" WXEXPORT int wxTaskBarIcon_EVT_TASKBAR_RIGHT_DOWN()   { return wxEVT_TASKBAR_RIGHT_DOWN; }
extern "C" WXEXPORT int wxTaskBarIcon_EVT_TASKBAR_RIGHT_UP()     { return wxEVT_TASKBAR_RIGHT_UP; }
extern "C" WXEXPORT int wxTaskBarIcon_EVT_TASKBAR_LEFT_DCLICK()  { return wxEVT_TASKBAR_LEFT_DCLICK; }
extern "C" WXEXPORT int wxTaskBarIcon_EVT_TASKBAR_RIGHT_DCLICK() { return wxEVT_TASKBAR_RIGHT_DCLICK; }

//-----------------------------------------------------------------------------

typedef wxMenu* (CALLBACK* Virtual_CreatePopupMenu) (wxc_object);

//-----------------------------------------------------------------------------

class _TaskBarIcon : public wxTaskBarIcon
{
protected:
    wxMenu *CreatePopupMenu()
        { return m_popmenu(m_dobj); }
        
public:
	_TaskBarIcon():wxTaskBarIcon(){}
#ifdef __WXMAC_OSX__
	_TaskBarIcon(int iconType):wxTaskBarIcon((wxTaskBarIconType)iconType){}
#endif
	
    void RegisterVirtual(wxc_object obj, Virtual_CreatePopupMenu popmenu)
    {
		m_dobj = obj;
        m_popmenu = popmenu;
    }
	
	wxMenu* BaseCreatePopupMenu() //Calls the implementation in wxTimerBase
		{ return wxTaskBarIcon::CreatePopupMenu(); }

private:
    Virtual_CreatePopupMenu m_popmenu;
    wxc_object m_dobj;

public:
    DECLARE_OBJECTDELETED(_TaskBarIcon)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxTaskBarIcon* wxTaskBarIcon_ctor()
{
	return new _TaskBarIcon();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTaskBarIcon* wxTaskBarIcon_ctor2(int iconType)
{
#ifdef __WXMAC_OSX__
	return new _TaskBarIcon(iconType);
#else
	return wxTaskBarIcon_ctor();
#endif
}

//-----------------------------------------------------------------------------
extern "C" WXEXPORT
void wxTaskBarIcon_RegisterVirtual(_TaskBarIcon* self, wxc_object obj, 
	Virtual_CreatePopupMenu popmenu)
{
    self->RegisterVirtual(obj, popmenu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxTaskBarIcon_dtor(wxTaskBarIcon* self)
{
	if (self != NULL)
		delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxMenu* wxTaskBarIcon_BaseCreatePopupMenu(_TaskBarIcon* self)
{
	return self->BaseCreatePopupMenu();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTaskBarIcon_IsIconInstalled(_TaskBarIcon* self)
{
	return self->IsIconInstalled();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTaskBarIcon_IsOk(_TaskBarIcon* self)
{
	return self->IsOk();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTaskBarIcon_PopupMenu(_TaskBarIcon* self, wxMenu* menu)
{
	return self->PopupMenu(menu);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTaskBarIcon_RemoveIcon(_TaskBarIcon* self)
{
	return self->RemoveIcon();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxTaskBarIcon_SetIcon(_TaskBarIcon* self, const wxIcon* icon, wxc_string tooltip)
{
	return self->SetIcon(*icon, wxstr(tooltip));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxTaskBarIconEvent* wxTaskBarIconEvent_ctor(wxEventType commandType, wxTaskBarIcon *tbIcon)
{
    return new wxTaskBarIconEvent(commandType, tbIcon);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxEvent* wxTaskBarIconEvent_Clone(wxTaskBarIconEvent* self)
{
  return self->Clone();
}
