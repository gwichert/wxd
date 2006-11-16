//-----------------------------------------------------------------------------
// wx.NET - LayoutWin.cs
// 
// The wxSashLayoutWindow proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public enum LayoutOrientation
	{
		wxLAYOUT_HORIZONTAL,
		wxLAYOUT_VERTICAL
	}
	
	//-----------------------------------------------------------------------------

	public enum LayoutAlignment
	{
		wxLAYOUT_NONE,
		wxLAYOUT_TOP,
		wxLAYOUT_LEFT,
		wxLAYOUT_RIGHT,
		wxLAYOUT_BOTTOM
	}
	
	//-----------------------------------------------------------------------------

	public class SashLayoutWindow : SashWindow
	{
		[DllImport("wx-c")] static extern IntPtr wxSashLayoutWindow_ctor();
		[DllImport("wx-c")] static extern bool wxSashLayoutWindow_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern LayoutAlignment wxSashLayoutWindow_GetAlignment(IntPtr self);
		[DllImport("wx-c")] static extern LayoutOrientation wxSashLayoutWindow_GetOrientation(IntPtr self);
		[DllImport("wx-c")] static extern void wxSashLayoutWindow_SetAlignment(IntPtr self, LayoutAlignment align);
		[DllImport("wx-c")] static extern void wxSashLayoutWindow_SetOrientation(IntPtr self, LayoutOrientation orient);
		[DllImport("wx-c")] static extern void wxSashLayoutWindow_SetDefaultSize(IntPtr self, ref Size size);
		
		//-----------------------------------------------------------------------------
	
		public SashLayoutWindow(IntPtr wxObject)
			: base(wxObject) {}
			
		public SashLayoutWindow()
			: base(wxSashLayoutWindow_ctor()) {}
			
		public SashLayoutWindow(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxSW_3D|wxCLIP_CHILDREN, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxSashLayoutWindow_ctor())
		{
			if (!Create(parent, id, pos, size, style, name)) 
			{
				throw new InvalidOperationException("Failed to create SashLayoutWindow");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public SashLayoutWindow(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, wxSW_3D|wxCLIP_CHILDREN, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxSW_3D|wxCLIP_CHILDREN, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "layoutWindow") {}
			
		public SashLayoutWindow(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------
		
		public new bool Create(Window parent, int id, Point pos, Size size, long style, string name)
		{
			return wxSashLayoutWindow_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name);
		}
		
		//-----------------------------------------------------------------------------
		
		public LayoutAlignment Alignment
		{
			get { return wxSashLayoutWindow_GetAlignment(wxObject); }
			set { wxSashLayoutWindow_SetAlignment(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public LayoutOrientation Orientation
		{
			get { return wxSashLayoutWindow_GetOrientation(wxObject); }
			set { wxSashLayoutWindow_SetOrientation(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Size DefaultSize
		{
			set { wxSashLayoutWindow_SetDefaultSize(wxObject, ref value); }
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class LayoutAlgorithm : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxLayoutAlgorithm_ctor();
		[DllImport("wx-c")] static extern bool wxLayoutAlgorithm_LayoutMDIFrame(IntPtr self, IntPtr frame, ref Rectangle rect);
		[DllImport("wx-c")] static extern bool wxLayoutAlgorithm_LayoutFrame(IntPtr self, IntPtr frame, IntPtr mainWindow);
		[DllImport("wx-c")] static extern bool wxLayoutAlgorithm_LayoutWindow(IntPtr self, IntPtr frame, IntPtr mainWindow);
		
		//-----------------------------------------------------------------------------
		
		public LayoutAlgorithm(IntPtr wxObject)
			: base(wxObject) {}
			
		public LayoutAlgorithm()
			: base(wxLayoutAlgorithm_ctor()) {}
			
		//-----------------------------------------------------------------------------
		
		public bool LayoutMDIFrame(MDIParentFrame frame)
		{
			// FIXME
			Rectangle dummy = new Rectangle(0, 0, 0, 0);
			return LayoutMDIFrame(frame, dummy);
		}
		
		public bool LayoutMDIFrame(MDIParentFrame frame, Rectangle rect)
		{
			return wxLayoutAlgorithm_LayoutMDIFrame(wxObject, Object.SafePtr(frame), ref rect);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool LayoutFrame(Frame frame)
		{
			return LayoutFrame(frame, null);
		}
		
		public bool LayoutFrame(Frame frame, Window mainWindow)
		{
			return wxLayoutAlgorithm_LayoutFrame(wxObject, Object.SafePtr(frame), Object.SafePtr(mainWindow));
		}
		
		//-----------------------------------------------------------------------------
		
		public bool LayoutWindow(Window frame)
		{
			return LayoutWindow(frame, null);
		}
		
		public bool LayoutWindow(Window frame, Window mainWindow)
		{
			return wxLayoutAlgorithm_LayoutWindow(wxObject, Object.SafePtr(frame), Object.SafePtr(mainWindow));
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class QueryLayoutInfoEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxQueryLayoutInfoEvent_ctor(int id);
		[DllImport("wx-c")] static extern void wxQueryLayoutInfoEvent_SetRequestedLength(IntPtr self, int length);
		[DllImport("wx-c")] static extern int wxQueryLayoutInfoEvent_GetRequestedLength(IntPtr self);
		[DllImport("wx-c")] static extern void wxQueryLayoutInfoEvent_SetFlags(IntPtr self, int flags);
		[DllImport("wx-c")] static extern int wxQueryLayoutInfoEvent_GetFlags(IntPtr self);
		[DllImport("wx-c")] static extern void wxQueryLayoutInfoEvent_SetSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void wxQueryLayoutInfoEvent_GetSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern void wxQueryLayoutInfoEvent_SetOrientation(IntPtr self, LayoutOrientation orient);
		[DllImport("wx-c")] static extern LayoutOrientation wxQueryLayoutInfoEvent_GetOrientation(IntPtr self);
		[DllImport("wx-c")] static extern void wxQueryLayoutInfoEvent_SetAlignment(IntPtr self, LayoutAlignment align);
		[DllImport("wx-c")] static extern LayoutAlignment wxQueryLayoutInfoEvent_GetAlignment(IntPtr self);
	
		//-----------------------------------------------------------------------------
		
		public QueryLayoutInfoEvent(IntPtr wxObject)
			: base(wxObject) {}
			
		public QueryLayoutInfoEvent()
			: this(0) {}
			
		public QueryLayoutInfoEvent(int id)
			: base(wxQueryLayoutInfoEvent_ctor(id)) {}
			
		//-----------------------------------------------------------------------------
		
		public int RequestedLength
		{
			get { return wxQueryLayoutInfoEvent_GetRequestedLength(wxObject); }
			set { wxQueryLayoutInfoEvent_SetRequestedLength(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int Flags
		{
			get { return wxQueryLayoutInfoEvent_GetFlags(wxObject); }
			set { wxQueryLayoutInfoEvent_SetFlags(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Size Size
		{
			get {
				Size size = new Size();
				wxQueryLayoutInfoEvent_GetSize(wxObject, out size);
				return size;
			}
			set { wxQueryLayoutInfoEvent_SetSize(wxObject, ref value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public LayoutOrientation Orientation
		{
			get { return wxQueryLayoutInfoEvent_GetOrientation(wxObject); }
			set { wxQueryLayoutInfoEvent_SetOrientation(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public LayoutAlignment Alignment
		{
			get { return wxQueryLayoutInfoEvent_GetAlignment(wxObject); }
			set { wxQueryLayoutInfoEvent_SetAlignment(wxObject, value); }
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class CalculateLayoutEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxCalculateLayoutEvent_ctor(int id);
		[DllImport("wx-c")] static extern void wxCalculateLayoutEvent_SetFlags(IntPtr self, int flags);
		[DllImport("wx-c")] static extern int wxCalculateLayoutEvent_GetFlags(IntPtr self);
		[DllImport("wx-c")] static extern void wxCalculateLayoutEvent_SetRect(IntPtr self, ref Rectangle rect);
		[DllImport("wx-c")] static extern void wxCalculateLayoutEvent_GetRect(IntPtr self, out Rectangle rect);
		
		//-----------------------------------------------------------------------------
	
		public CalculateLayoutEvent(IntPtr wxObject)
			: base(wxObject) {}
			
		public CalculateLayoutEvent()
			: this(0) {}
			
		public CalculateLayoutEvent(int id)
			: base(wxCalculateLayoutEvent_ctor(id)) {}
		
		//-----------------------------------------------------------------------------
		
		public int Flags
		{
			get { return wxCalculateLayoutEvent_GetFlags(wxObject); }
			set { wxCalculateLayoutEvent_SetFlags(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Rectangle Rect
		{
			get {
				Rectangle rect = new Rectangle();
				wxCalculateLayoutEvent_GetRect(wxObject, out rect);
				return rect;
			}
			
			set { wxCalculateLayoutEvent_SetRect(wxObject, ref value); }
		}
	}
}