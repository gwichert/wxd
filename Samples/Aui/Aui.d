
///////////////////////////////////////////////////////////////////////////////
// Name:    wxauitest.cpp
// Purpose:   wxaui: wx advanced user interface - sample/test program
// Author:    Benjamin I. Williams
// Modified by: David Gileadi: converted to D code
// Created:   2005-10-03
// RCS-ID:
// Copyright:   (C) Copyright 2005, Kirix Corporation, All Rights Reserved.
// Licence:   wxWindows Library Licence, Version 3.1
///////////////////////////////////////////////////////////////////////////////

import wx.wx;
import wx.Defs;
import wx.Grid;
import wx.TreeCtrl;
import wx.SpinCtrl;
import wx.ArtProvider;
import wx.Clipboard;
import wx.Image;
import wx.ColourDialog;
import wx.HTML;
import wx.Window;
import wx.aui.aui;
import std.string;


// -- application --

class MyApp : App
{
  public bool OnInit()
  {
    Frame frame = new MyFrame(null,
                   wxID_ANY,
                   "wxAUI 0.9.2 Test Application",
                   Window.wxDefaultPosition,
                   Size(800, 600));
    //SetTopWindow(frame);
    frame.Show();

    return true;
  }

  static void Main()
  {
    MyApp app = new MyApp();
    app.Run();
  }
}

int main()
{
  MyApp.Main();
  return 0;
}


// -- frame --

