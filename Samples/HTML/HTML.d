//-----------------------------------------------------------------------------
// wx.NET/Samples - HTML.cs
//
// A NET version of the wxWidgets "HTML" sample.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// Copyright (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using wx;

namespace Samples
{
    public class MyFrame : Frame
    {
        enum Cmd { Open, OpenURL, About, Quit, Dialog, Back, Forward }


        HtmlWindow m_html;

        //---------------------------------------------------------------------

        public MyFrame(string title, Point pos, Size size)
            : base(title, pos, size)
        {
            // Set the window icon

            Icon = new wx.Icon("../Samples/HTML/mondrian.png");

            // Set up a menu

            Menu fileMenu = new Menu();
            fileMenu.Append((int)Cmd.Open, "Open...\tCtrl+O",
                            "Open a page");
            fileMenu.Append((int)Cmd.OpenURL, "Open URL...\tCtrl+U",
                            "Open a URL");
            fileMenu.AppendSeparator();
            fileMenu.Append((int)Cmd.Quit, "E&xit\tAlt-X", 
                            "Quit this program");

            Menu goMenu = new Menu();
            goMenu.Append((int)Cmd.Back, "&Back\tCtrl+B", 
                          "Browse back one page");
            goMenu.Append((int)Cmd.Forward, "&Forward\tCtrl+F", 
                          "Browse forward one page");

            Menu helpMenu = new Menu();
            helpMenu.Append((int)Cmd.About, "&About...\tF1", 
                            "Show about dialog");

            MenuBar menuBar = new MenuBar();
            menuBar.Append(fileMenu, "&File");
            menuBar.Append(goMenu,   "&Browse");
            menuBar.Append(helpMenu, "&Help");

            MenuBar = menuBar;

            // Set up a status bar

            CreateStatusBar(2);
            StatusText = "Welcome to wxWidgets!";

            // Create the HTML window

            m_html = new HtmlWindow(this);
            m_html.SetRelatedFrame(this, "HTML : %s");
            m_html.RelatedStatusBar = 1;
            m_html.LoadPage("../Samples/HTML/Data/test.htm");

            // Set up the event table

            EVT_MENU((int)Cmd.Open,    new EventListener(OnOpen));
            EVT_MENU((int)Cmd.OpenURL, new EventListener(OnOpenURL));
            EVT_MENU((int)Cmd.Quit,    new EventListener(OnQuit));
            EVT_MENU((int)Cmd.Back,    new EventListener(OnBack));
            EVT_MENU((int)Cmd.Forward, new EventListener(OnForward));
            EVT_MENU((int)Cmd.About,   new EventListener(OnAbout));
        }

        //---------------------------------------------------------------------

        public void OnOpen(object sender, Event e)
        {
            string page = new FileSelector("Open HTML document", "", "", "", 
                                           "HTML Files (*.htm)|*.htm|" + 
                                           "All Files (*.*)|*.*");
            if (page != "") {
                m_html.LoadPage(page);
            }
        }

        public void OnOpenURL(object sender, Event e)
        {
            TextEntryDialog dlg = 
                new TextEntryDialog(this, "Enter URL to open", "Open URL", 
                                    "http://wxnet.sourceforge.net/news.html", 
                                    Dialog.wxOK | Dialog.wxCANCEL);
            if (dlg.ShowModal() == Dialog.wxID_OK) {
                m_html.LoadPage(dlg.Value);
            }
        }

        public void OnQuit(object sender, Event e)
        {
            Close();
        }

        //---------------------------------------------------------------------

        public void OnAbout(object sender, Event e)
        {
            HtmlAboutDialog dlg = new HtmlAboutDialog(this);
            dlg.ShowModal();
        }

        //---------------------------------------------------------------------

        public void OnBack(object sender, Event e)
        {
            if (!m_html.HistoryBack()) {
                MessageDialog dlg = 
                    new MessageDialog(this, "Can't go back any further", 
                                      "HTML", Dialog.wxOK | Dialog.wxCENTRE);
                dlg.ShowModal();
            }
        }

        public void OnForward(object sender, Event e)
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

        public HtmlAboutDialog (Window parent)
            : base(parent, -1, "About HTML")
        {
            Sizer = new BoxSizer(Orientation.wxVERTICAL);

            // Create the about html window

            HtmlWindow html = new HtmlWindow(this, -1, wxDefaultPosition,
                                             new Size(380, 160), 
                                             HtmlWindow.wxHW_SCROLLBAR_NEVER);
            html.Borders = 0;
            html.LoadPage("../Samples/HTML/Data/about.htm");

            html.Size = new Size(html.InternalRepresentation.Width,
                                 html.InternalRepresentation.Height);

            Sizer.Add(html, 1, Direction.wxALL, 5);

            // Create the OK button

            Sizer.Add(new Button(this, -1, "OK"), 0, 
                      Alignment.wxALIGN_CENTER | Direction.wxALL, 5);
            Sizer.Fit(this);

            EVT_BUTTON(-1, new EventListener(OnOK));
        }

        //---------------------------------------------------------------------

        public void OnOK(object sender, Event e)
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
            MyFrame frame = new MyFrame("HTML Sample", new Point(50,50), 
                                        new Size(450,340));
            frame.Show(true);

            return true;
        }

        //---------------------------------------------------------------------

        [STAThread]
        static void Main()
        {
            MyApp app = new MyApp();
            app.Run();
        }

        //---------------------------------------------------------------------
    }
}
