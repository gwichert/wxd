//-----------------------------------------------------------------------------
// wxD/Samples - HTML.cs
//
// A NET version of the wxWidgets "HTML" sample.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// Copyright (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

    public class MyFrame : Frame
    {
        enum Cmd { Open, OpenURL, About, Quit, Dialog, Back, Forward }


        HtmlWindow m_html;

        //---------------------------------------------------------------------

        public this(string title, Point pos, Size size)
        {
            super(title, pos, size);
            // Set the window icon

            this.icon = new Icon("../Samples/HTML/mondrian.png");

            // Set up a menu

            Menu fileMenu = new Menu();
            fileMenu.Append(Cmd.Open, "Open...\tCtrl+O",
                            "Open a page");
            fileMenu.Append(Cmd.OpenURL, "Open URL...\tCtrl+U",
                            "Open a URL");
            fileMenu.AppendSeparator();
            fileMenu.Append(Cmd.Quit, "E&xit\tAlt-X", 
                            "Quit this program");

            Menu goMenu = new Menu();
            goMenu.Append(Cmd.Back, "&Back\tCtrl+B", 
                          "Browse back one page");
            goMenu.Append(Cmd.Forward, "&Forward\tCtrl+F", 
                          "Browse forward one page");

            Menu helpMenu = new Menu();
            helpMenu.Append(Cmd.About, "&About...\tF1", 
                            "Show about dialog");

            MenuBar menuBar = new MenuBar();
            menuBar.Append(fileMenu, "&File");
            menuBar.Append(goMenu,   "&Browse");
            menuBar.Append(helpMenu, "&Help");

            this.menuBar = menuBar;

            // Set up a status bar

            CreateStatusBar(2);
            StatusText = "Welcome to wxWidgets!";

            // Create the HTML window

            m_html = new HtmlWindow(this);
            m_html.SetRelatedFrame(this, "HTML : %s");
            m_html.RelatedStatusBar = 1;
            m_html.LoadPage("../Samples/HTML/Data/test.htm");

            // Set up the event table

            EVT_MENU(Cmd.Open,    &OnOpen);
            EVT_MENU(Cmd.OpenURL, &OnOpenURL);
            EVT_MENU(Cmd.Quit,    &OnQuit);
            EVT_MENU(Cmd.Back,    &OnBack);
            EVT_MENU(Cmd.Forward, &OnForward);
            EVT_MENU(Cmd.About,   &OnAbout);
        }

        //---------------------------------------------------------------------

        public void OnOpen(Object sender, Event e)
        {
            string page = FileSelector("Open HTML document", "", "", "", 
                                           "HTML Files (*.htm)|*.htm|" ~ 
                                           "All Files (*.*)|*.*");
            if (page != "") {
                m_html.LoadPage(page);
            }
        }

        public void OnOpenURL(Object sender, Event e)
        {
            TextEntryDialog dlg = 
                new TextEntryDialog(this, "Enter URL to open", "Open URL", 
                                    "http://wxnet.sourceforge.net/news.html", 
                                    Dialog.wxOK | Dialog.wxCANCEL);
            if (dlg.ShowModal() == Dialog.wxID_OK) {
                m_html.LoadPage(dlg.Value);
            }
        }

        public void OnQuit(Object sender, Event e)
        {
            Close();
        }

        //---------------------------------------------------------------------

        public void OnAbout(Object sender, Event e)
        {
            HtmlAboutDialog dlg = new HtmlAboutDialog(this);
            dlg.ShowModal();
        }

        //---------------------------------------------------------------------

        public void OnBack(Object sender, Event e)
        {
            if (!m_html.HistoryBack()) {
                MessageDialog dlg = 
                    new MessageDialog(this, "Can't go back any further", 
                                      "HTML", Dialog.wxOK | Dialog.wxCENTRE);
                dlg.ShowModal();
            }
        }

        public void OnForward(Object sender, Event e)
        {
            if (!m_html.HistoryForward()) {
                MessageDialog dlg = 
                    new MessageDialog(this, "There is no forward", 
                                      "HTML", Dialog.wxOK | Dialog.wxCENTRE);
                dlg.ShowModal();
            }
        }

        //---------------------------------------------------------------------
    }

    public class HtmlAboutDialog : Dialog
    {
        //---------------------------------------------------------------------

        public this (Window parent)
        {
            super(parent, -1, "About HTML");

            this.sizer = new BoxSizer(Orientation.wxVERTICAL);

            // Create the about html window

            HtmlWindow html = new HtmlWindow(this, -1, wxDefaultPosition,
                                             new_Size(380,160), 
                                             HtmlWindow.wxHW_SCROLLBAR_NEVER);
            html.Borders = 0;
            html.LoadPage("../Samples/HTML/Data/about.htm");

            html.size = html.InternalRepresentation.size;

            sizer.Add(html, 1, Direction.wxALL, 5);

            // Create the OK button

            sizer.Add(new Button(this, -1, "OK"), 0, 
                      Alignment.wxALIGN_CENTER | Direction.wxALL, 5);
            sizer.Fit(this);

            EVT_BUTTON(-1, &OnOK);
        }

        //---------------------------------------------------------------------

        public void OnOK(Object sender, Event e)
        {
            EndModal(wxID_OK);
        }

        //---------------------------------------------------------------------
    }

    public class MyApp : App
    {
        //---------------------------------------------------------------------

        public override bool OnInit()
        {
            MyFrame frame = new MyFrame("HTML Sample", new_Point(50,50), new_Size(450,340));

            frame.Show(true);

            return true;
        }

        //---------------------------------------------------------------------

        static void Main()
        {
            MyApp app = new MyApp();
            app.Run();
        }

        //---------------------------------------------------------------------
    }

void main()
{
	MyApp.Main();
}
