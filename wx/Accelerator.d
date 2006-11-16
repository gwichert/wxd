//-----------------------------------------------------------------------------
// wx.NET - Accelerator.cs
//
// The wxAccelerator* interfaces
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
	public class AcceleratorEntry : Object
	{
		public const int wxACCEL_NORMAL	= 0x0000;
		public const int wxACCEL_ALT	= 0x0001;
		public const int wxACCEL_CTRL	= 0x0002;
		public const int wxACCEL_SHIFT	= 0x0004;
		
		//-----------------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxAcceleratorEntry_ctor(int flags, int keyCode, int cmd, IntPtr item);
		[DllImport("wx-c")] static extern void   wxAcceleratorEntry_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxAcceleratorEntry_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxAcceleratorEntry_Set(IntPtr self, int flags, int keyCode, int cmd, IntPtr item);
		[DllImport("wx-c")] static extern void   wxAcceleratorEntry_SetMenuItem(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern int    wxAcceleratorEntry_GetFlags(IntPtr self);
		[DllImport("wx-c")] static extern int    wxAcceleratorEntry_GetKeyCode(IntPtr self);
		[DllImport("wx-c")] static extern int    wxAcceleratorEntry_GetCommand(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxAcceleratorEntry_GetMenuItem(IntPtr self);
		
		[DllImport("wx-c")] static extern IntPtr wxAcceleratorEntry_GetAccelFromString(string label);
		
		//-----------------------------------------------------------------------------
		
		public AcceleratorEntry(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
			
		internal AcceleratorEntry(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public AcceleratorEntry()
			: this(0, 0, 0, null) {}
		
		public AcceleratorEntry(int flags)
			: this(flags, 0, 0, null) {}
			
		public AcceleratorEntry(int flags, int keyCode)
			: this(flags, keyCode, 0, null) {}
			
		public AcceleratorEntry(int flags, int keyCode, int cmd)
			: this(flags, keyCode, cmd, null) {}
			
		public AcceleratorEntry(int flags, int keyCode, int cmd, MenuItem item)
			: this(wxAcceleratorEntry_ctor(flags, keyCode, cmd, Object.SafePtr(item)), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxAcceleratorEntry_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		//---------------------------------------------------------------------

		internal static IntPtr SafePtr(AcceleratorEntry obj)
		{
			return (obj == null) ? IntPtr.Zero : obj.wxObject;
		}
			
		//-----------------------------------------------------------------------------
		
		public void Set(int flags, int keyCode, int cmd)
		{
			Set(flags, keyCode, cmd);
		}
		
		public void Set(int flags, int keyCode, int cmd, MenuItem item)
		{
			wxAcceleratorEntry_Set(wxObject, flags, keyCode, cmd, Object.SafePtr(item));
		}
		
		//-----------------------------------------------------------------------------
		
		public MenuItem MenuItem
		{
			set { wxAcceleratorEntry_SetMenuItem(wxObject, Object.SafePtr(value)); }
			get { return (MenuItem)Object.FindObject(wxAcceleratorEntry_GetMenuItem(wxObject), typeof(MenuItem)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int Flags
		{
			get { return wxAcceleratorEntry_GetFlags(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int KeyCode
		{
			get { return wxAcceleratorEntry_GetKeyCode(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int Command
		{
			get { return wxAcceleratorEntry_GetCommand(wxObject); }
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
						wxAcceleratorEntry_dtor(wxObject);
						memOwn = false;
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
		
		~AcceleratorEntry() 
		{
			Dispose();
		}
		
		//---------------------------------------------------------------------
		
		public static AcceleratorEntry GetAccelFromString(string label)
		{
			return (AcceleratorEntry)Object.FindObject(wxAcceleratorEntry_GetAccelFromString(label), typeof(AcceleratorEntry));
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class AcceleratorTable : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxAcceleratorTable_ctor();
		[DllImport("wx-c")] static extern bool   wxAcceleratorTable_Ok(IntPtr self);
		//[DllImport("wx-c")] static extern void   wxAcceleratorTable_Add(IntPtr self, IntPtr entry);
		//[DllImport("wx-c")] static extern void   wxAcceleratorTable_Remove(IntPtr self, IntPtr entry);
		//[DllImport("wx-c")] static extern IntPtr wxAcceleratorTable_GetMenuItem(IntPtr self, IntPtr evt);
		//[DllImport("wx-c")] static extern int    wxAcceleratorTable_GetCommand(IntPtr self, IntPtr evt);
		//[DllImport("wx-c")] static extern IntPtr wxAcceleratorTable_GetEntry(IntPtr self, IntPtr evt);
		
		//-----------------------------------------------------------------------------
		
		public AcceleratorTable(IntPtr wxObject)
			: base(wxObject) {}
			
		public AcceleratorTable()
			: this(wxAcceleratorTable_ctor()) {}
			
		#if ! __WXMAC__
		//-----------------------------------------------------------------------------
		
		/*public void Add(AcceleratorEntry entry)
		{
			wxAcceleratorTable_Add(wxObject, Object.SafePtr(entry));
		}*/
		
		//-----------------------------------------------------------------------------
		
		/*public void Remove(AcceleratorEntry entry)
		{
			wxAcceleratorTable_Remove(wxObject, Object.SafePtr(entry));
		}*/
		
		//-----------------------------------------------------------------------------
		
		/*public MenuItem GetMenuItem(KeyEvent evt)
		{
			return (MenuItem)FindObject(wxAcceleratorTable_GetMenuItem(wxObject, Object.SafePtr(evt)), typeof(MenuItem));
		}*/
		
		//-----------------------------------------------------------------------------
		
		/*public AcceleratorEntry GetEntry(KeyEvent evt)
		{
			return (AcceleratorEntry)Object.FindObject(wxAcceleratorTable_GetEntry(wxObject, Object.SafePtr(evt)), typeof(AcceleratorEntry));
		}*/
		#endif
		
		//-----------------------------------------------------------------------------
		
		/*public int GetCommand(KeyEvent evt)
		{
			return wxAcceleratorTable_GetCommand(wxObject, Object.SafePtr(evt));
		}*/
		
		//-----------------------------------------------------------------------------
		
		public bool Ok
		{
			get { return wxAcceleratorTable_Ok(wxObject); }
		}
	}
}

