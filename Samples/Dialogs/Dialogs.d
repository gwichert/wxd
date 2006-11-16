//-----------------------------------------------------------------------------
// wx.NET/Samples - Dialogs.cs
//
// A wx.NET version of the wxWidgets "dialogs" sample.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.IO;

namespace wx.Samples
{
	public class MyFrame : Frame
	{
		enum Cmd 
		{
			ChooseColour = 1, ChooseFont,
			MessageBox, SingleChoice, MultiChoice,
			TextEntry, PasswordEntry,
			FileOpen, FileOpen2, FilesOpen, FileSave,
			DirChoose, DirNewChoose,
			Tip, NumEntry, LogDialog,
			Modal, Modeless, ModelessBtn,
			Progress, Busyinfo,
			Find, Replace,
			Exit
		}

		// for FileOpen2
		public static string s_extDef;

		// for Find and Replace
		public FindReplaceData m_findData;
		public FindReplaceDialog m_dlgFind;
		public FindReplaceDialog m_dlgReplace;

		public MyModelessDialog m_dialog;

		private MyCanvas canvas;

		//---------------------------------------------------------------------

		public MyFrame(string title, Point pos, Size size)
			: base(title, pos, size)
		{
			// Set the window icon
			Icon = new Icon("../Samples/Dialogs/mondrian.png");

			// Set up a menu
			Menu fileMenu = new Menu();
			fileMenu.Append((int)Cmd.ChooseColour,	"&Choose Colour");
			fileMenu.AppendSeparator();
			fileMenu.Append((int)Cmd.ChooseFont, 	"Choose &Font");
			fileMenu.AppendSeparator();
			fileMenu.Append((int)Cmd.LogDialog, 	"&Log dialog\tCtrl-L");
			fileMenu.Append((int)Cmd.MessageBox, 	"&Message Box\tCtrl-M");
			fileMenu.Append((int)Cmd.TextEntry, 	"Text &entry\tCtrl-E");
			fileMenu.Append((int)Cmd.PasswordEntry, 	"&Password entry\tCtrl-P");
			fileMenu.Append((int)Cmd.NumEntry, 		"&Numeric entry\tCtrl-N");
			fileMenu.Append((int)Cmd.SingleChoice, 	"&Single choice\tCtrl-C");
			fileMenu.Append((int)Cmd.MultiChoice, 	"M&ultiple choice\tCtrl-U");
			fileMenu.AppendSeparator();
			fileMenu.Append((int)Cmd.Tip,		"&Tip of the day\tCtrl-T");
			fileMenu.AppendSeparator();
			fileMenu.Append((int)Cmd.FileOpen, 		"&Open file\tCtrl-O");
			fileMenu.Append((int)Cmd.FileOpen2, 	"&Second open file\tCtrl-2");
			fileMenu.Append((int)Cmd.FilesOpen, 	"Open &files\tCtrl-Q");
			fileMenu.Append((int)Cmd.FileSave, 		"Sa&ve file\tCtrl-S");
			fileMenu.Append((int)Cmd.DirChoose, 	"Choose &Directory\tCtrl-D");
			fileMenu.Append((int)Cmd.Progress, 		"Pro&gress dialog\tCtrl-G");
			fileMenu.Append((int)Cmd.Busyinfo, 		"&Busy info dialog\tCtrl-B");
			fileMenu.AppendCheckItem((int)Cmd.Find,	"&Find dialog\tCtrl-F", "");
			fileMenu.AppendCheckItem((int)Cmd.Replace,	"Find and &replace dialog\tShift-Ctrl-F", "");
			fileMenu.AppendSeparator();
			fileMenu.Append((int)Cmd.Modal,	"Mo&dal dialog\tCtrl-W");
			fileMenu.AppendCheckItem((int)Cmd.Modeless,	"Modeless &dialog\tCtrl-Z", "");

			fileMenu.AppendSeparator();

			fileMenu.Append((int)Cmd.Exit, "E&xit\tAlt-X");

			MenuBar menuBar = new MenuBar();
			menuBar.Append(fileMenu, "&File");

			MenuBar = menuBar;

			// Set up a status bar
			CreateStatusBar();

			// Create the canvas for drawing
			canvas = new MyCanvas(this);

			// Set up the event table
			EVT_MENU((int)Cmd.ChooseColour,     new EventListener(OnChooseColour));
			EVT_MENU((int)Cmd.ChooseFont,       new EventListener(OnChooseFont));

			EVT_MENU((int)Cmd.DirChoose,        new EventListener(OnDirChoose));

			EVT_MENU((int)Cmd.LogDialog,	new EventListener(OnLogDialog));
			EVT_MENU((int)Cmd.MessageBox,	new EventListener(OnMessageBox));
			EVT_MENU((int)Cmd.TextEntry,	new EventListener(OnTextEntry));
			EVT_MENU((int)Cmd.PasswordEntry,	new EventListener(OnPasswordEntry));
			EVT_MENU((int)Cmd.NumEntry,		new EventListener(OnNumericEntry));
			EVT_MENU((int)Cmd.SingleChoice,	new EventListener(OnSingleChoice));
			EVT_MENU((int)Cmd.MultiChoice,	new EventListener(OnMultiChoice));

			EVT_MENU((int)Cmd.Tip,		new EventListener(OnTip));

			EVT_MENU((int)Cmd.FileOpen,		new EventListener(OnFileOpen));
			EVT_MENU((int)Cmd.FileOpen2,	new EventListener(OnFileOpen2));
			EVT_MENU((int)Cmd.FilesOpen,	new EventListener(OnFilesOpen));
			EVT_MENU((int)Cmd.FileSave,		new EventListener(OnFileSave));
			EVT_MENU((int)Cmd.Progress,		new EventListener(OnProgress));
			EVT_MENU((int)Cmd.Busyinfo,		new EventListener(OnBusyinfo));
			EVT_MENU((int)Cmd.Find,		new EventListener(OnFind));
			EVT_MENU((int)Cmd.Replace,		new EventListener(OnReplace));
			EVT_MENU((int)Cmd.Modal,		new EventListener(OnModal));
			EVT_MENU((int)Cmd.Modeless,		new EventListener(OnModeless));

			EVT_FIND(-1,			new EventListener(OnFindEvent));
			EVT_FIND_NEXT(-1,			new EventListener(OnFindEvent));
			EVT_FIND_REPLACE(-1,		new EventListener(OnFindEvent));
			EVT_FIND_REPLACE_ALL(-1,		new EventListener(OnFindEvent));
			EVT_FIND_CLOSE(-1,			new EventListener(OnFindEvent));

			EVT_MENU((int)Cmd.Exit,             new EventListener(OnExit));

			m_findData = new FindReplaceData();
		}