class MyFrame : public Frame
{
  enum
  {
    ID_CreateTree = MenuIDs.wxID_HIGHEST+1,
    ID_CreateGrid,
    ID_CreateText,
    ID_CreateHTML,
    ID_CreateSizeReport,
    ID_GridContent,
    ID_TextContent,
    ID_TreeContent,
    ID_HTMLContent,
    ID_SizeReportContent,
    ID_CreatePerspective,
    ID_CopyPerspectiveCode,
    ID_AllowFloating,
    ID_AllowActivePane,
    ID_TransparentHint,
    ID_TransparentHintFade,
    ID_TransparentDrag,
    ID_NoGradient,
    ID_VerticalGradient,
    ID_HorizontalGradient,
    ID_Settings,
    ID_About,
    ID_FirstPerspective = ID_CreatePerspective+1000
  };

public:
  this(wxWindow parent,
      int id,
      char[] title,
      Point pos = Window.wxDefaultPosition,
      Size size = wxDefaultSize,
      long style = wxDEFAULT_FRAME_STYLE | wxSUNKEN_BORDER)
  {
    super(parent, id, title, pos, size, style);

    m_mgr = new FrameManager();

    // tell wxFrameManager to manage this frame
    m_mgr.SetFrame(this);

    // set frame icon
    icon = new Icon("../Samples/Aui/mondrian.png");

    // create menu
    MenuBar mb = new MenuBar;

    Menu file_menu = new Menu;
    file_menu.Append(MenuIDs.wxID_EXIT, "Exit");

    Menu view_menu = new Menu;
    view_menu.Append(ID_CreateText, "Create Text Control");
    view_menu.Append(ID_CreateHTML, "Create HTML Control");
    view_menu.Append(ID_CreateTree, "Create Tree");
    view_menu.Append(ID_CreateGrid, "Create Grid");
    view_menu.Append(ID_CreateSizeReport, "Create Size Reporter");
    view_menu.AppendSeparator();
    view_menu.Append(ID_GridContent, "Use a Grid for the Content Pane");
    view_menu.Append(ID_TextContent, "Use a Text Control for the Content Pane");
    view_menu.Append(ID_HTMLContent, "Use an HTML Control for the Content Pane");
    view_menu.Append(ID_TreeContent, "Use a Tree Control for the Content Pane");
    view_menu.Append(ID_SizeReportContent, "Use a Size Reporter for the Content Pane");

    Menu options_menu = new Menu;
    options_menu.AppendCheckItem(ID_AllowFloating, "Allow Floating");
    options_menu.AppendCheckItem(ID_TransparentHint, "Transparent Hint");
    options_menu.AppendCheckItem(ID_TransparentHintFade, "Transparent Hint Fade-in");
    options_menu.AppendCheckItem(ID_TransparentDrag, "Transparent Drag");
    options_menu.AppendCheckItem(ID_AllowActivePane, "Allow Active Pane");
    options_menu.AppendSeparator();
    options_menu.AppendRadioItem(ID_NoGradient, "No Caption Gradient");
    options_menu.AppendRadioItem(ID_VerticalGradient, "Vertical Caption Gradient");
    options_menu.AppendRadioItem(ID_HorizontalGradient, "Horizontal Caption Gradient");
    options_menu.AppendSeparator();
    options_menu.Append(ID_Settings, "Settings Pane");

    m_perspectives_menu = new Menu;
    m_perspectives_menu.Append(ID_CreatePerspective, "Create Perspective");
    m_perspectives_menu.Append(ID_CopyPerspectiveCode, "Copy Perspective Data To Clipboard");
    m_perspectives_menu.AppendSeparator();
    m_perspectives_menu.Append(ID_FirstPerspective+0, "Default Startup");
    m_perspectives_menu.Append(ID_FirstPerspective+1, "All Panes");

    Menu help_menu = new Menu;
    help_menu.Append(ID_About, "About...");

    mb.Append(file_menu, "File");
    mb.Append(view_menu, "View");
    mb.Append(m_perspectives_menu, "Perspectives");
    mb.Append(options_menu, "Options");
    mb.Append(help_menu, "Help");

    menuBar = mb;

    CreateStatusBar();
    statusBar.StatusText = "Ready";


    // min size for the frame itself isn't completely done.
    // see the end up wxFrameManager::Update() for the test
    // code. For now, just hard code a frame minimum size
    SetSizeHints(400,300);

    // create some toolbars
    ToolBar tb1 = new ToolBar(this, -1, Window.wxDefaultPosition, wxDefaultSize,
                     ToolBar.wxTB_FLAT | ToolBar.wxTB_NODIVIDER);
    tb1.ToolBitmapSize = Size(48,48);
    tb1.AddTool(101, "Test", ArtProvider.GetBitmap(ArtID.wxART_ERROR));
    tb1.AddSeparator();
    tb1.AddTool(102, "Test", ArtProvider.GetBitmap(ArtID.wxART_QUESTION));
    tb1.AddTool(103, "Test", ArtProvider.GetBitmap(ArtID.wxART_INFORMATION));
    tb1.AddTool(103, "Test", ArtProvider.GetBitmap(ArtID.wxART_WARNING));
    tb1.AddTool(103, "Test", ArtProvider.GetBitmap(ArtID.wxART_MISSING_IMAGE));
    tb1.Realize();



    ToolBar tb2 = new ToolBar(this, -1, Window.wxDefaultPosition, wxDefaultSize,
                     ToolBar.wxTB_FLAT | ToolBar.wxTB_NODIVIDER);
    tb2.ToolBitmapSize = Size(16,16);

    Bitmap tb2_bmp1 = ArtProvider.GetBitmap(ArtID.wxART_QUESTION, ArtClient.wxART_OTHER, Size(16,16));
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddSeparator();
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddSeparator();
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.AddTool(101, "Test", tb2_bmp1);
    tb2.Realize();


    ToolBar tb3 = new ToolBar(this, -1, Window.wxDefaultPosition, wxDefaultSize,
                     ToolBar.wxTB_FLAT | ToolBar.wxTB_NODIVIDER);
    tb3.ToolBitmapSize = Size(16,16);
    Bitmap tb3_bmp1 = ArtProvider.GetBitmap(ArtID.wxART_FOLDER, ArtClient.wxART_OTHER, Size(16,16));
    tb3.AddTool(101, "Test", tb3_bmp1);
    tb3.AddTool(101, "Test", tb3_bmp1);
    tb3.AddTool(101, "Test", tb3_bmp1);
    tb3.AddTool(101, "Test", tb3_bmp1);
    tb3.AddSeparator();
    tb3.AddTool(101, "Test", tb3_bmp1);
    tb3.AddTool(101, "Test", tb3_bmp1);
    tb3.Realize();

    ToolBar tb4 = new ToolBar(this, -1, Window.wxDefaultPosition, wxDefaultSize,
                     ToolBar.wxTB_FLAT | ToolBar.wxTB_NODIVIDER | /*ToolBar.wxTB_HORZ_LAYOUT*/0x0800 | ToolBar.wxTB_TEXT);
    tb4.ToolBitmapSize = Size(16,16);
    Bitmap tb4_bmp1 = ArtProvider.GetBitmap(ArtID.wxART_NORMAL_FILE, ArtClient.wxART_OTHER, Size(16,16));
    tb4.AddTool(101, "Item 1", tb4_bmp1);
    tb4.AddTool(101, "Item 2", tb4_bmp1);
    tb4.AddTool(101, "Item 3", tb4_bmp1);
    tb4.AddTool(101, "Item 4", tb4_bmp1);
    tb4.AddSeparator();
    tb4.AddTool(101, "Item 5", tb4_bmp1);
    tb4.AddTool(101, "Item 6", tb4_bmp1);
    tb4.AddTool(101, "Item 7", tb4_bmp1);
    tb4.AddTool(101, "Item 8", tb4_bmp1);
    tb4.Realize();


    // Set up the event table

    EVT_ERASE_BACKGROUND(&OnEraseBackground);
    EVT_SIZE(&OnSize);
    EVT_MENU(ID_CreateTree, &OnCreateTree);
    EVT_MENU(ID_CreateGrid, &OnCreateGrid);
    EVT_MENU(ID_CreateText, &OnCreateText);
    EVT_MENU(ID_CreateHTML, &OnCreateHTML);
    EVT_MENU(ID_CreateSizeReport, &OnCreateSizeReport);
    EVT_MENU(ID_CreatePerspective, &OnCreatePerspective);
    EVT_MENU(ID_CopyPerspectiveCode, &OnCopyPerspectiveCode);
    EVT_MENU(ID_AllowFloating, &OnManagerFlag);
    EVT_MENU(ID_TransparentHint, &OnManagerFlag);
    EVT_MENU(ID_TransparentHintFade, &OnManagerFlag);
    EVT_MENU(ID_TransparentDrag, &OnManagerFlag);
    EVT_MENU(ID_AllowActivePane, &OnManagerFlag);
    EVT_MENU(ID_NoGradient, &OnGradient);
    EVT_MENU(ID_VerticalGradient, &OnGradient);
    EVT_MENU(ID_HorizontalGradient, &OnGradient);
    EVT_MENU(ID_Settings, &OnSettings);
    EVT_MENU(ID_GridContent, &OnChangeContentPane);
    EVT_MENU(ID_TreeContent, &OnChangeContentPane);
    EVT_MENU(ID_TextContent, &OnChangeContentPane);
    EVT_MENU(ID_SizeReportContent, &OnChangeContentPane);
    EVT_MENU(ID_HTMLContent, &OnChangeContentPane);
    EVT_UPDATE_UI(ID_AllowFloating, &OnUpdateUI);
    EVT_UPDATE_UI(ID_TransparentHint, &OnUpdateUI);
    EVT_UPDATE_UI(ID_TransparentHintFade, &OnUpdateUI);
    EVT_UPDATE_UI(ID_TransparentDrag, &OnUpdateUI);
    EVT_UPDATE_UI(ID_NoGradient, &OnUpdateUI);
    EVT_UPDATE_UI(ID_VerticalGradient, &OnUpdateUI);
    EVT_UPDATE_UI(ID_HorizontalGradient, &OnUpdateUI);
    for (int i = 0; i < 1000; i++)
      EVT_MENU(ID_FirstPerspective + i, &OnRestorePerspective);


    // add a bunch of panes
    PaneInfo info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test1").Caption("Pane Caption").
            Top());

    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test2").Caption("Client Size Reporter").
            Bottom().Position(1));

    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test3").Caption("Client Size Reporter").
            Bottom());

    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test4").Caption("Pane Caption").
            Left());

    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test5").Caption("Pane Caption").
            Right());

    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test6").Caption("Client Size Reporter").
            Right().Row(1));

    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test7").Caption("Client Size Reporter").
            Left().Layer(1));
