//-----------------------------------------------------------------------------
// wx.NET - Utils.cs
//
// Common Utils wrapper classes.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class Utils
    {
		[DllImport("wx-c")] static extern IntPtr wxGlobal_GetHomeDir();

		public static string GetHomeDir()
		{
			return new wxString(wxGlobal_GetHomeDir(), true);
		}
		
		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern void wxSleep_func(int num);

		public static void wxSleep(int num)
		{
			wxSleep_func(num);
		}
		
		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern void wxYield_func();

		public static void wxYield()
		{
			wxYield_func();
		}
		
		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern void wxBeginBusyCursor_func();

		public static void BeginBusyCursor()
		{
			wxBeginBusyCursor_func();
		}

		[DllImport("wx-c")] static extern void wxEndBusyCursor_func();

		public static void EndBusyCursor()
		{
			wxEndBusyCursor_func();
		}
		
		//---------------------------------------------------------------------
		
		[DllImport("wx-c")] static extern void wxMutexGuiEnter_func();
		
		public static void MutexGuiEnter()
		{
			wxMutexGuiEnter_func();
		}
		
		[DllImport("wx-c")] static extern void wxMutexGuiLeave_func();
		
		public static void MutexGuiLeave()
		{
			wxMutexGuiLeave_func();
		}
		
			
		//-----------------------------------------------------------------------------

	        [DllImport("wx-c")] static extern int wxGetSingleChoiceIndex_func(string message, string caption, int n, string[] choices, IntPtr parent, int x, int y, bool centre, int width, int height);

        	//-----------------------------------------------------------------------------

		public static int GetSingleChoiceIndex(string message, string caption, string[] choices)
		{
			return wxGetSingleChoiceIndex_func(message, caption, choices.Length, choices, IntPtr.Zero, -1, -1, true, 200, 150);
		}

        	//-----------------------------------------------------------------------------

		public static int GetSingleChoiceIndex(string message, string caption, string[] choices, Window parent, int x, int y, bool centre, int width, int height)
		{
			return wxGetSingleChoiceIndex_func(message, caption, choices.Length, choices, Object.SafePtr(parent), x, y, centre, width, height);
		}
	}
	
	//---------------------------------------------------------------------

	public class BusyCursor : IDisposable
	{
		public BusyCursor()
		{
			Utils.BeginBusyCursor();
		}
	
		~BusyCursor()
		{
			Utils.EndBusyCursor();
		}
	
		public void Dispose()
		{
			Utils.EndBusyCursor();
		}
	}
	
	//---------------------------------------------------------------------

	public class WindowDisabler : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxWindowDisabler_ctor(IntPtr winToSkip);
		[DllImport("wx-c")] static extern void wxWindowDisabler_dtor(IntPtr self);
		
		//---------------------------------------------------------------------

		public WindowDisabler(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
		
		internal WindowDisabler(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public WindowDisabler()
			: this(null) {}

		public WindowDisabler(Window winToSkip)
			: this(wxWindowDisabler_ctor(Object.SafePtr(winToSkip)), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxWindowDisabler_dtor(wxObject);
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
		
		~WindowDisabler() 
		{
			Dispose();
		}
	}
	
	//---------------------------------------------------------------------

	public class BusyInfo : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxBusyInfo_ctor(string message, IntPtr parent);
		[DllImport("wx-c")] static extern void   wxBusyInfo_dtor(IntPtr self);
		
		//---------------------------------------------------------------------
	
		public BusyInfo(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
	
		public BusyInfo(string message)
			: this(message, null) {}
	
		public BusyInfo(string message, Window parent)
			: this(wxBusyInfo_ctor(message, Object.SafePtr(parent)), true) {}
			
		internal BusyInfo(IntPtr wxObject, bool memOwn)
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
						wxBusyInfo_dtor(wxObject);
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
		
		~BusyInfo() 
		{
			Dispose();
		}
	}
	
	//---------------------------------------------------------------------

	public class FileSelector
	{
		public const int wxCHANGE_DIR        = 0x0040;

		private string value = "";
		
		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxGlobal_FileSelector(string message, string default_path, string default_filename, string default_extension, string wildcard, int flags, IntPtr self, int x, int y);
		
		//---------------------------------------------------------------------

		public FileSelector()
			: this("Select a file", null, null, null, "*", 0, null, -1, -1) {}
	
		public FileSelector(string message)
			: this(message, null, null, null, "*", 0, null, -1, -1) {}
	
		public FileSelector(string message, string default_path)
			: this(message, default_path, null, null, "*", 0, null, -1, -1) {}
	
		public FileSelector(string message, string default_path, string default_filename)
			: this(message, default_path, default_filename, null, "*", 0, null, -1, -1) {}
	
		public FileSelector(string message, string default_path, string default_filename, string default_extension)
			: this(message, default_path, default_filename, default_extension, "*", 0, null, -1, -1) {}
	
		public FileSelector(string message, string default_path, string default_filename, string default_extension, string wildcard)
			: this(message, default_path, default_filename, default_extension, wildcard, 0, null, -1, -1) {}
	
		public FileSelector(string message, string default_path, string default_filename, string default_extension, string wildcard, int flags)
			: this(message, default_path, default_filename, default_extension, wildcard, flags, null, -1, -1) {}
	
		public FileSelector(string message, string default_path, string default_filename, string default_extension, string wildcard, int flags, Window parent)
			: this(message, default_path, default_filename, default_extension, wildcard, flags, parent, -1, -1) {}
	
		public FileSelector(string message, string default_path, string default_filename, string default_extension, string wildcard, int flags, Window parent, int x)
			: this(message, default_path, default_filename, default_extension, wildcard, flags, parent, x, -1) {}
	
		public FileSelector(string message, string default_path, string default_filename, string default_extension, string wildcard, int flags, Window parent, int x, int y)
		{
			value = new wxString(wxGlobal_FileSelector(message, default_path, default_filename, default_extension, wildcard, flags, Object.SafePtr(parent), x, y), true);
		}
		
		//---------------------------------------------------------------------
	
		public static implicit operator string(FileSelector f)
		{
			return f.value;
		}
	}
	
	//---------------------------------------------------------------------

	public class ArrayInt : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxArrayInt_ctor();
		[DllImport("wx-c")] static extern void   wxArrayInt_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxArrayInt_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxArrayInt_Add(IntPtr self, int toadd);
		[DllImport("wx-c")] static extern int    wxArrayInt_Item(IntPtr self, int num);
		[DllImport("wx-c")] static extern int    wxArrayInt_GetCount(IntPtr self);
		
		//---------------------------------------------------------------------

		public ArrayInt(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
			
		internal ArrayInt(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public ArrayInt()
			: this(wxArrayInt_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxArrayInt_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		//---------------------------------------------------------------------

		public static implicit operator int[] (ArrayInt ari)
		{
			int[] tmpi = new int[ari.Count];
			for (int i = 0; i < ari.Count; i++)
				tmpi[i] = ari.Item(i);
			return tmpi;
		}

		public void Add(int toadd)
		{
			wxArrayInt_Add(wxObject, toadd);
		}

		public int Item(int num)
		{
			return wxArrayInt_Item(wxObject, num);
		}

		public int Count
		{
			get { return wxArrayInt_GetCount(wxObject); }
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
						wxArrayInt_dtor(wxObject);
					}
				}
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			virtual_Dispose = null;
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~ArrayInt() 
		{
			Dispose();
		}
	}
	
	//---------------------------------------------------------------------

	public class ArrayString : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxArrayString_ctor();
		[DllImport("wx-c")] static extern void   wxArrayString_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxArrayString_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxArrayString_Add(IntPtr self, string toadd);
		[DllImport("wx-c")] static extern IntPtr wxArrayString_Item(IntPtr self, int num);
		[DllImport("wx-c")] static extern int    wxArrayString_GetCount(IntPtr self);
		
		//---------------------------------------------------------------------

		public ArrayString(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
			
		internal ArrayString(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public ArrayString()
			: this(wxArrayString_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxArrayString_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		//---------------------------------------------------------------------

		public static implicit operator string[] (ArrayString ars)
		{
			string[] tmps = new string[ars.Count];
			for (int i = 0; i < ars.Count; i++)
				tmps[i] = ars.Item(i);
			return tmps;
		}
	
		public string Item(int num)
		{
			return new wxString(wxArrayString_Item(wxObject, num), true);
		}	
	
		public void Add(string toadd)
		{
			wxArrayString_Add(wxObject, toadd);
		}

		public int Count
		{
			get { return wxArrayString_GetCount(wxObject); }
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
						wxArrayString_dtor(wxObject);
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
		
		~ArrayString() 
		{
			Dispose();
		}
	}
	
	//---------------------------------------------------------------------
	
	public class wxSize : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxSize_ctor(int x, int y);
		[DllImport("wx-c")] static extern void   wxSize_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSize_SetWidth(IntPtr self, int w);
		[DllImport("wx-c")] static extern void   wxSize_SetHeight(IntPtr self, int h);
		[DllImport("wx-c")] static extern int    wxSize_GetWidth(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSize_GetHeight(IntPtr self);

		//---------------------------------------------------------------------

		public wxSize(IntPtr wxObject)
			: base(wxObject)
		{ 
			this.wxObject = wxObject;
		}
		
		internal wxSize(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public wxSize()
			: this(0,0) {}
			
		public wxSize(Size s)
			: this(s.Width, s.Height) {}

		public wxSize(int x, int y)
			: this(wxSize_ctor(x, y), true) { }

		//---------------------------------------------------------------------

		public static implicit operator Size (wxSize size)
		{
			Size nsize = new Size();
			nsize.Width = size.Width;
			nsize.Height = size.Height;
			return nsize;
		}
		
		public int Width
		{
			get { return wxSize_GetWidth(wxObject); }
			set { wxSize_SetWidth(wxObject, value); }
		}
		
		public int Height
		{
			get { return wxSize_GetHeight(wxObject); }
			set { wxSize_SetHeight(wxObject, value); }
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
						wxSize_dtor(wxObject);
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
		
		~wxSize() 
		{
			Dispose();
		}
	}	
	
	//---------------------------------------------------------------------
	
	public class wxRect : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxRect_ctor(int x, int y, int w, int h);
		[DllImport("wx-c")] static extern void   wxRect_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxRect_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern int    wxRect_GetX(IntPtr self);
		[DllImport("wx-c")] static extern void   wxRect_SetX(IntPtr self, int x);
		[DllImport("wx-c")] static extern int    wxRect_GetY(IntPtr self);
		[DllImport("wx-c")] static extern void   wxRect_SetY(IntPtr self, int y);
		[DllImport("wx-c")] static extern int    wxRect_GetWidth(IntPtr self);
		[DllImport("wx-c")] static extern void   wxRect_SetWidth(IntPtr self, int w);
		[DllImport("wx-c")] static extern int    wxRect_GetHeight(IntPtr self);
		[DllImport("wx-c")] static extern void   wxRect_SetHeight(IntPtr self, int h);
		
		//---------------------------------------------------------------------

		public wxRect(IntPtr wxObject)
			: base(wxObject)
		{ 
			this.wxObject = wxObject;
		}
		
		internal wxRect(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public wxRect()
			: this(0,0,0,0) {}
			
		public wxRect(Rectangle r)
			: this(r.X, r.Y, r.Width, r.Height) {}

		public wxRect(int x, int y, int w, int h)
			: this(wxRect_ctor(x, y, w, h), true) 
		{ 
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxRect_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		//---------------------------------------------------------------------

		public static implicit operator Rectangle (wxRect rect)
		{
			Rectangle nrect = new Rectangle();
			nrect.X = rect.X;
			nrect.Y = rect.Y;
			nrect.Width = rect.Width;
			nrect.Height = rect.Height;
			return nrect;
		}
		
		public int X
		{
			get { return wxRect_GetX(wxObject); }
			set { wxRect_SetX(wxObject, value); }
		}
		
		public int Y
		{
			get { return wxRect_GetY(wxObject); }
			set { wxRect_SetY(wxObject, value); }
		}		
		
		public int Width
		{
			get { return wxRect_GetWidth(wxObject); }
			set { wxRect_SetWidth(wxObject, value); }
		}
		
		public int Height
		{
			get { return wxRect_GetHeight(wxObject); }
			set { wxRect_SetHeight(wxObject, value); }
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
						wxRect_dtor(wxObject);
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
		
		~wxRect() 
		{
			Dispose();
		}
	}	
}
