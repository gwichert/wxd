//-----------------------------------------------------------------------------
// wx.NET/Samples - Thread.cs
//
// A wx.NET thread sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2005 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Threading;

namespace wx.Samples
{
	public class MyFrame : wx.Frame
	{
		enum Cmd { Quit, StartThread, StopThread }
		
		private MyButton myButton;
		
		//---------------------------------------------------------------------

		public MyFrame( string title, Point pos, Size size )
			: base( title, pos, size )
		{
			wx.Menu fileMenu = new wx.Menu();
			fileMenu.Append( (int)Cmd.Quit, "E&xit\tAlt-X", "Quit this program" );

			wx.Menu threadMenu = new wx.Menu();
			threadMenu.Append( (int)Cmd.StartThread, "&Start Thread" );
			threadMenu.Append( (int)Cmd.StopThread, "St&op Thread" );

			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append( fileMenu, "&File" );
			menuBar.Append( threadMenu, "&Thread" );

			MenuBar = menuBar;
			
			myButton = new MyButton( this, "Text to change" );

			// Set up the event table

			EVT_MENU( (int)Cmd.Quit,    new EventListener(OnQuit) );
			EVT_MENU( (int)Cmd.StartThread,  new EventListener(OnStartThread) );
			EVT_MENU( (int)Cmd.StopThread,   new EventListener(OnStopThread) );
		}

		//---------------------------------------------------------------------

		public void OnQuit( object sender, wx.Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------

		public void OnStartThread( object sender, wx.Event e )
		{
			myButton.StartThread();
		}

		//---------------------------------------------------------------------
		
		public void OnStopThread( object sender, wx.Event e )
		{
			myButton.StopThread();
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyButton : wx.Button
	{
		private Thread updater_thread = null;
		
		private bool isThreadRunning = false;
		
		private string text = "This will be changed if you start the thread...";
		
		private long counter = 0;
		
		//---------------------------------------------------------------------
	
		public MyButton( Window parent, string label )
			: base( parent, label )
		{
			ObjectDeleted = new ObjectDeletedHandler( MyObjectDeleted );
			
			EVT_UPDATE_UI( ID, new EventListener( OnUpdateUI ) );
		}
		
		//---------------------------------------------------------------------
		
		public void OnUpdateUI( object sender, Event e )
		{
			Label = text;
		}
		
		//---------------------------------------------------------------------
		
		public void IncText()
		{
			text = "counter: " + counter++;
		}
		
		//---------------------------------------------------------------------
		
		public void StartThread()
		{
			updater_thread = new Thread( new ThreadStart( ThreadFunc ) );
			isThreadRunning = true;
			updater_thread.IsBackground = true;
			updater_thread.Start();
		}
		
		//---------------------------------------------------------------------
		
		public void StopThread()
		{
			isThreadRunning = false;
		}
		
		//---------------------------------------------------------------------
		
		public void MyObjectDeleted()
		{
			Console.WriteLine( "The object got deleted inside the c++ wrapper lib..." );
			
			isThreadRunning = false;
		}
		
		//---------------------------------------------------------------------
		
		void ThreadFunc()
		{
			Console.WriteLine( "Thread started..." );
		
			try
			{
				while ( true )
				{
					Thread.Sleep( 100 );
				
					if ( !isThreadRunning )
						break;
						
					IncText();
						
					EventHandler.AddPendingEvent( new UpdateUIEvent( ID ) );
				}
			}
			finally
			{
				updater_thread = null;
			}
			
			Console.WriteLine( "Thread stopped..." );
		}
	}
	
	//---------------------------------------------------------------------

	public class Threads : wx.App
	{
		public override bool OnInit()
		{
			MyFrame frame = new MyFrame( "wx.NET Thread sample", new Point( 50, 50 ), new Size( 450, 340 ) );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			Threads app = new Threads();
			app.Run();
		}
	}
}