		//---------------------------------------------------------------------

		public void OnChooseColour(object sender, Event e)
		{
			ColourData data = new ColourData();

			data.Colour = canvas.BackgroundColour;
			data.ChooseFull = true;

			for(int i = 0; i < 16; i++) 
			{
				byte rgb = (byte)(i * 16);
				Colour col = new Colour(rgb, rgb, rgb);
				data.SetCustomColour(i, col);
			}

			ColourDialog cd = new ColourDialog(this, data);
			cd.Title = "Choose the background colour";

			if (cd.ShowModal() == wxID_OK) 
			{
				canvas.BackgroundColour = cd.ColourData.Colour;
				//canvas.Clear();
				canvas.Refresh();
			}
		}

		public void OnChooseFont(object sender, Event e)
		{
			FontData data = new FontData();
			data.InitialFont = canvas.font;
			data.Colour = canvas.textColour;

			FontDialog fd = new FontDialog(this, data);

			if (fd.ShowModal() == wxID_OK) 
			{
				canvas.font = fd.FontData.ChosenFont;
				canvas.textColour = fd.FontData.Colour;
				canvas.Refresh();
			}
		}

		public void OnDirChoose(object sender, Event e)
		{
			string dirHome = Directory.GetCurrentDirectory();
			DirDialog dlg = new DirDialog(this, "Testing directory picker",
				dirHome);

			if (dlg.ShowModal() == Dialog.wxID_OK) 
			{
				Log.LogMessage("Selected path: " + dlg.Path);
			}
		}

