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

		//! \cond EXTERN
		static extern (C) IntPtr wxString_ctor(char* str);
		static extern (C) IntPtr wxString_ctor2(char[] str);
		static extern (C) void   wxString_dtor(IntPtr self);
		static extern (C) string wxString_mb_str(IntPtr self);
		static extern (C) uint   wxString_Length(IntPtr self);
		static extern (C) char   wxString_CharAt(IntPtr self, uint i);
		static extern (C) int    wxString_CharAtInt(IntPtr self, uint i);
		static extern (C) char*  wxString_c_str(IntPtr self);
		static extern (C) char[] wxString_d_str(IntPtr self);
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

		public uint length() { return wxString_Length(wxobj); }
		public char* c_str() { return wxString_c_str(wxobj); }
		public char[] toString() { return wxString_d_str(wxobj).dup; }
//version(__WXMSW__) {
		public char opIndex(uint i)
			{ return wxString_CharAt(wxobj, i); }
//} else {
//		public char opIndex(uint i)
//			{ return System.Convert.ToChar(wxString_CharAtInt(wxobj, i)); }
//} // version(__WXMSW__)			
		
	}

