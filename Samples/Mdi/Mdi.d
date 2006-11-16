//-----------------------------------------------------------------------------
// wx.NET/Samples - Mdi.cs
//
// wx.NET "mdi" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Collections;

namespace wx.Samples
{
	public class MyFrame : wx.MDIParentFrame
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

		public static ArrayList my_children = new ArrayList();

		//---------------------------------------------------------------------

		public MyFrame( Window parent, string title, Point pos, Size size )
			: base( parent, -1, title, pos, size )
		{
			Icon = new wx.Icon( "../Samples/Mdi/mondrian.png" );

			// Make a menubar
			Menu file_menu = new Menu();

			file_menu.Append( (int)Cmd.MDI_NEW_WINDOW, "&New window\tCtrl-N", "Create a new child window" );
			file_menu.Append( (int)Cmd.MDI_QUIT, "&Exit\tAlt-X", "Quit the program" );

			Menu help_menu = new Menu();
			help_menu.Append( (int)Cmd.MDI_ABOUT, "&About\tF1" );

			MenuBar menu_bar = new MenuBar();

			menu_bar.Append( file_menu, "&File" );
			menu_bar.Append( help_menu, "&Help" );

			MenuBar = menu_bar;
			
			textWindow = new TextCtrl( this, -1, "A help window", wxDefaultPosition, wxDefaultSize, TextCtrl.wxTE_MULTILINE | TextCtrl.wxSUNKEN_BORDER );
			
			ToolBar toolBar = CreateToolBar(wx.ToolBar.wxTB_FLAT | wx.ToolBar.wxTB_HORIZONTAL);
			InitToolBar(ToolBar);	

			CreateStatusBar();

			frame = this;
			
			EVT_MENU( (int)Cmd.MDI_ABOUT, new EventListener( OnAbout ) );
			EVT_MENU( (int)Cmd.MDI_NEW_WINDOW, new EventListener( OnNewWindow ) );
			EVT_MENU( (int)Cmd.MDI_QUIT, new EventListener( OnQuit ) );
			 
			EVT_CLOSE( new EventListener( OnClose ) );

			EVT_SIZE( new EventListener( OnSize ) );
		}

		//---------------------------------------------------------------------
		
		public void OnAbout( object sender, Event e )
		{
			MessageDialog md = new MessageDialog( this, "wxWidgets 2.0 MDI Demo\nPorted to wx.NET by Alexander Olk 2004\n", "About MDI Demo" );
			md.ShowModal();
		}

		//---------------------------------------------------------------------
		
		public void OnNewWindow( object sender, Event e )
		{
			Console.WriteLine( "MyFrame: OnNewWindow");
			MyChild subframe = new MyChild( this, "Canvas Frame", new Point( -1, -1 ),
					new Size( -1, -1 ), wxDEFAULT_FRAME_STYLE );

			subframe.Show( true );	
		}

		//---------------------------------------------------------------------

		public void OnQuit( object sender, Event e )
		{
			Console.WriteLine( "MyFrame: OnQuit" );
			Close();
		}

		//---------------------------------------------------------------------

