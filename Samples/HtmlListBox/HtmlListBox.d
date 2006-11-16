//-----------------------------------------------------------------------------
// wx.NET/Samples - HtmlListBox.cs
//
// wx.NET "HtmlListBox" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;

namespace wx.Samples
{
	public class MyHtmlListBox : HtmlListBox
	{
		//---------------------------------------------------------------------
		
		protected bool m_change;
		
		//---------------------------------------------------------------------
		
		public MyHtmlListBox( Window parent )
			: this( parent, false ) {}
			
		public MyHtmlListBox( Window parent, bool multi )
			: base( parent, -1, wxDefaultPosition, wxDefaultSize, multi ? ListBox.wxLB_MULTIPLE : 0 )
		{
			m_change = true;
			
			SetMargins( 5, 5 );
			
			ItemCount = 1000;
			
			Selection = 3;			
		}
		
		//---------------------------------------------------------------------
		
		public bool ChangeSelFg
		{
			set { m_change = value; }
		}
		
		//---------------------------------------------------------------------
		
		protected override string OnGetItem( int n )
		{
			int level = ( n % 6 ) + 1;
			    
			string retval;
			retval = String.Format( "<h{0}><font color=#{1:x2}{2:x2}{3:x2}>Item</font> <b>{4}</b></h{5}>", 
					level, 
					System.Math.Abs( n - 192 ) % 256,
					System.Math.Abs( n - 256 ) % 256,
					System.Math.Abs(n - 128) % 256,
					n,
					level );
				
			return retval;
		}
		
		//---------------------------------------------------------------------
		
		protected override void OnDrawSeparator( DC dc, Rectangle rect, int n )   
		{	
			MyFrame mp = (MyFrame)Parent;
			
			if ( mp.MenuBar.IsChecked( (int)MyFrame.Cmd.HtmlLbox_DrawSeparator ) )
			{
				dc.Pen = GDIPens.wxBLACK_DASHED_PEN;
				dc.DrawLine( rect.X, rect.Y, rect.Right - 1, rect.Y );
				dc.DrawLine( rect.X, rect.Bottom - 1, rect.Right - 1, rect.Bottom - 1 );
			}
			
		}
		
		//---------------------------------------------------------------------
		