		public void OnLogDialog(object sender, Event e)
		{
		{
			BusyCursor bc = new BusyCursor();
			Log.LogMessage("This is some message - everything is ok so far.");
			Log.LogMessage("Another message...\n... this one is on multiple lines");
			Log.LogWarning("And then something went wrong!");

			//Utils.wxYield();
			bc.Dispose();
		}

			Log.LogError("Intermediary error handler decided to abort.");
			Log.LogError("The top level caller detected an unrecoverable error.");

			Log.FlushActive();

			Log.LogMessage("And this is the same dialog but with only one message.");
		}

		public void OnMessageBox(object sender, Event e)
		{
			MessageDialog md = new MessageDialog(this, "This is a message box\nA long, long string to test out the message box properly",
				"Message box text", Dialog.wxNO_DEFAULT|Dialog.wxYES_NO|Dialog.wxCANCEL|Dialog.wxICON_INFORMATION);

			switch (md.ShowModal())
			{
				case Dialog.wxID_YES:		Log.LogStatus("You pressed \"Yes\"");
					break;
				case Dialog.wxID_NO:		Log.LogStatus("You pressed \"No\"");
					break;
				case Dialog.wxID_CANCEL:	Log.LogStatus("You pressed \"Cancel\"");
					break;
				default:			Log.LogStatus("Unexpected wxMessageDialog return code!");
					break;
			}
		}

		public void OnTextEntry(object sender, Event e)
		{
			TextEntryDialog ted = new TextEntryDialog(this,
				"This is a small sample\n" +
				"A long, long string to test out the text entrybox",
				"Please enter a string",
				"Default value",
				Dialog.wxOK | Dialog.wxCANCEL);

			if (ted.ShowModal() == Dialog.wxID_OK)
			{
				MessageDialog md = new MessageDialog(this, ted.Value, "Got string");
				md.ShowModal();
			}
		}

		public void OnPasswordEntry(object sender, Event e)
		{
			string pwd = new GetPasswordFromUser("Enter password:",
				"Password entry dialog",
				"",
				this);

			if (pwd.Length > 0)
			{
				MessageDialog md = new MessageDialog(this, "Your password is "+pwd, "Got password");
				md.ShowModal();
			}
		}

		public void OnNumericEntry(object sender, Event e)
		{
			long res = GetNumberFromUser( "This is some text, actually a lot of text.\n" +
				"Even two rows of text.",
				"Enter a number:",
				"Numeric input test",
				50, 0, 100, this );

			string msg;
			long icon;
			if ( res == -1 )
			{
				msg = "Invalid number entered or dialog cancelled.";
				icon = Dialog.wxICON_HAND;
			}
			else
			{
				msg = "You've entered " + res;
				icon = Dialog.wxICON_INFORMATION;
			}

			MessageDialog md = new MessageDialog(this, msg, "Numeric test result", Dialog.wxOK | icon);
			md.ShowModal();
		}

		public void OnSingleChoice(object sender, Event e)
		{
			string[] choices = { "One", "Two", "Three", "Four", "Five"};

			SingleChoiceDialog scd = new SingleChoiceDialog(this,"This is a small sample\n" +
				"A single-choice dialog",
				"Please select a value",
				choices);
			scd.SetSelection(2);

			if (scd.ShowModal() == wxID_OK)
			{
				MessageDialog md = new MessageDialog(this, scd.GetStringSelection(), "Got string");
				md.ShowModal();
			}
		}

		public void OnMultiChoice(object sender, Event e)
		{
			// OnMultiChoice uses MultiChoiceDialog instead of GetMultipleChoices which isn't implemented yet
			string[] choices = new string[] {
														  "One", "Two", "Three", "Four", "Five",
														  "Six", "Seven", "Eight", "Nine", "Ten",
														  "Eleven", "Twelve", "Seventeen" };

			MultiChoiceDialog mcd = new MultiChoiceDialog(this, "This is a small sample\n" +
				"A multi-choice convenience dialog",
				"Please select a value",
				choices);
			if (mcd.ShowModal() == wxID_OK)
			{
				int[] selections = mcd.GetSelections();
				int count = selections.Length;
				string msg;
				msg = "You selected " + count + " items:\n";
				for (int n = 0; n < count; n++)
				{
					msg += "\t" + n + ": " + selections[n] + " (" + choices[selections[n]] + ")\n";
				}

				MessageDialog md = new MessageDialog(this, msg, "Information");
				md.ShowModal();
			}

		}

