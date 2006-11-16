//-----------------------------------------------------------------------------
// wx.NET - StyledTextCtrl.h
// 
// The wxStyledTextCtrl wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#if WXNET_STYLEDTEXTCTRL

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class StyledTextCtrl : Control 
    {
        //-----------------------------------------------------------------------------

        // StyledTextCtrl Events
 
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_CHANGE();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_STYLENEEDED();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_CHARADDED();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT();  
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_KEY();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_DOUBLECLICK();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_UPDATEUI();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_MODIFIED();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_MACRORECORD();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_MARGINCLICK();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_NEEDSHOWN();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_POSCHANGED();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_PAINTED();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_USERLISTSELECTION();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_URIDROPPED();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_DWELLSTART();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_DWELLEND();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_START_DRAG();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_DRAG_OVER();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_DO_DROP();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_ZOOM();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK();
        [DllImport("wx-c")] static extern int wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK();

        public static readonly int wxEVT_STC_CHANGE = wxStyledTextCtrl_EVT_STC_CHANGE();
        public static readonly int wxEVT_STC_STYLENEEDED = wxStyledTextCtrl_EVT_STC_STYLENEEDED();
        public static readonly int wxEVT_STC_CHARADDED = wxStyledTextCtrl_EVT_STC_CHARADDED();
        public static readonly int wxEVT_STC_SAVEPOINTREACHED = wxStyledTextCtrl_EVT_STC_SAVEPOINTREACHED();
        public static readonly int wxEVT_STC_SAVEPOINTLEFT = wxStyledTextCtrl_EVT_STC_SAVEPOINTLEFT();  
        public static readonly int wxEVT_STC_ROMODIFYATTEMPT = wxStyledTextCtrl_EVT_STC_ROMODIFYATTEMPT();
        public static readonly int wxEVT_STC_KEY = wxStyledTextCtrl_EVT_STC_KEY();
        public static readonly int wxEVT_STC_DOUBLECLICK = wxStyledTextCtrl_EVT_STC_DOUBLECLICK();
        public static readonly int wxEVT_STC_UPDATEUI = wxStyledTextCtrl_EVT_STC_UPDATEUI();
        public static readonly int wxEVT_STC_MODIFIED = wxStyledTextCtrl_EVT_STC_MODIFIED();
        public static readonly int wxEVT_STC_MACRORECORD = wxStyledTextCtrl_EVT_STC_MACRORECORD();
        public static readonly int wxEVT_STC_MARGINCLICK = wxStyledTextCtrl_EVT_STC_MARGINCLICK();
        public static readonly int wxEVT_STC_NEEDSHOWN = wxStyledTextCtrl_EVT_STC_NEEDSHOWN();
        //public static readonly int wxEVT_STC_POSCHANGED = wxStyledTextCtrl_EVT_STC_POSCHANGED();
        public static readonly int wxEVT_STC_PAINTED = wxStyledTextCtrl_EVT_STC_PAINTED();
        public static readonly int wxEVT_STC_USERLISTSELECTION = wxStyledTextCtrl_EVT_STC_USERLISTSELECTION();
        public static readonly int wxEVT_STC_URIDROPPED = wxStyledTextCtrl_EVT_STC_URIDROPPED();
        public static readonly int wxEVT_STC_DWELLSTART = wxStyledTextCtrl_EVT_STC_DWELLSTART();
        public static readonly int wxEVT_STC_DWELLEND = wxStyledTextCtrl_EVT_STC_DWELLEND();
        public static readonly int wxEVT_STC_START_DRAG = wxStyledTextCtrl_EVT_STC_START_DRAG();
        public static readonly int wxEVT_STC_DRAG_OVER = wxStyledTextCtrl_EVT_STC_DRAG_OVER();
        public static readonly int wxEVT_STC_DO_DROP = wxStyledTextCtrl_EVT_STC_DO_DROP();
        public static readonly int wxEVT_STC_ZOOM = wxStyledTextCtrl_EVT_STC_ZOOM();
        public static readonly int wxEVT_STC_HOTSPOT_CLICK = wxStyledTextCtrl_EVT_STC_HOTSPOT_CLICK();
        public static readonly int wxEVT_STC_HOTSPOT_DCLICK = wxStyledTextCtrl_EVT_STC_HOTSPOT_DCLICK();
        public static readonly int wxEVT_STC_CALLTIP_CLICK = wxStyledTextCtrl_EVT_STC_CALLTIP_CLICK();

        //-----------------------------------------------------------------------------

        public const int wxSTC_INVALID_POSITION = -1;

        // Define start of Scintilla messages to be greater than all edit (EM_*) messages
        // as many EM_ messages can be used although that use is deprecated.
        public const int wxSTC_START = 2000;
        public const int wxSTC_OPTIONAL_START = 3000;
        public const int wxSTC_LEXER_START = 4000;
        public const int wxSTC_WS_INVISIBLE = 0;
        public const int wxSTC_WS_VISIBLEALWAYS = 1;
        public const int wxSTC_WS_VISIBLEAFTERINDENT = 2;
        public const int wxSTC_EOL_CRLF = 0;
        public const int wxSTC_EOL_CR = 1;
        public const int wxSTC_EOL_LF = 2;

        // The SC_CP_UTF8 value can be used to enter Unicode mode.
        // This is the same value as CP_UTF8 in Windows
        public const int wxSTC_CP_UTF8 = 65001;

        // The SC_CP_DBCS value can be used to indicate a DBCS mode for GTK+.
        public const int wxSTC_CP_DBCS = 1;
        public const int wxSTC_MARKER_MAX = 31;
        public const int wxSTC_MARK_CIRCLE = 0;
        public const int wxSTC_MARK_ROUNDRECT = 1;
        public const int wxSTC_MARK_ARROW = 2;
        public const int wxSTC_MARK_SMALLRECT = 3;
        public const int wxSTC_MARK_SHORTARROW = 4;
        public const int wxSTC_MARK_EMPTY = 5;
        public const int wxSTC_MARK_ARROWDOWN = 6;
        public const int wxSTC_MARK_MINUS = 7;
        public const int wxSTC_MARK_PLUS = 8;

        // Shapes used for outlining column.
        public const int wxSTC_MARK_VLINE = 9;
        public const int wxSTC_MARK_LCORNER = 10;
        public const int wxSTC_MARK_TCORNER = 11;
        public const int wxSTC_MARK_BOXPLUS = 12;
        public const int wxSTC_MARK_BOXPLUSCONNECTED = 13;
        public const int wxSTC_MARK_BOXMINUS = 14;
        public const int wxSTC_MARK_BOXMINUSCONNECTED = 15;
        public const int wxSTC_MARK_LCORNERCURVE = 16;
        public const int wxSTC_MARK_TCORNERCURVE = 17;
        public const int wxSTC_MARK_CIRCLEPLUS = 18;
        public const int wxSTC_MARK_CIRCLEPLUSCONNECTED = 19;
        public const int wxSTC_MARK_CIRCLEMINUS = 20;
        public const int wxSTC_MARK_CIRCLEMINUSCONNECTED = 21;

        // Invisible mark that only sets the line background color.
        public const int wxSTC_MARK_BACKGROUND = 22;
        public const int wxSTC_MARK_DOTDOTDOT = 23;
        public const int wxSTC_MARK_ARROWS = 24;
        public const int wxSTC_MARK_PIXMAP = 25;
        public const int wxSTC_MARK_CHARACTER = 10000;

        // Markers used for outlining column.
        public const int wxSTC_MARKNUM_FOLDEREND = 25;
        public const int wxSTC_MARKNUM_FOLDEROPENMID = 26;
        public const int wxSTC_MARKNUM_FOLDERMIDTAIL = 27;
        public const int wxSTC_MARKNUM_FOLDERTAIL = 28;
        public const int wxSTC_MARKNUM_FOLDERSUB = 29;
        public const int wxSTC_MARKNUM_FOLDER = 30;
        public const int wxSTC_MARKNUM_FOLDEROPEN = 31;
        public const int wxSTC_MASK_FOLDERS = -1;
        public const int wxSTC_MARGIN_SYMBOL = 0;
        public const int wxSTC_MARGIN_NUMBER = 1;

        // Styles in range 32..37 are predefined for parts of the UI and are not used as normal styles.
        // Styles 38 and 39 are for future use.
        public const int wxSTC_STYLE_DEFAULT = 32;
        public const int wxSTC_STYLE_LINENUMBER = 33;
        public const int wxSTC_STYLE_BRACELIGHT = 34;
        public const int wxSTC_STYLE_BRACEBAD = 35;
        public const int wxSTC_STYLE_CONTROLCHAR = 36;
        public const int wxSTC_STYLE_INDENTGUIDE = 37;
        public const int wxSTC_STYLE_LASTPREDEFINED = 39;
        public const int wxSTC_STYLE_MAX = 127;

        // Character set identifiers are used in StyleSetCharacterSet.
        // The values are the same as the Windows *_CHARSET values.
        public const int wxSTC_CHARSET_ANSI = 0;
        public const int wxSTC_CHARSET_DEFAULT = 1;
        public const int wxSTC_CHARSET_BALTIC = 186;
        public const int wxSTC_CHARSET_CHINESEBIG5 = 136;
        public const int wxSTC_CHARSET_EASTEUROPE = 238;
        public const int wxSTC_CHARSET_GB2312 = 134;
        public const int wxSTC_CHARSET_GREEK = 161;
        public const int wxSTC_CHARSET_HANGUL = 129;
        public const int wxSTC_CHARSET_MAC = 77;
        public const int wxSTC_CHARSET_OEM = 255;
        public const int wxSTC_CHARSET_RUSSIAN = 204;
        public const int wxSTC_CHARSET_SHIFTJIS = 128;
        public const int wxSTC_CHARSET_SYMBOL = 2;
        public const int wxSTC_CHARSET_TURKISH = 162;
        public const int wxSTC_CHARSET_JOHAB = 130;
        public const int wxSTC_CHARSET_HEBREW = 177;
        public const int wxSTC_CHARSET_ARABIC = 178;
        public const int wxSTC_CHARSET_VIETNAMESE = 163;
        public const int wxSTC_CHARSET_THAI = 222;
        public const int wxSTC_CASE_MIXED = 0;
        public const int wxSTC_CASE_UPPER = 1;
        public const int wxSTC_CASE_LOWER = 2;
        public const int wxSTC_INDIC_MAX = 7;
        public const int wxSTC_INDIC_PLAIN = 0;
        public const int wxSTC_INDIC_SQUIGGLE = 1;
        public const int wxSTC_INDIC_TT = 2;
        public const int wxSTC_INDIC_DIAGONAL = 3;
        public const int wxSTC_INDIC_STRIKE = 4;
        public const int wxSTC_INDIC0_MASK = 0x20;
        public const int wxSTC_INDIC1_MASK = 0x40;
        public const int wxSTC_INDIC2_MASK = 0x80;
        public const int wxSTC_INDICS_MASK = 0xE0;

        // PrintColourMode - use same colours as screen.
        public const int wxSTC_PRINT_NORMAL = 0;

        // PrintColourMode - invert the light value of each style for printing.
        public const int wxSTC_PRINT_INVERTLIGHT = 1;

        // PrintColourMode - force black text on white background for printing.
        public const int wxSTC_PRINT_BLACKONWHITE = 2;

        // PrintColourMode - text stays coloured, but all background is forced to be white for printing.
        public const int wxSTC_PRINT_COLOURONWHITE = 3;

        // PrintColourMode - only the default-background is forced to be white for printing.
        public const int wxSTC_PRINT_COLOURONWHITEDEFAULTBG = 4;
        public const int wxSTC_FIND_WHOLEWORD = 2;
        public const int wxSTC_FIND_MATCHCASE = 4;
        public const int wxSTC_FIND_WORDSTART = 0x00100000;
        public const int wxSTC_FIND_REGEXP = 0x00200000;
        public const int wxSTC_FIND_POSIX = 0x00400000;
        public const int wxSTC_FOLDLEVELBASE = 0x400;
        public const int wxSTC_FOLDLEVELWHITEFLAG = 0x1000;
        public const int wxSTC_FOLDLEVELHEADERFLAG = 0x2000;
        public const int wxSTC_FOLDLEVELBOXHEADERFLAG = 0x4000;
        public const int wxSTC_FOLDLEVELBOXFOOTERFLAG = 0x8000;
        public const int wxSTC_FOLDLEVELCONTRACTED = 0x10000;
        public const int wxSTC_FOLDLEVELUNINDENT = 0x20000;
        public const int wxSTC_FOLDLEVELNUMBERMASK = 0x0FFF;
        public const int wxSTC_FOLDFLAG_LINEBEFORE_EXPANDED = 0x0002;
        public const int wxSTC_FOLDFLAG_LINEBEFORE_CONTRACTED = 0x0004;
        public const int wxSTC_FOLDFLAG_LINEAFTER_EXPANDED = 0x0008;
        public const int wxSTC_FOLDFLAG_LINEAFTER_CONTRACTED = 0x0010;
        public const int wxSTC_FOLDFLAG_LEVELNUMBERS = 0x0040;
        public const int wxSTC_FOLDFLAG_BOX = 0x0001;
        public const int wxSTC_TIME_FOREVER = 10000000;
        public const int wxSTC_WRAP_NONE = 0;
        public const int wxSTC_WRAP_WORD = 1;
        public const int wxSTC_CACHE_NONE = 0;
        public const int wxSTC_CACHE_CARET = 1;
        public const int wxSTC_CACHE_PAGE = 2;
        public const int wxSTC_CACHE_DOCUMENT = 3;
        public const int wxSTC_EDGE_NONE = 0;
        public const int wxSTC_EDGE_LINE = 1;
        public const int wxSTC_EDGE_BACKGROUND = 2;
        public const int wxSTC_CURSORNORMAL = -1;
        public const int wxSTC_CURSORWAIT = 4;

        // Constants for use with SetVisiblePolicy, similar to SetCaretPolicy.
        public const int wxSTC_VISIBLE_SLOP = 0x01;
        public const int wxSTC_VISIBLE_STRICT = 0x04;

        // Caret policy, used by SetXCaretPolicy and SetYCaretPolicy.
        // If CARET_SLOP is set, we can define a slop value: caretSlop.
        // This value defines an unwanted zone (UZ) where the caret is... unwanted.
        // This zone is defined as a number of pixels near the vertical margins,
        // and as a number of lines near the horizontal margins.
        // By keeping the caret away from the edges, it is seen within its context,
        // so it is likely that the identifier that the caret is on can be completely seen,
        // and that the current line is seen with some of the lines following it which are
        // often dependent on that line.
        public const int wxSTC_CARET_SLOP = 0x01;

        // If CARET_STRICT is set, the policy is enforced... strictly.
        // The caret is centred on the display if slop is not set,
        // and cannot go in the UZ if slop is set.
        public const int wxSTC_CARET_STRICT = 0x04;

        // If CARET_JUMPS is set, the display is moved more energetically
        // so the caret can move in the same direction longer before the policy is applied again.
        public const int wxSTC_CARET_JUMPS = 0x10;

        // If CARET_EVEN is not set, instead of having symmetrical UZs,
        // the left and bottom UZs are extended up to right and top UZs respectively.
        // This way, we favour the displaying of useful information: the begining of lines,
        // where most code reside, and the lines after the caret, eg. the body of a function.
        public const int wxSTC_CARET_EVEN = 0x08;

        // Notifications
        // Type of modification and the action which caused the modification.
        // These are defined as a bit mask to make it easy to specify which notifications are wanted.
        // One bit is set from each of SC_MOD_* and SC_PERFORMED_*.
        public const int wxSTC_MOD_INSERTTEXT = 0x1;
        public const int wxSTC_MOD_DELETETEXT = 0x2;
        public const int wxSTC_MOD_CHANGESTYLE = 0x4;
        public const int wxSTC_MOD_CHANGEFOLD = 0x8;
        public const int wxSTC_PERFORMED_USER = 0x10;
        public const int wxSTC_PERFORMED_UNDO = 0x20;
        public const int wxSTC_PERFORMED_REDO = 0x40;
        public const int wxSTC_LASTSTEPINUNDOREDO = 0x100;
        public const int wxSTC_MOD_CHANGEMARKER = 0x200;
        public const int wxSTC_MOD_BEFOREINSERT = 0x400;
        public const int wxSTC_MOD_BEFOREDELETE = 0x800;
        public const int wxSTC_MODEVENTMASKALL = 0xF77;

        // Symbolic key codes and modifier flags.
        // ASCII and other printable characters below 256.
        // Extended keys above 300.
        public const int wxSTC_KEY_DOWN = 300;
        public const int wxSTC_KEY_UP = 301;
        public const int wxSTC_KEY_LEFT = 302;
        public const int wxSTC_KEY_RIGHT = 303;
        public const int wxSTC_KEY_HOME = 304;
        public const int wxSTC_KEY_END = 305;
        public const int wxSTC_KEY_PRIOR = 306;
        public const int wxSTC_KEY_NEXT = 307;
        public const int wxSTC_KEY_DELETE = 308;
        public const int wxSTC_KEY_INSERT = 309;
        public const int wxSTC_KEY_ESCAPE = 7;
        public const int wxSTC_KEY_BACK = 8;
        public const int wxSTC_KEY_TAB = 9;
        public const int wxSTC_KEY_RETURN = 13;
        public const int wxSTC_KEY_ADD = 310;
        public const int wxSTC_KEY_SUBTRACT = 311;
        public const int wxSTC_KEY_DIVIDE = 312;
        public const int wxSTC_SCMOD_SHIFT = 1;
        public const int wxSTC_SCMOD_CTRL = 2;
        public const int wxSTC_SCMOD_ALT = 4;

        // For SciLexer.h
        public const int wxSTC_LEX_CONTAINER = 0;
        public const int wxSTC_LEX_NULL = 1;
        public const int wxSTC_LEX_PYTHON = 2;
        public const int wxSTC_LEX_CPP = 3;
        public const int wxSTC_LEX_HTML = 4;
        public const int wxSTC_LEX_XML = 5;
        public const int wxSTC_LEX_PERL = 6;
        public const int wxSTC_LEX_SQL = 7;
        public const int wxSTC_LEX_VB = 8;
        public const int wxSTC_LEX_PROPERTIES = 9;
        public const int wxSTC_LEX_ERRORLIST = 10;
        public const int wxSTC_LEX_MAKEFILE = 11;
        public const int wxSTC_LEX_BATCH = 12;
        public const int wxSTC_LEX_XCODE = 13;
        public const int wxSTC_LEX_LATEX = 14;
        public const int wxSTC_LEX_LUA = 15;
        public const int wxSTC_LEX_DIFF = 16;
        public const int wxSTC_LEX_CONF = 17;
        public const int wxSTC_LEX_PASCAL = 18;
        public const int wxSTC_LEX_AVE = 19;
        public const int wxSTC_LEX_ADA = 20;
        public const int wxSTC_LEX_LISP = 21;
        public const int wxSTC_LEX_RUBY = 22;
        public const int wxSTC_LEX_EIFFEL = 23;
        public const int wxSTC_LEX_EIFFELKW = 24;
        public const int wxSTC_LEX_TCL = 25;
        public const int wxSTC_LEX_NNCRONTAB = 26;
        public const int wxSTC_LEX_BULLANT = 27;
        public const int wxSTC_LEX_VBSCRIPT = 28;
        public const int wxSTC_LEX_ASP = 29;
        public const int wxSTC_LEX_PHP = 30;
        public const int wxSTC_LEX_BAAN = 31;
        public const int wxSTC_LEX_MATLAB = 32;
        public const int wxSTC_LEX_SCRIPTOL = 33;
        public const int wxSTC_LEX_ASM = 34;
        public const int wxSTC_LEX_CPPNOCASE = 35;
        public const int wxSTC_LEX_FORTRAN = 36;
        public const int wxSTC_LEX_F77 = 37;
        public const int wxSTC_LEX_CSS = 38;
        public const int wxSTC_LEX_POV = 39;

        // When a lexer specifies its language as SCLEX_AUTOMATIC it receives a
        // value assigned in sequence from SCLEX_AUTOMATIC+1.
        public const int wxSTC_LEX_AUTOMATIC = 1000;

        // Lexical states for SCLEX_PYTHON
        public const int wxSTC_P_DEFAULT = 0;
        public const int wxSTC_P_COMMENTLINE = 1;
        public const int wxSTC_P_NUMBER = 2;
        public const int wxSTC_P_STRING = 3;
        public const int wxSTC_P_CHARACTER = 4;
        public const int wxSTC_P_WORD = 5;
        public const int wxSTC_P_TRIPLE = 6;
        public const int wxSTC_P_TRIPLEDOUBLE = 7;
        public const int wxSTC_P_CLASSNAME = 8;
        public const int wxSTC_P_DEFNAME = 9;
        public const int wxSTC_P_OPERATOR = 10;
        public const int wxSTC_P_IDENTIFIER = 11;
        public const int wxSTC_P_COMMENTBLOCK = 12;
        public const int wxSTC_P_STRINGEOL = 13;

        // Lexical states for SCLEX_CPP
        public const int wxSTC_C_DEFAULT = 0;
        public const int wxSTC_C_COMMENT = 1;
        public const int wxSTC_C_COMMENTLINE = 2;
        public const int wxSTC_C_COMMENTDOC = 3;
        public const int wxSTC_C_NUMBER = 4;
        public const int wxSTC_C_WORD = 5;
        public const int wxSTC_C_STRING = 6;
        public const int wxSTC_C_CHARACTER = 7;
        public const int wxSTC_C_UUID = 8;
        public const int wxSTC_C_PREPROCESSOR = 9;
        public const int wxSTC_C_OPERATOR = 10;
        public const int wxSTC_C_IDENTIFIER = 11;
        public const int wxSTC_C_STRINGEOL = 12;
        public const int wxSTC_C_VERBATIM = 13;
        public const int wxSTC_C_REGEX = 14;
        public const int wxSTC_C_COMMENTLINEDOC = 15;
        public const int wxSTC_C_WORD2 = 16;
        public const int wxSTC_C_COMMENTDOCKEYWORD = 17;
        public const int wxSTC_C_COMMENTDOCKEYWORDERROR = 18;

        // Lexical states for SCLEX_HTML, SCLEX_XML
        public const int wxSTC_H_DEFAULT = 0;
        public const int wxSTC_H_TAG = 1;
        public const int wxSTC_H_TAGUNKNOWN = 2;
        public const int wxSTC_H_ATTRIBUTE = 3;
        public const int wxSTC_H_ATTRIBUTEUNKNOWN = 4;
        public const int wxSTC_H_NUMBER = 5;
        public const int wxSTC_H_DOUBLESTRING = 6;
        public const int wxSTC_H_SINGLESTRING = 7;
        public const int wxSTC_H_OTHER = 8;
        public const int wxSTC_H_COMMENT = 9;
        public const int wxSTC_H_ENTITY = 10;

        // XML and ASP
        public const int wxSTC_H_TAGEND = 11;
        public const int wxSTC_H_XMLSTART = 12;
        public const int wxSTC_H_XMLEND = 13;
        public const int wxSTC_H_SCRIPT = 14;
        public const int wxSTC_H_ASP = 15;
        public const int wxSTC_H_ASPAT = 16;
        public const int wxSTC_H_CDATA = 17;
        public const int wxSTC_H_QUESTION = 18;

        // More HTML
        public const int wxSTC_H_VALUE = 19;

        // X-Code
        public const int wxSTC_H_XCCOMMENT = 20;

        // SGML
        public const int wxSTC_H_SGML_DEFAULT = 21;
        public const int wxSTC_H_SGML_COMMAND = 22;
        public const int wxSTC_H_SGML_1ST_PARAM = 23;
        public const int wxSTC_H_SGML_DOUBLESTRING = 24;
        public const int wxSTC_H_SGML_SIMPLESTRING = 25;
        public const int wxSTC_H_SGML_ERROR = 26;
        public const int wxSTC_H_SGML_SPECIAL = 27;
        public const int wxSTC_H_SGML_ENTITY = 28;
        public const int wxSTC_H_SGML_COMMENT = 29;
        public const int wxSTC_H_SGML_1ST_PARAM_COMMENT = 30;
        public const int wxSTC_H_SGML_BLOCK_DEFAULT = 31;

        // Embedded Javascript
        public const int wxSTC_HJ_START = 40;
        public const int wxSTC_HJ_DEFAULT = 41;
        public const int wxSTC_HJ_COMMENT = 42;
        public const int wxSTC_HJ_COMMENTLINE = 43;
        public const int wxSTC_HJ_COMMENTDOC = 44;
        public const int wxSTC_HJ_NUMBER = 45;
        public const int wxSTC_HJ_WORD = 46;
        public const int wxSTC_HJ_KEYWORD = 47;
        public const int wxSTC_HJ_DOUBLESTRING = 48;
        public const int wxSTC_HJ_SINGLESTRING = 49;
        public const int wxSTC_HJ_SYMBOLS = 50;
        public const int wxSTC_HJ_STRINGEOL = 51;
        public const int wxSTC_HJ_REGEX = 52;

        // ASP Javascript
        public const int wxSTC_HJA_START = 55;
        public const int wxSTC_HJA_DEFAULT = 56;
        public const int wxSTC_HJA_COMMENT = 57;
        public const int wxSTC_HJA_COMMENTLINE = 58;
        public const int wxSTC_HJA_COMMENTDOC = 59;
        public const int wxSTC_HJA_NUMBER = 60;
        public const int wxSTC_HJA_WORD = 61;
        public const int wxSTC_HJA_KEYWORD = 62;
        public const int wxSTC_HJA_DOUBLESTRING = 63;
        public const int wxSTC_HJA_SINGLESTRING = 64;
        public const int wxSTC_HJA_SYMBOLS = 65;
        public const int wxSTC_HJA_STRINGEOL = 66;
        public const int wxSTC_HJA_REGEX = 67;

        // Embedded VBScript
        public const int wxSTC_HB_START = 70;
        public const int wxSTC_HB_DEFAULT = 71;
        public const int wxSTC_HB_COMMENTLINE = 72;
        public const int wxSTC_HB_NUMBER = 73;
        public const int wxSTC_HB_WORD = 74;
        public const int wxSTC_HB_STRING = 75;
        public const int wxSTC_HB_IDENTIFIER = 76;
        public const int wxSTC_HB_STRINGEOL = 77;

        // ASP VBScript
        public const int wxSTC_HBA_START = 80;
        public const int wxSTC_HBA_DEFAULT = 81;
        public const int wxSTC_HBA_COMMENTLINE = 82;
        public const int wxSTC_HBA_NUMBER = 83;
        public const int wxSTC_HBA_WORD = 84;
        public const int wxSTC_HBA_STRING = 85;
        public const int wxSTC_HBA_IDENTIFIER = 86;
        public const int wxSTC_HBA_STRINGEOL = 87;

        // Embedded Python
        public const int wxSTC_HP_START = 90;
        public const int wxSTC_HP_DEFAULT = 91;
        public const int wxSTC_HP_COMMENTLINE = 92;
        public const int wxSTC_HP_NUMBER = 93;
        public const int wxSTC_HP_STRING = 94;
        public const int wxSTC_HP_CHARACTER = 95;
        public const int wxSTC_HP_WORD = 96;
        public const int wxSTC_HP_TRIPLE = 97;
        public const int wxSTC_HP_TRIPLEDOUBLE = 98;
        public const int wxSTC_HP_CLASSNAME = 99;
        public const int wxSTC_HP_DEFNAME = 100;
        public const int wxSTC_HP_OPERATOR = 101;
        public const int wxSTC_HP_IDENTIFIER = 102;

        // ASP Python
        public const int wxSTC_HPA_START = 105;
        public const int wxSTC_HPA_DEFAULT = 106;
        public const int wxSTC_HPA_COMMENTLINE = 107;
        public const int wxSTC_HPA_NUMBER = 108;
        public const int wxSTC_HPA_STRING = 109;
        public const int wxSTC_HPA_CHARACTER = 110;
        public const int wxSTC_HPA_WORD = 111;
        public const int wxSTC_HPA_TRIPLE = 112;
        public const int wxSTC_HPA_TRIPLEDOUBLE = 113;
        public const int wxSTC_HPA_CLASSNAME = 114;
        public const int wxSTC_HPA_DEFNAME = 115;
        public const int wxSTC_HPA_OPERATOR = 116;
        public const int wxSTC_HPA_IDENTIFIER = 117;

        // PHP
        public const int wxSTC_HPHP_DEFAULT = 118;
        public const int wxSTC_HPHP_HSTRING = 119;
        public const int wxSTC_HPHP_SIMPLESTRING = 120;
        public const int wxSTC_HPHP_WORD = 121;
        public const int wxSTC_HPHP_NUMBER = 122;
        public const int wxSTC_HPHP_VARIABLE = 123;
        public const int wxSTC_HPHP_COMMENT = 124;
        public const int wxSTC_HPHP_COMMENTLINE = 125;
        public const int wxSTC_HPHP_HSTRING_VARIABLE = 126;
        public const int wxSTC_HPHP_OPERATOR = 127;

        // Lexical states for SCLEX_PERL
        public const int wxSTC_PL_DEFAULT = 0;
        public const int wxSTC_PL_ERROR = 1;
        public const int wxSTC_PL_COMMENTLINE = 2;
        public const int wxSTC_PL_POD = 3;
        public const int wxSTC_PL_NUMBER = 4;
        public const int wxSTC_PL_WORD = 5;
        public const int wxSTC_PL_STRING = 6;
        public const int wxSTC_PL_CHARACTER = 7;
        public const int wxSTC_PL_PUNCTUATION = 8;
        public const int wxSTC_PL_PREPROCESSOR = 9;
        public const int wxSTC_PL_OPERATOR = 10;
        public const int wxSTC_PL_IDENTIFIER = 11;
        public const int wxSTC_PL_SCALAR = 12;
        public const int wxSTC_PL_ARRAY = 13;
        public const int wxSTC_PL_HASH = 14;
        public const int wxSTC_PL_SYMBOLTABLE = 15;
        public const int wxSTC_PL_REGEX = 17;
        public const int wxSTC_PL_REGSUBST = 18;
        public const int wxSTC_PL_LONGQUOTE = 19;
        public const int wxSTC_PL_BACKTICKS = 20;
        public const int wxSTC_PL_DATASECTION = 21;
        public const int wxSTC_PL_HERE_DELIM = 22;
        public const int wxSTC_PL_HERE_Q = 23;
        public const int wxSTC_PL_HERE_QQ = 24;
        public const int wxSTC_PL_HERE_QX = 25;
        public const int wxSTC_PL_STRING_Q = 26;
        public const int wxSTC_PL_STRING_QQ = 27;
        public const int wxSTC_PL_STRING_QX = 28;
        public const int wxSTC_PL_STRING_QR = 29;
        public const int wxSTC_PL_STRING_QW = 30;

        // Lexical states for SCLEX_VB, SCLEX_VBSCRIPT
        public const int wxSTC_B_DEFAULT = 0;
        public const int wxSTC_B_COMMENT = 1;
        public const int wxSTC_B_NUMBER = 2;
        public const int wxSTC_B_KEYWORD = 3;
        public const int wxSTC_B_STRING = 4;
        public const int wxSTC_B_PREPROCESSOR = 5;
        public const int wxSTC_B_OPERATOR = 6;
        public const int wxSTC_B_IDENTIFIER = 7;
        public const int wxSTC_B_DATE = 8;

        // Lexical states for SCLEX_PROPERTIES
        public const int wxSTC_PROPS_DEFAULT = 0;
        public const int wxSTC_PROPS_COMMENT = 1;
        public const int wxSTC_PROPS_SECTION = 2;
        public const int wxSTC_PROPS_ASSIGNMENT = 3;
        public const int wxSTC_PROPS_DEFVAL = 4;

        // Lexical states for SCLEX_LATEX
        public const int wxSTC_L_DEFAULT = 0;
        public const int wxSTC_L_COMMAND = 1;
        public const int wxSTC_L_TAG = 2;
        public const int wxSTC_L_MATH = 3;
        public const int wxSTC_L_COMMENT = 4;

        // Lexical states for SCLEX_LUA
        public const int wxSTC_LUA_DEFAULT = 0;
        public const int wxSTC_LUA_COMMENT = 1;
        public const int wxSTC_LUA_COMMENTLINE = 2;
        public const int wxSTC_LUA_COMMENTDOC = 3;
        public const int wxSTC_LUA_NUMBER = 4;
        public const int wxSTC_LUA_WORD = 5;
        public const int wxSTC_LUA_STRING = 6;
        public const int wxSTC_LUA_CHARACTER = 7;
        public const int wxSTC_LUA_LITERALSTRING = 8;
        public const int wxSTC_LUA_PREPROCESSOR = 9;
        public const int wxSTC_LUA_OPERATOR = 10;
        public const int wxSTC_LUA_IDENTIFIER = 11;
        public const int wxSTC_LUA_STRINGEOL = 12;
        public const int wxSTC_LUA_WORD2 = 13;
        public const int wxSTC_LUA_WORD3 = 14;
        public const int wxSTC_LUA_WORD4 = 15;
        public const int wxSTC_LUA_WORD5 = 16;
        public const int wxSTC_LUA_WORD6 = 17;

        // Lexical states for SCLEX_ERRORLIST
        public const int wxSTC_ERR_DEFAULT = 0;
        public const int wxSTC_ERR_PYTHON = 1;
        public const int wxSTC_ERR_GCC = 2;
        public const int wxSTC_ERR_MS = 3;
        public const int wxSTC_ERR_CMD = 4;
        public const int wxSTC_ERR_BORLAND = 5;
        public const int wxSTC_ERR_PERL = 6;
        public const int wxSTC_ERR_NET = 7;
        public const int wxSTC_ERR_LUA = 8;
        public const int wxSTC_ERR_CTAG = 9;
        public const int wxSTC_ERR_DIFF_CHANGED = 10;
        public const int wxSTC_ERR_DIFF_ADDITION = 11;
        public const int wxSTC_ERR_DIFF_DELETION = 12;
        public const int wxSTC_ERR_DIFF_MESSAGE = 13;
        public const int wxSTC_ERR_PHP = 14;
        public const int wxSTC_ERR_ELF = 15;
        public const int wxSTC_ERR_IFC = 16;

        // Lexical states for SCLEX_BATCH
        public const int wxSTC_BAT_DEFAULT = 0;
        public const int wxSTC_BAT_COMMENT = 1;
        public const int wxSTC_BAT_WORD = 2;
        public const int wxSTC_BAT_LABEL = 3;
        public const int wxSTC_BAT_HIDE = 4;
        public const int wxSTC_BAT_COMMAND = 5;
        public const int wxSTC_BAT_IDENTIFIER = 6;
        public const int wxSTC_BAT_OPERATOR = 7;

        // Lexical states for SCLEX_MAKEFILE
        public const int wxSTC_MAKE_DEFAULT = 0;
        public const int wxSTC_MAKE_COMMENT = 1;
        public const int wxSTC_MAKE_PREPROCESSOR = 2;
        public const int wxSTC_MAKE_IDENTIFIER = 3;
        public const int wxSTC_MAKE_OPERATOR = 4;
        public const int wxSTC_MAKE_TARGET = 5;
        public const int wxSTC_MAKE_IDEOL = 9;

        // Lexical states for SCLEX_DIFF
        public const int wxSTC_DIFF_DEFAULT = 0;
        public const int wxSTC_DIFF_COMMENT = 1;
        public const int wxSTC_DIFF_COMMAND = 2;
        public const int wxSTC_DIFF_HEADER = 3;
        public const int wxSTC_DIFF_POSITION = 4;
        public const int wxSTC_DIFF_DELETED = 5;
        public const int wxSTC_DIFF_ADDED = 6;

        // Lexical states for SCLEX_CONF (Apache Configuration Files Lexer)
        public const int wxSTC_CONF_DEFAULT = 0;
        public const int wxSTC_CONF_COMMENT = 1;
        public const int wxSTC_CONF_NUMBER = 2;
        public const int wxSTC_CONF_IDENTIFIER = 3;
        public const int wxSTC_CONF_EXTENSION = 4;
        public const int wxSTC_CONF_PARAMETER = 5;
        public const int wxSTC_CONF_STRING = 6;
        public const int wxSTC_CONF_OPERATOR = 7;
        public const int wxSTC_CONF_IP = 8;
        public const int wxSTC_CONF_DIRECTIVE = 9;

        // Lexical states for SCLEX_AVE, Avenue
        public const int wxSTC_AVE_DEFAULT = 0;
        public const int wxSTC_AVE_COMMENT = 1;
        public const int wxSTC_AVE_NUMBER = 2;
        public const int wxSTC_AVE_WORD = 3;
        public const int wxSTC_AVE_STRING = 6;
        public const int wxSTC_AVE_ENUM = 7;
        public const int wxSTC_AVE_STRINGEOL = 8;
        public const int wxSTC_AVE_IDENTIFIER = 9;
        public const int wxSTC_AVE_OPERATOR = 10;
        public const int wxSTC_AVE_WORD1 = 11;
        public const int wxSTC_AVE_WORD2 = 12;
        public const int wxSTC_AVE_WORD3 = 13;
        public const int wxSTC_AVE_WORD4 = 14;
        public const int wxSTC_AVE_WORD5 = 15;
        public const int wxSTC_AVE_WORD6 = 16;

        // Lexical states for SCLEX_ADA
        public const int wxSTC_ADA_DEFAULT = 0;
        public const int wxSTC_ADA_WORD = 1;
        public const int wxSTC_ADA_IDENTIFIER = 2;
        public const int wxSTC_ADA_NUMBER = 3;
        public const int wxSTC_ADA_DELIMITER = 4;
        public const int wxSTC_ADA_CHARACTER = 5;
        public const int wxSTC_ADA_CHARACTEREOL = 6;
        public const int wxSTC_ADA_STRING = 7;
        public const int wxSTC_ADA_STRINGEOL = 8;
        public const int wxSTC_ADA_LABEL = 9;
        public const int wxSTC_ADA_COMMENTLINE = 10;
        public const int wxSTC_ADA_ILLEGAL = 11;

        // Lexical states for SCLEX_BAAN
        public const int wxSTC_BAAN_DEFAULT = 0;
        public const int wxSTC_BAAN_COMMENT = 1;
        public const int wxSTC_BAAN_COMMENTDOC = 2;
        public const int wxSTC_BAAN_NUMBER = 3;
        public const int wxSTC_BAAN_WORD = 4;
        public const int wxSTC_BAAN_STRING = 5;
        public const int wxSTC_BAAN_PREPROCESSOR = 6;
        public const int wxSTC_BAAN_OPERATOR = 7;
        public const int wxSTC_BAAN_IDENTIFIER = 8;
        public const int wxSTC_BAAN_STRINGEOL = 9;
        public const int wxSTC_BAAN_WORD2 = 10;

        // Lexical states for SCLEX_LISP
        public const int wxSTC_LISP_DEFAULT = 0;
        public const int wxSTC_LISP_COMMENT = 1;
        public const int wxSTC_LISP_NUMBER = 2;
        public const int wxSTC_LISP_KEYWORD = 3;
        public const int wxSTC_LISP_STRING = 6;
        public const int wxSTC_LISP_STRINGEOL = 8;
        public const int wxSTC_LISP_IDENTIFIER = 9;
        public const int wxSTC_LISP_OPERATOR = 10;

        // Lexical states for SCLEX_EIFFEL and SCLEX_EIFFELKW
        public const int wxSTC_EIFFEL_DEFAULT = 0;
        public const int wxSTC_EIFFEL_COMMENTLINE = 1;
        public const int wxSTC_EIFFEL_NUMBER = 2;
        public const int wxSTC_EIFFEL_WORD = 3;
        public const int wxSTC_EIFFEL_STRING = 4;
        public const int wxSTC_EIFFEL_CHARACTER = 5;
        public const int wxSTC_EIFFEL_OPERATOR = 6;
        public const int wxSTC_EIFFEL_IDENTIFIER = 7;
        public const int wxSTC_EIFFEL_STRINGEOL = 8;

        // Lexical states for SCLEX_NNCRONTAB (nnCron crontab Lexer)
        public const int wxSTC_NNCRONTAB_DEFAULT = 0;
        public const int wxSTC_NNCRONTAB_COMMENT = 1;
        public const int wxSTC_NNCRONTAB_TASK = 2;
        public const int wxSTC_NNCRONTAB_SECTION = 3;
        public const int wxSTC_NNCRONTAB_KEYWORD = 4;
        public const int wxSTC_NNCRONTAB_MODIFIER = 5;
        public const int wxSTC_NNCRONTAB_ASTERISK = 6;
        public const int wxSTC_NNCRONTAB_NUMBER = 7;
        public const int wxSTC_NNCRONTAB_STRING = 8;
        public const int wxSTC_NNCRONTAB_ENVIRONMENT = 9;
        public const int wxSTC_NNCRONTAB_IDENTIFIER = 10;

        // Lexical states for SCLEX_MATLAB
        public const int wxSTC_MATLAB_DEFAULT = 0;
        public const int wxSTC_MATLAB_COMMENT = 1;
        public const int wxSTC_MATLAB_COMMAND = 2;
        public const int wxSTC_MATLAB_NUMBER = 3;
        public const int wxSTC_MATLAB_KEYWORD = 4;
        public const int wxSTC_MATLAB_STRING = 5;
        public const int wxSTC_MATLAB_OPERATOR = 6;
        public const int wxSTC_MATLAB_IDENTIFIER = 7;

        // Lexical states for SCLEX_SCRIPTOL
        public const int wxSTC_SCRIPTOL_DEFAULT = 0;
        public const int wxSTC_SCRIPTOL_COMMENT = 1;
        public const int wxSTC_SCRIPTOL_COMMENTLINE = 2;
        public const int wxSTC_SCRIPTOL_COMMENTDOC = 3;
        public const int wxSTC_SCRIPTOL_NUMBER = 4;
        public const int wxSTC_SCRIPTOL_WORD = 5;
        public const int wxSTC_SCRIPTOL_STRING = 6;
        public const int wxSTC_SCRIPTOL_CHARACTER = 7;
        public const int wxSTC_SCRIPTOL_UUID = 8;
        public const int wxSTC_SCRIPTOL_PREPROCESSOR = 9;
        public const int wxSTC_SCRIPTOL_OPERATOR = 10;
        public const int wxSTC_SCRIPTOL_IDENTIFIER = 11;
        public const int wxSTC_SCRIPTOL_STRINGEOL = 12;
        public const int wxSTC_SCRIPTOL_VERBATIM = 13;
        public const int wxSTC_SCRIPTOL_REGEX = 14;
        public const int wxSTC_SCRIPTOL_COMMENTLINEDOC = 15;
        public const int wxSTC_SCRIPTOL_WORD2 = 16;
        public const int wxSTC_SCRIPTOL_COMMENTDOCKEYWORD = 17;
        public const int wxSTC_SCRIPTOL_COMMENTDOCKEYWORDERROR = 18;
        public const int wxSTC_SCRIPTOL_COMMENTBASIC = 19;

        // Lexical states for SCLEX_ASM
        public const int wxSTC_ASM_DEFAULT = 0;
        public const int wxSTC_ASM_COMMENT = 1;
        public const int wxSTC_ASM_NUMBER = 2;
        public const int wxSTC_ASM_STRING = 3;
        public const int wxSTC_ASM_OPERATOR = 4;
        public const int wxSTC_ASM_IDENTIFIER = 5;
        public const int wxSTC_ASM_CPUINSTRUCTION = 6;
        public const int wxSTC_ASM_MATHINSTRUCTION = 7;
        public const int wxSTC_ASM_REGISTER = 8;
        public const int wxSTC_ASM_DIRECTIVE = 9;
        public const int wxSTC_ASM_DIRECTIVEOPERAND = 10;

        // Lexical states for SCLEX_FORTRAN
        public const int wxSTC_F_DEFAULT = 0;
        public const int wxSTC_F_COMMENT = 1;
        public const int wxSTC_F_NUMBER = 2;
        public const int wxSTC_F_STRING1 = 3;
        public const int wxSTC_F_STRING2 = 4;
        public const int wxSTC_F_STRINGEOL = 5;
        public const int wxSTC_F_OPERATOR = 6;
        public const int wxSTC_F_IDENTIFIER = 7;
        public const int wxSTC_F_WORD = 8;
        public const int wxSTC_F_WORD2 = 9;
        public const int wxSTC_F_WORD3 = 10;
        public const int wxSTC_F_PREPROCESSOR = 11;
        public const int wxSTC_F_OPERATOR2 = 12;
        public const int wxSTC_F_LABEL = 13;
        public const int wxSTC_F_CONTINUATION = 14;

        // Lexical states for SCLEX_CSS
        public const int wxSTC_CSS_DEFAULT = 0;
        public const int wxSTC_CSS_TAG = 1;
        public const int wxSTC_CSS_CLASS = 2;
        public const int wxSTC_CSS_PSEUDOCLASS = 3;
        public const int wxSTC_CSS_UNKNOWN_PSEUDOCLASS = 4;
        public const int wxSTC_CSS_OPERATOR = 5;
        public const int wxSTC_CSS_IDENTIFIER = 6;
        public const int wxSTC_CSS_UNKNOWN_IDENTIFIER = 7;
        public const int wxSTC_CSS_VALUE = 8;
        public const int wxSTC_CSS_COMMENT = 9;
        public const int wxSTC_CSS_ID = 10;
        public const int wxSTC_CSS_IMPORTANT = 11;
        public const int wxSTC_CSS_DIRECTIVE = 12;
        public const int wxSTC_CSS_DOUBLESTRING = 13;
        public const int wxSTC_CSS_SINGLESTRING = 14;

        // Lexical states for SCLEX_POV
        public const int wxSTC_POV_DEFAULT = 0;
        public const int wxSTC_POV_COMMENT = 1;
        public const int wxSTC_POV_COMMENTLINE = 2;
        public const int wxSTC_POV_COMMENTDOC = 3;
        public const int wxSTC_POV_NUMBER = 4;
        public const int wxSTC_POV_WORD = 5;
        public const int wxSTC_POV_STRING = 6;
        public const int wxSTC_POV_OPERATOR = 7;
        public const int wxSTC_POV_IDENTIFIER = 8;
        public const int wxSTC_POV_BRACE = 9;
        public const int wxSTC_POV_WORD2 = 10;


        //-----------------------------------------
        // Commands that can be bound to keystrokes

        // Redoes the next action on the undo history.
        public const int wxSTC_CMD_REDO = 2011;

        // Select all the text in the document.
        public const int wxSTC_CMD_SELECTALL = 2013;

        // Undo one action in the undo history.
        public const int wxSTC_CMD_UNDO = 2176;

        // Cut the selection to the clipboard.
        public const int wxSTC_CMD_CUT = 2177;

        // Copy the selection to the clipboard.
        public const int wxSTC_CMD_COPY = 2178;

        // Paste the contents of the clipboard into the document replacing the selection.
        public const int wxSTC_CMD_PASTE = 2179;

        // Clear the selection.
        public const int wxSTC_CMD_CLEAR = 2180;

        // Move caret down one line.
        public const int wxSTC_CMD_LINEDOWN = 2300;

        // Move caret down one line extending selection to new caret position.
        public const int wxSTC_CMD_LINEDOWNEXTEND = 2301;

        // Move caret up one line.
        public const int wxSTC_CMD_LINEUP = 2302;

        // Move caret up one line extending selection to new caret position.
        public const int wxSTC_CMD_LINEUPEXTEND = 2303;

        // Move caret left one character.
        public const int wxSTC_CMD_CHARLEFT = 2304;

        // Move caret left one character extending selection to new caret position.
        public const int wxSTC_CMD_CHARLEFTEXTEND = 2305;

        // Move caret right one character.
        public const int wxSTC_CMD_CHARRIGHT = 2306;

        // Move caret right one character extending selection to new caret position.
        public const int wxSTC_CMD_CHARRIGHTEXTEND = 2307;

        // Move caret left one word.
        public const int wxSTC_CMD_WORDLEFT = 2308;

        // Move caret left one word extending selection to new caret position.
        public const int wxSTC_CMD_WORDLEFTEXTEND = 2309;

        // Move caret right one word.
        public const int wxSTC_CMD_WORDRIGHT = 2310;

        // Move caret right one word extending selection to new caret position.
        public const int wxSTC_CMD_WORDRIGHTEXTEND = 2311;

        // Move caret to first position on line.
        public const int wxSTC_CMD_HOME = 2312;

        // Move caret to first position on line extending selection to new caret position.
        public const int wxSTC_CMD_HOMEEXTEND = 2313;

        // Move caret to last position on line.
        public const int wxSTC_CMD_LINEEND = 2314;

        // Move caret to last position on line extending selection to new caret position.
        public const int wxSTC_CMD_LINEENDEXTEND = 2315;

        // Move caret to first position in document.
        public const int wxSTC_CMD_DOCUMENTSTART = 2316;

        // Move caret to first position in document extending selection to new caret position.
        public const int wxSTC_CMD_DOCUMENTSTARTEXTEND = 2317;

        // Move caret to last position in document.
        public const int wxSTC_CMD_DOCUMENTEND = 2318;

        // Move caret to last position in document extending selection to new caret position.
        public const int wxSTC_CMD_DOCUMENTENDEXTEND = 2319;

        // Move caret one page up.
        public const int wxSTC_CMD_PAGEUP = 2320;

        // Move caret one page up extending selection to new caret position.
        public const int wxSTC_CMD_PAGEUPEXTEND = 2321;

        // Move caret one page down.
        public const int wxSTC_CMD_PAGEDOWN = 2322;

        // Move caret one page down extending selection to new caret position.
        public const int wxSTC_CMD_PAGEDOWNEXTEND = 2323;

        // Switch from insert to overtype mode or the reverse.
        public const int wxSTC_CMD_EDITTOGGLEOVERTYPE = 2324;

        // Cancel any modes such as call tip or auto-completion list display.
        public const int wxSTC_CMD_CANCEL = 2325;

        // Delete the selection or if no selection, the character before the caret.
        public const int wxSTC_CMD_DELETEBACK = 2326;

        // If selection is empty or all on one line replace the selection with a tab character.
        // If more than one line selected, indent the lines.
        public const int wxSTC_CMD_TAB = 2327;

        // Dedent the selected lines.
        public const int wxSTC_CMD_BACKTAB = 2328;

        // Insert a new line, may use a CRLF, CR or LF depending on EOL mode.
        public const int wxSTC_CMD_NEWLINE = 2329;

        // Insert a Form Feed character.
        public const int wxSTC_CMD_FORMFEED = 2330;

        // Move caret to before first visible character on line.
        // If already there move to first character on line.
        public const int wxSTC_CMD_VCHOME = 2331;

        // Like VCHome but extending selection to new caret position.
        public const int wxSTC_CMD_VCHOMEEXTEND = 2332;

        // Magnify the displayed text by increasing the sizes by 1 point.
        public const int wxSTC_CMD_ZOOMIN = 2333;

        // Make the displayed text smaller by decreasing the sizes by 1 point.
        public const int wxSTC_CMD_ZOOMOUT = 2334;

        // Delete the word to the left of the caret.
        public const int wxSTC_CMD_DELWORDLEFT = 2335;

        // Delete the word to the right of the caret.
        public const int wxSTC_CMD_DELWORDRIGHT = 2336;

        // Cut the line containing the caret.
        public const int wxSTC_CMD_LINECUT = 2337;

        // Delete the line containing the caret.
        public const int wxSTC_CMD_LINEDELETE = 2338;

        // Switch the current line with the previous.
        public const int wxSTC_CMD_LINETRANSPOSE = 2339;

        // Duplicate the current line.
        public const int wxSTC_CMD_LINEDUPLICATE = 2404;

        // Transform the selection to lower case.
        public const int wxSTC_CMD_LOWERCASE = 2340;

        // Transform the selection to upper case.
        public const int wxSTC_CMD_UPPERCASE = 2341;

        // Scroll the document down, keeping the caret visible.
        public const int wxSTC_CMD_LINESCROLLDOWN = 2342;

        // Scroll the document up, keeping the caret visible.
        public const int wxSTC_CMD_LINESCROLLUP = 2343;

        // Delete the selection or if no selection, the character before the caret.
        // Will not delete the character before at the start of a line.
        public const int wxSTC_CMD_DELETEBACKNOTLINE = 2344;

        // Move caret to first position on display line.
        public const int wxSTC_CMD_HOMEDISPLAY = 2345;

        // Move caret to first position on display line extending selection to
        // new caret position.
        public const int wxSTC_CMD_HOMEDISPLAYEXTEND = 2346;

        // Move caret to last position on display line.
        public const int wxSTC_CMD_LINEENDDISPLAY = 2347;

        // Move caret to last position on display line extending selection to new
        // caret position.
        public const int wxSTC_CMD_LINEENDDISPLAYEXTEND = 2348;

        // These are like their namesakes Home(Extend)?, LineEnd(Extend)?, VCHome(Extend)?
        // except they behave differently when word-wrap is enabled:
        // They go first to the start / end of the display line, like (Home|LineEnd)Display
        // The difference is that, the cursor is already at the point, it goes on to the start
        // or end of the document line, as appropriate for (Home|LineEnd|VCHome)Extend.
        public const int wxSTC_CMD_HOMEWRAP = 2349;
        public const int wxSTC_CMD_HOMEWRAPEXTEND = 2450;
        public const int wxSTC_CMD_LINEENDWRAP = 2451;
        public const int wxSTC_CMD_LINEENDWRAPEXTEND = 2452;
        public const int wxSTC_CMD_VCHOMEWRAP = 2453;
        public const int wxSTC_CMD_VCHOMEWRAPEXTEND = 2454;

        // Move to the previous change in capitalisation.
        public const int wxSTC_CMD_WORDPARTLEFT = 2390;

        // Move to the previous change in capitalisation extending selection
        // to new caret position.
        public const int wxSTC_CMD_WORDPARTLEFTEXTEND = 2391;

        // Move to the change next in capitalisation.
        public const int wxSTC_CMD_WORDPARTRIGHT = 2392;

        // Move to the next change in capitalisation extending selection
        // to new caret position.
        public const int wxSTC_CMD_WORDPARTRIGHTEXTEND = 2393;

        // Delete back from the current position to the start of the line.
        public const int wxSTC_CMD_DELLINELEFT = 2395;

        // Delete forwards from the current position to the end of the line.
        public const int wxSTC_CMD_DELLINERIGHT = 2396;

        // Move caret between paragraphs (delimited by empty lines)
        public const int wxSTC_CMD_PARADOWN = 2413;
        public const int wxSTC_CMD_PARADOWNEXTEND = 2414;
        public const int wxSTC_CMD_PARAUP = 2415;
        public const int wxSTC_CMD_PARAUPEXTEND = 2416;

        //-----------------------------------------------------------------------------

        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AddText(IntPtr self, string text);
        //[DllImport("wx-c")] static extern void   wxStyledTextCtrl_AddStyledText(IntPtr self, IntPtr data);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_InsertText(IntPtr self, int pos, string text);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ClearAll(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ClearDocumentStyle(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLength(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetCharAt(IntPtr self, int pos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetCurrentPos(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetAnchor(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetStyleAt(IntPtr self, int pos);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_Redo(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetUndoCollection(IntPtr self, bool collectUndo);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SelectAll(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSavePoint(IntPtr self);
        //[DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetStyledText(IntPtr self, int startPos, int endPos);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_CanRedo(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_MarkerLineFromHandle(IntPtr self, int handle);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MarkerDeleteHandle(IntPtr self, int handle);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetUndoCollection(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetViewWhiteSpace(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetViewWhiteSpace(IntPtr self, int viewWS);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_PositionFromPoint(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_PositionFromPointClose(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_GotoLine(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_GotoPos(IntPtr self, int pos);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetAnchor(IntPtr self, int posAnchor);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetCurLine(IntPtr self, ref int linePos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetEndStyled(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ConvertEOLs(IntPtr self, int eolMode);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetEOLMode(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetEOLMode(IntPtr self, int eolMode);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StartStyling(IntPtr self, int pos, int mask);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetStyling(IntPtr self, int length, int style);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetBufferedDraw(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetBufferedDraw(IntPtr self, bool buffered);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetTabWidth(IntPtr self, int tabWidth);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetTabWidth(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetCodePage(IntPtr self, int codePage);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MarkerDefine(IntPtr self, int markerNumber, int markerSymbol, IntPtr foreground, IntPtr background);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MarkerSetForeground(IntPtr self, int markerNumber, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MarkerSetBackground(IntPtr self, int markerNumber, IntPtr back);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_MarkerAdd(IntPtr self, int line, int markerNumber);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MarkerDelete(IntPtr self, int line, int markerNumber);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MarkerDeleteAll(IntPtr self, int markerNumber);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_MarkerGet(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_MarkerNext(IntPtr self, int lineStart, int markerMask);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_MarkerPrevious(IntPtr self, int lineStart, int markerMask);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MarkerDefineBitmap(IntPtr self, int markerNumber, IntPtr bmp);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMarginType(IntPtr self, int margin, int marginType);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetMarginType(IntPtr self, int margin);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMarginWidth(IntPtr self, int margin, int pixelWidth);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetMarginWidth(IntPtr self, int margin);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMarginMask(IntPtr self, int margin, int mask);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetMarginMask(IntPtr self, int margin);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMarginSensitive(IntPtr self, int margin, bool sensitive);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetMarginSensitive(IntPtr self, int margin);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleClearAll(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetForeground(IntPtr self, int style, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetBackground(IntPtr self, int style, IntPtr back);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetBold(IntPtr self, int style, bool bold);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetItalic(IntPtr self, int style, bool italic);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetSize(IntPtr self, int style, int sizePoints);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetFaceName(IntPtr self, int style, string fontName);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetEOLFilled(IntPtr self, int style, bool filled);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleResetDefault(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetUnderline(IntPtr self, int style, bool underline);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetCase(IntPtr self, int style, int caseForce);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetCharacterSet(IntPtr self, int style, int characterSet);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetHotSpot(IntPtr self, int style, bool hotspot);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSelForeground(IntPtr self, bool useSetting, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSelBackground(IntPtr self, bool useSetting, IntPtr back);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetCaretForeground(IntPtr self, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CmdKeyAssign(IntPtr self, int key, int modifiers, int cmd);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CmdKeyClear(IntPtr self, int key, int modifiers);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CmdKeyClearAll(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetStyleBytes(IntPtr self, int length, byte[] styleBytes);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetVisible(IntPtr self, int style, bool visible);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetCaretPeriod(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetCaretPeriod(IntPtr self, int periodMilliseconds);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetWordChars(IntPtr self, string characters);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_BeginUndoAction(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_EndUndoAction(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_IndicatorSetStyle(IntPtr self, int indic, int style);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_IndicatorGetStyle(IntPtr self, int indic);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_IndicatorSetForeground(IntPtr self, int indic, IntPtr fore);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_IndicatorGetForeground(IntPtr self, int indic);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetWhitespaceForeground(IntPtr self, bool useSetting, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetWhitespaceBackground(IntPtr self, bool useSetting, IntPtr back);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetStyleBits(IntPtr self, int bits);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetStyleBits(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetLineState(IntPtr self, int line, int state);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLineState(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetMaxLineState(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetCaretLineVisible(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetCaretLineVisible(IntPtr self, bool show);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetCaretLineBack(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetCaretLineBack(IntPtr self, IntPtr back);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetChangeable(IntPtr self, int style, bool changeable);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompShow(IntPtr self, int lenEntered, string itemList);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompCancel(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_AutoCompActive(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_AutoCompPosStart(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompComplete(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompStops(IntPtr self, string characterSet);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetSeparator(IntPtr self, int separatorCharacter);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_AutoCompGetSeparator(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSelect(IntPtr self, string text);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetCancelAtStart(IntPtr self, bool cancel);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_AutoCompGetCancelAtStart(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetFillUps(IntPtr self, string characterSet);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetChooseSingle(IntPtr self, bool chooseSingle);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_AutoCompGetChooseSingle(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetIgnoreCase(IntPtr self, bool ignoreCase);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_AutoCompGetIgnoreCase(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_UserListShow(IntPtr self, int listType, string itemList);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetAutoHide(IntPtr self, bool autoHide);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_AutoCompGetAutoHide(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetDropRestOfWord(IntPtr self, bool dropRestOfWord);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_AutoCompGetDropRestOfWord(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_RegisterImage(IntPtr self, int type, IntPtr bmp);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ClearRegisteredImages(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_AutoCompGetTypeSeparator(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AutoCompSetTypeSeparator(IntPtr self, int separatorCharacter);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetIndent(IntPtr self, int indentSize);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetIndent(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetUseTabs(IntPtr self, bool useTabs);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetUseTabs(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetLineIndentation(IntPtr self, int line, int indentSize);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLineIndentation(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLineIndentPosition(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetColumn(IntPtr self, int pos);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetUseHorizontalScrollBar(IntPtr self, bool show);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetUseHorizontalScrollBar(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetIndentationGuides(IntPtr self, bool show);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetIndentationGuides(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetHighlightGuide(IntPtr self, int column);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetHighlightGuide(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLineEndPosition(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetCodePage(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetCaretForeground(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetReadOnly(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetCurrentPos(IntPtr self, int pos);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSelectionStart(IntPtr self, int pos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetSelectionStart(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSelectionEnd(IntPtr self, int pos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetSelectionEnd(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetPrintMagnification(IntPtr self, int magnification);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetPrintMagnification(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetPrintColourMode(IntPtr self, int mode);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetPrintColourMode(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_FindText(IntPtr self, int minPos, int maxPos, string text, int flags);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_FormatRange(IntPtr self, bool doDraw, int startPos, int endPos, IntPtr draw, IntPtr target, ref Rectangle renderRect, ref Rectangle pageRect);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetFirstVisibleLine(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetLine(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLineCount(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMarginLeft(IntPtr self, int pixelWidth);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetMarginLeft(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMarginRight(IntPtr self, int pixelWidth);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetMarginRight(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetModify(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSelection(IntPtr self, int start, int end);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetSelectedText(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetTextRange(IntPtr self, int startPos, int endPos);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_HideSelection(IntPtr self, bool normal);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_LineFromPosition(IntPtr self, int pos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_PositionFromLine(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_LineScroll(IntPtr self, int columns, int lines);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_EnsureCaretVisible(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ReplaceSelection(IntPtr self, string text);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetReadOnly(IntPtr self, bool readOnly);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_CanPaste(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_CanUndo(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_EmptyUndoBuffer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_Undo(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_Cut(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_Copy(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_Paste(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_Clear(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetText(IntPtr self, string text);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetText(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetTextLength(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetOvertype(IntPtr self, bool overtype);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetOvertype(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetCaretWidth(IntPtr self, int pixelWidth);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetCaretWidth(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetTargetStart(IntPtr self, int pos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetTargetStart(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetTargetEnd(IntPtr self, int pos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetTargetEnd(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_ReplaceTarget(IntPtr self, string text);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_ReplaceTargetRE(IntPtr self, string text);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_SearchInTarget(IntPtr self, string text);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSearchFlags(IntPtr self, int flags);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetSearchFlags(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CallTipShow(IntPtr self, int pos, string definition);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CallTipCancel(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_CallTipActive(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_CallTipPosAtStart(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CallTipSetHighlight(IntPtr self, int start, int end);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CallTipSetBackground(IntPtr self, IntPtr back);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CallTipSetForeground(IntPtr self, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CallTipSetForegroundHighlight(IntPtr self, IntPtr fore);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_VisibleFromDocLine(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_DocLineFromVisible(IntPtr self, int lineDisplay);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetFoldLevel(IntPtr self, int line, int level);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetFoldLevel(IntPtr self, int line);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLastChild(IntPtr self, int line, int level);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetFoldParent(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ShowLines(IntPtr self, int lineStart, int lineEnd);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_HideLines(IntPtr self, int lineStart, int lineEnd);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetLineVisible(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetFoldExpanded(IntPtr self, int line, bool expanded);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetFoldExpanded(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ToggleFold(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_EnsureVisible(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetFoldFlags(IntPtr self, int flags);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_EnsureVisibleEnforcePolicy(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetTabIndents(IntPtr self, bool tabIndents);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetTabIndents(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetBackSpaceUnIndents(IntPtr self, bool bsUnIndents);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetBackSpaceUnIndents(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMouseDwellTime(IntPtr self, int periodMilliseconds);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetMouseDwellTime(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_WordStartPosition(IntPtr self, int pos, bool onlyWordCharacters);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_WordEndPosition(IntPtr self, int pos, bool onlyWordCharacters);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetWrapMode(IntPtr self, int mode);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetWrapMode(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetLayoutCache(IntPtr self, int mode);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLayoutCache(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetScrollWidth(IntPtr self, int pixelWidth);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetScrollWidth(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_TextWidth(IntPtr self, int style, string text);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetEndAtLastLine(IntPtr self, bool endAtLastLine);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetEndAtLastLine(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_TextHeight(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetUseVerticalScrollBar(IntPtr self, bool show);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetUseVerticalScrollBar(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AppendText(IntPtr self, string text);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetTwoPhaseDraw(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetTwoPhaseDraw(IntPtr self, bool twoPhase);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_TargetFromSelection(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_LinesJoin(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_LinesSplit(IntPtr self, int pixelWidth);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetFoldMarginColour(IntPtr self, bool useSetting, IntPtr back);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetFoldMarginHiColour(IntPtr self, bool useSetting, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_LineDuplicate(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_HomeDisplay(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_HomeDisplayExtend(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_LineEndDisplay(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_LineEndDisplayExtend(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_MoveCaretInsideView(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_LineLength(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_BraceHighlight(IntPtr self, int pos1, int pos2);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_BraceBadLight(IntPtr self, int pos);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_BraceMatch(IntPtr self, int pos);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetViewEOL(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetViewEOL(IntPtr self, bool visible);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetDocPointer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetDocPointer(IntPtr self, IntPtr docPointer);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetModEventMask(IntPtr self, int mask);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetEdgeColumn(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetEdgeColumn(IntPtr self, int column);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetEdgeMode(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetEdgeMode(IntPtr self, int mode);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextCtrl_GetEdgeColour(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetEdgeColour(IntPtr self, IntPtr edgeColour);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SearchAnchor(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_SearchNext(IntPtr self, int flags, string text);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_SearchPrev(IntPtr self, int flags, string text);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_LinesOnScreen(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_UsePopUp(IntPtr self, bool allowPopUp);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_SelectionIsRectangle(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetZoom(IntPtr self, int zoom);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetZoom(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CreateDocument(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_AddRefDocument(IntPtr self, IntPtr docPointer);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ReleaseDocument(IntPtr self, IntPtr docPointer);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetModEventMask(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSTCFocus(IntPtr self, bool focus);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetSTCFocus(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetStatus(IntPtr self, int statusCode);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetStatus(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMouseDownCaptures(IntPtr self, bool captures);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetMouseDownCaptures(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetSTCCursor(IntPtr self, int cursorType);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetSTCCursor(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetControlCharSymbol(IntPtr self, int symbol);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetControlCharSymbol(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_WordPartLeft(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_WordPartLeftExtend(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_WordPartRight(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_WordPartRightExtend(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetVisiblePolicy(IntPtr self, int visiblePolicy, int visibleSlop);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_DelLineLeft(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_DelLineRight(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetXOffset(IntPtr self, int newOffset);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetXOffset(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ChooseCaretX(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetXCaretPolicy(IntPtr self, int caretPolicy, int caretSlop);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetYCaretPolicy(IntPtr self, int caretPolicy, int caretSlop);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetPrintWrapMode(IntPtr self, int mode);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetPrintWrapMode(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetHotspotActiveForeground(IntPtr self, bool useSetting, IntPtr fore);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetHotspotActiveBackground(IntPtr self, bool useSetting, IntPtr back);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetHotspotActiveUnderline(IntPtr self, bool underline);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StartRecord(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StopRecord(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetLexer(IntPtr self, int lexer);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetLexer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_Colourise(IntPtr self, int start, int end);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetProperty(IntPtr self, string key, string value);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetKeyWords(IntPtr self, int keywordSet, string keyWords);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetLexerLanguage(IntPtr self, string language);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_GetCurrentLine(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetSpec(IntPtr self, int styleNum, string spec);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetFont(IntPtr self, int styleNum, IntPtr font);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_StyleSetFontAttr(IntPtr self, int styleNum, int size, string faceName, bool bold, bool italic, bool underline);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_CmdKeyExecute(IntPtr self, int cmd);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetMargins(IntPtr self, int left, int right);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_GetSelection(IntPtr self, ref int startPos, ref int endPos);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_PointFromPosition(IntPtr self, int pos, ref Point pt);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ScrollToLine(IntPtr self, int line);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_ScrollToColumn(IntPtr self, int column);
        [DllImport("wx-c")] static extern int    wxStyledTextCtrl_SendMsg(IntPtr self, int msg, int wp, int lp);
        //[DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetVScrollBar(IntPtr self, IntPtr bar);
        //[DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetHScrollBar(IntPtr self, IntPtr bar);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_GetLastKeydownProcessed(IntPtr self);
        [DllImport("wx-c")] static extern void   wxStyledTextCtrl_SetLastKeydownProcessed(IntPtr self, bool val);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_SaveFile(IntPtr self, string filename);
        [DllImport("wx-c")] static extern bool   wxStyledTextCtrl_LoadFile(IntPtr self, string filename);

        //-----------------------------------------------------------------------------

        static StyledTextCtrl()
        {
            Event.AddEventType(wxEVT_STC_CHANGE,               typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_STYLENEEDED,          typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_CHARADDED,            typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_SAVEPOINTREACHED,     typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_SAVEPOINTLEFT,        typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_ROMODIFYATTEMPT,      typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_KEY,                  typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_DOUBLECLICK,          typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_UPDATEUI,             typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_MODIFIED,             typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_MACRORECORD,          typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_MARGINCLICK,          typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_NEEDSHOWN,            typeof(StyledTextEvent));
            //Event.AddEventType(wxEVT_STC_POSCHANGED,           typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_PAINTED,              typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_USERLISTSELECTION,    typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_URIDROPPED,           typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_DWELLSTART,           typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_DWELLEND,             typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_START_DRAG,           typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_DRAG_OVER,            typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_DO_DROP,              typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_ZOOM,                 typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_HOTSPOT_CLICK,        typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_HOTSPOT_DCLICK,       typeof(StyledTextEvent));
            Event.AddEventType(wxEVT_STC_CALLTIP_CLICK,        typeof(StyledTextEvent));
        }

        //-----------------------------------------------------------------------------

        public StyledTextCtrl(IntPtr wxObject) 
            : base (wxObject) { }

        public  StyledTextCtrl(Window parent)
            : this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null) { }

        public  StyledTextCtrl(Window parent, int id)
            : this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null) { }

        public  StyledTextCtrl(Window parent, int id, Point pos)
            : this(parent, id, pos, wxDefaultSize, 0, null) { }

        public  StyledTextCtrl(Window parent, int id, Point pos, Size size)
            : this(parent, id, pos, size, 0, null) { }

        public  StyledTextCtrl(Window parent, int id, Point pos, Size size, int style)
            : this(parent, id, pos, size, style, null) { }

        public  StyledTextCtrl(Window parent, int id, Point pos, Size size, int style, string name)
            : this(wxStyledTextCtrl_ctor(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name)) { }
	    
	//---------------------------------------------------------------------
	// ctors with self created id
	    
        public  StyledTextCtrl(Window parent, Point pos)
            : this(parent, Window.UniqueID, pos, wxDefaultSize, 0, null) { }

        public  StyledTextCtrl(Window parent, Point pos, Size size)
            : this(parent, Window.UniqueID, pos, size, 0, null) { }

        public  StyledTextCtrl(Window parent, Point pos, Size size, int style)
            : this(parent, Window.UniqueID, pos, size, style, null) { }

        public  StyledTextCtrl(Window parent, Point pos, Size size, int style, string name)
	    : this(parent, Window.UniqueID, pos, size, style, name) {}

        //-----------------------------------------------------------------------------

        public void AddText(string text)
        {
            wxStyledTextCtrl_AddText(wxObject, text);
        }

        /*public void AddStyledText(MemoryBuffer data)
        {
            wxStyledTextCtrl_AddStyledText(wxObject, Object.SafePtr(data));
        }*/

        public void InsertText(int pos, string text)
        {
            wxStyledTextCtrl_InsertText(wxObject, pos, text);
        }

        //-----------------------------------------------------------------------------

        public void ClearAll()
        {
            wxStyledTextCtrl_ClearAll(wxObject);
        }

        public void ClearDocumentStyle()
        {
            wxStyledTextCtrl_ClearDocumentStyle(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int Length
        {
            get { return wxStyledTextCtrl_GetLength(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int GetCharAt(int pos)
        {
            return wxStyledTextCtrl_GetCharAt(wxObject, pos);
        }

        //-----------------------------------------------------------------------------

        public int CurrentPos
        {
            get { return wxStyledTextCtrl_GetCurrentPos(wxObject); }
            set { wxStyledTextCtrl_SetCurrentPos(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Anchor
        {
            get { return wxStyledTextCtrl_GetAnchor(wxObject); }
            set { wxStyledTextCtrl_SetAnchor(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int GetStyleAt(int pos)
        {
            return wxStyledTextCtrl_GetStyleAt(wxObject, pos);
        }

        //-----------------------------------------------------------------------------

        public void Redo()
        {
            wxStyledTextCtrl_Redo(wxObject);
        }

        //-----------------------------------------------------------------------------

        public bool UndoCollection
        {
            get { return wxStyledTextCtrl_GetUndoCollection(wxObject); }
            set { wxStyledTextCtrl_SetUndoCollection(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void SelectAll()
        {
            wxStyledTextCtrl_SelectAll(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void SetSavePoint()
        {
            wxStyledTextCtrl_SetSavePoint(wxObject);
        }

        //-----------------------------------------------------------------------------

        /*public MemoryBuffer GetStyledText(int startPos, int endPos)
        {
            return wxStyledTextCtrl_GetStyledText(wxObject, startPos, endPos);
        }*/

        //-----------------------------------------------------------------------------

        public bool CanRedo
        {
            get { return wxStyledTextCtrl_CanRedo(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int MarkerLineFromHandle(int handle)
        {
            return wxStyledTextCtrl_MarkerLineFromHandle(wxObject, handle);
        }

        public void MarkerDeleteHandle(int handle)
        {
            wxStyledTextCtrl_MarkerDeleteHandle(wxObject, handle);
        }

        //-----------------------------------------------------------------------------

        public int ViewWhiteSpace
        {
            get { return wxStyledTextCtrl_GetViewWhiteSpace(wxObject); }
            set { wxStyledTextCtrl_SetViewWhiteSpace(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int PositionFromPoint(Point pt)
        {
            return wxStyledTextCtrl_PositionFromPoint(wxObject, ref pt);
        }

        public int PositionFromPointClose(int x, int y)
        {
            return wxStyledTextCtrl_PositionFromPointClose(wxObject, x, y);
        }

        //-----------------------------------------------------------------------------

        public void GotoLine(int line)
        {
            wxStyledTextCtrl_GotoLine(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public void GotoPos(int pos)
        {
            wxStyledTextCtrl_GotoPos(wxObject, pos);
        }

        //-----------------------------------------------------------------------------

        public string CurLine
        {
            get {
                int i;
                return GetCurLine(out i);
            }
        }

        public string GetCurLine(out int linePos)
        {
            linePos = new int();
            return new wxString(wxStyledTextCtrl_GetCurLine(wxObject, ref linePos), true);
        }

        //-----------------------------------------------------------------------------

        public int EndStyled
        {
            get { return wxStyledTextCtrl_GetEndStyled(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void ConvertEOLs(int eolMode)
        {
            wxStyledTextCtrl_ConvertEOLs(wxObject, eolMode);
        }

        //-----------------------------------------------------------------------------

        public int EOLMode
        {
            get { return wxStyledTextCtrl_GetEOLMode(wxObject); }
            set { wxStyledTextCtrl_SetEOLMode(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void StartStyling(int pos, int mask)
        {
            wxStyledTextCtrl_StartStyling(wxObject, pos, mask);
        }

        //-----------------------------------------------------------------------------

        public void SetStyling(int length, int style)
        {
            wxStyledTextCtrl_SetStyling(wxObject, length, style);
        }

        //-----------------------------------------------------------------------------

        public bool BufferedDraw
        {
            get { return wxStyledTextCtrl_GetBufferedDraw(wxObject); }
            set { wxStyledTextCtrl_SetBufferedDraw(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int TabWidth
        {
            get { return wxStyledTextCtrl_GetTabWidth(wxObject); }
            set { wxStyledTextCtrl_SetTabWidth(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int CodePage
        {
            get { return wxStyledTextCtrl_GetCodePage(wxObject); } 
            set { wxStyledTextCtrl_SetCodePage(wxObject, value); } 
        }

        //-----------------------------------------------------------------------------

        public void MarkerDefine(int markerNumber, int markerSymbol, Colour foreground, Colour background)
        {
            wxStyledTextCtrl_MarkerDefine(wxObject, markerNumber, markerSymbol, Object.SafePtr(foreground), Object.SafePtr(background));
        }

        public void MarkerSetForeground(int markerNumber, Colour fore)
        {
            wxStyledTextCtrl_MarkerSetForeground(wxObject, markerNumber, Object.SafePtr(fore));
        }

        public void MarkerSetBackground(int markerNumber, Colour back)
        {
            wxStyledTextCtrl_MarkerSetBackground(wxObject, markerNumber, Object.SafePtr(back));
        }

        public int MarkerAdd(int line, int markerNumber)
        {
            return wxStyledTextCtrl_MarkerAdd(wxObject, line, markerNumber);
        }

        public void MarkerDelete(int line, int markerNumber)
        {
            wxStyledTextCtrl_MarkerDelete(wxObject, line, markerNumber);
        }

        public void MarkerDeleteAll(int markerNumber)
        {
            wxStyledTextCtrl_MarkerDeleteAll(wxObject, markerNumber);
        }

        public int MarkerGet(int line)
        {
            return wxStyledTextCtrl_MarkerGet(wxObject, line);
        }

        public int MarkerNext(int lineStart, int markerMask)
        {
            return wxStyledTextCtrl_MarkerNext(wxObject, lineStart, markerMask);
        }

        public int MarkerPrevious(int lineStart, int markerMask)
        {
            return wxStyledTextCtrl_MarkerPrevious(wxObject, lineStart, markerMask);
        }

        public void MarkerDefineBitmap(int markerNumber, Bitmap bmp)
        {
            wxStyledTextCtrl_MarkerDefineBitmap(wxObject, markerNumber, Object.SafePtr(bmp));
        }

        //-----------------------------------------------------------------------------

        public void SetMarginType(int margin, int marginType)
        {
            wxStyledTextCtrl_SetMarginType(wxObject, margin, marginType);
        }

        public int GetMarginType(int margin)
        {
            return wxStyledTextCtrl_GetMarginType(wxObject, margin);
        }

        //-----------------------------------------------------------------------------

        public void SetMarginWidth(int margin, int pixelWidth)
        {
            wxStyledTextCtrl_SetMarginWidth(wxObject, margin, pixelWidth);
        }

        public int GetMarginWidth(int margin)
        {
            return wxStyledTextCtrl_GetMarginWidth(wxObject, margin);
        }

        //-----------------------------------------------------------------------------

        public void SetMarginMask(int margin, int mask)
        {
            wxStyledTextCtrl_SetMarginMask(wxObject, margin, mask);
        }

        public int GetMarginMask(int margin)
        {
            return wxStyledTextCtrl_GetMarginMask(wxObject, margin);
        }

        //-----------------------------------------------------------------------------

        public void SetMarginSensitive(int margin, bool sensitive)
        {
            wxStyledTextCtrl_SetMarginSensitive(wxObject, margin, sensitive);
        }

        public bool GetMarginSensitive(int margin)
        {
            return wxStyledTextCtrl_GetMarginSensitive(wxObject, margin);
        }

        //-----------------------------------------------------------------------------

        public void StyleClearAll()
        {
            wxStyledTextCtrl_StyleClearAll(wxObject);
        }

        public void StyleSetForeground(int style, Colour fore)
        {
            wxStyledTextCtrl_StyleSetForeground(wxObject, style, Object.SafePtr(fore));
        }

        public void StyleSetBackground(int style, Colour back)
        {
            wxStyledTextCtrl_StyleSetBackground(wxObject, style, Object.SafePtr(back));
        }

        public void StyleSetBold(int style, bool bold)
        {
            wxStyledTextCtrl_StyleSetBold(wxObject, style, bold);
        }

        public void StyleSetItalic(int style, bool italic)
        {
            wxStyledTextCtrl_StyleSetItalic(wxObject, style, italic);
        }

        public void StyleSetSize(int style, int sizePoints)
        {
            wxStyledTextCtrl_StyleSetSize(wxObject, style, sizePoints);
        }

        public void StyleSetFaceName(int style, string fontName)
        {
            wxStyledTextCtrl_StyleSetFaceName(wxObject, style, fontName);
        }

        public void StyleSetEOLFilled(int style, bool filled)
        {
            wxStyledTextCtrl_StyleSetEOLFilled(wxObject, style, filled);
        }

        public void StyleResetDefault()
        {
            wxStyledTextCtrl_StyleResetDefault(wxObject);
        }

        public void StyleSetUnderline(int style, bool underline)
        {
            wxStyledTextCtrl_StyleSetUnderline(wxObject, style, underline);
        }

        public void StyleSetCase(int style, int caseForce)
        {
            wxStyledTextCtrl_StyleSetCase(wxObject, style, caseForce);
        }

        public void StyleSetCharacterSet(int style, int characterSet)
        {
            wxStyledTextCtrl_StyleSetCharacterSet(wxObject, style, characterSet);
        }

        public void StyleSetHotSpot(int style, bool hotspot)
        {
            wxStyledTextCtrl_StyleSetHotSpot(wxObject, style, hotspot);
        }

        public void StyleSetVisible(int style, bool visible)
        {
            wxStyledTextCtrl_StyleSetVisible(wxObject, style, visible);
        }

        public void StyleSetChangeable(int style, bool changeable)
        {
            wxStyledTextCtrl_StyleSetChangeable(wxObject, style, changeable);
        }

        //-----------------------------------------------------------------------------

        public void SetSelForeground(bool useSetting, Colour fore)
        {
            wxStyledTextCtrl_SetSelForeground(wxObject, useSetting, Object.SafePtr(fore));
        }

        public void SetSelBackground(bool useSetting, Colour back)
        {
            wxStyledTextCtrl_SetSelBackground(wxObject, useSetting, Object.SafePtr(back));
        }

        //-----------------------------------------------------------------------------

        public Colour CaretForeground
        {
            get { return new Colour(wxStyledTextCtrl_GetCaretForeground(wxObject), true); }
            set { wxStyledTextCtrl_SetCaretForeground(wxObject, Object.SafePtr(value)); } 
        }

        //-----------------------------------------------------------------------------

        public void CmdKeyAssign(int key, int modifiers, int cmd)
        {
            wxStyledTextCtrl_CmdKeyAssign(wxObject, key, modifiers, cmd);
        }

        public void CmdKeyClear(int key, int modifiers)
        {
            wxStyledTextCtrl_CmdKeyClear(wxObject, key, modifiers);
        }

        public void CmdKeyClearAll()
        {
            wxStyledTextCtrl_CmdKeyClearAll(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void SetStyleBytes(int length, byte[] styleBytes)
        {
            wxStyledTextCtrl_SetStyleBytes(wxObject, length, styleBytes);
        }

        //-----------------------------------------------------------------------------

        public int CaretPeriod
        {
            get { return wxStyledTextCtrl_GetCaretPeriod(wxObject); }
            set { wxStyledTextCtrl_SetCaretPeriod(wxObject, value); } 
        }

        //-----------------------------------------------------------------------------

        public void SetWordChars(string characters)
        {
            wxStyledTextCtrl_SetWordChars(wxObject, characters);
        }

        //-----------------------------------------------------------------------------

        public void BeginUndoAction()
        {
            wxStyledTextCtrl_BeginUndoAction(wxObject);
        }

        public void EndUndoAction()
        {
            wxStyledTextCtrl_EndUndoAction(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void IndicatorSetStyle(int indic, int style)
        {
            wxStyledTextCtrl_IndicatorSetStyle(wxObject, indic, style);
        }

        public int IndicatorGetStyle(int indic)
        {
            return wxStyledTextCtrl_IndicatorGetStyle(wxObject, indic);
        }

        public void IndicatorSetForeground(int indic, Colour fore)
        {
            wxStyledTextCtrl_IndicatorSetForeground(wxObject, indic, Object.SafePtr(fore));
        }

        public Colour IndicatorGetForeground(int indic)
        {
            return new Colour(wxStyledTextCtrl_IndicatorGetForeground(wxObject, indic), true);
        }

        //-----------------------------------------------------------------------------

        public void SetWhitespaceForeground(bool useSetting, Colour fore)
        {
            wxStyledTextCtrl_SetWhitespaceForeground(wxObject, useSetting, Object.SafePtr(fore));
        }

        public void SetWhitespaceBackground(bool useSetting, Colour back)
        {
            wxStyledTextCtrl_SetWhitespaceBackground(wxObject, useSetting, Object.SafePtr(back));
        }

        //-----------------------------------------------------------------------------

        public int StyleBits
        {
            get { return wxStyledTextCtrl_GetStyleBits(wxObject); }
            set { wxStyledTextCtrl_SetStyleBits(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void SetLineState(int line, int state)
        {
            wxStyledTextCtrl_SetLineState(wxObject, line, state);
        }

        public int GetLineState(int line)
        {
            return wxStyledTextCtrl_GetLineState(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public int MaxLineState
        {
            get { return wxStyledTextCtrl_GetMaxLineState(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool CaretLineVisible
        {
            get { return wxStyledTextCtrl_GetCaretLineVisible(wxObject); }
            set { wxStyledTextCtrl_SetCaretLineVisible(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public Colour CaretLineBack
        {
            get { return new Colour(wxStyledTextCtrl_GetCaretLineBack(wxObject), true); } 
            set { wxStyledTextCtrl_SetCaretLineBack(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public void AutoCompShow(int lenEntered, string itemList)
        {
            wxStyledTextCtrl_AutoCompShow(wxObject, lenEntered, itemList);
        }

        public void AutoCompCancel()
        {
            wxStyledTextCtrl_AutoCompCancel(wxObject);
        }

        public bool AutoCompActive
        {
            get { return wxStyledTextCtrl_AutoCompActive(wxObject); }
        }

        public int AutoCompPosStart
        {
            get { return wxStyledTextCtrl_AutoCompPosStart(wxObject); } 
        }

        public void AutoCompComplete()
        {
            wxStyledTextCtrl_AutoCompComplete(wxObject);
        }

        public string AutoCompStops
        {
            set { wxStyledTextCtrl_AutoCompStops(wxObject, value); }
        }

        public char AutoCompSeparator
        {
            get { return (char)wxStyledTextCtrl_AutoCompGetSeparator(wxObject); }
            set { wxStyledTextCtrl_AutoCompSetSeparator(wxObject, (int)value); } 
        }

        public void AutoCompSelect(string text)
        {
            wxStyledTextCtrl_AutoCompSelect(wxObject, text);
        }

        public bool AutoCompCancelAtStart
        {
            get { return wxStyledTextCtrl_AutoCompGetCancelAtStart(wxObject); }
            set { wxStyledTextCtrl_AutoCompSetCancelAtStart(wxObject, value); } 
        }

        public string AutoCompFillUps
        {
            set { wxStyledTextCtrl_AutoCompSetFillUps(wxObject, value); }
        }

        public bool AutoCompChooseSingle
        {
            get { return wxStyledTextCtrl_AutoCompGetChooseSingle(wxObject); }
            set { wxStyledTextCtrl_AutoCompSetChooseSingle(wxObject, value); }
        }

        public bool AutoCompIgnoreCase
        {
            get { return wxStyledTextCtrl_AutoCompGetIgnoreCase(wxObject); }
            set { wxStyledTextCtrl_AutoCompSetIgnoreCase(wxObject, value); } 
        }

        public bool AutoCompAutoHide
        {
            set { wxStyledTextCtrl_AutoCompSetAutoHide(wxObject, value); }
            get { return wxStyledTextCtrl_AutoCompGetAutoHide(wxObject); }
        }

        public bool AutoCompDropRestOfWord
        {
            set { wxStyledTextCtrl_AutoCompSetDropRestOfWord(wxObject, value); }
            get { return wxStyledTextCtrl_AutoCompGetDropRestOfWord(wxObject); } 
        }

        public int AutoCompTypeSeparator
        {
            get { return wxStyledTextCtrl_AutoCompGetTypeSeparator(wxObject); }
            set { wxStyledTextCtrl_AutoCompSetTypeSeparator(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void UserListShow(int listType, string itemList)
        {
            wxStyledTextCtrl_UserListShow(wxObject, listType, itemList);
        }

        //-----------------------------------------------------------------------------

        public void RegisterImage(int type, Bitmap bmp)
        {
            wxStyledTextCtrl_RegisterImage(wxObject, type, Object.SafePtr(bmp));
        }

        public void ClearRegisteredImages()
        {
            wxStyledTextCtrl_ClearRegisteredImages(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int Indent
        {
            get { return wxStyledTextCtrl_GetIndent(wxObject); }
            set { wxStyledTextCtrl_SetIndent(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool UseTabs
        {
            get { return wxStyledTextCtrl_GetUseTabs(wxObject); }
            set { wxStyledTextCtrl_SetUseTabs(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void SetLineIndentation(int line, int indentSize)
        {
            wxStyledTextCtrl_SetLineIndentation(wxObject, line, indentSize);
        }

        public int GetLineIndentation(int line)
        {
            return wxStyledTextCtrl_GetLineIndentation(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public int GetLineIndentPosition(int line)
        {
            return wxStyledTextCtrl_GetLineIndentPosition(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public int GetColumn(int pos)
        {
            return wxStyledTextCtrl_GetColumn(wxObject, pos);
        }

        //-----------------------------------------------------------------------------

        public bool UseHorizontalScrollBar
        {
            set { wxStyledTextCtrl_SetUseHorizontalScrollBar(wxObject, value); }
            get { return wxStyledTextCtrl_GetUseHorizontalScrollBar(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool IndentationGuides
        {
            set { wxStyledTextCtrl_SetIndentationGuides(wxObject, value); }
            get { return wxStyledTextCtrl_GetIndentationGuides(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int HighlightGuide
        {
            get { return wxStyledTextCtrl_GetHighlightGuide(wxObject); }
            set { wxStyledTextCtrl_SetHighlightGuide(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int GetLineEndPosition(int line)
        {
            return wxStyledTextCtrl_GetLineEndPosition(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public bool ReadOnly
        {
            get { return wxStyledTextCtrl_GetReadOnly(wxObject); }
            set { wxStyledTextCtrl_SetReadOnly(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int SelectionStart
        {
            get { return wxStyledTextCtrl_GetSelectionStart(wxObject); } 
            set { wxStyledTextCtrl_SetSelectionStart(wxObject, value); }
        }

        public int SelectionEnd
        {
            get { return wxStyledTextCtrl_GetSelectionEnd(wxObject); }
            set { wxStyledTextCtrl_SetSelectionEnd(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int PrintMagnification
        {
            get { return wxStyledTextCtrl_GetPrintMagnification(wxObject); }
            set { wxStyledTextCtrl_SetPrintMagnification(wxObject, value); }
        }

        public int PrintColourMode
        {
            get { return wxStyledTextCtrl_GetPrintColourMode(wxObject); }
            set { wxStyledTextCtrl_SetPrintColourMode(wxObject, value); } 
        }

        //-----------------------------------------------------------------------------

        public int FindText(int minPos, int maxPos, string text, int flags)
        {
            return wxStyledTextCtrl_FindText(wxObject, minPos, maxPos, text, flags);
        }

        //-----------------------------------------------------------------------------

        public int FormatRange(bool doDraw, int startPos, int endPos, DC draw, DC target, Rectangle renderRect, Rectangle pageRect)
        {
            return wxStyledTextCtrl_FormatRange(wxObject, doDraw, startPos, endPos, Object.SafePtr(draw), Object.SafePtr(target), ref renderRect, ref pageRect);
        }

        //-----------------------------------------------------------------------------

        public int FirstVisibleLine
        {
            get { return wxStyledTextCtrl_GetFirstVisibleLine(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public string GetLine(int line)
        {
            return new wxString(wxStyledTextCtrl_GetLine(wxObject, line), true);
        }

        //-----------------------------------------------------------------------------

        public int LineCount
        {
            get { return wxStyledTextCtrl_GetLineCount(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int MarginLeft
        {
            get { return wxStyledTextCtrl_GetMarginLeft(wxObject); }
            set { wxStyledTextCtrl_SetMarginLeft(wxObject, value); }
        }

        public int MarginRight
        {
            get { return wxStyledTextCtrl_GetMarginRight(wxObject); }
            set { wxStyledTextCtrl_SetMarginRight(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool Modify
        {
            get { return wxStyledTextCtrl_GetModify(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void SetSelection(int start, int end)
        {
            wxStyledTextCtrl_SetSelection(wxObject, start, end);
        }

        public string SelectedText
        {
            get { return new wxString(wxStyledTextCtrl_GetSelectedText(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public string GetTextRange(int startPos, int endPos)
        {
            return new wxString(wxStyledTextCtrl_GetTextRange(wxObject, startPos, endPos), true);
        }

        //-----------------------------------------------------------------------------

        public bool HideSelection
        {
            set { wxStyledTextCtrl_HideSelection(wxObject, value); } 
        }

        //-----------------------------------------------------------------------------

        public int LineFromPosition(int pos)
        {
            return wxStyledTextCtrl_LineFromPosition(wxObject, pos);
        }

        public int PositionFromLine(int line)
        {
            return wxStyledTextCtrl_PositionFromLine(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public void LineScroll(int columns, int lines)
        {
            wxStyledTextCtrl_LineScroll(wxObject, columns, lines);
        }

        //-----------------------------------------------------------------------------

        public void EnsureCaretVisible()
        {
            wxStyledTextCtrl_EnsureCaretVisible(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void ReplaceSelection(string text)
        {
            wxStyledTextCtrl_ReplaceSelection(wxObject, text);
        }

        //-----------------------------------------------------------------------------

        public bool CanPaste
        {
            get { return wxStyledTextCtrl_CanPaste(wxObject); } 
        }

        public bool CanUndo
        {
            get { return wxStyledTextCtrl_CanUndo(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void EmptyUndoBuffer()
        {
            wxStyledTextCtrl_EmptyUndoBuffer(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void Undo()
        {
            wxStyledTextCtrl_Undo(wxObject);
        }

        public void Cut()
        {
            wxStyledTextCtrl_Cut(wxObject);
        }

        public void Copy()
        {
            wxStyledTextCtrl_Copy(wxObject);
        }

        public void Paste()
        {
            wxStyledTextCtrl_Paste(wxObject);
        }

        public void Clear()
        {
            wxStyledTextCtrl_Clear(wxObject);
        }

        //-----------------------------------------------------------------------------

        public string Text
        {
            set { wxStyledTextCtrl_SetText(wxObject, value); } 
            get { return new wxString(wxStyledTextCtrl_GetText(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public int TextLength
        {
            get { return wxStyledTextCtrl_GetTextLength(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool Overtype
        {
            get { return wxStyledTextCtrl_GetOvertype(wxObject); }
            set { wxStyledTextCtrl_SetOvertype(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int CaretWidth
        {
            get { return wxStyledTextCtrl_GetCaretWidth(wxObject); } 
            set { wxStyledTextCtrl_SetCaretWidth(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int TargetStart
        {
            get { return wxStyledTextCtrl_GetTargetStart(wxObject); }
            set { wxStyledTextCtrl_SetTargetStart(wxObject, value); }
        }

        public int TargetEnd
        {
            get { return wxStyledTextCtrl_GetTargetEnd(wxObject); }
            set { wxStyledTextCtrl_SetTargetEnd(wxObject, value); } 
        }

        public int ReplaceTarget(string text)
        {
            return wxStyledTextCtrl_ReplaceTarget(wxObject, text);
        }

        public int ReplaceTargetRE(string text)
        {
            return wxStyledTextCtrl_ReplaceTargetRE(wxObject, text);
        }

        public int SearchInTarget(string text)
        {
            return wxStyledTextCtrl_SearchInTarget(wxObject, text);
        }

        //-----------------------------------------------------------------------------

        public int SetSearchFlags
        {
            get { return wxStyledTextCtrl_GetSearchFlags(wxObject); }
            set { wxStyledTextCtrl_SetSearchFlags(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void CallTipShow(int pos, string definition)
        {
            wxStyledTextCtrl_CallTipShow(wxObject, pos, definition);
        }

        public void CallTipCancel()
        {
            wxStyledTextCtrl_CallTipCancel(wxObject);
        }

        public bool CallTipActive
        {
            get { return wxStyledTextCtrl_CallTipActive(wxObject); }
        }

        public int CallTipPosAtStart
        {
            get { return wxStyledTextCtrl_CallTipPosAtStart(wxObject); }
        }

        public void CallTipSetHighlight(int start, int end)
        {
            wxStyledTextCtrl_CallTipSetHighlight(wxObject, start, end);
        }

        public Colour CallTipBackground
        {
            set { wxStyledTextCtrl_CallTipSetBackground(wxObject, Object.SafePtr(value)); }
        }

        public Colour CallTipForeground
        {
            set { wxStyledTextCtrl_CallTipSetForeground(wxObject, Object.SafePtr(value)); } 
        }

        public Colour CallTipForegroundHighlight
        {
            set { wxStyledTextCtrl_CallTipSetForegroundHighlight(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public int VisibleFromDocLine(int line)
        {
            return wxStyledTextCtrl_VisibleFromDocLine(wxObject, line);
        }

        public int DocLineFromVisible(int lineDisplay)
        {
            return wxStyledTextCtrl_DocLineFromVisible(wxObject, lineDisplay);
        }

        //-----------------------------------------------------------------------------

        public void SetFoldLevel(int line, int level)
        {
            wxStyledTextCtrl_SetFoldLevel(wxObject, line, level);
        }

        public int GetFoldLevel(int line)
        {
            return wxStyledTextCtrl_GetFoldLevel(wxObject, line);
        }

        public int GetLastChild(int line, int level)
        {
            return wxStyledTextCtrl_GetLastChild(wxObject, line, level);
        }

        public int GetFoldParent(int line)
        {
            return wxStyledTextCtrl_GetFoldParent(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public void ShowLines(int lineStart, int lineEnd)
        {
            wxStyledTextCtrl_ShowLines(wxObject, lineStart, lineEnd);
        }

        public void HideLines(int lineStart, int lineEnd)
        {
            wxStyledTextCtrl_HideLines(wxObject, lineStart, lineEnd);
        }

        public bool GetLineVisible(int line)
        {
            return wxStyledTextCtrl_GetLineVisible(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public void SetFoldExpanded(int line, bool expanded)
        {
            wxStyledTextCtrl_SetFoldExpanded(wxObject, line, expanded);
        }

        public bool GetFoldExpanded(int line)
        {
            return wxStyledTextCtrl_GetFoldExpanded(wxObject, line);
        }

        public void ToggleFold(int line)
        {
            wxStyledTextCtrl_ToggleFold(wxObject, line);
        }

        public void EnsureVisible(int line)
        {
            wxStyledTextCtrl_EnsureVisible(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public int FoldFlags
        {
            set { wxStyledTextCtrl_SetFoldFlags(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void EnsureVisibleEnforcePolicy(int line)
        {
            wxStyledTextCtrl_EnsureVisibleEnforcePolicy(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public bool TabIndents
        {
            get { return wxStyledTextCtrl_GetTabIndents(wxObject); }
            set { wxStyledTextCtrl_SetTabIndents(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool BackSpaceUnIndents
        {
            get { return wxStyledTextCtrl_GetBackSpaceUnIndents(wxObject); }
            set { wxStyledTextCtrl_SetBackSpaceUnIndents(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int MouseDwellTime
        {
            set { wxStyledTextCtrl_SetMouseDwellTime(wxObject, value); }
            get { return wxStyledTextCtrl_GetMouseDwellTime(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int WordStartPosition(int pos, bool onlyWordCharacters)
        {
            return wxStyledTextCtrl_WordStartPosition(wxObject, pos, onlyWordCharacters);
        }

        public int WordEndPosition(int pos, bool onlyWordCharacters)
        {
            return wxStyledTextCtrl_WordEndPosition(wxObject, pos, onlyWordCharacters);
        }

        //-----------------------------------------------------------------------------

        public int WrapMode
        {
            get { return wxStyledTextCtrl_GetWrapMode(wxObject); }
            set { wxStyledTextCtrl_SetWrapMode(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int LayoutCache
        {
            set { wxStyledTextCtrl_SetLayoutCache(wxObject, value); }
            get { return wxStyledTextCtrl_GetLayoutCache(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int ScrollWidth
        {
            get { return wxStyledTextCtrl_GetScrollWidth(wxObject); }
            set { wxStyledTextCtrl_SetScrollWidth(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int TextWidth(int style, string text)
        {
            return wxStyledTextCtrl_TextWidth(wxObject, style, text);
        }

        //-----------------------------------------------------------------------------

        public bool EndAtLastLine
        {
            get { return (bool)wxStyledTextCtrl_GetEndAtLastLine(wxObject); }
            set { wxStyledTextCtrl_SetEndAtLastLine(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int TextHeight(int line)
        {
            return wxStyledTextCtrl_TextHeight(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public bool UseVerticalScrollBar
        {
            get { return wxStyledTextCtrl_GetUseVerticalScrollBar(wxObject); }
            set { wxStyledTextCtrl_SetUseVerticalScrollBar(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        deprecated public void AppendText(int length, string text)
        {
            AppendText(text);
        }

        //-----------------------------------------------------------------------------

        public void AppendText(int length, string text)
        {
            wxStyledTextCtrl_AppendText(wxObject, text);
        }

        //-----------------------------------------------------------------------------

        public bool TwoPhaseDraw
        {
            get { return wxStyledTextCtrl_GetTwoPhaseDraw(wxObject); } 
            set { wxStyledTextCtrl_SetTwoPhaseDraw(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void TargetFromSelection()
        {
            wxStyledTextCtrl_TargetFromSelection(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void LinesJoin()
        {
            wxStyledTextCtrl_LinesJoin(wxObject);
        }

        public void LinesSplit(int pixelWidth)
        {
            wxStyledTextCtrl_LinesSplit(wxObject, pixelWidth);
        }

        //-----------------------------------------------------------------------------

        public void SetFoldMarginColour(bool useSetting, Colour back)
        {
            wxStyledTextCtrl_SetFoldMarginColour(wxObject, useSetting, Object.SafePtr(back));
        }

        public void SetFoldMarginHiColour(bool useSetting, Colour fore)
        {
            wxStyledTextCtrl_SetFoldMarginHiColour(wxObject, useSetting, Object.SafePtr(fore));
        }

        //-----------------------------------------------------------------------------

        public void LineDuplicate()
        {
            wxStyledTextCtrl_LineDuplicate(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void HomeDisplay()
        {
            wxStyledTextCtrl_HomeDisplay(wxObject);
        }

        public void HomeDisplayExtend()
        {
            wxStyledTextCtrl_HomeDisplayExtend(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void LineEndDisplay()
        {
            wxStyledTextCtrl_LineEndDisplay(wxObject);
        }

        public void LineEndDisplayExtend()
        {
            wxStyledTextCtrl_LineEndDisplayExtend(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void MoveCaretInsideView()
        {
            wxStyledTextCtrl_MoveCaretInsideView(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int LineLength(int line)
        {
            return wxStyledTextCtrl_LineLength(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public void BraceHighlight(int pos1, int pos2)
        {
            wxStyledTextCtrl_BraceHighlight(wxObject, pos1, pos2);
        }

        public void BraceBadLight(int pos)
        {
            wxStyledTextCtrl_BraceBadLight(wxObject, pos);
        }

        public int BraceMatch(int pos)
        {
            return wxStyledTextCtrl_BraceMatch(wxObject, pos);
        }

        //-----------------------------------------------------------------------------

        public bool ViewEOL
        {
            get { return wxStyledTextCtrl_GetViewEOL(wxObject); }
            set { wxStyledTextCtrl_SetViewEOL(wxObject, value); } 
        }

        //-----------------------------------------------------------------------------

        // Not really usable yet, unless sharing documents between styled
        // text controls (?)

        public Object DocPointer
        {
            get { return FindObject(wxStyledTextCtrl_GetDocPointer(wxObject)); }
            set { wxStyledTextCtrl_SetDocPointer(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public int ModEventMask
        {
            get { return wxStyledTextCtrl_GetModEventMask(wxObject); } 
            set { wxStyledTextCtrl_SetModEventMask(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int EdgeColumn
        {
            get { return wxStyledTextCtrl_GetEdgeColumn(wxObject); }
            set { wxStyledTextCtrl_SetEdgeColumn(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int EdgeMode
        {
            get { return wxStyledTextCtrl_GetEdgeMode(wxObject); } 
            set { wxStyledTextCtrl_SetEdgeMode(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public Colour EdgeColour
        {
            get { return new Colour(wxStyledTextCtrl_GetEdgeColour(wxObject), true); } 
            set { wxStyledTextCtrl_SetEdgeColour(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public void SearchAnchor()
        {
            wxStyledTextCtrl_SearchAnchor(wxObject);
        }

        public int SearchNext(int flags, string text)
        {
            return wxStyledTextCtrl_SearchNext(wxObject, flags, text);
        }

        public int SearchPrev(int flags, string text)
        {
            return wxStyledTextCtrl_SearchPrev(wxObject, flags, text);
        }

        //-----------------------------------------------------------------------------

        public int LinesOnScreen
        {
            get { return wxStyledTextCtrl_LinesOnScreen(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool UsePopUp
        {
            set { wxStyledTextCtrl_UsePopUp(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool SelectionIsRectangle
        {
            get { return wxStyledTextCtrl_SelectionIsRectangle(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Zoom
        {
            get { return wxStyledTextCtrl_GetZoom(wxObject); }
            set { wxStyledTextCtrl_SetZoom(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void CreateDocument()
        {
            wxStyledTextCtrl_CreateDocument(wxObject);
        }

        public void AddRefDocument(Object docPointer)
        {
            wxStyledTextCtrl_AddRefDocument(wxObject, Object.SafePtr(docPointer));
        }

        public void ReleaseDocument(Object docPointer)
        {
            wxStyledTextCtrl_ReleaseDocument(wxObject, Object.SafePtr(docPointer));
        }

        //-----------------------------------------------------------------------------

        public bool STCFocus
        {
            get { return wxStyledTextCtrl_GetSTCFocus(wxObject); } 
            set { wxStyledTextCtrl_SetSTCFocus(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Status
        {
            get { return wxStyledTextCtrl_GetStatus(wxObject); }
            set { wxStyledTextCtrl_SetStatus(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool MouseDownCaptures
        {
            get { return wxStyledTextCtrl_GetMouseDownCaptures(wxObject); }
            set { wxStyledTextCtrl_SetMouseDownCaptures(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int STCCursor
        {
            set { wxStyledTextCtrl_SetSTCCursor(wxObject, value); }
            get { return wxStyledTextCtrl_GetSTCCursor(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int ControlCharSymbol
        {
            set { wxStyledTextCtrl_SetControlCharSymbol(wxObject, value); }
            get { return wxStyledTextCtrl_GetControlCharSymbol(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void WordPartLeft()
        {
            wxStyledTextCtrl_WordPartLeft(wxObject);
        }

        public void WordPartLeftExtend()
        {
            wxStyledTextCtrl_WordPartLeftExtend(wxObject);
        }

        public void WordPartRight()
        {
            wxStyledTextCtrl_WordPartRight(wxObject);
        }

        public void WordPartRightExtend()
        {
            wxStyledTextCtrl_WordPartRightExtend(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void SetVisiblePolicy(int visiblePolicy, int visibleSlop)
        {
            wxStyledTextCtrl_SetVisiblePolicy(wxObject, visiblePolicy, visibleSlop);
        }

        //-----------------------------------------------------------------------------

        public void DelLineLeft()
        {
            wxStyledTextCtrl_DelLineLeft(wxObject);
        }

        public void DelLineRight()
        {
            wxStyledTextCtrl_DelLineRight(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int XOffset
        {
            set { wxStyledTextCtrl_SetXOffset(wxObject, value); }
            get { return wxStyledTextCtrl_GetXOffset(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void ChooseCaretX()
        {
            wxStyledTextCtrl_ChooseCaretX(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void SetXCaretPolicy(int caretPolicy, int caretSlop)
        {
            wxStyledTextCtrl_SetXCaretPolicy(wxObject, caretPolicy, caretSlop);
        }

        public void SetYCaretPolicy(int caretPolicy, int caretSlop)
        {
            wxStyledTextCtrl_SetYCaretPolicy(wxObject, caretPolicy, caretSlop);
        }

        //-----------------------------------------------------------------------------

        public int PrintWrapMode
        {
            set { wxStyledTextCtrl_SetPrintWrapMode(wxObject, value); }
            get { return wxStyledTextCtrl_GetPrintWrapMode(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void SetHotspotActiveForeground(bool useSetting, Colour fore)
        {
            wxStyledTextCtrl_SetHotspotActiveForeground(wxObject, useSetting, Object.SafePtr(fore));
        }

        public void SetHotspotActiveBackground(bool useSetting, Colour back)
        {
            wxStyledTextCtrl_SetHotspotActiveBackground(wxObject, useSetting, Object.SafePtr(back));
        }

        public void SetHotspotActiveUnderline(bool underline)
        {
            wxStyledTextCtrl_SetHotspotActiveUnderline(wxObject, underline);
        }

        //-----------------------------------------------------------------------------

        public void StartRecord()
        {
            wxStyledTextCtrl_StartRecord(wxObject);
        }

        public void StopRecord()
        {
            wxStyledTextCtrl_StopRecord(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int Lexer
        {
            set { wxStyledTextCtrl_SetLexer(wxObject, value); }
            get { return wxStyledTextCtrl_GetLexer(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void Colourise(int start, int end)
        {
            wxStyledTextCtrl_Colourise(wxObject, start, end);
        }

        //-----------------------------------------------------------------------------

        public void SetProperty(string key, string value)
        {
            wxStyledTextCtrl_SetProperty(wxObject, key, value);
        }

        //-----------------------------------------------------------------------------

        public void SetKeyWords(int keywordSet, string keyWords)
        {
            wxStyledTextCtrl_SetKeyWords(wxObject, keywordSet, keyWords);
        }

        //-----------------------------------------------------------------------------

        public string LexerLanguage
        {
            set { wxStyledTextCtrl_SetLexerLanguage(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int CurrentLine
        {
            get { return wxStyledTextCtrl_GetCurrentLine(wxObject); } 
        }

        //-----------------------------------------------------------------------------

        public void StyleSetSpec(int styleNum, string spec)
        {
            wxStyledTextCtrl_StyleSetSpec(wxObject, styleNum, spec);
        }

        public void StyleSetFont(int styleNum, Font font)
        {
            wxStyledTextCtrl_StyleSetFont(wxObject, styleNum, Object.SafePtr(font));
        }

        public void StyleSetFontAttr(int styleNum, int size, string faceName, bool bold, bool italic, bool underline)
        {
            wxStyledTextCtrl_StyleSetFontAttr(wxObject, styleNum, size, faceName, bold, italic, underline);
        }

        //-----------------------------------------------------------------------------

        public void CmdKeyExecute(int cmd)
        {
            wxStyledTextCtrl_CmdKeyExecute(wxObject, cmd);
        }

        //-----------------------------------------------------------------------------

        public void SetMargins(int left, int right)
        {
            wxStyledTextCtrl_SetMargins(wxObject, left, right);
        }

        //-----------------------------------------------------------------------------

        public void GetSelection(out int startPos, out int endPos)
        {
            startPos = new int();
            endPos = new int();
            wxStyledTextCtrl_GetSelection(wxObject, ref startPos, ref endPos);
        }

        //-----------------------------------------------------------------------------

        public Point PointFromPosition(int pos)
        {
            Point pt = new Point();
            wxStyledTextCtrl_PointFromPosition(wxObject, pos, ref pt);
            return pt;
        }

        //-----------------------------------------------------------------------------

        public void ScrollToLine(int line)
        {
            wxStyledTextCtrl_ScrollToLine(wxObject, line);
        }

        //-----------------------------------------------------------------------------

        public void ScrollToColumn(int column)
        {
            wxStyledTextCtrl_ScrollToColumn(wxObject, column);
        }

        //-----------------------------------------------------------------------------

        /*public int SendMsg(int msg, int wp, int lp)
        {
            return wxStyledTextCtrl_SendMsg(wxObject, msg, wp, lp);
        }*/

        //-----------------------------------------------------------------------------

        /*public ScrollBar VScrollBar
        {
            set { wxStyledTextCtrl_SetVScrollBar(wxObject, Object.SafePtr(value)); }
        }*/

        //-----------------------------------------------------------------------------

        /*public ScrollBar SetHScrollBar
        {
            set { wxStyledTextCtrl_SetHScrollBar(wxObject, Object.SafePtr(value)); }
        }*/

        //-----------------------------------------------------------------------------

        public bool LastKeydownProcessed
        {
            get { return wxStyledTextCtrl_GetLastKeydownProcessed(wxObject); }
            set { wxStyledTextCtrl_SetLastKeydownProcessed(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public bool SaveFile(string filename)
        {
            return wxStyledTextCtrl_SaveFile(wxObject, filename);
        }

        public bool LoadFile(string filename)
        {
            return wxStyledTextCtrl_LoadFile(wxObject, filename);
        }

        //-----------------------------------------------------------------------------

		public event EventListener Change
		{
			add { AddCommandListener(wxEVT_STC_CHANGE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener StyleNeeded
		{
			add { AddCommandListener(wxEVT_STC_STYLENEEDED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener CharAdded
		{
			add { AddCommandListener(wxEVT_STC_CHARADDED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener SavePointReached
		{
			add { AddCommandListener(wxEVT_STC_SAVEPOINTREACHED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener SavePointLeft
		{
			add { AddCommandListener(wxEVT_STC_SAVEPOINTLEFT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ROModifyAttempt
		{
			add { AddCommandListener(wxEVT_STC_ROMODIFYATTEMPT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Key
		{
			add { AddCommandListener(wxEVT_STC_KEY, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DoubleClick
		{
			add { AddCommandListener(wxEVT_STC_DOUBLECLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public override event EventListener UpdateUI
		{
			add { AddCommandListener(wxEVT_STC_UPDATEUI, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Modified
		{
			add { AddCommandListener(wxEVT_STC_MODIFIED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MacroRecord
		{
			add { AddCommandListener(wxEVT_STC_MACRORECORD, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MarginClick
		{
			add { AddCommandListener(wxEVT_STC_MARGINCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener NeedShown
		{
			add { AddCommandListener(wxEVT_STC_NEEDSHOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		/*public event EventListener PositionChanged
		{
			add { AddCommandListener(wxEVT_STC_POSCHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}*/

		public event EventListener Paint
		{
			add { AddCommandListener(wxEVT_STC_PAINTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener UserListSelection
		{
			add { AddCommandListener(wxEVT_STC_USERLISTSELECTION, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener URIDropped
		{
			add { AddCommandListener(wxEVT_STC_URIDROPPED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DwellStart
		{
			add { AddCommandListener(wxEVT_STC_DWELLSTART, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DwellEnd
		{
			add { AddCommandListener(wxEVT_STC_DWELLEND, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener StartDrag
		{
			add { AddCommandListener(wxEVT_STC_START_DRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DragOver
		{
			add { AddCommandListener(wxEVT_STC_DRAG_OVER, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DoDrop
		{
			add { AddCommandListener(wxEVT_STC_DO_DROP, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Zoomed
		{
			add { AddCommandListener(wxEVT_STC_ZOOM, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener HotspotClick
		{
			add { AddCommandListener(wxEVT_STC_HOTSPOT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener HotspotDoubleClick
		{
			add { AddCommandListener(wxEVT_STC_HOTSPOT_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener CalltipClick
		{
			add { AddCommandListener(wxEVT_STC_CALLTIP_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
    }

    public class StyledTextEvent : CommandEvent 
    {
        [DllImport("wx-c")] static extern IntPtr wxStyledTextEvent_ctor(int commandType, int id);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetPosition(IntPtr self, int pos);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetKey(IntPtr self, int k);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetModifiers(IntPtr self, int m);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetModificationType(IntPtr self, int t);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetText(IntPtr self, string t);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetLength(IntPtr self, int len);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetLinesAdded(IntPtr self, int num);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetLine(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetFoldLevelNow(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetFoldLevelPrev(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetMargin(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetMessage(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetWParam(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetLParam(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetListType(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetX(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetY(IntPtr self, int val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetDragText(IntPtr self, string val);
        [DllImport("wx-c")] static extern void   wxStyledTextEvent_SetDragAllowMove(IntPtr self, bool val);
        //[DllImport("wx-c")] static extern void   wxStyledTextEvent_SetDragResult(IntPtr self, wxDragResult val);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetPosition(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetKey(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetModifiers(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetModificationType(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextEvent_GetText(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetLength(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetLinesAdded(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetLine(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetFoldLevelNow(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetFoldLevelPrev(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetMargin(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetMessage(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetWParam(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetLParam(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetListType(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetX(IntPtr self);
        [DllImport("wx-c")] static extern int    wxStyledTextEvent_GetY(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxStyledTextEvent_GetDragText(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextEvent_GetDragAllowMove(IntPtr self);
        //[DllImport("wx-c")] static extern IntPtr wxStyledTextEvent_GetDragResult(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextEvent_GetShift(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextEvent_GetControl(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxStyledTextEvent_GetAlt(IntPtr self);

        //-----------------------------------------------------------------------------

		public StyledTextEvent(IntPtr wxObject) 
            : base(wxObject) { }

        public  StyledTextEvent(int commandType, int id)
            : base(wxStyledTextEvent_ctor(commandType, id)) { }

        //-----------------------------------------------------------------------------

        public int Position
        {
            get { return wxStyledTextEvent_GetPosition(wxObject); }
            set { wxStyledTextEvent_SetPosition(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Key
        {
            get { return wxStyledTextEvent_GetKey(wxObject); }
            set { wxStyledTextEvent_SetKey(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Modifiers
        {
            set { wxStyledTextEvent_SetModifiers(wxObject, value); }
            get { return wxStyledTextEvent_GetModifiers(wxObject); } 
        }

        //-----------------------------------------------------------------------------

        public int ModificationType
        {
            set { wxStyledTextEvent_SetModificationType(wxObject, value); }
            get { return wxStyledTextEvent_GetModificationType(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public string Text
        {
            set { wxStyledTextEvent_SetText(wxObject, value); } 
            get { return new wxString(wxStyledTextEvent_GetText(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public int Length
        {
            set { wxStyledTextEvent_SetLength(wxObject, value); }
            get { return wxStyledTextEvent_GetLength(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int LinesAdded
        {
            set { wxStyledTextEvent_SetLinesAdded(wxObject, value); } 
            get { return wxStyledTextEvent_GetLinesAdded(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Line
        {
            set { wxStyledTextEvent_SetLine(wxObject, value); } 
            get { return wxStyledTextEvent_GetLine(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int FoldLevelNow
        {
            set { wxStyledTextEvent_SetFoldLevelNow(wxObject, value); }
            get { return wxStyledTextEvent_GetFoldLevelNow(wxObject); }
        }

        public int FoldLevelPrev
        {
            set { wxStyledTextEvent_SetFoldLevelPrev(wxObject, value); }
            get { return wxStyledTextEvent_GetFoldLevelPrev(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Margin
        {
            set { wxStyledTextEvent_SetMargin(wxObject, value); }
            get { return wxStyledTextEvent_GetMargin(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Message
        {
            set { wxStyledTextEvent_SetMessage(wxObject, value); } 
            get { return wxStyledTextEvent_GetMessage(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int WParam
        {
            set { wxStyledTextEvent_SetWParam(wxObject, value); }
            get { return wxStyledTextEvent_GetWParam(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int LParam
        {
            set { wxStyledTextEvent_SetLParam(wxObject, value); }
            get { return wxStyledTextEvent_GetLParam(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int ListType
        {
            set { wxStyledTextEvent_SetListType(wxObject, value); }
            get { return wxStyledTextEvent_GetListType(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int X
        {
            set { wxStyledTextEvent_SetX(wxObject, value); }
            get { return wxStyledTextEvent_GetX(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Y
        {
            set { wxStyledTextEvent_SetY(wxObject, value); }
            get { return wxStyledTextEvent_GetY(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public string DragText
        {
            set { wxStyledTextEvent_SetDragText(wxObject, value); }
            get { return new wxString(wxStyledTextEvent_GetDragText(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public bool DragAllowMove
        {
            set { wxStyledTextEvent_SetDragAllowMove(wxObject, value); } 
            get { return wxStyledTextEvent_GetDragAllowMove(wxObject); }
        }

        //-----------------------------------------------------------------------------

        /*public DragResult DragResult
        {
            set { wxStyledTextEvent_SetDragResult(wxObject, Object.SafePtr(value)); }
            get { return wxStyledTextEvent_GetDragResult(wxObject); }
        }*/

        //-----------------------------------------------------------------------------

        public bool Shift
        {
            get { return wxStyledTextEvent_GetShift(wxObject); }
        }

        public bool Control
        {
            get { return wxStyledTextEvent_GetControl(wxObject); }
        }

        public bool Alt
        {
            get { return wxStyledTextEvent_GetAlt(wxObject); }
        }
    }
}

#endif 

