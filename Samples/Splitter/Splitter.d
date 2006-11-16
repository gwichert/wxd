//-----------------------------------------------------------------------------
// wxD/Samples - Splitter.d
//
// A wxD version of the wxWidgets "splitter" sample.
//
// Written by Jason Perkins (jason@379.com)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

	enum Cmd
	{
		Quit,
		SplitHorizontal,
		SplitVertical,
		Unsplit,
		SplitLive,
		SetPosition,
		SetMinSize
	}


	public class SplitterApp : App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			MyFrame frame = new MyFrame();
			frame.Show(true);
			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			SplitterApp app = new SplitterApp();
			app.Run();
		}

		//---------------------------------------------------------------------
	}


	public class MyFrame : Frame
	{
		private MySplitterWindow splitter;
		private MyCanvas         left, right;

		//---------------------------------------------------------------------

		public this()
		{
			super("wxSplitterWindow Sample",
			       wxDefaultPosition, new_Size(420,300),
			       wxDEFAULT_FRAME | wxNO_FULL_REPAINT_ON_RESIZE);
			Menu splitMenu = new Menu();
			splitMenu.Append(Cmd.SplitVertical, "Split &Vertically\tCtrl-V", "Split vertically");
			splitMenu.Append(Cmd.SplitHorizontal, "Split &Horizontally\tCtrl-H", "Split horizontally");
			splitMenu.Append(Cmd.Unsplit, "&Unsplit\tCtrl-U", "Unsplit");
			splitMenu.AppendSeparator();
			splitMenu.AppendCheckItem(Cmd.SplitLive, "&Live Update\tCtrl-L", "Toggle live update mode");
			splitMenu.Append(Cmd.SetPosition, "Set &Position\tCtrl-P", "Set the splitter position");
			splitMenu.Append(Cmd.SetMinSize, "Set &Minimum Size\tCtrl-M", "Set the minimum pane size");
			splitMenu.AppendSeparator();
			splitMenu.Append(Cmd.Quit, "E&xit\tAlt-X", "Exit");

			MenuBar menuBar = new MenuBar();
			menuBar.Append(splitMenu, "&Splitter");
			this.menuBar = menuBar;

			menuBar.Check(Cmd.SplitLive, true);

			CreateStatusBar(2);
			SetStatusText("Min pane size = 0", 1);

			splitter = new MySplitterWindow(this);

			left = new MyCanvas(splitter);
			left.BackgroundColour = new Colour("RED");
			left.SetScrollbars(20, 20, 50, 50);
			left.cursor = new Cursor(StockCursor.wxCURSOR_MAGNIFIER);

			right = new MyCanvas(splitter);
			right.BackgroundColour = new Colour("CYAN");
			right.SetScrollbars(20, 20, 50, 50);

			splitter.SplitVertically(left, right, 100);

			// Set up the event table

			EVT_MENU(Cmd.SplitVertical,    &SplitVertical);
			EVT_MENU(Cmd.SplitHorizontal,  &SplitHorizontal);
			EVT_MENU(Cmd.Unsplit,          &Unsplit);
			EVT_MENU(Cmd.SplitLive,        &ToggleLive);
			EVT_MENU(Cmd.SetPosition,      &SetPosition);
			EVT_MENU(Cmd.SetMinSize,       &SetMinSize);

			EVT_MENU(Cmd.Quit,             &OnQuit);

			EVT_UPDATE_UI(Cmd.SplitVertical,   &UpdateUIVertical);
			EVT_UPDATE_UI(Cmd.SplitHorizontal, &UpdateUIHorizontal);
			EVT_UPDATE_UI(Cmd.Unsplit,         &UpdateUIUnsplit);
		}

		//---------------------------------------------------------------------

		public void SplitHorizontal(Object sender, Event e)
		{
			if (splitter.IsSplit)
				splitter.Unsplit();

			left.Show(true);
			right.Show(true);

			splitter.SplitHorizontally(left, right);

			SetStatusText("Splitter split horizontally", 1);
		}

		public void SplitVertical(Object sender, Event e)
		{
			if (splitter.IsSplit)
				splitter.Unsplit();

			left.Show(true);
			right.Show(true);

			splitter.SplitVertically(left, right);

			SetStatusText("Splitter split vertically", 1);
		}

		public void Unsplit(Object sender, Event e)
		{
			if (splitter.IsSplit)
				splitter.Unsplit();
			SetStatusText("No splitter", 1);
		}

		public void ToggleLive(Object sender, Event e)
		{
			CommandEvent ce = cast(CommandEvent)e;
			if (ce.IsChecked)
				splitter.StyleFlags = splitter.StyleFlags | SplitterWindow.wxSP_LIVE_UPDATE;
			else
				splitter.StyleFlags = splitter.StyleFlags & ~SplitterWindow.wxSP_LIVE_UPDATE;
		}

		public void SetPosition(Object sender, Event e)
		{
		}

		public void SetMinSize(Object sender, Event e)
		{
		}

		//---------------------------------------------------------------------

		public void OnQuit(Object sender, Event e)
		{
			Close(true);
		}

		public void UpdateUIHorizontal(Object sender, Event e)
		{
			UpdateUIEvent ue = cast(UpdateUIEvent)e;
			ue.Enabled = (!splitter.IsSplit || splitter.splitMode != SplitMode.wxSPLIT_HORIZONTAL);
		}

		public void UpdateUIVertical(Object sender, Event e)
		{
			UpdateUIEvent ue = cast(UpdateUIEvent)e;
			ue.Enabled = (!splitter.IsSplit || splitter.splitMode != SplitMode.wxSPLIT_VERTICAL);
		}

		public void UpdateUIUnsplit(Object sender, Event e)
		{
			UpdateUIEvent ue = cast(UpdateUIEvent)e;
			ue.Enabled = splitter.IsSplit;
		}

		//---------------------------------------------------------------------
	}



	public class MySplitterWindow : SplitterWindow
	{
		private Frame parent;

		//---------------------------------------------------------------------

		public this(Frame parent)
		{
			super(parent, -1,
			       wxDefaultPosition, wxDefaultSize,
			       wxSP_3D | wxSP_LIVE_UPDATE | wxCLIP_CHILDREN);
			this.parent = parent;
		}

		//---------------------------------------------------------------------

		public void OnPositionChanged(Object sender, Event e)
		{
		}

		public void OnPositionChanging(Object sender, Event e)
		{
		}

		public void OnDoubleClick(Object sender, Event e)
		{
		}

		public void OnUnsplit(Object sender, Event e)
		{
		}

		//---------------------------------------------------------------------
	}


	public class MyCanvas : ScrolledWindow
	{
		//---------------------------------------------------------------------

		public this(Window parent)
		{
			super(parent);
		}

		//---------------------------------------------------------------------

		public override void OnDraw(DC dc)
		{
			dc.pen = new Pen("BLACK", 1, FillStyle.wxSOLID);
			dc.DrawLine(0, 0, 100, 100);

			dc.BackgroundMode = FillStyle.wxTRANSPARENT;
			dc.DrawText("Testing", 50, 50);

			dc.pen = new Pen("RED", 1, FillStyle.wxSOLID);
			dc.brush = new Brush("GREEN", FillStyle.wxSOLID);
			dc.DrawRectangle(120, 120, 100, 80);
		}

		//---------------------------------------------------------------------
	}


void main()
{
	SplitterApp.Main();
}
