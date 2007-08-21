//-----------------------------------------------------------------------------
// wxD/Samples - StyledText.d
//
// A wxD version of the wxWidgets "contrib/stc/stctest" sample.
//
// (C) 2003 Otto Wyss
// (C) 2006 afb <afb.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module StyledText;

version (Tango)
static assert(0);
else // Phobos
import std.c.math : fmin; // for DeterminePrintSize


import wx.wx;
import wx.Display;     // to calculate print size

import defsext;	       // Additional definitions
import Edit;	       // Edit module
import Prefs;	       // Prefs
import FileNameFunc;   // Normalize file path.

const char [] mondrian = "../Samples/StyledText/mondrian.png";

//============================================================================
// declarations
//============================================================================

const char[] APP_NAME = "STC-Test";
const char[] APP_DESCR = "See http://wxguide.sourceforge.net/";

const char[] APP_MAINT = "Otto Wyss";
const char[] APP_VENDOR = "wxWidgets";
const char[] APP_COPYRIGHT = "(C) 2003 Otto Wyss";
const char[] APP_LICENCE = "wxWidgets";

const char[] APP_VERSION = "0.1.alpha";
const char[] APP_BUILD = __DATE__;

const char[] APP_WEBSITE = "http://www.wxWidgets.org";
const char[] APP_MAIL = "mailto://???";

const char[] NONAME = "<untitled>";

//----------------------------------------------------------------------------
// global application name
char[] g_appname = null;

// global print data, to remember settings during the session
PrintData g_printData = null;
PageSetupDialogData g_pageSetupData = null;

//============================================================================
// implementations
//============================================================================

void main()
{
	StyledTextApp app = new StyledTextApp();
	app.Run();
}


//----------------------------------------------------------------------------
// StyledTextApp
//----------------------------------------------------------------------------

public class StyledTextApp : App {

	private AppFrame frame;

	// the main function called durning application start
	public override bool OnInit () {

		Image.InitAllHandlers();

		// set application and vendor name
		AppName = (APP_NAME);
		VendorName = (APP_VENDOR);
		g_appname = APP_VENDOR ~ "-" ~ APP_NAME;

		// initialize print data and setup
		g_printData = new PrintData;
		g_pageSetupData = new PageSetupDialogData;

		// create application frame
		frame = new AppFrame (g_appname);

		// open application frame
		frame.Layout ();
		frame.Show (true);
		TopWindow = (frame);

		return true;
	}
}

//----------------------------------------------------------------------------
// AppFrame
//----------------------------------------------------------------------------

public class AppFrame : Frame
{

	private Edit edit;
	private MenuBar m_menuBar;

