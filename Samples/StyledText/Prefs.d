//////////////////////////////////////////////////////////////////////////////
// File:        prefs.h
// Purpose:     STC test Preferences initialization
// Maintainer:  Wyo
// Created:     2003-09-01
// RCS-ID:      $Id$
// Copyright:   (c) wxGuide
// Licence:     wxWindows licence
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// headers
//----------------------------------------------------------------------------

//! wxWidgets headers

//! wxWidgets/contrib headers
public import wx.StyledTextCtrl;

//! application headers
private import defsext;    // Additional definitions


//============================================================================
// declarations
//============================================================================

//! general style types
const int mySTC_TYPE_DEFAULT = 0;

const int mySTC_TYPE_WORD1 = 1;
const int mySTC_TYPE_WORD2 = 2;
const int mySTC_TYPE_WORD3 = 3;
const int mySTC_TYPE_WORD4 = 4;
const int mySTC_TYPE_WORD5 = 5;
const int mySTC_TYPE_WORD6 = 6;

const int mySTC_TYPE_COMMENT = 7;
const int mySTC_TYPE_COMMENT_DOC = 8;
const int mySTC_TYPE_COMMENT_LINE = 9;
const int mySTC_TYPE_COMMENT_SPECIAL = 10;

const int mySTC_TYPE_CHARACTER = 11;
const int mySTC_TYPE_CHARACTER_EOL = 12;
const int mySTC_TYPE_STRING = 13;
const int mySTC_TYPE_STRING_EOL = 14;

const int mySTC_TYPE_DELIMITER = 15;

const int mySTC_TYPE_PUNCTUATION = 16;

const int mySTC_TYPE_OPERATOR = 17;

const int mySTC_TYPE_BRACE = 18;

const int mySTC_TYPE_COMMAND = 19;
const int mySTC_TYPE_IDENTIFIER = 20;
const int mySTC_TYPE_LABEL = 21;
const int mySTC_TYPE_NUMBER = 22;
const int mySTC_TYPE_PARAMETER = 23;
const int mySTC_TYPE_REGEX = 24;
const int mySTC_TYPE_UUID = 25;
const int mySTC_TYPE_VALUE = 26;

const int mySTC_TYPE_PREPROCESSOR = 27;
const int mySTC_TYPE_SCRIPT = 28;

const int mySTC_TYPE_ERROR = 29;

//----------------------------------------------------------------------------
//! style bits types
const int mySTC_STYLE_BOLD = 1;
const int mySTC_STYLE_ITALIC = 2;
const int mySTC_STYLE_UNDERL = 4;
const int mySTC_STYLE_HIDDEN = 8;

//----------------------------------------------------------------------------
//! general folding types
const int mySTC_FOLD_COMMENT = 1;
const int mySTC_FOLD_COMPACT = 2;
const int mySTC_FOLD_PREPROC = 4;

const int mySTC_FOLD_HTML = 16;
const int mySTC_FOLD_HTMLPREP = 32;

const int mySTC_FOLD_COMMENTPY = 64;
const int mySTC_FOLD_QUOTESPY = 128;

//----------------------------------------------------------------------------
//! flags
const int mySTC_FLAG_WRAPMODE = 16;

//----------------------------------------------------------------------------
// CommonInfo

struct CommonInfo {
    // editor functionality prefs
    bool syntaxEnable;
    bool foldEnable;
    bool indentEnable;
    // display defaults prefs
    bool readOnlyInitial;
    bool overTypeInitial;
    bool wrapModeInitial;
    bool displayEOLEnable;
    bool indentGuideEnable;
    bool lineNumberEnable;
    bool longLineOnEnable;
    bool whiteSpaceEnable;
};
extern const CommonInfo g_CommonPrefs;

//----------------------------------------------------------------------------
// LanguageInfo

struct LanguageInfo {
    wxChar *name;
    wxChar *filepattern;
    int lexer;
    struct {
        int type;
        const wxChar *words;
    } styles [STYLE_TYPES_COUNT];
    int folds;
};

extern const LanguageInfo g_LanguagePrefs[];
extern const int g_LanguagePrefsSize;

//----------------------------------------------------------------------------
// StyleInfo
struct StyleInfo {
    wxChar *name;
    wxChar *foreground;
    wxChar *background;
    wxChar *fontname;
    int fontsize;
    int fontstyle;
    int lettercase;
};

extern const StyleInfo g_StylePrefs[];
extern const int g_StylePrefsSize;

//============================================================================
// declarations
//============================================================================

