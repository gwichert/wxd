//-----------------------------------------------------------------------------
// wx.NET/Samples - ListView.cs
//
// wx.NET "ListView" sample.
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

		public ListViewFrame(string title, Point pos, Size size)
			: base(title, pos, size)
		{
			// Set the window icon and status bar

			Icon = new wx.Icon("../Samples/ListView/mondrian.png");

			CreateStatusBar();
			StatusText = "Welcome to the ListView Sample!";	
			
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
			
			MyListView mlv = new MyListView( this );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( mlv, 1, Stretch.wxGROW );
			bSizer.Add( textCtrl, 0, Stretch.wxGROW );

			Sizer = bSizer;
		}

		//---------------------------------------------------------------------	

		public void OnAbout( object sender, Event e )
		{
			MessageDialog.MessageBox( "wx.NET ListView sample\n2004 by Alexander Olk", "About",
				Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}

		//---------------------------------------------------------------------	

		public void OnQuit( object sender, Event e )
		{
			Close();
		}
	}   
	
	//---------------------------------------------------------------------	
	
	public class MyListView : ListView
	{
		public MyListView( Window parent )
			: base( parent, -1, wxDefaultPosition, wxDefaultSize, ListCtrl.wxLC_REPORT | ListCtrl.wxLC_EDIT_LABELS  )
		{
		
			InsertColumn( 0, "First Column" );
			SetColumnWidth( 0, 200 );
			
			ListItem itemCol = new ListItem();
			itemCol.Text = "Second Column";
			itemCol.Align = ListCtrl.wxLIST_FORMAT_CENTER;
			itemCol.Width = 300;
			InsertColumn( 1, itemCol );
		
			for ( int i = 0; i < 200; ++i )
			{
				string buf = "Col 1 Item " + i;
				int tmp = InsertItem( i, buf, 0);
				SetItemData( tmp, i );
				
				buf = "Col 2 Item " + i;
				SetItem( i, 1, buf );
			}
				
			Log.LogMessage( "Items created..." );
			
			ColumnClick += new EventListener( OnColumnClick );
			ItemSelect += new EventListener( OnItemSelect );
			ColumnRightClick += new EventListener( OnColumnRightClick );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnColumnClick( object sender, Event e )
		{
			ListEvent le = e as ListEvent;
			
			Log.LogMessage( "Clicked column header " + le.Column );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnItemSelect( object sender, Event e )
		{
			ListEvent le = e as ListEvent;
			
			Log.LogMessage( "Value 1st field of selected item: " + le.Text );
			
			ListItem info = new ListItem();
			info.Id = le.Index;
			info.Column = 1;
			info.Mask = ListCtrl.wxLIST_MASK_TEXT;
			
			GetItem( ref info );
			
			Log.LogMessage( "Value of 2nd field of selected item: " + info.Text );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnColumnRightClick( object sender, Event e )
		{
			ListEvent le = e as ListEvent;
			
			Log.LogMessage( "Right clicked column header " + le.Column );
		}
	}
	
	//---------------------------------------------------------------------	

	public class ListViewApp : wx.App
	{
		public override bool OnInit()
		{
			ListViewFrame frame = new ListViewFrame("ListView wxWidgets Sample", new Point(10, 100), new Size(650,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			ListViewApp app = new ListViewApp();
			app.Run();
		}
	}
}
