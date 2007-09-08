/////////////////////////////////////////////////////////////////////////////
// Name:        tbtest.cpp
// Purpose:     wxTaskBarIcon demo
// Author:      Julian Smart
// Modified by: afb, ported to wxD
// Created:     01/02/97
// RCS-ID:      $Id$
// Copyright:   (c)
// Licence:     wxWindows licence
/////////////////////////////////////////////////////////////////////////////

import wx.wx;

// Declare two frames
MyDialog   dialog = null;

void main()
{
	MyApp app = new MyApp();
	app.Run();
}

// Define a new application
class MyApp: wxApp
{
public:

bool OnInit()
{
    // Create the main frame window
    dialog = new MyDialog(null, wxID_ANY, "wxTaskBarIcon Test Dialog", Dialog.wxDefaultPosition, wxSize(365, 290));

    dialog.Show(true);

    return true;
}

}

class MyDialog: wxDialog
{
public:

this(wxWindow parent, int id, string title,
    wxPoint pos, wxSize size, int windowStyle = wxDEFAULT_DIALOG_STYLE)
{
    super(parent, id, title, pos, size, windowStyle);

    Init();

    EVT_BUTTON(MenuIDs.wxID_OK, &OnOK);
    EVT_BUTTON(MenuIDs.wxID_EXIT, &OnExit);
    EVT_CLOSE(&OnCloseWindow);
}

~this()
{
    delete m_taskBarIcon;
}

void OnOK(Object sender, Event event)
{
    Show(false);
}

void OnExit(Object sender, Event event)
{
    Close(true);
}

void OnCloseWindow(Object sender, Event event)
{
    Destroy();
}

void Init()
{
  cast(void)new wxStaticText(this, wxID_ANY, "Press 'Hide me' to hide me, Exit to quit.",
                         wxPoint(10, 20));

  cast(void)new wxStaticText(this, wxID_ANY, "Double-click on the taskbar icon to show me again.",
                         wxPoint(10, 40));

  cast(void)new wxButton(this, MenuIDs.wxID_EXIT, "Exit", wxPoint(185, 230), wxSize(80, 25));
  (new wxButton(this, wxID_OK, "Hide me", wxPoint(100, 230), wxSize(80, 25))).SetDefault();
  Centre(Orientation.wxBOTH);
   
  m_taskBarIcon = new MyTaskBarIcon();
  if (!m_taskBarIcon.SetIcon(new Icon("../Samples/TaskBar/mondrian.png"), "wxTaskBarIcon Sample"))
        MessageBox("Could not set icon.");
}

protected:
    MyTaskBarIcon   m_taskBarIcon;

}

enum {
    PU_RESTORE = 10001,
    PU_NEW_ICON,
    PU_OLD_ICON,
    PU_EXIT,
    PU_CHECKMARK,
    PU_SUB1,
    PU_SUB2,
    PU_SUBMAIN
}


class MyTaskBarIcon : wxTaskBarIcon
{
public:
    this(wxTaskBarIconType iconType = wxTaskBarIconType.DEFAULT_TYPE)
    {
    super(iconType);

    EVT_MENU(PU_RESTORE, &OnMenuRestore);
    EVT_MENU(PU_EXIT,    &OnMenuExit);
    EVT_MENU(PU_NEW_ICON,&OnMenuSetNewIcon);
    EVT_MENU(PU_OLD_ICON,&OnMenuSetOldIcon);
    EVT_MENU(PU_CHECKMARK,&OnMenuCheckmark);
    EVT_UPDATE_UI(PU_CHECKMARK,&OnMenuUICheckmark);
    EVT_TASKBAR_LEFT_DCLICK  (&OnLeftButtonDClick);
    EVT_MENU(PU_SUB1, &OnMenuSub);
    EVT_MENU(PU_SUB2, &OnMenuSub);
    }


void OnMenuRestore(Object sender, Event event)
{
    dialog.Show(true);
}

void OnMenuExit(Object sender, Event event)
{
    dialog.Close(true);
}

static bool check = true;

void OnMenuCheckmark(Object sender, Event event)
{
       check =!check;
}

void OnMenuUICheckmark(Object sender, Event event)
{
       (cast(UpdateUIEvent)event).Check( check );
}

void OnMenuSetNewIcon(Object sender, Event event)
{
    wxIcon icon = new Icon("../Samples/TaskBar/smile.png");

    if (!SetIcon(icon, "wxTaskBarIcon Sample - a different icon"))
        MessageBox("Could not set new icon.");
}

void OnMenuSetOldIcon(Object sender, Event event)
{
    if (IsIconInstalled())
    {
        RemoveIcon();
    }
    else
    {
        MessageBox("wxTaskBarIcon Sample - icon already is the old version");
    }
}

void OnMenuSub(Object sender, Event event)
{
    MessageBox("You clicked on a submenu!");
}

// Overridables
wxMenu CreatePopupMenu()
{
    // Try creating menus different ways
    // TODO: Probably try calling SetBitmap with some XPMs here
    wxMenu menu = new wxMenu;
    menu.Append(PU_RESTORE, "&Restore TBTest");
    menu.AppendSeparator();
    menu.Append(PU_OLD_ICON, "&Restore Old Icon");    
    menu.Append(PU_NEW_ICON, "&Set New Icon");
    menu.AppendSeparator();
    menu.Append(PU_CHECKMARK, "Checkmark","", ItemKind.wxITEM_CHECK);
    menu.AppendSeparator();
    wxMenu submenu = new wxMenu;
    submenu.Append(PU_SUB1, "One submenu");
    submenu.AppendSeparator();
    submenu.Append(PU_SUB2, "Another submenu");
    menu.Append(PU_SUBMAIN, "Submenu", submenu);
version(__WXMAC__) {} else { /*Mac has built-in quit menu*/
    menu.AppendSeparator();
    menu.Append(PU_EXIT,    "E&xit");
}
    return menu;
}

void OnLeftButtonDClick(Object sender, Event event)
{
    dialog.Show(true);
}

}

