//-----------------------------------------------------------------------------
// wxD/Samples - SashWindow.cs
//
// wxD "SashWindow" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
private import std.string;

static if (__VERSION__ >= 2050) {
import std.conv : to;
version(D_Version2) mixin("alias to!string toString;");
}

	//---------------------------------------------------------------------	

	public class SashWindowFrame : Frame
	{
		public this( string title, Point pos, Size size )
		{
			super( title, pos, size );
			MainPanel mp = new MainPanel( this );

			TextCtrl textCtrl = new TextCtrl(this, -1, "", wxDefaultPosition, wxDefaultSize, 
				TextCtrl.wxTE_MULTILINE | TextCtrl.wxTE_READONLY | TextCtrl.wxSUNKEN_BORDER );

			Log.SetActiveTarget( textCtrl );

			BoxSizer bSizer = new BoxSizer( Orientation.wxVERTICAL );
			bSizer.Add( mp, 1, Stretch.wxGROW );
			bSizer.Add( textCtrl, 0, Stretch.wxGROW );

			sizer = bSizer;
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

		public LayoutAlgorithm la;

		//---------------------------------------------------------------------

		public this(Window parent)
		{
			super( parent );

			la = new LayoutAlgorithm();
			remainingSpace = new Panel( this, -1, wxDefaultPosition, wxDefaultSize, wxSUNKEN_BORDER );
			StaticText st = new StaticText( remainingSpace, -1, "I'm the remaining space Panel" );

			topWindow = new SashLayoutWindow( this, Cmd.ID_WINDOW_TOP, 
				wxDefaultPosition, Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			topWindow.DefaultSize = Size( 1000, 30 );
			topWindow.Orientation = LayoutOrientation.wxLAYOUT_HORIZONTAL;
			topWindow.Alignment = LayoutAlignment.wxLAYOUT_TOP;
			topWindow.BackgroundColour = new Colour( 255, 0, 0 );
			topWindow.SetSashVisible( SashEdgePosition.wxSASH_BOTTOM, true );
			StaticText st1 = new StaticText( topWindow, -1, "I'm the top SashLayoutWindow" );

			bottomWindow = new SashLayoutWindow( this, Cmd.ID_WINDOW_BOTTOM, 
				wxDefaultPosition, Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			bottomWindow.DefaultSize = Size( 1000, 30 );
			bottomWindow.Orientation = LayoutOrientation.wxLAYOUT_HORIZONTAL;
			bottomWindow.Alignment = LayoutAlignment.wxLAYOUT_BOTTOM;
			bottomWindow.BackgroundColour = new Colour( 0, 0, 255 );
			bottomWindow.SetSashVisible( SashEdgePosition.wxSASH_TOP, true );
			StaticText st2 = new StaticText( bottomWindow, -1, "I'm the bottom SashLayoutWindow" );

			leftWindow1 = new SashLayoutWindow( this, Cmd.ID_WINDOW_LEFT1, 
				wxDefaultPosition, Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			leftWindow1.DefaultSize = Size( 120, 1000 );
			leftWindow1.Orientation = LayoutOrientation.wxLAYOUT_VERTICAL;
			leftWindow1.Alignment = LayoutAlignment.wxLAYOUT_LEFT;
			leftWindow1.BackgroundColour = new Colour( 0, 255, 0 );
			leftWindow1.SetSashVisible( SashEdgePosition.wxSASH_RIGHT, true );
			leftWindow1.ExtraBorderSize = 10;
			TextCtrl leftWindow1tc = new TextCtrl( leftWindow1, -1, 
				"I'm a child of leftWindow1", wxDefaultPosition, 
				wxDefaultSize, TextCtrl.wxTE_MULTILINE | wxSUNKEN_BORDER );

			leftWindow2 = new SashLayoutWindow( this, Cmd.ID_WINDOW_LEFT2, 
				wxDefaultPosition, Size( 200, 30 ), 
				wxNO_BORDER | SashWindow.wxSW_3D );
			leftWindow2.DefaultSize = Size( 120, 1000 );
			leftWindow2.Orientation = LayoutOrientation.wxLAYOUT_VERTICAL;
			leftWindow2.Alignment = LayoutAlignment.wxLAYOUT_LEFT;
			leftWindow2.BackgroundColour = new Colour( 0, 255, 255 );
			leftWindow2.SetSashVisible( SashEdgePosition.wxSASH_RIGHT, true );
			leftWindow2.ExtraBorderSize = 15;
			TextCtrl leftWindow2tc = new TextCtrl( leftWindow2, -1, 
				"I'm a child of leftWindow2", wxDefaultPosition, 
				wxDefaultSize, TextCtrl.wxTE_MULTILINE | wxSUNKEN_BORDER );

			EVT_SASH_DRAGGED_RANGE( Cmd.ID_WINDOW_TOP, Cmd.ID_WINDOW_BOTTOM, & OnSashDraggedRange ) ;
			
			Resized_Add(& OnSize );
		}

		//---------------------------------------------------------------------

		public void OnSashDraggedRange( Object sender, Event e )
		{
			SashEvent se = cast(SashEvent) e;

			Log.LogMessage("OnSashDraggedRange:" );
			Log.LogMessage("DragStatus: " ~ .toString(cast(int)se.DragStatus) );
			Log.LogMessage("Event ID: " ~ .toString(cast(int)se.ID) );

			if ( se.DragStatus == SashDragStatus.wxSASH_STATUS_OUT_OF_RANGE )
				return;

			int eventID = e.ID;

			switch ( eventID )
			{
				case Cmd.ID_WINDOW_TOP:
					topWindow.DefaultSize = Size( 1000, se.DragRect.Height );
				break;

				case Cmd.ID_WINDOW_LEFT1:
					leftWindow1.DefaultSize = Size( se.DragRect.Width, 1000 );
				break;

				case Cmd.ID_WINDOW_LEFT2:
					leftWindow2.DefaultSize = Size( se.DragRect.Width, 1000 );
				break;

				case Cmd.ID_WINDOW_BOTTOM:
					bottomWindow.DefaultSize = Size( 1000, se.DragRect.Height );
				break;
			}

			la.LayoutWindow( this, remainingSpace );
			remainingSpace.Refresh();
		}

		//---------------------------------------------------------------------

		public void OnSize( Object sender, Event e )
		{
			Log.LogMessage("OnSize" );
			la.LayoutWindow( this, remainingSpace );
		}
	}

	//---------------------------------------------------------------------

	public class SashWindowApp : App
	{
		public override bool OnInit()
		{
			SashWindowFrame frame = new SashWindowFrame( "SashWindow wxWidgets Sample", Point( 10, 100), Size(650,340) );
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			SashWindowApp app = new SashWindowApp();
			app.Run();
		}

		//---------------------------------------------------------------------
	}

void main()
{
	SashWindowApp.Main();
}
