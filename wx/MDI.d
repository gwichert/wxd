//-----------------------------------------------------------------------------
// wx.NET - MDI.cs
// 
// The wxMDI* wrapper class.
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
	public class MDIParentFrame : Frame
	{
		public const long wxDEFAULT_MDI_FRAME_STYLE = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL;
		
		//-----------------------------------------------------------------------------
		
		private delegate IntPtr Virtual_OnCreateClient();
		
		private Virtual_OnCreateClient virtual_OnCreateClient;
	
		//-----------------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxMDIParentFrame_ctor();
		[DllImport("wx-c")] static extern void wxMDIParentFrame_RegisterVirtual(IntPtr self, Virtual_OnCreateClient onCreateClient);
		[DllImport("wx-c")] static extern IntPtr wxMDIParentFrame_OnCreateClient(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxMDIParentFrame_Create(IntPtr self, IntPtr parent, int id, string title, ref Point pos, ref Size size, uint style, string name);
	
		[DllImport("wx-c")] static extern IntPtr wxMDIParentFrame_GetActiveChild(IntPtr self);
		//[DllImport("wx-c")] static extern void   wxMDIParentFrame_SetActiveChild(IntPtr self, IntPtr pChildFrame);
	
		[DllImport("wx-c")] static extern IntPtr wxMDIParentFrame_GetClientWindow(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxMDIParentFrame_Cascade(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMDIParentFrame_Tile(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxMDIParentFrame_ArrangeIcons(IntPtr self);
	
		[DllImport("wx-c")] static extern void   wxMDIParentFrame_ActivateNext(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMDIParentFrame_ActivatePrevious(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxMDIParentFrame_GetClientSize(IntPtr self, out int width, out int height);

		//-----------------------------------------------------------------------------

		public MDIParentFrame(IntPtr wxObject)
			: base(wxObject) {}

		public MDIParentFrame()
			: base(wxMDIParentFrame_ctor()) 
		{ 
			 virtual_OnCreateClient = new Virtual_OnCreateClient(DoOnCreateClient);
			wxMDIParentFrame_RegisterVirtual(wxObject, virtual_OnCreateClient);
		}

		public MDIParentFrame(Window parent, int id, string title)
			: this(parent, id, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_MDI_FRAME_STYLE, "mdiParentFrame") { }
			
		public MDIParentFrame(Window parent, int id, string title, Point pos)
			: this(parent, id, title, pos, wxDefaultSize, wxDEFAULT_MDI_FRAME_STYLE, "mdiParentFrame") { }
			
		public MDIParentFrame(Window parent, int id, string title, Point pos, Size size)
			: this(parent, id, title, pos, size, wxDEFAULT_MDI_FRAME_STYLE, "mdiParentFrame") { }
			
		public MDIParentFrame(Window parent, int id, string title, Point pos, Size size, long style)
			: this(parent, id, title, pos, size, style, "mdiParentFrame") { }

		public MDIParentFrame(Window parent, int id, string title, Point pos, Size size, long style, string name)
			: base(wxMDIParentFrame_ctor())
		{
			virtual_OnCreateClient = new Virtual_OnCreateClient(DoOnCreateClient);
			wxMDIParentFrame_RegisterVirtual(wxObject, virtual_OnCreateClient);
			
			if (!Create(parent, id, title, pos, size, style, name)) 
			{
				throw new InvalidOperationException("Could not create MDIParentFrame");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public MDIParentFrame(Window parent, string title)
			: this(parent, Window.UniqueID, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_MDI_FRAME_STYLE, "mdiParentFrame") { }
			
		public MDIParentFrame(Window parent, string title, Point pos)
			: this(parent, Window.UniqueID, title, pos, wxDefaultSize, wxDEFAULT_MDI_FRAME_STYLE, "mdiParentFrame") { }
			
		public MDIParentFrame(Window parent, string title, Point pos, Size size)
			: this(parent, Window.UniqueID, title, pos, size, wxDEFAULT_MDI_FRAME_STYLE, "mdiParentFrame") { }
			
		public MDIParentFrame(Window parent, string title, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, title, pos, size, style, "mdiParentFrame") { }

		public MDIParentFrame(Window parent, string title, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, title, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------

		public new bool Create(Window parent, int id, string title, Point pos, Size size, long style, string name)
		{
			return wxMDIParentFrame_Create(wxObject, Object.SafePtr(parent), id, title, ref pos, ref size, (uint)style, name);
		}
		
		//-----------------------------------------------------------------------------
		
		private IntPtr DoOnCreateClient()
		{
			return Object.SafePtr(OnCreateClient());
		}
		
		public virtual MDIClientWindow OnCreateClient()
		{
			return (MDIClientWindow)FindObject(wxMDIParentFrame_OnCreateClient(wxObject), typeof(MDIClientWindow));
		}

		//-----------------------------------------------------------------------------

		public MDIChildFrame GetActiveChild()
		{
			return (MDIChildFrame)FindObject(wxMDIParentFrame_GetActiveChild(wxObject), typeof(MDIChildFrame));
		}

		/*
		public void SetActiveChild(MDIChildFrame pChildFrame)
		{
			wxMDIParentFrame_SetActiveChild(wxObject, Object.SafePtr(pChildFrame));
		}
		*/

		//-----------------------------------------------------------------------------

		public MDIClientWindow GetClientWindow()
		{
			return (MDIClientWindow)FindObject(wxMDIParentFrame_GetClientWindow(wxObject), typeof(MDIClientWindow));
		}

		//-----------------------------------------------------------------------------

		public virtual void Cascade()
		{
			wxMDIParentFrame_Cascade(wxObject);
		}

		public virtual void Tile()
		{
			wxMDIParentFrame_Tile(wxObject);
		}

		//-----------------------------------------------------------------------------

		public virtual void ArrangeIcons()
		{
			wxMDIParentFrame_ArrangeIcons(wxObject);
		}

		//-----------------------------------------------------------------------------

		public virtual void ActivateNext()
		{
			wxMDIParentFrame_ActivateNext(wxObject);
		}

		public virtual void ActivatePrevious()
		{
			wxMDIParentFrame_ActivatePrevious(wxObject);
		}

		//-----------------------------------------------------------------------------
		
		public virtual void GetClientSize(out int width, out int height)
		{
			wxMDIParentFrame_GetClientSize(wxObject, out width, out height);
		}
	}

	public class MDIChildFrame : Frame 
	{
		[DllImport("wx-c")] static extern IntPtr wxMDIChildFrame_ctor();
		[DllImport("wx-c")] static extern bool   wxMDIChildFrame_Create(IntPtr self, IntPtr parent, int id, string title, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void   wxMDIChildFrame_Activate(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMDIChildFrame_Restore(IntPtr self);
		[DllImport("wx-c")] static extern void   wxMDIChildFrame_Maximize(IntPtr self, bool maximize);

		//-----------------------------------------------------------------------------

		public MDIChildFrame(IntPtr wxObject) 
			: base(wxObject) { }

		public MDIChildFrame()
			: base(wxMDIChildFrame_ctor()) {}

		public MDIChildFrame(MDIParentFrame parent, int id, string title)
			: this(parent, id, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "mdiChildFrame") { }
			
		public MDIChildFrame(MDIParentFrame parent, int id, string title, Point pos)
			: this(parent, id, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "mdiChildFrame") { }
			
		public MDIChildFrame(MDIParentFrame parent, int id, string title, Point pos, Size size)
			: this(parent, id, title, pos, size, wxDEFAULT_FRAME_STYLE, "mdiChildFrame") { }
			
		public MDIChildFrame(MDIParentFrame parent, int id, string title, Point pos, Size size, long style)
			: this(parent, id, title, pos, size, style, "mdiChildFrame") { }

		public MDIChildFrame(MDIParentFrame parent, int id, string title, Point pos, Size size, long style, string name)
			: base(wxMDIChildFrame_ctor())
		{
			if (!Create(parent, id, title, pos, size, style, name))
			{
				throw new InvalidOperationException("Could not create MDIChildFrame");
			}
	    
			EVT_ACTIVATE( new EventListener( OnActivate ) );
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public MDIChildFrame(MDIParentFrame parent, string title)
			: this(parent, Window.UniqueID, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "mdiChildFrame") { }
			
		public MDIChildFrame(MDIParentFrame parent, string title, Point pos)
			: this(parent, Window.UniqueID, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "mdiChildFrame") { }
			
		public MDIChildFrame(MDIParentFrame parent, string title, Point pos, Size size)
			: this(parent, Window.UniqueID, title, pos, size, wxDEFAULT_FRAME_STYLE, "mdiChildFrame") { }
			
		public MDIChildFrame(MDIParentFrame parent, string title, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, title, pos, size, style, "mdiChildFrame") { }

		public MDIChildFrame(MDIParentFrame parent, string title, Point pos, Size size, long style, string name)
			:this(parent, Window.UniqueID, title, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------

		public bool Create(MDIParentFrame parent, int id, string title, Point pos, Size size, long style, string name)
		{
			bool ret = wxMDIChildFrame_Create(wxObject, Object.SafePtr(parent), id, title, ref pos, ref size, (uint)style, name);
			#if __WXMAC__
				// Bug in wxMac 2.5.2; it always returns FALSE
				return true;
			#else
				return ret;
			#endif
		}

		//-----------------------------------------------------------------------------

		public virtual void Activate()
		{
			wxMDIChildFrame_Activate(wxObject);
		}

		//-----------------------------------------------------------------------------

		public virtual void Restore()
		{
			wxMDIChildFrame_Restore(wxObject);
		}

		//-----------------------------------------------------------------------------
	
		public virtual void OnActivate(object sender, Event e)
		{
		}
		
		//-----------------------------------------------------------------------------
		
		public virtual void Maximize()
		{
			wxMDIChildFrame_Maximize(wxObject, true);
		}
	}

	public class MDIClientWindow : Window
	{
		[DllImport("wx-c")] static extern IntPtr wxMDIClientWindow_ctor();
		[DllImport("wx-c")] static extern bool   wxMDIClientWindow_CreateClient(IntPtr self, IntPtr parent, uint style);
	
		//-----------------------------------------------------------------------------
	
		public MDIClientWindow(IntPtr wxObject) 
			: base(wxObject) { }

		public  MDIClientWindow()
			: base(wxMDIClientWindow_ctor()) { }

		public MDIClientWindow(MDIParentFrame parent)
			: this(parent, 0) { }

		public MDIClientWindow(MDIParentFrame parent, long style)
			: base(wxMDIClientWindow_ctor())
		{
			if (!CreateClient(parent, style))
			{
				throw new InvalidOperationException("Could not create MDIClientWindow");
			}
		}
		
		//-----------------------------------------------------------------------------

		public bool CreateClient(MDIParentFrame parent, long style)
		{
			return wxMDIClientWindow_CreateClient(wxObject, Object.SafePtr(parent), (uint)style);
		}
	}
}

