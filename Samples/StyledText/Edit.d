//-----------------------------------------------------------------------------
// wxD/Samples - Edit.d
//
// A wxD version of the wxWidgets "contrib/stc/edit" sample.
//
// (C) 2003 Wyo
// (C) 2007
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import std.string : find, rfind, format, tolower;
import std.path : getBaseName;

import wx.wx;

import Prefs;
import defsext;	 // additional definitions
import StyledText;

//----------------------------------------------------------------------------
// Edit
//----------------------------------------------------------------------------

public class Edit : StyledTextCtrl {

	// file
	private char[] m_filename;

	// lanugage properties
	private Prefs.LanguageInfo m_language;

	// margin variables
	private int m_LineNrID;
	private int m_LineNrMargin;
	private int m_FoldingID;
	private int m_FoldingMargin;
	private int m_DividerID;

	public this (Window parent, int id = wxID_ANY,
				Point pos = wxDefaultPosition,
				Size size= wxDefaultSize,
				long style = wxSUNKEN_BORDER|wxVSCROLL)
	{
		super(parent, id, pos, size, style);

		m_filename = "";

		m_LineNrID = 0;
		m_DividerID = 1;
		m_FoldingID = 2;

		// default font for all styles
		ViewEOL = g_CommonPrefs.displayEOLEnable;
		IndentationGuides = g_CommonPrefs.indentGuideEnable;
		EdgeMode = (g_CommonPrefs.longLineOnEnable ? wxSTC_EDGE_LINE: wxSTC_EDGE_NONE);
		ViewWhiteSpace = (g_CommonPrefs.whiteSpaceEnable ? wxSTC_WS_VISIBLEALWAYS: wxSTC_WS_INVISIBLE);
		Overtype = g_CommonPrefs.overTypeInitial;
		ReadOnly = g_CommonPrefs.readOnlyInitial;
		WrapMode = (g_CommonPrefs.wrapModeInitial ? wxSTC_WRAP_WORD: wxSTC_WRAP_NONE);
		Font font = new Font(10, FontFamily.wxMODERN, FontStyle.wxNORMAL, FontWeight.wxNORMAL);
		StyleSetFont (wxSTC_STYLE_DEFAULT, font);
		StyleSetForeground (wxSTC_STYLE_DEFAULT, Colour.wxBLACK);
		StyleSetBackground (wxSTC_STYLE_DEFAULT, Colour.wxWHITE);
		StyleSetForeground (wxSTC_STYLE_LINENUMBER, new Colour ("DARK GREY"));
		StyleSetBackground (wxSTC_STYLE_LINENUMBER, Colour.wxWHITE);
		StyleSetForeground(wxSTC_STYLE_INDENTGUIDE, new Colour ("DARK GREY"));
		InitializePrefs (DEFAULT_LANGUAGE);

		// set visibility
		SetVisiblePolicy (wxSTC_VISIBLE_STRICT|wxSTC_VISIBLE_SLOP, 1);
		SetXCaretPolicy (wxSTC_CARET_EVEN|wxSTC_VISIBLE_STRICT|wxSTC_CARET_SLOP, 1);
		SetYCaretPolicy (wxSTC_CARET_EVEN|wxSTC_VISIBLE_STRICT|wxSTC_CARET_SLOP, 1);

		// markers
		MarkerDefine (wxSTC_MARKNUM_FOLDER,		wxSTC_MARK_DOTDOTDOT, Colour.wxBLACK, Colour.wxBLACK);
		MarkerDefine (wxSTC_MARKNUM_FOLDEROPEN,	wxSTC_MARK_ARROWDOWN, Colour.wxBLACK, Colour.wxBLACK);
		MarkerDefine (wxSTC_MARKNUM_FOLDERSUB,	 wxSTC_MARK_EMPTY,	 Colour.wxBLACK, Colour.wxBLACK);
		MarkerDefine (wxSTC_MARKNUM_FOLDEREND,	 wxSTC_MARK_DOTDOTDOT, Colour.wxBLACK, Colour.wxWHITE);
		MarkerDefine (wxSTC_MARKNUM_FOLDEROPENMID, wxSTC_MARK_ARROWDOWN, Colour.wxBLACK, Colour.wxWHITE);
		MarkerDefine (wxSTC_MARKNUM_FOLDERMIDTAIL, wxSTC_MARK_EMPTY,	 Colour.wxBLACK, Colour.wxBLACK);
		MarkerDefine (wxSTC_MARKNUM_FOLDERTAIL,	wxSTC_MARK_EMPTY,	 Colour.wxBLACK, Colour.wxBLACK);

		// miscelaneous
		m_LineNrMargin = TextWidth (wxSTC_STYLE_LINENUMBER, "_999999");
		m_FoldingMargin = 16;
		CmdKeyClear (wxSTC_KEY_TAB, 0); // this is done by the menu accelerator key
		LayoutCache (wxSTC_CACHE_PAGE);

		// common
		EVT_SIZE (                        &OnSize);
		// edit
		EVT_MENU (MenuIDs.wxID_CLEAR,     &OnEditClear);
		EVT_MENU (MenuIDs.wxID_CUT,       &OnEditCut);
		EVT_MENU (MenuIDs.wxID_COPY,      &OnEditCopy);
		EVT_MENU (MenuIDs.wxID_PASTE,     &OnEditPaste);
		EVT_MENU (myID_INDENTINC,         &OnEditIndentInc);
		EVT_MENU (myID_INDENTRED,         &OnEditIndentRed);
		EVT_MENU (MenuIDs.wxID_SELECTALL, &OnEditSelectAll);
		EVT_MENU (myID_SELECTLINE,        &OnEditSelectLine);
		EVT_MENU (MenuIDs.wxID_REDO,      &OnEditRedo);
		EVT_MENU (MenuIDs.wxID_UNDO,      &OnEditUndo);
		// find
		EVT_MENU (MenuIDs.wxID_FIND,      &OnFind);
		EVT_MENU (myID_FINDNEXT,          &OnFindNext);
		EVT_MENU (myID_REPLACE,           &OnReplace);
		EVT_MENU (myID_REPLACENEXT,       &OnReplaceNext);
		EVT_MENU (myID_BRACEMATCH,        &OnBraceMatch);
		EVT_MENU (myID_GOTO,              &OnGoto);
		// view
		EVT_MENU_RANGE (myID_HILIGHTFIRST, myID_HILIGHTLAST,
		                                  &OnHilightLang);
		EVT_MENU (myID_DISPLAYEOL,        &OnDisplayEOL);
		EVT_MENU (myID_INDENTGUIDE,       &OnIndentGuide);
		EVT_MENU (myID_LINENUMBER,        &OnLineNumber);
		EVT_MENU (myID_LONGLINEON,        &OnLongLineOn);
		EVT_MENU (myID_WHITESPACE,        &OnWhiteSpace);
		EVT_MENU (myID_FOLDTOGGLE,        &OnFoldToggle);
		EVT_MENU (myID_OVERTYPE,          &OnSetOverType);
		EVT_MENU (myID_READONLY,          &OnSetReadOnly);
		EVT_MENU (myID_WRAPMODEON,        &OnWrapmodeOn);
		EVT_MENU (myID_CHARSETANSI,       &OnUseCharset);
		EVT_MENU (myID_CHARSETMAC,        &OnUseCharset);
		// extra
		EVT_MENU (myID_CHANGELOWER,       &OnChangeCase);
		EVT_MENU (myID_CHANGEUPPER,       &OnChangeCase);
		EVT_MENU (myID_CONVERTCR,         &OnConvertEOL);
		EVT_MENU (myID_CONVERTCRLF,       &OnConvertEOL);
		EVT_MENU (myID_CONVERTLF,         &OnConvertEOL);
		// stc
		EVT_STC_MARGINCLICK (wxID_ANY,    cast(EventListener)&OnMarginClick);
		EVT_STC_CHARADDED (wxID_ANY,      cast(EventListener)&OnCharAdded);
	}