	// constructor
	public this (char[] title)
	{
		super(null, wxID_ANY, title, wxDefaultPosition, Size(750,550),
					wxDEFAULT_FRAME_STYLE | wxNO_FULL_REPAINT_ON_RESIZE);

		// about box shown for 1 seconds
		// Note: moved here, since otherwise it crashes on wxMac...
		AppAbout dlg = new AppAbout(this, 1000);

		// set icon and background
		Title = g_appname;
		icon = new Icon(mondrian);
		BackgroundColour = new Colour("WHITE");

		// create menu
		m_menuBar = new MenuBar;
		CreateMenu ();

		// open first page
		edit = new Edit (this, wxID_ANY);
		edit.SetFocus();

		FileOpen ("../Samples/StyledText/StyledText.d");

		// common
		EVT_CLOSE (                         cast(EventListener)&OnClose);
		// file
		EVT_MENU (MenuIDs.wxID_OPEN,        &OnFileOpen);
		EVT_MENU (MenuIDs.wxID_SAVE,        &OnFileSave);
		EVT_MENU (MenuIDs.wxID_SAVEAS,      &OnFileSaveAs);
		EVT_MENU (MenuIDs.wxID_CLOSE,       &OnFileClose);
		// properties
		EVT_MENU (myID_PROPERTIES,          &OnProperties);
		// print and exit
		EVT_MENU (MenuIDs.wxID_PRINT_SETUP, &OnPrintSetup);
		EVT_MENU (MenuIDs.wxID_PREVIEW,     &OnPrintPreview);
		EVT_MENU (MenuIDs.wxID_PRINT,       &OnPrint);
		EVT_MENU (MenuIDs.wxID_EXIT,        &OnExit);
		// edit
		EVT_MENU (MenuIDs.wxID_CLEAR,       &OnEdit);
		EVT_MENU (MenuIDs.wxID_CUT,         &OnEdit);
		EVT_MENU (MenuIDs.wxID_COPY,        &OnEdit);
		EVT_MENU (MenuIDs.wxID_PASTE,       &OnEdit);
		EVT_MENU (myID_INDENTINC,           &OnEdit);
		EVT_MENU (myID_INDENTRED,           &OnEdit);
		EVT_MENU (MenuIDs.wxID_SELECTALL,   &OnEdit);
		EVT_MENU (myID_SELECTLINE,          &OnEdit);
		EVT_MENU (MenuIDs.wxID_REDO,        &OnEdit);
		EVT_MENU (MenuIDs.wxID_UNDO,        &OnEdit);
		// find
		EVT_MENU (MenuIDs.wxID_FIND,        &OnEdit);
		EVT_MENU (myID_FINDNEXT,            &OnEdit);
		EVT_MENU (myID_REPLACE,             &OnEdit);
		EVT_MENU (myID_REPLACENEXT,         &OnEdit);
		EVT_MENU (myID_BRACEMATCH,          &OnEdit);
		EVT_MENU (myID_GOTO,                &OnEdit);
		// view
		EVT_MENU_RANGE (myID_HILIGHTFIRST, myID_HILIGHTLAST,
		                                    &OnEdit);
		EVT_MENU (myID_DISPLAYEOL,          &OnEdit);
		EVT_MENU (myID_INDENTGUIDE,         &OnEdit);
		EVT_MENU (myID_LINENUMBER,          &OnEdit);
		EVT_MENU (myID_LONGLINEON,          &OnEdit);
		EVT_MENU (myID_WHITESPACE,          &OnEdit);
		EVT_MENU (myID_FOLDTOGGLE,          &OnEdit);
		EVT_MENU (myID_OVERTYPE,            &OnEdit);
		EVT_MENU (myID_READONLY,            &OnEdit);
		EVT_MENU (myID_WRAPMODEON,          &OnEdit);
		// extra
		EVT_MENU (myID_CHANGELOWER,         &OnEdit);
		EVT_MENU (myID_CHANGEUPPER,         &OnEdit);
		EVT_MENU (myID_CONVERTCR,           &OnEdit);
		EVT_MENU (myID_CONVERTCRLF,         &OnEdit);
		EVT_MENU (myID_CONVERTLF,           &OnEdit);
		EVT_MENU (myID_CHARSETANSI,         &OnEdit);
		EVT_MENU (myID_CHARSETMAC,          &OnEdit);
		// help
		EVT_MENU (MenuIDs.wxID_ABOUT,       &OnAbout);
	}

	// common event handlers
	public void OnClose (Object sender, CloseEvent event)
	{
		CommandEvent evt;
		OnFileClose (this, evt);

		if (edit && edit.Modified()) {
			if (event.CanVeto())
				event.Veto (true);
			return;
		}
		Destroy();
	}

	public void OnAbout (Object sender, Event event)
	{
		scope AppAbout dlg = new AppAbout(this);
	}

	public void OnExit (Object sender, Event event)
	{
		Close (true);
	}

	// file event handlers
	public void OnFileOpen (Object sender, Event event)
	{
		if (!edit) return;
		
		char[] fname;
		scope FileDialog dlg = new FileDialog(this, "Open file", "", "", "Any file (*)|*",
			FileDialog.wxOPEN | FileDialog.wxFILE_MUST_EXIST | FileDialog.wxCHANGE_DIR);
		
		if (dlg.ShowModal() != wxID_OK) return;

		fname = dlg.Path;
		FileOpen (fname);
	}

	public void OnFileSave (Object sender, Event event)
	{
		if (!edit) return;

		if (!edit.Modified()) {
			MessageBox("There is nothing to save!", "Save file", Dialog.wxOK | Dialog.wxICON_EXCLAMATION);
			return;
		}
		edit.SaveFile ();
	}

	public void OnFileSaveAs (Object sender, Event event)
	{
		if (!edit) return;

		char[] filename;
		scope FileDialog dlg = new FileDialog(this, "Save file", "", "", "Any file (*)|*",
		
			FileDialog.wxSAVE | FileDialog.wxOVERWRITE_PROMPT);

		if (dlg.ShowModal() != wxID_OK) return;

		filename = dlg.Path;
		edit.SaveFile (filename);
	}

	public void OnFileClose (Object sender, Event event)
	{
		if (!edit) return;

		if (edit.Modified()) {
			if (MessageBox("Text is not saved, save before closing?", "Close",
					Dialog.wxYES_NO | Dialog.wxICON_QUESTION) == Dialog.wxYES) {
				edit.SaveFile();
				if (edit.Modified()) {
					MessageBox("Text could not be saved!", "Close abort",
							Dialog.wxOK | Dialog.wxICON_EXCLAMATION);
					return;
				}
			}
		}

		edit.SetFilename ("");
		edit.ClearAll();
		edit.SetSavePoint();
	}

