//-----------------------------------------------------------------------------
// wx.NET - Clipboard.cs
//
// The wxClipboard wrapper class.
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
	public class Clipboard : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxClipboard_ctor();
		[DllImport("wx-c")] static extern bool   wxClipboard_Open(IntPtr self);
		[DllImport("wx-c")] static extern void   wxClipboard_Close(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxClipboard_IsOpened(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxClipboard_AddData(IntPtr self, IntPtr data);
		[DllImport("wx-c")] static extern bool   wxClipboard_SetData(IntPtr self, IntPtr data);
		[DllImport("wx-c")] static extern bool   wxClipboard_IsSupported(IntPtr self, IntPtr format);
		[DllImport("wx-c")] static extern bool   wxClipboard_GetData(IntPtr self, IntPtr data);
		[DllImport("wx-c")] static extern void   wxClipboard_Clear(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxClipboard_Flush(IntPtr self);
		[DllImport("wx-c")] static extern void   wxClipboard_UsePrimarySelection(IntPtr self, bool primary);

		//-----------------------------------------------------------------------------
		
		public Clipboard(IntPtr wxObject)
			: base(wxObject) {}

		public  Clipboard()
			: base(wxClipboard_ctor()) { }
		
		//-----------------------------------------------------------------------------

		public bool Open()
		{
			return wxClipboard_Open(wxObject);
		}

		public void Close()
		{
			wxClipboard_Close(wxObject);
		}

		//-----------------------------------------------------------------------------

		public bool IsOpened()
		{
			return wxClipboard_IsOpened(wxObject);
		}

		//-----------------------------------------------------------------------------

		public bool AddData(DataObject data)
		{
			return wxClipboard_AddData(wxObject, Object.SafePtr(data));
		}

		public bool SetData(DataObject data)
		{
			return wxClipboard_SetData(wxObject, Object.SafePtr(data));
		}

		public bool GetData(DataObject data)
		{
			return wxClipboard_GetData(wxObject, Object.SafePtr(data));
		}

		//-----------------------------------------------------------------------------

		public bool IsSupported(DataFormat format)
		{
			return wxClipboard_IsSupported(wxObject, Object.SafePtr(format));
		}

		//-----------------------------------------------------------------------------

		public void Clear()
		{
			wxClipboard_Clear(wxObject);
		}

		public bool Flush()
		{
			return wxClipboard_Flush(wxObject);
		}
		
		//-----------------------------------------------------------------------------
	
		public virtual void UsePrimarySelection(bool primary)
		{
			wxClipboard_UsePrimarySelection(wxObject, primary);
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class CTheClipboard : Clipboard
	{
		private static readonly Clipboard theClipboard = new CTheClipboard();
		
		//-----------------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxTheClipboard_static();
		
		//-----------------------------------------------------------------------------
	
		public CTheClipboard()
			: base(wxTheClipboard_static()) {}
			
		//-----------------------------------------------------------------------------
		
		public static Clipboard TheClipboard
		{
			get { return theClipboard; }
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class ClipboardLocker : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxClipboardLocker_ctor(IntPtr clipboard);
		[DllImport("wx-c")] static extern void   wxClipBoardLocker_dtor(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxClipboardLocker_IsOpen(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
		public ClipboardLocker(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
			
		internal ClipboardLocker(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
		
		public ClipboardLocker()
			: this(null) {}
			
		public ClipboardLocker(Clipboard clipboard)
			: this(wxClipboardLocker_ctor(Object.SafePtr(clipboard)), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxClipBoardLocker_dtor(wxObject);
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
		
		~ClipboardLocker() 
		{
			Dispose();
		}
			
		//-----------------------------------------------------------------------------
			
		public bool IsOpen
		{
			get { return wxClipboardLocker_IsOpen(wxObject); }
		}
	}
}
