//-----------------------------------------------------------------------------
// wxD/Samples - HtmlListBox.d
//
// wxD "HtmlListBox" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
import std.string;

	public class MyHtmlListBox : HtmlListBox
	{
		//---------------------------------------------------------------------
		
		protected bool m_change;
		
		//---------------------------------------------------------------------
		
		public this( Window parent )
			{ this( parent, false ); }
			
		public this( Window parent, bool multi )
		{
			super( parent, -1, wxDefaultPosition, wxDefaultSize, multi ? ListBox.wxLB_MULTIPLE : 0 );
			m_change = true;
			
			SetMargins( 5, 5 );
			
			ItemCount = 1000;
			
			Selection = 3;			
		}
		
		//---------------------------------------------------------------------
		
		public void ChangeSelFg(bool value)
		{
			m_change = value;
		}
		
		//---------------------------------------------------------------------
		
		private static char[] tohex(ubyte value) {
			char buf[2];
			buf[0] = hexdigits[value/16];
			buf[1] = hexdigits[value%16];
			return buf.dup;
		}
		
		private static uint abs(int value) { return value<0?-value:value; }
		
		protected override string OnGetItem( int n )
		{
			int level = ( n % 6 ) + 1;
		
			return std.string.format("<h%d><font color=#%02x%02x%02x>Item</font> <b>%u</b></h%d>",
				level,
				abs(n - 192) % 256,
				abs(n - 256) % 256,
				abs(n - 128) % 256,
				n,level
			);
		}
		
		//---------------------------------------------------------------------
		
		protected override void OnDrawSeparator( DC dc, Rectangle rect, int n )   
		{	
			MyFrame mp = cast(MyFrame)Parent;
			
			if ( mp.menuBar.IsChecked( MyFrame.Cmd.HtmlLbox_DrawSeparator ) )
			{
				dc.pen = Pen.wxBLACK_DASHED_PEN;
				dc.DrawLine( rect.X, rect.Y, rect.Right - 1, rect.Y );
				dc.DrawLine( rect.X, rect.Bottom - 1, rect.Right - 1, rect.Bottom - 1 );
			}
			
		}
		
		//---------------------------------------------------------------------
		
		protected override Colour GetSelectedTextColour( Colour colFg )
		{
			return m_change ? super.GetSelectedTextColour( colFg ) : colFg;
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyFrame : Frame
	{
		public enum Cmd { HtmlLbox_Quit,
			HtmlLbox_SetMargins,
			HtmlLbox_DrawSeparator,
			HtmlLbox_ToggleMulti,
			HtmlLbox_SelectAll,

			HtmlLbox_SetBgCol,
			HtmlLbox_SetSelBgCol,
			HtmlLbox_SetSelFgCol,

			HtmlLbox_About = wxID_ABOUT }
		
		//---------------------------------------------------------------------
		
		private MyHtmlListBox m_hlbox;
		
		//---------------------------------------------------------------------
		
		public this( Window parent, string title, Point pos, Size size ) 
		{
			super( parent, -1, title, pos, size );
			icon = new Icon( "../Samples/HtmlListBox/mondrian.png" );
			
			Menu menuFile = new Menu();
			menuFile.Append( Cmd.HtmlLbox_Quit, "E&xit\tAlt-X", "Quit this program" );
			
			Menu menuHLbox = new Menu();
			menuHLbox.Append( Cmd.HtmlLbox_SetMargins, "Set &margins...\tCtrl-G", "Change the margins around the items" );
			menuHLbox.AppendCheckItem( Cmd.HtmlLbox_DrawSeparator, "&Draw separators\tCtrl-D", "Toggle drawing separators between cells" );
			menuHLbox.AppendSeparator();
			menuHLbox.AppendCheckItem( Cmd.HtmlLbox_ToggleMulti, "&Multiple selection\tCtrl-M", "Toggle multiple selection on/off" );
			menuHLbox.AppendSeparator();
			menuHLbox.Append( Cmd.HtmlLbox_SelectAll, "Select &all items\tCtrl-A" );
			menuHLbox.AppendSeparator();
			menuHLbox.Append( Cmd.HtmlLbox_SetBgCol, "Set &background...\tCtrl-B" );
			menuHLbox.Append( Cmd.HtmlLbox_SetSelBgCol, "Set &selection background...\tCtrl-S" );
			menuHLbox.AppendCheckItem( Cmd.HtmlLbox_SetSelFgCol, "Keep &foreground in selection\tCtrl-F" );
			
			Menu helpMenu = new Menu();
			helpMenu.Append( Cmd.HtmlLbox_About, "&About...\tF1", "Show about dialog" );
			
			MenuBar menuBar = new MenuBar();
			menuBar.Append( menuFile, "&File" );
			menuBar.Append( menuHLbox, "&Listbox" );
			menuBar.Append( helpMenu, "&Help" );
			
			menuBar.Check( Cmd.HtmlLbox_DrawSeparator, true );
			
			this.menuBar = menuBar;
			
			CreateStatusBar( 2 );
			StatusText = "Welcome to wxWidgets!";
			
			m_hlbox = new MyHtmlListBox( this );
			TextCtrl text = new TextCtrl( this, -1, "", wxDefaultPosition, wxDefaultSize, TextCtrl.wxTE_MULTILINE );
			
			Log.SetActiveTarget( text ); 
			
			BoxSizer sizer = new BoxSizer( Orientation.wxHORIZONTAL );
			sizer.Add( m_hlbox, 1, Stretch.wxGROW );
			sizer.Add( text, 1, Stretch.wxGROW );
			
			this.sizer = sizer;
			
			EVT_MENU( Cmd.HtmlLbox_Quit,  & OnQuit ) ;
			EVT_MENU( Cmd.HtmlLbox_SetMargins,  & OnSetMargins ) ;
			EVT_MENU( Cmd.HtmlLbox_DrawSeparator, & OnDrawSeparator ) ;
			EVT_MENU( Cmd.HtmlLbox_ToggleMulti, & OnToggleMulti ) ;
			EVT_MENU( Cmd.HtmlLbox_SelectAll, & OnSelectAll ) ;

			EVT_MENU( Cmd.HtmlLbox_About, & OnAbout ) ;

			EVT_MENU( Cmd.HtmlLbox_SetBgCol, & OnSetBgCol ) ;
			EVT_MENU( Cmd.HtmlLbox_SetSelBgCol, & OnSetSelBgCol ) ;
			EVT_MENU( Cmd.HtmlLbox_SetSelFgCol, & OnSetSelFgCol ) ;

			EVT_UPDATE_UI( Cmd.HtmlLbox_SelectAll, & OnUpdateUISelectAll ) ;


			EVT_LISTBOX( wxID_ANY, & OnLboxSelect ) ;
			EVT_LISTBOX_DCLICK( wxID_ANY, & OnLboxDClick ) ;
		}
		
		//---------------------------------------------------------------------
		
		public void OnQuit( Object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnAbout( Object sender, Event e )
		{
			MessageBox( this, "This sample shows wxHtmlListBox class.\n" 
				"\n" 
				"(c) 2003 Vadim Zeitlin\n" 
				"Ported to wxD by BERO", "About HtmlLbox", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetMargins( Object sender, Event e )
		{
			long margin = GetNumberFromUser(
				"Enter the margins to use for the listbox items.",
				"Margin: ",
				"HtmlLbox: Set the margins",
				0, 0, 20,
				this
			);
			
			if ( margin != -1 )
			{
				m_hlbox.SetMargins( margin, margin );
				m_hlbox.RefreshAll();
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnDrawSeparator( Object sender, Event e )
		{
			m_hlbox.RefreshAll();
		}
		
		//---------------------------------------------------------------------
		
		public void OnToggleMulti( Object sender, Event e )
		{
			CommandEvent evt = cast(CommandEvent) e;
			
			Sizer sizer = this.sizer;
			sizer.Detach( m_hlbox );
			
			m_hlbox = new MyHtmlListBox( this, evt.IsChecked );
			sizer.Prepend( m_hlbox, 1, Stretch.wxGROW, 0, null );
			
			sizer.Layout();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelectAll( Object sender, Event e )
		{
			m_hlbox.SelectAll();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetBgCol( Object sender, Event e )
		{
			ColourData data = new ColourData();

			data.colour = m_hlbox.BackgroundColour;
			data.ChooseFull = true;
			
			ColourDialog cd = new ColourDialog( this, data );
			cd.Title = "Choose the background colour";
			
			if ( cd.ShowModal() == wxID_OK )
			{
				Colour col = cd.colourData.colour;
			
				if ( col.Ok() )
				{
					m_hlbox.BackgroundColour = col;
					m_hlbox.Refresh();
				
					StatusText = "Background colour changed.";
				}
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetSelBgCol( Object sender, Event e )
		{
			ColourData data = new ColourData();

			data.colour = m_hlbox.BackgroundColour;
			data.ChooseFull = true;
			
			ColourDialog cd = new ColourDialog( this, data );
			cd.Title = "Choose the selection background colour";
			
			if ( cd.ShowModal() == wxID_OK )
			{
				Colour col = cd.colourData.colour;
			
			
				if ( col.Ok() )
				{
					m_hlbox.SelectionBackground = col;
					m_hlbox.Refresh();
				
					StatusText = "Selection background colour changed.";
				}
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetSelFgCol( Object sender, Event e )
		{
			CommandEvent evt = cast(CommandEvent) e;
			
			m_hlbox.ChangeSelFg = !evt.IsChecked;
			m_hlbox.Refresh();
		}
		
		//---------------------------------------------------------------------
		
		public void OnUpdateUISelectAll( Object sender, Event e )
		{
			UpdateUIEvent evt = cast(UpdateUIEvent) e;
			
			evt.Enabled = ( m_hlbox != null ) && m_hlbox.HasMultipleSelection;
		}
		
		//---------------------------------------------------------------------
		
		public void OnLboxSelect( Object sender, Event e )
		{
			CommandEvent evt = cast(CommandEvent) e;
			
			Log.LogMessage( "Listbox selection is now {0}.", evt.Int );
			
			if ( m_hlbox.HasMultipleSelection )
			{
				string s = "";
				bool first = true;
				uint cookie = 0;
				
				for ( int item = m_hlbox.GetFirstSelected( cookie ); item != -1/*wxNOT_FOUND*/; item = m_hlbox.GetNextSelected( cookie ) )
				{
					if ( first )
					{
						first = false;
					}
					else
					{
						s ~= ", ";
					}
					
					s ~= item;
					
				}
				
				if ( s.length > 0 )
					Log.LogMessage( "Selected items: {0}", s );
			}
			
			StatusText = "# items selected = " ~ .toString(m_hlbox.SelectedCount);
		}
		
		//---------------------------------------------------------------------
		
		public void OnLboxDClick( Object sender, Event e )
		{
			CommandEvent evt = cast(CommandEvent) e;
			
			Log.LogMessage( "Listbox item {0} double clicked.", evt.Int );
		}
	}
	
	//---------------------------------------------------------------------

	public class HTLBox : App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame( null, "HtmListBox sample", Point( -1, -1 ), Size( 400, 500 ) );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			HTLBox app = new HTLBox();
			app.Run();
		}
	}	


void main()
{
	HTLBox.Main();
}
