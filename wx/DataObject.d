//-----------------------------------------------------------------------------
// wx.NET - Dataobj.cs
//
// The wxDataObject wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;

namespace wx
{
	public abstract class DataObject : Object
	{
		public enum DataDirection
		{
			Get = 0x01,
			Set = 0x02,
			Both = 0x03
		}
		
		//---------------------------------------------------------------------

		public DataObject(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal DataObject(IntPtr wxObject, bool memOwn)
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
		
		~DataObject() 
		{
			Dispose();
		}
	}
	
	//---------------------------------------------------------------------

	public class DataObjectSimple : DataObject
	{
		[DllImport("wx-c")] static extern IntPtr wxDataObjectSimple_ctor(IntPtr format);
		[DllImport("wx-c")] static extern void wxDataObjectSimple_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxDataObjectSimple_SetFormat(IntPtr self, IntPtr format);
		[DllImport("wx-c")] static extern uint wxDataObjectSimple_GetDataSize(IntPtr self);
		[DllImport("wx-c")] static extern bool wxDataObjectSimple_GetDataHere(IntPtr self, IntPtr buf);
		[DllImport("wx-c")] static extern bool wxDataObjectSimple_SetData(IntPtr self, uint len, IntPtr buf);
		
		//---------------------------------------------------------------------

		public DataObjectSimple(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
		
		internal DataObjectSimple(IntPtr wxObject, bool memOwn)
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
						wxDataObjectSimple_dtor(wxObject);
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
		
		~DataObjectSimple() 
		{
			Dispose();
		}
	}
	
	//---------------------------------------------------------------------

	public class TextDataObject : DataObjectSimple
	{
		[DllImport("wx-c")] static extern IntPtr wxTextDataObject_ctor(string text);
		[DllImport("wx-c")] static extern void wxTextDataObject_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxTextDataObject_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern int wxTextDataObject_GetTextLength(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTextDataObject_GetText(IntPtr self);
		[DllImport("wx-c")] static extern void wxTextDataObject_SetText(IntPtr self, string text);
		
		//---------------------------------------------------------------------

		public TextDataObject(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
			
		internal TextDataObject(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public TextDataObject()
			: this("") {}

		public TextDataObject(string text)
			: this(wxTextDataObject_ctor(text), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxTextDataObject_RegisterDisposable(wxObject, virtual_Dispose);
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
						wxTextDataObject_dtor(wxObject);
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
		
		~TextDataObject() 
		{
			Dispose();
		}
			
		//---------------------------------------------------------------------

		public int TextLength
		{
			get { return wxTextDataObject_GetTextLength(wxObject); }
		}
		
		//---------------------------------------------------------------------

		public string Text
		{
			get { return new wxString(wxTextDataObject_GetText(wxObject), true); }
			set { wxTextDataObject_SetText(wxObject, value); }
		}
	}
	
	//---------------------------------------------------------------------

	public class FileDataObject : DataObjectSimple
	{
		[DllImport("wx-c")] static extern IntPtr wxFileDataObject_ctor();
		[DllImport("wx-c")] static extern void wxFileDataObject_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxFileDataObject_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void wxFileDataObject_AddFile(IntPtr self, string filename);
		[DllImport("wx-c")] static extern IntPtr wxFileDataObject_GetFilenames(IntPtr self);
		
		//---------------------------------------------------------------------
		
		public FileDataObject(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
			
		internal FileDataObject(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public FileDataObject()
			: this(wxFileDataObject_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxFileDataObject_RegisterDisposable(wxObject, virtual_Dispose);
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
						wxFileDataObject_dtor(wxObject);
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
		
		~FileDataObject() 
		{
			Dispose();
		}
			
		//---------------------------------------------------------------------
			
		public void AddFile(string filename)
		{
			wxFileDataObject_AddFile(wxObject, filename);
		}
		
		public string[] Filenames
		{
			get { return new ArrayString(wxFileDataObject_GetFilenames(wxObject), true); }
		}
	}
}