/*
    info = new PaneInfo();
    m_mgr.AddPane(CreateTreeCtrl(), info.
            Name("test8").Caption("Tree Pane").
            Left().Layer(1).Position(1));
*/
    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test9").Caption("Min Size 200x100").
            BestSize(Size(200,100)).MinSize(Size(200,100)).
            Bottom().Layer(1));

    info = new PaneInfo();
    m_mgr.AddPane(CreateTextCtrl(), info.
            Name("test10").Caption("Text Pane").
            Bottom().Layer(1).Position(1));

    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("test11").Caption("Fixed Pane").
            Bottom().Layer(1).Position(2).Fixed());


    info = new PaneInfo();
    m_mgr.AddPane(new SettingsPanel(this,this), info.
            Name("settings").Caption("Dock Manager Settings").
            Dockable(false).Float().Hide());

    // create some center panes

    info = new PaneInfo();
    m_mgr.AddPane(CreateGrid(), info.Name("grid_content").
            CenterPane().Hide());
/*
    info = new PaneInfo();
    m_mgr.AddPane(CreateTreeCtrl(), info.Name("tree_content").
            CenterPane().Hide());
*/
    info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.Name("sizereport_content").
            CenterPane().Hide());

    info = new PaneInfo();
    m_mgr.AddPane(CreateTextCtrl(), info.Name("text_content").
            CenterPane().Hide());

    info = new PaneInfo();
    m_mgr.AddPane(CreateHTMLCtrl(), info.Name("html_content").
            CenterPane());

    // add the toolbars to the manager

    info = new PaneInfo();
    m_mgr.AddPane(tb1, info.
            Name("tb1").Caption("Big Toolbar").
            ToolbarPane().Top().
            LeftDockable(false).RightDockable(false));

    info = new PaneInfo();
    m_mgr.AddPane(tb2, info.
            Name("tb2").Caption("Toolbar 2").
            ToolbarPane().Top().Row(1).
            LeftDockable(false).RightDockable(false));

    info = new PaneInfo();
    m_mgr.AddPane(tb3, info.
            Name("tb3").Caption("Toolbar 3").
            ToolbarPane().Top().Row(1).Position(1).
            LeftDockable(false).RightDockable(false));

    info = new PaneInfo();
    m_mgr.AddPane(tb4, info.
            Name("tb4").Caption("Sample Bookmark Toolbar").
            ToolbarPane().Top().Row(2).
            LeftDockable(false).RightDockable(false));

    info = new PaneInfo();
    m_mgr.AddPane(new Button(this, -1, "Test Button"),
            info.Name("tb5").
            ToolbarPane().Top().Row(2).Position(1).
            LeftDockable(false).RightDockable(false));



    // make some default perspectives

    char[] perspective_all = m_mgr.SavePerspective();

    int i, count;
    for (i = 0, count = m_mgr.GetPaneCount(); i < count; ++i)
      if (!m_mgr.GetPane(i).IsToolbar())
        m_mgr.GetPane(i).Hide();
    m_mgr.GetPane("tb1").Hide();
    m_mgr.GetPane("tb5").Hide();
    m_mgr.GetPane("test8").Show().Left().Layer(0).Row(0).Position(0);
    m_mgr.GetPane("test10").Show().Bottom().Layer(0).Row(0).Position(0);
    m_mgr.GetPane("html_content").Show();
    char[] perspective_default = m_mgr.SavePerspective();

    m_perspectives ~= perspective_default;
    m_perspectives ~= perspective_all;

    // "commit" all changes made to wxFrameManager
    m_mgr.Update();
  }

  ~this()
  {
    m_mgr.UnInit();
  }

  DockArt GetDockArt()
  {
    return m_mgr.GetArtProvider();
  }

  void DoUpdate()
  {
    m_mgr.Update();
  }