	// properties event handlers
	public void OnProperties (Object sender, Event event)
	{
		if (!edit) return;

		scope EditProperties dlg = new EditProperties(edit, 0);
	}

	// print event handlers
	public void OnPrintSetup (Object sender, Event event)
	{
		g_pageSetupData.printData = g_printData;
		PageSetupDialog pageSetupDialog = new PageSetupDialog(this, g_pageSetupData);
		pageSetupDialog.ShowModal();
		g_printData = pageSetupDialog.PageSetupData.printData;
		g_pageSetupData = pageSetupDialog.PageSetupData;
	}

	public void OnPrintPreview (Object sender, Event event)
	{
		PrintDialogData printDialogData = new PrintDialogData(g_printData);
		PrintPreview preview = new PrintPreview (new EditPrint (edit),
			new EditPrint (edit), printDialogData);
		
		if (!preview.Ok()) {
			MessageBox ("There was a problem with previewing.\n" ~
							 "Perhaps your current printer is not correctly?",
						  "Previewing", Dialog.wxOK);
			return;
		}

		Rectangle rect = DeterminePrintSize();
		PreviewFrame frame = new PreviewFrame (preview, this, "Print Preview");
		frame.SetSize (rect);
		frame.Centre(Orientation.wxBOTH);
		frame.Initialize();
		frame.Show(true);
	}

	public void OnPrint (Object sender, Event event)
	{
		PrintDialogData printDialogData = new PrintDialogData(g_printData);
		Printer printer = new Printer(printDialogData);
		EditPrint printout = new EditPrint(edit);
		if (!printer.Print (this, printout, true)) {
			if (printer.LastError() == PrinterError.wxPRINTER_ERROR) {
			MessageBox ("There was a problem with printing.\n" ~
						  "Perhaps your current printer is not correctly?",
						  "Previewing", Dialog.wxOK);
				return;
			}
		}
		g_printData = printer.printDialogData.printData;
	}

	// edit events
	public void OnEdit (Object sender, Event event)
	{
		if (edit) edit.ProcessEvent (event);
	}

	// private functions