		public void OnTip(object sender, Event e)
		{
			// we have to use a IntPtr, class wxTipProvider is abstract and wxFileTipProvider private
			IntPtr tp = TipProvider.CreateFileTipProvider("../Samples/Dialogs/tips.txt", new Random().Next());

			bool showAtStartup = TipProvider.ShowTip(this, tp);

			if ( showAtStartup )
			{
				wx.MessageDialog.ShowModal(this, "Will show tips on startup", "Tips dialog",
					Dialog.wxOK | Dialog.wxICON_INFORMATION);
			}

			// does nothing, only for example
			int s_index = TipProvider.CurrentTip;
		}

		public void OnFileOpen(object sender, Event e)
		{
			FileDialog fd = new FileDialog(this,
				"Testing open file dialog",
				"",
				"",
				"cs files (*.cs)|*.cs");

			fd.Directory = Utils.GetHomeDir();

			if (fd.ShowModal() == wxID_OK)
			{
				string info = "Full file name: " + fd.Path + "\n" +
					"Path: " + fd.Directory + "\n" +
					"Name: " + fd.Filename;
				MessageDialog md = new MessageDialog(this, info, "Selected file");
				md.ShowModal();
			}
		}

		public void OnFileOpen2(object sender, Event e)
		{
			string path = new FileSelector( "Select the file to load",
				"", "", s_extDef,
				"Waveform (*.wav)|*.wav|Plain text (*.txt)|*.txt|All files (*.*)|*.*",
				FileSelector.wxCHANGE_DIR,
				this );
			if (path.Length == 0) return;

			s_extDef = path.Substring(path.LastIndexOf(".") + 1);

			MessageDialog md = new MessageDialog(this,
				"You selected the file '" + path +
				"', remembered extension '" + s_extDef + "'",
				"FileOpen2");
			md.ShowModal();
		}

		public void OnFilesOpen(object sender, Event e)
		{
			FileDialog fd = new FileDialog(this,
				"Testing open multiple file dialog",
				"", "", "*",
				FileDialogStyle.wxMULTIPLE);

			if (fd.ShowModal() == wxID_OK)
			{
				string[] paths, filenames;
				paths = fd.Paths;
				filenames = fd.Filenames;

				string msg = "";
				for (int n = 0; n < paths.Length; n++)
				{
					msg += "File " + n + ": " + paths[n] + " " +
						" (" + filenames[n] + ")\n";
				}

				MessageDialog md = new MessageDialog(this, msg, "Selected files");
				md.ShowModal();
			}
		}

		public void OnFileSave(object sender, Event e)
		{
			FileDialog fd = new FileDialog(this,
				"Testing save file dialog",
				"",
				"myletter.doc",
				"Text files (*.txt)|*.txt|Document files (*.doc)|*.doc",
				FileDialogStyle.wxSAVE | FileDialogStyle.wxOVERWRITE_PROMPT);

			fd.FilterIndex = 1;

			if (fd.ShowModal() == wxID_OK)
			{
				MessageDialog md = new MessageDialog(this, fd.Path + ", filter " + fd.FilterIndex, "FileSave");
				md.ShowModal();
			}
		}

		public void OnProgress(object sender, Event e)
		{
			int max = 10;

			ProgressDialog pd = new ProgressDialog(
				"Progress dialog example",
				"An informative message",
				max,
				this,
				ProgressDialog.wxPD_CAN_ABORT |
				ProgressDialog.wxPD_APP_MODAL |
				// ProgressDialog.wxPD_AUTO_HIDE | -- try this as well
				ProgressDialog.wxPD_ELAPSED_TIME |
				ProgressDialog.wxPD_ESTIMATED_TIME |
				ProgressDialog.wxPD_REMAINING_TIME);

			bool cont = true;
			for ( int i = 0; i <= max; i++)
			{
				System.Threading.Thread.Sleep(1000);
				if ( i == max )
				{
					cont = pd.Update(i, "That's all, folks!");
				}
				else if ( i == max / 2 )
				{
					cont = pd.Update(i, "Only a half left (very long message)!");
				}
				else
				{
					cont = pd.Update(i);
				}
				if ( !cont )
				{
					MessageDialog md = new MessageDialog(this,
						"Do you really want to cancel?",
						"Progress dialog question",
						Dialog.wxYES_NO | Dialog.wxICON_QUESTION);
					if (md.ShowModal() == wxID_YES)
					{
						// use Dispose() or Show(false) to close the ProgressDialog
						// otherwise the dialog won't get closed and the app hangs
						//pd.Dispose();
						pd.Show(false);					
						break;
					}
					pd.Resume();
				}
			}
		
			pd.Dispose();
		}