	//----------------------------------------------------------------------------
	// common event handlers
	public void OnSize(Object sender, Event event )
	{
		int x = ClientSize.Width +
				(g_CommonPrefs.lineNumberEnable? m_LineNrMargin: 0) +
				(g_CommonPrefs.foldEnable? m_FoldingMargin: 0);
		if (x > 0) ScrollWidth = x;
		
		event.Skip();
	}

	// edit event handlers
	public void OnEditRedo (Object sender, Event event)
	{
		if (!CanRedo()) return;

		Redo ();
	}

	public void OnEditUndo (Object sender, Event event)
	{
		if (!CanUndo()) return;

		Undo ();
	}

	public void OnEditClear (Object sender, Event event)
	{
		if (ReadOnly) return;

		Clear ();
	}

	public void OnEditCut (Object sender, Event event)
	{
		if (ReadOnly || (SelectionEnd-SelectionStart <= 0)) return;

		Cut ();
	}

	public void OnEditCopy (Object sender, Event event)
	{
		if (SelectionEnd-SelectionStart <= 0) return;

		Copy ();
	}

	public void OnEditPaste (Object sender, Event event)
	{
		if (!CanPaste()) return;

		Paste ();
	}

	public void OnFind (Object sender, Event event) {}

	public void OnFindNext (Object sender, Event event) {}

