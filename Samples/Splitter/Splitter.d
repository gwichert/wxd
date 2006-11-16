//-----------------------------------------------------------------------------
// wx.NET/Samples - Splitter.cs
//
// A wx.NET version of the wxWidgets "splitter" sample.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;

namespace wx.Samples
{
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


	public class SplitterApp : wx.App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			MyFrame frame = new MyFrame();
			frame.Show(true);
			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			SplitterApp app = new SplitterApp();
			app.Run();
		}

		//---------------------------------------------------------------------
	}


	public class MyFrame : wx.Frame
	{
		private MySplitterWindow splitter;
		private MyCanvas         left, right;

		//---------------------------------------------------------------------

		public MyFrame()
			: base("wxSplitterWindow Sample",
			       wxDefaultPosition, new Size(420,300),
			       wxDEFAULT_FRAME | wxNO_FULL_REPAINT_ON_RESIZE)
		{
			wx.Menu splitMenu = new wx.Menu();
			splitMenu.Append((int)Cmd.SplitVertical, "Split &Vertically\tCtrl-V", "Split vertically");
			splitMenu.Append((int)Cmd.SplitHorizontal, "Split &Horizontally\tCtrl-H", "Split horizontally");
			splitMenu.Append((int)Cmd.Unsplit, "&Unsplit\tCtrl-U", "Unsplit");
			splitMenu.AppendSeparator();
			splitMenu.AppendCheckItem((int)Cmd.SplitLive, "&Live Update\tCtrl-L", "Toggle live update mode");
			splitMenu.Append((int)Cmd.SetPosition, "Set &Position\tCtrl-P", "Set the splitter position");
			splitMenu.Append((int)Cmd.SetMinSize, "Set &Minimum Size\tCtrl-M", "Set the minimum pane size");
			splitMenu.AppendSeparator();
			splitMenu.Append((int)Cmd.Quit, "E&xit\tAlt-X", "Exit");

			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append(splitMenu, "&Splitter");
			MenuBar = menuBar;

			menuBar.Check((int)Cmd.SplitLive, true);

			CreateStatusBar(2);
			SetStatusText("Min pane size = 0", 1);

			splitter = new MySplitterWindow(this);

			left = new MyCanvas(splitter);
			left.BackgroundColour = new wx.Colour("RED");
			left.SetScrollbars(20, 20, 50, 50);
			left.Cursor = new Cursor(StockCursor.wxCURSOR_MAGNIFIER);

			right = new MyCanvas(splitter);
			right.BackgroundColour = new wx.Colour("CYAN");
			right.SetScrollbars(20, 20, 50, 50);

			splitter.SplitVertically(left, right, 100);

			// Set up the event table

			EVT_MENU((int)Cmd.SplitVertical,    new EventListener(SplitVertical));
			EVT_MENU((int)Cmd.SplitHorizontal,  new EventListener(SplitHorizontal));
			EVT_MENU((int)Cmd.Unsplit,          new EventListener(Unsplit));
			EVT_MENU((int)Cmd.SplitLive,        new EventListener(ToggleLive));
			EVT_MENU((int)Cmd.SetPosition,      new EventListener(SetPosition));
			EVT_MENU((int)Cmd.SetMinSize,       new EventListener(SetMinSize));

			EVT_MENU((int)Cmd.Quit,             new EventListener(OnQuit));

			EVT_UPDATE_UI((int)Cmd.SplitVertical,   new EventListener(UpdateUIVertical));
			EVT_UPDATE_UI((int)Cmd.SplitHorizontal, new EventListener(UpdateUIHorizontal));
			EVT_UPDATE_UI((int)Cmd.Unsplit,         new EventListener(UpdateUIUnsplit));
		}

		//---------------------------------------------------------------------

		public void SplitHorizontal(object sender, wx.Event e)
		{
			if (splitter.IsSplit)
				splitter.Unsplit();

			left.Show(true);
			right.Show(true);

			splitter.SplitHorizontally(left, right);

			SetStatusText("Splitter split horizontally", 1);
		}

		public void SplitVertical(object sender, wx.Event e)
		{
			if (splitter.IsSplit)
				splitter.Unsplit();

			left.Show(true);
			right.Show(true);

			splitter.SplitVertically(left, right);

			SetStatusText("Splitter split vertically", 1);
		}

		public void Unsplit(object sender, wx.Event e)
		{
			if (splitter.IsSplit)
				splitter.Unsplit();
			SetStatusText("No splitter", 1);
		}

		public void ToggleLive(object sender, wx.Event e)
		{
			CommandEvent ce = (CommandEvent)e;
			if (ce.IsChecked)
				splitter.StyleFlags |= SplitterWindow.wxSP_LIVE_UPDATE;
			else
				splitter.StyleFlags &= ~SplitterWindow.wxSP_LIVE_UPDATE;
		}

		public void SetPosition(object sender, wx.Event e)
		{
		}

		public void SetMinSize(object sender, wx.Event e)
		{
		}

		//---------------------------------------------------------------------

		public void OnQuit(object sender, wx.Event e)
		{
			Close(true);
		}

		public void UpdateUIHorizontal(object sender, wx.Event e)
		{
			UpdateUIEvent ue = (UpdateUIEvent)e;
			ue.Enabled = (!splitter.IsSplit || splitter.SplitMode != SplitMode.wxSPLIT_HORIZONTAL);
		}

		public void UpdateUIVertical(object sender, wx.Event e)
		{
			UpdateUIEvent ue = (UpdateUIEvent)e;
			ue.Enabled = (!splitter.IsSplit || splitter.SplitMode != SplitMode.wxSPLIT_VERTICAL);
		}

		public void UpdateUIUnsplit(object sender, wx.Event e)
		{
			UpdateUIEvent ue = (UpdateUIEvent)e;
			ue.Enabled = splitter.IsSplit;
		}

		//---------------------------------------------------------------------
	}



	public class MySplitterWindow : wx.SplitterWindow
	{
		private Frame parent;

		//---------------------------------------------------------------------

		public MySplitterWindow(wx.Frame parent)
			: base(parent, -1,
			       wxDefaultPosition, wxDefaultSize,
			       wxSP_3D | wxSP_LIVE_UPDATE | wxCLIP_CHILDREN)
		{
			this.parent = parent;
		}

		//---------------------------------------------------------------------

		public void OnPositionChanged(object sender, wx.Event e)
		{
		}

		public void OnPositionChanging(object sender, wx.Event e)
		{
		}

		public void OnDoubleClick(object sender, wx.Event e)
		{
		}

		public void OnUnsplit(object sender, wx.Event e)
		{
		}

		//---------------------------------------------------------------------
	}


	public class MyCanvas : wx.ScrolledWindow
	{
		//---------------------------------------------------------------------

		public MyCanvas(Window parent)
			: base(parent)
		{
		}

		//---------------------------------------------------------------------

		public override void OnDraw(wx.DC dc)
		{
			dc.Pen = new Pen("BLACK", 1, FillStyle.wxSOLID);
			dc.DrawLine(0, 0, 100, 100);

			dc.BackgroundMode = FillStyle.wxTRANSPARENT;
			dc.DrawText("Testing", 50, 50);

			dc.Pen = new Pen("RED", 1, FillStyle.wxSOLID);
			dc.Brush = new Brush("GREEN", FillStyle.wxSOLID);
			dc.DrawRectangle(120, 120, 100, 80);
		}

		//---------------------------------------------------------------------
	}
}
