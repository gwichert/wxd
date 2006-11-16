//-----------------------------------------------------------------------------
// wx.NET - Dnd.cs
//
// The wxDND wrapper classes.
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
	public enum Drag
	{
		wxDrag_CopyOnly    = 0,
		wxDrag_AllowMove   = 1,
		wxDrag_DefaultMove = 3
	}
	
	//---------------------------------------------------------------------

	public enum DragResult
	{
    		wxDragError,
    		wxDragNone,
    		wxDragCopy,
    		wxDragMove,
    		wxDragLink,
    		wxDragCancel
	}
	
	//---------------------------------------------------------------------

	public class DropSource : Object
	{
		private delegate int Virtual_DoDragDrop(int flags);

		private Virtual_DoDragDrop virtual_DoDragDrop;
		
		protected DataObject m_dataObject = null;
		
		[DllImport("wx-c")] static extern IntPtr wxDropSource_Win_ctor(IntPtr win);
		[DllImport("wx-c")] static extern IntPtr wxDropSource_DataObject_ctor(IntPtr dataObject, IntPtr win);
		[DllImport("wx-c")] static extern void wxDropSource_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxDropSource_RegisterVirtual(IntPtr self, Virtual_DoDragDrop doDragDrop);
		[DllImport("wx-c")] static extern int wxDropSource_DoDragDrop(IntPtr self, int flags);
		[DllImport("wx-c")] static extern void wxDropSource_SetData(IntPtr self, IntPtr dataObject);
		
		//---------------------------------------------------------------------

		public DropSource(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}		
			
		internal DropSource(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
		
		public DropSource(Window win)
			: this(wxDropSource_Win_ctor(Object.SafePtr(win)), true) 
		{ 
			m_dataObject = null;
			
			virtual_DoDragDrop = new Virtual_DoDragDrop(DoDoDragDrop);

			wxDropSource_RegisterVirtual( wxObject, virtual_DoDragDrop );
		}

		public DropSource(DataObject dataObject, Window win)
			: this(wxDropSource_DataObject_ctor(Object.SafePtr(dataObject), Object.SafePtr(win)), true) 
		{
			m_dataObject = dataObject;

			virtual_DoDragDrop = new Virtual_DoDragDrop(DoDoDragDrop);
			
			wxDropSource_RegisterVirtual( wxObject, virtual_DoDragDrop );
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
						wxDropSource_dtor(wxObject);
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
		
		~DropSource() 
		{
			Dispose();
		}

		//---------------------------------------------------------------------

		public virtual DragResult DoDragDrop(int flags)
		{
			return (DragResult)wxDropSource_DoDragDrop(wxObject, flags);
		}
		
		private int DoDoDragDrop(int flags)
		{
			return (int)DoDragDrop(flags);
		}
		
		//---------------------------------------------------------------------
		
		public DataObject DataObject
		{
			get { return m_dataObject; }
			set { m_dataObject = value; wxDropSource_SetData(wxObject, Object.SafePtr(value)); }
		}
	}
	
	//---------------------------------------------------------------------

	public abstract class DropTarget : Object
	{
		private delegate int Virtual_OnDragOver(int x, int y, int def);
		private delegate bool Virtual_OnDrop(int x, int y);
		private delegate int Virtual_OnData3(int x, int y, int def);
		private delegate bool Virtual_GetData();
		private delegate void Virtual_OnLeave();
		private delegate int Virtual_OnEnter(int x, int y, int def);

		private Virtual_OnDragOver virtual_OnDragOver;
		private Virtual_OnDrop virtual_OnDrop;
		private Virtual_OnData3 virtual_OnData3;
		private Virtual_GetData virtual_GetData;
		private Virtual_OnLeave virtual_OnLeave;
		private Virtual_OnEnter virtual_OnEnter;
		
		//---------------------------------------------------------------------
		
		protected DataObject m_dataObject = null;
		
		//---------------------------------------------------------------------
		
		[DllImport("wx-c")] static extern IntPtr wxDropTarget_ctor(IntPtr dataObject);
		[DllImport("wx-c")] static extern void wxDropTarget_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxDropTarget_RegisterVirtual(IntPtr self, Virtual_OnDragOver onDragOver, Virtual_OnDrop onDrop, Virtual_OnData3 onData, Virtual_GetData getData, Virtual_OnLeave onLeave, Virtual_OnEnter onEnter);  
		[DllImport("wx-c")] static extern void   wxDropTarget_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxDropTarget_SetDataObject(IntPtr self, IntPtr dataObject);
		[DllImport("wx-c")] static extern int wxDropTarget_OnEnter(IntPtr self, int x, int y, int def);
		[DllImport("wx-c")] static extern int wxDropTarget_OnDragOver(IntPtr self, int x, int y, int def);
		[DllImport("wx-c")] static extern void   wxDropTarget_OnLeave(IntPtr self);
		[DllImport("wx-c")] static extern bool wxDropTarget_OnDrop(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern bool wxDropTarget_GetData(IntPtr self);
		
		//---------------------------------------------------------------------

		public DropTarget()
			: this(null) { }		
		
		public DropTarget(DataObject dataObject)
			: this(wxDropTarget_ctor(Object.SafePtr(dataObject)), true) 
		{ 
			m_dataObject = dataObject;

			virtual_OnDragOver = new Virtual_OnDragOver(DoOnDragOver);
			virtual_OnDrop = new Virtual_OnDrop(OnDrop);
			virtual_OnData3 = new Virtual_OnData3(DoOnData);
			virtual_GetData = new Virtual_GetData(GetData);
			virtual_OnLeave = new Virtual_OnLeave(OnLeave);
			virtual_OnEnter = new Virtual_OnEnter(DoOnEnter);
			
			wxDropTarget_RegisterVirtual( wxObject, virtual_OnDragOver,
				virtual_OnDrop,
				virtual_OnData3,
				virtual_GetData,
				virtual_OnLeave,
				virtual_OnEnter);
				
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxDropTarget_RegisterDisposable(wxObject, virtual_Dispose);
		}

		public DropTarget(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}			
		
		internal DropTarget(IntPtr wxObject, bool memOwn)
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
						wxDropTarget_dtor(wxObject);
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
		
		~DropTarget() 
		{
			Dispose();
		}

		//---------------------------------------------------------------------

		public virtual DragResult OnDragOver(int x, int y, DragResult def)
		{
			return (DragResult)wxDropTarget_OnDragOver(wxObject, x, y, (int)def);
		}
		
		private int DoOnDragOver(int x, int y, int def)
		{
			return (int)OnDragOver(x, y, (DragResult)def);
		}
		
		//---------------------------------------------------------------------

		public virtual bool OnDrop(int x, int y)
		{
			return wxDropTarget_OnDrop(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------

		public abstract DragResult OnData(int x, int y, DragResult def);
		
		private int DoOnData(int x, int y, int def)
		{
			return (int)OnData(x, y, (DragResult) def);
		}

		//---------------------------------------------------------------------

		public virtual bool GetData()
		{
			return wxDropTarget_GetData(wxObject);
		}
		
		//---------------------------------------------------------------------

		public virtual DragResult OnEnter(int x, int y, DragResult def)
		{
			return (DragResult)wxDropTarget_OnEnter(wxObject, x, y, (int)def);
		}
		
		private int DoOnEnter(int x, int y, int def)
		{
			return (int)OnEnter(x, y, (DragResult) def);
		}
		
		//---------------------------------------------------------------------

		public virtual void OnLeave()
		{
			wxDropTarget_OnLeave(wxObject);
		}
		
		//---------------------------------------------------------------------

		public DataObject DataObject
		{
			get { return m_dataObject; }
			set { m_dataObject = value; wxDropTarget_SetDataObject(wxObject, Object.SafePtr(value)); }
		}
	}
	
	//---------------------------------------------------------------------

	public abstract class TextDropTarget : DropTarget
	{
		[DllImport("wx-c")] static extern bool wxTextDropTarget_OnDrop(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern bool wxTextDropTarget_GetData(IntPtr self);

		//---------------------------------------------------------------------

		public TextDropTarget()
			: base(new TextDataObject()) {}
			
		public abstract bool OnDropText(int x, int y, string text);

		//---------------------------------------------------------------------

		public override DragResult OnData(int x, int y, DragResult def)
		{
			if (!GetData())
				return DragResult.wxDragNone;
				
			TextDataObject dobj = (TextDataObject)m_dataObject;
		
			return OnDropText(x, y, dobj.Text) ? def : DragResult.wxDragNone;
		}

		//---------------------------------------------------------------------
        
		public override bool OnDrop(int x, int y)
		{
			return wxTextDropTarget_OnDrop(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------

		public override bool GetData()
		{
			return wxTextDropTarget_GetData(wxObject);
		}
	}
	
	//---------------------------------------------------------------------

	public abstract class FileDropTarget : DropTarget
	{
		[DllImport("wx-c")] static extern bool wxFileDropTarget_OnDrop(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern bool wxFileDropTarget_GetData(IntPtr self);

		//---------------------------------------------------------------------

		public FileDropTarget()
			: base(new FileDataObject()) {}
 
		public abstract bool OnDropFiles(int x, int y, string[] filenames);
		
		//---------------------------------------------------------------------

		public override DragResult OnData(int x, int y, DragResult def)
		{
			if ( !GetData() )
				return DragResult.wxDragNone;
				
			FileDataObject dobj = (FileDataObject)m_dataObject;
			
			return OnDropFiles(x, y, dobj.Filenames) ? def : DragResult.wxDragNone;
		}

		//---------------------------------------------------------------------
                
		public override bool OnDrop(int x, int y)
		{
			return wxFileDropTarget_OnDrop(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------

		public override bool GetData()
		{
			return wxFileDropTarget_GetData(wxObject);
		}
	}
}

