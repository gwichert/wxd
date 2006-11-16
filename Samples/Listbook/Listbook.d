//-----------------------------------------------------------------------------
// wx.NET/Samples - Listbook.cs
//
// wx.NET "Listbook" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;

namespace wx.Samples
{
	public class ListbookFrame : Frame
	{
		enum Cmd 
		{
			About,
			Quit
		}

		//---------------------------------------------------------------------

		public TextCtrl textCtrl;
		public MyListbook listbook;

		//---------------------------------------------------------------------

		public ListbookFrame(string title, Point pos, Size size)
			: base(title, pos, size)
		{
			// Set the window icon and status bar

			Icon = new wx.Icon("../Samples/Listbook/mondrian.png");

			CreateStatusBar();
			StatusText = "Welcome to the Listbook Sample!";	
			
			Menu menuFile = new Menu();
			menuFile.AppendWL( (int)Cmd.About, "&About", new EventListener( OnAbout ) );
			menuFile.AppendSeparator();
			menuFile.AppendWL( (int)Cmd.Quit, "E&xit\tAlt-X", "Quit this program", new EventListener( OnQuit) );
			
			MenuBar menuBar = new MenuBar();
			menuBar.Append( menuFile, "&File" );
			MenuBar = menuBar;

			textCtrl = new TextCtrl(this, -1, "", wxDefaultPosition, wxDefaultSize, 
				TextCtrl.wxTE_MULTILINE | TextCtrl.wxTE_READONLY | TextCtrl.wxSUNKEN_BORDER );

			Log.SetActiveTarget( textCtrl );

			listbook = new MyListbook( this, -1 );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( listbook, 1, Stretch.wxGROW );
			bSizer.Add( textCtrl, 0, Stretch.wxGROW );

			Sizer = bSizer;
		}

		//---------------------------------------------------------------------	

		public void OnAbout( object sender, Event e )
		{
			MessageDialog.MessageBox( "wx.NET Listbook sample\n2004 by Alexander Olk", "About",
				Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------	

		public void OnQuit( object sender, Event e )
		{
			Close();
		}
	}   
	
	//---------------------------------------------------------------------	

	public class MyListbook : Listbook
	{
		public ImageList imageList;

		//---------------------------------------------------------------------	

		public MyListbook( Window parent, int id)
			: base( parent, id )
		{
			imageList = new ImageList( 32, 32 );

			// load bitmaps
			for ( int i = 1; i < 16; ++i )
			{
				Bitmap bmp = new Bitmap( String.Format( "../Samples/Listbook/bmp/toblom{0}.png", 
					i.ToString().PadLeft( 2, '0' ) ) );
				imageList.Add( bmp );
			}

			AssignImageList( imageList );

			for ( int i = 1; i < 16; ++i )
			{
				ListbookPanel p = new ListbookPanel( this, -1, i );
				AddPage( p , String.Format( "Picture {0}    ", i ), false, i - 1 );
			} 

			EVT_LISTBOOK_PAGE_CHANGED( -1, new EventListener( OnPageChanged ) );
			EVT_LISTBOOK_PAGE_CHANGING( -1, new EventListener( OnPageChanging ) );
		}

		//---------------------------------------------------------------------	

		public void OnPageChanged( object sender, Event e )
		{
			ListbookEvent le = (ListbookEvent) e;

			Log.LogMessage( "OnPageChanged, old: " + le.OldSelection + ", " +
				"new: " + le.Selection + ", Selection: " + this.Selection );

			e.Skip();
		}

		//---------------------------------------------------------------------	

		public void OnPageChanging( object sender, Event e )
		{
			ListbookEvent le = (ListbookEvent) e;

			Log.LogMessage( "OnPageChanging, old: " + le.OldSelection + ", " +
				"new: " + le.Selection + ", Selection: " + this.Selection );

			e.Skip();
		}
	}

	//---------------------------------------------------------------------	

	public class ListbookPanel : Panel
	{
		public HtmlWindow htmlWindow;
		
		//---------------------------------------------------------------------	

		public ListbookPanel( Window parent, int id, int number )
			: base( parent, id )
		{
			htmlWindow = new HtmlWindow( this );
			htmlWindow.AppendToPage( "<html><body><center><h1>This is HtmlWindow page " +
				number + ".</h1><br><br><br>" + 
				"<img height=\"32\" width=\"32\" alt=\"\" " +
				"src=\"" +
				String.Format( "../Samples/Listbook/bmp/toblom{0}.png", number.ToString().PadLeft( 2, '0' ) ) +
				"\">" +
				"</center></body></html>" );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( htmlWindow, 1, Stretch.wxGROW );

			Sizer = bSizer;
		}
	}

	//---------------------------------------------------------------------	

	public class ListbookApp : wx.App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			ListbookFrame frame = new ListbookFrame("Listbook wxWidgets Sample", new Point(10, 100), new Size(650,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			ListbookApp app = new ListbookApp();
			app.Run();
		}

		//---------------------------------------------------------------------
	}
}