private:
  void OnEraseBackground(Object sender, Event event)
  {
    event.Skip();
  }

  void OnSize(Object sender, Event event)
  {
    event.Skip();
  }

  void OnSettings(Object sender, Event event)
  {
    // show the settings pane, and float it
    PaneInfo floating_pane = m_mgr.GetPane("settings").Float().Show();

    if (floating_pane.floating_pos == Window.wxDefaultPosition)
      floating_pane.FloatingPosition(GetStartPosition());

    m_mgr.Update();
  }


  void OnGradient(Object sender, Event event)
  {
    int gradient = 0;

    switch (event.ID())
    {
      case ID_NoGradient:     gradient = wxPaneDockArtGradients.wxAUI_GRADIENT_NONE; break;
      case ID_VerticalGradient:   gradient = wxPaneDockArtGradients.wxAUI_GRADIENT_VERTICAL; break;
      case ID_HorizontalGradient: gradient = wxPaneDockArtGradients.wxAUI_GRADIENT_HORIZONTAL; break;
    }

    m_mgr.GetArtProvider().SetMetric(wxPaneDockArtSetting.wxAUI_ART_GRADIENT_TYPE, gradient);
    m_mgr.Update();
  }

  void OnManagerFlag(Object sender, Event event)
  {
    uint flag = 0;

version(__WXMSW__)
{}
else
{
    if (event.ID() == ID_TransparentDrag ||
      event.ID() == ID_TransparentHint ||
      event.ID() == ID_TransparentHintFade)
    {
      MessageBox("This option is presently only available on wxMSW");
      return;
    }
}

    switch (event.ID())
    {
      case ID_AllowFloating: flag = wxFrameManagerOption.wxAUI_MGR_ALLOW_FLOATING; break;
      case ID_TransparentDrag: flag = wxFrameManagerOption.wxAUI_MGR_TRANSPARENT_DRAG; break;
      case ID_TransparentHint: flag = wxFrameManagerOption.wxAUI_MGR_TRANSPARENT_HINT; break;
      case ID_TransparentHintFade: flag = wxFrameManagerOption.wxAUI_MGR_TRANSPARENT_HINT_FADE; break;
      case ID_AllowActivePane: flag = wxFrameManagerOption.wxAUI_MGR_ALLOW_ACTIVE_PANE; break;
    }
    m_mgr.SetFlags(m_mgr.GetFlags() ^ flag);
    m_mgr.Update();
  }

  void OnUpdateUI(Object sender, Event event)
  {
    uint flags = m_mgr.GetFlags();

    switch (event.ID())
    {
      case ID_NoGradient:
        (cast(UpdateUIEvent)event).Check(m_mgr.GetArtProvider().GetMetric(wxPaneDockArtSetting.wxAUI_ART_GRADIENT_TYPE) == wxPaneDockArtGradients.wxAUI_GRADIENT_NONE ? true : false);
        break;
      case ID_VerticalGradient:
        (cast(UpdateUIEvent)event).Check(m_mgr.GetArtProvider().GetMetric(wxPaneDockArtSetting.wxAUI_ART_GRADIENT_TYPE) == wxPaneDockArtGradients.wxAUI_GRADIENT_VERTICAL ? true : false);
        break;
      case ID_HorizontalGradient:
        (cast(UpdateUIEvent)event).Check(m_mgr.GetArtProvider().GetMetric(wxPaneDockArtSetting.wxAUI_ART_GRADIENT_TYPE) == wxPaneDockArtGradients.wxAUI_GRADIENT_HORIZONTAL ? true : false);
        break;
      case ID_AllowFloating:
        (cast(UpdateUIEvent)event).Check(flags & wxFrameManagerOption.wxAUI_MGR_ALLOW_FLOATING ? true : false);
        break;
      case ID_TransparentDrag:
        (cast(UpdateUIEvent)event).Check(flags & wxFrameManagerOption.wxAUI_MGR_TRANSPARENT_DRAG ? true : false);
        break;
      case ID_TransparentHint:
        (cast(UpdateUIEvent)event).Check(flags & wxFrameManagerOption.wxAUI_MGR_TRANSPARENT_HINT ? true : false);
        break;
      case ID_TransparentHintFade:
        (cast(UpdateUIEvent)event).Check(flags & wxFrameManagerOption.wxAUI_MGR_TRANSPARENT_HINT_FADE ? true : false);
        break;
    }
  }

  void OnCreatePerspective(Object sender, Event event)
  {
    TextEntryDialog dlg = new TextEntryDialog(this, "Enter a name for the new perspective:",
                "wxAUI Test");

    dlg.Value = format("Perspective %d", m_perspectives.length+1);
    if (dlg.ShowModal() != wxID_OK)
      return;

    if (m_perspectives.length == 0)
    {
      m_perspectives_menu.AppendSeparator();
    }

    m_perspectives_menu.Append(ID_FirstPerspective + m_perspectives.length, dlg.Value);
    m_perspectives ~= m_mgr.SavePerspective();
  }

  void OnCopyPerspectiveCode(Object sender, Event event)
  {
    char[] s = m_mgr.SavePerspective();

    if (Clipboard.TheClipboard.Open())
    {
      Clipboard.TheClipboard.SetData(new TextDataObject(s));
      Clipboard.TheClipboard.Close();
    }
  }

  void OnRestorePerspective(Object sender, Event event)
  {
    m_mgr.LoadPerspective(m_perspectives[event.ID - ID_FirstPerspective]);
  }


  Point GetStartPosition()
  {
    static int x = 0;
    x += 20;
    Point pt = ClientToScreen(Point(0,0));
    return Point(pt.X + x, pt.Y + x);
  }

  void OnCreateTree(Object sender, Event event)
  {
    PaneInfo info = new PaneInfo();
    m_mgr.AddPane(CreateTreeCtrl(), info.
            Name("Test").Caption("Tree Control").
            Float().FloatingPosition(GetStartPosition()).
            FloatingSize(Size(150,300)));
    m_mgr.Update();
  }

  void OnCreateGrid(Object sender, Event event)
  {
    PaneInfo info = new PaneInfo();
    m_mgr.AddPane(CreateGrid(), info.
            Name("Test").Caption("Grid").
            Float().FloatingPosition(GetStartPosition()).
            FloatingSize(Size(300,200)));
    m_mgr.Update();
  }

  void OnCreateHTML(Object sender, Event event)
  {
    PaneInfo info = new PaneInfo();
    m_mgr.AddPane(CreateHTMLCtrl(), info.
            Name("Test").Caption("Grid").
            Float().FloatingPosition(GetStartPosition()).
            FloatingSize(Size(300,200)));
    m_mgr.Update();
  }

  void OnCreateText(Object sender, Event event)
  {
    PaneInfo info = new PaneInfo();
    m_mgr.AddPane(CreateTextCtrl(), info.
            Name("Test").Caption("Text Control").
            Float().FloatingPosition(GetStartPosition()));
    m_mgr.Update();
  }

  void OnCreateSizeReport(Object sender, Event event)
  {
    PaneInfo info = new PaneInfo();
    m_mgr.AddPane(CreateSizeReportCtrl(), info.
            Name("Test").Caption("Client Size Reporter").
            Float().FloatingPosition(GetStartPosition()));
    m_mgr.Update();
  }

  void OnChangeContentPane(Object sender, Event event)
  {
    m_mgr.GetPane("grid_content").Show(event.ID() == ID_GridContent ? true:false);
    m_mgr.GetPane("text_content").Show(event.ID() == ID_TextContent ? true:false);
    m_mgr.GetPane("tree_content").Show(event.ID() == ID_TreeContent ? true:false);
    m_mgr.GetPane("sizereport_content").Show(event.ID() == ID_SizeReportContent ? true:false);
    m_mgr.GetPane("html_content").Show(event.ID() == ID_HTMLContent ? true:false);
    m_mgr.Update();
  }

  TextCtrl CreateTextCtrl()
  {
    char[] text;
    static int n = 0;

    text = format("This is text box %d", ++n);

    return new TextCtrl(this,-1, text,
                Point(0,0), Size(150,90),
                wxNO_BORDER | TextCtrl.wxTE_MULTILINE);
  }


  Grid CreateGrid()
  {
    Grid grid = new Grid(this, -1,
                  Point(0,0),
                  Size(150,250),
                  wxNO_BORDER | wxWANTS_CHARS);
    grid.CreateGrid(50, 20);
    return grid;
  }

  TreeCtrl CreateTreeCtrl()
  {
    TreeCtrl tree = new TreeCtrl(this, -1,
                      Point(0,0), Size(160,250),
                      TreeCtrl.wxTR_DEFAULT_STYLE | wxNO_BORDER);

    TreeItemId root = tree.AddRoot("wxAUI Project");
    ArrayTreeItemIds items = new ArrayTreeItemIds();


    ImageList imglist = new ImageList(16, 16, true, 2);
    imglist.Add(ArtProvider.GetBitmap(ArtID.wxART_FOLDER, ArtClient.wxART_OTHER, Size(16,16)));
    imglist.Add(ArtProvider.GetBitmap(ArtID.wxART_NORMAL_FILE, ArtClient.wxART_OTHER, Size(16,16)));
    tree.AssignImageList(imglist);

    items.Add(tree.AppendItem(root, "Item 1", 0));
    items.Add(tree.AppendItem(root, "Item 2", 0));
    items.Add(tree.AppendItem(root, "Item 3", 0));
    items.Add(tree.AppendItem(root, "Item 4", 0));
    items.Add(tree.AppendItem(root, "Item 5", 0));


    int i, count;
    for (i = 0, count = items.Count(); i < count; ++i)
    {
      TreeItemId id = items.Item(i);
      tree.AppendItem(id, "Subitem 1", 1);
      tree.AppendItem(id, "Subitem 2", 1);
      tree.AppendItem(id, "Subitem 3", 1);
      tree.AppendItem(id, "Subitem 4", 1);
      tree.AppendItem(id, "Subitem 5", 1);
    }


    tree.Expand(root);

    return tree;
  }

  SizeReportCtrl CreateSizeReportCtrl(int width = 80, int height = 80)
  {
    SizeReportCtrl ctrl = new SizeReportCtrl(this, -1,
                     Window.wxDefaultPosition,
                     Size(width, height), m_mgr);
    return ctrl;
  }

  HtmlWindow CreateHTMLCtrl()
  {
    HtmlWindow ctrl = new HtmlWindow(this, -1,
                     Window.wxDefaultPosition,
                     Size(400,300));
    ctrl.SetPage(GetIntroText());
    return ctrl;
  }


  char[] GetIntroText()
  {
    return
      "<html><body>"
      "<h3>Welcome to wxAUI 0.9.2</h3>"
      "<br/><b>Overview</b><br/>"
      "<p>wxAUI is an Advanced User Interface library for the wxWidgets toolkit "
      "that allows developers to create high-quality, cross-platform user "
      "interfaces quickly and easily.</p>"
      "<p><b>Features</b></p>"
      "<p>With wxAUI version 0.9.2, developers can create application frameworks with:</p>"
      "<ul>"
      "<li>Native, dockable floating frames</li>"
      "<li>Perspective saving and loading</li>"
      "<li>Native toolbars incorporating real-time, &quot;spring-loaded&quot; dragging</li>"
      "<li>Customizable floating/docking behavior</li>"
      "<li>Completely customizable look-and-feel</li>"
      "<li>Optional transparent window effects (while dragging or docking)</li>"
      "</ul>"
      "<p><b>What's new in 0.9.2?</b></p>"
      "<p>The following features/fixes have been added since the last version of wxAUI:</p>"
      "<ul>"
      "<li>Support for wxMac</li>"
      "<li>Updates for wxWidgets 2.6.3</li>"
      "<li>Fix to pass more unused events through</li>"
      "<li>Fix to allow floating windows to receive idle events</li>"
      "<li>Fix for minimizing/maximizing problem with transparent hint pane</li>"
      "<li>Fix to not paint empty hint rectangles</li>"
      "<li>Fix for 64-bit compilation</li>"
      "</ul>"
      "<p><b>What changed in 0.9.1?</b></p>"
      "<p>The following features/fixes were added in wxAUI 0.9.1:</p>"
      "<ul>"
      "<li>Support for MDI frames</li>"
      "<li>Gradient captions option</li>"
      "<li>Active/Inactive panes option</li>"
      "<li>Fix for screen artifacts/paint problems</li>"
      "<li>Fix for hiding/showing floated window problem</li>"
      "<li>Fix for floating pane sizing problem</li>"
      "<li>Fix for drop position problem when dragging around center pane margins</li>"
      "<li>LF-only text file formatting for source code</li>"
      "</ul>"
      "<p>See README.txt for more information.</p>"
      "</body></html>";
  }

  FrameManager m_mgr;
  char[][] m_perspectives;
  Menu m_perspectives_menu;
}



