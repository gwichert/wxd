//-----------------------------------------------------------------------------
// wx.NET/Samples - Minimal.cs
//
// A wx.NET version of the wxWidgets "minimal" sample.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;

namespace wx.Samples
{
	public class MyFrame : wx.Frame
	{
		enum Cmd { About, Quit, Dialog }

		//---------------------------------------------------------------------

		public MyFrame(string title, Point pos, Size size)
			: base(title, pos, size)
		{
			// Set the window icon

			Icon = new wx.Icon("../Samples/Minimal/mondrian.png");

			// Set up a menu

			wx.Menu fileMenu = new wx.Menu();
			//fileMenu.Append((int)Cmd.Dialog, "&Show dialog\tAlt-D", "Show test dialog");
			fileMenu.Append((int)Cmd.Quit, "E&xit\tAlt-X", "Quit this program");

			wx.Menu helpMenu = new wx.Menu();
			helpMenu.Append((int)Cmd.About, "&About...\tF1", "Show about dialog");

			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append(fileMenu, "&File");
			menuBar.Append(helpMenu, "&Help");

			MenuBar = menuBar;

			// Set up a status bar

			CreateStatusBar(2);
			StatusText = "Welcome to wxWidgets!";

			// Set up the event table

			EVT_MENU((int)Cmd.Quit,    new EventListener(OnQuit));
		    EVT_MENU((int)Cmd.Dialog,  new EventListener(OnDialog));
			EVT_MENU((int)Cmd.About,   new EventListener(OnAbout));
		}

		//---------------------------------------------------------------------

		public void OnQuit(object sender, wx.Event e)
		{
			Close();
		}

		//---------------------------------------------------------------------

		public void OnDialog(object sender, wx.Event e)
		{
            wx.Dialog dialog = new wx.Dialog( this, -1, "Test dialog", new Point(50,50), new Size(450,340) );
            wx.BoxSizer main_sizer = new wx.BoxSizer( wx.Orientation.wxVERTICAL );
            
            wx.StaticBoxSizer top_sizer = new wx.StaticBoxSizer( new wx.StaticBox( dialog, -1, "Bitmaps" ), wx.Orientation.wxHORIZONTAL );
            main_sizer.Add( top_sizer, 0, wx.Direction.wxALL, 5 );
            
            wx.BitmapButton bb = new wx.BitmapButton( dialog, -1, new wx.Bitmap("../Samples/Minimal/mondrian.png") );
            top_sizer.Add( bb, 0, wx.Direction.wxALL, 10 );
            
            wx.StaticBitmap sb = new wx.StaticBitmap( dialog, -1, new wx.Bitmap("../Samples/Minimal/mondrian.png") );
            top_sizer.Add( sb, 0, wx.Direction.wxALL, 10 );
            
            wx.Button button = new wx.Button( dialog, 5100, "OK" );
            main_sizer.Add( button, 0, wx.Direction.wxALL|wx.Alignment.wxALIGN_CENTER, 5 );
            
            dialog.SetSizer( main_sizer, true );
            main_sizer.Fit( dialog );
            main_sizer.SetSizeHints( dialog );
            
            dialog.CentreOnParent();
            dialog.ShowModal();
		}

		//---------------------------------------------------------------------

		public void OnAbout(object sender, wx.Event e)
		{
			string msg = "This is the About dialog of the minimal sample.";
			wx.MessageDialog.ShowModal(this, msg, "About Minimal", Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------
	}



	public class Minimal : wx.App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("Minimal wxWidgets App", new Point(50,50), new Size(450,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			Minimal app = new Minimal();
			app.Run();
		}

		//---------------------------------------------------------------------
	}
}
