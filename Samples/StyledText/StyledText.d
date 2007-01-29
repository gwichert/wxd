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


//----------------------------------------------------------------------------
// headers
//----------------------------------------------------------------------------

import wx.wx;

//! wxWidgets headers
import wx.Config;   // configuration support
import wx.FileDialog;  // file dialog support
//import wx.filename; // filename support
import wx.Notebook; // notebook support
//import wx.settings; // system settings
import wx.wxString;   // strings support
import wx.Image;    // images support
import wx.PrintDialog;

//! application headers
import defsext;    // Additional definitions
import Edit;       // Edit module
import Prefs;      // Prefs

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
//! global application name
string g_appname = null;

//! global print data, to remember settings during the session
PrintData g_printData = null;
PageSetupDialogData g_pageSetupData = null;

//============================================================================
// implementations
//============================================================================

//----------------------------------------------------------------------------
// App
//----------------------------------------------------------------------------

class App: public wxApp {

public:

//! the main function called durning application start
bool OnInit () {

    wxImage.InitAllHandlers();

    // set application and vendor name
    AppName = (APP_NAME);
    VendorName = (APP_VENDOR);
    g_appname = APP_VENDOR ~ "-" ~ APP_NAME;

    // initialize print data and setup
    g_printData = new wxPrintData;
    g_pageSetupData = new wxPageSetupDialogData;

    // create application frame
    m_frame = new AppFrame (g_appname);

    // open application frame
    m_frame.Layout ();
    m_frame.Show (true);
    TopWindow = (m_frame);

    return true;
}

//! application exit function
int OnExit () {

    // delete global appname
    delete g_appname;

    // delete global print data and setup
    if (g_printData) delete g_printData;
    if (g_pageSetupData) delete g_pageSetupData;

    return 0;
}

private:
    //! frame window
    AppFrame m_frame;
}

//----------------------------------------------------------------------------
// AppFrame
//----------------------------------------------------------------------------