	public void OnReplace (Object sender, Event event) {}

	public void OnReplaceNext (Object sender, Event event) {}

	public void OnBraceMatch (Object sender, Event event)
	{
		int min = CurrentPos;
		int max = BraceMatch (min);
		if (max > (min+1))
		{
			BraceHighlight (min+1, max);
			SetSelection (min+1, max);
		}
		else
		{
			BraceBadLight (min);
		}
	}

	public void OnGoto (Object sender, Event event) {}

	public void OnEditIndentInc (Object sender, Event event)
	{
		CmdKeyExecute (wxSTC_CMD_TAB);
	}

	public void OnEditIndentRed (Object sender, Event event)
	{
		CmdKeyExecute (wxSTC_CMD_DELETEBACK);
	}

	public void OnEditSelectAll (Object sender, Event event)
	{
		SetSelection (0, TextLength);
	}

	public void OnEditSelectLine (Object sender, Event event)
	{
		int lineStart = PositionFromLine (CurrentLine);
		int lineEnd = PositionFromLine (CurrentLine + 1);
		SetSelection (lineStart, lineEnd);
	}

	public void OnHilightLang (Object sender, Event event)
	{
		InitializePrefs (g_LanguagePrefs [event.ID - myID_HILIGHTFIRST].name);
	}

	public void OnDisplayEOL (Object sender, Event event)
	{
		ViewEOL = !ViewEOL;
	}

	public void OnIndentGuide (Object sender, Event event)
	{
		IndentationGuides = !IndentationGuides;
	}

	public void OnLineNumber (Object sender, Event event)
	{
		SetMarginWidth (m_LineNrID,	GetMarginWidth (m_LineNrID) == 0 ? m_LineNrMargin: 0);
	}

	public void OnLongLineOn (Object sender, Event event)
	{
		EdgeMode = (EdgeMode == 0 ? wxSTC_EDGE_LINE: wxSTC_EDGE_NONE);
	}

	public void OnWhiteSpace (Object sender, Event event)
	{
		ViewWhiteSpace = (ViewWhiteSpace == 0 ? wxSTC_WS_VISIBLEALWAYS: wxSTC_WS_INVISIBLE);
	}

	public void OnFoldToggle (Object sender, Event event)
	{
		ToggleFold (GetFoldParent(CurrentLine));
	}

	public void OnSetOverType (Object sender, Event event)
	{
		Overtype = !Overtype;
	}

	public void OnSetReadOnly (Object sender, Event event)
	{
		ReadOnly = !ReadOnly;
	}

	public void OnWrapmodeOn (Object sender, Event event)
	{
		WrapMode = (WrapMode == 0? wxSTC_WRAP_WORD: wxSTC_WRAP_NONE);
	}

	public void OnUseCharset (Object sender, Event event)
	{
		int Nr;
		int charset = CodePage;
		switch (event.ID)
		{
			case myID_CHARSETANSI: {charset = wxSTC_CHARSET_ANSI; break;}
			case myID_CHARSETMAC: {charset = wxSTC_CHARSET_ANSI; break;}
		}
		for (Nr = 0; Nr < wxSTC_STYLE_LASTPREDEFINED; Nr++)
		{
			StyleSetCharacterSet (Nr, charset);
		}
		CodePage = charset;
	}

