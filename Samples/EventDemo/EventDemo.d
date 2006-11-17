// Generated with wxg2wxnet
// (C) 2004 by Alexander Olk (xenomorph2@onlinehome.de)

//-----------------------------------------------------------------------------
// NET/Samples - EventDemo.d
//
// A wxD sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------
 
import wx.wx;

	public class EventDemoApp : App 
	{
		public override bool OnInit()
		{
			EventDemoFrame _eventdemoframe = new EventDemoFrame( null, -1, "" );
			_eventdemoframe.Show( true );
 
			return true;
		}
 
		//---------------------------------------------------------------------
 
		
		static void Main()
		{
			EventDemoApp app = new EventDemoApp();
			app.Run();
		}
	}
 
	//---------------------------------------------------------------------
 
	public class EventDemoFrame : Frame
	{
		// Do not change the code between region and endregion ( incl. region and endregion )...
		//#region Wxg2wxnet IDS: EventDemoFrame
		public enum Cmd {
			ID_MAINBUTTON,
			ID_MENU_ABOUT,
			ID_MENU_ABOUT2,
			ID_MENU_EXIT,
			ID_MENU_EVENT_1,
			ID_MENU_EVENT_2
		}
		//#endregion

		//---------------------------------------------------------------------
 
		// Do not change the code between region and endregion ( incl. region and endregion )...
		//#region Wxg2wxnet Objects: EventDemoFrame
		protected Button mainbutton;
		//#endregion
		
		protected MenuItem menuItemExit;
		protected MenuItem menuItemAbout;
		
		DummyClass1 dc1;
		DummyClass2 dc2;
 
		//---------------------------------------------------------------------
 
		public this( Window parent, int id, string title )
		{
			super( parent, id , "New Event Demo", wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE );
			dc1 = new DummyClass1();
			dc2 = new DummyClass2();
 

			// Do not change the code between region and endregion ( incl. region and endregion )...
			//#region Wxg2wxnet CTOR: EventDemoFrame
			mainbutton = new Button( this, Cmd.ID_MAINBUTTON, "Press Me" );
			//#endregion
			
			Menu fileMenu = new Menu();
			
			menuItemExit = new MenuItem( fileMenu, Cmd.ID_MENU_EXIT, "E&xit" );
			menuItemAbout = new MenuItem( fileMenu, Cmd.ID_MENU_ABOUT, "&About..." );
			
			fileMenu.Append( menuItemAbout );
			
			fileMenu.AppendWL( Cmd.ID_MENU_ABOUT2, "&About2...", & OnMenuAboutClicked ) ;
			
			fileMenu.Append( menuItemExit );     
			
			Menu eventMenu = new Menu();
			
			eventMenu.AppendWL( Cmd.ID_MENU_EVENT_1, "&Remove 2. mainbutton handler", & OnMenuRemoveHandler ) ;
			eventMenu.AppendWL( Cmd.ID_MENU_EVENT_2, "&Readd 2. mainbutton handler", & OnMenuReaddHandler ) ;
			
			MenuBar menu_bar = new MenuBar();
			menu_bar.Append( fileMenu, "&File" );
			menu_bar.Append( eventMenu, "&Events" );

			this.menuBar = menu_bar;
			
			SetWxProperties();
			DoWxLayout();
			
			mainbutton.Click_Add(& OnButtonClicked );
			mainbutton.Click_Add(& dc1.OnButtonClicked );
			mainbutton.Click_Add(& dc2.OnButtonClicked );
			
			menuItemExit.Click_Add(& OnMenuExitClicked );
			menuItemAbout.Click_Add(& OnMenuAboutClicked );
		}
		
		//---------------------------------------------------------------------
		
		public void OnButtonClicked( Object sender, Event e )
		{
			MessageBox("I get called first", "Message dialog EventDemoFrame",
							Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}
		
		//---------------------------------------------------------------------
		
		public void OnMenuExitClicked( Object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnMenuAboutClicked( Object sender, Event e )
		{
			MessageBox("This is the about Box...", "EventDemoFrame About...",
							Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}
		
		//---------------------------------------------------------------------
		
		public void OnMenuRemoveHandler( Object sender, Event e )
		{
			mainbutton.Click_Remove(&dc1.OnButtonClicked) ;
		}
		
		//---------------------------------------------------------------------
		
		public void OnMenuReaddHandler( Object sender, Event e )
		{
			mainbutton.Click_Add(& dc1.OnButtonClicked );
		}
 
		//---------------------------------------------------------------------
 
		public void SetWxProperties()
		{
			// Do not change the code between region and endregion ( incl. region and endregion )...
			//#region Wxg2wxnet PROPERTIES: EventDemoFrame
			Title = "New Event Demo";
			mainbutton.SetDefault();
			//#endregion
		}
 
		//---------------------------------------------------------------------
 
		public void DoWxLayout()
		{
			// Do not change the code between region and endregion ( incl. region and endregion )...
			//#region Wxg2wxnet LAYOUT: EventDemoFrame
 
			BoxSizer sizer_1 = new BoxSizer( Orientation.wxVERTICAL );
			sizer_1.Add( mainbutton, 1, Direction.wxALL|Stretch.wxEXPAND, 2 );
			sizer_1.Fit( this );
			sizer_1.SetSizeHints( this );
			AutoLayout = true;
			SetSizer( sizer_1 );
			Layout();
			//#endregion
		}
	}
	
	//---------------------------------------------------------------------
	
	public class DummyClass1
	{
		public void OnButtonClicked( Object sender, Event e )
		{
			MessageBox("I am second", "Message dialog DummyClass1",
							Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}
	}
	
	//---------------------------------------------------------------------
 
	public class DummyClass2
	{
		public void OnButtonClicked( Object sender, Event e )
		{
			MessageBox("And I am the third", "Message dialog DummyClass2",
							Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}
	}

 

void main()
{
	EventDemoApp.Main();
}
