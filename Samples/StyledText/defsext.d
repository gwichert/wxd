/////////////////////////////////////////////////////////////////////////////
// Name:        defsext.h extensions
// Purpose:     STC test declarations
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
import wx.PrintDialog; // printing dialog


//============================================================================
// declarations
//============================================================================

const char[] DEFAULT_LANGUAGE = "<default>";

const char[] PAGE_COMMON = "Common";
const char[] PAGE_LANGUAGES = "Languages";
const char[] PAGE_STYLE_TYPES = "Style types";

const int STYLE_TYPES_COUNT = 32;


// ----------------------------------------------------------------------------
// standard IDs
// ----------------------------------------------------------------------------

enum {
    // menu IDs
    myID_PROPERTIES = wxID_HIGHEST,
    myID_INDENTINC,
    myID_INDENTRED,
    myID_FINDNEXT,
    myID_REPLACE,
    myID_REPLACENEXT,
    myID_BRACEMATCH,
    myID_GOTO,
    myID_PAGEACTIVE,
    myID_DISPLAYEOL,
    myID_INDENTGUIDE,
    myID_LINENUMBER,
    myID_LONGLINEON,
    myID_WHITESPACE,
    myID_FOLDTOGGLE,
    myID_OVERTYPE,
    myID_READONLY,
    myID_WRAPMODEON,
    myID_CHANGECASE,
    myID_CHANGELOWER,
    myID_CHANGEUPPER,
    myID_HILIGHTLANG,
    myID_HILIGHTFIRST,
    myID_HILIGHTLAST = myID_HILIGHTFIRST + 99,
    myID_CONVERTEOL,
    myID_CONVERTCR,
    myID_CONVERTCRLF,
    myID_CONVERTLF,
    myID_USECHARSET,
    myID_CHARSETANSI,
    myID_CHARSETMAC,
    myID_PAGEPREV,
    myID_PAGENEXT,
    myID_SELECTLINE,

    // other IDs
    myID_STATUSBAR,
    myID_TITLEBAR,
    myID_ABOUTTIMER,
    myID_UPDATETIMER,

    // dialog find IDs
    myID_DLG_FIND_TEXT,

    // preferences IDs
    myID_PREFS_LANGUAGE,
    myID_PREFS_STYLETYPE,
    myID_PREFS_KEYWORDS,
};

// ----------------------------------------------------------------------------
// global items
// ----------------------------------------------------------------------------

/+
//! global application name
extern wxString *g_appname;

#if wxUSE_PRINTING_ARCHITECTURE

//! global print data, to remember settings during the session
extern wxPrintData *g_printData;
extern wxPageSetupData *g_pageSetupData;

#endif // wxUSE_PRINTING_ARCHITECTURE
+/