	public void OnChangeCase (Object sender, Event event)
	{
		switch (event.ID)
		{
			case myID_CHANGELOWER:
				CmdKeyExecute (wxSTC_CMD_LOWERCASE);
				break;
			case myID_CHANGEUPPER:
				CmdKeyExecute (wxSTC_CMD_UPPERCASE);
				break;
		}
	}

	public void OnConvertEOL (Object sender, Event event)
	{
		int eolMode = EOLMode;
		switch (event.ID)
		{
			case myID_CONVERTCR: { eolMode = wxSTC_EOL_CR; break;}
			case myID_CONVERTCRLF: { eolMode = wxSTC_EOL_CRLF; break;}
			case myID_CONVERTLF: { eolMode = wxSTC_EOL_LF; break;}
		}
		ConvertEOLs (eolMode);
		EOLMode (eolMode);
	}

	// misc
	public void OnMarginClick (Object sender, StyledTextEvent event)
	{
		if (event.Margin == 2)
		{
			int lineClick = LineFromPosition (event.Position);
			int levelClick = GetFoldLevel (lineClick);
			if ((levelClick & wxSTC_FOLDLEVELHEADERFLAG) > 0)
			{
				ToggleFold (lineClick);
			}
		}
	}

	public void OnCharAdded (Object sender, StyledTextEvent event)
	{
		char chr = cast(char)event.Key;
		int currentLine = CurrentLine;
		// Change this if support for mac files with \r is needed
		if (chr == '\n')
		{
			int lineInd = 0;
			if (currentLine > 0)
			{
				lineInd = GetLineIndentation(currentLine - 1);
			}
			if (lineInd == 0) return;
			
			SetLineIndentation (currentLine, lineInd);
			GotoPos(PositionFromLine (currentLine) + lineInd);
		}
	}

	public char[] DeterminePrefs (char[] filename)
	{
		//nested functions used to replace some wxSring functions.
		char[] AfterFirst(char[] str, char ch)
		{
			int idx = rfind(str, ch);
	
			if(idx == -1) return "";
			else return str[idx+1..$].dup;
		}

		char[] AfterLast(char[] str, char ch)
		{
			int idx = rfind(str, ch);

			if(idx == -1) return str.dup;
			else return str[idx+1..$].dup;
		}

		char[] BeforeFirst(char[] str, char ch)
		{
			int idx = find(str, ch);

			if(idx == -1) return str.dup;
			else return str[0..idx];
		}

		char[] BeforeLast(char[]str, char ch)
		{
			int idx = rfind(str, ch);

			if(idx == -1) return "";
			else return str[0..idx].dup;
		}
		//end nwsted functions

		Prefs.LanguageInfo curInfo;

		// determine language from filepatterns
		int languageNr;
		for (languageNr = 0; languageNr < g_LanguagePrefs.length; languageNr++)
		{
			curInfo = g_LanguagePrefs [languageNr];
			char[] filepattern = curInfo.filepattern;
			filepattern = tolower(filepattern);
			while (!filepattern.length == 0)
			{
				char[] cur = BeforeFirst(filepattern, ';');
				if ((cur == filename) ||
					(cur == (BeforeLast(filename, '.') ~ ".*")) ||
					(cur == ("*." ~ AfterLast(filename, '.')))) {
					return curInfo.name;
				}
				filepattern = AfterFirst(filepattern, ';');
			}
		}

		return "";
	}

