//-----------------------------------------------------------------------------
// wx.NET/Samples - Dbgrid.cs
//
// wx.NET "dbgrid" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Data;
using System.Data.Odbc;
using wx.DataAccess;

namespace wx.Samples
{ 
	public class MyDbGrid : DbGrid
	{
		private MyFrame myFrame;
		
		//---------------------------------------------------------------------
		
		public MyDbGrid(MyFrame parent, int id, Point pos, Size size)
			: base(parent, id, pos, size)
		{
			myFrame = parent;  
			
			EVT_GRID_CELL_LEFT_CLICK(new EventListener(OnGridCellLeftClick));		
		}
		
		//---------------------------------------------------------------------
		
		public void OnGridCellLeftClick(object sender, Event e)
		{
			GridEvent ge = (GridEvent) e;
			DataRow dr = GetRow(ge.Row);
			
			myFrame.NameText = dr["name"].ToString();
			myFrame.StreetText = dr["street"].ToString();
			myFrame.CityText = dr["city"].ToString();
			myFrame.IdText = dr["id"].ToString();		

			e.Skip();
		}
	}
	
	//---------------------------------------------------------------------

	public class MyFrame : wx.Frame
	{
		enum Cmd { About, Quit, Save, Row }
		
		private OdbcConnection dbcon = null;
		private OdbcDataAdapter dbadapter = null;
		private MyDbGrid grid = null;
		private DbGrid grid2 = null;
		
		private TextCtrl name_text = null;
		private TextCtrl street_text = null;
		private TextCtrl city_text = null;
		private TextCtrl id_text = null;
		
		public static bool globalError = false;
		
		public static string DSNstring = "";
		public static string UIDstring = "";
		public static string DATABASEstring = "";

		//---------------------------------------------------------------------

		public MyFrame(string title, Point pos, Size size)
			: base(title, pos, size)
		{
			// Set the window icon 

			Icon = new wx.Icon("../Samples/DbGrid/mondrian.png");

			// Set up a menu

			wx.Menu fileMenu = new wx.Menu();
			fileMenu.Append((int)Cmd.Quit, "E&xit\tAlt-X", "Quit this program");

			wx.Menu helpMenu = new wx.Menu();
			helpMenu.Append((int)Cmd.About, "&About...\tF1", "Show about dialog");

			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append(fileMenu, "&File");
			menuBar.Append(helpMenu, "&Help");

			MenuBar = menuBar;
			
			BoxSizer new_main_sizer = new BoxSizer( Orientation.wxHORIZONTAL );
			
			BoxSizer main_sizer = new BoxSizer( Orientation.wxVERTICAL );
			
			main_sizer.Add( new StaticText( this, -1, "MyDbGrid"), 0, Direction.wxALL, 5 );
			
			grid = new MyDbGrid( this, -1, wxDefaultPosition, new Size(580,200) );			
			
			BoxSizer helpSizer = new BoxSizer( Orientation.wxHORIZONTAL );
			helpSizer.Add(grid, 1, Direction.wxALL | Stretch.wxEXPAND, 5 );
			helpSizer.Add(0, 200, 0, 0, 0 );
			main_sizer.Add( helpSizer, 1, Direction.wxALL, 5);
			
			main_sizer.Add( new StaticLine( this, -1, wxDefaultPosition, wxDefaultSize, StaticLine.wxLI_HORIZONTAL ), 0, Stretch.wxEXPAND | Direction.wxALL, 5 );
			main_sizer.Add( new StaticText( this, -1, "Second DbGrid CreateGridFromColumnMapping (does nothing, shows only creation with this method)"), 0, Direction.wxALL, 5 );
			
			grid2 = new DbGrid(this, -1, wxDefaultPosition, new Size(580,200));
			
			BoxSizer helpSizer2 = new BoxSizer( Orientation.wxHORIZONTAL );
			helpSizer2.Add(grid2, 1, Direction.wxALL | Stretch.wxEXPAND, 5 );
			helpSizer2.Add(0, 200, 0, 0, 0 );
			main_sizer.Add( helpSizer2, 1, Direction.wxALL, 5);
			
			new_main_sizer.Add(main_sizer, 0, Direction.wxALL, 0);
			
			FlexGridSizer fgs = new FlexGridSizer( 5, 2, 5, 5 );
			
			fgs.Add( new StaticText( this, -1, "Name:" ), 0, Direction.wxALL | Alignment.wxALIGN_RIGHT, 2 );
			
			name_text = new TextCtrl( this, -1, "", wxDefaultPosition, new Size( 100, 21 ) );
			fgs.Add( name_text, 0, Direction.wxALL | Alignment.wxALIGN_LEFT, 2);
			
			fgs.Add( new StaticText( this, -1, "Street:" ), 0, Direction.wxALL | Alignment.wxALIGN_RIGHT, 2 );
			
			street_text = new TextCtrl( this, -1, "", wxDefaultPosition, new Size( 100, 21 ) );
			fgs.Add( street_text, 0, Direction.wxALL | Alignment.wxALIGN_LEFT, 2);
			
			fgs.Add( new StaticText( this, -1, "City:" ), 0, Direction.wxALL | Alignment.wxALIGN_RIGHT, 2 );
			
			city_text = new TextCtrl( this, -1, "", wxDefaultPosition, new Size( 100, 21 ) );
			fgs.Add( city_text, 0, Direction.wxALL | Alignment.wxALIGN_LEFT, 2);
			
			fgs.Add( new StaticText( this, -1, "ID:" ), 0, Direction.wxALL | Alignment.wxALIGN_RIGHT, 2 );
			
			id_text = new TextCtrl( this, -1, "", wxDefaultPosition, new Size( 100, 21 ) );
			fgs.Add( id_text, 0, Direction.wxALL | Alignment.wxALIGN_LEFT, 2);		

			fgs.Add( new Button(this, (int)Cmd.Save, "Save"), 0, Direction.wxALL, 2 );
			fgs.Add( new Button(this, (int)Cmd.Row, "New Row"), 0, Direction.wxALL, 2 );
			
			new_main_sizer.Add( new StaticLine( this, -1, wxDefaultPosition, wxDefaultSize, StaticLine.wxLI_VERTICAL ), 0, Stretch.wxEXPAND | Direction.wxALL, 5 );			
			new_main_sizer.Add(fgs, 0, Direction.wxALL, 5);
			
			AutoLayout = true;
			SetSizer( new_main_sizer, true );
			new_main_sizer.Fit( this );
			new_main_sizer.SetSizeHints( this );

			// Set up a status bar

			CreateStatusBar(2);
			StatusText = "Welcome to wxWidgets!";
			
			UserDialog ud = new UserDialog( null, -1, "Enter database strings..." );
			ud.Center();
			int retval = ud.ShowModal();

			if ( retval == 0 )
			{
				globalError = true;
			}
			else
				SetupDatabase();

			// Set up the event table

			EVT_MENU((int)Cmd.Quit,    new EventListener(OnQuit));
			EVT_MENU((int)Cmd.About,   new EventListener(OnAbout));
			EVT_BUTTON((int)Cmd.Save, new EventListener(OnSave));
			EVT_BUTTON((int)Cmd.Row, new EventListener(OnNewRow));
			EVT_CLOSE( new EventListener( OnClose ) );
		} 
		
