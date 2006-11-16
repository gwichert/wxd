//-----------------------------------------------------------------------------
// wx.NET - ColourDialog.cs
// 
// The wxColourDialog wrapper class.
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
	public class ColourData : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxColourData_ctor();

		[DllImport("wx-c")] static extern void   wxColourData_SetChooseFull(IntPtr self, bool flag);
		[DllImport("wx-c")] static extern bool   wxColourData_GetChooseFull(IntPtr self);

		[DllImport("wx-c")] static extern void   wxColourData_SetColour(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxColourData_GetColour(IntPtr self);

		[DllImport("wx-c")] static extern void   wxColourData_SetCustomColour(IntPtr self, int i, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxColourData_GetCustomColour(IntPtr self, int i);

		//---------------------------------------------------------------------
        
		public ColourData(IntPtr wxObject) 
			: base(wxObject) { }

		public ColourData()
			: base(wxColourData_ctor()) { }

		//---------------------------------------------------------------------

		public bool ChooseFull
		{
			get 
			{
				return wxColourData_GetChooseFull(wxObject);
			}
			set
			{
				wxColourData_SetChooseFull(wxObject, value);
			}
		}

		//---------------------------------------------------------------------
	
		public Colour Colour
		{
			get
			{
				IntPtr ptr = wxColourData_GetColour(wxObject);
				return (Colour)FindObject(ptr, typeof(Colour));
			}
			set
			{
				wxColourData_SetColour(wxObject, Object.SafePtr(value));
			}
		}
		
		//---------------------------------------------------------------------
	
		public Colour GetCustomColour(int i) 
		{
			return new Colour(wxColourData_GetCustomColour(wxObject, i), true);
		}
	
		public void SetCustomColour(int i, Colour colour)
		{
			wxColourData_SetCustomColour(wxObject, i, Object.SafePtr(colour));
		}
	}
	
	//---------------------------------------------------------------------
	
	public class ColourDialog : Dialog
	{
		[DllImport("wx-c")] static extern IntPtr wxColourDialog_ctor();
		[DllImport("wx-c")] static extern bool   wxColourDialog_Create(IntPtr self, IntPtr parent, IntPtr data);
		[DllImport("wx-c")] static extern IntPtr wxColourDialog_GetColourData(IntPtr self);
		[DllImport("wx-c")] static extern int    wxColourDialog_ShowModal(IntPtr self);
		
		[DllImport("wx-c")] static extern IntPtr wxColourDialog_GetColourFromUser(IntPtr parent, IntPtr colInit);
	
		//---------------------------------------------------------------------
	
		public ColourDialog(IntPtr wxObject)
			: base(wxObject) { }
	
		public ColourDialog()
			: base(wxColourDialog_ctor()) { }
	
		public ColourDialog(Window parent)
			: this(parent, null) { }
	
		public ColourDialog(Window parent, ColourData data)
			: base(wxColourDialog_ctor())
		{
			if (!Create(parent, data)) 
			{
				throw new InvalidOperationException("Failed to create ColourDialog");
			}
		}
	
		public bool Create(Window parent, ColourData data)
		{
			return wxColourDialog_Create(wxObject, Object.SafePtr(parent),
							Object.SafePtr(data));
		}
	
		//---------------------------------------------------------------------
	
		public ColourData ColourData
		{
			get
			{
				IntPtr ptr = wxColourDialog_GetColourData(wxObject);
				return (ColourData)FindObject(ptr, typeof(ColourData));
			}
		}
	
		//---------------------------------------------------------------------
	
		public override int ShowModal()
		{
			return wxColourDialog_ShowModal(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public static Colour GetColourFromUser()
		{
			return GetColourFromUser(null, NullObjects.wxNullColour);
		}
		
		public static Colour GetColourFromUser(Window parent)
		{
			return GetColourFromUser(parent, NullObjects.wxNullColour);
		}
		
		public static Colour GetColourFromUser(Window parent, Colour colInit)
		{
			return new Colour(wxColourDialog_GetColourFromUser(Object.SafePtr(parent), Object.SafePtr(colInit)));
		}
	}
}
