//-----------------------------------------------------------------------------
// wx.NET - Fontdlg.cs
// 
// The wxFontDialog wrapper class.
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
    public class FontData : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxFontData_ctor();
		[DllImport("wx-c")] static extern void   wxFontData_dtor(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFontData_SetAllowSymbols(IntPtr self, bool flag);
		[DllImport("wx-c")] static extern bool   wxFontData_GetAllowSymbols(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFontData_SetColour(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxFontData_GetColour(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFontData_SetShowHelp(IntPtr self, bool flag);
		[DllImport("wx-c")] static extern bool   wxFontData_GetShowHelp(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFontData_EnableEffects(IntPtr self, bool flag);
		[DllImport("wx-c")] static extern bool   wxFontData_GetEnableEffects(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFontData_SetInitialFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern IntPtr wxFontData_GetInitialFont(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFontData_SetChosenFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern IntPtr wxFontData_GetChosenFont(IntPtr self);

		[DllImport("wx-c")] static extern void   wxFontData_SetRange(IntPtr self, int minRange, int maxRange);

        //---------------------------------------------------------------------

        public FontData(IntPtr wxObject) 
            : base(wxObject) { }

        public FontData()
            : base(wxFontData_ctor()) { }

        //---------------------------------------------------------------------

        public bool AllowSymbols
        {
            get { return wxFontData_GetAllowSymbols(wxObject); }
            set { wxFontData_SetAllowSymbols(wxObject, value); }
        }

        //---------------------------------------------------------------------

        public bool EffectsEnabled
        {
            get { return wxFontData_GetEnableEffects(wxObject); }
            set { wxFontData_EnableEffects(wxObject, value); }
        }

        //---------------------------------------------------------------------

        public bool ShowHelp
        {
            get { return wxFontData_GetShowHelp(wxObject); }
            set { wxFontData_SetShowHelp(wxObject, value); }
        }

        //---------------------------------------------------------------------

        public Colour Colour
        {
            get 
            {
                return new Colour(wxFontData_GetColour(wxObject), true);
            }
            set 
            {
                wxFontData_SetColour(wxObject, Object.SafePtr(value)); 
            }
        }

        //---------------------------------------------------------------------
        
        public Font InitialFont
        {
            get
            {
                return new Font(wxFontData_GetInitialFont(wxObject));
            }
            set
            {
                wxFontData_SetInitialFont(wxObject, Object.SafePtr(value));
            }
        }

        //---------------------------------------------------------------------

        public Font ChosenFont
        {
            get
            {
                return new Font(wxFontData_GetChosenFont(wxObject));
            }
            set
            {
                wxFontData_SetChosenFont(wxObject, Object.SafePtr(value));
            }
        }

        //---------------------------------------------------------------------

        public void SetRange(int min, int max)
        {
            wxFontData_SetRange(wxObject, min, max);
        }

        //---------------------------------------------------------------------
    }

	public class FontDialog : Dialog
	{
		[DllImport("wx-c")] static extern IntPtr wxFontDialog_ctor();
		[DllImport("wx-c")] static extern bool   wxFontDialog_Create(IntPtr self, IntPtr parent, IntPtr data);
		[DllImport("wx-c")] static extern void   wxFontDialog_dtor(IntPtr self);

		[DllImport("wx-c")] static extern int    wxFontDialog_ShowModal(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxFontDialog_GetFontData(IntPtr self);

        //---------------------------------------------------------------------

        public FontDialog(IntPtr wxObject)
            : base(wxObject) { }

        public FontDialog()
            : base(wxFontDialog_ctor()) { }

        public FontDialog(Window parent)
            : this(parent, null) { }

        public FontDialog(Window parent, FontData data)
            : this()
        {
            if (!Create(parent, data)) 
            {
                throw new InvalidOperationException("Failed to create FontDialog");
            }
        }

        public bool Create(Window parent, FontData data)
        {
            return wxFontDialog_Create(wxObject, Object.SafePtr(parent), Object.SafePtr(data));
        }

        //---------------------------------------------------------------------

        public FontData FontData
        {
            get
            {
                IntPtr ptr = wxFontDialog_GetFontData(wxObject);
                return (FontData)FindObject(ptr, typeof(FontData));
            }
        }

        //---------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxFontDialog_ShowModal(wxObject);
        }

        //---------------------------------------------------------------------
	}

}
