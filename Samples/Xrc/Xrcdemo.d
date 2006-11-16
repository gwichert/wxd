//-----------------------------------------------------------------------------
// wx.NET/Samples - Xrcdemo.cs
//
// wx.NET "Xrcdemo" sample.
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
	public class XrcFrame : Frame
	{
		public XrcFrame()
			: this( null ) {}
			
		public XrcFrame( Window parent )			
		{
			XmlResource.Get().LoadFrame( this, parent, "main_frame" );
			
			Icon = new Icon( "../Samples/Xrc/rc/appicon.ico" );
			
			MenuBar = XmlResource.Get().LoadMenuBar( "main_menu" );
			
			ToolBar = XmlResource.Get().LoadToolBar( this, "main_toolbar" );
			
			CreateStatusBar( 1 );
			
			EVT_MENU( XmlResource.XRCID( "exit_tool_or_menuitem" ), new EventListener( OnExitToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "non_derived_dialog_tool_or_menuitem" ), new EventListener( OnNonDerivedDialogToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "derived_tool_or_menuitem" ), new EventListener( OnDerivedDialogToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "controls_tool_or_menuitem" ), new EventListener( OnControlsToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "uncentered_tool_or_menuitem" ), new EventListener( OnUncenteredToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "custom_class_tool_or_menuitem" ), new EventListener( OnCustomClassToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "platform_property_tool_or_menuitem" ), new EventListener( OnPlatformPropertyToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "art_provider_tool_or_menuitem" ), new EventListener( OnArtProviderToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "variable_expansion_tool_or_menuitem" ), new EventListener( OnVariableExpansionToolOrMenuCommand ) );
			EVT_MENU( XmlResource.XRCID( "wxglade_dialog_menuitem" ), new EventListener( OnWxGladeMenu ) );
			EVT_MENU( XmlResource.XRCID( "about_tool_or_menuitem" ), new EventListener( OnAboutToolOrMenuCommand ) );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnExitToolOrMenuCommand( object sender, Event e )
		{
			Close(true);
		}
		
		//---------------------------------------------------------------------	
		
		public void OnNonDerivedDialogToolOrMenuCommand( object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog(this, "non_derived_dialog" ); 
			
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnDerivedDialogToolOrMenuCommand( object sender, Event e )
		{
			PreferencesDialog preferencesDialog = new PreferencesDialog( this );
			
			preferencesDialog.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnWxGladeMenu( object sender, Event e )
		{
		
			/*Dialog dlg = XmlResource.Get().LoadDialog(this, "wxglade_dialog" ); 
			
			dlg.ShowModal();*/
			
			wxGladeDialog wxgladeDialog = new wxGladeDialog( this );
			
			wxgladeDialog.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnControlsToolOrMenuCommand( object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog(this, "controls_dialog" );
			
			//ListCtrl lc = (ListCtrl)dlg.FindWindow( XmlResource.XRCID( "controls_listctrl" ), typeof( ListCtrl) );
			
			ListCtrl lc = (ListCtrl)XmlResource.XRCCTRL( dlg, "controls_listctrl", typeof( ListCtrl ) );
			
			lc.InsertColumn( 0, "Name", ListCtrl.wxLIST_FORMAT_LEFT, 200);
			lc.InsertItem( 0, "Todd Hope" );
			lc.InsertItem( 1, "Kim Wynd" );
			lc.InsertItem( 2, "Leon Li" );
			
			TreeCtrl treectrl = (TreeCtrl)XmlResource.XRCCTRL(  dlg, "controls_treectrl", typeof( TreeCtrl ) );
			
			treectrl.AddRoot( "Godfather" );
			
			treectrl.AppendItem( treectrl.RootItem, "Evil henchman 1" );
			treectrl.AppendItem( treectrl.RootItem, "Evil henchman 2" );
			treectrl.AppendItem( treectrl.RootItem, "Evil accountant" );
			
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnUncenteredToolOrMenuCommand( object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "uncentered_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnCustomClassToolOrMenuCommand( object sender, Event e )
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
		
		public void OnPlatformPropertyToolOrMenuCommand( object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "platform_property_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnArtProviderToolOrMenuCommand( object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "art_provider_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnVariableExpansionToolOrMenuCommand( object sender, Event e )
		{
			Dialog dlg = XmlResource.Get().LoadDialog( this, "variable_expansion_dialog" );
			dlg.ShowModal();
		}
		
		//---------------------------------------------------------------------	
		
		public void OnAboutToolOrMenuCommand( object sender, Event e )
		{
			string msg = "This is the about dialog of XML resources demo.\n" +
					"Ported to wx.NET by Alexander Olk";
			MessageDialog.ShowModal( this, msg, "About XML resources demo", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}
	}   
	
	//---------------------------------------------------------------------	
	
	public class PreferencesDialog : Dialog
	{
		public PreferencesDialog( Window parent )
		{
			XmlResource.Get().LoadDialog( this, parent, "derived_dialog" );
		
			EVT_BUTTON( XmlResource.XRCID( "my_button" ), new EventListener( OnMyButtonClicked ) );
			EVT_UPDATE_UI( XmlResource.XRCID( "my_checkbox" ), new EventListener( OuUpdateUIMyCheckbox ) );
			EVT_BUTTON( wxID_OK, new EventListener( OnOK ) );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnMyButtonClicked( object sender, Event e )
		{
			MessageDialog.ShowModal( this, "You cliecked on My Button", "", Dialog.wxOK  | Dialog.wxICON_INFORMATION );
		}
		
		//---------------------------------------------------------------------	
		
		public void OuUpdateUIMyCheckbox( object sender, Event e )
		{
			 bool myCheckBoxIsChecked = ( (CheckBox)XmlResource.XRCCTRL(  this, "my_checkbox", typeof( CheckBox ) ) ).IsChecked;
			 
			 ( (TextCtrl)XmlResource.XRCCTRL( this, "my_textctrl", typeof( TextCtrl ) ) ).Enable( myCheckBoxIsChecked );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnOK( object sender, Event e )
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
	
		public MyResizableListCtrl( Window parent, int id, Point pos, Size size, long style, Validator validator)
			: base( parent, id, pos, size, style, validator, "myResizableListCtrl" )
		{
			InsertColumn( (int)COL.RECORD_COLUMN, "Record", ListCtrl.wxLIST_FORMAT_LEFT, 140 );
			InsertColumn( (int)COL.ACTION_COLUMN, "Action", ListCtrl.wxLIST_FORMAT_LEFT, 70 );
			InsertColumn( (int)COL.PRIORITY_COLUMN, "Priority", ListCtrl.wxLIST_FORMAT_LEFT, 70 );
			
			EVT_RIGHT_DOWN( new EventListener( ContextSensitiveMenu ) );
			EVT_SIZE( new EventListener( OnSize ) );
		}
		
		//---------------------------------------------------------------------	
		
		public void ContextSensitiveMenu( object sender, Event e )
		{
			MouseEvent me = (MouseEvent) e;
		
			Menu a_menu = new Menu();
			
			a_menu.Append( (int)Cmd.PU_ADD_RECORD, "Add a new record" );
			a_menu.Append( (int)Cmd.PU_EDIT_RECORD, "Edit selected record..." );
			a_menu.Append( (int)Cmd.PU_DELETE_RECORD, "Delete selected record" );
			
			if ( SelectedItemCount == 0 )
			{
				a_menu.Enable( (int)Cmd.PU_EDIT_RECORD, false );
				a_menu.Enable( (int)Cmd.PU_DELETE_RECORD, false );
			}
			
			PopupMenu( a_menu, me.Position );
		}
		
		//---------------------------------------------------------------------	
		
		protected void OnSize( object sender, Event e )
		{
			SetColumnWidths();
			e.Skip();
		}
		
		//---------------------------------------------------------------------	
		
		public void SetColumnWidths()
		{
			int leftmostColumnWidth = Size.Width;
			
			leftmostColumnWidth -= GetColumnWidth( (int)COL.ACTION_COLUMN );
			leftmostColumnWidth -= GetColumnWidth( (int)COL.PRIORITY_COLUMN );
			leftmostColumnWidth -= SystemSettings.GetMetric( SystemMetric.wxSYS_VSCROLL_X );
			leftmostColumnWidth -= 5;
			
			SetColumnWidth( (int)COL.RECORD_COLUMN, leftmostColumnWidth );
		}
	}
	
	//---------------------------------------------------------------------	
	
	public class wxGladeDialog : Dialog
	{
		public wxGladeDialog( Window parent )
		{
			XmlResource.Get().LoadDialog( this, parent, "wxglade_dialog" );
		
			EVT_BUTTON( wxID_OK, new EventListener( OnOK ) );
		}
		
		//---------------------------------------------------------------------	
		
		public void OnOK( object sender, Event e)
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

		[STAThread]
		static void Main()
		{
			Xrcdemo app = new Xrcdemo();			
			app.Run();
		}

		//---------------------------------------------------------------------
	}
}