	public bool InitializePrefs (char[] name)
	{
		// initialize styles
		StyleClearAll();
		Prefs.LanguageInfo curInfo;

		// determine language
		bool found = false;
		int languageNr;
		for (languageNr = 0; languageNr < g_LanguagePrefs.length; languageNr++)
		{
			curInfo = g_LanguagePrefs [languageNr];
			if (curInfo.name == name)
			{
				found = true;
				break;
			}
		}
		if (!found) return false;

		// set lexer and language
		Lexer (curInfo.lexer);
		m_language = curInfo;

		// set margin for line numbers
		SetMarginType (m_LineNrID, wxSTC_MARGIN_NUMBER);
		StyleSetForeground (wxSTC_STYLE_LINENUMBER, new Colour ("DARK GREY"));
		StyleSetBackground (wxSTC_STYLE_LINENUMBER, Colour.wxWHITE);
		SetMarginWidth (m_LineNrID, 0); // start out not visible

		// default fonts for all styles!
		int Nr;
		for (Nr = 0; Nr < wxSTC_STYLE_LASTPREDEFINED; Nr++)
		{
			Font font = new Font(10, FontFamily.wxMODERN, FontStyle.wxNORMAL, FontWeight.wxNORMAL);
			StyleSetFont (Nr, font);
		}

		// set common styles
		StyleSetForeground (wxSTC_STYLE_DEFAULT, new Colour ("DARK GREY"));
		StyleSetForeground (wxSTC_STYLE_INDENTGUIDE, new Colour ("DARK GREY"));

		
		// initialize settings
		if (g_CommonPrefs.syntaxEnable)
		{
			int keywordnr = 0;
			for (Nr = 0; Nr < STYLE_TYPES_COUNT; Nr++)
			{
				if (curInfo.styles[Nr].type == -1) continue;

				/+const+/ StyleInfo curType = g_StylePrefs [curInfo.styles[Nr].type];
				Font font = new Font(curType.fontsize, FontFamily.wxMODERN, FontStyle.wxNORMAL, FontWeight.wxNORMAL,
							false, curType.fontname);
				StyleSetFont (Nr, font);
				if (curType.foreground)
				{
					StyleSetForeground (Nr, new Colour (curType.foreground));
				}
				if (curType.background)
				{
					StyleSetBackground (Nr, new Colour (curType.background));
				}
				StyleSetBold (Nr, (curType.fontstyle & mySTC_STYLE_BOLD) > 0);
				StyleSetItalic (Nr, (curType.fontstyle & mySTC_STYLE_ITALIC) > 0);
				StyleSetUnderline (Nr, (curType.fontstyle & mySTC_STYLE_UNDERL) > 0);
				StyleSetVisible (Nr, (curType.fontstyle & mySTC_STYLE_HIDDEN) == 0);
				StyleSetCase (Nr, curType.lettercase);
				char[] pwords = curInfo.styles[Nr].words;
				if (pwords)
				{
					SetKeyWords (keywordnr, pwords);
					keywordnr += 1;
				}
			}
		}

		// set margin as unused
		SetMarginType (m_DividerID, wxSTC_MARGIN_SYMBOL);
		SetMarginWidth (m_DividerID, 0);
		SetMarginSensitive (m_DividerID, false);

		// folding
		SetMarginType (m_FoldingID, wxSTC_MARGIN_SYMBOL);
		SetMarginMask (m_FoldingID, wxSTC_MASK_FOLDERS);
		StyleSetBackground (m_FoldingID, Colour.wxWHITE);
		SetMarginWidth (m_FoldingID, 0);
		SetMarginSensitive (m_FoldingID, false);
		if (g_CommonPrefs.foldEnable)
		{
			SetMarginWidth (m_FoldingID, curInfo.folds != 0? m_FoldingMargin: 0);
			SetMarginSensitive (m_FoldingID, curInfo.folds != 0);
			SetProperty ("fold", curInfo.folds != 0? "1": "0");
			SetProperty ("fold.comment", (curInfo.folds & mySTC_FOLD_COMMENT) > 0? "1": "0");
			SetProperty ("fold.compact", (curInfo.folds & mySTC_FOLD_COMPACT) > 0? "1": "0");
			SetProperty ("fold.preprocessor", (curInfo.folds & mySTC_FOLD_PREPROC) > 0? "1": "0");
			SetProperty ("fold.html", (curInfo.folds & mySTC_FOLD_HTML) > 0? "1": "0");
			SetProperty ("fold.html.preprocessor", (curInfo.folds & mySTC_FOLD_HTMLPREP) > 0? "1": "0");
			SetProperty ("fold.comment.python", (curInfo.folds & mySTC_FOLD_COMMENTPY) > 0? "1": "0");
			SetProperty ("fold.quotes.python", (curInfo.folds & mySTC_FOLD_QUOTESPY) > 0? "1": "0");
		}

		FoldFlags = wxSTC_FOLDFLAG_LINEBEFORE_CONTRACTED | wxSTC_FOLDFLAG_LINEAFTER_CONTRACTED;

		// set spaces and indention
		TabWidth = 4;
		UseTabs = false;
		TabIndents = true;
		BackSpaceUnIndents = true;
		Indent = (g_CommonPrefs.indentEnable? 4: 0);

		// others
		ViewEOL = g_CommonPrefs.displayEOLEnable;
		IndentationGuides = g_CommonPrefs.indentGuideEnable;
		EdgeColumn = 80;
		EdgeMode = (g_CommonPrefs.longLineOnEnable? wxSTC_EDGE_LINE: wxSTC_EDGE_NONE);
		ViewWhiteSpace = (g_CommonPrefs.whiteSpaceEnable ? wxSTC_WS_VISIBLEALWAYS: wxSTC_WS_INVISIBLE);
		Overtype = g_CommonPrefs.overTypeInitial;
		ReadOnly = g_CommonPrefs.readOnlyInitial;
		WrapMode = (g_CommonPrefs.wrapModeInitial ? wxSTC_WRAP_WORD: wxSTC_WRAP_NONE);

		return true;
	}