		protected override Colour GetSelectedTextColour( Colour colFg )
		{
			return m_change ? base.GetSelectedTextColour( colFg ) : colFg;
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
		
		public MyFrame( Window parent, string title, Point pos, Size size ) 
			: base( parent, -1, title, pos, size )
		{
			Icon = new wx.Icon( "../Samples/HtmlListBox/mondrian.png" );
			
			Menu menuFile = new Menu();
			menuFile.Append( (int)Cmd.HtmlLbox_Quit, "E&xit\tAlt-X", "Quit this program" );
			
			Menu menuHLbox = new Menu();
			menuHLbox.Append( (int)Cmd.HtmlLbox_SetMargins, "Set &margins...\tCtrl-G", "Change the margins around the items" );
			menuHLbox.AppendCheckItem( (int)Cmd.HtmlLbox_DrawSeparator, "&Draw separators\tCtrl-D", "Toggle drawing separators between cells" );
			menuHLbox.AppendSeparator();
			menuHLbox.AppendCheckItem( (int)Cmd.HtmlLbox_ToggleMulti, "&Multiple selection\tCtrl-M", "Toggle multiple selection on/off" );
			menuHLbox.AppendSeparator();
			menuHLbox.Append( (int)Cmd.HtmlLbox_SelectAll, "Select &all items\tCtrl-A" );
			menuHLbox.AppendSeparator();
			menuHLbox.Append( (int)Cmd.HtmlLbox_SetBgCol, "Set &background...\tCtrl-B" );
			menuHLbox.Append( (int)Cmd.HtmlLbox_SetSelBgCol, "Set &selection background...\tCtrl-S" );
			menuHLbox.AppendCheckItem( (int)Cmd.HtmlLbox_SetSelFgCol, "Keep &foreground in selection\tCtrl-F" );
			
			Menu helpMenu = new Menu();
			helpMenu.Append( (int)Cmd.HtmlLbox_About, "&About...\tF1", "Show about dialog" );
			
			MenuBar menuBar = new MenuBar();
			menuBar.Append( menuFile, "&File" );
			menuBar.Append( menuHLbox, "&Listbox" );
			menuBar.Append( helpMenu, "&Help" );
			
			menuBar.Check( (int)Cmd.HtmlLbox_DrawSeparator, true );
			
			MenuBar = menuBar;
			
			CreateStatusBar( 2 );
			StatusText = "Welcome to wxWidgets!";
			
			m_hlbox = new MyHtmlListBox( this );
			TextCtrl text = new TextCtrl( this, -1, "", wxDefaultPosition, wxDefaultSize, TextCtrl.wxTE_MULTILINE );
			
			Log.SetActiveTarget( text ); 
			
			BoxSizer sizer = new BoxSizer( Orientation.wxHORIZONTAL );
			sizer.Add( m_hlbox, 1, Stretch.wxGROW );
			sizer.Add( text, 1, Stretch.wxGROW );
			
			Sizer = sizer;
			
			EVT_MENU( (int)Cmd.HtmlLbox_Quit,  new EventListener( OnQuit ) );
			EVT_MENU( (int)Cmd.HtmlLbox_SetMargins,  new EventListener( OnSetMargins ) );
			EVT_MENU( (int)Cmd.HtmlLbox_DrawSeparator, new EventListener( OnDrawSeparator ) );
			EVT_MENU( (int)Cmd.HtmlLbox_ToggleMulti, new EventListener( OnToggleMulti ) );
			EVT_MENU( (int)Cmd.HtmlLbox_SelectAll, new EventListener( OnSelectAll ) );

			EVT_MENU( (int)Cmd.HtmlLbox_About, new EventListener( OnAbout ) );

			EVT_MENU( (int)Cmd.HtmlLbox_SetBgCol, new EventListener( OnSetBgCol ) );
			EVT_MENU( (int)Cmd.HtmlLbox_SetSelBgCol, new EventListener( OnSetSelBgCol ) );
			EVT_MENU( (int)Cmd.HtmlLbox_SetSelFgCol, new EventListener( OnSetSelFgCol ) );

			EVT_UPDATE_UI( (int)Cmd.HtmlLbox_SelectAll, new EventListener( OnUpdateUISelectAll ) );


			EVT_LISTBOX( wxID_ANY, new EventListener( OnLboxSelect ) );
			EVT_LISTBOX_DCLICK( wxID_ANY, new EventListener( OnLboxDClick ) );
		}
		
		//---------------------------------------------------------------------
		
		public void OnQuit( object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnAbout( object sender, Event e )
		{
			wx.MessageDialog.ShowModal( this, "This sample shows wxHtmlListBox class.\n" +
				"\n" +
				"© 2003 Vadim Zeitlin\n" +
				"Ported to wx.NET by Alexander Olk", "About HtmlLbox", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetMargins( object sender, Event e )
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
				m_hlbox.SetMargins( (int)margin, (int)margin );
				m_hlbox.RefreshAll();
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnDrawSeparator( object sender, Event e )
		{
			m_hlbox.RefreshAll();
		}
		
		//---------------------------------------------------------------------
		
		public void OnToggleMulti( object sender, Event e )
		{
			CommandEvent evt = (CommandEvent) e;
			
			Sizer sizer = Sizer;
			sizer.Detach( m_hlbox );
			
			m_hlbox = new MyHtmlListBox( this, evt.IsChecked );
			sizer.Prepend( m_hlbox, 1, (int)Stretch.wxGROW, 0, null );
			
			sizer.Layout();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelectAll( object sender, Event e )
		{
			m_hlbox.SelectAll();
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetBgCol( object sender, Event e )
		{
			ColourData data = new ColourData();

			data.Colour = m_hlbox.BackgroundColour;
			data.ChooseFull = true;
			
			ColourDialog cd = new ColourDialog( this, data );
			cd.Title = "Choose the background colour";
			
			if ( cd.ShowModal() == wxID_OK )
			{
				Colour col = cd.ColourData.Colour;
			
				if ( col.Ok() )
				{
					m_hlbox.BackgroundColour = col;
					m_hlbox.Refresh();
				
					StatusText = "Background colour changed.";
				}
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetSelBgCol( object sender, Event e )
		{
			ColourData data = new ColourData();

			data.Colour = m_hlbox.BackgroundColour;
			data.ChooseFull = true;
			
			ColourDialog cd = new ColourDialog( this, data );
			cd.Title = "Choose the selection background colour";
			
			if ( cd.ShowModal() == wxID_OK )
			{
				Colour col = cd.ColourData.Colour;
			
			
				if ( col.Ok() )
				{
					m_hlbox.SelectionBackground = col;
					m_hlbox.Refresh();
				
					StatusText = "Selection background colour changed.";
				}
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSetSelFgCol( object sender, Event e )
		{
			CommandEvent evt = (CommandEvent) e;
			
			m_hlbox.ChangeSelFg = !evt.IsChecked;
			m_hlbox.Refresh();
		}
		
		//---------------------------------------------------------------------
		
		public void OnUpdateUISelectAll( object sender, Event e )
		{
			UpdateUIEvent evt = (UpdateUIEvent) e;
			
			evt.Enabled = ( m_hlbox != null ) && m_hlbox.HasMultipleSelection;
		}
		
		//---------------------------------------------------------------------
		
		public void OnLboxSelect( object sender, Event e )
		{
			CommandEvent evt = (CommandEvent) e;
			
			Log.LogMessage( "Listbox selection is now {0}.", evt.Int );
			
			if ( m_hlbox.HasMultipleSelection )
			{
				string s = "";
				bool first = true;
				ulong cookie = 0;
				
				for ( int item = m_hlbox.GetFirstSelected( out cookie ); item != -1/*wxNOT_FOUND*/; item = m_hlbox.GetNextSelected( out cookie ) )
				{
					if ( first )
					{
						first = false;
					}
					else
					{
						s += ", ";
					}
					
					s += item;
					
				}
				
				if ( s.Length > 0 )
					Log.LogMessage( "Selected items: {0}", s );
			}
			
			StatusText = "# items selected = " + m_hlbox.SelectedCount;
		}
		
		//---------------------------------------------------------------------
		
		public void OnLboxDClick( object sender, Event e )
		{
			CommandEvent evt = (CommandEvent) e;
			
			Log.LogMessage( "Listbox item {0} double clicked.", evt.Int );
		}
	}
	
	//---------------------------------------------------------------------

	public class HTLBox : wx.App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame( null, "HtmListBox sample", new Point( -1, -1 ), new Size( 400, 500 ) );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			HTLBox app = new HTLBox();
			app.Run();
		}
	}	
}
