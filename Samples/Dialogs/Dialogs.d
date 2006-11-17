//-----------------------------------------------------------------------------
// wxD/Samples - Dialogs.d
//
// A wxD version of the wxWidgets "dialogs" sample.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
private import std.string;
private import std.random;
alias std.string.find indexOf;
alias std.string.rfind LastIndexOf;

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
		public static string s_extDef="";

		// for Find and Replace
		public FindReplaceData m_findData;
		public FindReplaceDialog m_dlgFind;
		public FindReplaceDialog m_dlgReplace;

		public MyModelessDialog m_dialog;

		private MyCanvas canvas;

		//---------------------------------------------------------------------

		public this(string title, Point pos, Size size)
		{
			super(title, pos, size);
			// Set the window icon
			icon = new Icon("../Samples/Dialogs/mondrian.png");

			// Set up a menu
			Menu fileMenu = new Menu();
			fileMenu.Append(Cmd.ChooseColour,	"&Choose Colour");
			fileMenu.AppendSeparator();
			fileMenu.Append(Cmd.ChooseFont, 	"Choose &Font");
			fileMenu.AppendSeparator();
			fileMenu.Append(Cmd.LogDialog, 	"&Log dialog\tCtrl-L");
			fileMenu.Append(Cmd.MessageBox, 	"&Message Box\tCtrl-M");
			fileMenu.Append(Cmd.TextEntry, 	"Text &entry\tCtrl-E");
			fileMenu.Append(Cmd.PasswordEntry, 	"&Password entry\tCtrl-P");
			fileMenu.Append(Cmd.NumEntry, 		"&Numeric entry\tCtrl-N");
			fileMenu.Append(Cmd.SingleChoice, 	"&Single choice\tCtrl-C");
			fileMenu.Append(Cmd.MultiChoice, 	"M&ultiple choice\tCtrl-U");
			fileMenu.AppendSeparator();
			fileMenu.Append(Cmd.Tip,		"&Tip of the day\tCtrl-T");
			fileMenu.AppendSeparator();
			fileMenu.Append(Cmd.FileOpen, 		"&Open file\tCtrl-O");
			fileMenu.Append(Cmd.FileOpen2, 	"&Second open file\tCtrl-2");
			fileMenu.Append(Cmd.FilesOpen, 	"Open &files\tCtrl-Q");
			fileMenu.Append(Cmd.FileSave, 		"Sa&ve file\tCtrl-S");
			fileMenu.Append(Cmd.DirChoose, 	"Choose &Directory\tCtrl-D");
			fileMenu.Append(Cmd.Progress, 		"Pro&gress dialog\tCtrl-G");
			fileMenu.Append(Cmd.Busyinfo, 		"&Busy info dialog\tCtrl-B");
			fileMenu.AppendCheckItem(Cmd.Find,	"&Find dialog\tCtrl-F", "");
			fileMenu.AppendCheckItem(Cmd.Replace,	"Find and &replace dialog\tShift-Ctrl-F", "");
			fileMenu.AppendSeparator();
			fileMenu.Append(Cmd.Modal,	"Mo&dal dialog\tCtrl-W");
			fileMenu.AppendCheckItem(Cmd.Modeless,	"Modeless &dialog\tCtrl-Z", "");

			fileMenu.AppendSeparator();

			fileMenu.Append(Cmd.Exit, "E&xit\tAlt-X");

			MenuBar menuBar = new MenuBar();
			menuBar.Append(fileMenu, "&File");

			this.menuBar = menuBar;

			// Set up a status bar
			CreateStatusBar();

			// Create the canvas for drawing
			canvas = new MyCanvas(this);

			// Set up the event table
			EVT_MENU(Cmd.ChooseColour,     &OnChooseColour);
			EVT_MENU(Cmd.ChooseFont,       &OnChooseFont);

			EVT_MENU(Cmd.DirChoose,        &OnDirChoose);

			EVT_MENU(Cmd.LogDialog,	&OnLogDialog);
			EVT_MENU(Cmd.MessageBox,	&OnMessageBox);
			EVT_MENU(Cmd.TextEntry,	&OnTextEntry);
			EVT_MENU(Cmd.PasswordEntry,	&OnPasswordEntry);
			EVT_MENU(Cmd.NumEntry,		&OnNumericEntry);
			EVT_MENU(Cmd.SingleChoice,	&OnSingleChoice);
			EVT_MENU(Cmd.MultiChoice,	&OnMultiChoice);

			EVT_MENU(Cmd.Tip,		&OnTip);

			EVT_MENU(Cmd.FileOpen,		&OnFileOpen);
			EVT_MENU(Cmd.FileOpen2,	&OnFileOpen2);
			EVT_MENU(Cmd.FilesOpen,	&OnFilesOpen);
			EVT_MENU(Cmd.FileSave,		&OnFileSave);
			EVT_MENU(Cmd.Progress,		&OnProgress);
			EVT_MENU(Cmd.Busyinfo,		&OnBusyinfo);
			EVT_MENU(Cmd.Find,		&OnFind);
			EVT_MENU(Cmd.Replace,		&OnReplace);
			EVT_MENU(Cmd.Modal,		&OnModal);
			EVT_MENU(Cmd.Modeless,		&OnModeless);

			EVT_FIND(-1,			&OnFindEvent);
			EVT_FIND_NEXT(-1,			&OnFindEvent);
			EVT_FIND_REPLACE(-1,		&OnFindEvent);
			EVT_FIND_REPLACE_ALL(-1,		&OnFindEvent);
			EVT_FIND_CLOSE(-1,			&OnFindEvent);

			EVT_MENU(Cmd.Exit,             &OnExit);

			m_findData = new FindReplaceData();
		}

		//---------------------------------------------------------------------

		public void OnChooseColour(Object sender, Event e)
		{
			ColourData data = new ColourData();

			data.colour = canvas.BackgroundColour;
			data.ChooseFull = true;

			for(int i = 0; i < 16; i++) 
			{
				ubyte rgb = cast(ubyte)(i * 16);
				Colour col = new Colour(rgb, rgb, rgb);
				data.SetCustomColour(i, col);
			}

			ColourDialog cd = new ColourDialog(this, data);
			cd.Title = "Choose the background colour";

			if (cd.ShowModal() == wxID_OK) 
			{
				canvas.BackgroundColour = cd.colourData.colour;
				//canvas.Clear();
				canvas.Refresh();
			}
		}

		public void OnChooseFont(Object sender, Event e)
		{
			FontData data = new FontData();
			data.InitialFont = canvas.font;
			data.colour = canvas.textColour;

			FontDialog fd = new FontDialog(this, data);

			if (fd.ShowModal() == wxID_OK) 
			{
				canvas.font = fd.fontData.ChosenFont;
				canvas.textColour = fd.fontData.colour;
				canvas.Refresh();
			}
		}

		public void OnDirChoose(Object sender, Event e)
		{
			string dirHome = std.file.getcwd();
			DirDialog dlg = new DirDialog(this, "Testing directory picker",
				dirHome);

			if (dlg.ShowModal() == Dialog.wxID_OK) 
			{
				Log.LogMessage("Selected path: " ~ dlg.Path);
			}
		}

		public void OnLogDialog(Object sender, Event e)
		{
		{
			BusyCursor bc = new BusyCursor();
			Log.LogMessage("This is some message - everything is ok so far.");
			Log.LogMessage("Another message...\n... this one is on multiple lines");
			Log.LogWarning("And then something went wrong!");

			//wxYield();
			bc.Dispose();
		}

			Log.LogError("Intermediary error handler decided to abort.");
			Log.LogError("The top level caller detected an unrecoverable error.");

			Log.FlushActive();

			Log.LogMessage("And this is the same dialog but with only one message.");
		}

		public void OnMessageBox(Object sender, Event e)
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

		public void OnTextEntry(Object sender, Event e)
		{
			TextEntryDialog ted = new TextEntryDialog(this,
				"This is a small sample\n" ~
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

		public void OnPasswordEntry(Object sender, Event e)
		{
			string pwd = GetPasswordFromUser("Enter password:",
				"Password entry dialog",
				"",
				this);

			if (pwd.length > 0)
			{
				MessageDialog md = new MessageDialog(this, "Your password is " ~ pwd, "Got password");
				md.ShowModal();
			}
		}

		public void OnNumericEntry(Object sender, Event e)
		{
			int res = GetNumberFromUser( "This is some text, actually a lot of text.\n" ~
				"Even two rows of text.",
				"Enter a number:",
				"Numeric input test",
				50, 0, 100, this );

			string msg;
			int icon;
			if ( res == -1 )
			{
				msg = "Invalid number entered or dialog cancelled.";
				icon = Dialog.wxICON_HAND;
			}
			else
			{
				msg = "You've entered " ~ .toString(res);
				icon = Dialog.wxICON_INFORMATION;
			}

			MessageDialog md = new MessageDialog(this, msg, "Numeric test result", Dialog.wxOK | icon);
			md.ShowModal();
		}

		public void OnSingleChoice(Object sender, Event e)
		{
			const string[] choices = [ "One", "Two", "Three", "Four", "Five"];

			SingleChoiceDialog scd = new SingleChoiceDialog(this,"This is a small sample\n" ~
				"A single-choice dialog",
				"Please select a value",
				choices);
			scd.Selection = 2;

			if (scd.ShowModal() == wxID_OK)
			{
				MessageDialog md = new MessageDialog(this, scd.StringSelection(), "Got string");
				md.ShowModal();
			}
		}

		public void OnMultiChoice(Object sender, Event e)
		{
			// OnMultiChoice uses MultiChoiceDialog instead of GetMultipleChoices which isn't implemented yet
			const string[] choices = [
														  "One", "Two", "Three", "Four", "Five",
														  "Six", "Seven", "Eight", "Nine", "Ten",
														  "Eleven", "Twelve", "Seventeen" ];

			MultiChoiceDialog mcd = new MultiChoiceDialog(this, "This is a small sample\n" ~
				"A multi-choice convenience dialog",
				"Please select a value",
				choices);
			if (mcd.ShowModal() == wxID_OK)
			{
				int[] selections = mcd.GetSelections();
				int count = selections.length;
				string msg;
				msg = "You selected " ~ .toString(count) ~ " items:\n";
				for (int n = 0; n < count; n++)
				{
					msg ~= "\t" ~ .toString(n) ~ ": " ~ .toString(selections[n]) ~ " (" ~ choices[selections[n]] ~ ")\n";
				}

				MessageDialog md = new MessageDialog(this, msg, "Information");
				md.ShowModal();
			}

		}

		public void OnTip(Object sender, Event e)
		{
			// we have to use a IntPtr, class wxTipProvider is abstract and wxFileTipProvider private
			IntPtr tp = TipProvider.CreateFileTipProvider("../Samples/Dialogs/tips.txt", std.random.rand());

			bool showAtStartup = TipProvider.ShowTip(this, tp);

			if ( showAtStartup )
			{
				MessageBox(this, "Will show tips on startup", "Tips dialog",
					Dialog.wxOK | Dialog.wxICON_INFORMATION);
			}

			// does nothing, only for example
			int s_index = TipProvider.CurrentTip;
		}

		public void OnFileOpen(Object sender, Event e)
		{
			FileDialog fd = new FileDialog(this,
				"Testing open file dialog",
				"",
				"",
				"cs files (*.cs)|*.cs");

			fd.Directory = GetHomeDir();

			if (fd.ShowModal() == wxID_OK)
			{
				string info = "Full file name: " ~ fd.Path ~ "\n" ~
					"Path: " ~ fd.Directory ~ "\n" ~
					"Name: " ~ fd.Filename;
				MessageDialog md = new MessageDialog(this, info, "Selected file");
				md.ShowModal();
			}
		}

		public void OnFileOpen2(Object sender, Event e)
		{
			string path = FileSelector( "Select the file to load",
				"", "", s_extDef,
				"Waveform (*.wav)|*.wav|Plain text (*.txt)|*.txt|All files (*.*)|*.*",
				FileDialog.wxCHANGE_DIR,
				this );
			if (path.length == 0) return;

			s_extDef = path[path.LastIndexOf(".") + 1..path.length];

			MessageDialog md = new MessageDialog(this,
				"You selected the file '" ~ path ~
				"', remembered extension '" ~ s_extDef ~ "'",
				"FileOpen2");
			md.ShowModal();
		}

		public void OnFilesOpen(Object sender, Event e)
		{
			FileDialog fd = new FileDialog(this,
				"Testing open multiple file dialog",
				"", "", "*",
				FileDialog.wxMULTIPLE);

			if (fd.ShowModal() == wxID_OK)
			{
				string[] paths, filenames;
				paths = fd.Paths;
				filenames = fd.Filenames;

				string msg = "";
				for (int n = 0; n < paths.length; n++)
				{
					msg ~= "File " ~ .toString(n) ~ ": " ~ paths[n] ~ " " ~
						" (" ~ filenames[n] ~ ")\n";
				}

				MessageDialog md = new MessageDialog(this, msg, "Selected files");
				md.ShowModal();
			}
		}

		public void OnFileSave(Object sender, Event e)
		{
			FileDialog fd = new FileDialog(this,
				"Testing save file dialog",
				"",
				"myletter.doc",
				"Text files (*.txt)|*.txt|Document files (*.doc)|*.doc",
				FileDialog.wxSAVE | FileDialog.wxOVERWRITE_PROMPT);

			fd.FilterIndex = 1;

			if (fd.ShowModal() == wxID_OK)
			{
				MessageDialog md = new MessageDialog(this, fd.Path ~ ", filter " ~ .toString(fd.FilterIndex), "FileSave");
				md.ShowModal();
			}
		}

		public void OnProgress(Object sender, Event e)
		{
			int max = 10;

			ProgressDialog pd = new ProgressDialog(
				"Progress dialog example",
				"An informative message",
				max,
				this,
				ProgressDialog.wxPD_CAN_ABORT |
				ProgressDialog.wxPD_APP_MODAL |
				// ProgressDialog.wxPD_AUTO_HIDE | -- try cast(well)this
				ProgressDialog.wxPD_ELAPSED_TIME |
				ProgressDialog.wxPD_ESTIMATED_TIME |
				ProgressDialog.wxPD_REMAINING_TIME);

			bool cont = true;
			for ( int i = 0; i <= max; i++)
			{
				wxSleep(1);
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

		public void OnBusyinfo(Object sender, Event e)
		{
			auto WindowDisabler disableAll = new WindowDisabler();

			auto BusyInfo info = new BusyInfo("Working, please wait...", this);

			for ( int i = 0; i < 18; i++ )
			{
				App.GetApp().Yield();
				// or wxYield();
			}

			wxSleep(1);

		}

		public void OnFind(Object sender, Event e)
		{
			m_dlgFind = new FindReplaceDialog(
				this,
				m_findData,
				"Find Dialog",
				FindReplaceDialog.wxFR_NOWHOLEWORD);
			m_dlgFind.Show(true);
		}

		public void OnReplace(Object sender, Event e)
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
			string 	str = (((flags & FindReplaceDialog.wxFR_DOWN) != 0) ? "down" : "up") ~ ", " ~
				(((flags & FindReplaceDialog.wxFR_WHOLEWORD) != 0) ? "whole words only, " : "") ~
				(((flags & FindReplaceDialog.wxFR_MATCHCASE) != 0) ? "" : "not ") ~
				"case sensitive";

			return str;
		}

		public void OnFindEvent(Object sender, Event e)
		{
			FindDialogEvent fre= cast(FindDialogEvent)e;
			int etype = fre.eventType;

			if ( etype == Event.wxEVT_COMMAND_FIND   || etype == Event.wxEVT_COMMAND_FIND_NEXT )
			{
				Log.LogMessage("Find %s'%s' (flags: {%s})",
					etype == Event.wxEVT_COMMAND_FIND_NEXT ? "next " : "",
					fre.FindString,
					DecodeFindDialogEventFlags(fre.Flags));
			}
			else if ( etype == Event.wxEVT_COMMAND_FIND_REPLACE ||
				etype == Event.wxEVT_COMMAND_FIND_REPLACE_ALL )
			{
				Log.LogMessage("Replace %s'%s' with '%s' (flags: %s)",
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
					idMenu = Cmd.Find;
					m_dlgFind = null;
				}
				else if ( dlg == m_dlgReplace )
				{
					txt = "Replace";
					idMenu = Cmd.Replace;
					m_dlgReplace = null;
				}
				else
				{
					txt = "Unknown";
					idMenu = -1;

					// wxFAIL_MSG...
					Log.LogError("unexpected event");
				}

				Log.LogMessage("%s dialog is being closed.", txt);

				if ( idMenu != -1 )
				{
					menuBar.Check(idMenu, false);
				}

				dlg.Destroy();
			}
			else
			{
				Log.LogError("Unknown find dialog event!");
			}
		}

		public void OnModal(Object sender, Event e)
		{
			MyModalDialog dlg = new MyModalDialog(this);
			dlg.ShowModal();
		}

		public void OnModeless(Object sender, Event e)
		{
			CommandEvent ce = cast(CommandEvent) e;
			bool show = menuBar.IsChecked(ce.ID);

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

		public void OnExit(Object sender, Event e)
		{
			Close(true);
		}

		//---------------------------------------------------------------------
	}

	public class MyCanvas : ScrolledWindow
	{
		public Font font;
		public Colour textColour;

		public this(Window parent)
		{
			super(parent);
			font = Font.wxNORMAL_FONT;
			textColour = new Colour(0, 0, 0);
			
			EVT_PAINT(&OnPaint);
		}

		public void OnPaint(Object sender, Event e)
		{
			PaintDC dc = new PaintDC(this);
			dc.font = font;
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

		public this(Window parent)
		{
			super(parent, -1, "Modeless dialog");
			BoxSizer sizerTop = new BoxSizer(Orientation.wxVERTICAL);

			Button btn = new Button(this, Id.DIALOG_MODELESS_BTN, "Press me");
			CheckBox check = new CheckBox(this, -1, "Should be disabled");
			check.Disable();

			sizerTop.Add(btn, 1, Stretch.wxEXPAND | Direction.wxALL, 5);
			sizerTop.Add(check, 1, Stretch.wxEXPAND | Direction.wxALL, 5);

			AutoLayout = true;
			SetSizer(sizerTop);

			sizerTop.SetSizeHints(this);
			sizerTop.Fit(this);

			EVT_BUTTON(Id.DIALOG_MODELESS_BTN, &OnButton);
			EVT_CLOSE(&OnClose);
		}

		public void OnButton(Object sender, Event e)
		{
			MessageBox(this, "Button pressed in modeless dialog", "Info",
				Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}

		public void OnClose(Object sender, Event e)
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

		public this(Window parent)
		{
			super(parent, -1, "Modal dialog");
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

			EVT_BUTTON(-1, &OnButton);
		}

		public void OnButton(Object sender, Event e)
		{
			CommandEvent ce = cast(CommandEvent) e;

			if ( ce.EventObject == m_btnDelete )
			{
				//m_btnFocused = null;
				m_btnDelete.Disable();
				m_btnFocused.Hide();
			}
			else if (ce.EventObject == m_btnFocused )
			{
				GetTextFromUser("Dummy prompt",
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
				Point(50,50), Size(450,340));
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			Dialogs app = new Dialogs();
			app.Run();
		}

		//---------------------------------------------------------------------
	}

void main()
{
	Dialogs.Main();
}
