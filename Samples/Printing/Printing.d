//-----------------------------------------------------------------------------
// wx.NET/Samples - Printing.cs
//
// A wx.NET version of the wxWidgets "printing" sample.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
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
		enum Cmd { Print, PrintSetup, PageSetup, PrintPreview, About, Quit }

        private MyCanvas m_canvas;
        private wx.Font m_testFont;

        private PrintData m_printData;
        private PageSetupDialogData m_pageSetupData;

		public MyFrame(string title, Point pos, Size size)
			: base(title, pos, size)
		{
            // Setup our canvas

            m_canvas = new MyCanvas(this);

            // Setup the menu

            MenuBar menuBar = new MenuBar();

            Menu fileMenu = new Menu();
            fileMenu.Append((int)Cmd.Print, "&Print...\tCtrl+P", 
                            "Print the canvas");
            fileMenu.Append((int)Cmd.PrintSetup, "Pr&int Setup...", 
                            "Setup printer properties");
            fileMenu.Append((int)Cmd.PageSetup, "P&age Setup...",
                            "Page properties");
            fileMenu.Append((int)Cmd.PrintPreview, "Print P&review...",
                            "Preview the printer output");
            fileMenu.AppendSeparator();
            fileMenu.Append((int)Cmd.Quit, "E&xit\tCtrl+Shift+W", 
                            "Exit the printer demo");
            menuBar.Append(fileMenu, "&File");

            Menu helpMenu = new Menu();
            helpMenu.Append((int)Cmd.About, "About...",
                            "About this application");
            menuBar.Append(helpMenu, "&Help");

            MenuBar = menuBar;

            EVT_MENU((int)Cmd.Print,        new EventListener(OnPrint));
            EVT_MENU((int)Cmd.PrintSetup,   new EventListener(OnPrintSetup));
            EVT_MENU((int)Cmd.PageSetup,    new EventListener(OnPageSetup));
            EVT_MENU((int)Cmd.PrintPreview, new EventListener(OnPrintPreview));
            EVT_MENU((int)Cmd.Quit,         new EventListener(OnQuit));
            EVT_MENU((int)Cmd.About,        new EventListener(OnAbout));

            // Misc initialization 

            m_printData     = new PrintData();
            m_pageSetupData = new PageSetupDialogData();

            Icon = new wx.Icon("../Samples/Printing/mondrian.png");

            CreateStatusBar(2);
            StatusText = "Welcome to the Printing Demo!";

            Centre();
        }

		public void OnPrint(object sender, wx.Event e)
        {
            PrintDialogData printDialogData = new PrintDialogData(m_printData);
            Printer printer = new Printer(printDialogData);

            MyPrintout printout = new MyPrintout("My printout");

            if (!printer.Print(this, printout, true)) {
                if (printer.LastError == PrinterError.wxPRINTER_ERROR) {
                    MessageDialog.ShowModal(
                            "There was a problem printing.\n" +
                            "Perhaps your current printer is not set correctly?",
                            "Printing", Dialog.wxOK
                        );
                }
                else {
                    MessageDialog.ShowModal("You cancelled printing", 
                                            "Printing", Dialog.wxOK);
                }
            }
            else {
                m_printData = printer.PrintDialogData.PrintData;
            }
        }

		public void OnPrintSetup(object sender, wx.Event e)
        {
            PrintDialog printerDialog = new PrintDialog(this, m_printData);

            printerDialog.PrintDialogData.SetupDialog = true;
            printerDialog.ShowModal();

            m_printData = printerDialog.PrintDialogData.PrintData;
        }

		public void OnPageSetup(object sender, wx.Event e)
        {
            m_pageSetupData = m_printData;

            PageSetupDialog pageSetupDialog = 
                new PageSetupDialog(this, m_pageSetupData);
            pageSetupDialog.ShowModal();

            m_printData = pageSetupDialog.PageSetupData.PrintData;
            m_pageSetupData = pageSetupDialog.PageSetupData;
        }

		public void OnPrintPreview(object sender, wx.Event e)
        {
            // Pass two printout objects: for preview, and possible printing.
            PrintDialogData printDialogData = new PrintDialogData(m_printData);

            PrintPreview preview = 
                new PrintPreview(new MyPrintout(""), new MyPrintout(""), 
                                 printDialogData);

            if (!preview.Ok)
            {
                MessageDialog.ShowModal(
                        "There was a problem previewing.\n" + 
                        "Perhaps your current printer is not set correctly?",
                        "Previewing", Dialog.wxOK
                    );
                return;
            }

            PreviewFrame frame = 
                new PreviewFrame(preview, this, "Demo Print Preview", 
                                 new Point(100, 100), new Size(600, 650));

            frame.Centre();
            frame.Initialize();
            frame.Show(true);
        }

		public void OnQuit(object sender, wx.Event e)
		{
			Close();
		}

		public void OnAbout(object sender, wx.Event e)
		{
			string msg = "wx.NET printing demo\n" + 
                         "Written by Bryan Bulten\n\n" +
                         "Ported from the wxWidgets Printing \n" +
                         "Demo by Julian Smart ";

			wx.MessageDialog.ShowModal(this, msg, "About wx.NET Printing Demo", 
                                       Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

        public static void Draw(DC dc)
        {
            dc.Background = new wx.Brush("White");
            dc.Clear();
            // TODO dc.Font = m_testFont);

            dc.BackgroundMode = FillStyle.wxTRANSPARENT;

            dc.Brush = new wx.Brush("Cyan");
            dc.Pen = new wx.Pen("Red");

            dc.DrawRectangle(0, 30, 200, 100);
            dc.DrawText("Rectangle 200 by 100", 40, 40);
            dc.DrawEllipse(50, 140, 100, 50);
            dc.DrawText("Test message: this is in 10 point text", 10, 180);

            string test = "Greek (Ελληνικά) Γειά σας -- " +
                          "Hebrew    שלום -- " +
                          "Japanese (日本語)";
            dc.DrawText(test, 10, 200); 

            dc.Pen = new wx.Pen("Black");
            dc.DrawLine(0, 0, 200, 200);
            dc.DrawLine(200, 0, 0, 200);

            // TODO
            //wx.Icon my_icon = new wx.Icon("../Samples/Printing/mondrian.png");
            //dc.DrawIcon(my_icon, 100, 100);
        }
	}

    public class MyCanvas : ScrolledWindow
    {
        public MyCanvas(Frame frame)
            : base(frame) 
        { 
            BackgroundColour = new Colour("White");
        }

        public override void OnDraw(DC dc)
        {
            MyFrame.Draw(dc);
        }
    }

    public class MyPrintout : Printout
    {
        public MyPrintout(string title)
            : base(title) { }

        public override bool OnPrintPage(int page)
        {
            DC dc = DC;
            if (dc != null) {
                if (page == 1)
                    DrawPageOne(dc);
                else 
                    DrawPageTwo(dc);

                // TODO
                //dc.SetDeviceOrigin(0, 0);
                //dc.SetUserScale(1.0, 1.0);

                return true;
            }

            return false;
        }

        public override bool HasPage(int page)
        {
            return (page == 1 || page == 2);
        }

        public override void GetPageInfo(ref int minPage, ref int maxPage, 
                                         ref int selPageFrom, 
                                         ref int selPageTo)
        {
            minPage = 1; maxPage = 2;
            selPageFrom = 1; selPageTo = 2;
        }

        private void DrawPageOne(DC dc)
        {
            // TODO: Scale graphics here 
            
            MyFrame.Draw(dc);
        }

        private void DrawPageTwo(DC dc)
        {
            // TODO: Draw something different here
        }
    }

	public class MyApp : App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("wx.NET Printing Demo", 
                                        new Point(50,50), new Size(450,340));
			frame.Show(true);

			return true;
		}

		[STAThread]
		static void Main()
		{
			MyApp app = new MyApp();
			app.Run();
		}
	}
}