		public void OnClose( object sender, Event e )
		{
			Console.WriteLine( "MyFrame: OnClose" );
			CloseEvent ce = (CloseEvent) e;
			
			if ( ce.CanVeto && MyFrame.gs_nFrames > 0 )
			{
				string msg = gs_nFrames + " windows still open, close anyhow?";
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
		
		public void OnSize( object sender, Event e )
		{
			Size cs = ClientSize;
			
			textWindow.SetSize( 0, 0, 200, cs.Height );
			GetClientWindow().SetSize( 200, 0, cs.Width - 200, cs.Height );
		}

		//---------------------------------------------------------------------
		
		public void InitToolBar( ToolBar toolBar )
		{
			wx.Bitmap[] bitmaps = new wx.Bitmap[8];
			
			bitmaps[0] = new wx.Bitmap();
			bitmaps[0].LoadFile( "../Samples/Mdi/bitmaps/new.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			bitmaps[1] = new wx.Bitmap();
			bitmaps[1].LoadFile( "../Samples/Mdi/bitmaps/open.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			bitmaps[2] = new wx.Bitmap();
			bitmaps[2].LoadFile( "../Samples/Mdi/bitmaps/save.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			bitmaps[3] = new wx.Bitmap();
			bitmaps[3].LoadFile( "../Samples/Mdi/bitmaps/copy.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			bitmaps[4] = new wx.Bitmap();
			bitmaps[4].LoadFile( "../Samples/Mdi/bitmaps/cut.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			bitmaps[5] = new wx.Bitmap();
			bitmaps[5].LoadFile( "../Samples/Mdi/bitmaps/paste.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			bitmaps[6] = new wx.Bitmap();
			bitmaps[6].LoadFile( "../Samples/Mdi/bitmaps/print.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			bitmaps[7] = new wx.Bitmap();
			bitmaps[7].LoadFile( "../Samples/Mdi/bitmaps/help.xpm", BitmapType.wxBITMAP_TYPE_XPM );
			
			int width = 24;
			int currentX = 5;
			
			toolBar.AddTool( (int)Cmd.MDI_NEW_WINDOW, bitmaps[0], NullObjects.wxNullBitmap, false, currentX, -1, null, "New File", "" );
			currentX += width + 5;
			toolBar.AddTool( 100, bitmaps[1], NullObjects.wxNullBitmap, false, currentX, -1, null, "Open file", "" );
			currentX += width + 5;
			toolBar.AddTool( 200, bitmaps[2], NullObjects.wxNullBitmap, false, currentX, -1, null, "Save file", "" );
			currentX += width + 5;
			toolBar.AddTool( 300, bitmaps[3], NullObjects.wxNullBitmap, false, currentX, -1, null, "Copy", "" );
			currentX += width + 5;
			toolBar.AddTool( 400, bitmaps[4], NullObjects.wxNullBitmap, false, currentX, -1, null, "Cut", "" );
			currentX += width + 5;
			toolBar.AddTool( 500, bitmaps[5], NullObjects.wxNullBitmap, false, currentX, -1, null, "Paste", "" );
			currentX += width + 5;
			toolBar.AddTool( 600, bitmaps[6], NullObjects.wxNullBitmap, false, currentX, -1, null, "Print", "" );
			currentX += width + 5;
			toolBar.AddTool( 700, bitmaps[7], NullObjects.wxNullBitmap, false, currentX, -1, null, "Help", "" );
			
			toolBar.Realize();
		}
	}
			
	//---------------------------------------------------------------------
	
	public class MyCanvas : ScrolledWindow
	{
		private bool m_dirty = false;
		private bool drawing = false;
		
		//---------------------------------------------------------------------
		
		public MyCanvas( Window parent, Point pos, Size size )
			: base( parent, -1, pos, size,  /*Border.*/wxSUNKEN_BORDER | wxNO_FULL_REPAINT_ON_RESIZE | wxVSCROLL | wxHSCROLL )
		{
			BackgroundColour = new Colour( "WHITE" );
			
			this.EVT_MOUSE_EVENTS( new EventListener( OnEvent ) );
		}
		
		//---------------------------------------------------------------------
		
		public override void OnDraw( DC dc )
		{
			dc.Font = Font.wxSWISS_FONT;
			dc.Pen = GDIPens.wxGREEN_PEN;
			
			dc.DrawLine( 0, 0, 200, 200 );
			dc.DrawLine( 200, 0, 0, 200 );
			
			dc.Brush = GDIBrushes.wxCYAN_BRUSH;
			dc.Pen = GDIPens.wxRED_PEN;
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
		
		public void OnEvent( object sender, Event e)
		{
			MouseEvent me = (MouseEvent) e;

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
					dc.Pen = GDIPens.wxBLACK_PEN;
					dc.DrawLine( MyFrame.xpos, MyFrame.ypos, pt.X, pt.Y );

					m_dirty = true;
				}

				dc.Dispose();
			
				MyFrame.xpos = pt.X;
				MyFrame.ypos = pt.Y;
			}
		}

		//---------------------------------------------------------------------
		
		public bool IsDirty
		{
			get { return m_dirty; }
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyChild : MDIChildFrame
	{
		enum Cmd { MDI_ABOUT = 100, MDI_QUIT, MDI_NEW_WINDOW, MDI_CHILD_QUIT, MDI_REFRESH, MDI_CHANGE_TITLE, MDI_CHANGE_POSITION, MDI_CHANGE_SIZE }
		
		private MyCanvas canvas = null;
		
		public static string s_title = "Canvas Frame";
		
		//---------------------------------------------------------------------
		
		public MyChild( MDIParentFrame parent, string title, Point pos, Size size, long style )
			: base( parent, -1, title, pos, size, style | wxNO_FULL_REPAINT_ON_RESIZE )
		{
			MyFrame.my_children.Add( this );

			Icon = new wx.Icon( "../Samples/Mdi/mondrian.png" );
			
			SetSizeHints( 100, 100 );
			
			string atitle = "Canvas Frame " + ( ++MyFrame.gs_nFrames );
			
			Title = atitle;
			
			Menu file_menu = new Menu();

			file_menu.Append( (int)Cmd.MDI_NEW_WINDOW, "&New window" );
			file_menu.Append( (int)Cmd.MDI_CHILD_QUIT, "&Close child", "Close this window" );
			file_menu.Append( (int)Cmd.MDI_QUIT, "&Exit" );

			Menu option_menu = new Menu();

			option_menu.Append( (int)Cmd.MDI_REFRESH, "&Refresh picture" );
			option_menu.Append( (int)Cmd.MDI_CHANGE_TITLE, "Change &title...\tCtrl-T" );
			option_menu.AppendSeparator();
			option_menu.Append( (int)Cmd.MDI_CHANGE_POSITION, "Move frame\tCtrl-M" );
			option_menu.Append( (int)Cmd.MDI_CHANGE_SIZE, "Resize frame\tCtrl-S" );

			Menu help_menu = new Menu();
			help_menu.Append( (int)Cmd.MDI_ABOUT, "&About" );

			MenuBar menu_bar = new MenuBar();

			menu_bar.Append( file_menu, "&File" );
			menu_bar.Append( option_menu, "&Child" );
			menu_bar.Append( help_menu, "&Help" );

			MenuBar = menu_bar;

			//CreateStatusBar();
			MyFrame.frame.StatusText = title;

			Size cs = ClientSize;
			canvas = new MyCanvas( this, new Point( 0, 0 ), new Size( cs.Width, cs.Height ) );
			canvas.Cursor = new Cursor( StockCursor.wxCURSOR_PENCIL );

			canvas.SetScrollbars(20, 20, 50, 50);
			
			EVT_MENU( (int)Cmd.MDI_CHILD_QUIT, new EventListener( OnQuit ) );
			EVT_MENU( (int)Cmd.MDI_REFRESH,  new EventListener( OnRefresh ) );
			EVT_MENU( (int)Cmd.MDI_CHANGE_TITLE, new EventListener( OnChangeTitle ) );
			EVT_MENU( (int)Cmd.MDI_CHANGE_POSITION, new EventListener( OnChangePosition ) );
			EVT_MENU( (int)Cmd.MDI_CHANGE_SIZE, new EventListener( OnChangeSize ) );
			
			EVT_MENU( (int)Cmd.MDI_NEW_WINDOW, new EventListener( MyFrame.frame.OnNewWindow ) );
			EVT_MENU( (int)Cmd.MDI_QUIT, new EventListener( MyFrame.frame.OnQuit ) );
			EVT_MENU( (int)Cmd.MDI_ABOUT, new EventListener( MyFrame.frame.OnAbout ) );

			EVT_SIZE( new EventListener( OnSize ) );
			EVT_MOVE( new EventListener( OnMove ) );

			EVT_CLOSE( new EventListener( OnClose ) );			
		}

		//---------------------------------------------------------------------
		
		public void OnQuit( object sender, Event e )
		{
			Console.WriteLine( "MyChild: OnQuit" );
			MyFrame.my_children.Remove( this );
			Close( true );
		}

		//---------------------------------------------------------------------
		
		public void OnRefresh( object sender, Event e )
		{
			if ( canvas != null ) 
				canvas.Refresh();
		}

		//---------------------------------------------------------------------
		
		public void OnChangeTitle( object sender, Event e )
		{
			string title = new GetTextFromUser( "Enter the new title for MDI child", "MDI sample question", s_title, Parent.Parent );
			
			if ( title.Length == 0 )
				return;
				
			s_title = title;
			Title = s_title;
		}

		//---------------------------------------------------------------------
		
		public void OnChangePosition( object sender, Event e )
		{
			Move( 10, 10, 0 );
		}

		//---------------------------------------------------------------------

		public void OnChangeSize( object sender, Event e )
		{
			ClientSize = new Size( 100, 100 );
		}

		//---------------------------------------------------------------------
		
		public void OnSize( object sender, Event e )
		{
			SizeEvent se = (SizeEvent) e;
			Size size1 = se.Size;
			Size size2 = Size;
			Size size3 = ClientSize;
			
			Log.LogStatus( "size from event: {0}x{1}, from frame {2}x{3}, client {4}x{5}",
					size1.Width, size1.Height, size2.Width, size2.Height, size3.Width, size3.Height );
			se.Skip();
		}

		//---------------------------------------------------------------------
		
		public void OnMove( object sender, Event e )
		{
			MoveEvent me = (MoveEvent) e;
			Point pos1 = me.Position;
			Point pos2 = Position;

			Log.LogStatus( "position from event: ({0}, {1}), from frame ({2}, {3})",
					pos1.X, pos1.Y, pos2.X, pos2.Y );
			
			me.Skip();
		}

		//---------------------------------------------------------------------
		
		public void OnClose( object sender, Event e )
		{
			Console.WriteLine( "MyChild: OnClose" );
			CloseEvent ce = (CloseEvent) e;

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
		
		public override void OnActivate( object sender, Event e )
		{
			ActivateEvent ae = (ActivateEvent) e;
			if ( ae.Active && canvas != null )
				canvas.SetFocus();
		}
	}
	
	//---------------------------------------------------------------------

	public class MDI : wx.App
	{
		public override bool OnInit()
		{
			MyFrame.frame = new MyFrame( null, "MDI Demo", new Point( -1, -1 ), new Size( 500, 400 ) );
			MyFrame.frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			MDI app = new MDI();
			app.Run();
		}
	}	
}
