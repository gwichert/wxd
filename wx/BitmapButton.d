//-----------------------------------------------------------------------------
// wx.NET - BitmapButton.cs
//
// The wxBitmapButton wrapper class.
//
// Written by Robert Roebling
// (C) 2003 Robert Roebling
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class BitmapButton : Control
	{
		private delegate void Virtual_OnSetBitmap();
		
		[DllImport("wx-c")] static extern IntPtr wxBitmapButton_ctor();
		[DllImport("wx-c")] static extern void   wxBitmapButton_RegisterVirtual(IntPtr self, Virtual_OnSetBitmap onSetBitmap);
		//[DllImport("wx-c")] static extern void   wxBitmapButton_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern bool   wxBitmapButton_Create(IntPtr self, IntPtr parent, int id, IntPtr label, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern void   wxBitmapButton_SetDefault(IntPtr self);
		
		[DllImport("wx-c")] static extern void wxBitmapButton_SetLabel(IntPtr self, string label);
		[DllImport("wx-c")] static extern IntPtr wxBitmapButton_GetLabel(IntPtr self);
		
		[DllImport("wx-c")] static extern bool wxBitmapButton_Enable(IntPtr self, bool enable);

		[DllImport("wx-c")] static extern void   wxBitmapButton_SetBitmapLabel(IntPtr self, IntPtr bitmap);
		[DllImport("wx-c")] static extern IntPtr wxBitmapButton_GetBitmapLabel(IntPtr self);
		
		[DllImport("wx-c")] static extern void wxBitmapButton_SetBitmapSelected(IntPtr self, IntPtr bitmap);
		[DllImport("wx-c")] static extern IntPtr wxBitmapButton_GetBitmapSelected(IntPtr self);

		[DllImport("wx-c")] static extern void wxBitmapButton_SetBitmapFocus(IntPtr self, IntPtr bitmap);
		[DllImport("wx-c")] static extern IntPtr wxBitmapButton_GetBitmapFocus(IntPtr self);

		[DllImport("wx-c")] static extern void wxBitmapButton_SetBitmapDisabled(IntPtr self, IntPtr bitmap);
		[DllImport("wx-c")] static extern IntPtr wxBitmapButton_GetBitmapDisabled(IntPtr self);
		
		[DllImport("wx-c")] static extern void wxBitmapButton_OnSetBitmap(IntPtr self);
		
		[DllImport("wx-c")] static extern void wxBitmapButton_ApplyParentThemeBackground(IntPtr self, IntPtr colour);

		//---------------------------------------------------------------------
		
		public BitmapButton(IntPtr wxObject) 
			: base(wxObject) { }

		public BitmapButton()
			: this(wxBitmapButton_ctor()) 
		{
			wxBitmapButton_RegisterVirtual(wxObject, new Virtual_OnSetBitmap(OnSetBitmap));
		}

		public BitmapButton(Window parent, int id, Bitmap label)
			: this(parent, id, label, wxDefaultPosition, wxDefaultSize, 0, null, null)	{ }

		public BitmapButton(Window parent, int id, Bitmap label, Point pos)
			: this(parent, id, label, pos, wxDefaultSize, 0, null, null) { }

		public BitmapButton(Window parent, int id, Bitmap label, Point pos, Size size)
			: this(parent, id, label, pos, size, 0, null, null) { } 

		public BitmapButton(Window parent, int id, Bitmap label, Point pos, Size size, long style)
			: this(parent, id, label, pos, size, style, null, null) { }

		public BitmapButton(Window parent, int id, Bitmap label, Point pos, Size size, long style, Validator validator)
			: this(parent, id, label, pos, size, style, validator, null) { }

		public BitmapButton(Window parent, int id, Bitmap label, Point pos, Size size, long style, Validator validator, string name)
			: this(wxBitmapButton_ctor())
		{
			wxBitmapButton_RegisterVirtual(wxObject, new Virtual_OnSetBitmap(OnSetBitmap));
			
			if (!Create(parent, id, label, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create BitmapButton");
			}
		}
			
		//---------------------------------------------------------------------
		// ctors with self created id
			
		public BitmapButton(Window parent, Bitmap label)
			: this(parent, Window.UniqueID, label, wxDefaultPosition, wxDefaultSize, 0, null, null)	{ }

		public BitmapButton(Window parent, Bitmap label, Point pos)
			: this(parent, Window.UniqueID, label, pos, wxDefaultSize, 0, null, null) { }

		public BitmapButton(Window parent, Bitmap label, Point pos, Size size)
			: this(parent, Window.UniqueID, label, pos, size, 0, null, null) { } 

		public BitmapButton(Window parent, Bitmap label, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, label, pos, size, style, null, null) { }

		public BitmapButton(Window parent, Bitmap label, Point pos, Size size, long style, Validator validator)
			: this(parent, Window.UniqueID, label, pos, size, style, validator, null) { }

		public BitmapButton(Window parent, Bitmap label, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, label, pos, size, style, validator, name) {}

		//---------------------------------------------------------------------
		
		public bool Create(Window parent, int id, Bitmap label, Point pos, Size size, long style, Validator validator, string name)
		{
			return wxBitmapButton_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(label), ref pos, ref size, (uint)style, Object.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------		

		public void SetDefault()
		{
			wxBitmapButton_SetDefault(wxObject);
		}
		
		//---------------------------------------------------------------------		
		
		public string StringLabel
		{
			get { return new wxString(wxBitmapButton_GetLabel(wxObject), true); }
			set { wxBitmapButton_SetLabel(wxObject, value); }
		}
		
		public void SetLabel(string label)
		{
			wxBitmapButton_SetLabel(wxObject, label);
		}
		
		public string GetLabel()
		{
			return new wxString(wxBitmapButton_GetLabel(wxObject), true);
		}
		
		//---------------------------------------------------------------------
		
		public bool Enable()
		{
			return Enable(true);
		}
		
		public bool Enable(bool enable)
		{
			return wxBitmapButton_Enable(wxObject, enable);
		}

		//---------------------------------------------------------------------

		public wx.Bitmap BitmapLabel
		{
			get { return (wx.Bitmap)FindObject(wxBitmapButton_GetBitmapLabel(wxObject), typeof(Bitmap)); }
			set { wxBitmapButton_SetBitmapLabel(wxObject, Object.SafePtr(value)); }
		}

		public new wx.Bitmap Label
		{
			get { return (wx.Bitmap)FindObject(wxBitmapButton_GetBitmapLabel(wxObject), typeof(Bitmap)); }
			set { wxBitmapButton_SetBitmapLabel(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Bitmap BitmapSelected
		{
			get { return (wx.Bitmap)FindObject(wxBitmapButton_GetBitmapSelected(wxObject), typeof(Bitmap)); }
			set { wxBitmapButton_SetBitmapSelected(wxObject, Object.SafePtr(value)); }
		}
		
		public Bitmap BitmapFocus
		{
			get { return (wx.Bitmap)FindObject(wxBitmapButton_GetBitmapFocus(wxObject), typeof(Bitmap)); }
			set { wxBitmapButton_SetBitmapFocus(wxObject, Object.SafePtr(value)); }
		}

		public Bitmap BitmapDisabled
		{
			get { return (wx.Bitmap)FindObject(wxBitmapButton_GetBitmapDisabled(wxObject), typeof(Bitmap)); }
			set { wxBitmapButton_SetBitmapDisabled(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------
		
		protected virtual void OnSetBitmap()
		{
			wxBitmapButton_OnSetBitmap(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public virtual void ApplyParentThemeBackground(Colour bg)
		{
			wxBitmapButton_ApplyParentThemeBackground(wxObject, Object.SafePtr(bg));
		}
	}
}
