//-----------------------------------------------------------------------------
// wx.NET - GridCtrl.cs
//
// The wxGrid controls wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;
using System.Drawing;

namespace wx
{
	public class GridCellDateTimeRenderer : GridCellStringRenderer
	{
		[DllImport("wx-c")] static extern IntPtr wxGridCellDateTimeRenderer_ctor(string outformat, string informat);
		[DllImport("wx-c")] static extern void wxGridCellDateTimeRenderer_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxGridCellDateTimeRenderer_Draw(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, ref Rectangle rect, int row, int col, bool isSelected);
		[DllImport("wx-c")] static extern void wxGridCellDateTimeRenderer_GetBestSize(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, int row, int col, out Size size);
		[DllImport("wx-c")] static extern IntPtr wxGridCellDateTimeRenderer_Clone(IntPtr self);
		[DllImport("wx-c")] static extern void wxGridCellDateTimeRenderer_SetParameters(IntPtr self, string parameter);
		
		public GridCellDateTimeRenderer()
			: this("%c", "%c") {}
			
		public GridCellDateTimeRenderer(string outformat)
			: this(outformat, "%c") {}
			
		public GridCellDateTimeRenderer(string outformat, string informat)
			: this(wxGridCellDateTimeRenderer_ctor(outformat, informat), true) {}
				
		public GridCellDateTimeRenderer(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal GridCellDateTimeRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellDateTimeRenderer_dtor(wxObject);
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
		
		~GridCellDateTimeRenderer() 
		{
			Dispose();
		}
		
		public override void SetParameters(string parameter)
		{
			wxGridCellDateTimeRenderer_SetParameters(wxObject, parameter);
		}
		
		public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
		{
			wxGridCellDateTimeRenderer_Draw(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), ref rect, row, col, isSelected);
		}
		
