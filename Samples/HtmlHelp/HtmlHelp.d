//-----------------------------------------------------------------------------
// wxD/Samples - HtmlHelp.cs
//
// wxD "HtmlHelpController" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

	public class MyFrame : Frame
	{
		public enum Cmd 
		{ 
			HtmlHelp_Quit,
			HtmlHelp_About,
			HtmlHelp_Help
		}
		
		private HtmlHelpController help;
		
		public this( Window parent, string title, Point pos, Size size ) 
		{
			super( parent, -1, title, pos, size )
;
			Menu menuFile = new Menu();
			
			menuFile.AppendWL( Cmd.HtmlHelp_Help, "&Help", "Test Help...", & OnHelp ) ;
			menuFile.AppendWL( Cmd.HtmlHelp_About, "&About", "About the sample...", & OnAbout ) ;
			menuFile.AppendWL( Cmd.HtmlHelp_Quit, "E&xit\tAlt-X", "Quit this program", & OnQuit ) ;
			
			MenuBar menuBar = new MenuBar();
			menuBar.Append( menuFile, "&File" );
			
			this.menuBar = menuBar;
			
			help = new HtmlHelpController( HtmlHelpController.wxHF_DEFAULT_STYLE | HtmlHelpController.wxHF_OPEN_FILES) ;
			
			help.UseConfig( Config.Get() );
			
			help.TempDir = "." ;
			
			bool ret = help.AddBook( "../Samples/HtmlHelp/helpfiles/testing.hhp" );
			if ( !ret )
				MessageBox( "Failed adding book ../Samples/HtmlHelp/helpfiles/testing.hhp" );
				
			ret = help.AddBook( "../Samples/HtmlHelp/helpfiles/another.hhp" );
			if ( !ret )
				MessageBox( "Failed adding book ../Samples/HtmlHelp/helpfiles/another.hhp" );
				
			this.Closing_Add(&OnClosing);
		}
		
		//---------------------------------------------------------------------
		
		public void OnQuit( Object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnHelp( Object sender, Event e )
		{
			help.Display( "Test HELPFILE" );
		}
		
		//---------------------------------------------------------------------
		
		public void OnClosing( Object sender, Event e )
		{
			if ( help.frame )
				help.frame.Close();
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnAbout( Object sender, Event e )
		{
			MessageBox( this, "HtmlHelpController class sample.\n" 
				"\n" 
				"Ported to wxD by BERO", "About HtmlHelpController", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}
	}
	
	//---------------------------------------------------------------------

	public class HtmlHelp : App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame( null, "HtmlHelpController sample", Window.wxDefaultPosition, Window.wxDefaultSize );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			HtmlHelp app = new HtmlHelp();
			app.Run();
		}
	}		



void main()
{
	HtmlHelp.Main();
}