	// creates the application menu bar
	private void CreateMenu ()
	{
		// File menu
		wxMenu menuFile = new wxMenu;
		menuFile.Append (MenuIDs.wxID_OPEN, "&Open ..\tCtrl+O");
		menuFile.Append (MenuIDs.wxID_SAVE, "&Save\tCtrl+S");
		menuFile.Append (MenuIDs.wxID_SAVEAS, "Save &as ..\tCtrl+Shift+S");
		menuFile.Append (MenuIDs.wxID_CLOSE, "&Close\tCtrl+W");
		menuFile.AppendSeparator();
		menuFile.Append (myID_PROPERTIES, "Proper&ties ..\tCtrl+I");
		menuFile.AppendSeparator();
		menuFile.Append (MenuIDs.wxID_PRINT_SETUP, "Print Set&up ..");
		menuFile.Append (MenuIDs.wxID_PREVIEW, "Print Pre&view\tCtrl+Shift+P");
		menuFile.Append (MenuIDs.wxID_PRINT, "&Print ..\tCtrl+P");
		menuFile.AppendSeparator();
		menuFile.Append (MenuIDs.wxID_EXIT, "&Quit\tCtrl+Q");

		// Edit menu
		Menu menuEdit = new Menu;
		menuEdit.Append (MenuIDs.wxID_UNDO, "&Undo\tCtrl+Z");
		menuEdit.Append (MenuIDs.wxID_REDO, "&Redo\tCtrl+Shift+Z");
		menuEdit.AppendSeparator();
		menuEdit.Append (MenuIDs.wxID_CUT, "Cu&t\tCtrl+X");
		menuEdit.Append (MenuIDs.wxID_COPY, "&Copy\tCtrl+C");
		menuEdit.Append (MenuIDs.wxID_PASTE, "&Paste\tCtrl+V");
		menuEdit.Append (MenuIDs.wxID_CLEAR, "&Delete\tDel");
		menuEdit.AppendSeparator();
		menuEdit.Append (MenuIDs.wxID_FIND, "&Find\tCtrl+F");
		menuEdit.Enable (MenuIDs.wxID_FIND, false);
		menuEdit.Append (myID_FINDNEXT, "Find &next\tF3");
		menuEdit.Enable (myID_FINDNEXT, false);
		menuEdit.Append (myID_REPLACE, "&Replace\tCtrl+H");
		menuEdit.Enable (myID_REPLACE, false);
		menuEdit.Append (myID_REPLACENEXT, "Replace &again\tShift+F4");
		menuEdit.Enable (myID_REPLACENEXT, false);
		menuEdit.AppendSeparator();
		menuEdit.Append (myID_BRACEMATCH, "&Match brace\tCtrl+M");
		menuEdit.Append (myID_GOTO, "&Goto\tCtrl+G");
		menuEdit.Enable (myID_GOTO, false);
		menuEdit.AppendSeparator();
		menuEdit.Append (myID_INDENTINC, "&Indent increase\tTab");
		menuEdit.Append (myID_INDENTRED, "I&ndent reduce\tBksp");
		menuEdit.AppendSeparator();
		menuEdit.Append (MenuIDs.wxID_SELECTALL, "&Select all\tCtrl+A");
		menuEdit.Append (myID_SELECTLINE, "Select &line\tCtrl+L");

		// hilight submenu
		Menu menuHilight = new Menu;
		int Nr;
		for (Nr = 0; Nr < g_LanguagePrefs.length; Nr++) {
			menuHilight.Append (myID_HILIGHTFIRST + Nr,
								 g_LanguagePrefs [Nr].name);
		}

		// charset submenu
		Menu menuCharset = new Menu;
		menuCharset.Append (myID_CHARSETANSI, "&ANSI (Windows)");
		menuCharset.Append (myID_CHARSETMAC, "&MAC (Macintosh)");

		// View menu
		Menu menuView = new Menu;
		menuView.Append (myID_HILIGHTLANG, "&Hilight language ..", menuHilight);
		menuView.AppendSeparator();
		menuView.AppendCheckItem (myID_FOLDTOGGLE, "&Toggle current fold\tCtrl+T");
		menuView.AppendCheckItem (myID_OVERTYPE, "&Overwrite mode\tIns");
		menuView.AppendCheckItem (myID_WRAPMODEON, "&Wrap mode\tCtrl+U");
		menuView.AppendSeparator();
		menuView.AppendCheckItem (myID_DISPLAYEOL, "Show line &endings");
		menuView.AppendCheckItem (myID_INDENTGUIDE, "Show &indent guides");
		menuView.AppendCheckItem (myID_LINENUMBER, "Show line &numbers");
		menuView.AppendCheckItem (myID_LONGLINEON, "Show &long line marker");
		menuView.AppendCheckItem (myID_WHITESPACE, "Show white&space");
		menuView.AppendSeparator();
		menuView.Append (myID_USECHARSET, "Use &code page of ..", menuCharset);

		// change case submenu
		Menu menuChangeCase = new Menu;
		menuChangeCase.Append (myID_CHANGEUPPER, "&Upper case");
		menuChangeCase.Append (myID_CHANGELOWER, "&Lower case");

		// convert EOL submenu
		Menu menuConvertEOL = new Menu;
		menuConvertEOL.Append (myID_CONVERTCR, "CR (&Linux)");
		menuConvertEOL.Append (myID_CONVERTCRLF, "CR+LF (&Windows)");
		menuConvertEOL.Append (myID_CONVERTLF, "LF (&Macintosh)");

		// Extra menu
		Menu menuExtra = new Menu;
		menuExtra.AppendCheckItem (myID_READONLY, "&Readonly mode");
		menuExtra.AppendSeparator();
		menuExtra.Append (myID_CHANGECASE, "Change &case to ..", menuChangeCase);
		menuExtra.AppendSeparator();
		menuExtra.Append (myID_CONVERTEOL, "Convert line &endings to ..", menuConvertEOL);

		// Window menu
		Menu menuWindow = new Menu;
		menuWindow.Append (myID_PAGEPREV, "&Previous\tCtrl+Shift+Tab");
		menuWindow.Append (myID_PAGENEXT, "&Next\tCtrl+Tab");

		// Help menu
		Menu menuHelp = new Menu;
		menuHelp.Append (MenuIDs.wxID_ABOUT, "&About ..\tShift+F1");

		// construct menu
		m_menuBar.Append (menuFile, "&File");
		m_menuBar.Append (menuEdit, "&Edit");
		m_menuBar.Append (menuView, "&View");
		m_menuBar.Append (menuExtra, "E&xtra");
		m_menuBar.Append (menuWindow, "&Window");
		m_menuBar.Append (menuHelp, "&Help");
		this.menuBar = m_menuBar;
	}