//----------------------------------------------------------------------------
//! language types
const CommonInfo g_CommonPrefs = {
    // editor functionality prefs
    true,  // syntaxEnable
    true,  // foldEnable
    true,  // indentEnable
    // display defaults prefs
    false, // overTypeInitial
    false, // readOnlyInitial
    false,  // wrapModeInitial
    false, // displayEOLEnable
    false, // IndentGuideEnable
    true,  // lineNumberEnable
    false, // longLineOnEnable
    false, // whiteSpaceEnable
};

//----------------------------------------------------------------------------
// keywordlists
// C++
wxChar* CppWordlist1 =
    "asm auto bool break case catch char class const const_cast "
    "continue default delete do double dynamic_cast else enum explicit "
    "export extern false float for friend goto if inline int long "
    "mutable namespace new operator private protected public register "
    "reinterpret_cast return short signed sizeof static static_cast "
    "struct switch template this throw true try typedef typeid "
    "typename union unsigned using virtual void volatile wchar_t "
    "while";
wxChar* CppWordlist2 =
    "file";
wxChar* CppWordlist3 =
    "a addindex addtogroup anchor arg attention author b brief bug c "
    "class code date def defgroup deprecated dontinclude e em endcode "
    "endhtmlonly endif endlatexonly endlink endverbatim enum example "
    "exception f$ f[ f] file fn hideinitializer htmlinclude "
    "htmlonly if image include ingroup internal invariant interface "
    "latexonly li line link mainpage name namespace nosubgrouping note "
    "overload p page par param post pre ref relates remarks return "
    "retval sa section see showinitializer since skip skipline struct "
    "subsection test throw todo typedef union until var verbatim "
    "verbinclude version warning weakgroup $ @ \"\" & < > # { }";

// Python
wxChar* PythonWordlist1 =
    "and assert break class continue def del elif else except exec "
    "finally for from global if import in is lambda None not or pass "
    "print raise return try while yield";
wxChar* PythonWordlist2 =
    "ACCELERATORS ALT AUTO3STATE AUTOCHECKBOX AUTORADIOBUTTON BEGIN "
    "BITMAP BLOCK BUTTON CAPTION CHARACTERISTICS CHECKBOX CLASS "
    "COMBOBOX CONTROL CTEXT CURSOR DEFPUSHBUTTON DIALOG DIALOGEX "
    "DISCARDABLE EDITTEXT END EXSTYLE FONT GROUPBOX ICON LANGUAGE "
    "LISTBOX LTEXT MENU MENUEX MENUITEM MESSAGETABLE POPUP PUSHBUTTON "
    "RADIOBUTTON RCDATA RTEXT SCROLLBAR SEPARATOR SHIFT STATE3 "
    "STRINGTABLE STYLE TEXTINCLUDE VALUE VERSION VERSIONINFO VIRTKEY";


//----------------------------------------------------------------------------
//! languages
const LanguageInfo g_LanguagePrefs [] = {
    // C++
    {"C++",
     "*.c;*.cc;*.cpp;*.cxx;*.cs;*.h;*.hh;*.hpp;*.hxx;*.sma",
     wxSTC_LEX_CPP,
     {{mySTC_TYPE_DEFAULT, NULL},
      {mySTC_TYPE_COMMENT, NULL},
      {mySTC_TYPE_COMMENT_LINE, NULL},
      {mySTC_TYPE_COMMENT_DOC, NULL},
      {mySTC_TYPE_NUMBER, NULL},
      {mySTC_TYPE_WORD1, CppWordlist1}, // KEYWORDS
      {mySTC_TYPE_STRING, NULL},
      {mySTC_TYPE_CHARACTER, NULL},
      {mySTC_TYPE_UUID, NULL},
      {mySTC_TYPE_PREPROCESSOR, NULL},
      {mySTC_TYPE_OPERATOR, NULL},
      {mySTC_TYPE_IDENTIFIER, NULL},
      {mySTC_TYPE_STRING_EOL, NULL},
      {mySTC_TYPE_DEFAULT, NULL}, // VERBATIM
      {mySTC_TYPE_REGEX, NULL},
      {mySTC_TYPE_COMMENT_SPECIAL, NULL}, // DOXY
      {mySTC_TYPE_WORD2, CppWordlist2}, // EXTRA WORDS
      {mySTC_TYPE_WORD3, CppWordlist3}, // DOXY KEYWORDS
      {mySTC_TYPE_ERROR, NULL}, // KEYWORDS ERROR
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL}},
     mySTC_FOLD_COMMENT | mySTC_FOLD_COMPACT | mySTC_FOLD_PREPROC},
    // Python
    {"Python",
     "*.py;*.pyw",
     wxSTC_LEX_PYTHON,
     {{mySTC_TYPE_DEFAULT, NULL},
      {mySTC_TYPE_COMMENT_LINE, NULL},
      {mySTC_TYPE_NUMBER, NULL},
      {mySTC_TYPE_STRING, NULL},
      {mySTC_TYPE_CHARACTER, NULL},
      {mySTC_TYPE_WORD1, PythonWordlist1}, // KEYWORDS
      {mySTC_TYPE_DEFAULT, NULL}, // TRIPLE
      {mySTC_TYPE_DEFAULT, NULL}, // TRIPLEDOUBLE
      {mySTC_TYPE_DEFAULT, NULL}, // CLASSNAME
      {mySTC_TYPE_DEFAULT, PythonWordlist2}, // DEFNAME
      {mySTC_TYPE_OPERATOR, NULL},
      {mySTC_TYPE_IDENTIFIER, NULL},
      {mySTC_TYPE_DEFAULT, NULL}, // COMMENT_BLOCK
      {mySTC_TYPE_STRING_EOL, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL}},
     mySTC_FOLD_COMMENTPY | mySTC_FOLD_QUOTESPY},
    // * (any)
    {(wxChar *)DEFAULT_LANGUAGE,
     "*.*",
     wxSTC_LEX_PROPERTIES,
     {{mySTC_TYPE_DEFAULT, NULL},
      {mySTC_TYPE_DEFAULT, NULL},
      {mySTC_TYPE_DEFAULT, NULL},
      {mySTC_TYPE_DEFAULT, NULL},
      {mySTC_TYPE_DEFAULT, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL},
      {-1, NULL}},
     0},
    };