// -- SizeReportCtrl --
// (a utility control that always reports it's client size)

class SizeReportCtrl : Control
{
public:

  this(wxWindow parent, int id = -1,
           Point pos = Window.wxDefaultPosition,
           Size size = wxDefaultSize,
           FrameManager mgr = null)
  {
    super(parent, id, pos, size, wxNO_BORDER);

    m_mgr = mgr;

    EVT_PAINT(&OnPaint);
    EVT_SIZE(&OnSize);
    EVT_ERASE_BACKGROUND(&OnEraseBackground);
  }

private:

  void OnPaint(Object sender, Event evt)
  {
    evt.Skip();

    PaintDC dc = new PaintDC(this);
    Size size = ClientSize;
    char[] s;
    int h, w, height;

    s = format("Size: %d x %d", size.Width, size.Height);

    dc.SetFont(Font.wxNORMAL_FONT);
    dc.GetTextExtent(s, w, height);
    height += 3;
    dc.SetBrush(Brush.wxWHITE_BRUSH);
    dc.SetPen(Pen.wxWHITE_PEN);
    dc.DrawRectangle(0, 0, size.Width, size.Height);
    dc.SetPen(Pen.wxLIGHT_GREY_PEN);
    dc.DrawLine(0, 0, size.Width, size.Height);
    dc.DrawLine(0, size.Height, size.Width, 0);
    dc.DrawText(s, (size.Width-w)/2, ((size.Height-(height*5))/2));

    if (m_mgr)
    {
      PaneInfo pi = m_mgr.GetPane(this);

      s = format("Layer: %d", pi.dock_layer);
      dc.GetTextExtent(s, w, h);
      dc.DrawText(s, (size.Width-w)/2, ((size.Height-(height*5))/2)+(height*1));

      s = format("Dock: %d Row: %d", pi.dock_direction, pi.dock_row);
      dc.GetTextExtent(s, w, h);
      dc.DrawText(s, (size.Width-w)/2, ((size.Height-(height*5))/2)+(height*2));

      s = format("Position: %d", pi.dock_pos);
      dc.GetTextExtent(s, w, h);
      dc.DrawText(s, (size.Width-w)/2, ((size.Height-(height*5))/2)+(height*3));

      s = format("Proportion: %d", pi.dock_proportion);
      dc.GetTextExtent(s, w, h);
      dc.DrawText(s, (size.Width-w)/2, ((size.Height-(height*5))/2)+(height*4));
    }
  }

