//-----------------------------------------------------------------------------
// wx.NET - ActivateEvent.cs
//
// The wxActivateEvent wrapper class.
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
	public class GDIPens
	{
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetRedPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetCyanPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetGreenPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetBlackPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetWhitePen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetTransparentPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetBlackDashedPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetGreyPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetMediumGreyPen();
		[DllImport("wx-c")] static extern IntPtr wxGDIObj_GetLightGreyPen();

		public static Pen wxRED_PEN = new Pen(wxGDIObj_GetRedPen());
		public static Pen wxCYAN_PEN = new Pen(wxGDIObj_GetCyanPen());
		public static Pen wxGREEN_PEN = new Pen(wxGDIObj_GetGreenPen());
		public static Pen wxBLACK_PEN = new Pen(wxGDIObj_GetBlackPen());
		public static Pen wxWHITE_PEN = new Pen(wxGDIObj_GetWhitePen());
		public static Pen wxTRANSPARENT_PEN = new Pen(wxGDIObj_GetTransparentPen());
		public static Pen wxBLACK_DASHED_PEN = new Pen(wxGDIObj_GetBlackDashedPen());
		public static Pen wxGREY_PEN = new Pen(wxGDIObj_GetGreyPen());
		public static Pen wxMEDIUM_GREY_PEN = new Pen(wxGDIObj_GetMediumGreyPen());
		public static Pen wxLIGHT_GREY_PEN = new Pen(wxGDIObj_GetLightGreyPen());
	}
	
	//-----------------------------------------------------------------------------
	
	public class GDIBrushes
	{
		[DllImport("wx-c")] static extern IntPtr wxBLUE_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxGREEN_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxWHITE_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxBLACK_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxGREY_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxMEDIUM_GREY_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxLIGHT_GREY_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxTRANSPARENT_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxCYAN_BRUSH_Get();
		[DllImport("wx-c")] static extern IntPtr wxRED_BRUSH_Get();
		
		public static Brush wxBLUE_BRUSH = new Brush(wxBLUE_BRUSH_Get());
		public static Brush wxGREEN_BRUSH = new Brush(wxGREEN_BRUSH_Get());
		public static Brush wxWHITE_BRUSH = new Brush(wxWHITE_BRUSH_Get());
		public static Brush wxBLACK_BRUSH = new Brush(wxBLACK_BRUSH_Get());
		public static Brush wxGREY_BRUSH = new Brush(wxGREY_BRUSH_Get());
		public static Brush wxMEDIUM_GREY_BRUSH = new Brush(wxMEDIUM_GREY_BRUSH_Get());
		public static Brush wxLIGHT_GREY_BRUSH = new Brush(wxLIGHT_GREY_BRUSH_Get());
		public static Brush wxTRANSPARENT_BRUSH = new Brush(wxTRANSPARENT_BRUSH_Get());
		public static Brush wxCYAN_BRUSH = new Brush(wxCYAN_BRUSH_Get());
		public static Brush wxRED_BRUSH = new Brush(wxRED_BRUSH_Get());
	}
	
	//-----------------------------------------------------------------------------
	
	public class NullObjects
	{
		[DllImport("wx-c")] static extern IntPtr wxNullBitmap_Get();
		[DllImport("wx-c")] static extern IntPtr wxNullIcon_Get();
		[DllImport("wx-c")] static extern IntPtr wxNullCursor_Get();
		[DllImport("wx-c")] static extern IntPtr wxNullPen_Get();
		[DllImport("wx-c")] static extern IntPtr wxNullBrush_Get();
		[DllImport("wx-c")] static extern IntPtr wxNullPalette_Get();
		[DllImport("wx-c")] static extern IntPtr wxNullFont_Get();
		[DllImport("wx-c")] static extern IntPtr wxNullColour_Get();
		
		public static wx.Bitmap wxNullBitmap = new wx.Bitmap(wxNullBitmap_Get());
		public static Icon wxNullIcon = new Icon(wxNullIcon_Get());
		public static Cursor wxNullCursor = new Cursor(wxNullCursor_Get());
		public static Pen wxNullPen = new Pen(wxNullPen_Get());
		public static Brush wxNullBrush = new Brush(wxNullBrush_Get());
		public static Palette wxNullPalette = new Palette(wxNullPalette_Get());
		public static Font wxNullFont = new Font(wxNullFont_Get());
		public static Colour wxNullColour = new Colour(wxNullColour_Get());
	}

	//-----------------------------------------------------------------------------

	public class ColourDatabase : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxColourDatabase_ctor();
		[DllImport("wx-c")] static extern void wxColourDataBase_dtor(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxColourDatabase_Find(IntPtr self, string name);
		[DllImport("wx-c")] static extern IntPtr wxColourDatabase_FindName(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern void wxColourDatabase_AddColour(IntPtr self, string name, IntPtr colour);
		
		//-----------------------------------------------------------------------------
	
		public ColourDatabase(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal ColourDatabase(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public ColourDatabase()
			: this(wxColourDatabase_ctor(), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxColourDataBase_dtor(wxObject);
						memOwn = false;
					}
				}
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~ColourDatabase() 
		{
			Dispose();
		}
			
		//-----------------------------------------------------------------------------
			
		public Colour Find(string name)
		{
			return new Colour(wxColourDatabase_Find(wxObject, name), true);
		}
		
		//-----------------------------------------------------------------------------
		
		public string FindName(Colour colour)
		{
			return new wxString(wxColourDatabase_FindName(wxObject, Object.SafePtr(colour)), true);
		}
		
		//-----------------------------------------------------------------------------
		
		public void AddColour(string name, Colour colour)
		{
			wxColourDatabase_AddColour(wxObject, name, Object.SafePtr(colour));
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class PenList : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxPenList_ctor();
		[DllImport("wx-c")] static extern void wxPenList_AddPen(IntPtr self, IntPtr pen);
		[DllImport("wx-c")] static extern void wxPenList_RemovePen(IntPtr self, IntPtr pen);
		[DllImport("wx-c")] static extern IntPtr wxPenList_FindOrCreatePen(IntPtr self, IntPtr colour, int width, int style);
		
		//-----------------------------------------------------------------------------
	
		public PenList(IntPtr wxObject)
			: base(wxObject) {}
			
		public PenList()
			: base(wxPenList_ctor()) {}
			
		//-----------------------------------------------------------------------------
			
		public void AddPen(Pen pen)
		{
			wxPenList_AddPen(wxObject, Object.SafePtr(pen));
		}
		
		//-----------------------------------------------------------------------------
		
		public void RemovePen(Pen pen)
		{
			wxPenList_RemovePen(wxObject, Object.SafePtr(pen));
		}
		
		//-----------------------------------------------------------------------------
		
		public Pen FindOrCreatePen(Colour colour, int width, int style)
		{
			return new Pen(wxPenList_FindOrCreatePen(wxObject, Object.SafePtr(colour), width, style));
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class BrushList : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxBrushList_ctor();
		[DllImport("wx-c")] static extern void wxBrushList_AddBrush(IntPtr self, IntPtr brush);
		[DllImport("wx-c")] static extern void wxBrushList_RemoveBrush(IntPtr self, IntPtr brush);
		[DllImport("wx-c")] static extern IntPtr wxBrushList_FindOrCreateBrush(IntPtr self, IntPtr colour, int style);
		
		//-----------------------------------------------------------------------------
	
		public BrushList(IntPtr wxObject)
			: base(wxObject) {}
			
		public BrushList()
			: base(wxBrushList_ctor()) {}
			
		//-----------------------------------------------------------------------------
			
		public void AddBrush(Brush brush)
		{
			wxBrushList_AddBrush(wxObject, Object.SafePtr(brush));
		}
		
		//-----------------------------------------------------------------------------
		
		public void RemoveBrush(Brush brush)
		{
			wxBrushList_RemoveBrush(wxObject, Object.SafePtr(brush));
		}
		
		//-----------------------------------------------------------------------------
		
		public Brush FindOrCreateBrush(Colour colour, int style)
		{
			return new Brush(wxBrushList_FindOrCreateBrush(wxObject, Object.SafePtr(colour), style));
		}
	}	
	
	//-----------------------------------------------------------------------------
	
	public class FontList : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxFontList_ctor();
		[DllImport("wx-c")] static extern void wxFontList_AddFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern void wxFontList_RemoveFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern IntPtr wxFontList_FindOrCreateFont(IntPtr self, 
			int pointSize, 
			int family, 
			int style, 
			int weight,
			bool underline,
			string face,
			FontEncoding encoding);
		
		//-----------------------------------------------------------------------------
	
		public FontList(IntPtr wxObject)
			: base(wxObject) {}
			
		public FontList()
			: base(wxFontList_ctor()) {}
			
		//-----------------------------------------------------------------------------
			
		public void AddFont(Font font)
		{
			wxFontList_AddFont(wxObject, Object.SafePtr(font));
		}
		
		//-----------------------------------------------------------------------------
		
		public void RemoveFont(Font font)
		{
			wxFontList_RemoveFont(wxObject, Object.SafePtr(font));
		}
		
		//-----------------------------------------------------------------------------
		
		public Font FindOrCreateFont(int pointSize, int family, int style, int weight)
		{
			return FindOrCreateFont(pointSize, family, style, weight, false, "", FontEncoding.wxFONTENCODING_DEFAULT);
		}
		
		public Font FindOrCreateFont(int pointSize, int family, int style, int weight, bool underline)
		{
			return FindOrCreateFont(pointSize, family, style, weight, underline, "", FontEncoding.wxFONTENCODING_DEFAULT);
		}

		public Font FindOrCreateFont(int pointSize, int family, int style, int weight, bool underline, string face)
		{
			return FindOrCreateFont(pointSize, family, style, weight, underline, face, FontEncoding.wxFONTENCODING_DEFAULT);
		}
		
		
		public Font FindOrCreateFont(int pointSize, int family, int style, int weight, bool underline, string face, FontEncoding encoding)
		{
			return new Font(wxFontList_FindOrCreateFont(wxObject, pointSize, family, style, weight, underline, face, encoding));
		}
	}		
	
	//-----------------------------------------------------------------------------
	
	public class BitmapList : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxBitmapList_ctor();
		[DllImport("wx-c")] static extern void   wxBitmapList_AddBitmap(IntPtr self, IntPtr bitmap);
		[DllImport("wx-c")] static extern void   wxBitmapList_RemoveBitmap(IntPtr self, IntPtr bitmap);
		
		//-----------------------------------------------------------------------------
		
		public BitmapList(IntPtr wxObject)
			: base(wxObject) {}
			
		public BitmapList()
			: base(wxBitmapList_ctor()) {}
			
		//-----------------------------------------------------------------------------
		
		public void AddBitmap(Bitmap bitmap)
		{
			wxBitmapList_AddBitmap(wxObject, Object.SafePtr(bitmap));
		}
		
		//-----------------------------------------------------------------------------
		
		public void RemoveBitmap(Bitmap bitmap)
		{
			wxBitmapList_RemoveBitmap(wxObject, Object.SafePtr(bitmap));
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public struct StockCursors
	{
		[DllImport("wx-c")] static extern IntPtr wxSTANDARD_CURSOR_Get();
		[DllImport("wx-c")] static extern IntPtr wxHOURGLASS_CURSOR_Get();
		[DllImport("wx-c")] static extern IntPtr wxCROSS_CURSOR_Get();
		
		//-----------------------------------------------------------------------------
		
		public static Cursor wxSTANDARD_CURSOR = new Cursor(wxSTANDARD_CURSOR_Get());
		public static Cursor wxHOURGLASS_CURSOR = new Cursor(wxHOURGLASS_CURSOR_Get());
		public static Cursor wxCROSS_CURSOR = new Cursor(wxCROSS_CURSOR_Get());
	}
}

