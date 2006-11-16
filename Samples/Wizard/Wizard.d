//-----------------------------------------------------------------------------
// wx.NET/Samples - Wizard.cs
//
// A wx.NET version of the wxWidgets "wizard" sample.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using wx;

namespace wx.Samples
{
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

        [STAThread]
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

        public MyFrame(string title)
            : base(title)
        {
            Menu fileMenu = new Menu();
            fileMenu.Append((int)Cmd.RunWizard, "&Run wizard...\tCtrl-R");
            fileMenu.AppendSeparator();
            fileMenu.Append((int)Cmd.Quit, "E&xit\tAlt-X", "Quit this program");

            Menu helpMenu = new Menu();
            helpMenu.Append((int)Cmd.About, "&About...\tF1", "Show about dialog");

            MenuBar menuBar = new MenuBar();
            menuBar.Append(fileMenu, "&File");
            menuBar.Append(helpMenu, "&Help");
            MenuBar = menuBar;

            CreateStatusBar();

            // Add event listeners

            EVT_MENU((int)Cmd.About,        new EventListener(OnAbout));
            EVT_MENU((int)Cmd.Quit,         new EventListener(OnQuit));
            EVT_MENU((int)Cmd.RunWizard,    new EventListener(OnRunWizard));
        }

        //---------------------------------------------------------------------

        public void OnQuit(object sender, Event e)
        {
            Close(true);
        }

        //---------------------------------------------------------------------

        public void OnAbout(object sender, Event e)
        {
            string msg = "Demo of wxWizard class\n© 1999, 2000 Vadim Zeitlin";
            MessageDialog.ShowModal(this, msg, "About wxWizard Sample", Dialog.wxOK | Dialog.wxICON_INFORMATION);
        }

        //---------------------------------------------------------------------

        public void OnRunWizard(object sender, Event e)
        {
            Wizard wizard = new Wizard(this, -1, "Absolutely Useless Wizard",
                                             new Bitmap("../Samples/Wizard/wiztest.png"));

            WizardPageSimple page1 = new WizardPageSimple(wizard);
            StaticText text = new StaticText(page1, -1,
                                                   "This wizard doesn't help you do anything at all.\n\n" +
                                                   "The next pages will present you with more useless controls.");

            RadioBoxPage   page3 = new RadioBoxPage(wizard);
            ValidationPage page4 = new ValidationPage(wizard);

            WizardPageSimple.Chain(page1, page3);
            WizardPageSimple.Chain(page3, page4);

            wizard.PageSize = text.BestSize;
            wizard.RunWizard(page1);
        }

        //---------------------------------------------------------------------

        public void OnWizardCancel(object sender, Event e)
        {
        }
    }


    public class ValidationPage : WizardPageSimple
    {
        private CheckBox checkbox;

        //---------------------------------------------------------------------

        public ValidationPage(Wizard parent) : base(parent)
        {
            checkbox = new CheckBox(this, -1, "Check Me");
        }

        //---------------------------------------------------------------------

        public override bool TransferDataFromWindow()
        {
            if (!checkbox.Value)
            {
                string msg = "Check the checkbox first!";
                MessageDialog.ShowModal(this, msg, "No way", Dialog.wxOK | Dialog.wxICON_WARNING);
                return false;
            }

            return true;
        }

        //---------------------------------------------------------------------
    }


    public class RadioBoxPage : WizardPageSimple
    {
        private enum Choices { Forward, Backward, Both, Neither };

        private RadioBox radio;

        //---------------------------------------------------------------------

        public RadioBoxPage(Wizard parent) : base(parent)
        {
            radio = new RadioBox(this, -1, "Allow to proceed:", new Point(5,5),
                                    wxDefaultSize, Enum.GetNames(typeof(Choices)),
                                    1, 0);
            radio.Selection = (int)Choices.Both;
        }

        //---------------------------------------------------------------------
    }

}

