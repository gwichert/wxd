//-----------------------------------------------------------------------------
// wxD/Samples - Launcher.d
//
// wxD sample "Launcher".
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
import std.process;
import std.c.process;

	public class LauncherFrame : Frame
	{
		private MiddleHtmlWindow middleHtmlWindow = null;
		private TopHtmlWindow topHtmlWindow = null;
		private BottomHtmlWindow bottomHtmlWindow = null;
		
		//---------------------------------------------------------------------

		public this( string title, Point pos, Size size )
		{
			super(title, wxDefaultPosition, size);
			icon = new Icon( "../Samples/Launcher/mondrian.png" );

			CreateStatusBar( 1 );
			StatusText = "Welcome...";	
			
			topHtmlWindow = new TopHtmlWindow( this );
			middleHtmlWindow = new MiddleHtmlWindow( this );
			bottomHtmlWindow = new BottomHtmlWindow( this );
			
			BoxSizer bs = new BoxSizer( Orientation.wxVERTICAL );
			
			bs.Add( topHtmlWindow, 0, Stretch.wxGROW );
			bs.Add( middleHtmlWindow, 1, Stretch.wxGROW );
			bs.Add( bottomHtmlWindow, 0, Stretch.wxGROW );
			
			sizer = bs;
			
			CheckEnvironment();
		}
		
		//---------------------------------------------------------------------	
		
		private void CheckEnvironment()
		{
			// If we could determine they are running under PNET warn them
			// things probably won't work (at cast(of)least v0.6.6)
			string clr; //= Environment.GetEnvironmentVariable("CLR_LAUNCHER");
			if (clr == "ilrun")
			{
				MessageDialog md = new MessageDialog(this, 
					"There is a bug in DotGNU cast(of)PortableD v0.6.6 that does not allow the Launcher to work properly. Process.Start(\"ilrun example.exe\") does not work and results in a defunct process.\n\nYou may continue to use the Launcher; however, unless you have a newer version PNET samples probably won't launch when you click them.",
					"Launcher Error", Dialog.wxOK | Dialog.wxICON_WARNING);
				md.ShowModal();
			}
		}
	}   
	
	//---------------------------------------------------------------------	
	
	public class TopHtmlWindow : HtmlWindow
	{
		public this( LauncherFrame parent )
		{
			super( parent, -1, wxDefaultPosition, new_Size( 400, 144 ) );
			LoadPage( "../Samples/Launcher/launchertop.html" );
		}
	}
	
	//---------------------------------------------------------------------	
	
	public class BottomHtmlWindow : HtmlWindow
	{
		private LauncherFrame parent = null;
	
		public this( LauncherFrame parent )
		{
			super( parent, -1, wxDefaultPosition, new_Size( 400, 80 ) );
			this.parent = parent;
			LoadPage( "../Samples/Launcher/launcherbottom.html" );
		}
		
		//---------------------------------------------------------------------	
		
		public override void OnLinkClicked(HtmlLinkInfo link)
		{
			if ( link.Href == "quit" )
			{
				parent.Close();
				return;
			}
		}
	}

	//---------------------------------------------------------------------	
	
	public class MiddleHtmlWindow : HtmlWindow
	{
		private LauncherFrame parent = null;
		
		//---------------------------------------------------------------------	
	
		public this( LauncherFrame parent )
		{
			super( parent );
			this.parent = parent;
		
			LoadPage( "../Samples/Launcher/wxDSamplesLauncher.html" );
		}
		
		//---------------------------------------------------------------------	
		
		public override void OnLinkClicked(HtmlLinkInfo link)
		{
			string app = link.Href;
			
			if ( std.file.exists( app ~ ".exe" ) )
			{
				string launch_command = "";

                                // If we are on a Linux platform, use wxnet-run script to
                                // launch samples. This is not used to pick up environment
                                // as this gets inherited. The script ensures we use the
                                // D runtime the user has selected.
                                if ( std.file.exists( "wxnet-run" ) )
                                        launch_command = "./wxnet-run " ~ app ~ ".exe";

                                // On MacOS we need to launch the appropriate bundle
                                else if ( std.file.exists( "../MacBundles" ) ) //FIXME: check directory
                                        launch_command = "open ../MacBundles/" ~ app ~ ".app";

                                // Everything else (Windows for now) just execute the assembly
                                else
                                        launch_command = app ~ ".exe";

				try
				{
					parent.StatusText = "Executing " ~ launch_command;		
					std.process.spawnvp(_P_NOWAIT, launch_command ,null);
				}
				catch (Exception ex)
				{
					TellError("Error running command '" ~ launch_command ~ "': " ~
						ex.msg);
				}
			}
			else
			{
				TellError("The sample " ~ app ~ " could not be found in the 'Bin' directory. The sample may not be available on your operating system or it could not be built because of missing development libraries.");
			}
		}
		
		//---------------------------------------------------------------------	

		private void TellError(string msg)
		{
			MessageDialog md = new MessageDialog(this, 
				"An error occured while trying to launch your sample:\n\n" ~ msg,
				"Sample Launch Error", Dialog.wxOK | Dialog.wxICON_WARNING);
			md.ShowModal();
		}
	}
	
	//---------------------------------------------------------------------	

	public class LauncherApp : App
	{
		public override bool OnInit()
		{
			LauncherFrame frame = new LauncherFrame( "wxD Samples Launcher", new_Point( 10, 100 ), new_Size( 600, 600 ) );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			LauncherApp app = new LauncherApp();
			app.Run();
		}
	}


void main()
{
	LauncherApp.Main();
}
