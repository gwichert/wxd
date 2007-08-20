//-----------------------------------------------------------------------------
// wxD/Samples - Minimal.d
// based on
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

import wx.wx;

	public class MyFrame : Frame
	{
		enum Cmd
		{
			About = MenuIDs.wxID_ABOUT,
			Quit = MenuIDs.wxID_EXIT,
			Dialog = MenuIDs.wxID_HIGHEST + 1
		}

		//---------------------------------------------------------------------

		public this(string title, Point pos, Size size)
		{
			super(title, pos, size);
			// Set the window icon

			icon = new Icon("../Samples/Minimal/mondrian.png");

			// Set up a menu

			Menu fileMenu = new Menu();
			fileMenu.Append(Cmd.Dialog, "&Show dialog\tAlt-D", "Show test dialog");
			fileMenu.Append(Cmd.Quit, "E&xit\tAlt-X", "Quit this program");

			Menu helpMenu = new Menu();
			helpMenu.Append(Cmd.About, "&About...\tF1", "Show about dialog");

			MenuBar menuBar = new MenuBar();
			menuBar.Append(fileMenu, "&File");
			menuBar.Append(helpMenu, "&Help");

			this.menuBar = menuBar;

			// Set up a status bar

			CreateStatusBar(2);
			StatusText = "Welcome to wxWidgets!";

			// Set up the event table

			EVT_MENU(Cmd.Quit,    &OnQuit);
			EVT_MENU(Cmd.Dialog,  &OnDialog);
			EVT_MENU(Cmd.About,   &OnAbout);
		}

		//---------------------------------------------------------------------

		public void OnQuit(Object sender, Event e)
		{
			Close();
		}

		//---------------------------------------------------------------------

		public void OnDialog(Object sender, Event e)
		{
            Dialog dialog = new Dialog( this, -1, "Test dialog", Point(50,50), Size(450,340) );
            BoxSizer main_sizer = new BoxSizer( Orientation.wxVERTICAL );

            StaticBoxSizer top_sizer = new StaticBoxSizer( new StaticBox( dialog, -1, "Bitmaps" ), Orientation.wxHORIZONTAL );
            main_sizer.Add( top_sizer, 0, Direction.wxALL, 5 );

            BitmapButton bb = new BitmapButton( dialog, -1, new Bitmap("../Samples/Minimal/mondrian.png") );
            top_sizer.Add( bb, 0, Direction.wxALL, 10 );

            StaticBitmap sb = new StaticBitmap( dialog, -1, new Bitmap("../Samples/Minimal/mondrian.png") );
            top_sizer.Add( sb, 0, Direction.wxALL, 10 );

            Button button = new Button( dialog, 5100, "OK" );
            main_sizer.Add( button, 0, Direction.wxALL|Alignment.wxALIGN_CENTER, 5 );

            dialog.SetSizer( main_sizer, true );
            main_sizer.Fit( dialog );
            main_sizer.SetSizeHints( dialog );

            dialog.CentreOnParent();
            dialog.ShowModal();
		}

		//---------------------------------------------------------------------

		public void OnAbout(Object sender, Event e)
		{
			string msg = "This is the About dialog of the minimal sample.\nWelcome to " ~ wxVERSION_STRING;
			MessageBox(this, msg, "About Minimal", Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------
	}



	public class Minimal : App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("Minimal wxWidgets App", Point(50,50), Size(450,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		static void Main()
		{
			Minimal app = new Minimal();
			app.Run();
		}

		//---------------------------------------------------------------------
	}

int main()
{
	Minimal.Main();
	return 0;
}
