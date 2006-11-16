//-----------------------------------------------------------------------------
// wx.NET - Caret.cs
//
// The wxCaret wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class Caret : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxCaret_ctor();
		[DllImport("wx-c")] static extern void wxCaret_dtor(IntPtr self);
		[DllImport("wx-c")] static extern bool wxCaret_Create(IntPtr self, IntPtr window, int width, int height);
		[DllImport("wx-c")] static extern bool wxCaret_IsOk(IntPtr self);
		[DllImport("wx-c")] static extern bool wxCaret_IsVisible(IntPtr self);
		[DllImport("wx-c")] static extern void wxCaret_GetPosition(IntPtr self, out int x, out int y);
		[DllImport("wx-c")] static extern void wxCaret_GetSize(IntPtr self, out int width, out int height);
		[DllImport("wx-c")] static extern IntPtr wxCaret_GetWindow(IntPtr self);
		[DllImport("wx-c")] static extern void wxCaret_SetSize(IntPtr self, int width, int height);
		[DllImport("wx-c")] static extern void wxCaret_Move(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void wxCaret_Show(IntPtr self, bool show);
		[DllImport("wx-c")] static extern void wxCaret_Hide(IntPtr self);
		[DllImport("wx-c")] static extern int wxCaret_GetBlinkTime();
		[DllImport("wx-c")] static extern void wxCaret_SetBlinkTime(int milliseconds);
		
		//---------------------------------------------------------------------

		public Caret()
			: this(wxCaret_ctor(), true) {}

		public Caret(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
		
		internal Caret(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public Caret(Window window, Size size)
			: this(window, size.Width, size.Height) {}

		public Caret(Window window, int width, int height)
			: this(wxCaret_ctor(), true)
		{
			if (!wxCaret_Create(wxObject, Object.SafePtr(window), width, height))
			{
				throw new InvalidOperationException("Failed to create Caret");
			}
		}
		
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxCaret_dtor(wxObject);
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
		
		~Caret() 
		{
			Dispose();
		}
		
		//---------------------------------------------------------------------

		public bool Create(Window window, int width, int height)
		{
			return wxCaret_Create(wxObject, Object.SafePtr(window), width, height);
		}

		//---------------------------------------------------------------------

		public bool IsOk
		{
			get { return wxCaret_IsOk(wxObject); }
		}

		public bool IsVisible
		{
			get { return wxCaret_IsVisible(wxObject); }
		}

		//---------------------------------------------------------------------

		public Point Position
		{
			get
			{
				int x, y;
				wxCaret_GetPosition(wxObject, out x, out y);
				return new Point(x, y);
			}
			set
			{
				wxCaret_Move(wxObject, value.X, value.Y);
			}
		}

		//---------------------------------------------------------------------

		public Size Size
		{
			get
			{
				int w, h;
				wxCaret_GetSize(wxObject, out w, out h);
				return new Size(w, h);
			}
			set
			{
				wxCaret_SetSize(wxObject, value.Width, value.Height);
			}
		}

		//---------------------------------------------------------------------

		public Window Window
		{
			get
			{
				return (Window)Object.FindObject(wxCaret_GetWindow(wxObject));
			}
		}

		//---------------------------------------------------------------------

		public void Show(bool show)
		{
			wxCaret_Show(wxObject, show);
		}

		public void Hide()
		{
			wxCaret_Hide(wxObject);
		}

		//---------------------------------------------------------------------

		public static int BlinkTime
		{
			get
			{
				return wxCaret_GetBlinkTime();
			}
			set
			{
				wxCaret_SetBlinkTime(value);
			}
		}

		//---------------------------------------------------------------------
	}

	public class CaretSuspend : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxCaretSuspend_ctor(IntPtr win);
		[DllImport("wx-c")] static extern void wxCaretSuspend_dtor(IntPtr self);
		
		//---------------------------------------------------------------------

		public CaretSuspend(Window win)
			: this(wxCaretSuspend_ctor(Object.SafePtr(win)), true) {}
		
		public CaretSuspend(IntPtr wxObject)
			: base(wxObject)
		{ 
			this.wxObject = wxObject;
		}
		
		internal CaretSuspend(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
		
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxCaretSuspend_dtor(wxObject);
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
		
		~CaretSuspend() 
		{
			Dispose();
		}
	}
}
