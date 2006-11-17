//-----------------------------------------------------------------------------
// wxD - wxString.d
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - wxString.cs
//
/// The wxString wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.wxString;
public import wx.common;

//! \cond STD
private import std.string;
private import std.utf;
//! \endcond

		//! \cond EXTERN
		static extern (C) IntPtr  wxString_ctor(char* str);
		static extern (C) IntPtr  wxString_ctor2(string str);
		static extern (C) void    wxString_dtor(IntPtr self);
		static extern (C) size_t  wxString_Length(IntPtr self);
		static extern (C) wxChar  wxString_GetChar(IntPtr self, size_t i);
		static extern (C) wxChar* wxString_c_str(IntPtr self);
		static extern (C) string  wxString_d_str(IntPtr self);
		//! \endcond
		
		//---------------------------------------------------------------------

	//! \brief wxString is a class representing a character string.
	public class wxString : wxObject
	{
		public this(IntPtr wxobj)
		{ 
			super(wxobj);
		}
			
		private this(IntPtr wxobj, bool memOwn)
		{ 
			super(wxobj);
			this.memOwn = memOwn;
		}

		public this()
			{ this(""); }

		public this(string str)
			{ this(wxString_ctor2(str), true); }
		
		//---------------------------------------------------------------------
		override protected void dtor() { wxString_dtor(wxobj); }				
		//---------------------------------------------------------------------

		public size_t length() { return wxString_Length(wxobj); }
		public char opIndex(size_t i) { return wxString_GetChar(wxobj, i); }
		public wxChar* data() { return wxString_c_str(wxobj); }
		public string opCast() { return wxString_d_str(wxobj).dup; }

	}