class AppFrame: public wxFrame {


public:

//! constructor
this (string title) {

    super(null, wxID_ANY, title, wxDefaultPosition, wxSize(750,550),
                    wxDEFAULT_FRAME_STYLE | wxNO_FULL_REPAINT_ON_RESIZE);

    // intitialize important variables
    m_edit = null;

    // set icon and background
    Title = g_appname;
    icon = new Icon(mondrian);
    BackgroundColour = new wxColour("WHITE");

    // about box shown for 1 seconds
    AppAbout dlg = new AppAbout(this, 1000);

    // create menu
    m_menuBar = new wxMenuBar;
    CreateMenu ();

    // open first page
    m_edit = new Edit (this, wxID_ANY);
    m_edit.SetFocus();

    FileOpen ("stctest.cpp");

    // common
    EVT_CLOSE (                      &OnClose);
    // file
    EVT_MENU (wxID_OPEN,             &OnFileOpen);
    EVT_MENU (wxID_SAVE,             &OnFileSave);
    EVT_MENU (wxID_SAVEAS,           &OnFileSaveAs);
    EVT_MENU (wxID_CLOSE,            &OnFileClose);
    // properties
    EVT_MENU (myID_PROPERTIES,       &OnProperties);
    // print and exit
    EVT_MENU (wxID_PRINT_SETUP,      &OnPrintSetup);
    EVT_MENU (wxID_PREVIEW,          &OnPrintPreview);
    EVT_MENU (wxID_PRINT,            &OnPrint);
    EVT_MENU (wxID_EXIT,             &OnExit);
    // edit
    EVT_MENU (wxID_CLEAR,            &OnEdit);
    EVT_MENU (wxID_CUT,              &OnEdit);
    EVT_MENU (wxID_COPY,             &OnEdit);
    EVT_MENU (wxID_PASTE,            &OnEdit);
    EVT_MENU (myID_INDENTINC,        &OnEdit);
    EVT_MENU (myID_INDENTRED,        &OnEdit);
    EVT_MENU (wxID_SELECTALL,        &OnEdit);
    EVT_MENU (myID_SELECTLINE,       &OnEdit);
    EVT_MENU (wxID_REDO,             &OnEdit);
    EVT_MENU (wxID_UNDO,             &OnEdit);
    // find
    EVT_MENU (wxID_FIND,             &OnEdit);
    EVT_MENU (myID_FINDNEXT,         &OnEdit);
    EVT_MENU (myID_REPLACE,          &OnEdit);
    EVT_MENU (myID_REPLACENEXT,      &OnEdit);
    EVT_MENU (myID_BRACEMATCH,       &OnEdit);
    EVT_MENU (myID_GOTO,             &OnEdit);
    // view
    EVT_MENU_RANGE (myID_HILIGHTFIRST, myID_HILIGHTLAST,
                                     &OnEdit);
    EVT_MENU (myID_DISPLAYEOL,       &OnEdit);
    EVT_MENU (myID_INDENTGUIDE,      &OnEdit);
    EVT_MENU (myID_LINENUMBER,       &OnEdit);
    EVT_MENU (myID_LONGLINEON,       &OnEdit);
    EVT_MENU (myID_WHITESPACE,       &OnEdit);
    EVT_MENU (myID_FOLDTOGGLE,       &OnEdit);
    EVT_MENU (myID_OVERTYPE,         &OnEdit);
    EVT_MENU (myID_READONLY,         &OnEdit);
    EVT_MENU (myID_WRAPMODEON,       &OnEdit);
    // extra
    EVT_MENU (myID_CHANGELOWER,      &OnEdit);
    EVT_MENU (myID_CHANGEUPPER,      &OnEdit);
    EVT_MENU (myID_CONVERTCR,        &OnEdit);
    EVT_MENU (myID_CONVERTCRLF,      &OnEdit);
    EVT_MENU (myID_CONVERTLF,        &OnEdit);
    EVT_MENU (myID_CHARSETANSI,      &OnEdit);
    EVT_MENU (myID_CHARSETMAC,       &OnEdit);
    // help
    EVT_MENU (wxID_ABOUT,            &OnAbout);

}

//! destructor
~this () {
}

// common event handlers
void OnClose (wxCloseEvent event) {
    wxCommandEvent evt;
    OnFileClose (evt);
    if (m_edit && m_edit.Modified()) {
        if (event.CanVeto()) event.Veto (true);
        return;
    }
    Destroy();
}

void OnAbout (wxCommandEvent event) {
    auto AppAbout dlg = new AppAbout(this);
}

void OnExit (wxCommandEvent event) {
    Close (true);
}

// file event handlers
void OnFileOpen (wxCommandEvent event) {
    if (!m_edit) return;
    wxString fname;
    auto wxFileDialog dlg = new wxFileDialog(this, _T("Open file"), wxEmptyString, wxEmptyString, _T("Any file (*)|*"),
                      wxOPEN | wxFILE_MUST_EXIST | wxCHANGE_DIR);
    if (dlg.ShowModal() != wxID_OK) return;
    fname = dlg.GetPath ();
    FileOpen (fname);
}

void OnFileSave (wxCommandEvent event) {
    if (!m_edit) return;
    if (!m_edit.Modified()) {
        wxMessageBox ("There is nothing to save!"), _("Save file",
                      wxOK | wxICON_EXCLAMATION);
        return;
    }
    m_edit.SaveFile ();
}

void OnFileSaveAs (wxCommandEvent event) {
    if (!m_edit) return;
    wxString filename = wxEmptyString;
    auto wxFileDialog dlg = new wxFileDialog(this, _T("Save file"), wxEmptyString, wxEmptyString, _T("Any file (*)|*"), wxSAVE|wxOVERWRITE_PROMPT);
    if (dlg.ShowModal() != wxID_OK) return;
    filename = dlg.GetPath();
    m_edit.SaveFile (filename);
}

void OnFileClose (wxCommandEvent event) {
    if (!m_edit) return;
    if (m_edit.Modified()) {
        if (wxMessageBox ("Text is not saved, save before closing?"), _("Close",
                          wxYES_NO | wxICON_QUESTION) == wxYES) {
            m_edit.SaveFile();
            if (m_edit.Modified()) {
                wxMessageBox ("Text could not be saved!"), _("Close abort",
                              wxOK | wxICON_EXCLAMATION);
                return;
            }
        }
    }
    m_edit.SetFilename (wxEmptyString);
    m_edit.ClearAll();
    m_edit.SetSavePoint();
}

// properties event handlers
void OnProperties (wxCommandEvent event) {
    if (!m_edit) return;
    auto EditProperties dlg = new EditProperties(m_edit, 0);
}

// print event handlers
void OnPrintSetup (wxCommandEvent event) {
    (*g_pageSetupData) = * g_printData;
    wxPageSetupDialog pageSetupDialog = new wxPageSetupDialog(this, g_pageSetupData);
    pageSetupDialog.ShowModal();
    (*g_printData) = pageSetupDialog.GetPageSetupData().GetPrintData();
    (*g_pageSetupData) = pageSetupDialog.GetPageSetupData();
}

void OnPrintPreview (wxCommandEvent event) {
    wxPrintDialogData printDialogData = new wxPrintDialogData( *g_printData);
    wxPrintPreview *preview =
        new wxPrintPreview (new EditPrint (m_edit),
                            new EditPrint (m_edit),
                            &printDialogData);
    if (!preview.Ok()) {
        delete preview;
        wxMessageBox ("There was a problem with previewing.\n" ~
                         "Perhaps your current printer is not correctly?",
                      "Previewing", wxOK);
        return;
    }
    wxRect rect = DeterminePrintSize();
    wxPreviewFrame *frame = new wxPreviewFrame (preview, this, "Print Preview");
    frame.SetSize (rect);
    frame.Centre(wxBOTH);
    frame.Initialize();
    frame.Show(true);
}

void OnPrint (wxCommandEvent event) {
    wxPrintDialogData printDialogData = new wxPrintDialogData( *g_printData);
    wxPrinter printer = wxPrinter(&printDialogData);
    EditPrint printout = new EditPrint(m_edit);
    if (!printer.Print (this, &printout, true)) {
        if (wxPrinter.GetLastError() == wxPRINTER_ERROR) {
        wxMessageBox ("There was a problem with printing.\n" ~
                         "Perhaps your current printer is not correctly?",
                      "Previewing", wxOK);
            return;
        }
    }
    (*g_printData) = printer.GetPrintDialogData().GetPrintData();
}

// edit events
void OnEdit (wxCommandEvent event) {
    if (m_edit) m_edit.ProcessEvent (event);
}

// private functions

private:

//! creates the application menu bar
void CreateMenu ()
{
    // File menu
    wxMenu *menuFile = new wxMenu;
    menuFile.Append (wxID_OPEN, "&Open ..\tCtrl+O");
    menuFile.Append (wxID_SAVE, "&Save\tCtrl+S");
    menuFile.Append (wxID_SAVEAS, "Save &as ..\tCtrl+Shift+S");
    menuFile.Append (wxID_CLOSE, "&Close\tCtrl+W");
    menuFile.AppendSeparator();
    menuFile.Append (myID_PROPERTIES, "Proper&ties ..\tCtrl+I");
    menuFile.AppendSeparator();
    menuFile.Append (wxID_PRINT_SETUP, "Print Set&up ..");
    menuFile.Append (wxID_PREVIEW, "Print Pre&view\tCtrl+Shift+P");
    menuFile.Append (wxID_PRINT, "&Print ..\tCtrl+P");
    menuFile.AppendSeparator();
    menuFile.Append (wxID_EXIT, "&Quit\tCtrl+Q");

    // Edit menu
    wxMenu *menuEdit = new wxMenu;
    menuEdit.Append (wxID_UNDO, "&Undo\tCtrl+Z");
    menuEdit.Append (wxID_REDO, "&Redo\tCtrl+Shift+Z");
    menuEdit.AppendSeparator();
    menuEdit.Append (wxID_CUT, "Cu&t\tCtrl+X");
    menuEdit.Append (wxID_COPY, "&Copy\tCtrl+C");
    menuEdit.Append (wxID_PASTE, "&Paste\tCtrl+V");
    menuEdit.Append (wxID_CLEAR, "&Delete\tDel");
    menuEdit.AppendSeparator();
    menuEdit.Append (wxID_FIND, "&Find\tCtrl+F");
    menuEdit.Enable (wxID_FIND, false);
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
    menuEdit.Append (wxID_SELECTALL, "&Select all\tCtrl+A");
    menuEdit.Append (myID_SELECTLINE, "Select &line\tCtrl+L");

    // hilight submenu
    wxMenu *menuHilight = new wxMenu;
    int Nr;
    for (Nr = 0; Nr < g_LanguagePrefsSize; Nr++) {
        menuHilight.Append (myID_HILIGHTFIRST + Nr,
                             g_LanguagePrefs [Nr].name);
    }

    // charset submenu
    wxMenu *menuCharset = new wxMenu;
    menuCharset.Append (myID_CHARSETANSI, "&ANSI (Windows)");
    menuCharset.Append (myID_CHARSETMAC, "&MAC (Macintosh)");

    // View menu
    wxMenu *menuView = new wxMenu;
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
    wxMenu *menuChangeCase = new wxMenu;
    menuChangeCase.Append (myID_CHANGEUPPER, "&Upper case");
    menuChangeCase.Append (myID_CHANGELOWER, "&Lower case");

    // convert EOL submenu
    wxMenu *menuConvertEOL = new wxMenu;
    menuConvertEOL.Append (myID_CONVERTCR, "CR (&Linux)");
    menuConvertEOL.Append (myID_CONVERTCRLF, "CR+LF (&Windows)");
    menuConvertEOL.Append (myID_CONVERTLF, "LF (&Macintosh)");

    // Extra menu
    wxMenu *menuExtra = new wxMenu;
    menuExtra.AppendCheckItem (myID_READONLY, "&Readonly mode");
    menuExtra.AppendSeparator();
    menuExtra.Append (myID_CHANGECASE, "Change &case to ..", menuChangeCase);
    menuExtra.AppendSeparator();
    menuExtra.Append (myID_CONVERTEOL, "Convert line &endings to ..", menuConvertEOL);

    // Window menu
    wxMenu *menuWindow = new wxMenu;
    menuWindow.Append (myID_PAGEPREV, "&Previous\tCtrl+Shift+Tab");
    menuWindow.Append (myID_PAGENEXT, "&Next\tCtrl+Tab");

    // Help menu
    wxMenu *menuHelp = new wxMenu;
    menuHelp.Append (wxID_ABOUT, "&About ..\tShift+F1");

    // construct menu
    m_menuBar.Append (menuFile, "&File");
    m_menuBar.Append (menuEdit, "&Edit");
    m_menuBar.Append (menuView, "&View");
    m_menuBar.Append (menuExtra, "E&xtra");
    m_menuBar.Append (menuWindow, "&Window");
    m_menuBar.Append (menuHelp, "&Help");
    SetMenuBar (m_menuBar);
}

void FileOpen (string fname)
{
    wxFileName w(fname); w.Normalize(); fname = w.GetFullPath();
    m_edit.LoadFile (fname);
}

// print preview position and size
wxRect DeterminePrintSize () {

    wxSize scr = wxGetDisplaySize();

    // determine position and size (shifting 16 left and down)
    wxRect rect = GetRect();
    rect.x += 16;
    rect.y += 16;
    rect.width = wxMin (rect.width, (scr.x - rect.x));
    rect.height = wxMin (rect.height, (scr.x - rect.y));

    return rect;
}

private:
    // edit object
    Edit m_edit;