	private void FileOpen (char[] fname)
	{
		fname = absPath(fname);
		edit.LoadFile (fname);
	}

	// print preview position and size
	private Rectangle DeterminePrintSize ()
	{
		Display display = new Display(Display.GetFromPoint(this.Position));
		Rectangle scr = display.Geometry();

		// determine position and size (shifting 16 left and down)
		Rectangle rect = Rect();
		rect.X += 16;
		rect.Y += 16;
		rect.Width = cast(int)fmin (rect.Width, (scr.X - rect.X));
		rect.Height = cast(int)fmin (rect.Height, (scr.X - rect.Y));

		return rect;
	}
}

//----------------------------------------------------------------------------
// AppAbout
//----------------------------------------------------------------------------

public class AppAbout : Dialog
{
	private Timer timer;

	// constructor
	public this (Window parent,	int milliseconds = 0,
					long style = wxDEFAULT_DIALOG_STYLE)
	{
		super(parent, wxID_ANY, "",	wxDefaultPosition, wxDefaultSize,
					style | wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER);

		// set timer if any
		if (milliseconds > 0) {
			timer = new Timer (this, myID_ABOUTTIMER);
			
			timer.SetOwner(this);
			
			timer.Start (milliseconds, wxTIMER_ONE_SHOT);
		}

		// sets the application title
		Title ("About ..");

		// about info
		GridSizer aboutinfo = new GridSizer (2, 0, 2);
		aboutinfo.Add (new StaticText(this, wxID_ANY, "Written by: "),
						0, Alignment.wxALIGN_LEFT);
		aboutinfo.Add (new StaticText(this, wxID_ANY, APP_MAINT),
						1, Stretch.wxEXPAND | Alignment.wxALIGN_LEFT);
		aboutinfo.Add (new StaticText(this, wxID_ANY, "Version: "),
						0, Alignment.wxALIGN_LEFT);
		aboutinfo.Add (new StaticText(this, wxID_ANY, APP_VERSION),
						1, Stretch.wxEXPAND | Alignment.wxALIGN_LEFT);
		aboutinfo.Add (new StaticText(this, wxID_ANY, "Licence type: "),
						0, Alignment.wxALIGN_LEFT);
		aboutinfo.Add (new StaticText(this, wxID_ANY, APP_LICENCE),
						1, Stretch.wxEXPAND | Alignment.wxALIGN_LEFT);
		aboutinfo.Add (new StaticText(this, wxID_ANY, "Copyright: "),
						0, Alignment.wxALIGN_LEFT);
		aboutinfo.Add (new StaticText(this, wxID_ANY, APP_COPYRIGHT),
						1, Stretch.wxEXPAND | Alignment.wxALIGN_LEFT);

		// about icontitle//info
		BoxSizer aboutpane = new BoxSizer (Orientation.wxHORIZONTAL);
		Bitmap bitmap = new Bitmap(new Icon(mondrian));
		aboutpane.Add (new StaticBitmap (this, wxID_ANY, bitmap),
						0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT|Direction.wxRIGHT, 20);
		aboutpane.Add (aboutinfo, 1, Stretch.wxEXPAND);
		aboutpane.Add (60, 0);

		// about complete
		BoxSizer totalpane = new BoxSizer (Orientation.wxVERTICAL);
		totalpane.Add (0, 20);
		StaticText appname = new StaticText(this, wxID_ANY, g_appname);
		appname.SetFont (new Font (24, FontFamily.wxDEFAULT, FontStyle.wxNORMAL, FontWeight.wxBOLD));
		totalpane.Add (appname, 0, Alignment.wxALIGN_CENTER | Direction.wxLEFT | Direction.wxRIGHT, 40);
		totalpane.Add (0, 10);
		totalpane.Add (aboutpane, 0, Stretch.wxEXPAND | Direction.wxALL, 4);
		totalpane.Add (new StaticText(this, wxID_ANY, APP_DESCR),
						0, Alignment.wxALIGN_CENTER | Direction.wxALL, 10);
		Button okButton = new Button (this, wxID_OK, "OK");
		okButton.SetDefault();
		totalpane.Add (okButton, 0, Alignment.wxALIGN_CENTER | Direction.wxLEFT | Direction.wxRIGHT | Direction.wxBOTTOM, 10);

		SetSizerAndFit (totalpane, true);

		//Add event before ShowModal
		EVT_TIMER (myID_ABOUTTIMER, &OnTimerEvent);

		CenterOnScreen();
		ShowModal();
	}

	// event handlers
	public void OnTimerEvent (Object sender, Event event)
	{
	
		timer = null;
		EndModal (wxID_OK);
	}
}
