//-----------------------------------------------------------------------------
// wxD/Samples - Sound.d
//
// A wxD version of the wxWidgets "sound" sample.
//
// Written by Vaclav Slavik
// (c) 2004 Vaclav Salvik
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;

import wx.Sound;

string WAV_FILE = "doggrowl.wav";

	public class MyFrame : Frame
	{
		// IDs for the controls and the menu commands
		enum
		{
			// menu items
			Sound_Quit = MenuIDs.wxID_EXIT,
			Sound_About = MenuIDs.wxID_ABOUT,
			Sound_PlaySync = MenuIDs.wxID_HIGHEST + 1,
			Sound_PlayAsync,
			Sound_PlayAsyncOnStack,
			Sound_PlayLoop,
			Sound_SelectFile
		}

		//---------------------------------------------------------------------

		public this(string title)
		{
			super(title);

		    m_sound = null;
    		m_soundFile = WAV_FILE;

			// Set up a menu

			Menu helpMenu = new Menu();
			helpMenu.Append(Sound_About, "&About...\tF1", "Show about dialog");

			Menu fileMenu = new Menu();
			fileMenu.Append(Sound_SelectFile, "&Select WAV file\tCtrl+O", "Select a new wav file to play");
			fileMenu.Append(Sound_Quit, "E&xit\tAlt-X", "Quit this program");

			Menu playMenu = new Menu();
			playMenu.Append(Sound_PlaySync, "Play sound &synchronously\tCtrl+S");
			playMenu.Append(Sound_PlayAsync, "Play sound &asynchronously\tCtrl+A");
			playMenu.Append(Sound_PlayLoop, "&Loop sound\tCtrl+L");

			// now append the freshly created menu to the menu bar...
			MenuBar menuBar = new MenuBar();
			menuBar.Append(fileMenu, "&File");
			menuBar.Append(playMenu, "&Play");
			menuBar.Append(helpMenu, "&Help");

			// ... and attach this menu bar to the frame
			this.menuBar = menuBar;
			// Set up the event table

			EVT_MENU(Sound_SelectFile,	&OnSelectFile);
			EVT_MENU(Sound_Quit,    	&OnQuit);
			EVT_MENU(Sound_About,   	&OnAbout);
			EVT_MENU(Sound_PlaySync,    &OnPlaySync);
			EVT_MENU(Sound_PlayAsync,   &OnPlayAsync);
			EVT_MENU(Sound_PlayLoop,    &OnPlayLoop);

			m_tc = new TextCtrl(this, wxID_ANY, "",
								  wxDefaultPosition, wxDefaultSize,
								  TextCtrl.wxTE_MULTILINE|TextCtrl.wxTE_READONLY);
			NotifyUsingFile(m_soundFile);
		}

		private:
			Sound     m_sound;
			string    m_soundFile;
			TextCtrl  m_tc;

		//---------------------------------------------------------------------

		void NotifyUsingFile(string name)
		{
			string msg;
			msg = "Using sound file: " ~ name ~ "\n";
			m_tc.AppendText(msg);
		}

		//---------------------------------------------------------------------

		public void OnSelectFile(Object sender, Event e)
		{
			FileDialog dlg = new FileDialog (this, "Choose a sound file",
							 "", "", "WAV files (*.wav)|*.wav", FileDialog.wxOPEN|FileDialog.wxCHANGE_DIR);
			if ( dlg.ShowModal() == wxID_OK )
			{
				m_soundFile = dlg.Path;
				if (m_sound) delete m_sound;
				m_sound = null;
				NotifyUsingFile(m_soundFile);
			}
		}

		//---------------------------------------------------------------------

		public void OnQuit(Object sender, Event e)
		{
			// true is to force the frame to close
			Close(true);
		}

		//---------------------------------------------------------------------

		public void OnPlaySync(Object sender, Event e)
		{
			BusyCursor busy = new BusyCursor;
			if (!m_sound)
				m_sound = new Sound(m_soundFile);
			if (m_sound.IsOk())
				m_sound.Play(wxSOUND_SYNC);
			delete busy;
		}

		//---------------------------------------------------------------------

		public void OnPlayAsync(Object sender, Event e)
		{
			BusyCursor busy = new BusyCursor;
			if (!m_sound)
				m_sound = new Sound(m_soundFile);
			if (m_sound.IsOk())
				m_sound.Play(wxSOUND_ASYNC);
			delete busy;
		}

		//---------------------------------------------------------------------

		public void OnPlayLoop(Object sender, Event e)
		{
			BusyCursor busy = new BusyCursor;
			if (!m_sound)
				m_sound = new Sound(m_soundFile);
			if (m_sound.IsOk())
				m_sound.Play(wxSOUND_ASYNC | wxSOUND_LOOP);
			delete busy;
		}

		//---------------------------------------------------------------------

		public void OnAbout(Object sender, Event e)
		{
			string msg = "This is the About dialog of the sound sample.\nWelcome to " ~ wxVERSION_STRING;
			MessageBox(this, msg, "About", Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		//---------------------------------------------------------------------
	}



	public class MyApp : App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			// create the main application window
			MyFrame frame = new MyFrame("wxWidgets Sound Sample");

			// and show it (the frames, unlike simple controls, are not shown when
			// created initially)
			frame.Show(true);

			// success
    		return true;
		}

		//---------------------------------------------------------------------
	}

int main()
{
	MyApp app = new MyApp();
	app.Run();
	return 0;
}