		public override Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col)
		{
			Size size = new Size();
			wxGridCellDateTimeRenderer_GetBestSize(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), row, col, out size);			
			return size;
		}
		
		public override GridCellRenderer Clone()
		{
			return (GridCellRenderer)FindObject(wxGridCellDateTimeRenderer_Clone(wxObject), typeof(GridCellRenderer));
		}			
	}
	
	//-----------------------------------------------------------------------------
	
	public class GridCellEnumRenderer : GridCellStringRenderer
	{
		[DllImport("wx-c")] static extern IntPtr wxGridCellEnumRenderer_ctor(int n, string[] choices);
		[DllImport("wx-c")] static extern void wxGridCellEnumRenderer_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxGridCellEnumRenderer_Draw(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, ref Rectangle rect, int row, int col, bool isSelected);
		[DllImport("wx-c")] static extern void wxGridCellEnumRenderer_GetBestSize(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, int row, int col, out Size size);
		[DllImport("wx-c")] static extern IntPtr wxGridCellEnumRenderer_Clone(IntPtr self);
		[DllImport("wx-c")] static extern void wxGridCellEnumRenderer_SetParameters(IntPtr self, string parameter);
		
		public GridCellEnumRenderer()
			: this(null) {}
			
		public GridCellEnumRenderer(string[] choices)
			: this(wxGridCellEnumRenderer_ctor(choices.Length, choices), true) {}
				
		public GridCellEnumRenderer(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal GridCellEnumRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellEnumRenderer_dtor(wxObject);
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
		
		~GridCellEnumRenderer() 
		{
			Dispose();
		}
		
		public override void SetParameters(string parameter)
		{
			wxGridCellEnumRenderer_SetParameters(wxObject, parameter);
		}
		
		public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
		{
			wxGridCellEnumRenderer_Draw(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), ref rect, row, col, isSelected);
		}
		
		public override Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col)
		{
			Size size = new Size();
			wxGridCellEnumRenderer_GetBestSize(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), row, col, out size);			
			return size;
		}
		
		public override GridCellRenderer Clone()
		{
			return (GridCellRenderer)FindObject(wxGridCellEnumRenderer_Clone(wxObject), typeof(GridCellRenderer));
		}			
	}
	
	//-----------------------------------------------------------------------------
	
	public class GridCellEnumEditor : GridCellChoiceEditor
	{
		[DllImport("wx-c")] static extern IntPtr wxGridCellEnumEditor_ctor(int n, string[] choices);
		[DllImport("wx-c")] static extern void wxGridCellEnumEditor_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxGridCellEnumEditor_BeginEdit(IntPtr self, int row, int col, IntPtr grid);
		[DllImport("wx-c")] static extern bool wxGridCellEnumEditor_EndEdit(IntPtr self, int row, int col, IntPtr grid);
		[DllImport("wx-c")] static extern IntPtr wxGridCellEnumEditor_Clone(IntPtr self);
		
		public GridCellEnumEditor()
			: this(null) {}
		
		public GridCellEnumEditor(string[] choices)
			: this(wxGridCellEnumEditor_ctor(choices.Length, choices), true) {}
		
		public GridCellEnumEditor(IntPtr wxObject)
			: base(wxObject) 
		{	
			this.wxObject = wxObject;
		}		
		
		internal GridCellEnumEditor(IntPtr wxObject, bool memOwn)
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
						wxGridCellEnumEditor_dtor(wxObject);
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
		
		~GridCellEnumEditor() 
		{
			Dispose();
		}
			
		public override void BeginEdit(int row, int col, Grid grid)
		{
			wxGridCellEnumEditor_BeginEdit(wxObject, row, col, Object.SafePtr(grid));
		}
		
		public override bool EndEdit(int row, int col, Grid grid)
		{
			return wxGridCellEnumEditor_EndEdit(wxObject, row, col, Object.SafePtr(grid));
		}	

		public override GridCellEditor Clone()
		{
			return (GridCellEditor)FindObject(wxGridCellEnumEditor_Clone(wxObject), typeof(GridCellEditor));
		}				
	}
	
	//-----------------------------------------------------------------------------
	
	public class GridCellAutoWrapStringEditor : GridCellTextEditor
	{
		[DllImport("wx-c")] static extern IntPtr wxGridCellAutoWrapStringEditor_ctor();
		[DllImport("wx-c")] static extern void wxGridCellAutoWrapStringEditor_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxGridCellAutoWrapStringEditor_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void wxGridCellAutoWrapStringEditor_Create(IntPtr self, IntPtr parent, int id, IntPtr evtHandler);
		[DllImport("wx-c")] static extern IntPtr wxGridCellAutoWrapStringEditor_Clone(IntPtr self);
		
		public GridCellAutoWrapStringEditor()
			: this(wxGridCellAutoWrapStringEditor_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxGridCellAutoWrapStringEditor_RegisterDisposable(wxObject, virtual_Dispose);
		}

		public GridCellAutoWrapStringEditor(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal GridCellAutoWrapStringEditor(IntPtr wxObject, bool memOwn)
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
						wxGridCellAutoWrapStringEditor_dtor(wxObject);
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
		
		~GridCellAutoWrapStringEditor() 
		{
			Dispose();
		}
			
		public override void Create(Window parent, int id, EvtHandler evtHandler)
		{
			wxGridCellAutoWrapStringEditor_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(evtHandler));
		}
		
		public override GridCellEditor Clone()
		{
			return (GridCellEditor)FindObject(wxGridCellAutoWrapStringEditor_Clone(wxObject), typeof(GridCellEditor));
		}		
	}
	
	//-----------------------------------------------------------------------------
	
	public class GridCellAutoWrapStringRenderer : GridCellStringRenderer
	{
		[DllImport("wx-c")] static extern IntPtr wxGridCellAutoWrapStringRenderer_ctor();
		[DllImport("wx-c")] static extern void wxGridCellAutoWrapStringRenderer_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxGridCellAutoWrapStringRenderer_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void wxGridCellAutoWrapStringRenderer_Draw(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, ref Rectangle rect, int row, int col, bool isSelected);
		[DllImport("wx-c")] static extern void wxGridCellAutoWrapStringRenderer_GetBestSize(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, int row, int col, out Size size);
		[DllImport("wx-c")] static extern IntPtr wxGridCellAutoWrapStringRenderer_Clone(IntPtr self);
		
		public GridCellAutoWrapStringRenderer()
			: this(wxGridCellAutoWrapStringRenderer_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxGridCellAutoWrapStringRenderer_RegisterDisposable(wxObject, virtual_Dispose);
		}
				
		public GridCellAutoWrapStringRenderer(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal GridCellAutoWrapStringRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellAutoWrapStringRenderer_dtor(wxObject);
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
		
		~GridCellAutoWrapStringRenderer() 
		{
			Dispose();
		}
		
		public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
		{
			wxGridCellAutoWrapStringRenderer_Draw(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), ref rect, row, col, isSelected);
		}
		
		public override Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col)
		{
			Size size = new Size();
			wxGridCellAutoWrapStringRenderer_GetBestSize(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), row, col, out size);			
			return size;
		}
		
		public override GridCellRenderer Clone()
		{
			return (GridCellRenderer)FindObject(wxGridCellAutoWrapStringRenderer_Clone(wxObject), typeof(GridCellRenderer));
		}			
	}
}