	public bool LoadFile ()
	{
		// get filname
		if (!m_filename)
		{
			FileDialog dlg = new FileDialog(this, "Open file", "", "",
					"Any file (*)|*", FileDialog.wxOPEN | FileDialog.wxFILE_MUST_EXIST | FileDialog.wxCHANGE_DIR);
			if (dlg.ShowModal() != wxID_OK) return false;
			
			m_filename = dlg.Path;
		}

		// load file
		return LoadFile (m_filename);
	}

	public bool LoadFile (char[] filename)
	{
		// load file in edit and clear undo
		if (!filename.length < 1) m_filename = filename;

		ClearAll ();
		StyledTextCtrl.LoadFile(m_filename);
		EmptyUndoBuffer();

		// determine lexer language
		InitializePrefs (DeterminePrefs(getBaseName(m_filename)));

		return true;
	}

	public bool SaveFile ()
	{
		// return if no change
		if (!Modified()) return true;

		// get filname
		if (!m_filename)
		{
			FileDialog dlg = new FileDialog(this, "Save file", "", "", "Any file (*)|*",
					FileDialog.wxSAVE | FileDialog.wxOVERWRITE_PROMPT);
			if (dlg.ShowModal() != wxID_OK) return false;
			
			m_filename = dlg.Path;
		}

		// save file
		return SaveFile (m_filename);
	}

	public bool SaveFile (char[] filename)
	{
		// return if no change
		if (!Modified()) return true;

		return StyledTextCtrl.SaveFile(filename);
	}

	public bool Modified ()
	{
		// return modified state
		return (Modify && !ReadOnly);
	}

	//Properties
	public Prefs.LanguageInfo GetLanguageInfo () {return m_language;}
	public char[] GetFilename () {return m_filename;}
	public void SetFilename (char[] filename) {m_filename = filename;}
}

//----------------------------------------------------------------------------
// EditProperties
//----------------------------------------------------------------------------

public class EditProperties : Dialog {

