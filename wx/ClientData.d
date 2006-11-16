//-----------------------------------------------------------------------------
// wx.NET - ClientData.cs
//
// The wxClientData wrapper class.
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
	public class ClientData : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxClientData_ctor();
		[DllImport("wx-c")] static extern void wxClientData_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxClientData_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		
		//---------------------------------------------------------------------
        
		public ClientData(IntPtr wxObject)
			: base(wxObject) 
		{ 
			this.wxObject = wxObject;
		}
		
		internal ClientData(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public ClientData()
			: this(wxClientData_ctor(), true) 
		{ 
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxClientData_RegisterDisposable(wxObject, virtual_Dispose);
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
						wxClientData_dtor(wxObject);
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
		
		~ClientData() 
		{
			Dispose();
		}
	}
    
	//---------------------------------------------------------------------
    
	public class StringClientData : ClientData
	{
		[DllImport("wx-c")] static extern IntPtr wxStringClientData_ctor(string data);
		[DllImport("wx-c")] static extern void   wxStringClientData_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxStringClientData_SetData(IntPtr self, string data);
		[DllImport("wx-c")] static extern IntPtr wxStringClientData_GetData(IntPtr self);
		
		//---------------------------------------------------------------------
        
		public StringClientData()
			: this(wxStringClientData_ctor(""), true) { }
			
		public StringClientData(string data)
			: this(wxStringClientData_ctor(data), true) { }
			
		public StringClientData(IntPtr wxObject)
			: base(wxObject) 
		{ 
			this.wxObject = wxObject;
		}
			
		internal StringClientData(IntPtr wxObject, bool memOwn)
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
						wxStringClientData_dtor(wxObject);
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
		
		~StringClientData() 
		{
			Dispose();
		}

		//---------------------------------------------------------------------
		
		public string Data
		{
			get { return new wxString(wxStringClientData_GetData(wxObject), true); }
			set { wxStringClientData_SetData(wxObject, value); }
		}
	}
}

