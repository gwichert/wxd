//-----------------------------------------------------------------------------
// wxD/Samples - Xrcdemo.d
//
// wxD "Xrcdemo" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

	public class XrcFrame : Frame
	{
		public this()
			{ this( null ); }
			
		public this( Window parent )			
		{
			XmlResource.Get().LoadFrame( this, parent, "main_frame" );
			
			icon = new Icon( "../Samples/Xrc/rc/appicon.ico" );
			
			menuBar = XmlResource.Get().LoadMenuBar( "main_menu" );
			
			toolBar = XmlResource.Get().LoadToolBar( this, "main_toolbar" );
			
			CreateStatusBar( 1 );
			
			EVT_MENU( XmlResource.XRCID( "exit_tool_or_menuitem" ), & OnExitToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "non_derived_dialog_tool_or_menuitem" ), & OnNonDerivedDialogToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "derived_tool_or_menuitem" ), & OnDerivedDialogToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "controls_tool_or_menuitem" ), & OnControlsToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "uncentered_tool_or_menuitem" ), & OnUncenteredToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "custom_class_tool_or_menuitem" ), & OnCustomClassToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "platform_property_tool_or_menuitem" ), & OnPlatformPropertyToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "art_provider_tool_or_menuitem" ), & OnArtProviderToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "variable_expansion_tool_or_menuitem" ), & OnVariableExpansionToolOrMenuCommand ) ;
			EVT_MENU( XmlResource.XRCID( "wxglade_dialog_menuitem" ), & OnWxGladeMenu ) ;
			EVT_MENU( XmlResource.XRCID( "about_tool_or_menuitem" ), & OnAboutToolOrMenuCommand ) ;
		}
		
		//---------------------------------------------------------------------	
		
		public void OnExitToolOrMenuCommand( Object sender, Event e )
		{
			Close(true);
		}
		
		//---------------------------------------------------------------------	
		
		public void OnNonDerivedDialogToolOrMenuCommand( Object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog(this, "non_derived_dialog" ); 
			
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnDerivedDialogToolOrMenuCommand( Object sender, Event e )
		{
			PreferencesDialog preferencesDialog = new PreferencesDialog( this );
			
			preferencesDialog.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnWxGladeMenu( Object sender, Event e )
		{
		
			/*Dialog dlg = XmlResource.Get().LoadDialog(this, "wxglade_dialog" ); 
			
			dlg.ShowModal();*/
			
			wxGladeDialog wxgladeDialog = new wxGladeDialog( this );
			
			wxgladeDialog.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnControlsToolOrMenuCommand( Object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog(this, "controls_dialog" );
			
			//ListCtrl lc = (ListCtrl)dlg.FindWindow( XmlResource.XRCID( "controls_listctrl" ), typeof( ListCtrl) );
			
			ListCtrl lc = cast(ListCtrl)XmlResource.XRCCTRL( dlg, "controls_listctrl", &ListCtrl.New );
			
			lc.InsertColumn( 0, "Name", ListCtrl.wxLIST_FORMAT_LEFT, 200);
			lc.InsertItem( 0, "Todd Hope" );
			lc.InsertItem( 1, "Kim Wynd" );
			lc.InsertItem( 2, "Leon Li" );
			
			TreeCtrl treectrl = cast(TreeCtrl)XmlResource.XRCCTRL(  dlg, "controls_treectrl", &TreeCtrl.New );
			
			treectrl.AddRoot( "Godfather" );
			
			treectrl.AppendItem( treectrl.RootItem, "Evil henchman 1" );
			treectrl.AppendItem( treectrl.RootItem, "Evil henchman 2" );
			treectrl.AppendItem( treectrl.RootItem, "Evil accountant" );
			
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnUncenteredToolOrMenuCommand( Object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "uncentered_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnCustomClassToolOrMenuCommand( Object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "custom_class_dialog" );
			
			MyResizableListCtrl a_myResizableListCtrl = new MyResizableListCtrl( dlg,
									-1,
									wxDefaultPosition,
									wxDefaultSize,
									ListCtrl.wxLC_REPORT,
									null );
									
			XmlResource.Get().AttachUnknownControl( "custom_control_placeholder", a_myResizableListCtrl );
			
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnPlatformPropertyToolOrMenuCommand( Object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "platform_property_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnArtProviderToolOrMenuCommand( Object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "art_provider_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnVariableExpansionToolOrMenuCommand( Object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "variable_expansion_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnAboutToolOrMenuCommand( Object sender, Event e )
		{
			string msg = "This is the about dialog of XML resources demo.\n" 
					"Ported to D by BERO";
			MessageBox( this, msg, "About XML resources demo", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}
	}   
	
	//---------------------------------------------------------------------	
	
	public class PreferencesDialog : Dialog
	{
		public this( Window parent )
		{
			XmlResource.Get().LoadDialog( this, parent, "derived_dialog" );
		
			EVT_BUTTON( XmlResource.XRCID( "my_button" ), & OnMyButtonClicked ) ;
			EVT_UPDATE_UI( XmlResource.XRCID( "my_checkbox" ), & OuUpdateUIMyCheckbox ) ;
			EVT_BUTTON( wxID_OK, & OnOK ) ;
		}
		
		//---------------------------------------------------------------------	
		
		public void OnMyButtonClicked( Object sender, Event e )
		{
			MessageBox( this, "You cliecked on My Button", "", Dialog.wxOK  | Dialog.wxICON_INFORMATION );
		}
		
		//---------------------------------------------------------------------	
		
		public void OuUpdateUIMyCheckbox( Object sender, Event e )
		{
			 bool myCheckBoxIsChecked = ( cast(CheckBox)XmlResource.XRCCTRL(  this, "my_checkbox", &CheckBox.New ) ).IsChecked;
			 
			 ( cast(TextCtrl)XmlResource.XRCCTRL( this, "my_textctrl", &TextCtrl.New ) ).Enable( myCheckBoxIsChecked );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnOK( Object sender, Event e )
		{
			MessageDialog md = new MessageDialog( this, "Press OK to close Derived dialog, or Cancel to abort",
					"Overriding base class OK button handler", Dialog.wxOK | Dialog.wxCANCEL | Dialog.wxCENTER );
					
			if ( md.ShowModal() == wxID_OK )
			{
				EndModal( wxID_OK );
			}
		}
	}
	
	//---------------------------------------------------------------------	
	
	public class MyResizableListCtrl : ListCtrl
	{
		enum COL { RECORD_COLUMN = 0, ACTION_COLUMN, PRIORITY_COLUMN }
		
		enum Cmd { PU_ADD_RECORD, PU_EDIT_RECORD, PU_DELETE_RECORD }
		
		//---------------------------------------------------------------------	
	
		public this( Window parent, int id, Point pos, Size size, long style, Validator validator)
		{
			super( parent, id, pos, size, style, validator, "myResizableListCtrl" );
			InsertColumn( COL.RECORD_COLUMN, "Record", ListCtrl.wxLIST_FORMAT_LEFT, 140 );
			InsertColumn( COL.ACTION_COLUMN, "Action", ListCtrl.wxLIST_FORMAT_LEFT, 70 );
			InsertColumn( COL.PRIORITY_COLUMN, "Priority", ListCtrl.wxLIST_FORMAT_LEFT, 70 );
			
			EVT_RIGHT_DOWN( & ContextSensitiveMenu ) ;
			EVT_SIZE( & OnSize ) ;
		}
		
		//---------------------------------------------------------------------	
		
		public void ContextSensitiveMenu( Object sender, Event e )
		{
			MouseEvent me = cast(MouseEvent) e;
		
			Menu a_menu = new Menu();
			
			a_menu.Append( Cmd.PU_ADD_RECORD, "Add a new record" );
			a_menu.Append( Cmd.PU_EDIT_RECORD, "Edit selected record..." );
			a_menu.Append( Cmd.PU_DELETE_RECORD, "Delete selected record" );
			
			if ( SelectedItemCount == 0 )
			{
				a_menu.Enable( Cmd.PU_EDIT_RECORD, false );
				a_menu.Enable( Cmd.PU_DELETE_RECORD, false );
			}
			
			PopupMenu( a_menu, me.Position );
		}
		
		//---------------------------------------------------------------------	
		
		protected void OnSize( Object sender, Event e )
		{
			SetColumnWidths();
			e.Skip();
		}
		
		//---------------------------------------------------------------------	
		
		public void SetColumnWidths()
		{
			int leftmostColumnWidth = Size.Width;
			
			leftmostColumnWidth -= GetColumnWidth( COL.ACTION_COLUMN );
			leftmostColumnWidth -= GetColumnWidth( COL.PRIORITY_COLUMN );
			leftmostColumnWidth -= SystemSettings.GetMetric( SystemMetric.wxSYS_VSCROLL_X );
			leftmostColumnWidth -= 5;
			
			SetColumnWidth( COL.RECORD_COLUMN, leftmostColumnWidth );
		}
	}
	
	//---------------------------------------------------------------------	
	
	public class wxGladeDialog : Dialog
	{
		public this( Window parent )
		{
			XmlResource.Get().LoadDialog( this, parent, "wxglade_dialog" );
		
			EVT_BUTTON( wxID_OK, & OnOK ) ;
		}
		
		//---------------------------------------------------------------------	
		
		public void OnOK( Object sender, Event e)
		{
			Close();
		}
	}
	
	//---------------------------------------------------------------------	

	public class Xrcdemo : App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			Image.InitAllHandlers();
			
			XmlResource.Get().InitAllHandlers();
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/menu.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/toolbar.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/basicdlg.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/derivdlg.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/controls.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/frame.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/uncenter.xrc" );    
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/custclas.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/artprov.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/platform.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/variable.xrc" );
			
			XmlResource.Get().Load( "../Samples/Xrc/rc/wxglade.xrc" );
			
			XrcFrame frame = new XrcFrame();
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			Xrcdemo app = new Xrcdemo();			
			app.Run();
		}

		//---------------------------------------------------------------------
	}

void main()
{
	Xrcdemo.Main();
}