	public this (Edit edit, long style)
	{
		super(edit, wxID_ANY, "", wxDefaultPosition, wxDefaultSize,
				style | Dialog.wxDEFAULT_DIALOG_STYLE | Dialog.wxRESIZE_BORDER);

		// sets the application title
		Title ("Properties");
		char[] text;

		// fullname
		BoxSizer fullname = new BoxSizer (Orientation.wxHORIZONTAL);
		fullname.Add (10, 0);
		fullname.Add (new StaticText (this, wxID_ANY, "Full filename", wxDefaultPosition, Size(80, -1)),
					   0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL);
		fullname.Add (new StaticText (this, wxID_ANY, edit.GetFilename()),
					   0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL);

		// text info
		GridSizer textinfo = new GridSizer (4, 0, 2);
		textinfo.Add (new StaticText (this, wxID_ANY, "Language", wxDefaultPosition, Size(80, -1)),
					   0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT, 4);
		textinfo.Add (new StaticText (this, wxID_ANY, edit.m_language.name),
					   0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxRIGHT, 4);
		textinfo.Add (new StaticText (this, wxID_ANY, "Lexer-ID: ", wxDefaultPosition, Size(80, -1)),
					   0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT, 4);
		text = format("%d", edit.Lexer());
		textinfo.Add (new StaticText (this, wxID_ANY, text),
					   0, Alignment.wxALIGN_RIGHT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxRIGHT, 4);
		char[] EOLtype = "";
		switch (edit.EOLMode) {
			case StyledTextCtrl.wxSTC_EOL_CR: {EOLtype = "CR (Unix)"; break; }
			case StyledTextCtrl.wxSTC_EOL_CRLF: {EOLtype = "CRLF (Windows)"; break; }
			case StyledTextCtrl.wxSTC_EOL_LF: {EOLtype = "CR (Macintosh)"; break; }
		}
		textinfo.Add (new StaticText (this, wxID_ANY, "Line endings", wxDefaultPosition, Size(80, -1)),
					   0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT, 4);
		textinfo.Add (new StaticText (this, wxID_ANY, EOLtype),
					   0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxRIGHT, 4);

		// text info box
		StaticBoxSizer textinfos = new StaticBoxSizer (
						 new StaticBox (this, wxID_ANY, "Informations"),
						 Orientation.wxVERTICAL);
		textinfos.Add (textinfo, 0, Stretch.wxEXPAND);
		textinfos.Add (0, 6);

		// statistic
		GridSizer statistic = new GridSizer (4, 0, 2);
		statistic.Add (new StaticText (this, wxID_ANY, "Total lines", wxDefaultPosition, Size(80, -1)),
						0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT, 4);
		text = format("%d", edit.LineCount);
		statistic.Add (new StaticText (this, wxID_ANY, text),
						0, Alignment.wxALIGN_RIGHT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxRIGHT, 4);
		statistic.Add (new StaticText (this, wxID_ANY, "Total chars", wxDefaultPosition, Size(80, -1)),
						0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT, 4);
		text = format("%d", edit.TextLength);
		statistic.Add (new StaticText (this, wxID_ANY, text),
						0, Alignment.wxALIGN_RIGHT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxRIGHT, 4);
		statistic.Add (new StaticText (this, wxID_ANY, "Current line", wxDefaultPosition, Size(80, -1)),
						0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT, 4);
		text = format("%d", edit.CurrentLine);
		statistic.Add (new StaticText (this, wxID_ANY, text),
						0, Alignment.wxALIGN_RIGHT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxRIGHT, 4);
		statistic.Add (new StaticText (this, wxID_ANY, "Current pos", wxDefaultPosition, Size(80, -1)),
						0, Alignment.wxALIGN_LEFT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxLEFT, 4);
		text = format("%d", edit.CurrentPos);
		statistic.Add (new StaticText (this, wxID_ANY, text),
						0, Alignment.wxALIGN_RIGHT|Alignment.wxALIGN_CENTER_VERTICAL|Direction.wxRIGHT, 4);

		// char/line statistics
		StaticBoxSizer statistics = new StaticBoxSizer (
						 new StaticBox (this, wxID_ANY, "Statistics"),
						 Orientation.wxVERTICAL);
		statistics.Add (statistic, 0, Stretch.wxEXPAND);
		statistics.Add (0, 6);

		// total pane
		BoxSizer totalpane = new BoxSizer (Orientation.wxVERTICAL);
		totalpane.Add (fullname, 0, Stretch.wxEXPAND | Direction.wxLEFT | Direction.wxRIGHT | Direction.wxTOP, 10);
		totalpane.Add (0, 6);
		totalpane.Add (textinfos, 0, Stretch.wxEXPAND | Direction.wxLEFT | Direction.wxRIGHT, 10);
		totalpane.Add (0, 10);
		totalpane.Add (statistics, 0, Stretch.wxEXPAND | Direction.wxLEFT | Direction.wxRIGHT, 10);
		totalpane.Add (0, 6);
		Button okButton = new Button (this, wxID_OK, "OK");
		okButton.SetDefault();
		totalpane.Add (okButton, 0, Alignment.wxALIGN_CENTER | Direction.wxALL, 10);

		SetSizerAndFit (totalpane, true);

		ShowModal();
	}

}

