//-----------------------------------------------------------------------------
// wxD/Samples - Printing.d
//
// A wxD version of the wxWidgets "printing" sample.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

	public class MyFrame : Frame
	{
		enum Cmd { Print, PrintSetup, PageSetup, PrintPreview, About, Quit }

        private MyCanvas m_canvas;
        private Font m_testFont;

        private PrintData m_printData;
        private PageSetupDialogData m_pageSetupData;

		public this(string title, Point pos, Size size)
		{
			super(title, pos, size);
            // Setup our canvas

            m_canvas = new MyCanvas(this);

            // Setup the menu

            MenuBar menuBar = new MenuBar();

            Menu fileMenu = new Menu();
            fileMenu.Append(Cmd.Print, "&Print...\tCtrl+P", 
                            "Print the canvas");
            fileMenu.Append(Cmd.PrintSetup, "Pr&int Setup...", 
                            "Setup printer properties");
            fileMenu.Append(Cmd.PageSetup, "P&age Setup...",
                            "Page properties");
            fileMenu.Append(Cmd.PrintPreview, "Print P&review...",
                            "Preview the printer output");
            fileMenu.AppendSeparator();
            fileMenu.Append(Cmd.Quit, "E&xit\tCtrl+Shift+W", 
                            "Exit the printer demo");
            menuBar.Append(fileMenu, "&File");

            Menu helpMenu = new Menu();
            helpMenu.Append(Cmd.About, "About...",
                            "About this application");
            menuBar.Append(helpMenu, "&Help");

            this.menuBar = menuBar;

            EVT_MENU(Cmd.Print,        &OnPrint);
            EVT_MENU(Cmd.PrintSetup,   &OnPrintSetup);
            EVT_MENU(Cmd.PageSetup,    &OnPageSetup);
            EVT_MENU(Cmd.PrintPreview, &OnPrintPreview);
            EVT_MENU(Cmd.Quit,         &OnQuit);
            EVT_MENU(Cmd.About,        &OnAbout);

            // Misc initialization 

            m_printData     = new PrintData();
            m_pageSetupData = new PageSetupDialogData();

            icon = new Icon("../Samples/Printing/mondrian.png");

            CreateStatusBar(2);
            StatusText = "Welcome to the Printing Demo!";

            Centre();
        }

		public void OnPrint(Object sender, Event e)
        {
            PrintDialogData printDialogData = new PrintDialogData(m_printData);
            Printer printer = new Printer(printDialogData);

            MyPrintout printout = new MyPrintout("My printout");

            if (!printer.Print(this, printout, true)) {
                if (printer.LastError == PrinterError.wxPRINTER_ERROR) {
                    MessageBox(
                            "There was a problem printing.\n" 
                            "Perhaps your current printer is not set correctly?",
                            "Printing", Dialog.wxOK
                        );
                }
                else {
                    MessageBox("You cancelled printing", 
                                            "Printing", Dialog.wxOK);
                }
            }
            else {
                m_printData = printer.printDialogData.printData;
            }
        }

		public void OnPrintSetup(Object sender, Event e)
        {
            PrintDialog printerDialog = new PrintDialog(this, m_printData);

            printerDialog.printDialogData.SetupDialog = true;
            printerDialog.ShowModal();

            m_printData = printerDialog.printDialogData.printData;
        }

		public void OnPageSetup(Object sender, Event e)
        {
            m_pageSetupData = new PageSetupDialogData(m_printData);

            PageSetupDialog pageSetupDialog = 
                new PageSetupDialog(this, m_pageSetupData);
            pageSetupDialog.ShowModal();

            m_printData = pageSetupDialog.PageSetupData.printData;
            m_pageSetupData = pageSetupDialog.PageSetupData;
        }

		public void OnPrintPreview(Object sender, Event e)
        {
            // Pass two printout Objects: for preview, and possible printing.
            PrintDialogData printDialogData = new PrintDialogData(m_printData);

            PrintPreview preview = 
                new PrintPreview(new MyPrintout(""), new MyPrintout(""), 
                                 printDialogData);

            if (!preview.Ok)
            {
                MessageBox(
                        "There was a problem previewing.\n" ~ 
                        "Perhaps your current printer is not set correctly?",
                        "Previewing", Dialog.wxOK
                    );
                return;
            }

            PreviewFrame frame = 
                new PreviewFrame(preview, this, "Demo Print Preview", 
                                 Point(100, 100), Size(600, 650));

            frame.Centre();
            frame.Initialize();
            frame.Show(true);
        }

		public void OnQuit(Object sender, Event e)
		{
			Close();
		}

		public void OnAbout(Object sender, Event e)
		{
			string msg = "wxD printing demo\n" 
                         "Written by Bryan Bulten\n\n" 
                         "Ported from the wxWidgets Printing \n" 
                         "Demo by BERO ";

			MessageBox(this, msg, "About wxD Printing Demo", 
                                       Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

        public static void Draw(DC dc)
        {
            dc.Background = new Brush("White");
            dc.Clear();
            // TODO dc.Font = m_testFont);

            dc.BackgroundMode = FillStyle.wxTRANSPARENT;

            dc.brush = new Brush("Cyan");
            dc.pen = new Pen("Red");

            dc.DrawRectangle(0, 30, 200, 100);
            dc.DrawText("Rectangle 200 by 100", 40, 40);
            dc.DrawEllipse(50, 140, 100, 50);
            dc.DrawText("Test message: this is in 10 point text", 10, 180);

            string test = "Greek -- " ~
                          "Hebrew -- " ~
                          "Japanese ()";
            dc.DrawText(test, 10, 200); 

            dc.pen = new Pen("Black");
            dc.DrawLine(0, 0, 200, 200);
            dc.DrawLine(200, 0, 0, 200);

            // TODO
            //Icon my_icon = new Icon("../Samples/Printing/mondrian.png");
            //dc.DrawIcon(my_icon, 100, 100);
        }
	}

    public class MyCanvas : ScrolledWindow
    {
        public this(Frame frame)
        { 
            super(frame) ;
            BackgroundColour = new Colour("White");
        }

        public override void OnDraw(DC dc)
        {
            MyFrame.Draw(dc);
        }
    }

    public class MyPrintout : Printout
    {
        public this(string title)

            { super(title); }
        public override bool OnPrintPage(int page)
        {
            DC dc = this.Dc;
            if (dc) {
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

        version(D_Version2)
        public override void GetPageInfo(ref int minPage, ref int maxPage, 
                                         ref int selPageFrom, 
                                         ref int selPageTo)
        {
            minPage = 1; maxPage = 2;
            selPageFrom = 1; selPageTo = 2;
        }
        else // !D_Version2
        public override void GetPageInfo(inout int minPage, inout int maxPage, 
                                         inout int selPageFrom, 
                                         inout int selPageTo)
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
			MyFrame frame = new MyFrame("wxD Printing Demo", 
                                        Point(50,50), Size(450,340));
			frame.Show(true);

			return true;
		}

		
		static void Main()
		{
			MyApp app = new MyApp();
			app.Run();
		}
	}


void main()
{
	MyApp.Main();
}