  void OnEraseBackground(Object sender, Event evt)
  {
    // intentionally empty
  }

  void OnSize(Object sender, Event evt)
  {
    Refresh();
  }
private:

  FrameManager m_mgr;
}




class SettingsPanel : Panel
{
  enum
  {
    ID_PaneBorderSize = MenuIDs.wxID_HIGHEST+1,
    ID_SashSize,
    ID_CaptionSize,
    ID_BackgroundColor,
    ID_SashColor,
    ID_InactiveCaptionColor,
    ID_InactiveCaptionGradientColor,
    ID_InactiveCaptionTextColor,
    ID_ActiveCaptionColor,
    ID_ActiveCaptionGradientColor,
    ID_ActiveCaptionTextColor,
    ID_BorderColor,
    ID_GripperColor
  };

public:

  this(wxWindow parent, MyFrame frame)
  {
    super(parent, -1, Window.wxDefaultPosition, wxDefaultSize);

    BoxSizer vert = new BoxSizer(Orientation.wxVERTICAL);

    //vert.Add(1, 1, 1, Stretch.wxEXPAND);

    BoxSizer s1 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_border_size = new SpinCtrl(this, ID_PaneBorderSize, "", Window.wxDefaultPosition, Size(50,20));
    s1.Add(1, 1, 1, Stretch.wxEXPAND);
    s1.Add(new StaticText(this, -1, "Pane Border Size:"));
    s1.Add(m_border_size);
    s1.Add(1, 1, 1, Stretch.wxEXPAND);
    s1.SetItemMinSize(1, Size(180, 20));
    //vert.Add(s1, 0, Stretch.wxEXPAND | wxLEFT | wxBOTTOM, 5);

    BoxSizer s2 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_sash_size = new SpinCtrl(this, ID_SashSize, "", Window.wxDefaultPosition, Size(50,20));
    s2.Add(1, 1, 1, Stretch.wxEXPAND);
    s2.Add(new StaticText(this, -1, "Sash Size:"));
    s2.Add(m_sash_size);
    s2.Add(1, 1, 1, Stretch.wxEXPAND);
    s2.SetItemMinSize(1, Size(180, 20));
    //vert.Add(s2, 0, Stretch.wxEXPAND | wxLEFT | wxBOTTOM, 5);

    BoxSizer s3 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_caption_size = new SpinCtrl(this, ID_CaptionSize, "", Window.wxDefaultPosition, Size(50,20));
    s3.Add(1, 1, 1, Stretch.wxEXPAND);
    s3.Add(new StaticText(this, -1, "Caption Size:"));
    s3.Add(m_caption_size);
    s3.Add(1, 1, 1, Stretch.wxEXPAND);
    s3.SetItemMinSize(1, Size(180, 20));
    //vert.Add(s3, 0, Stretch.wxEXPAND | wxLEFT | wxBOTTOM, 5);

    //vert.Add(1, 1, 1, Stretch.wxEXPAND);


    Bitmap b = CreateColorBitmap(Colour.wxBLACK);

    BoxSizer s4 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_background_color = new BitmapButton(this, ID_BackgroundColor, b, Window.wxDefaultPosition, Size(50,25));
    s4.Add(1, 1, 1, Stretch.wxEXPAND);
    s4.Add(new StaticText(this, -1, "Background Color:"));
    s4.Add(m_background_color);
    s4.Add(1, 1, 1, Stretch.wxEXPAND);
    s4.SetItemMinSize(1, Size(180, 20));

    BoxSizer s5 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_sash_color = new BitmapButton(this, ID_SashColor, b, Window.wxDefaultPosition, Size(50,25));
    s5.Add(1, 1, 1, Stretch.wxEXPAND);
    s5.Add(new StaticText(this, -1, "Sash Color:"));
    s5.Add(m_sash_color);
    s5.Add(1, 1, 1, Stretch.wxEXPAND);
    s5.SetItemMinSize(1, Size(180, 20));

    BoxSizer s6 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_inactive_caption_color = new BitmapButton(this, ID_InactiveCaptionColor, b, Window.wxDefaultPosition, Size(50,25));
    s6.Add(1, 1, 1, Stretch.wxEXPAND);
    s6.Add(new StaticText(this, -1, "Normal Caption:"));
    s6.Add(m_inactive_caption_color);
    s6.Add(1, 1, 1, Stretch.wxEXPAND);
    s6.SetItemMinSize(1, Size(180, 20));

    BoxSizer s7 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_inactive_caption_gradient_color = new BitmapButton(this, ID_InactiveCaptionGradientColor, b, Window.wxDefaultPosition, Size(50,25));
    s7.Add(1, 1, 1, Stretch.wxEXPAND);
    s7.Add(new StaticText(this, -1, "Normal Caption Gradient:"));
    s7.Add(m_inactive_caption_gradient_color);
    s7.Add(1, 1, 1, Stretch.wxEXPAND);
    s7.SetItemMinSize(1, Size(180, 20));

    BoxSizer s8 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_inactive_caption_text_color = new BitmapButton(this, ID_InactiveCaptionTextColor, b, Window.wxDefaultPosition, Size(50,25));
    s8.Add(1, 1, 1, Stretch.wxEXPAND);
    s8.Add(new StaticText(this, -1, "Normal Caption Text:"));
    s8.Add(m_inactive_caption_text_color);
    s8.Add(1, 1, 1, Stretch.wxEXPAND);
    s8.SetItemMinSize(1, Size(180, 20));

    BoxSizer s9 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_active_caption_color = new BitmapButton(this, ID_ActiveCaptionColor, b, Window.wxDefaultPosition, Size(50,25));
    s9.Add(1, 1, 1, Stretch.wxEXPAND);
    s9.Add(new StaticText(this, -1, "Active Caption:"));
    s9.Add(m_active_caption_color);
    s9.Add(1, 1, 1, Stretch.wxEXPAND);
    s9.SetItemMinSize(1, Size(180, 20));

    BoxSizer s10 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_active_caption_gradient_color = new BitmapButton(this, ID_ActiveCaptionGradientColor, b, Window.wxDefaultPosition, Size(50,25));
    s10.Add(1, 1, 1, Stretch.wxEXPAND);
    s10.Add(new StaticText(this, -1, "Active Caption Gradient:"));
    s10.Add(m_active_caption_gradient_color);
    s10.Add(1, 1, 1, Stretch.wxEXPAND);
    s10.SetItemMinSize(1, Size(180, 20));

    BoxSizer s11 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_active_caption_text_color = new BitmapButton(this, ID_ActiveCaptionTextColor, b, Window.wxDefaultPosition, Size(50,25));
    s11.Add(1, 1, 1, Stretch.wxEXPAND);
    s11.Add(new StaticText(this, -1, "Active Caption Text:"));
    s11.Add(m_active_caption_text_color);
    s11.Add(1, 1, 1, Stretch.wxEXPAND);
    s11.SetItemMinSize(1, Size(180, 20));

    BoxSizer s12 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_border_color = new BitmapButton(this, ID_BorderColor, b, Window.wxDefaultPosition, Size(50,25));
    s12.Add(1, 1, 1, Stretch.wxEXPAND);
    s12.Add(new StaticText(this, -1, "Border Color:"));
    s12.Add(m_border_color);
    s12.Add(1, 1, 1, Stretch.wxEXPAND);
    s12.SetItemMinSize(1, Size(180, 20));

    BoxSizer s13 = new BoxSizer(Orientation.wxHORIZONTAL);
    m_gripper_color = new BitmapButton(this, ID_GripperColor, b, Window.wxDefaultPosition, Size(50,25));
    s13.Add(1, 1, 1, Stretch.wxEXPAND);
    s13.Add(new StaticText(this, -1, "Gripper Color:"));
    s13.Add(m_gripper_color);
    s13.Add(1, 1, 1, Stretch.wxEXPAND);
    s13.SetItemMinSize(1, Size(180, 20));

    GridSizer grid_sizer = new GridSizer(0, 2, 0, 0);
    grid_sizer.HGap = 5;
    grid_sizer.Add(s1);  grid_sizer.Add(s4);
    grid_sizer.Add(s2);  grid_sizer.Add(s5);
    grid_sizer.Add(s3);  grid_sizer.Add(s13);
    grid_sizer.Add(1,1); grid_sizer.Add(s12);
    grid_sizer.Add(s6);  grid_sizer.Add(s9);
    grid_sizer.Add(s7);  grid_sizer.Add(s10);
    grid_sizer.Add(s8);  grid_sizer.Add(s11);

    BoxSizer cont_sizer = new BoxSizer(Orientation.wxVERTICAL);
    cont_sizer.Add(grid_sizer, 1, Stretch.wxEXPAND | Direction.wxALL, 5);
    SetSizer(cont_sizer);
    sizer().SetSizeHints(this);

    m_frame = frame;
    m_border_size.Value = frame.GetDockArt().GetMetric(wxPaneDockArtSetting.wxAUI_ART_PANE_BORDER_SIZE);
    m_sash_size.Value = frame.GetDockArt().GetMetric(wxPaneDockArtSetting.wxAUI_ART_SASH_SIZE);
    m_caption_size.Value = frame.GetDockArt().GetMetric(wxPaneDockArtSetting.wxAUI_ART_CAPTION_SIZE);

    UpdateColors();

    EVT_SPINCTRL(ID_PaneBorderSize, &OnPaneBorderSize);
    EVT_SPINCTRL(ID_SashSize, &OnSashSize);
    EVT_SPINCTRL(ID_CaptionSize, &OnCaptionSize);
    EVT_BUTTON(ID_BackgroundColor, &OnSetColor);
    EVT_BUTTON(ID_SashColor, &OnSetColor);
    EVT_BUTTON(ID_InactiveCaptionColor, &OnSetColor);
    EVT_BUTTON(ID_InactiveCaptionGradientColor, &OnSetColor);
    EVT_BUTTON(ID_InactiveCaptionTextColor, &OnSetColor);
    EVT_BUTTON(ID_ActiveCaptionColor, &OnSetColor);
    EVT_BUTTON(ID_ActiveCaptionGradientColor, &OnSetColor);
    EVT_BUTTON(ID_ActiveCaptionTextColor, &OnSetColor);
    EVT_BUTTON(ID_BorderColor, &OnSetColor);
    EVT_BUTTON(ID_GripperColor, &OnSetColor);
  }

private:

