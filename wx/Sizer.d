//-----------------------------------------------------------------------------
// wx.NET - Sizer.cs
//
// The wxSizer wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public abstract class Sizer : Object
	{
		[DllImport("wx-c")] static extern void wxSizer_AddWindow(IntPtr self, IntPtr window, int proportion, int flag, int border, IntPtr userData);
		[DllImport("wx-c")] static extern void wxSizer_AddSizer(IntPtr self, IntPtr sizer, int proportion, int flag, int border, IntPtr userData);
		[DllImport("wx-c")] static extern void wxSizer_Add(IntPtr self, int width, int height, int proportion, int flag, int border, IntPtr userData);

		[DllImport("wx-c")] static extern void wxSizer_Fit(IntPtr self, IntPtr window, ref Size size);
		[DllImport("wx-c")] static extern void wxSizer_FitInside(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern void wxSizer_Layout(IntPtr self);

		[DllImport("wx-c")] static extern void wxSizer_InsertWindow(IntPtr self, int before, IntPtr window, int option, uint flag, int border, IntPtr userData);
		[DllImport("wx-c")] static extern void wxSizer_InsertSizer(IntPtr self, int before, IntPtr sizer, int option, uint flag, int border, IntPtr userData);
		[DllImport("wx-c")] static extern void wxSizer_Insert(IntPtr self, int before, int width, int height, int option, uint flag, int border, IntPtr userData);

		[DllImport("wx-c")] static extern void wxSizer_PrependWindow(IntPtr self, IntPtr window, int option, uint flag, int border, IntPtr userData);
		[DllImport("wx-c")] static extern void wxSizer_PrependSizer(IntPtr self, IntPtr sizer, int option, uint flag, int border, IntPtr userData);
		[DllImport("wx-c")] static extern void wxSizer_Prepend(IntPtr self, int width, int height, int option, uint flag, int border, IntPtr userData);

		[DllImport("wx-c")] static extern bool wxSizer_RemoveWindow(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern bool wxSizer_RemoveSizer(IntPtr self, IntPtr sizer);
		[DllImport("wx-c")] static extern bool wxSizer_Remove(IntPtr self, int pos);

		[DllImport("wx-c")] static extern void wxSizer_Clear(IntPtr self, bool delete_windows);
		[DllImport("wx-c")] static extern void wxSizer_DeleteWindows(IntPtr self);

		[DllImport("wx-c")] static extern void wxSizer_SetMinSize(IntPtr self, ref Size size);

		[DllImport("wx-c")] static extern bool wxSizer_SetItemMinSizeWindow(IntPtr self, IntPtr window, ref Size size);
		[DllImport("wx-c")] static extern bool wxSizer_SetItemMinSizeSizer(IntPtr self, IntPtr sizer, ref Size size);
		[DllImport("wx-c")] static extern bool wxSizer_SetItemMinSize(IntPtr self, int pos, ref Size size);

		[DllImport("wx-c")] static extern void wxSizer_GetSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern void wxSizer_GetPosition(IntPtr self, out Point pt);
		[DllImport("wx-c")] static extern void wxSizer_GetMinSize(IntPtr self, out Size size);

		[DllImport("wx-c")] static extern void wxSizer_RecalcSizes(IntPtr self);
		[DllImport("wx-c")] static extern void wxSizer_CalcMin(IntPtr self, out Size size);

		[DllImport("wx-c")] static extern void wxSizer_SetSizeHints(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern void wxSizer_SetVirtualSizeHints(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern void wxSizer_SetDimension(IntPtr self, int x, int y, int width, int height);

		[DllImport("wx-c")] static extern void wxSizer_ShowWindow(IntPtr self, IntPtr window, bool show);
		[DllImport("wx-c")] static extern void wxSizer_HideWindow(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern void wxSizer_ShowSizer(IntPtr self, IntPtr sizer, bool show);
		[DllImport("wx-c")] static extern void wxSizer_HideSizer(IntPtr self, IntPtr sizer);

		[DllImport("wx-c")] static extern bool wxSizer_IsShownWindow(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern bool wxSizer_IsShownSizer(IntPtr self, IntPtr sizer);
		
		[DllImport("wx-c")] static extern bool wxSizer_Detach(IntPtr self, IntPtr window);
		[DllImport("wx-c")] static extern bool wxSizer_Detach2(IntPtr self, IntPtr sizer);
		[DllImport("wx.c")] static extern bool wxSizer_Detach3(IntPtr self, int index);

		//---------------------------------------------------------------------

		public Sizer(IntPtr wxObject)
			: base(wxObject) {}

		//---------------------------------------------------------------------

		public void Add(Window window)
		    { Add( window, 0, 0, 0, null); }
		public void Add(Window window, int proportion, long flag)
		    { Add( window, proportion, flag, 0, null); }
		public void Add(Window window, int proportion, long flag, int border)
		    { Add( window, proportion, flag, border, null); }
		public void Add(Window window, int proportion, long flag, int border, Object userData)
		{
			wxSizer_AddWindow(wxObject, Object.SafePtr(window), proportion, (int)flag,
							  border, Object.SafePtr(userData));
		}

		public void Add(Sizer sizer)
		    { Add( sizer, 0, 0, 0, null); }
		public void Add(Sizer sizer, int proportion, long flag)
		    { Add( sizer, proportion, flag, 0, null); }
		public void Add(Sizer sizer, int proportion, long flag, int border)
		    { Add( sizer, proportion, flag, border, null); }
		public void Add(Sizer sizer, int proportion, long flag, int border,	Object userData)
		{
			wxSizer_AddSizer(wxObject, Object.SafePtr(sizer), proportion, (int)flag,
							 border, Object.SafePtr(userData));
		}

		public void Add(int width, int height)
		    { Add( width, height, 0, 0, 0, null); }
		public void Add(int width, int height, int proportion, long flag, int border)
		    { Add( width, height, proportion, flag, border, null); }
		public void Add(int width, int height, int proportion, long flag, int border, Object userData)
		{
			wxSizer_Add(wxObject, width, height, proportion, (int)flag, border,
						Object.SafePtr(userData));
		}

		//---------------------------------------------------------------------

		public Size Fit(Window window)
		{
			Size size = new Size();
			wxSizer_Fit(wxObject, Object.SafePtr(window), ref size);
			return size;
		}

		public void FitInside(Window window)
		{
			wxSizer_FitInside(wxObject, Object.SafePtr(window));
		}

		public void Layout()
		{
			wxSizer_Layout(wxObject);
		}

		//---------------------------------------------------------------------

		public void Insert(int before, Window window, int option, long flag,
						   int border, Object userData)
		{
			wxSizer_InsertWindow(wxObject, before, Object.SafePtr(window),
								 option, (uint)flag, border,
								 Object.SafePtr(userData));
		}

		public void Insert(int before, Sizer sizer, int option, long flag,
						   int border, Object userData)
		{
			wxSizer_InsertSizer(wxObject, before, Object.SafePtr(sizer),
								option, (uint)flag, border,
								Object.SafePtr(userData));
		}

		public void Insert(int before, int width, int height, int option,
						   long flag, int border, Object userData)
		{
			wxSizer_Insert(wxObject, before, width, height, option, (uint)flag,
						   border, Object.SafePtr(userData));
		}

		//---------------------------------------------------------------------

		public void Prepend(Window window)
            { Prepend(window, 0, 0, 0, null); }
		public void Prepend(Window window, int option)
            { Prepend(window, option, 0, 0, null); }
		public void Prepend(Window window, int option, long flag)
            { Prepend(window, option, flag, 0, null); }
		public void Prepend(Window window, int option, long flag, int border)
            { Prepend(window, option, flag, border, null); }

		public void Prepend(Window window, int option, long flag, int border,
							Object userData)
		{
			wxSizer_PrependWindow(wxObject, Object.SafePtr(window), option,
								  (uint)flag, border, Object.SafePtr(userData));
		}

		public void Prepend(Sizer sizer, int option, long flag, int border,
							Object userData)
		{
			wxSizer_PrependSizer(wxObject, Object.SafePtr(sizer), option,
								 (uint)flag, border, Object.SafePtr(userData));
		}

		public void Prepend(int width, int height, int option, long flag,
						    int border, Object userData)
		{
			wxSizer_Prepend(wxObject, width, height, option,
							(uint)flag, border, Object.SafePtr(userData));
		}

		//---------------------------------------------------------------------

		public bool Remove(Window window)
		{
			return wxSizer_RemoveWindow(wxObject, Object.SafePtr(window));
		}

		public bool Remove(Sizer sizer)
		{
			return wxSizer_RemoveSizer(wxObject, Object.SafePtr(sizer));
		}

		public bool Remove(int pos)
		{
			return wxSizer_Remove(wxObject, pos);
		}

		//---------------------------------------------------------------------

		public void SetMinSize(Size size)
		{
			wxSizer_SetMinSize(wxObject, ref size);
		}

		//---------------------------------------------------------------------

		public bool SetItemMinSize(Window window, Size size)
		{
			return wxSizer_SetItemMinSizeWindow(wxObject, Object.SafePtr(window),
												ref size);
		}

		public bool SetItemMinSize(Sizer sizer, Size size)
		{
			return wxSizer_SetItemMinSizeSizer(wxObject, Object.SafePtr(sizer),
											   ref size);
		}

		public bool SetItemMinSize(int pos, Size size)
		{
			return wxSizer_SetItemMinSize(wxObject, pos, ref size);
		}

		//---------------------------------------------------------------------

		public Size Size
		{
			get
			{
				Size size = new Size();
				wxSizer_GetSize(wxObject, out size);
				return size;
			}
		}

		public Point Position
		{
			get
			{
				Point pt = new Point();
				wxSizer_GetPosition(wxObject, out pt);
				return pt;
			}
		}

		public Size MinSize
		{
			get
			{
				Size size = new Size();
				wxSizer_GetMinSize(wxObject, out size);
				return size;
			}
		}

		//---------------------------------------------------------------------

		public virtual void RecalcSizes()
		{
			wxSizer_RecalcSizes(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual Size CalcMin()
		{
			Size size = new Size();
			wxSizer_CalcMin(wxObject, out size);
			return size;
		}

		//---------------------------------------------------------------------

		public void SetSizeHints(Window window)
		{
			wxSizer_SetSizeHints(wxObject, Object.SafePtr(window));
		}

		public void SetVirtualSizeHints(Window window)
		{
			wxSizer_SetVirtualSizeHints(wxObject, Object.SafePtr(window));
		}

		public void SetDimension(int x, int y, int width, int height)
		{
			wxSizer_SetDimension(wxObject, x, y, width, height);
		}

		//---------------------------------------------------------------------

		public void Show(Window window, bool show)
		{
			wxSizer_ShowWindow(wxObject, Object.SafePtr(window), show);
		}

		public void Show(Sizer sizer, bool show)
		{
			wxSizer_ShowSizer(wxObject, Object.SafePtr(sizer), show);
		}

		// New to wx.NET
		public void Show(bool show)
		{
			Show(this, show);
		}


		//---------------------------------------------------------------------

		public void Clear(bool delete_windows)
		{
			wxSizer_Clear(wxObject, delete_windows);
		}

		public void DeleteWindows()
		{
			wxSizer_DeleteWindows(wxObject);
		}

		//---------------------------------------------------------------------

		public void Hide(Window window)
		{
			wxSizer_HideWindow(wxObject, Object.SafePtr(window));
		}

		public void Hide(Sizer sizer)
		{
			wxSizer_HideSizer(wxObject, Object.SafePtr(sizer));
		}

		//---------------------------------------------------------------------

		public bool IsShown(Window window)
		{
			return wxSizer_IsShownWindow(wxObject, Object.SafePtr(window));
		}

		public bool IsShown(Sizer sizer)
		{
			return wxSizer_IsShownSizer(wxObject, Object.SafePtr(sizer));
		}

		//---------------------------------------------------------------------
		
		public bool Detach(Window window)
		{
			return wxSizer_Detach(wxObject, Object.SafePtr(window));
		}
		
		public bool Detach(Sizer sizer)
		{
			return wxSizer_Detach2(wxObject, Object.SafePtr(sizer));
		}
		
		public bool Detach(int index)
		{
			return wxSizer_Detach3(wxObject, index);
		}
		
		//---------------------------------------------------------------------
	}
}