		//---------------------------------------------------------------------
		
		public void SetupDatabase()
		{
			// Set up Odbc and DbGrid
			
			dbcon = new OdbcConnection();
			
			dbcon.ConnectionString ="DSN=" + DSNstring + ";UID=" + UIDstring + ";DATABASE=" + DATABASEstring;
			
			try
			{
				dbcon.Open();
			} 
			catch ( DllNotFoundException ex )
			{
				string tmps = ex.ToString();
				if ( tmps.IndexOf( "odbc32" ) != -1 )
				{
					string msg = "Couldn't find lib odbc32.\n\n" +
						"When you are using Linux please make a link in /usr/lib or /usr/local/lib to your libodbc.so\n\n" +
						"For example: ln -s libodbc.so.1 libodbc32.so";
					MessageDialog.MessageBox( msg, "Error...", Dialog.wxOK | Dialog.wxICON_INFORMATION );
					globalError = true;
				}
			}
			catch ( System.Data.Odbc.OdbcException oex )
			{
				string msg = "Couldn't open database \"" + DATABASEstring + "\"\n\n" +
					"Did you choose the correct DSN, DATABASE and UID values ?\n" +
					"Are your odbc settings correct ?\n\n" + 
					"Did you create a database \"" + DATABASEstring + "\" with a table \"testtable\" ?\n\n" +
					"If not, create one with the following create command:\n\n" +
					"CREATE TABLE testtable(\n" + 
					"	id	VARCHAR(19),\n" +
					"	name VARCHAR(200),\n" +
					"	street VARCHAR(200),\n" +
					"	city VARCHAR(200)\n" +
					");";
				
				MessageDialog.MessageBox( msg, "Error...", Dialog.wxOK | Dialog.wxICON_INFORMATION );
				globalError = true;
			}
			
			if ( ! globalError )
			{
				dbadapter = new OdbcDataAdapter("SELECT * FROM testtable order by id", dbcon);			
										
				dbadapter.Fill(grid.dataSet, "testtable");
				dbadapter.Fill(grid2.dataSet, "testtable");
						
				// do the mapping before CreateGrid
				// db columnname, new columnname, optional columnwidth
				grid.AddColumnMapping("id", "ID", 40);						
				grid.AddColumnMapping("name", "Name", 120);
				grid.AddColumnMapping("street", "Street",120);
				grid.AddColumnMapping("city", "City", 120);
				
				grid.CreateGridFromDataSet("testtable");  // creates grid with the data in grid.dataSet
	
				grid2.AddColumnMapping("city", "City", 120);
				grid2.AddColumnMapping("street", "Street",120);			
				//grid2.AddColumnMapping("id", "ID", 40);						
				grid2.AddColumnMapping("name", "Name", 120);
				
				grid2.CreateGridFromColumnMapping("testtable");  // creates grid with the data in grid.dataSet
				
				DataRow dr = grid.GetRow(0);
				
				if ( dr != null )
				{
					name_text.Value = dr["name"].ToString();
					street_text.Value = dr["street"].ToString();
					city_text.Value = dr["city"].ToString();
					id_text.Value = dr["id"].ToString();
				}
			}
		}
		
