//-----------------------------------------------------------------------------
// NET/Samples - Display.d
//
// A D version of the Widgets "display" sample with improvements.
//
// Ported by Michael S. Muegel mike _at_ muegel dot org
//
// Licensed	under the Widgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
import CompareModesDialog;

	// Client data class for the choice	control	containing the video modes
	public class MyVideoModeClientData : ClientData
	{
		public this(VideoMode m)
		{
			mode = m;
		}
		public VideoMode mode;
	}

	// Define a	new	application	type, each program should derive a class from App
	public class MyApp : App
	{
		public override	bool OnInit()
		{
			MyFrame	frame =	new	MyFrame("Display Windows Sample", 
				new_Point(-1, -1), new_Size(-1, -1));
			frame.Show(true);
			return true;
		}

		//---------------------------------------------------------------------

		
		static void	Main()
		{
			MyApp app =	new	MyApp();
			app.Run();
		}
	} // MyApp

	// Define a	new	frame type:	this is	going to be	our	main frame
	public class MyFrame : Frame
	{
		// menu items
		public const int ID_About = 100;
		public const int ID_Quit = 101;
		public const int ID_FromPoint = 102;
		public const int ID_FromPointError = 103;
		public const int ID_VideoModeCompare = 104;
		public const int ID_FullScreen = 105;

		// controls
		public const int ID_ChangeMode = 106;
		public const int ID_ResetMode = 107;
		public const int ID_CurrentMode = 108;

		// used within event handlers
		Notebook m_notebook;

		public this(string title, Point pos,	Size size)
		{
			super(title, pos, size);

			// Set up menus
			Menu menuDisplay = new Menu();
			menuDisplay.Append(ID_FromPoint, "Find display from &point ...");
			menuDisplay.Append(ID_FromPointError, "Simulate off screen find display from point ...");
			menuDisplay.Append(ID_VideoModeCompare, "Compare video modes for currently selected display ...");
			
			menuDisplay.AppendSeparator();
			menuDisplay.AppendCheckItem(ID_FullScreen,	"Full &screen\tF12");
			menuDisplay.AppendSeparator();
			menuDisplay.Append(ID_Quit, "E&xit\tAlt-X", "Quit this program");

			// the "About" item	should be in the help menu
			Menu helpMenu =	new	Menu();
			helpMenu.Append(ID_About, "&About...\tF1",	"Show about dialog");

			// now append the freshly created menu to the menu bar...
			MenuBar	menuBar	= new MenuBar();
			menuBar.Append(menuDisplay,	"&Display");
			menuBar.Append(helpMenu, "&Help");

			// ... and attach this menu	bar	to the frame
			MenuBar = menuBar;

			// create status bar
			CreateStatusBar();

			// create child	controls
			Panel panel	= new Panel(this, -1);
			m_notebook = new Notebook(panel, -1);

			int count = Display.Count;
			for	( int nDpy = 0; nDpy < count; nDpy++	)
			{
				Display	display	= new Display(nDpy);

				Window page	= new Panel(m_notebook,	-1);

				// create 2	column flex	grid sizer with	growable 2nd column
				FlexGridSizer sizer	= new FlexGridSizer(2, 10, 20);
				sizer.AddGrowableCol(1);

				Rectangle r = display.Geometry;
				sizer.Add(new StaticText(page, -1, "Origin:	"));
				sizer.Add(new StaticText(page, -1, r.Location.ToString()));

				sizer.Add(new StaticText(page, -1, "Size: "));
				sizer.Add(new StaticText(page, -1, r.Width + "," ~ r.Height));


				sizer.Add(new StaticText(page, -1, "Name: "));
				sizer.Add(new StaticText(page, -1, display.Name));

				// Added this to port
				sizer.Add(new StaticText(page, -1, "Is Primary?: "));
				sizer.Add(new StaticText(page, -1, display.IsPrimary.ToString()));

				Choice choiceModes	= new Choice(page, ID_ChangeMode);
				VideoMode[] modes	= display.GetModes();
				for	( int nMode = 0; nMode < modes.Length; nMode++ )
				{
					VideoMode mode = modes[nMode];

					choiceModes.Append(mode.ToString(),
						new	MyVideoModeClientData(mode));
				}

				sizer.Add(new StaticText(page, -1, "&Modes:	"));
				sizer.Add(choiceModes, 0, Stretch.wxEXPAND);

				sizer.Add(new StaticText(page, -1, "Current: "));
				sizer.Add(new StaticText(page, ID_CurrentMode,
					display.CurrentMode.ToString()));

				// add it to another sizer to have borders around it and button	below
				Sizer sizerTop	= new BoxSizer(Orientation.wxVERTICAL);
				sizerTop.Add(sizer,	1, Direction.wxALL | Stretch.wxEXPAND, 10);

				sizerTop.Add(new Button(page, ID_ResetMode, "&Reset mode"),
					0, Direction.wxALL | Dialog.wxCENTRE, 5);
				page.SetSizer(sizerTop);

				m_notebook.AddPage(page, "Display "	+ nDpy.ToString());
			}

			NotebookSizer notebookSizer	= new NotebookSizer(m_notebook);
			panel.SetSizer(notebookSizer);
			notebookSizer.Fit(this);


			// Bind	events
			EVT_MENU(ID_Quit,	new	EventListener(OnQuit));
			EVT_MENU(ID_FromPoint,	 &OnFromPoint);
			EVT_MENU(ID_FromPointError,	 &OnFromPointError);
			EVT_MENU(ID_VideoModeCompare,	 &OnCompareModes);
			EVT_MENU(ID_FullScreen, &OnFullScreen);
			EVT_MENU(ID_About,	new	EventListener(OnAbout));
			EVT_CHOICE(ID_ChangeMode, &OnChangeMode);
			EVT_BUTTON(ID_ResetMode, &OnResetMode);
			EVT_LEFT_UP(new	EventListener(OnLeftClick));
			EVT_DISPLAY_CHANGED(new	EventListener(OnDisplayChanged));

		} // MyFrame ctor

		// Menu	selection handlers
		public void	OnQuit(Object sender, Event	e)
		{
			Close(true);
		}

		public void	OnFromPoint(Object sender, Event e)
		{
			SetStatusText("Press the mouse anywhere...");
			CaptureMouse();
		}

		public void	OnFromPointError(Object sender, Event e)
		{
			ShowScreenFromPoint(new_Point(-9999, -9999));
		}

		public void	OnFullScreen(Object	sender,	Event e)
		{
			CommandEvent ce = cast(CommandEvent)e;
			ShowFullScreen(ce.IsChecked);
		}

		public void	OnAbout(Object sender, Event e)
		{
			string msg = "This is the wxWidgets display sample ported to C#. Port by Michael S. Muegel.";
			MessageBox(this, msg, "About Display Sample",
				Dialog.wxOK);
		}

		public void	OnChangeMode(Object	sender,	Event e)
		{
			CommandEvent ce = cast(CommandEvent)e;
			Display	display	= CurrentDisplay();
			VideoMode mode = cast(VideoMode) (cast(MyVideoModeClientData)ce.ClientObject).mode;
			if (! display.ChangeMode(mode))
				MessageBox(this, "Changing video mode failed!", 
					"Error", Dialog.wxOK | Dialog.wxICON_WARNING);
		}

		public void	OnResetMode(Object sender, Event e)
		{
			CurrentDisplay().ResetMode();
		}

		public void	OnLeftClick(Object sender, Event e)
		{
			if ( HasCapture() )
			{
				MouseEvent me = cast(MouseEvent)e;
				// mouse events	are	in client coords, Display works	in screen ones
				Point ptScreen = ClientToScreen(me.Position);
				ReleaseMouse();
				ShowScreenFromPoint(ptScreen);
			}
		}

		private void ShowScreenFromPoint(Point ptScreen)
		{
			int	dpy	= Display.GetFromPoint(ptScreen);

			if ( dpy ==	Display.wxNOT_FOUND )
				MessageBox(this, 
					"Mouse clicked outside of display at " ~ ptScreen.ToString(),
					"Error", Dialog.wxOK | Dialog.wxICON_WARNING);
			else
				MessageBox(this, "Mouse clicked in display #" +
					dpy.ToString() + " at " ~ ptScreen.ToString(), 
					"Click Result", Dialog.wxOK);

		}

		public void	OnDisplayChanged(Object	sender,	Event e)
		{
			// update the current mode text
			for	( int n = 0; n < m_notebook.PageCount; n++ )
			{
				StaticText label = cast(StaticText) m_notebook.GetPage(n).FindWindow(ID_CurrentMode);
				if ( label != null)
					label.Label = (new Display(n)).CurrentMode.toString();
			}


			MessageBox(this, "EVT_DISPLAY_CHANGED fired. Display resolution has been changed.", "Resolution Changed", Dialog.wxOK);

			e.Skip();
		}

		public void	OnCompareModes(Object sender, Event	e)
		{
			CompareModesDialog dialog = new CompareModesDialog(this, 
				-1, CurrentDisplay());
			dialog.ShowModal();
		}

		private Display CurrentDisplay()
		{
			return new Display(m_notebook.Selection);
		}

	} // MyFrame


	/*
	#ifdef __MSW__
		if ( argc == 2 && !Stricmp(argv[1],	 _T("/dx"))	)
		{
			Display::UseDirectX(true);
		}
	#endif // __MSW__
	*/

void main()
{
	MyApp.Main();
}
