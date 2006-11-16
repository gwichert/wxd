//-----------------------------------------------------------------------------
// wxD/Samples - Wizard.d
//
// A wxD version of the wxWidgets "wizard" sample.
//
// Written by Jason Perkins (jason@379.com)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

    enum Cmd
    {
        About,
        Quit,
        RunWizard
    }

    public class MyApp : App
    {
        //---------------------------------------------------------------------

        public override bool OnInit()
        {
            MyFrame frame = new MyFrame("wxWizard Sample");
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


    public class MyFrame : Frame
    {
        //---------------------------------------------------------------------

        public this(string title)
        {
            super(title);
            Menu fileMenu = new Menu();
            fileMenu.Append(Cmd.RunWizard, "&Run wizard...\tCtrl-R");
            fileMenu.AppendSeparator();
            fileMenu.Append(Cmd.Quit, "E&xit\tAlt-X", "Quit this program");

            Menu helpMenu = new Menu();
            helpMenu.Append(Cmd.About, "&About...\tF1", "Show about dialog");

            MenuBar menuBar = new MenuBar();
            menuBar.Append(fileMenu, "&File");
            menuBar.Append(helpMenu, "&Help");
            this.menuBar = menuBar;

            CreateStatusBar();

            // Add event listeners

            EVT_MENU(Cmd.About,        &OnAbout);
            EVT_MENU(Cmd.Quit,         &OnQuit);
            EVT_MENU(Cmd.RunWizard,    &OnRunWizard);
        }

        //---------------------------------------------------------------------

        public void OnQuit(Object sender, Event e)
        {
            Close(true);
        }

        //---------------------------------------------------------------------

        public void OnAbout(Object sender, Event e)
        {
            string msg = "Demo of wxWizard class\n(c) 1999, 2000 Vadim Zeitlin\n ported for D by BERO";
            MessageBox(this, msg, "About wxWizard Sample", Dialog.wxOK | Dialog.wxICON_INFORMATION);
        }

        //---------------------------------------------------------------------

        public void OnRunWizard(Object sender, Event e)
        {
            Wizard wizard = new Wizard(this, -1, "Absolutely Useless Wizard",
                                             new Bitmap("../Samples/Wizard/wiztest.png"));

            WizardPageSimple page1 = new WizardPageSimple(wizard);
            StaticText text = new StaticText(page1, -1,
                                                   "This wizard doesn't help you do anything at all.\n\n" ~
                                                   "The next pages will present you with more useless controls.");

            RadioBoxPage   page3 = new RadioBoxPage(wizard);
            ValidationPage page4 = new ValidationPage(wizard);

            WizardPageSimple.Chain(page1, page3);
            WizardPageSimple.Chain(page3, page4);

            wizard.PageSize = text.BestSize;
            wizard.RunWizard(page1);
        }

        //---------------------------------------------------------------------

        public void OnWizardCancel(Object sender, Event e)
        {
        }
    }


    public class ValidationPage : WizardPageSimple
    {
        private CheckBox checkbox;

        //---------------------------------------------------------------------

        public this(Wizard parent)
        {
            super(parent);
            checkbox = new CheckBox(this, -1, "Check Me");
        }

        //---------------------------------------------------------------------

        public override bool TransferDataFromWindow()
        {
            if (!checkbox.Value)
            {
                string msg = "Check the checkbox first!";
                MessageBox(this, msg, "No way", Dialog.wxOK | Dialog.wxICON_WARNING);
                return false;
            }

            return true;
        }

        //---------------------------------------------------------------------
    }


    public class RadioBoxPage : WizardPageSimple
    {
        private RadioBox radio;

        //---------------------------------------------------------------------

        public this(Wizard parent)
        {
            super(parent);
            static string[] choices = [ "Forward", "Backward", "Both", "Neither" ];

            radio = new RadioBox(this, -1, "Allow to proceed:", new_Point(5,5),
                                    wxDefaultSize, choices,
                                    1, 0);
            radio.Selection = 2;
        }

        //---------------------------------------------------------------------
    }


void main()
{
	MyApp.Main();
}