		//---------------------------------------------------------------------
		
		public string NameText
		{
			set { name_text.Value = value; }
		}
		
		//---------------------------------------------------------------------
		
		public string StreetText
		{
			set { street_text.Value = value; }
		}
		
		//---------------------------------------------------------------------
		
		public string CityText
		{
			set { city_text.Value = value; }
		}
		
		//---------------------------------------------------------------------
		
		public string IdText
		{
			set { id_text.Value = value; }
		}
		
		//---------------------------------------------------------------------

		public void OnQuit(object sender, wx.Event e)
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnClose( object sender, Event e )
		{
			try
			{
				dbcon.Close();
			}
			catch ( Exception ex )
			{
				Console.WriteLine( "DBConnection allready closed." );
			}
		}

		//---------------------------------------------------------------------

		public void OnAbout(object sender, wx.Event e)
		{
			string msg = "This is the About dialog of the DbGrid sample.";
			wx.MessageDialog.ShowModal(this, msg, "About DbGrid", Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------
		
		public void OnSave(object sender, Event e)
		{
			DataSet ds = grid.dataSet.GetChanges();
			if (ds == null ) return;
			
			DataTable table = ds.Tables["testtable"];
			
			foreach (DataRow row in table.Rows) {
			
				int i = 0;
				string[]  parm = new string[4];
				
				foreach (DataColumn col in table.Columns) {
					parm[i]=row[col].ToString();
					i++;
				}
				
				string dbstring = "";
				
				switch (row.RowState)
				{
					case DataRowState.Added:
						dbstring = "INSERT INTO testtable(id, name, street, city) " +
								"VALUES ( '"+parm[0]+"', '"+parm[1]+"', '"+parm[2]+"', '"+parm[3]+"')";
					break;
					
					case DataRowState.Modified:
						dbstring = "UPDATE testtable SET "+
								"name = '"+parm[1]+"', street = '"+parm[2]+"', city = '"+parm[3]+"' WHERE id = '"+parm[0]+"'";
					break;
				}
				
				if (dbstring.Length > 0)
				{
					OdbcCommand updatecmd = new OdbcCommand(dbstring, dbcon);
					try
					{
						updatecmd.ExecuteNonQuery();
					} 
					catch (Exception ex)
					{
						MessageDialog.ShowModal(this, ex.ToString(), "Error", Dialog.wxOK | Dialog.wxICON_ERROR);						
					}
					grid.dataSet.AcceptChanges();
				}
			}
		}		

		//---------------------------------------------------------------------

		public void OnNewRow(object sender, Event e)
		{
				grid.AddRow(); 
		}
	}
	
	//---------------------------------------------------------------------
	
	public class UserDialog : Dialog
	{
		// Do not change the code between region and endregion ( incl. region and endregion )...
		#region "TowxNET IDS: UserDialog"
		public enum Cmd {
			ID_BUTTON_OK,
			ID_BUTON_CANCEL
		}
		#endregion
 
		//---------------------------------------------------------------------
 
		// Do not change the code between region and endregion ( incl. region and endregion )...
		#region "TowxNET Objects: UserDialog"
		protected BoxSizer sizer_1;
		protected FlexGridSizer grid_sizer_1;
		protected StaticText label_1;
		protected TextCtrl text_ctrl_1;
		protected StaticText label_2;
		protected TextCtrl text_ctrl_2;
		protected StaticText label_3;
		protected TextCtrl text_ctrl_3;
		protected StaticLine static_line_1;
		protected BoxSizer sizer_2;
		protected Button okButton;
		protected Button cancelButton;
		#endregion
		
		private int modalRetval = 0;
 
		//---------------------------------------------------------------------
 
		public UserDialog( Window parent, int id, string title )
			: base( parent, id , "Enter database strings...", wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE )
		{
			InitializeComponent();
			
			okButton.Click += new EventListener( OnButton );
			cancelButton.Click += new EventListener( OnButton );
		}
 
		//---------------------------------------------------------------------
 
		// Do not change the code between region and endregion ( incl. region and endregion )...
		#region "TowxNET CTOR: UserDialog"
		public void InitializeComponent()
		{
			//common
			label_1 = new StaticText( this, -1, "DSN:" );
			text_ctrl_1 = new TextCtrl( this, -1, "test" );
			label_2 = new StaticText( this, -1, "UID:" );
			text_ctrl_2 = new TextCtrl( this, -1, "alex" );
			label_3 = new StaticText( this, -1, "DATABASE:" );
			text_ctrl_3 = new TextCtrl( this, -1, "test" );
			static_line_1 = new StaticLine( this, -1 );
			okButton = new Button( this, (int)Cmd.ID_BUTTON_OK, "OK", wxDefaultPosition, wxDefaultSize, 0 );
			cancelButton = new Button( this, (int)Cmd.ID_BUTON_CANCEL, "Cancel", wxDefaultPosition, wxDefaultSize, 0 );
 
			//Properties
			Title = "Enter database strings...";
			text_ctrl_1.SetSize( 150, 22 );
			text_ctrl_1.SetFocus();
			text_ctrl_2.SetSize( 150, 22 );
			text_ctrl_3.SetSize( 150, 22 );
			okButton.SetDefault();
 
			//Layout
 
			grid_sizer_1 = new FlexGridSizer( 3, 2, 0, 0 );
			grid_sizer_1.Add( label_1, 0, wx.Direction.wxALL|wx.Alignment.wxALIGN_RIGHT|wx.Alignment.wxALIGN_CENTER_VERTICAL, 5 );
			grid_sizer_1.Add( text_ctrl_1, 0, wx.Direction.wxALL, 5 );
			grid_sizer_1.Add( label_2, 0, wx.Direction.wxALL|wx.Alignment.wxALIGN_RIGHT|wx.Alignment.wxALIGN_CENTER_VERTICAL, 5 );
			grid_sizer_1.Add( text_ctrl_2, 0, wx.Direction.wxALL, 5 );
			grid_sizer_1.Add( label_3, 0, wx.Direction.wxALL|wx.Alignment.wxALIGN_RIGHT|wx.Alignment.wxALIGN_CENTER_VERTICAL, 5 );
			grid_sizer_1.Add( text_ctrl_3, 0, wx.Direction.wxALL, 5 );
 
			sizer_2 = new BoxSizer( Orientation.wxHORIZONTAL );
			sizer_2.Add( 10, 20, 1, wx.Stretch.wxEXPAND, 0 );
			sizer_2.Add( okButton, 0, wx.Direction.wxALL, 5 );
			sizer_2.Add( cancelButton, 0, wx.Direction.wxALL, 5 );
 
			sizer_1 = new BoxSizer( Orientation.wxVERTICAL );
			sizer_1.Add( grid_sizer_1, 1, wx.Stretch.wxEXPAND, 0 );
			sizer_1.Add( static_line_1, 0, wx.Stretch.wxEXPAND, 0 );
			sizer_1.Add( sizer_2, 0, wx.Stretch.wxEXPAND, 0 );
			sizer_1.Fit( this );
			sizer_1.SetSizeHints( this );
			AutoLayout = true;
			SetSizer( sizer_1 );
			Layout();
		}
		#endregion
		
		//---------------------------------------------------------------------
		
		public void OnButton( object sender, Event e )
		{
			if ( e.ID == (int)Cmd.ID_BUTTON_OK )
				modalRetval = 1;
				
			MyFrame.DSNstring = text_ctrl_1.Value;
			MyFrame.UIDstring = text_ctrl_2.Value;
			MyFrame.DATABASEstring = text_ctrl_3.Value;
				
			EndModal( modalRetval );
		}
	}
	
	//---------------------------------------------------------------------

	public class DBGRID : wx.App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("DbGrid wxWidgets App", new Point(50,50), new Size(700,400));
			
			if ( MyFrame.globalError ) return false;
			
			frame.Show(true);

			return true;
		}
		
		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			DBGRID app = new DBGRID();
			app.Run();
		}
	}
}
