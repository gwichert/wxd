//-----------------------------------------------------------------------------
// wxD/Samples - ListView.cs
//
// wxD "ListView" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
private import std.string;

	public class ListViewFrame : Frame
	{
		enum Cmd 
		{
			About,
			Quit
		}

		//---------------------------------------------------------------------

		public TextCtrl textCtrl;

		//---------------------------------------------------------------------

		public this(string title, Point pos, Size size)
		{
			super(title, pos, size);
			// Set the window icon and status bar

			this.icon = new Icon("../Samples/ListView/mondrian.png");

			CreateStatusBar();
			StatusText = "Welcome to the ListView Sample!";	
			
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
			
			MyListView mlv = new MyListView( this );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( mlv, 1, Stretch.wxGROW );
			bSizer.Add( textCtrl, 0, Stretch.wxGROW );

			this.sizer = bSizer;
		}

		//---------------------------------------------------------------------	

		public void OnAbout( Object sender, Event e )
		{
			MessageBox( "wxD ListView sample\n2004 by Alexander Olk", "About",
				Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}

		//---------------------------------------------------------------------	

		public void OnQuit( Object sender, Event e )
		{
			Close();
		}
	}   
	
	//---------------------------------------------------------------------	
	
	public class MyListView : ListView
	{
		public this( Window parent )
		{
			super( parent, -1, wxDefaultPosition, wxDefaultSize, ListCtrl.wxLC_REPORT | ListCtrl.wxLC_EDIT_LABELS  );
		
			InsertColumn( 0, "First Column" );
			SetColumnWidth( 0, 200 );
			
			ListItem itemCol = new ListItem();
			itemCol.Text = "Second Column";
			itemCol.Align = ListCtrl.wxLIST_FORMAT_CENTER;
			itemCol.Width = 300;
			InsertColumn( 1, itemCol );
		
			for ( int i = 0; i < 200; ++i )
			{
				string buf = "Col 1 Item " ~ .toString(i);
				int tmp = InsertItem( i, buf, 0);
				SetItemData( tmp, i );
				
				buf = "Col 2 Item " ~ .toString(i);
				SetItem( i, 1, buf );
			}
				
			Log.LogMessage( "Items created..." );
			
			ColumnClick_Add(& OnColumnClick );
			ItemSelect_Add(& OnItemSelect );
			ColumnRightClick_Add(& OnColumnRightClick );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnColumnClick( Object sender, Event e )
		{
			ListEvent le = cast(ListEvent)e;
			
			Log.LogMessage( "Clicked column header " ~ .toString(le.Column) );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnItemSelect( Object sender, Event e )
		{
			ListEvent le = cast(ListEvent)e;
			
			Log.LogMessage( "Value 1st field of selected item: " ~ le.Text );
			
			ListItem info = new ListItem();
			info.Id = le.Index;
			info.Column = 1;
			info.Mask = ListCtrl.wxLIST_MASK_TEXT;
			
			GetItem( info );
			
			Log.LogMessage( "Value of 2nd field of selected item: " ~ info.Text );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnColumnRightClick( Object sender, Event e )
		{
			ListEvent le = cast(ListEvent)e;
			
			Log.LogMessage( "Right clicked column header " ~ .toString(le.Column) );
		}
	}
	
	//---------------------------------------------------------------------	

	public class ListViewApp : App
	{
		public override bool OnInit()
		{
			ListViewFrame frame = new ListViewFrame("ListView wxWidgets Sample", Point(10, 100), Size(650,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			ListViewApp app = new ListViewApp();
			app.Run();
		}
	}

void main(char[][] argv)
{
	ListViewApp.Main();
}
