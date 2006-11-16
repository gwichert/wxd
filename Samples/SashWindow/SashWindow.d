//-----------------------------------------------------------------------------
// wx.NET/Samples - SashWindow.cs
//
// wx.NET "SashWindow" sample.
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
	//---------------------------------------------------------------------	

	public class SashWindowFrame : Frame
	{
		public SashWindowFrame( string title, Point pos, Size size )
			: base( title, pos, size )
		{
			MainPanel mp = new MainPanel( this );

			TextCtrl textCtrl = new TextCtrl(this, -1, "", wxDefaultPosition, wxDefaultSize, 
				TextCtrl.wxTE_MULTILINE | TextCtrl.wxTE_READONLY | TextCtrl.wxSUNKEN_BORDER );

			Log.SetActiveTarget( textCtrl );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( mp, 1, Stretch.wxGROW );
			bSizer.Add( textCtrl, 0, Stretch.wxGROW );

			Sizer = bSizer;
		}
	}

	//---------------------------------------------------------------------

	public class MainPanel : Panel
	{
		enum Cmd 
		{
			ID_WINDOW_TOP,
			ID_WINDOW_LEFT1,
			ID_WINDOW_LEFT2,
			ID_WINDOW_BOTTOM
		}

		//---------------------------------------------------------------------

		public SashLayoutWindow topWindow;
		public SashLayoutWindow bottomWindow;
		public SashLayoutWindow leftWindow1;
		public SashLayoutWindow leftWindow2;

		public Panel remainingSpace;

		public LayoutAlgorithm la = new LayoutAlgorithm();

		//---------------------------------------------------------------------

		public MainPanel(Window parent)
			: base( parent )
		{
			remainingSpace = new Panel( this, -1, wxDefaultPosition, wxDefaultSize, wxSUNKEN_BORDER );
			StaticText st = new StaticText( remainingSpace, -1, "I'm the remaining space Panel" );

			topWindow = new SashLayoutWindow( this, (int)Cmd.ID_WINDOW_TOP, 
				wxDefaultPosition, new Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			topWindow.DefaultSize = new Size( 1000, 30 );
			topWindow.Orientation = LayoutOrientation.wxLAYOUT_HORIZONTAL;
			topWindow.Alignment = LayoutAlignment.wxLAYOUT_TOP;
			topWindow.BackgroundColour = new Colour( 255, 0, 0 );
			topWindow.SetSashVisible( SashEdgePosition.wxSASH_BOTTOM, true );
			StaticText st1 = new StaticText( topWindow, -1, "I'm the top SashLayoutWindow" );

			bottomWindow = new SashLayoutWindow( this, (int)Cmd.ID_WINDOW_BOTTOM, 
				wxDefaultPosition, new Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			bottomWindow.DefaultSize = new Size( 1000, 30 );
			bottomWindow.Orientation = LayoutOrientation.wxLAYOUT_HORIZONTAL;
			bottomWindow.Alignment = LayoutAlignment.wxLAYOUT_BOTTOM;
			bottomWindow.BackgroundColour = new Colour( 0, 0, 255 );
			bottomWindow.SetSashVisible( SashEdgePosition.wxSASH_TOP, true );
			StaticText st2 = new StaticText( bottomWindow, -1, "I'm the bottom SashLayoutWindow" );

			leftWindow1 = new SashLayoutWindow( this, (int)Cmd.ID_WINDOW_LEFT1, 
				wxDefaultPosition, new Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			leftWindow1.DefaultSize = new Size( 120, 1000 );
			leftWindow1.Orientation = LayoutOrientation.wxLAYOUT_VERTICAL;
			leftWindow1.Alignment = LayoutAlignment.wxLAYOUT_LEFT;
			leftWindow1.BackgroundColour = new Colour( 0, 255, 0 );
			leftWindow1.SetSashVisible( SashEdgePosition.wxSASH_RIGHT, true );
			leftWindow1.ExtraBorderSize = 10;
			TextCtrl leftWindow1tc = new TextCtrl( leftWindow1, -1, 
				"I'm a child of leftWindow1", wxDefaultPosition, 
				wxDefaultSize, TextCtrl.wxTE_MULTILINE | wxSUNKEN_BORDER );

			leftWindow2 = new SashLayoutWindow( this, (int)Cmd.ID_WINDOW_LEFT2, 
				wxDefaultPosition, new Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			leftWindow2.DefaultSize = new Size( 120, 1000 );
			leftWindow2.Orientation = LayoutOrientation.wxLAYOUT_VERTICAL;
			leftWindow2.Alignment = LayoutAlignment.wxLAYOUT_LEFT;
			leftWindow2.BackgroundColour = new Colour( 0, 255, 255 );
			leftWindow2.SetSashVisible( SashEdgePosition.wxSASH_RIGHT, true );
			leftWindow2.ExtraBorderSize = 15;
			TextCtrl leftWindow2tc = new TextCtrl( leftWindow2, -1, 
				"I'm a child of leftWindow2", wxDefaultPosition, 
				wxDefaultSize, TextCtrl.wxTE_MULTILINE | wxSUNKEN_BORDER );

			EVT_SASH_DRAGGED_RANGE( (int)Cmd.ID_WINDOW_TOP, (int)Cmd.ID_WINDOW_BOTTOM, new EventListener( OnSashDraggedRange ) );
			
			Resized += new EventListener( OnSize );
		}

		//---------------------------------------------------------------------

		public void OnSashDraggedRange( object sender, Event e )
		{
			SashEvent se = (SashEvent) e;

			Log.LogMessage("OnSashDraggedRange:" );
			Log.LogMessage("DragStatus: " + se.DragStatus );
			Log.LogMessage("Event ID: " + se.ID );

			if ( se.DragStatus == SashDragStatus.wxSASH_STATUS_OUT_OF_RANGE )
				return;

			int eventID = e.ID;

			switch ( eventID )
			{
				case (int)Cmd.ID_WINDOW_TOP:
					topWindow.DefaultSize = new Size( 1000, se.DragRect.Height );
				break;

				case (int)Cmd.ID_WINDOW_LEFT1:
					leftWindow1.DefaultSize = new Size( se.DragRect.Width, 1000 );
				break;

				case (int)Cmd.ID_WINDOW_LEFT2:
					leftWindow2.DefaultSize = new Size( se.DragRect.Width, 1000 );
				break;

				case (int)Cmd.ID_WINDOW_BOTTOM:
					bottomWindow.DefaultSize = new Size( 1000, se.DragRect.Height );
				break;
			}

			la.LayoutWindow( this, remainingSpace );
			remainingSpace.Refresh();
		}

		//---------------------------------------------------------------------

		public void OnSize( object sender, Event e )
		{
			Log.LogMessage("OnSize" );
			la.LayoutWindow( this, remainingSpace );
		}
	}

	//---------------------------------------------------------------------

	public class SashWindowApp : wx.App
	{
		public override bool OnInit()
		{
			SashWindowFrame frame = new SashWindowFrame( "SashWindow wxWidgets Sample", new Point( 10, 100), new Size(650,340) );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			SashWindowApp app = new SashWindowApp();
			app.Run();
		}

		//---------------------------------------------------------------------
	}
}