		public void OnBusyinfo(object sender, Event e)
		{
			WindowDisabler disableAll = new WindowDisabler();

			BusyInfo info = new BusyInfo("Working, please wait...", this);

			for ( int i = 0; i < 18; i++ )
			{
				App.GetApp().Yield();
				// or Utils.wxYield();
			}

			System.Threading.Thread.Sleep(1500);

			// how can this be done automatically ???
			disableAll.Dispose();
			info.Dispose();
		}

		public void OnFind(object sender, Event e)
		{
			m_dlgFind = new FindReplaceDialog(
				this,
				m_findData,
				"Find Dialog",
				FindReplaceDialog.wxFR_NOWHOLEWORD);
			m_dlgFind.Show(true);
		}

		public void OnReplace(object sender, Event e)
		{
			m_dlgReplace = new FindReplaceDialog(
				this,
				m_findData,
				"Find and replace dialog",
				FindReplaceDialog.wxFR_REPLACEDIALOG);
			m_dlgReplace.Show(true);
		}

		public string DecodeFindDialogEventFlags(int flags)
		{
			string 	str = (((flags & FindReplaceDialog.wxFR_DOWN) != 0) ? "down" : "up") + ", " +
				(((flags & FindReplaceDialog.wxFR_WHOLEWORD) != 0) ? "whole words only, " : "") +
				(((flags & FindReplaceDialog.wxFR_MATCHCASE) != 0) ? "" : "not ") +
				"case sensitive";

			return str;
		}

		public void OnFindEvent(object sender, Event e)
		{
			FindDialogEvent fre= (FindDialogEvent)e;
			int etype = fre.EventType;

			if ( etype == Event.wxEVT_COMMAND_FIND   || etype == Event.wxEVT_COMMAND_FIND_NEXT )
			{
				Log.LogMessage("Find {0}'{1}' (flags: {2})",
					etype == Event.wxEVT_COMMAND_FIND_NEXT ? "next " : "",
					fre.FindString,
					DecodeFindDialogEventFlags(fre.Flags));
			}
			else if ( etype == Event.wxEVT_COMMAND_FIND_REPLACE ||
				etype == Event.wxEVT_COMMAND_FIND_REPLACE_ALL )
			{
				Log.LogMessage("Replace {0}'{1}' with '{2}' (flags: {3})",
					etype == Event.wxEVT_COMMAND_FIND_REPLACE_ALL ? "all " : "",
					fre.FindString,
					fre.ReplaceString,
					DecodeFindDialogEventFlags(fre.Flags));
			}
			else if ( etype == Event.wxEVT_COMMAND_FIND_CLOSE )
			{
				FindReplaceDialog dlg = fre.Dialog;

				int idMenu;
				string txt;
				if ( dlg == m_dlgFind )
				{
					txt = "Find";
					idMenu = (int)Cmd.Find;
					m_dlgFind = null;
				}
				else if ( dlg == m_dlgReplace )
				{
					txt = "Replace";
					idMenu = (int)Cmd.Replace;
					m_dlgReplace = null;
				}
				else
				{
					txt = "Unknown";
					idMenu = -1;

					// wxFAIL_MSG...
					Log.LogError("unexpected event");
				}

				Log.LogMessage("{0} dialog is being closed.", txt);

				if ( idMenu != -1 )
				{
					MenuBar.Check(idMenu, false);
				}

				dlg.Destroy();
			}
			else
			{
				Log.LogError("Unknown find dialog event!");
			}
		}

		public void OnModal(object sender, Event e)
		{
			MyModalDialog dlg = new MyModalDialog(this);
			dlg.ShowModal();
		}

		public void OnModeless(object sender, Event e)
		{
			CommandEvent ce = (CommandEvent) e;
			bool show = MenuBar.IsChecked(ce.ID);

			if ( show )
			{
				m_dialog = new MyModelessDialog(this);
				m_dialog.Show(true);
			}
			else
			{
				m_dialog.Hide();
			}
		}

