//-----------------------------------------------------------------------------
// wx.NET - Font.cs
//
// The wxFont wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	// Font encodings - taken from wx/fontenc.h
	// Author: Vadim Zeitlin, (C) Vadim Zeitlin
	public enum FontEncoding
	{
		wxFONTENCODING_SYSTEM = -1,     // system default
		wxFONTENCODING_DEFAULT,         // current default encoding

		// ISO8859 standard defines a number of single-byte charsets
		wxFONTENCODING_ISO8859_1,           // West European (Latin1)
		wxFONTENCODING_ISO8859_2,           // Central and East European (Latin2)
		wxFONTENCODING_ISO8859_3,           // Esperanto (Latin3)
		wxFONTENCODING_ISO8859_4,           // Baltic (old) (Latin4)
		wxFONTENCODING_ISO8859_5,           // Cyrillic
		wxFONTENCODING_ISO8859_6,           // Arabic
		wxFONTENCODING_ISO8859_7,           // Greek
		wxFONTENCODING_ISO8859_8,           // Hebrew
		wxFONTENCODING_ISO8859_9,           // Turkish (Latin5)
		wxFONTENCODING_ISO8859_10,          // Variation of Latin4 (Latin6)
		wxFONTENCODING_ISO8859_11,          // Thai
		wxFONTENCODING_ISO8859_12,          // doesn't exist currently, but put it
		// here anyhow to make all ISO8859
		// consecutive numbers
		wxFONTENCODING_ISO8859_13,          // Baltic (Latin7)
		wxFONTENCODING_ISO8859_14,          // Latin8
		wxFONTENCODING_ISO8859_15,          // Latin9 (a.k.a. Latin0, includes euro)
		wxFONTENCODING_ISO8859_MAX,

		// Cyrillic charset soup (see http://czyborra.com/charsets/cyrillic.html)
		wxFONTENCODING_KOI8,                // we don't support any of KOI8 variants
		wxFONTENCODING_ALTERNATIVE,         // same as MS-DOS CP866
		wxFONTENCODING_BULGARIAN,           // used under Linux in Bulgaria
		// what would we do without Microsoft? They have their own encodings
		// for DOS
		wxFONTENCODING_CP437,               // original MS-DOS codepage
		wxFONTENCODING_CP850,               // CP437 merged with Latin1
		wxFONTENCODING_CP852,               // CP437 merged with Latin2
		wxFONTENCODING_CP855,               // another cyrillic encoding
		wxFONTENCODING_CP866,               // and another one
		// and for Windows
		wxFONTENCODING_CP874,               // WinThai
		wxFONTENCODING_CP932,               // Japanese (shift-JIS)
		wxFONTENCODING_CP936,               // Chinese simplified (GB)
		wxFONTENCODING_CP949,               // Korean (Hangul charset)
		wxFONTENCODING_CP950,               // Chinese (traditional - Big5)
		wxFONTENCODING_CP1250,              // WinLatin2
		wxFONTENCODING_CP1251,              // WinCyrillic
		wxFONTENCODING_CP1252,              // WinLatin1
		wxFONTENCODING_CP1253,              // WinGreek (8859-7)
		wxFONTENCODING_CP1254,              // WinTurkish
		wxFONTENCODING_CP1255,              // WinHebrew
		wxFONTENCODING_CP1256,              // WinArabic
		wxFONTENCODING_CP1257,              // WinBaltic (same as Latin 7)
		wxFONTENCODING_CP12_MAX,

		wxFONTENCODING_UTF7,                // UTF-7 Unicode encoding
		wxFONTENCODING_UTF8,                // UTF-8 Unicode encoding

		// Far Eastern encodings
		// Chinese
		wxFONTENCODING_GB2312 = wxFONTENCODING_CP936,       // Simplified Chinese
		wxFONTENCODING_BIG5 = wxFONTENCODING_CP950,         // Traditional Chinese

		// Japanese (see http://zsigri.tripod.com/fontboard/cjk/jis.html)
		wxFONTENCODING_Shift_JIS = wxFONTENCODING_CP932,    // Shift JIS
		wxFONTENCODING_EUC_JP,                              // Extended Unix Codepage for Japanese

		wxFONTENCODING_UNICODE,         // Unicode - currently used only by
		// wxEncodingConverter class

		wxFONTENCODING_MAX
	}

	public enum FontFamily
	{
		// Text font families
		wxDEFAULT    = 70,
		wxDECORATIVE,
		wxROMAN,
		wxSCRIPT,
		wxSWISS,
		wxMODERN,
		wxTELETYPE,  
		wxMAX,
        
		// Proportional or Fixed width fonts (not yet used)
		wxVARIABLE   = 80,
		wxFIXED,
        
		wxNORMAL     = 90,
		wxLIGHT,
		wxBOLD,
		// Also wxNORMAL for normal (non-italic text)
		wxITALIC,
		wxSLANT
	}

	public enum FontWeight
	{
		wxNORMAL = 90,
		wxLIGHT,
		wxBOLD,
		wxMAX
	}

	public enum FontStyle
	{
		wxNORMAL = 90,
		wxITALIC = 93,
		wxSLANT  = 94,
		wxMAX
	}
	
	public enum FontFlag
	{
		wxFONTFLAG_DEFAULT          = 0,

		wxFONTFLAG_ITALIC           = 1 << 0,
		wxFONTFLAG_SLANT            = 1 << 1,

		wxFONTFLAG_LIGHT            = 1 << 2,
		wxFONTFLAG_BOLD             = 1 << 3,

		wxFONTFLAG_ANTIALIASED      = 1 << 4,
		wxFONTFLAG_NOT_ANTIALIASED  = 1 << 5,

		wxFONTFLAG_UNDERLINED       = 1 << 6,
		wxFONTFLAG_STRIKETHROUGH    = 1 << 7,

		wxFONTFLAG_MASK = wxFONTFLAG_ITALIC             |
			wxFONTFLAG_SLANT              |
			wxFONTFLAG_LIGHT              |
			wxFONTFLAG_BOLD               |
			wxFONTFLAG_ANTIALIASED        |
			wxFONTFLAG_NOT_ANTIALIASED    |
			wxFONTFLAG_UNDERLINED         |
			wxFONTFLAG_STRIKETHROUGH
	}

	public class Font : GDIObject, ICloneable
	{
		[DllImport("wx-c")] static extern        IntPtr wxFont_NORMAL_FONT();
		[DllImport("wx-c")] static extern        IntPtr wxFont_SMALL_FONT();
		[DllImport("wx-c")] static extern        IntPtr wxFont_ITALIC_FONT();
		[DllImport("wx-c")] static extern        IntPtr wxFont_SWISS_FONT();

		[DllImport("wx-c")] static extern        IntPtr wxFont_ctorDef();
		[DllImport("wx-c")] static extern        IntPtr wxFont_ctor(int pointSize, int family, int style, int weight, bool underline, string faceName, FontEncoding encoding);
		[DllImport("wx-c")] static extern void   wxFont_dtor(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxFont_Ok(IntPtr self);
		[DllImport("wx-c")] static extern int    wxFont_GetPointSize(IntPtr self);
		[DllImport("wx-c")] static extern int    wxFont_GetFamily(IntPtr self);
		[DllImport("wx-c")] static extern int    wxFont_GetStyle(IntPtr self);
		[DllImport("wx-c")] static extern int    wxFont_GetWeight(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxFont_GetUnderlined(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxFont_GetFaceName(IntPtr self);
		[DllImport("wx-c")] static extern int    wxFont_GetEncoding(IntPtr self);
		[DllImport("wx-c")] static extern        IntPtr wxFont_GetNativeFontInfo(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxFont_IsFixedWidth(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxFont_GetNativeFontInfoDesc(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxFont_GetNativeFontInfoUserDesc(IntPtr self);
		[DllImport("wx-c")] static extern void   wxFont_SetPointSize(IntPtr self, int pointSize);
		[DllImport("wx-c")] static extern void   wxFont_SetFamily(IntPtr self, int family);
		[DllImport("wx-c")] static extern void   wxFont_SetStyle(IntPtr self, int style);
		[DllImport("wx-c")] static extern void   wxFont_SetWeight(IntPtr self, int weight);
		[DllImport("wx-c")] static extern void   wxFont_SetFaceName(IntPtr self, string faceName);
		[DllImport("wx-c")] static extern void   wxFont_SetUnderlined(IntPtr self, bool underlined);
		[DllImport("wx-c")] static extern void   wxFont_SetEncoding(IntPtr self, int encoding);
		[DllImport("wx-c")] static extern void   wxFont_SetNativeFontInfoUserDesc(IntPtr self, IntPtr info);
		[DllImport("wx-c")] static extern IntPtr wxFont_GetFamilyString(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxFont_GetStyleString(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxFont_GetWeightString(IntPtr self);
		[DllImport("wx-c")] static extern void   wxFont_SetNoAntiAliasing(IntPtr self, bool no);
		[DllImport("wx-c")] static extern bool   wxFont_GetNoAntiAliasing(IntPtr self);
		[DllImport("wx-c")] static extern int    wxFont_GetDefaultEncoding();
		[DllImport("wx-c")] static extern void   wxFont_SetDefaultEncoding(int encoding);
	
		[DllImport("wx-c")] static extern IntPtr wxFont_New(string strNativeFontDesc);

		//---------------------------------------------------------------------

		public static Font wxNORMAL_FONT    = new Font(wxFont_NORMAL_FONT());
		public static Font wxSMALL_FONT     = new Font(wxFont_SMALL_FONT());
		public static Font wxITALIC_FONT    = new Font(wxFont_ITALIC_FONT());
		public static Font wxSWISS_FONT     = new Font(wxFont_SWISS_FONT());

		//---------------------------------------------------------------------

		public Font(IntPtr wxObject) 
			: base(wxObject) { }
			
		internal Font(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public Font()
			: this(wxFont_ctorDef(), true) { }

		public Font(int pointSize, FontFamily family, FontStyle style, FontWeight weight)
			: this(pointSize, family, style, weight, false, "", FontEncoding.wxFONTENCODING_DEFAULT) { }

		public Font(int pointSize, FontFamily family, FontStyle style, FontWeight weight, bool underline, string faceName)
			: this(pointSize, family, style, weight, underline, faceName, FontEncoding.wxFONTENCODING_DEFAULT) { }

		public Font(int pointSize, FontFamily family, FontStyle style, FontWeight weight, bool underline, string faceName, FontEncoding encoding)
			: this(wxFont_ctor(pointSize, (int)family, (int)style, (int)weight, underline, faceName, encoding), true) { }
			
		~Font()
		{
			Dispose();
		}

		//---------------------------------------------------------------------

		public override void Dispose()
		{
			if ((this != Font.wxNORMAL_FONT) && (this != Font.wxSWISS_FONT) &&
				(this != Font.wxSMALL_FONT) && (this != Font.wxITALIC_FONT)) 
			{
				Dispose(true);
			}
		}

		//---------------------------------------------------------------------

		public int PointSize
		{
			get { return wxFont_GetPointSize(wxObject); }
			set { wxFont_SetPointSize(wxObject, value); }
		}

		public FontFamily Family
		{
			get { return (FontFamily)wxFont_GetFamily(wxObject); }
			set { wxFont_SetFamily(wxObject, (int)value); }
		}

		public FontStyle Style
		{
			get { return (FontStyle)wxFont_GetStyle(wxObject); }
			set { wxFont_SetStyle(wxObject, (int)value); }
		}

		public FontEncoding Encoding
		{
			get { return (FontEncoding)wxFont_GetEncoding(wxObject); }
			set { wxFont_SetEncoding(wxObject, (int)value); }
		}

		public FontWeight Weight
		{
			get { return (FontWeight)wxFont_GetWeight(wxObject); }
			set { wxFont_SetWeight(wxObject, (int)value); }
		}

		public bool Underlined
		{
			get { return wxFont_GetUnderlined(wxObject); }
			set { wxFont_SetUnderlined(wxObject, value); }
		}

		public string FaceName
		{
			get { return new wxString(wxFont_GetFaceName(wxObject), true); }
			set { wxFont_SetFaceName(wxObject, value); }
		}
	
		public string FamilyString
		{
			get { return new wxString(wxFont_GetFamilyString(wxObject), true); }
		}
	
		public string StyleString
		{
			get { return new wxString(wxFont_GetStyleString(wxObject), true); }
		}
	
		public string WeightString
		{
			get { return new wxString(wxFont_GetStyleString(wxObject), true); }
		}
	
		public bool IsFixedWidth
		{
			get { return wxFont_IsFixedWidth(wxObject); }
		}
	
		public bool Ok
		{
			get { return wxFont_Ok(wxObject); }
		}
	
		public IntPtr NativeFontInfo
		{
			get { return wxFont_GetNativeFontInfo(wxObject); }
		}
	
		public string NativeFontInfoUserDesc
		{
			get { return new wxString(wxFont_GetNativeFontInfoUserDesc(wxObject), true); }
		}
	
		public string NativeFontInfoDesc
		{
			get{ return new wxString(wxFont_GetNativeFontInfoDesc(wxObject), true); }
		}
	
		public static Font New(string strNativeFontDesc)
		{
			return new Font(wxFont_New(strNativeFontDesc));
		}

		//---------------------------------------------------------------------

		// Implement ICloneable to provide instance copy
		public object Clone()
		{
			Font clone = new Font();
			CopyMembers(this, clone);
			return clone;
		}

		// Constructor that copies font passed in
		public Font(Font existing_font) : this(wxFont_ctorDef())
		{
			CopyMembers(existing_font, this);
		}

		private void CopyMembers(Font from, Font to)
		{
			to.Encoding = from.Encoding;
			to.FaceName = from.FaceName;
			to.Family = from.Family;
			to.PointSize = from.PointSize;
			to.Style = from.Style;
			to.Underlined = from.Underlined;
			to.Weight = from.Weight;
		}
	}
}
