//-----------------------------------------------------------------------------
// wx.NET/Samples - Launcher.cs
//
// wx.NET sample "Launcher".
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Collections;
using System.Diagnostics;
using System.IO;

namespace wx.Samples
{
	public class LauncherFrame : Frame
	{
		private MiddleHtmlWindow middleHtmlWindow = null;
		private TopHtmlWindow topHtmlWindow = null;
		private BottomHtmlWindow bottomHtmlWindow = null;
		
		//---------------------------------------------------------------------

		public LauncherFrame( string title, Point pos, Size size )
			: base(title, wxDefaultPosition, size)
		{
			Icon = new wx.Icon( "../Samples/Launcher/mondrian.png" );

			CreateStatusBar( 1 );
			StatusText = "Welcome...";	
			
			topHtmlWindow = new TopHtmlWindow( this );
			middleHtmlWindow = new MiddleHtmlWindow( this );
			bottomHtmlWindow = new BottomHtmlWindow( this );
			
			BoxSizer bs = new BoxSizer( Orientation.wxVERTICAL );
			
			bs.Add( topHtmlWindow, 0, Stretch.wxGROW );
			bs.Add( middleHtmlWindow, 1, Stretch.wxGROW );
			bs.Add( bottomHtmlWindow, 0, Stretch.wxGROW );
			
			Sizer = bs;
			
			CheckEnvironment();
		}
		
		//---------------------------------------------------------------------	
		
		private void CheckEnvironment()
		{
			// If we could determine they are running under PNET warn them
			// things probably won't work (at least as of v0.6.6)
			string clr = Environment.GetEnvironmentVariable("CLR_LAUNCHER");
			if (clr == "ilrun")
			{
				MessageDialog md = new MessageDialog(this, 
					"There is a bug in DotGNU Portable.NET as of v0.6.6 that does not allow the Launcher to work properly. Process.Start(\"ilrun example.exe\") does not work and results in a defunct process.\n\nYou may continue to use the Launcher; however, unless you have a newer version PNET samples probably won't launch when you click them.",
					"Launcher Error", Dialog.wxOK | Dialog.wxICON_WARNING);
				md.ShowModal();
			}
		}
	}   
	
	//---------------------------------------------------------------------	
	
	public class TopHtmlWindow : HtmlWindow
	{
		public TopHtmlWindow( LauncherFrame parent )
			: base( parent, -1, wxDefaultPosition, new Size( 400, 144 ) )
		{
			LoadPage( "../Samples/Launcher/launchertop.html" );
		}
	}
	
	//---------------------------------------------------------------------	
	
	public class BottomHtmlWindow : HtmlWindow
	{
		private LauncherFrame parent = null;
	
		public BottomHtmlWindow( LauncherFrame parent )
			: base( parent, -1, wxDefaultPosition, new Size( 400, 80 ) )
		{
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
	
		public MiddleHtmlWindow( LauncherFrame parent )
			: base( parent )
		{
			this.parent = parent;
		
			LoadPage( "../Samples/Launcher/wx.NETSamplesLauncher.html" );
		}
		
		//---------------------------------------------------------------------	
		
		public override void OnLinkClicked(HtmlLinkInfo link)
		{
			string app = link.Href;
			
			if ( System.IO.File.Exists( app + ".exe" ) )
			{
				string launch_command = "";

                                // If we are on a Linux platform, use wxnet-run script to
                                // launch samples. This is not used to pick up environment
                                // as this gets inherited. The script ensures we use the
                                // .NET runtime the user has selected.
                                if ( File.Exists( "wxnet-run" ) )
                                        launch_command = "./wxnet-run " + app + ".exe";

                                // On MacOS we need to launch the appropriate bundle
                                else if ( Directory.Exists( "../MacBundles" ) )
                                        launch_command = "open ../MacBundles/" + app + ".app";

                                // Everything else (Windows for now) just execute the assembly
                                else
                                        launch_command = app + ".exe";

				try
				{
					parent.StatusText = "Executing " + launch_command;		
					Process.Start( launch_command );
				}
				catch (Exception ex)
				{
					TellError("Error running command '" + launch_command + "': " +
						ex.Message);
				}
			}
			else
			{
				TellError("The sample " + app + " could not be found in the 'Bin' directory. The sample may not be available on your operating system or it could not be built because of missing development libraries.");
			}
		}
		
		//---------------------------------------------------------------------	

		private void TellError(string msg)
		{
			MessageDialog md = new MessageDialog(this, 
				"An error occured while trying to launch your sample:\n\n" + msg,
				"Sample Launch Error", Dialog.wxOK | Dialog.wxICON_WARNING);
			md.ShowModal();
		}
	}
	
	//---------------------------------------------------------------------	

	public class LauncherApp : wx.App
	{
		public override bool OnInit()
		{
			LauncherFrame frame = new LauncherFrame( "wx.NET Samples Launcher", new Point( 10, 100 ), new Size( 600, 600 ) );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			LauncherApp app = new LauncherApp();
			app.Run();
		}
	}
}
