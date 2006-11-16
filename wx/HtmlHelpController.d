//-----------------------------------------------------------------------------
// wx.NET - HtmlHelpController.cs
//
// The wxHtmlHelpController wrapper class
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class HtmlHelpController : Object
	{
		public static int wxHF_TOOLBAR =	0x0001;
		public static int wxHF_CONTENTS =	0x0002;
		public static int wxHF_INDEX =		0x0004;
		public static int wxHF_SEARCH =		0x0008;
		public static int wxHF_BOOKMARKS =	0x0010;
		public static int wxHF_OPEN_FILES =	0x0020;
		public static int wxHF_PRINT = 		0x0040;
		public static int wxHF_FLAT_TOOLBAR =	0x0080;
		public static int wxHF_MERGE_BOOKS =	0x0100;
		public static int wxHF_ICONS_BOOK =	0x0200;
		public static int wxHF_ICONS_BOOK_CHAPTER = 0x0400;
		public static int wxHF_ICONS_FOLDER = 0x0000;
		public static int wxHF_DEFAULT_STYLE =		(wxHF_TOOLBAR | wxHF_CONTENTS | 
					wxHF_INDEX | wxHF_SEARCH | 
					wxHF_BOOKMARKS | wxHF_PRINT);
		public static int wxHF_OPENFILES =	wxHF_OPEN_FILES;
		public static int wxHF_FLATTOOLBAR = 	wxHF_FLAT_TOOLBAR;
		public static int wxHF_DEFAULTSTYLE =	wxHF_DEFAULT_STYLE;
		
		//-----------------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxHtmlHelpController_ctor(int style);
		[DllImport("wx-c")] static extern void   wxHtmlHelpController_SetTitleFormat(IntPtr self, string format);
		[DllImport("wx-c")] static extern void   wxHtmlHelpController_SetTempDir(IntPtr self, string path);
		[DllImport("wx-c")] static extern bool   wxHtmlHelpController_AddBook(IntPtr self, string book_url);
		[DllImport("wx-c")] static extern bool   wxHtmlHelpController_Display(IntPtr self, string x);
		[DllImport("wx-c")] static extern bool   wxHtmlHelpController_DisplayInt(IntPtr self, int id);
		[DllImport("wx-c")] static extern bool   wxHtmlHelpController_DisplayContents(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxHtmlHelpController_DisplayIndex(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxHtmlHelpController_KeywordSearch(IntPtr self, string keyword, int mode);
		[DllImport("wx-c")] static extern void   wxHtmlHelpController_UseConfig(IntPtr self, IntPtr config, string rootpath);
		[DllImport("wx-c")] static extern void   wxHtmlHelpController_ReadCustomization(IntPtr self, IntPtr cfg, string path);
		[DllImport("wx-c")] static extern void   wxHtmlHelpController_WriteCustomization(IntPtr self, IntPtr cfg, string path);
		[DllImport("wx-c")] static extern IntPtr wxHtmlHelpController_GetFrame(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
		public HtmlHelpController(IntPtr wxObject)
			: base(wxObject) {}
			
		public HtmlHelpController()
			: this(wxHF_DEFAULT_STYLE) {}
			
		public HtmlHelpController(int style)
			: base(wxHtmlHelpController_ctor(style)) {}
			
		//-----------------------------------------------------------------------------
		
		public string TitleFormat
		{
			set { wxHtmlHelpController_SetTitleFormat(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public string TempDir 
		{
			set { wxHtmlHelpController_SetTempDir(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool AddBook(string book_url)
		{
			return wxHtmlHelpController_AddBook(wxObject, book_url);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Display(string x)
		{
			return wxHtmlHelpController_Display(wxObject, x);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Display(int id)
		{
			return wxHtmlHelpController_DisplayInt(wxObject, id); 
		}
		
		//-----------------------------------------------------------------------------
		
		public bool DisplayContents()
		{
			return wxHtmlHelpController_DisplayContents(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool DisplayIndex()
		{
			return wxHtmlHelpController_DisplayIndex(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool KeywordSearch(string keyword)
		{
			return KeywordSearch(keyword, HelpSearchMode.wxHELP_SEARCH_ALL);
		}
		
		public bool KeywordSearch(string keyword, HelpSearchMode mode)
		{
			return wxHtmlHelpController_KeywordSearch(wxObject, keyword, (int)mode);
		}
		
		//-----------------------------------------------------------------------------
		
		public void UseConfig(Config config)
		{
			UseConfig(config, "");
		}
		
		public void UseConfig(Config config, string rootpath)
		{
			wxHtmlHelpController_UseConfig(wxObject, Object.SafePtr(config), rootpath);
		}
		
		//-----------------------------------------------------------------------------
		
		public void ReadCustomization(Config cfg)
		{
			ReadCustomization(cfg, "");
		}
		
		public void ReadCustomization(Config cfg, string path)
		{
			wxHtmlHelpController_ReadCustomization(wxObject, Object.SafePtr(cfg), path);
		}
		
		//-----------------------------------------------------------------------------
		
		public void WriteCustomization(Config cfg)
		{
			WriteCustomization(cfg, "");
		}
		
		public void WriteCustomization(Config cfg, string path)
		{
			wxHtmlHelpController_WriteCustomization(wxObject, Object.SafePtr(cfg), path);
		}
		
		//-----------------------------------------------------------------------------
		
		public Frame Frame
		{
			get { 
				IntPtr tmp = wxHtmlHelpController_GetFrame(wxObject); 
				if ( tmp != IntPtr.Zero )
					return new Frame(tmp);
				else
					return null;
			}
		}
	}
}