//----------------------------------------------------------------------------
// EditPrint
//----------------------------------------------------------------------------

public class EditPrint : Printout {

	private Edit edit;
	private int printed;
	private Rectangle pageRect;
	private Rectangle printRect;

	public this (Edit edit, char[] title = "")
	{
		super(title);

		this.edit = edit;
	}

	// event handlers
	public bool OnPrintPage (int page)
	{
		DC dc = Dc;
		if (!dc) return false;

		// scale DC
		PrintScaling (dc);

		// print page
		if (page == 1) printed = 0;
		printed = edit.FormatRange (1, printed, edit.Length,
				dc, dc, printRect, pageRect);

		return true;
	}

	public bool OnBeginDocument (int startPage, int endPage)
	{
		if (!Printout.OnBeginDocument (startPage, endPage))
		{
			return false;
		}
		return true;
	}

	public void GetPageInfo (ref int minPage, ref int maxPage, ref int selPageFrom, ref int selPageTo)
	{
		// initialize values
		minPage = 0;
		maxPage = 0;
		selPageFrom = 0;
		selPageTo = 0;

		// scale DC if possible
		DC dc = Dc;
		if (!dc) return;
		PrintScaling (dc);

		// get print page informations and convert to printer pixels
		Size ppiScr;
		GetPPIScreen (ppiScr.Width, ppiScr.Height);
		Size page = g_pageSetupData.paperSize;
		page.Width = cast(int) (page.Width * ppiScr.Width / 25.4);
		page.Height = cast(int) (page.Height * ppiScr.Height / 25.4);
		pageRect = Rectangle (0,
		                      0,
		                      page.Width,
		                      page.Height);

		// get margins informations and convert to printer pixels
		Point pt = g_pageSetupData.MarginTopLeft;
		int left = pt.X;
		int top = pt.Y;
		pt = g_pageSetupData.MarginBottomRight;
		int right = pt.X;
		int bottom = pt.Y;

		top = cast(int) (top * ppiScr.Height / 25.4);
		bottom = cast(int) (bottom * ppiScr.Height / 25.4);
		left = cast(int) (left * ppiScr.Width / 25.4);
		right = cast(int) (right * ppiScr.Width / 25.4);

		printRect = Rectangle (left,
		                       top,
		                       page.Width - (left + right),
		                       page.Height - (top + bottom));

		// count pages
		while (HasPage (maxPage))
		{
			printed = edit.FormatRange (0, printed, edit.Length,
					dc, dc, printRect, pageRect);
			maxPage += 1;
		}
		if (maxPage > 0) minPage = 1;
		selPageFrom = minPage;
		selPageTo = maxPage;
	}

	// print functions
	public bool HasPage (int page)
	{
		return (printed < edit.Length);
	}

	public bool PrintScaling (DC dc)
	{
		// check for dc, return if none
		if (!dc) return false;

		// get printer and screen sizing values
		Size ppiScr;
		GetPPIScreen (ppiScr.Width, ppiScr.Height);
		if (ppiScr.Width == 0) 
		{ 
			// most possible guess 96 dpi
			ppiScr.Width = 96;
			ppiScr.Height = 96;
		}
		Size ppiPrt;
		GetPPIPrinter (ppiPrt.Width, ppiPrt.Height);
		if (ppiPrt.Width == 0)
		{
			// scaling factor to 1
			ppiPrt.Width = ppiScr.Width;
			ppiPrt.Height = ppiScr.Height;
		}
		Size dcSize = dc.size;
		Size pageSize;
		GetPageSizePixels (pageSize.Width, pageSize.Height);

		// set user scale
		float scale_x = cast(float)(ppiPrt.Width * dcSize.Width) /
						cast(float)(ppiScr.Width * pageSize.Width);
		float scale_y = cast(float)(ppiPrt.Height * dcSize.Height) /
						cast(float)(ppiScr.Height * pageSize.Height);
		dc.SetUserScale (scale_x, scale_y);

		return true;
	}
}
