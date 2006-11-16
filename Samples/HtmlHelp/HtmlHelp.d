//-----------------------------------------------------------------------------
// wx.NET/Samples - HtmlHelp.cs
//
// wx.NET "HtmlHelpController" sample.
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
	public class MyFrame : Frame
	{
		public enum Cmd 
		{ 
			HtmlHelp_Quit,
			HtmlHelp_About,
			HtmlHelp_Help
		}
		
		private HtmlHelpController help;
		
		public MyFrame( Window parent, string title, Point pos, Size size ) 
			: base( parent, -1, title, pos, size )
		{
			Menu menuFile = new Menu();
			
			menuFile.AppendWL( (int)Cmd.HtmlHelp_Help, "&Help", "Test Help...", new EventListener( OnHelp ) );
			menuFile.AppendWL( (int)Cmd.HtmlHelp_About, "&About", "About the sample...", new EventListener( OnAbout ) );
			menuFile.AppendWL( (int)Cmd.HtmlHelp_Quit, "E&xit\tAlt-X", "Quit this program", new EventListener( OnQuit ) );
			
			MenuBar menuBar = new MenuBar();
			menuBar.Append( menuFile, "&File" );
			
			MenuBar = menuBar;
			
			help = new HtmlHelpController( HtmlHelpController.wxHF_DEFAULT_STYLE | HtmlHelpController.wxHF_OPEN_FILES) ;
			
			help.UseConfig( Config.Get() );
			
			help.TempDir = "." ;
			
			bool ret = help.AddBook( "../Samples/HtmlHelp/helpfiles/testing.hhp" );
			if ( !ret )
				MessageDialog.MessageBox( "Failed adding book ../Samples/HtmlHelp/helpfiles/testing.hhp" );
				
			ret = help.AddBook( "../Samples/HtmlHelp/helpfiles/another.hhp" );
			if ( !ret )
				MessageDialog.MessageBox( "Failed adding book ../Samples/HtmlHelp/helpfiles/another.hhp" );
				
			this.Closing += new EventListener(OnClosing);
		}
		
		//---------------------------------------------------------------------
		
		public void OnQuit( object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnHelp( object sender, Event e )
		{
			help.Display( "Test HELPFILE" );
		}
		
		//---------------------------------------------------------------------
		
		public void OnClosing( object sender, Event e )
		{
			if ( help.Frame != null )
				help.Frame.Close();
			e.Skip();
		}
		
		//---------------------------------------------------------------------
		
		public void OnAbout( object sender, Event e )
		{
			MessageDialog.ShowModal( this, "HtmlHelpController class sample.\n" +
				"\n" +
				"Ported to wx.NET by Alexander Olk", "About HtmlHelpController", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}
	}
	
	//---------------------------------------------------------------------

	public class HtmlHelp : wx.App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame( null, "HtmlHelpController sample", Window.wxDefaultPosition, Window.wxDefaultSize );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			HtmlHelp app = new HtmlHelp();
			app.Run();
		}
	}		
}

