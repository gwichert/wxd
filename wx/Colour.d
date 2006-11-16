//-----------------------------------------------------------------------------
// wx.NET - Colour.cs
//
// The wxColour wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public class Colour : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxColour_ctor();
		[DllImport("wx-c")] static extern IntPtr wxColour_ctorByName(string name);
		[DllImport("wx-c")] static extern IntPtr wxColour_ctorByParts(byte red, byte green, byte blue);
		[DllImport("wx-c")] static extern void   wxColour_dtor(IntPtr self);
		//[DllImport("wx-c")] static extern void   wxColour_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);

		[DllImport("wx-c")] static extern byte   wxColour_Red(IntPtr self);
		[DllImport("wx-c")] static extern byte   wxColour_Blue(IntPtr self);
		[DllImport("wx-c")] static extern byte   wxColour_Green(IntPtr self);

		[DllImport("wx-c")] static extern bool   wxColour_Ok(IntPtr self);
		[DllImport("wx-c")] static extern void   wxColour_Set(IntPtr self, byte red, byte green, byte blue);
		
		[DllImport("wx-c")] static extern IntPtr wxColour_CreateByName(string name);

		//---------------------------------------------------------------------

		public static Colour wxBLACK       = new Colour("Black");
		public static Colour wxWHITE       = new Colour("White");
		public static Colour wxRED         = new Colour("Red");
		public static Colour wxBLUE        = new Colour("Blue");
		public static Colour wxGREEN       = new Colour("Green");
		public static Colour wxCYAN        = new Colour("Cyan");
		public static Colour wxLIGHT_GREY  = new Colour("Light Gray");

		//---------------------------------------------------------------------

		public Colour(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject; 
		}
			
		internal Colour(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public Colour() 
			: this(wxColour_ctor(), true) 
		{ 
			/*virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxColour_RegisterDisposable(wxObject, virtual_Dispose);*/
		}

		public Colour(string name)
			: this(wxColour_ctorByName(name.ToUpper()), true) 
		{ 
			/*virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxColour_RegisterDisposable(wxObject, virtual_Dispose);*/
		}

		public Colour(byte red, byte green, byte blue)
			: this(wxColour_ctorByParts(red, green, blue), true) 
		{ 
			/*virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxColour_RegisterDisposable(wxObject, virtual_Dispose);*/
		}

		~Colour()
		{
			Dispose();
		}
		
		//---------------------------------------------------------------------

		public override void Dispose()
		{
			if ((this != Colour.wxBLACK) && (this != Colour.wxWHITE) &&
				(this != Colour.wxRED) && (this != Colour.wxBLUE) &&
					(this != Colour.wxGREEN) && (this != Colour.wxCYAN) &&
						(this != Colour.wxLIGHT_GREY)) 
			{
				Dispose(true);
			}
		}

		//---------------------------------------------------------------------

		public byte Red
		{
			get { return wxColour_Red(wxObject); }
		}

		public byte Green
		{
			get { return wxColour_Green(wxObject); }
		}

		public byte Blue
		{
			get { return wxColour_Blue(wxObject); }
		}

		//---------------------------------------------------------------------

		public bool Ok()
		{
			return wxColour_Ok(wxObject);
		}

		public void Set(byte red, byte green, byte blue)
		{
			wxColour_Set(wxObject, red, green, blue);
		}

		//---------------------------------------------------------------------
		
		#if __WXGTK__
		public static Colour CreateByName(string name)
		{
			return new Colour(wxColour_CreateByName(name), true);
		}
		#endif
	}
}
