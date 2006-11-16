//-----------------------------------------------------------------------------
// wx.NET - SashWindow.cs
// 
// The wxSashWindow wrapper classes.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public enum SashEdgePosition 
	{
		wxSASH_TOP = 0,
		wxSASH_RIGHT,
		wxSASH_BOTTOM,
		wxSASH_LEFT,
		wxSASH_NONE = 100
	}
	
	//-----------------------------------------------------------------------------
	
	public enum SashDragStatus
	{
		wxSASH_STATUS_OK,
		wxSASH_STATUS_OUT_OF_RANGE
	}
		
	//-----------------------------------------------------------------------------

	public class SashEdge : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxSashEdge_ctor();
		[DllImport("wx-c")] static extern void wxSashEdge_dtor(IntPtr self);
		[DllImport("wx-c")] static extern bool wxSashEdge_m_show(IntPtr self);
		[DllImport("wx-c")] static extern bool wxSashEdge_m_border(IntPtr self);
		[DllImport("wx-c")] static extern int wxSashEdge_m_margin(IntPtr self);
		
		//-----------------------------------------------------------------------------
	
		public SashEdge(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal SashEdge(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public SashEdge()
			: this(wxSashEdge_ctor(), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxSashEdge_dtor(wxObject);
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
		
		~SashEdge() 
		{
			Dispose();
		}
			
		//-----------------------------------------------------------------------------
		
		public bool m_show
		{
			get { return wxSashEdge_m_show(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool m_border
		{
			get { return wxSashEdge_m_border(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int m_margin
		{
			get { return wxSashEdge_m_margin(wxObject); }
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class SashWindow : Window
	{
		public const long wxSW_NOBORDER	= 0x0000;
		public const long wxSW_BORDER	= 0x0020;
		public const long wxSW_3DSASH	= 0x0040;
		public const long wxSW_3DBORDER	= 0x0080;
		public const long wxSW_3D	= wxSW_3DSASH | wxSW_3DBORDER;
		
		public const int wxSASH_DRAG_NONE	= 0;
		public const int wxSASH_DRAG_DRAGGING	= 1;
		public const int wxSASH_DRAG_LEFT_DOWN	= 2;

		//-----------------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxSashWindow_ctor();
		[DllImport("wx-c")] static extern bool wxSashWindow_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void wxSashWindow_SetSashVisible(IntPtr self, SashEdgePosition edge, bool sash);
		[DllImport("wx-c")] static extern bool wxSashWindow_GetSashVisible(IntPtr self, SashEdgePosition edge);
		[DllImport("wx-c")] static extern void wxSashWindow_SetSashBorder(IntPtr self, SashEdgePosition edge, bool border);
		[DllImport("wx-c")] static extern bool wxSashWindow_HasBorder(IntPtr self, SashEdgePosition edge);
		[DllImport("wx-c")] static extern int wxSashWindow_GetEdgeMargin(IntPtr self, SashEdgePosition edge);
		[DllImport("wx-c")] static extern void wxSashWindow_SetDefaultBorderSize(IntPtr self, int width);
		[DllImport("wx-c")] static extern int wxSashWindow_GetDefaultBorderSize(IntPtr self);
		[DllImport("wx-c")] static extern void wxSashWindow_SetExtraBorderSize(IntPtr self, int width);
		[DllImport("wx-c")] static extern int wxSashWindow_GetExtraBorderSize(IntPtr self);
		[DllImport("wx-c")] static extern void wxSashWindow_SetMinimumSizeX(IntPtr self, int min);
		[DllImport("wx-c")] static extern void wxSashWindow_SetMinimumSizeY(IntPtr self, int min);
		[DllImport("wx-c")] static extern int wxSashWindow_GetMinimumSizeX(IntPtr self);
		[DllImport("wx-c")] static extern int wxSashWindow_GetMinimumSizeY(IntPtr self);
		[DllImport("wx-c")] static extern void wxSashWindow_SetMaximumSizeX(IntPtr self, int max);
		[DllImport("wx-c")] static extern void wxSashWindow_SetMaximumSizeY(IntPtr self, int max);
		[DllImport("wx-c")] static extern int wxSashWindow_GetMaximumSizeX(IntPtr self);
		[DllImport("wx-c")] static extern int wxSashWindow_GetMaximumSizeY(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
		public SashWindow(IntPtr wxObject)
			: base(wxObject) {}
			
		public SashWindow()
			: base(wxSashWindow_ctor()) {}
			
		public SashWindow(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "sashWindow") {}
			
		public SashWindow(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "sashWindow") {}
			
		public SashWindow(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "sashWindow") {}
			
		public SashWindow(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxSW_3D|wxCLIP_CHILDREN, "sashWindow") {}
			
		public SashWindow(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "sashWindow") {}
			
		public SashWindow(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxSashWindow_ctor())
		{
			if (!Create(parent, id, pos, size, style, name)) 
			{
				throw new InvalidOperationException("Failed to create SashWindow");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public SashWindow(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "sashWindow") {}
			
		public SashWindow(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxSW_3D|wxCLIP_CHILDREN, "sashWindow") {}
			
		public SashWindow(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "sashWindow") {}
			
		public SashWindow(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------
		
		public bool Create(Window parent, int id, Point pos, Size size, long style, string name)
		{
			return wxSashWindow_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetSashVisible(SashEdgePosition edge, bool sash)
		{
			wxSashWindow_SetSashVisible(wxObject, edge, sash);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool GetSashVisible(SashEdgePosition edge)
		{
			return wxSashWindow_GetSashVisible(wxObject, edge);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetSashBorder(SashEdgePosition edge, bool border)
		{
			wxSashWindow_SetSashBorder(wxObject, edge, border);
		}
		
		//-----------------------------------------------------------------------------
		
		public int GetEdgeMargin(SashEdgePosition edge)
		{
			return wxSashWindow_GetEdgeMargin(wxObject, edge);
		}
		
		//-----------------------------------------------------------------------------
		
		public int DefaultBorderSize
		{
			get { return wxSashWindow_GetDefaultBorderSize(wxObject); }
			set { wxSashWindow_SetDefaultBorderSize(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int ExtraBorderSize
		{
			get { return wxSashWindow_GetExtraBorderSize(wxObject); }
			set { wxSashWindow_SetExtraBorderSize(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int MinimumSizeX
		{
			get { return wxSashWindow_GetMinimumSizeX(wxObject); }
			set { wxSashWindow_SetMinimumSizeX(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int MinimumSizeY
		{
			get { return wxSashWindow_GetMinimumSizeY(wxObject); }
			set { wxSashWindow_SetMinimumSizeY(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int MaximumSizeX
		{
			get { return wxSashWindow_GetMaximumSizeX(wxObject); }
			set { wxSashWindow_SetMaximumSizeX(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int MaximumSizeY
		{
			get { return wxSashWindow_GetMaximumSizeY(wxObject); }
			set { wxSashWindow_SetMaximumSizeY(wxObject, value); }
		}		
	}
	
	//-----------------------------------------------------------------------------
	
	public class SashEvent : CommandEvent
	{
		[DllImport("wx-c")] static extern IntPtr wxSashEvent_ctor(int id, SashEdgePosition edge);
		[DllImport("wx-c")] static extern void wxSashEvent_SetEdge(IntPtr self, SashEdgePosition edge);
		[DllImport("wx-c")] static extern SashEdgePosition wxSashEvent_GetEdge(IntPtr self);
		[DllImport("wx-c")] static extern void wxSashEvent_SetDragRect(IntPtr self, ref Rectangle rect);
		[DllImport("wx-c")] static extern void wxSashEvent_GetDragRect(IntPtr self, out Rectangle rect);
		[DllImport("wx-c")] static extern void wxSashEvent_SetDragStatus(IntPtr self, SashDragStatus status);
		[DllImport("wx-c")] static extern SashDragStatus wxSashEvent_GetDragStatus(IntPtr self);
	
		public SashEvent(IntPtr wxObject)
			: base(wxObject) {}
			
		public SashEvent()
			: this(0, SashEdgePosition.wxSASH_NONE) {}
			
		public SashEvent(int id)
			: this(id, SashEdgePosition.wxSASH_NONE) {}
			
		public SashEvent(int id, SashEdgePosition edge)
			: base(wxSashEvent_ctor(id, edge)) {}
			
		//-----------------------------------------------------------------------------
		
		public SashEdgePosition Edge
		{
			get { return wxSashEvent_GetEdge(wxObject); }
			set { wxSashEvent_SetEdge(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Rectangle DragRect
		{
			get { 
				Rectangle rect = new Rectangle();
				wxSashEvent_GetDragRect(wxObject, out rect);
				return rect;
			}
			set { wxSashEvent_SetDragRect(wxObject, ref value); }	
		}
		
		//-----------------------------------------------------------------------------
		
		public SashDragStatus DragStatus
		{
			get { return wxSashEvent_GetDragStatus(wxObject); }
			set { wxSashEvent_SetDragStatus(wxObject, value); }
		}
	}
}