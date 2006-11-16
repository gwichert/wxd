//-----------------------------------------------------------------------------
// wxD/Samples - Mdi.d
//
// wxD "mdi" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

struct ArrayList /* for .NET compatibility */
{
	Object[] array;

	void Add(Object o)
	{
		array ~= o;
	}
	void Remove(Object o)
	{
		uint i;
		for(i=0;i<array.length;i++) {
			if (array[i]===o) break;
		}
		if (i==array.length) return;
		for(i++;i<array.length;i++) {
			array[i-1] = array[i];
		}
		array.length = array.length-1;
	}
}

	public class MyFrame : MDIParentFrame
	{
		public enum Cmd 
		{ 
		   MDI_NEW_WINDOW = 1, 
		   MDI_QUIT, 
		   MDI_ABOUT
		}
		
		public static int gs_nFrames;
		public static int xpos = -1;
		public static int ypos = -1;		
		
		private TextCtrl textWindow;
		
		public static MyFrame frame = null;

		public static ArrayList my_children;

		//---------------------------------------------------------------------

		public this( Window parent, string title, Point pos, Size size )
		{
			super( parent, -1, title, pos, size );
			icon = new Icon( "../Samples/Mdi/mondrian.png" );

			// Make a menubar
			Menu file_menu = new Menu();

			file_menu.Append( Cmd.MDI_NEW_WINDOW, "&New window\tCtrl-N", "Create a new child window" );
			file_menu.Append( Cmd.MDI_QUIT, "&Exit\tAlt-X", "Quit the program" );

			Menu help_menu = new Menu();
			help_menu.Append( Cmd.MDI_ABOUT, "&About\tF1" );

			MenuBar menu_bar = new MenuBar();

			menu_bar.Append( file_menu, "&File" );
			menu_bar.Append( help_menu, "&Help" );

			this.menuBar = menu_bar;
			
			textWindow = new TextCtrl( this, -1, "A help window", wxDefaultPosition, wxDefaultSize, TextCtrl.wxTE_MULTILINE | TextCtrl.wxSUNKEN_BORDER );
			
			ToolBar toolBar = CreateToolBar(ToolBar.wxTB_FLAT | ToolBar.wxTB_HORIZONTAL);
			InitToolBar(this.toolBar);	

			CreateStatusBar();

			frame = this;
			
			EVT_MENU( Cmd.MDI_ABOUT, & OnAbout ) ;
			EVT_MENU( Cmd.MDI_NEW_WINDOW, & OnNewWindow ) ;
			EVT_MENU( Cmd.MDI_QUIT, & OnQuit ) ;
			 
			EVT_CLOSE( & OnClose ) ;

			EVT_SIZE( & OnSize ) ;
		}

		//---------------------------------------------------------------------
		
		public void OnAbout( Object sender, Event e )
		{
			MessageDialog md = new MessageDialog( this, "wxWidgets 2.0 MDI Demo\nPorted to wxD by Alexander Olk 2004\n", "About MDI Demo" );
			md.ShowModal();
		}

		//---------------------------------------------------------------------
		
		public void OnNewWindow( Object sender, Event e )
		{
			stdout.writeLine( "MyFrame: OnNewWindow");
			MyChild subframe = new MyChild( this, "Canvas Frame", new_Point( -1, -1 ),
					new_Size( -1, -1 ), wxDEFAULT_FRAME_STYLE );

			subframe.Show( true );	
		}

		//---------------------------------------------------------------------

		public void OnQuit( Object sender, Event e )
		{
			stdout.writeLine( "MyFrame: OnQuit" );
			Close();
		}

		//---------------------------------------------------------------------

		public void OnClose( Object sender, Event e )
		{
			stdout.writeLine( "MyFrame: OnClose" );
			CloseEvent ce = cast(CloseEvent) e;
			
			if ( ce.CanVeto && MyFrame.gs_nFrames > 0 )
			{
				string msg = .toString(gs_nFrames) ~ " windows still open, close anyhow?";
				MessageDialog md = new MessageDialog( this, msg, "Please confirm", Dialog.wxICON_QUESTION | Dialog.wxYES_NO );
				if ( md.ShowModal() != wxID_YES )
				{
					ce.Veto();
					return;
				}
			}
			ce.Skip();
		}

		//---------------------------------------------------------------------
		
		public void OnSize( Object sender, Event e )
		{
			Size cs = ClientSize;
			
			textWindow.SetSize( 0, 0, 200, cs.Height );
			GetClientWindow().SetSize( 200, 0, cs.Width - 200, cs.Height );
		}

		//---------------------------------------------------------------------
		
		public void InitToolBar( ToolBar toolBar )
		{
			Bitmap[] bitmaps = new Bitmap[8];
			
			bitmaps[0] = new Bitmap( "../Samples/Mdi/bitmaps/new.xpm" );
			bitmaps[1] = new Bitmap( "../Samples/Mdi/bitmaps/open.xpm" );
			bitmaps[2] = new Bitmap( "../Samples/Mdi/bitmaps/save.xpm" );
			bitmaps[3] = new Bitmap( "../Samples/Mdi/bitmaps/copy.xpm" );
			bitmaps[4] = new Bitmap( "../Samples/Mdi/bitmaps/cut.xpm" );
			bitmaps[5] = new Bitmap( "../Samples/Mdi/bitmaps/paste.xpm" );
			bitmaps[6] = new Bitmap( "../Samples/Mdi/bitmaps/print.xpm" );
			bitmaps[7] = new Bitmap( "../Samples/Mdi/bitmaps/help.xpm" );
			
			int width = 24;
			int currentX = 5;
			
			toolBar.AddTool( Cmd.MDI_NEW_WINDOW, bitmaps[0], Bitmap.wxNullBitmap, false, currentX, -1, null, "New File", "" );
			currentX += width + 5;
			toolBar.AddTool( 100, bitmaps[1], Bitmap.wxNullBitmap, false, currentX, -1, null, "Open file", "" );
			currentX += width + 5;
			toolBar.AddTool( 200, bitmaps[2], Bitmap.wxNullBitmap, false, currentX, -1, null, "Save file", "" );
			currentX += width + 5;
			toolBar.AddTool( 300, bitmaps[3], Bitmap.wxNullBitmap, false, currentX, -1, null, "Copy", "" );
			currentX += width + 5;
			toolBar.AddTool( 400, bitmaps[4], Bitmap.wxNullBitmap, false, currentX, -1, null, "Cut", "" );
			currentX += width + 5;
			toolBar.AddTool( 500, bitmaps[5], Bitmap.wxNullBitmap, false, currentX, -1, null, "Paste", "" );
			currentX += width + 5;
			toolBar.AddTool( 600, bitmaps[6], Bitmap.wxNullBitmap, false, currentX, -1, null, "Print", "" );
			currentX += width + 5;
			toolBar.AddTool( 700, bitmaps[7], Bitmap.wxNullBitmap, false, currentX, -1, null, "Help", "" );
			
			toolBar.Realize();
		}
	}
			
	//---------------------------------------------------------------------
	
	public class MyCanvas : ScrolledWindow
	{
		private bool m_dirty = false;
		private bool drawing = false;
		
		//---------------------------------------------------------------------
		
		public this( Window parent, Point pos, Size size )
		{
			super( parent, -1, pos, size,  /*Border.*/wxSUNKEN_BORDER | wxNO_FULL_REPAINT_ON_RESIZE | wxVSCROLL | wxHSCROLL );
			BackgroundColour = new Colour( "WHITE" );
			
			this.EVT_MOUSE_EVENTS( & OnEvent ) ;
		}
		
		//---------------------------------------------------------------------
		
		public override void OnDraw( DC dc )
		{
			dc.font = Font.wxSWISS_FONT;
			dc.pen = Pen.wxGREEN_PEN;
			
			dc.DrawLine( 0, 0, 200, 200 );
			dc.DrawLine( 200, 0, 0, 200 );
			
			dc.brush = Brush.wxCYAN_BRUSH;
			dc.pen = Pen.wxRED_PEN;
			dc.DrawRectangle( 100, 100, 100, 50 );
			dc.DrawRoundedRectangle( 150, 150, 100, 50, 20 );
			
			dc.DrawEllipse( 250, 250, 100, 50 );
			//dc.DrawSpline( 50, 200, 50, 100, 200, 10 );
			dc.DrawLine( 50, 230, 200, 230 );
			dc.DrawText( "This is a test string", 50, 230 );
			
			Point[] points = new Point[3];
			points[0].X = 200; points[0].Y = 300;
			points[1].X = 100; points[1].Y = 400;
			points[2].X = 300; points[2].Y = 400;
			
			dc.DrawPolygon( 3, points );
			dc.Dispose();
		}
		
		//---------------------------------------------------------------------
		
		public void OnEvent( Object sender, Event e)
		{
			MouseEvent me = cast(MouseEvent) e;

			if ( e.EventType == Event.wxEVT_LEFT_DOWN )
			{
				drawing = true;
			}

			if ( e.EventType == Event.wxEVT_LEFT_UP )
			{
				drawing = false;
			}

			if ( drawing )
			{
				ClientDC dc = new ClientDC( this );
				PrepareDC( dc );
			
				Point pt = me.LogicalPosition( dc );

				if ( MyFrame.xpos > -1 && MyFrame.ypos > -1 && me.Dragging )
				{
					dc.pen = Pen.wxBLACK_PEN;
					dc.DrawLine( MyFrame.xpos, MyFrame.ypos, pt.X, pt.Y );

					m_dirty = true;
				}

				dc.Dispose();
			
				MyFrame.xpos = pt.X;
				MyFrame.ypos = pt.Y;
			}
		}

		//---------------------------------------------------------------------
		
		public bool IsDirty()
		{
			return m_dirty;
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyChild : MDIChildFrame
	{
		enum Cmd { MDI_ABOUT = 100, MDI_QUIT, MDI_NEW_WINDOW, MDI_CHILD_QUIT, MDI_REFRESH, MDI_CHANGE_TITLE, MDI_CHANGE_POSITION, MDI_CHANGE_SIZE }
		
		private MyCanvas canvas = null;
		
		public static string s_title = "Canvas Frame";
		
		//---------------------------------------------------------------------
		
		public this( MDIParentFrame parent, string title, Point pos, Size size, long style )
		{
			super( parent, -1, title, pos, size, style | wxNO_FULL_REPAINT_ON_RESIZE );
			MyFrame.my_children.Add( this );

			icon = new Icon( "../Samples/Mdi/mondrian.png" );
			
			SetSizeHints( 100, 100 );
			
			string atitle = "Canvas Frame " ~ .toString( ++MyFrame.gs_nFrames );
			
			Title = atitle;
			
			Menu file_menu = new Menu();

			file_menu.Append( Cmd.MDI_NEW_WINDOW, "&New window" );
			file_menu.Append( Cmd.MDI_CHILD_QUIT, "&Close child", "Close this window" );
			file_menu.Append( Cmd.MDI_QUIT, "&Exit" );

			Menu option_menu = new Menu();

			option_menu.Append( Cmd.MDI_REFRESH, "&Refresh picture" );
			option_menu.Append( Cmd.MDI_CHANGE_TITLE, "Change &title...\tCtrl-T" );
			option_menu.AppendSeparator();
			option_menu.Append( Cmd.MDI_CHANGE_POSITION, "Move frame\tCtrl-M" );
			option_menu.Append( Cmd.MDI_CHANGE_SIZE, "Resize frame\tCtrl-S" );

			Menu help_menu = new Menu();
			help_menu.Append( Cmd.MDI_ABOUT, "&About" );

			MenuBar menu_bar = new MenuBar();

			menu_bar.Append( file_menu, "&File" );
			menu_bar.Append( option_menu, "&Child" );
			menu_bar.Append( help_menu, "&Help" );

			this.menuBar = menu_bar;

			//CreateStatusBar();
			MyFrame.frame.StatusText = title;

			Size cs = ClientSize;
			canvas = new MyCanvas( this, new_Point( 0, 0 ), new_Size( cs.Width, cs.Height ) );
			canvas.cursor = new Cursor( StockCursor.wxCURSOR_PENCIL );

			canvas.SetScrollbars(20, 20, 50, 50);
			
			EVT_MENU( Cmd.MDI_CHILD_QUIT, & OnQuit ) ;
			EVT_MENU( Cmd.MDI_REFRESH,  & OnRefresh ) ;
			EVT_MENU( Cmd.MDI_CHANGE_TITLE, & OnChangeTitle ) ;
			EVT_MENU( Cmd.MDI_CHANGE_POSITION, & OnChangePosition ) ;
			EVT_MENU( Cmd.MDI_CHANGE_SIZE, & OnChangeSize ) ;
			
			EVT_MENU( Cmd.MDI_NEW_WINDOW, & MyFrame.frame.OnNewWindow ) ;
			EVT_MENU( Cmd.MDI_QUIT, & MyFrame.frame.OnQuit ) ;
			EVT_MENU( Cmd.MDI_ABOUT, & MyFrame.frame.OnAbout ) ;

			EVT_SIZE( & OnSize ) ;
			EVT_MOVE( & OnMove ) ;

			EVT_CLOSE( & OnClose ) ;			
		}

		//---------------------------------------------------------------------
		
		public void OnQuit( Object sender, Event e )
		{
			stdout.writeLine( "MyChild: OnQuit" );
			MyFrame.my_children.Remove( this );
			Close( true );
		}

		//---------------------------------------------------------------------
		
		public void OnRefresh( Object sender, Event e )
		{
			if ( canvas != null ) 
				canvas.Refresh();
		}

		//---------------------------------------------------------------------
		
		public void OnChangeTitle( Object sender, Event e )
		{
			string title = GetTextFromUser( "Enter the new title for MDI child", "MDI sample question", s_title, Parent.Parent );
			
			if ( title.length == 0 )
				return;
				
			s_title = title;
			Title = s_title;
		}

		//---------------------------------------------------------------------
		
		public void OnChangePosition( Object sender, Event e )
		{
			Move( 10, 10, 0 );
		}

		//---------------------------------------------------------------------

		public void OnChangeSize( Object sender, Event e )
		{
			ClientSize = new_Size( 100, 100 );
		}

		//---------------------------------------------------------------------
		
		public void OnSize( Object sender, Event e )
		{
			SizeEvent se = cast(SizeEvent) e;
			Size size1 = se.size;
			Size size2 = size;
			Size size3 = ClientSize;
			
			Log.LogStatus( "size from event: %dx%d, from frame %dx%d, client %dx%d",
					size1.Width, size1.Height, size2.Width, size2.Height, size3.Width, size3.Height );
			se.Skip();
		}

		//---------------------------------------------------------------------
		
		public void OnMove( Object sender, Event e )
		{
			MoveEvent me = cast(MoveEvent) e;
			Point pos1 = me.Position;
			Point pos2 = Position;

			Log.LogStatus( "position from event: ({0}, {1}), from frame ({2}, {3})",
					pos1.X, pos1.Y, pos2.X, pos2.Y );
			
			me.Skip();
		}

		//---------------------------------------------------------------------
		
		public void OnClose( Object sender, Event e )
		{
			stdout.writeLine( "MyChild: OnClose" );
			CloseEvent ce = cast(CloseEvent) e;

			if ( canvas != null && canvas.IsDirty )
			{
				MessageDialog md = new MessageDialog( null, "Really close ?", "Please confirm", 
						Dialog.wxICON_QUESTION | Dialog.wxYES_NO );
				if ( md.ShowModal() != wxID_YES )
				{
					ce.Veto();
					return;
				}
			}
			
			MyFrame.gs_nFrames--;
			
			e.Skip();
		}
	
		//---------------------------------------------------------------------
		
		public override void OnActivate( Object sender, Event e )
		{
			ActivateEvent ae = cast(ActivateEvent) e;
			if ( ae.Active && canvas != null )
				canvas.SetFocus();
		}
	}
	
	//---------------------------------------------------------------------

	public class MDI : App
	{
		public override bool OnInit()
		{
			MyFrame.frame = new MyFrame( null, "MDI Demo", new_Point( -1, -1 ), new_Size( 500, 400 ) );
			MyFrame.frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			MDI app = new MDI();
			app.Run();
		}
	}	


void main()
{
	MDI.Main();
}
