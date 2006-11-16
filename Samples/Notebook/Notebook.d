//-----------------------------------------------------------------------------
// wxD/Samples - Notebook.d
//
// wxD "Notebook" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
import std.string;
alias std.string.find indexOf;

	public class MyFrame : Frame
	{
		enum ID_CONTROLS 
		{
			ID_RADIO_ORIENT = 5999,
			ID_CHK_SHOWIMAGES,
			ID_BTN_ADD_PAGE,
			ID_BTN_INSERT_PAGE,
			ID_BTN_DELETE_CUR_PAGE,
			ID_BTN_DELETE_LAST_PAGE,
			ID_BTN_NEXT_PAGE,
			ID_NOTEBOOK
		}
		
		public const int ORIENT_TOP = 0;
		public const int ORIENT_BOTTOM = 1;
		public const int ORIENT_LEFT = 2;
		public const int ORIENT_RIGHT = 3;
		public const int ORIENT_MAX = 4;		
		
		private Panel m_panel;
		private RadioBox m_radioOrient;
		private CheckBox m_chkShowImages;
		
		private Button m_btnAddPage;
		private Button m_btnInsertPage;
		private Button m_btnDeleteCurPage;
		private Button m_btnDeleteLastPage;
		private Button m_btnNextPage;
		private Button m_btnExit;
		
		private MyNotebook m_notebook;
		private TextCtrl m_text;
		
		private BoxSizer m_sizerFrame;
		private BoxSizer m_sizerTop;
		private NotebookSizer m_sizerNotebook;
		private ImageList m_imageList;
		
		public static int s_pageAdded = 0;
		public static int s_pageIns = 0;
		public static int s_numNotebookEvents = 0;
		public static int s_nPages = -1;
		public static int s_nSel = -1;
		
		//---------------------------------------------------------------------

		public this( string title, Point pos, Size size )
		{
			super( title, pos, size );
			Size imageSize = new_Size( 32, 32 );
			
			m_imageList = new ImageList( imageSize.Width, imageSize.Height );
			
			m_imageList.Add( ArtProvider.GetIcon( ArtID.wxART_INFORMATION, ArtClient.wxART_OTHER, imageSize ) );
			
			m_imageList.Add( ArtProvider.GetIcon( ArtID.wxART_QUESTION, ArtClient.wxART_OTHER, imageSize ) );
			
			m_imageList.Add( ArtProvider.GetIcon( ArtID.wxART_WARNING, ArtClient.wxART_OTHER, imageSize ) );
			
			m_imageList.Add( ArtProvider.GetIcon( ArtID.wxART_ERROR, ArtClient.wxART_OTHER, imageSize ) );
			
			m_panel = new Panel( this, -1, wxDefaultPosition, wxDefaultSize,
				wxTAB_TRAVERSAL | wxCLIP_CHILDREN | wxNO_BORDER );
			
			const string[] strOrientations =
			[
				"&Top",
				"&Bottom",
				"&Left",
				"&Right"
			];
			
			m_radioOrient = new RadioBox(
				m_panel, ID_CONTROLS.ID_RADIO_ORIENT,
				"&Tab orientation",
				wxDefaultPosition, wxDefaultSize,
				strOrientations,
				1, RadioBox.wxRA_SPECIFY_COLS );
			
			m_chkShowImages = new CheckBox( m_panel, ID_CONTROLS.ID_CHK_SHOWIMAGES, "&Show images" );
			
			m_btnAddPage = new Button( m_panel, ID_CONTROLS.ID_BTN_ADD_PAGE, "&Add page" );
			
			m_btnInsertPage = new Button( m_panel, ID_CONTROLS.ID_BTN_INSERT_PAGE, "&Insert page" );
			
			m_btnDeleteCurPage = new Button( m_panel, ID_CONTROLS.ID_BTN_DELETE_CUR_PAGE, "&Delete current page" );
			
			m_btnDeleteLastPage = new Button( m_panel, ID_CONTROLS.ID_BTN_DELETE_LAST_PAGE, "Delete las&t page" );
			
			m_btnNextPage = new Button( m_panel, ID_CONTROLS.ID_BTN_NEXT_PAGE, "&Next page" );
			
			m_btnExit = new Button( m_panel, wxID_OK, "&Exit" );
			m_btnExit.SetDefault();
			
			m_notebook = new MyNotebook( m_panel, ID_CONTROLS.ID_NOTEBOOK );
			
			m_text = new TextCtrl( m_panel, -1, "", wxDefaultPosition, wxDefaultSize, TextCtrl.wxTE_MULTILINE | TextCtrl.wxTE_READONLY );
			
			Log.SetActiveTarget( m_text );
			Log.AddTraceMask( "focus" );			
			
			m_notebook.CreateInitialPages();
			
			m_sizerFrame = new BoxSizer( Orientation.wxVERTICAL );
			
			m_sizerTop = new BoxSizer( Orientation.wxHORIZONTAL );
			
			BoxSizer sizerLeft = new BoxSizer( Orientation.wxVERTICAL );
			
			sizerLeft.Add( m_radioOrient, 0, Stretch.wxEXPAND );
			sizerLeft.Add( m_chkShowImages, 0, Stretch.wxEXPAND | Direction.wxTOP, 4 );
			
			//sizerLeft.Add( 0, 0, 1 );
			
			sizerLeft.Add( m_btnAddPage, 0, Stretch.wxEXPAND | ( Direction.wxTOP | Direction.wxBOTTOM ), 4 );
			sizerLeft.Add( m_btnInsertPage, 0, Stretch.wxEXPAND | ( Direction.wxTOP | Direction.wxBOTTOM ), 4 );
			sizerLeft.Add( m_btnDeleteCurPage, 0, Stretch.wxEXPAND | ( Direction.wxTOP | Direction.wxBOTTOM ), 4 );
			sizerLeft.Add( m_btnDeleteLastPage, 0, Stretch.wxEXPAND | ( Direction.wxTOP | Direction.wxBOTTOM ), 4 );
			sizerLeft.Add( m_btnNextPage, 0, Stretch.wxEXPAND | ( Direction.wxTOP | Direction.wxBOTTOM ), 4 );
			
			//sizerLeft.Add( 0, 0, 1 );
			
			sizerLeft.Add( m_btnExit, 0, Stretch.wxEXPAND );
			
			m_sizerTop.Add( sizerLeft, 0, Stretch.wxEXPAND | Direction.wxALL, 4 );
			
			m_sizerFrame.Add( m_sizerTop, 1, Stretch.wxEXPAND );
			m_sizerFrame.Add( m_text, 0, Stretch.wxEXPAND );
			
			ReInitNotebook();
			
			m_panel.sizer = m_sizerFrame;
			
			m_panel.AutoLayout = true;
			
			m_sizerFrame.Fit( this );
			
			Centre( Orientation.wxBOTH );
			
			EVT_RADIOBOX( ID_CONTROLS.ID_RADIO_ORIENT, & OnCheckOrRadioBox) ;
			EVT_CHECKBOX( ID_CONTROLS.ID_CHK_SHOWIMAGES, & OnCheckOrRadioBox ) ;

			EVT_BUTTON( ID_CONTROLS.ID_BTN_ADD_PAGE, & OnButtonAddPage ) ;
			EVT_BUTTON( ID_CONTROLS.ID_BTN_INSERT_PAGE, & OnButtonInsertPage ) ;
			EVT_BUTTON( ID_CONTROLS.ID_BTN_DELETE_CUR_PAGE, & OnButtonDeleteCurPage ) ;
			EVT_BUTTON( ID_CONTROLS.ID_BTN_DELETE_LAST_PAGE, & OnButtonDeleteLastPage ) ;
			EVT_BUTTON( ID_CONTROLS.ID_BTN_NEXT_PAGE, & OnButtonNextPage ) ;
			EVT_BUTTON( wxID_OK, & OnButtonExit ) ;

			EVT_UPDATE_UI( ID_CONTROLS.ID_BTN_DELETE_CUR_PAGE, & OnUpdateUIBtnDeleteCurPage ) ;
			EVT_UPDATE_UI( ID_CONTROLS.ID_BTN_DELETE_LAST_PAGE, & OnUpdateUIBtnDeleteLastPage ) ;

			EVT_NOTEBOOK_PAGE_CHANGED( ID_CONTROLS.ID_NOTEBOOK, & OnNotebook ) ;
			EVT_NOTEBOOK_PAGE_CHANGING( ID_CONTROLS.ID_NOTEBOOK, & OnNotebook ) ;

			EVT_IDLE( & OnIdle ) ;
		}
		
		public void ReInitNotebook()
		{
			long flags = 0;
			
			switch ( m_radioOrient.Selection )
			{
				default: Log.LogError( "unknown notebook orientation" ); break;
				case ORIENT_TOP :
					flags = Notebook.wxNB_TOP;
					break;
				case ORIENT_BOTTOM :
					flags = Notebook.wxNB_BOTTOM;
					break;
				case ORIENT_LEFT :
					flags = Notebook.wxNB_LEFT;
					break;
				case ORIENT_RIGHT :
					flags = Notebook.wxNB_RIGHT;
					break;
			}
			
			MyNotebook notebook = m_notebook;
			
			m_notebook = new MyNotebook( m_panel, ID_CONTROLS.ID_NOTEBOOK,
				wxDefaultPosition, wxDefaultSize, flags );
			
			if ( m_chkShowImages.IsChecked )
			{
				m_notebook.Images = m_imageList;
			}
			
			if ( notebook )
			{
				int sel = notebook.Selection;
				
				int count = notebook.PageCount;
				
				for ( int n = 0; n < count; n++ )
				{
					string str = notebook.GetPageText( n );
					
					Window page = m_notebook.CreatePage( str );
					m_notebook.AddPage( page, str, false, m_notebook.IconIndex );
				}
				
				if ( m_sizerNotebook )
				{
					m_sizerTop.Remove( m_sizerNotebook );
				}
				
				notebook.Dispose();
				notebook = null;
				
				if ( sel != -1 )
				{
					m_notebook.Selection = sel;
				}
			}
			
			m_sizerNotebook = new NotebookSizer( m_notebook );
			m_sizerTop.Add( m_sizerNotebook, 1, Stretch.wxEXPAND | Direction.wxALL, 4 );
			m_sizerTop.Layout();
		}
		
		public void OnCheckOrRadioBox( Object sender, Event e )
		{
			ReInitNotebook();
		}
		
		public void OnButtonAddPage( Object sender, Event e )
		{
			Panel panel = new Panel( m_notebook, -1 );
			new Button( panel, -1, "First button", new_Point( 10, 10 ), new_Size( -1, -1 ) );
			new Button( panel, -1, "Second button", new_Point( 50, 100 ), new_Size( -1, -1 ) );
			
			m_notebook.AddPage( panel, "Added " ~ .toString( ++s_pageAdded), true, m_notebook.IconIndex );
		}
		
		public void OnButtonInsertPage( Object sender, Event e )
		{
			Panel panel = m_notebook.CreateUserCreatedPage();
			
			m_notebook.InsertPage( 0, panel, "Inserted " ~ .toString( ++s_pageIns), false, m_notebook.IconIndex );
			
			m_notebook.Selection = 0;
		}
		
		public void OnButtonDeleteCurPage( Object sender, Event e )
		{
			int sel = m_notebook.Selection;
			
			if ( sel != -1 )
			{
				m_notebook.DeletePage( sel );
			}
		}
		
		public void OnButtonDeleteLastPage( Object sender, Event e )
		{
			int page = m_notebook.PageCount;
			
			if ( page != 0 )
			{
				m_notebook.DeletePage( page -1 );
			}
		}
		
		public void OnButtonNextPage( Object sender, Event e )
		{
			m_notebook.AdvanceSelection( true );
		}
		
		public void OnButtonExit( Object sender, Event e )
		{
			Close();
		}
		
		public void OnNotebook( Object sender, Event e )
		{
			string str = "Unknown notebook event";
			
			NotebookEvent ne = cast(NotebookEvent) e;
			
			int eventType = ne.eventType;
			
			if ( eventType == Event.wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED )
			{
				str = "Notebook changed";
			}
			else if ( eventType == Event.wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING )
			{
				int idx = ne.OldSelection;
				
				if ( idx != -1 && m_notebook.GetPageText( idx ) == "Veto" )
				{
					MessageDialog md = new MessageDialog( this, "Are you sure you want to leave this notebook page?\n(This demonstrates veto-ing)",
							"Notebook sample", Dialog.wxICON_QUESTION | Dialog.wxYES_NO );
						
					if ( md.ShowModal() != wxID_YES )
					{
						ne.Veto();
						
						return;
					}		
				}
				
				str = "Notebook changing";
			}
			
			Log.LogMessage( "Notebook event #{0}: {1} ({2})", s_numNotebookEvents++, str, eventType );
			
			m_text.SetInsertionPointEnd();
			
			ne.Skip();
		}
		
		public void OnUpdateUIBtnDeleteCurPage( Object sender, Event e )
		{
			UpdateUIEvent ue = cast(UpdateUIEvent) e;
			ue.Enabled = m_notebook.Selection != -1;
		}
		
		public void OnUpdateUIBtnDeleteLastPage( Object sender, Event e )
		{
			UpdateUIEvent ue = cast(UpdateUIEvent) e;
			ue.Enabled = m_notebook.PageCount != 0;
		}
		
		public void OnIdle( Object sender, Event e )
		{
			int nPages = m_notebook.PageCount;
			int nSel = m_notebook.Selection;
			if ( nPages != s_nPages || nSel != s_nSel )
			{
				s_nPages = nPages;
				s_nSel = nSel;
				
				string title = "Notebook (" ~ .toString(nPages) ~ " pages, selection: " ~ .toString(nSel) ~ ")";
				
				Title = title;
			}
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyNotebook : Notebook
	{
		public this( Window parent, int id )
			{ this( parent, id, wxDefaultPosition, wxDefaultSize, 0 ); }
		
		public this( Window parent, int id, Point pos, Size size, long style )
		{
			super ( parent, id, pos, size, style );
		}
		
		public void CreateInitialPages()
		{
			Panel panel = null;
			
			panel = CreateRadioButtonsPage();
			AddPage( panel, "Radiobuttons", false, IconIndex );
			
			panel = CreateVetoPage();
			AddPage( panel, "Veto", false, IconIndex );
			
			panel = CreateBigButtonPage();
			AddPage( panel, "Maximized button", false, IconIndex );
			
			panel = CreateInsertPage();
			InsertPage( 0, panel, "Inserted", false, IconIndex );
			
			Selection = 1;
		}
		
		public Panel CreatePage( string pageName )
		{
			if ( pageName.indexOf( "Inserted " ) != -1 || pageName.indexOf( "Added " ) != -1 )
			{
				return CreateUserCreatedPage();
			}
			
			if ( pageName == "Inserted" )
			{
				return CreateInsertPage();
			}
			
			if ( pageName == "Veto" )
			{
				return CreateVetoPage();
			}
			
			if ( pageName == "Radiobuttons" )
			{
				return CreateRadioButtonsPage();
			}
			
			if ( pageName == "Maximized button" )
			{
				return CreateBigButtonPage();
			}
			
			return CreateBigButtonPage();
		}
		
		public Panel CreateUserCreatedPage()
		{
			Panel panel = new Panel( this );
			
			new Button( panel, -1, "Button", new_Point( 10, 10 ), new_Size( -1, -1 ) );
			
			return panel;
		}
		
		public int IconIndex()
		{
				if ( Images )
				{
					int nImages = Images.ImageCount;
					if ( nImages > 0 )
					{
						return PageCount % nImages;
					}
				}
				return -1; 
		}
		
		private Panel CreateInsertPage()
		{
			Panel panel = new Panel( this );
			
			panel.BackgroundColour = new Colour( "MAROON" );
			
			new StaticText( panel, -1, "This page has been inserted, not added.", new_Point( 10, 10 ) );
			
			return panel;
		}
		
		private Panel CreateRadioButtonsPage()
		{
			Panel panel = new Panel( this );
			
			const string[] animals = [ "Fox", "Hare", "Rabbit", "Sabre-toothed tiger", "Rex" ];
			
			RadioBox radiobox1 = new RadioBox( panel, -1, "Choose one", 
				wxDefaultPosition, wxDefaultSize, animals, 2, RadioBox.wxRA_SPECIFY_ROWS );
			
			const string[] computers = [ "Amiga", "Commodore 64", "PET", "Another" ];
			
			RadioBox radiobox2 = new RadioBox( panel, -1, "Choose your favourite",
				wxDefaultPosition, wxDefaultSize, computers, 0, RadioBox.wxRA_SPECIFY_COLS );
			
			BoxSizer sizerPanel = new BoxSizer( Orientation.wxVERTICAL );
			sizerPanel.Add( radiobox1, 2, Stretch.wxEXPAND );
			sizerPanel.Add( radiobox2, 1, Stretch.wxEXPAND );
			panel.sizer = sizerPanel;
			
			return panel;
		}
		
		private Panel CreateVetoPage()
		{
			Panel panel = new Panel( this );
			
			new StaticText( panel, -1, "This page intentionally left blank", new_Point( 10, 10 ) );
			
			return panel;
		}
		
		private Panel CreateBigButtonPage()
		{
			Panel panel = new Panel( this );
			
			Button buttonBig = new Button( panel, -1, "Maximized button", new_Point( 0, 0 ), new_Size( 480, 360 ) );
			
			BoxSizer sizerPanel = new BoxSizer( Orientation.wxVERTICAL );
			sizerPanel.Add( buttonBig, 1, Stretch.wxEXPAND );
			panel.sizer = sizerPanel;
			
			return panel;
		}
	}
	
	//---------------------------------------------------------------------

	public class NOTEBOOK : App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame( "Notebook sample", Window.wxDefaultPosition, Window.wxDefaultSize );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			NOTEBOOK app = new NOTEBOOK();
			app.Run();
		}
	}


void main()
{
	NOTEBOOK.Main();
}
