//-----------------------------------------------------------------------------
// wxD/Samples - Listbook.d
//
// wxD "Listbook" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
import std.string;

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

		public this(string title, Point pos, Size size)
		{
			super(title, pos, size);
			// Set the window icon and status bar

			icon = new Icon("../Samples/Listbook/mondrian.png");

			CreateStatusBar();
			StatusText = "Welcome to the Listbook Sample!";	
			
			Menu menuFile = new Menu();
			menuFile.AppendWL( Cmd.About, "&About", & OnAbout ) ;
			menuFile.AppendSeparator();
			menuFile.AppendWL( Cmd.Quit, "E&xit\tAlt-X", "Quit this program", & OnQuit) ;
			
			MenuBar menuBar = new MenuBar();
			menuBar.Append( menuFile, "&File" );
			this.menuBar = menuBar;

			textCtrl = new TextCtrl(this, -1, "", wxDefaultPosition, wxDefaultSize, 
				TextCtrl.wxTE_MULTILINE | TextCtrl.wxTE_READONLY | TextCtrl.wxSUNKEN_BORDER );

			Log.SetActiveTarget( textCtrl );

			listbook = new MyListbook( this, -1 );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( listbook, 1, Stretch.wxGROW );
			bSizer.Add( textCtrl, 0, Stretch.wxGROW );

			sizer = bSizer;
		}

		//---------------------------------------------------------------------	

		public void OnAbout( Object sender, Event e )
		{
			MessageBox( "wxD Listbook sample\n2004 by Alexander Olk\nportred D by BERO", "About",
				Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------	

		public void OnQuit( Object sender, Event e )
		{
			Close();
		}
	}   
	
	//---------------------------------------------------------------------	

	public class MyListbook : Listbook
	{
		public ImageList imageList;

		//---------------------------------------------------------------------	

		public this( Window parent, int id)
		{
			super( parent, id );
			imageList = new ImageList( 32, 32 );

			// load bitmaps
			for ( int i = 1; i < 16; ++i )
			{
				Bitmap bmp = new Bitmap( std.string.format( "../Samples/Listbook/bmp/toblom%02d.png", 
					i ) );
				imageList.Add( bmp );
			}

			AssignImageList( imageList );

			for ( int i = 1; i < 16; ++i )
			{
				ListbookPanel p = new ListbookPanel( this, -1, i );
				AddPage( p , std.string.format( "Picture %d    ", i ), false, i - 1 );
			} 

			EVT_LISTBOOK_PAGE_CHANGED( -1, & OnPageChanged ) ;
			EVT_LISTBOOK_PAGE_CHANGING( -1, & OnPageChanging ) ;
		}

		//---------------------------------------------------------------------	

		public void OnPageChanged( Object sender, Event e )
		{
			ListbookEvent le = cast(ListbookEvent) e;

			Log.LogMessage( "OnPageChanged, old: " ~ .toString(le.OldSelection) ~ ", " ~
				"new: " ~ .toString(le.Selection) ~ ", Selection: " ~ .toString(this.Selection) );

			e.Skip();
		}

		//---------------------------------------------------------------------	

		public void OnPageChanging( Object sender, Event e )
		{
			ListbookEvent le = cast(ListbookEvent) e;

			Log.LogMessage( "OnPageChanging, old: " ~ .toString(le.OldSelection) ~ ", " ~
				"new: " ~ .toString(le.Selection) ~ ", Selection: " ~ .toString(this.Selection) );

			e.Skip();
		}
	}

	//---------------------------------------------------------------------	

	public class ListbookPanel : Panel
	{
		public HtmlWindow htmlWindow;
		
		//---------------------------------------------------------------------	

		public this( Window parent, int id, int number )
		{
			super( parent, id );
			htmlWindow = new HtmlWindow( this );
			htmlWindow.AppendToPage( "<html><body><center><h1>This is HtmlWindow page " ~
				.toString(number) ~ ".</h1><br><br><br>" ~ 
				"<img height=\"32\" width=\"32\" alt=\"\" " ~
				"src=\"" ~
				std.string.format( "../Samples/Listbook/bmp/toblom%02d.png", number ) ~
				"\">" ~
				"</center></body></html>" );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( htmlWindow, 1, Stretch.wxGROW );

			sizer = bSizer;
		}
	}

	//---------------------------------------------------------------------	

	public class ListbookApp : App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			ListbookFrame frame = new ListbookFrame("Listbook wxWidgets Sample", new_Point(10, 100), new_Size(650,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			ListbookApp app = new ListbookApp();
			app.Run();
		}

		//---------------------------------------------------------------------
	}


void main()
{
	ListbookApp.Main();
}