  Bitmap CreateColorBitmap(Colour c)
  {
    Image image = new Image(25,14);
    for (int x = 0; x < 25; ++x)
      for (int y = 0; y < 14; ++y)
      {
        Colour pixcol = c;
        if (x == 0 || x == 24 || y == 0 || y == 13)
          pixcol = Colour.wxBLACK;
        image.SetRGB(x, y, pixcol.Red(), pixcol.Green(), pixcol.Blue());
      }
    return new Bitmap(image);
  }

  void UpdateColors()
  {
    Colour bk = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_BACKGROUND_COLOUR);
    m_background_color.BitmapLabel = CreateColorBitmap(bk);

    Colour cap = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_INACTIVE_CAPTION_COLOUR);
    m_inactive_caption_color.BitmapLabel = CreateColorBitmap(cap);

    Colour capgrad = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_INACTIVE_CAPTION_GRADIENT_COLOUR);
    m_inactive_caption_gradient_color.BitmapLabel = CreateColorBitmap(capgrad);

    Colour captxt = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_INACTIVE_CAPTION_TEXT_COLOUR);
    m_inactive_caption_text_color.BitmapLabel = CreateColorBitmap(captxt);

    Colour acap = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_ACTIVE_CAPTION_COLOUR);
    m_active_caption_color.BitmapLabel = CreateColorBitmap(acap);

    Colour acapgrad = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_ACTIVE_CAPTION_GRADIENT_COLOUR);
    m_active_caption_gradient_color.BitmapLabel = CreateColorBitmap(acapgrad);

    Colour acaptxt = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_ACTIVE_CAPTION_TEXT_COLOUR);
    m_active_caption_text_color.BitmapLabel = CreateColorBitmap(acaptxt);

    Colour sash = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_SASH_COLOUR);
    m_sash_color.BitmapLabel = CreateColorBitmap(sash);

    Colour border = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_BORDER_COLOUR);
    m_border_color.BitmapLabel = CreateColorBitmap(border);

    Colour gripper = m_frame.GetDockArt().GetColor(wxPaneDockArtSetting.wxAUI_ART_GRIPPER_COLOUR);
    m_gripper_color.BitmapLabel = CreateColorBitmap(gripper);
  }

  void OnPaneBorderSize(Object sender, Event event)
  {
    m_frame.GetDockArt().SetMetric(wxPaneDockArtSetting.wxAUI_ART_PANE_BORDER_SIZE,
                     m_border_size.Value);
    m_frame.DoUpdate();
  }

  void OnSashSize(Object sender, Event event)
  {
    m_frame.GetDockArt().SetMetric(wxPaneDockArtSetting.wxAUI_ART_SASH_SIZE,
                     m_sash_size.Value);
    m_frame.DoUpdate();
  }

  void OnCaptionSize(Object sender, Event event)
  {
    m_frame.GetDockArt().SetMetric(wxPaneDockArtSetting.wxAUI_ART_CAPTION_SIZE,
                     m_caption_size.Value);
    m_frame.DoUpdate();
  }

  void OnSetColor(Object sender, Event event)
  {
    ColourDialog dlg = new ColourDialog(m_frame);
    dlg.Title = "Color Picker";
    if (dlg.ShowModal() != wxID_OK)
      return;

    int var = 0;
    switch (event.ID)
    {
      case ID_BackgroundColor:        var = wxPaneDockArtSetting.wxAUI_ART_BACKGROUND_COLOUR; break;
      case ID_SashColor:          var = wxPaneDockArtSetting.wxAUI_ART_SASH_COLOUR; break;
      case ID_InactiveCaptionColor:     var = wxPaneDockArtSetting.wxAUI_ART_INACTIVE_CAPTION_COLOUR; break;
      case ID_InactiveCaptionGradientColor: var = wxPaneDockArtSetting.wxAUI_ART_INACTIVE_CAPTION_GRADIENT_COLOUR; break;
      case ID_InactiveCaptionTextColor:   var = wxPaneDockArtSetting.wxAUI_ART_INACTIVE_CAPTION_TEXT_COLOUR; break;
      case ID_ActiveCaptionColor:       var = wxPaneDockArtSetting.wxAUI_ART_ACTIVE_CAPTION_COLOUR; break;
      case ID_ActiveCaptionGradientColor:   var = wxPaneDockArtSetting.wxAUI_ART_ACTIVE_CAPTION_GRADIENT_COLOUR; break;
      case ID_ActiveCaptionTextColor:     var = wxPaneDockArtSetting.wxAUI_ART_ACTIVE_CAPTION_TEXT_COLOUR; break;
      case ID_BorderColor:          var = wxPaneDockArtSetting.wxAUI_ART_BORDER_COLOUR; break;
      case ID_GripperColor:         var = wxPaneDockArtSetting.wxAUI_ART_GRIPPER_COLOUR; break;
      default: return;
    }

    m_frame.GetDockArt().SetColor(var, dlg.colourData.colour);
    m_frame.DoUpdate();
    UpdateColors();
  }

private:

  MyFrame m_frame;
  SpinCtrl m_border_size;
  SpinCtrl m_sash_size;
  SpinCtrl m_caption_size;
  BitmapButton m_inactive_caption_text_color;
  BitmapButton m_inactive_caption_gradient_color;
  BitmapButton m_inactive_caption_color;
  BitmapButton m_active_caption_text_color;
  BitmapButton m_active_caption_gradient_color;
  BitmapButton m_active_caption_color;
  BitmapButton m_sash_color;
  BitmapButton m_background_color;
  BitmapButton m_border_color;
  BitmapButton m_gripper_color;
}