const int g_LanguagePrefsSize = WXSIZEOF(g_LanguagePrefs);

//----------------------------------------------------------------------------
//! style types
const StyleInfo g_StylePrefs [] = {
    // mySTC_TYPE_DEFAULT
    {"Default",
     "BLACK", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_WORD1
    {"Keyword1",
     "BLUE", "WHITE",
     "", 10, mySTC_STYLE_BOLD, 0},

    // mySTC_TYPE_WORD2
    {"Keyword2",
     "DARK BLUE", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_WORD3
    {"Keyword3",
     "CORNFLOWER BLUE", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_WORD4
    {"Keyword4",
     "CYAN", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_WORD5
    {"Keyword5",
     "DARK GREY", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_WORD6
    {"Keyword6",
     "GREY", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_COMMENT
    {"Comment",
     "FOREST GREEN", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_COMMENT_DOC
    {"Comment (Doc)",
     "FOREST GREEN", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_COMMENT_LINE
    {"Comment line",
     "FOREST GREEN", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_COMMENT_SPECIAL
    {"Special comment",
     "FOREST GREEN", "WHITE",
     "", 10, mySTC_STYLE_ITALIC, 0},

    // mySTC_TYPE_CHARACTER
    {"Character",
     "KHAKI", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_CHARACTER_EOL
    {"Character (EOL)",
     "KHAKI", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_STRING
    {"String",
     "BROWN", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_STRING_EOL
    {"String (EOL)",
     "BROWN", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_DELIMITER
    {"Delimiter",
     "ORANGE", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_PUNCTUATION
    {"Punctuation",
     "ORANGE", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_OPERATOR
    {"Operator",
     "BLACK", "WHITE",
     "", 10, mySTC_STYLE_BOLD, 0},

    // mySTC_TYPE_BRACE
    {"Label",
     "VIOLET", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_COMMAND
    {"Command",
     "BLUE", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_IDENTIFIER
    {"Identifier",
     "BLACK", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_LABEL
    {"Label",
     "VIOLET", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_NUMBER
    {"Number",
     "SIENNA", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_PARAMETER
    {"Parameter",
     "VIOLET", "WHITE",
     "", 10, mySTC_STYLE_ITALIC, 0},

    // mySTC_TYPE_REGEX
    {"Regular expression",
     "ORCHID", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_UUID
    {"UUID",
     "ORCHID", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_VALUE
    {"Value",
     "ORCHID", "WHITE",
     "", 10, mySTC_STYLE_ITALIC, 0},

    // mySTC_TYPE_PREPROCESSOR
    {"Preprocessor",
     "GREY", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_SCRIPT
    {"Script",
     "DARK GREY", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_ERROR
    {"Error",
     "RED", "WHITE",
     "", 10, 0, 0},

    // mySTC_TYPE_UNDEFINED
    {"Undefined",
     "ORANGE", "WHITE",
     "", 10, 0, 0}

    };

const int g_StylePrefsSize = WXSIZEOF(g_StylePrefs);