    wxMenuBar m_menuBar;
}

//----------------------------------------------------------------------------
// AppAbout
//----------------------------------------------------------------------------

class AppAbout: public wxDialog {

public:

//! constructor
this (wxWindow parent,
                    int milliseconds,
                    long style = wxDEFAULT_DIALOG_STYLE) {

    super(parent, wxID_ANY, wxEmptyString,
                    wxDefaultPosition, wxDefaultSize,
                    style | wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER);

/+
    // set timer if any
    m_timer = null;
    if (milliseconds > 0) {
        m_timer = new wxTimer (this, myID_ABOUTTIMER);
        m_timer.Start (milliseconds, wxTIMER_ONE_SHOT);
    }
+/

    // sets the application title
    SetTitle ("About ..");

    // about info
    wxGridSizer *aboutinfo = new wxGridSizer (2, 0, 2);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, "Written by: "),
                    0, wxALIGN_LEFT);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, APP_MAINT),
                    1, wxEXPAND | wxALIGN_LEFT);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, "Version: "),
                    0, wxALIGN_LEFT);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, APP_VERSION),
                    1, wxEXPAND | wxALIGN_LEFT);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, "Licence type: "),
                    0, wxALIGN_LEFT);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, APP_LICENCE),
                    1, wxEXPAND | wxALIGN_LEFT);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, "Copyright: "),
                    0, wxALIGN_LEFT);
    aboutinfo.Add (new wxStaticText(this, wxID_ANY, APP_COPYRIGHT),
                    1, wxEXPAND | wxALIGN_LEFT);

    // about icontitle//info
    wxBoxSizer *aboutpane = new wxBoxSizer (wxHORIZONTAL);
    wxBitmap bitmap = wxBitmap(wxICON (mondrian));
    aboutpane.Add (new wxStaticBitmap (this, wxID_ANY, bitmap),
                    0, wxALIGN_LEFT|wxALIGN_CENTER_VERTICAL|wxLEFT|wxRIGHT, 20);
    aboutpane.Add (aboutinfo, 1, wxEXPAND);
    aboutpane.Add (60, 0);

    // about complete
    wxBoxSizer *totalpane = new wxBoxSizer (wxVERTICAL);
    totalpane.Add (0, 20);
    wxStaticText *appname = new wxStaticText(this, wxID_ANY, *g_appname);
    appname.SetFont (wxFont (24, wxDEFAULT, wxNORMAL, wxBOLD));
    totalpane.Add (appname, 0, wxALIGN_CENTER | wxLEFT | wxRIGHT, 40);
    totalpane.Add (0, 10);
    totalpane.Add (aboutpane, 0, wxEXPAND | wxALL, 4);
    totalpane.Add (new wxStaticText(this, wxID_ANY, APP_DESCR),
                    0, wxALIGN_CENTER | wxALL, 10);
    wxButton *okButton = new wxButton (this, wxID_OK, "OK");
    okButton.SetDefault();
    totalpane.Add (okButton, 0, wxALIGN_CENTER | wxLEFT | wxRIGHT | wxBOTTOM, 10);

    SetSizerAndFit (totalpane);

    CenterOnScreen();
    ShowModal();

    EVT_TIMER (myID_ABOUTTIMER, &OnTimerEvent);
}

    //! destructor
~this () {
/+
    if (m_timer)  {
        delete m_timer;
        m_timer = null;
    }
+/
}

//----------------------------------------------------------------------------
// event handlers
/+
void OnTimerEvent (wxTimerEvent event) {
    if (m_timer) delete m_timer;
    m_timer = null;
    EndModal (wxID_OK);
}

private:
    // timer
    wxTimer m_timer;
+/
}