		//---------------------------------------------------------------------

		public void OnExit(object sender, Event e)
		{
			Close(true);
		}

		//---------------------------------------------------------------------
	}

	public class MyCanvas : ScrolledWindow
	{
		public Font font;
		public Colour textColour;

		public MyCanvas(Window parent)
			: base(parent)
		{
			font = Font.wxNORMAL_FONT;
			textColour = new Colour(0, 0, 0);
			
			EVT_PAINT(new EventListener(OnPaint));
		}

		public void OnPaint(object sender, Event e)
		{
			PaintDC dc = new PaintDC(this);
			dc.Font = font;
			dc.TextForeground = textColour;
			dc.BackgroundMode = FillStyle.wxTRANSPARENT;
			dc.DrawText("wxWidgets common dialogs test application", 10, 10);
			dc.Dispose(); //needed
		}
	}

	//---------------------------------------------------------------------

	public class MyModelessDialog : Dialog
	{
		enum Id 
		{
			DIALOG_MODELESS_BTN = 1
		}

		public MyModelessDialog(Window parent)
			: base(parent, -1, "Modeless dialog")
		{
			BoxSizer sizerTop = new BoxSizer(Orientation.wxVERTICAL);

			Button btn = new Button(this, (int)Id.DIALOG_MODELESS_BTN, "Press me");
			CheckBox check = new CheckBox(this, -1, "Should be disabled");
			check.Disable();

			sizerTop.Add(btn, 1, Stretch.wxEXPAND | Direction.wxALL, 5);
			sizerTop.Add(check, 1, Stretch.wxEXPAND | Direction.wxALL, 5);

			AutoLayout = true;
			SetSizer(sizerTop);

			sizerTop.SetSizeHints(this);
			sizerTop.Fit(this);

			EVT_BUTTON((int)Id.DIALOG_MODELESS_BTN, new EventListener(OnButton));
			EVT_CLOSE(new EventListener(OnClose));
		}

		public void OnButton(object sender, Event e)
		{
			wx.MessageDialog.ShowModal(this, "Button pressed in modeless dialog", "Info",
				Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		public void OnClose(object sender, Event e)
		{
			// must add CloseEvent...
			// must add Event.Veto
		}
	}

	//---------------------------------------------------------------------

	public class MyModalDialog : Dialog
	{
		public Button m_btnFocused;
		public Button m_btnDelete;

		public MyModalDialog(Window parent)
			: base(parent, -1, "Modal dialog")
		{
			BoxSizer sizerTop = new BoxSizer(Orientation.wxHORIZONTAL);

			m_btnFocused = new Button(this, -1, "Default button");
			m_btnDelete = new Button(this, -1, "&Delete button");
			Button btnOk = new Button(this, wxID_CANCEL, "&Close");
			sizerTop.Add(m_btnFocused, 0, Alignment.wxALIGN_CENTER | Direction.wxALL, 5);
			sizerTop.Add(m_btnDelete, 0, Alignment.wxALIGN_CENTER | Direction.wxALL, 5);
			sizerTop.Add(btnOk, 0, Alignment.wxALIGN_CENTER | Direction.wxALL, 5);

			AutoLayout = true;
			SetSizer(sizerTop);

			sizerTop.SetSizeHints(this);
			sizerTop.Fit(this);

			m_btnFocused.SetFocus();
			m_btnFocused.SetDefault();

			EVT_BUTTON(-1, new EventListener(OnButton));
		}

		public void OnButton(object sender, Event e)
		{
			CommandEvent ce = (CommandEvent) e;

			if ( ce.EventObject == m_btnDelete )
			{
				//m_btnFocused = null;
				m_btnDelete.Disable();
				m_btnFocused.Hide();
			}
			else if (ce.EventObject == m_btnFocused )
			{
				new GetTextFromUser("Dummy prompt",
					"Modal dialog called from dialog",
					"", this);
			}
			else
			{
				e.Skip();
			}
		}
	}

	public class Dialogs : App
	{
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			MyFrame frame = new MyFrame("wxWidgets Dialogs Example",
				new Point(50,50), new Size(450,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			Dialogs app = new Dialogs();
			app.Run();
		}

		//---------------------------------------------------------------------
	}
}
