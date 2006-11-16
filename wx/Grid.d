//-----------------------------------------------------------------------------
// wx.NET - Grid.cs
//
// The wxGrid wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;
using System.Drawing;

namespace wx
{
    public enum GridSelectionMode
    {
        wxGridSelectCells,
        wxGridSelectRows,
        wxGridSelectColumns
    }

    public class GridEvent : Event 
    {
        [DllImport("wx-c")] static extern IntPtr wxGridEvent_ctor(int id, int type, IntPtr obj, int row, int col, int x, int y, bool sel, bool control, bool shift, bool alt, bool meta);
        [DllImport("wx-c")] static extern int    wxGridEvent_GetRow(IntPtr self);
        [DllImport("wx-c")] static extern int    wxGridEvent_GetCol(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridEvent_GetPosition(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern bool   wxGridEvent_Selecting(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridEvent_ControlDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridEvent_MetaDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridEvent_ShiftDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridEvent_AltDown(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridEvent_Veto(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridEvent_Allow(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridEvent_IsAllowed(IntPtr self);      

        //-----------------------------------------------------------------------------

        public GridEvent(IntPtr wxObject)
            : base(wxObject) { }

        public GridEvent(int id, int type, Object obj, int row, int col, int x, int y, bool sel, bool control, bool shift, bool alt, bool meta)
            : this(wxGridEvent_ctor(id, type, Object.SafePtr(obj), row, col, x, y, sel, control, shift, alt, meta)) { }

        //-----------------------------------------------------------------------------

        public int Row
        {
            get { return wxGridEvent_GetRow(wxObject); }
        }

        public int Col
        {
            get { return wxGridEvent_GetCol(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public Point Position
        {
            get { 
                Point pt = new Point();
                wxGridEvent_GetPosition(wxObject, ref pt);
                return pt;
            }
        }

        //-----------------------------------------------------------------------------

        public bool Selecting
        {
            get { return wxGridEvent_Selecting(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool ControlDown
        {
            get { return wxGridEvent_ControlDown(wxObject); }
        }

        public bool MetaDown
        {
            get { return wxGridEvent_MetaDown(wxObject); }
        }

        public bool ShiftDown
        {
            get { return wxGridEvent_ShiftDown(wxObject); }
        }

            public bool AltDown
            {
                get { return wxGridEvent_AltDown(wxObject); }
            }
        
        //-----------------------------------------------------------------------------     
        
        public void Veto()
        {
            wxGridEvent_Veto(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public void Allow()
        {
            wxGridEvent_Allow(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public bool Allowed
        {
            get { return wxGridEvent_IsAllowed(wxObject); }
        }               
    }
    
    //-----------------------------------------------------------------------------

    public abstract class GridCellEditor : GridCellWorker
    {
        private delegate void Virtual_Create(IntPtr parent, int id, IntPtr evtHandler);
        private delegate void Virtual_BeginEdit(int row, int col, IntPtr grid);
        private delegate bool Virtual_EndEdit(int row, int col, IntPtr grid);
        private delegate void Virtual_Reset();
        private delegate IntPtr Virtual_Clone();
        private delegate void Virtual_SetSize(IntPtr rect);
        private delegate void Virtual_Show(bool show, IntPtr attr);
        private delegate void Virtual_PaintBackground(IntPtr rect, IntPtr attr);
        private delegate bool Virtual_IsAcceptedKey(IntPtr evt);
        private delegate void Virtual_StartingKey(IntPtr evt);
        private delegate void Virtual_StartingClick();
        private delegate void Virtual_HandleReturn(IntPtr evt);
        private delegate void Virtual_Destroy();
        private delegate string Virtual_GetValue();

		private Virtual_Create virtual_Create;
		private Virtual_BeginEdit virtual_BeginEdit;
		private Virtual_EndEdit virtual_EndEdit;
		private Virtual_Reset virtual_Reset;
		private Virtual_Clone virtual_Clone;
		private Virtual_SetSize virtual_SetSize;
		private Virtual_Show virtual_Show;
		private Virtual_PaintBackground virtual_PaintBackground;
		private Virtual_IsAcceptedKey virtual_IsAcceptedKey;
		private Virtual_StartingKey virtual_StartingKey;
		private Virtual_StartingClick virtual_StartingClick;
		private Virtual_HandleReturn virtual_HandleReturn;
		private Virtual_Destroy virtual_Destroy;
		private Virtual_GetValue virtual_GetValue;
        
        //-----------------------------------------------------------------------------
        
        [DllImport("wx-c")] static extern IntPtr wxGridCellEditor_ctor();
	[DllImport("wx-c")] static extern void wxGridCellEditor_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellEditor_RegisterVirtual(IntPtr self, 
            Virtual_Create create, 
            Virtual_BeginEdit beginEdit, 
            Virtual_EndEdit endEdit, 
            Virtual_Reset reset, 
            Virtual_Clone clone,
            Virtual_SetSize setSize,
            Virtual_Show show,
            Virtual_PaintBackground paintBackground,
            Virtual_IsAcceptedKey isAcceptedKey,
            Virtual_StartingKey startingKey,
            Virtual_StartingClick startingClick,
            Virtual_HandleReturn handleReturn,
            Virtual_Destroy destroy,
            Virtual_GetValue getvalue);
        [DllImport("wx-c")] static extern bool   wxGridCellEditor_IsCreated(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellEditor_SetSize(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern void   wxGridCellEditor_Show(IntPtr self, bool show, IntPtr attr);
        [DllImport("wx-c")] static extern void   wxGridCellEditor_PaintBackground(IntPtr self, ref Rectangle rectCell, IntPtr attr);
        [DllImport("wx-c")] static extern bool wxGridCellEditor_IsAcceptedKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void   wxGridCellEditor_StartingKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void   wxGridCellEditor_StartingClick(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellEditor_HandleReturn(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void   wxGridCellEditor_Destroy(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridCellEditor_GetValue(IntPtr self);
	
        //-----------------------------------------------------------------------------
        
        public GridCellEditor(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellEditor(IntPtr wxObject, bool memOwn)
			: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}
            
        public GridCellEditor()
            : this(wxGridCellEditor_ctor(), true) 
        {
			virtual_Create = new Virtual_Create(DoCreate);
            virtual_BeginEdit = new Virtual_BeginEdit(DoBeginEdit);
            virtual_EndEdit = new Virtual_EndEdit(DoEndEdit);
            virtual_Reset = new Virtual_Reset(Reset);
            virtual_Clone = new Virtual_Clone(DoClone);
            virtual_SetSize = new Virtual_SetSize(DoSetSize);
            virtual_Show = new Virtual_Show(DoShow);
            virtual_PaintBackground = new Virtual_PaintBackground(DoPaintBackground);
            virtual_IsAcceptedKey = new Virtual_IsAcceptedKey(DoIsAcceptedKey);
            virtual_StartingKey = new Virtual_StartingKey(DoStartingKey);
            virtual_StartingClick = new Virtual_StartingClick(StartingClick);
            virtual_HandleReturn = new Virtual_HandleReturn(DoHandleReturn);
            virtual_Destroy = new Virtual_Destroy(Destroy);
            virtual_GetValue = new Virtual_GetValue(GetValue);

            wxGridCellEditor_RegisterVirtual(wxObject, virtual_Create,
                    virtual_BeginEdit,
                    virtual_EndEdit,
                    virtual_Reset,
                    virtual_Clone,
                    virtual_SetSize,
                    virtual_Show,
                    virtual_PaintBackground,
                    virtual_IsAcceptedKey,
                    virtual_StartingKey,
                    virtual_StartingClick,
                    virtual_HandleReturn,
                    virtual_Destroy,
                    virtual_GetValue);                                    
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
						wxGridCellEditor_dtor(wxObject);
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
		
		~GridCellEditor() 
		{
			Dispose();
		}
            
        //-----------------------------------------------------------------------------
    
        public bool IsCreated
        {
            get { return wxGridCellEditor_IsCreated(wxObject); }
        }
    
        //-----------------------------------------------------------------------------
        
        private void DoCreate(IntPtr parent, int id, IntPtr evtHandler)
        {
            Create((Window)Object.FindObject(parent), id, (EvtHandler)Object.FindObject(evtHandler, typeof(EvtHandler)));
        }
    
        public abstract void Create(Window parent, int id, EvtHandler evtHandler);
    
        //-----------------------------------------------------------------------------
        
        private void DoSetSize(IntPtr rect)
        {
            SetSize(new wxRect(rect));
        }
    
        public virtual void SetSize(Rectangle rect)
        {
            wxGridCellEditor_SetSize(wxObject, ref rect);
        }

        //-----------------------------------------------------------------------------
        
        private void DoShow(bool show, IntPtr attr)
        {
            Show(show, (GridCellAttr)FindObject(attr, typeof(GridCellAttr)));
        }

        public virtual void Show(bool show, GridCellAttr attr)
        {
            wxGridCellEditor_Show(wxObject, show, Object.SafePtr(attr));
        }

        //-----------------------------------------------------------------------------
        
        private void DoPaintBackground(IntPtr rectCell, IntPtr attr)
        {
            PaintBackground(new wxRect(rectCell), (GridCellAttr)Object.FindObject(attr, typeof(GridCellAttr)));
        }

        public virtual void PaintBackground(Rectangle rectCell, GridCellAttr attr)
        {
            wxGridCellEditor_PaintBackground(wxObject, ref rectCell, Object.SafePtr(attr));
        }

        //-----------------------------------------------------------------------------
        
        private void DoBeginEdit(int row, int col, IntPtr grid)
        {
            BeginEdit(row, col, (Grid)Object.FindObject(grid, typeof(Grid)));
        }
    
        public abstract void BeginEdit(int row, int col, Grid grid);
        
        private bool DoEndEdit(int row, int col, IntPtr grid)
        {
            return EndEdit(row, col, (Grid)Object.FindObject(grid, typeof(Grid)));
        }
        
        public abstract bool EndEdit(int row, int col, Grid grid);
    
        //-----------------------------------------------------------------------------
    
        public abstract void Reset();
    
        //-----------------------------------------------------------------------------
        
        private bool DoIsAcceptedKey(IntPtr evt)
        {
            return IsAcceptedKey((KeyEvent)Object.FindObject(evt, typeof(Event)));
        }
        
        public virtual bool IsAcceptedKey(KeyEvent evt)
        {
            return wxGridCellEditor_IsAcceptedKey(wxObject, Object.SafePtr(evt));
        }
        
        private void DoStartingKey(IntPtr evt)
        {
            StartingKey((KeyEvent)Object.FindObject(evt, typeof(Event)));
        }
    
        public virtual void StartingKey(KeyEvent evt)
        {
            wxGridCellEditor_StartingKey(wxObject, Object.SafePtr(evt));
        }

        public virtual void StartingClick()
        {
            wxGridCellEditor_StartingClick(wxObject);
        }

        //-----------------------------------------------------------------------------
        
        private void DoHandleReturn(IntPtr evt)
        {
            HandleReturn((KeyEvent)Object.FindObject(evt, typeof(Event)));
        }

        public virtual void HandleReturn(KeyEvent evt)
        {
            wxGridCellEditor_HandleReturn(wxObject, Object.SafePtr(evt));
        }

        //-----------------------------------------------------------------------------

        public virtual void Destroy()
        {
            wxGridCellEditor_Destroy(wxObject);
        }

        //-----------------------------------------------------------------------------
        
        private IntPtr DoClone()
        {
            return Object.SafePtr(Clone());
        }
        
        public abstract GridCellEditor Clone();
        
        //-----------------------------------------------------------------------------
        
            public virtual string GetValue()
        {
            return new wxString(wxGridCellEditor_GetValue(wxObject), true);
        }
    }
    
    //-----------------------------------------------------------------------------
    
    public class GridCellTextEditor : GridCellEditor
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellTextEditor_ctor();
	[DllImport("wx-c")] static extern void wxGridCellTextEditor_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellTextEditor_Create(IntPtr self, IntPtr parent, int id, IntPtr evtHandler);
        [DllImport("wx-c")] static extern void wxGridCellTextEditor_SetSize(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern void wxGridCellTextEditor_PaintBackground(IntPtr self, ref Rectangle rectCell, IntPtr attr);
        [DllImport("wx-c")] static extern bool wxGridCellTextEditor_IsAcceptedKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void wxGridCellTextEditor_BeginEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern bool wxGridCellTextEditor_EndEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern void wxGridCellTextEditor_Reset(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellTextEditor_StartingKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void wxGridCellTextEditor_SetParameters(IntPtr self, string parameter);
        [DllImport("wx-c")] static extern IntPtr wxGridCellTextEditor_Clone(IntPtr self);
	
        public GridCellTextEditor()
            : this(wxGridCellTextEditor_ctor(), true) { }

        public GridCellTextEditor(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellTextEditor(IntPtr wxObject, bool memOwn)
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
						wxGridCellTextEditor_dtor(wxObject);
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
		
		~GridCellTextEditor() 
		{
			Dispose();
		}

        public override void Create(Window parent, int id, EvtHandler evtHandler)
        {
            wxGridCellTextEditor_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(evtHandler));
        }

        public override void SetSize(Rectangle rect)
        {
            wxGridCellTextEditor_SetSize(wxObject, ref rect);
        }

        public override void PaintBackground(Rectangle rectCell, GridCellAttr attr)
        {
            wxGridCellTextEditor_PaintBackground(wxObject, ref rectCell, Object.SafePtr(attr));
        }

        public override bool IsAcceptedKey(KeyEvent evt)
        {
            return wxGridCellTextEditor_IsAcceptedKey(wxObject, Object.SafePtr(evt));
        }

        public override void BeginEdit(int row, int col, Grid grid)
        {
            wxGridCellTextEditor_BeginEdit(wxObject, row, col, Object.SafePtr(grid));
        }

        public override bool EndEdit(int row, int col, Grid grid)
        {
            return wxGridCellTextEditor_EndEdit(wxObject, row, col, Object.SafePtr(grid));
        }

        public override void Reset()
        {
            wxGridCellTextEditor_Reset(wxObject);
        }

        public override void StartingKey(KeyEvent evt)
        {
            wxGridCellTextEditor_StartingKey(wxObject, Object.SafePtr(evt));
        }

        public override void SetParameters(string parameter)
        {
            wxGridCellTextEditor_SetParameters(wxObject, parameter);
        }

        public override GridCellEditor Clone()
        {
            return (GridCellEditor)FindObject(wxGridCellTextEditor_Clone(wxObject), typeof(GridCellEditor));
        }
    }

    //-----------------------------------------------------------------------------

    public class GridCellNumberEditor : GridCellTextEditor
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellNumberEditor_ctor(int min, int max);
	[DllImport("wx-c")] static extern void wxGridCellNumberEditor_dtor(IntPtr self);
	[DllImport("wx-c")] static extern void wxGridCellNumberEditor_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
        [DllImport("wx-c")] static extern void wxGridCellNumberEditor_Create(IntPtr self, IntPtr parent, int id, IntPtr evtHandler);
        [DllImport("wx-c")] static extern bool wxGridCellNumberEditor_IsAcceptedKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void wxGridCellNumberEditor_BeginEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern bool wxGridCellNumberEditor_EndEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern void wxGridCellNumberEditor_Reset(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellNumberEditor_StartingKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void wxGridCellNumberEditor_SetParameters(IntPtr self, string parameter);
        [DllImport("wx-c")] static extern IntPtr wxGridCellNumberEditor_Clone(IntPtr self);
	
        public GridCellNumberEditor()
            : this(-1, -1) { }

        public GridCellNumberEditor(int min)
            : this(min, -1) { }

        public GridCellNumberEditor(int min, int max)
            : this(wxGridCellNumberEditor_ctor(min, max), true) 
	{ 
		virtual_Dispose = new Virtual_Dispose(VirtualDispose);
		wxGridCellNumberEditor_RegisterDisposable(wxObject, virtual_Dispose);
	}

        public GridCellNumberEditor(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellNumberEditor(IntPtr wxObject, bool memOwn)
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
						wxGridCellNumberEditor_dtor(wxObject);
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
		
		~GridCellNumberEditor() 
		{
			Dispose();
		}

        public override void Create(Window parent, int id, EvtHandler evtHandler)
        {
            wxGridCellNumberEditor_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(evtHandler));
        }

        public override bool IsAcceptedKey(KeyEvent evt)
        {
            return wxGridCellNumberEditor_IsAcceptedKey(wxObject, Object.SafePtr(evt));
        }

        public override void BeginEdit(int row, int col, Grid grid)
        {
            wxGridCellNumberEditor_BeginEdit(wxObject, row, col, Object.SafePtr(grid));
        }

        public override bool EndEdit(int row, int col, Grid grid)
        {
            return wxGridCellNumberEditor_EndEdit(wxObject, row, col, Object.SafePtr(grid));
        }

        public override void Reset()
        {
            wxGridCellNumberEditor_Reset(wxObject);
        }

        public override void StartingKey(KeyEvent evt)
        {
            wxGridCellNumberEditor_StartingKey(wxObject, Object.SafePtr(evt));
        }

        public override void SetParameters(string parameter)
        {
            wxGridCellNumberEditor_SetParameters(wxObject, parameter);
        }

        public override GridCellEditor Clone()
        {
            return (GridCellEditor)FindObject(wxGridCellNumberEditor_Clone(wxObject), typeof(GridCellEditor));
        }
    }

    //-----------------------------------------------------------------------------

    public class GridCellFloatEditor : GridCellTextEditor
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellFloatEditor_ctor(int width, int precision);
	[DllImport("wx-c")] static extern void wxGridCellFloatEditor_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellFloatEditor_Create(IntPtr self, IntPtr parent, int id, IntPtr evtHandler);
        [DllImport("wx-c")] static extern bool wxGridCellFloatEditor_IsAcceptedKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void wxGridCellFloatEditor_BeginEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern bool wxGridCellFloatEditor_EndEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern void wxGridCellFloatEditor_Reset(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellFloatEditor_StartingKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void wxGridCellFloatEditor_SetParameters(IntPtr self, string parameter);
        [DllImport("wx-c")] static extern IntPtr wxGridCellFloatEditor_Clone(IntPtr self);
	
        public GridCellFloatEditor()
            : this(-1, -1) { }

        public GridCellFloatEditor(int width)
            : this(width, -1) { }

        public GridCellFloatEditor(int width, int precision)
            : this(wxGridCellFloatEditor_ctor(width, precision), true) { }

        public GridCellFloatEditor(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellFloatEditor(IntPtr wxObject, bool memOwn)
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
						wxGridCellFloatEditor_dtor(wxObject);
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
		
		~GridCellFloatEditor() 
		{
			Dispose();
		}

        public override void Create(Window parent, int id, EvtHandler evtHandler)
        {
            wxGridCellFloatEditor_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(evtHandler));
        }

        public override bool IsAcceptedKey(KeyEvent evt)
        {
            return wxGridCellFloatEditor_IsAcceptedKey(wxObject, Object.SafePtr(evt));
        }

        public override void BeginEdit(int row, int col, Grid grid)
        {
            wxGridCellFloatEditor_BeginEdit(wxObject, row, col, Object.SafePtr(grid));
        }

        public override bool EndEdit(int row, int col, Grid grid)
        {
            return wxGridCellFloatEditor_EndEdit(wxObject, row, col, Object.SafePtr(grid));
        }

        public override void Reset()
        {
            wxGridCellFloatEditor_Reset(wxObject);
        }

        public override void StartingKey(KeyEvent evt)
        {
            wxGridCellFloatEditor_StartingKey(wxObject, Object.SafePtr(evt));
        }

        public override void SetParameters(string parameter)
        {
            wxGridCellFloatEditor_SetParameters(wxObject, parameter);
        }

        public override GridCellEditor Clone()
        {
            return (GridCellEditor)FindObject(wxGridCellFloatEditor_Clone(wxObject), typeof(GridCellEditor));
        }
    }

    //-----------------------------------------------------------------------------
    
    public class GridCellBoolEditor : GridCellEditor
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellBoolEditor_ctor();
	[DllImport("wx-c")] static extern void wxGridCellBoolEditor_dtor(IntPtr self);
	[DllImport("wx-c")] static extern void wxGridCellBoolEditor_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
        [DllImport("wx-c")] static extern void wxGridCellBoolEditor_Create(IntPtr self, IntPtr parent, int id, IntPtr evtHandler);
        [DllImport("wx-c")] static extern void wxGridCellBoolEditor_SetSize(IntPtr self, ref Rectangle rect);
        [DllImport("wx-c")] static extern bool wxGridCellBoolEditor_IsAcceptedKey(IntPtr self, IntPtr evt);
        [DllImport("wx-c")] static extern void wxGridCellBoolEditor_BeginEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern bool wxGridCellBoolEditor_EndEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern void wxGridCellBoolEditor_Reset(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellBoolEditor_StartingClick(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridCellBoolEditor_Clone(IntPtr self);
	
        public GridCellBoolEditor()
            : this(wxGridCellBoolEditor_ctor(), true) 
	{ 
		virtual_Dispose = new Virtual_Dispose(VirtualDispose);
		wxGridCellBoolEditor_RegisterDisposable(wxObject, virtual_Dispose);
	}

        public GridCellBoolEditor(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellBoolEditor(IntPtr wxObject, bool memOwn)
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
						wxGridCellBoolEditor_dtor(wxObject);
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
		
		~GridCellBoolEditor() 
		{
			Dispose();
		}

        public override void Create(Window parent, int id, EvtHandler evtHandler)
        {
            wxGridCellBoolEditor_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(evtHandler));
        }

        public override void SetSize(Rectangle rect)
        {
            wxGridCellBoolEditor_SetSize(wxObject, ref rect);
        }

        public override bool IsAcceptedKey(KeyEvent evt)
        {
            return wxGridCellBoolEditor_IsAcceptedKey(wxObject, Object.SafePtr(evt));
        }

        public override void BeginEdit(int row, int col, Grid grid)
        {
            wxGridCellBoolEditor_BeginEdit(wxObject, row, col, Object.SafePtr(grid));
        }
        
        public override bool EndEdit(int row, int col, Grid grid)
        {
            return wxGridCellBoolEditor_EndEdit(wxObject, row, col, Object.SafePtr(grid));
        }
        
        public override void Reset()
        {
            wxGridCellBoolEditor_Reset(wxObject);
        }

        public override void StartingClick()
        {
            wxGridCellBoolEditor_StartingClick(wxObject);
        }
        
        public override GridCellEditor Clone()
        {
            return (GridCellEditor)FindObject(wxGridCellBoolEditor_Clone(wxObject), typeof(GridCellEditor));
        }       
    }
    
    //-----------------------------------------------------------------------------
    
    public class GridCellChoiceEditor : GridCellEditor
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellChoiceEditor_ctor(int n, string[] choices, bool allowOthers);
	[DllImport("wx-c")] static extern void wxGridCellChoiceEditor_dtor(IntPtr self);
	[DllImport("wx-c")] static extern void wxGridCellChoiceEditor_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
        [DllImport("wx-c")] static extern void wxGridCellChoiceEditor_Create(IntPtr self, IntPtr parent, int id, IntPtr evtHandler);
        [DllImport("wx-c")] static extern void wxGridCellChoiceEditor_PaintBackground(IntPtr self, ref Rectangle rectCell, IntPtr attr);
        [DllImport("wx-c")] static extern void wxGridCellChoiceEditor_BeginEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern bool wxGridCellChoiceEditor_EndEdit(IntPtr self, int row, int col, IntPtr grid);
        [DllImport("wx-c")] static extern void wxGridCellChoiceEditor_Reset(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellChoiceEditor_SetParameters(IntPtr self, string parameter);
        [DllImport("wx-c")] static extern IntPtr wxGridCellChoiceEditor_Clone(IntPtr self);
	
        public GridCellChoiceEditor()
            : this(null, false) { }
        
        public GridCellChoiceEditor(string[] choices)
            : this(choices, false) { }
        
        public GridCellChoiceEditor(string[] choices, bool allowOthers)
            : this(wxGridCellChoiceEditor_ctor(choices.Length, choices, allowOthers), true) 
	{ 
		virtual_Dispose = new Virtual_Dispose(VirtualDispose);
		wxGridCellChoiceEditor_RegisterDisposable(wxObject, virtual_Dispose);
	}

        public GridCellChoiceEditor(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellChoiceEditor(IntPtr wxObject, bool memOwn)
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
						wxGridCellChoiceEditor_dtor(wxObject);
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
		
		~GridCellChoiceEditor() 
		{
			Dispose();
		}

        public override void Create(Window parent, int id, EvtHandler evtHandler)
        {
            wxGridCellChoiceEditor_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr(evtHandler));
        }

        public override void PaintBackground(Rectangle rectCell, GridCellAttr attr)
        {
            wxGridCellChoiceEditor_PaintBackground(wxObject, ref rectCell, Object.SafePtr(attr));
        }

        public override void BeginEdit(int row, int col, Grid grid)
        {
            wxGridCellChoiceEditor_BeginEdit(wxObject, row, col, Object.SafePtr(grid));
        }
        
        public override bool EndEdit(int row, int col, Grid grid)
        {
            return wxGridCellChoiceEditor_EndEdit(wxObject, row, col, Object.SafePtr(grid));
        }
        
        public override void Reset()
        {
            wxGridCellChoiceEditor_Reset(wxObject);
        }

        public override void SetParameters(string parameter)
        {
            wxGridCellChoiceEditor_SetParameters(wxObject, parameter);
        }

        public override GridCellEditor Clone()
        {
            return (GridCellEditor)FindObject(wxGridCellChoiceEditor_Clone(wxObject), typeof(GridCellEditor));
        }       
    }
    
    //-----------------------------------------------------------------------------

    public class GridRangeSelectEvent : Event
    {
        [DllImport("wx-c")] static extern IntPtr wxGridRangeSelectEvent_ctor(int id, int type, IntPtr obj, IntPtr topLeft, IntPtr bottomRight, bool sel, bool control, bool shift, bool alt, bool meta);
        [DllImport("wx-c")] static extern IntPtr wxGridRangeSelectEvent_GetTopLeftCoords(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridRangeSelectEvent_GetBottomRightCoords(IntPtr self);
        [DllImport("wx-c")] static extern int wxGridRangeSelectEvent_GetTopRow(IntPtr self);
        [DllImport("wx-c")] static extern int wxGridRangeSelectEvent_GetBottomRow(IntPtr self);
        [DllImport("wx-c")] static extern int wxGridRangeSelectEvent_GetLeftCol(IntPtr self);
        [DllImport("wx-c")] static extern int wxGridRangeSelectEvent_GetRightCol(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridRangeSelectEvent_Selecting(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridRangeSelectEvent_ControlDown(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridRangeSelectEvent_MetaDown(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridRangeSelectEvent_ShiftDown(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridRangeSelectEvent_AltDown(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridRangeSelectEvent_Veto(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridRangeSelectEvent_Allow(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridRangeSelectEvent_IsAllowed(IntPtr self);       
    
        //-----------------------------------------------------------------------------
    
        public GridRangeSelectEvent(IntPtr wxObject)
            : base(wxObject) { }
    
        public GridRangeSelectEvent(int id, int type, Object obj, GridCellCoords topLeft, GridCellCoords bottomRight, bool sel, bool control, bool shift, bool alt, bool meta)
            : base(wxGridRangeSelectEvent_ctor(id, type, Object.SafePtr(obj), Object.SafePtr(topLeft), Object.SafePtr(bottomRight), sel, control, shift, alt, meta)) { }
    
            //-----------------------------------------------------------------------------
    
        public GridCellCoords TopLeftCoords
        {
            get { return new GridCellCoords(wxGridRangeSelectEvent_GetTopLeftCoords(wxObject)); }
        }
    
        public GridCellCoords BottomRightCoords
        {
            get { return new GridCellCoords(wxGridRangeSelectEvent_GetBottomRightCoords(wxObject)); }
        }
    
        //-----------------------------------------------------------------------------
    
        public int TopRow
        {
            get { return wxGridRangeSelectEvent_GetTopRow(wxObject); }
        }
    
        public int BottomRow
        {
            get { return wxGridRangeSelectEvent_GetBottomRow(wxObject); }
        }
    
        //-----------------------------------------------------------------------------
    
        public int LeftCol
        {
            get { return wxGridRangeSelectEvent_GetLeftCol(wxObject); }
        }
    
        public int RightCol
        {
            get { return wxGridRangeSelectEvent_GetRightCol(wxObject); }
        }
    
        //-----------------------------------------------------------------------------
    
        public bool Selecting
        {
            get { return wxGridRangeSelectEvent_Selecting(wxObject); }
        }
    
        //-----------------------------------------------------------------------------
    
        public bool ControlDown
        {
            get { return wxGridRangeSelectEvent_ControlDown(wxObject); }
        }
    
        public bool MetaDown
        {
            get { return wxGridRangeSelectEvent_MetaDown(wxObject); }
        }
    
        public bool ShiftDown
        {
            get { return wxGridRangeSelectEvent_ShiftDown(wxObject); }
        }
    
        public bool AltDown
        {
            get { return wxGridRangeSelectEvent_AltDown(wxObject); }
        }
        
        //-----------------------------------------------------------------------------     
        
        public void Veto()
        {
            wxGridRangeSelectEvent_Veto(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public void Allow()
        {
            wxGridRangeSelectEvent_Allow(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public bool Allowed
        {
            get { return wxGridRangeSelectEvent_IsAllowed(wxObject); }
        }                       
    }

    public class GridCellWorker : Object //ClientData
    {
        private delegate void Virtual_SetParameters(IntPtr param);

		private Virtual_SetParameters virtual_SetParameters;
    
        [DllImport("wx-c")] static extern IntPtr wxGridCellWorker_ctor();
        [DllImport("wx-c")] static extern void wxGridCellWorker_RegisterVirtual(IntPtr self, Virtual_SetParameters setParameters);
        [DllImport("wx-c")] static extern void wxGridCellWorker_IncRef(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellWorker_DecRef(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellWorker_SetParameters(IntPtr self, string parms);
	
        //-----------------------------------------------------------------------------
        
        public GridCellWorker(IntPtr wxObject) 
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellWorker(IntPtr wxObject, bool memOwn)
			: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}
	
        public GridCellWorker()
            : this(wxGridCellWorker_ctor(), true) 
        { 
			virtual_SetParameters = new Virtual_SetParameters(DoSetParameters);
            wxGridCellWorker_RegisterVirtual(wxObject, virtual_SetParameters);
        }
	
	//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				memOwn = false;
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~GridCellWorker() 
		{
			Dispose();
		}
        
        //-----------------------------------------------------------------------------
        
        public void IncRef()
        {
            wxGridCellWorker_IncRef(wxObject);
        }
        
        public void DecRef()
        {
            wxGridCellWorker_DecRef(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        private void DoSetParameters(IntPtr param)
        {
            SetParameters(new wxString(param));
        }
        
        public virtual void SetParameters(string param)
        {
            wxGridCellWorker_SetParameters(wxObject, param);
        }
    }
    
    //-----------------------------------------------------------------------------

    public class GridEditorCreatedEvent : CommandEvent 
    {
            [DllImport("wx-c")] static extern IntPtr wxGridEditorCreatedEvent_ctor(int id, int type, IntPtr obj, int row, int col, IntPtr ctrl);
            [DllImport("wx-c")] static extern int    wxGridEditorCreatedEvent_GetRow(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGridEditorCreatedEvent_GetCol(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGridEditorCreatedEvent_GetControl(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGridEditorCreatedEvent_SetRow(IntPtr self, int row);
            [DllImport("wx-c")] static extern void   wxGridEditorCreatedEvent_SetCol(IntPtr self, int col);
            [DllImport("wx-c")] static extern void   wxGridEditorCreatedEvent_SetControl(IntPtr self, IntPtr ctrl);

            //-----------------------------------------------------------------------------
    
            public GridEditorCreatedEvent(IntPtr wxObject)
            : base(wxObject) { } 
    
            public GridEditorCreatedEvent(int id, int type, Object obj, int row, int col, Control ctrl)
            : this(wxGridEditorCreatedEvent_ctor(id, type, Object.SafePtr(obj), row, col, Object.SafePtr(ctrl))) { }
    
            //-----------------------------------------------------------------------------
    
            public int Row
            {
            get { return wxGridEditorCreatedEvent_GetRow(wxObject); }
            set { wxGridEditorCreatedEvent_SetRow(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int Col
            {
            get { return wxGridEditorCreatedEvent_GetCol(wxObject); }
            set { wxGridEditorCreatedEvent_SetCol(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public Control Control
            {
            get { return (Control)FindObject(wxGridEditorCreatedEvent_GetControl(wxObject), typeof(Control)); }
            set { wxGridEditorCreatedEvent_SetControl(wxObject, Object.SafePtr(value)); }
            }
    }
    
    //-----------------------------------------------------------------------------

    public class Grid : ScrolledWindow
    {
            [DllImport("wx-c")] static extern IntPtr wxGrid_ctor();
            [DllImport("wx-c")] static extern IntPtr wxGrid_ctorFull(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
            [DllImport("wx-c")] static extern bool   wxGrid_CreateGrid(IntPtr self, int numRows, int numCols,  int selmode);
            [DllImport("wx-c")] static extern void   wxGrid_SetSelectionMode(IntPtr self, int selmode);
            [DllImport("wx-c")] static extern int    wxGrid_GetNumberRows(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetNumberCols(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetTable(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_SetTable(IntPtr self, IntPtr table, bool takeOwnership, int select);
            [DllImport("wx-c")] static extern void   wxGrid_ClearGrid(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_InsertRows(IntPtr self, int pos, int numRows, bool updateLabels);
            [DllImport("wx-c")] static extern bool   wxGrid_AppendRows(IntPtr self, int numRows, bool updateLabels);
            [DllImport("wx-c")] static extern bool   wxGrid_DeleteRows(IntPtr self, int pos, int numRows, bool updateLabels);
            [DllImport("wx-c")] static extern bool   wxGrid_InsertCols(IntPtr self, int pos, int numCols, bool updateLabels);
            [DllImport("wx-c")] static extern bool   wxGrid_AppendCols(IntPtr self, int numCols, bool updateLabels);
            [DllImport("wx-c")] static extern bool   wxGrid_DeleteCols(IntPtr self, int pos, int numCols, bool updateLabels);
            [DllImport("wx-c")] static extern void   wxGrid_BeginBatch(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_EndBatch(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetBatchCount(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_ForceRefresh(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_IsEditable(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_EnableEditing(IntPtr self, bool edit);
            [DllImport("wx-c")] static extern void   wxGrid_EnableCellEditControl(IntPtr self, bool enable);
            [DllImport("wx-c")] static extern void   wxGrid_DisableCellEditControl(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_CanEnableCellControl(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_IsCellEditControlEnabled(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_IsCellEditControlShown(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_IsCurrentCellReadOnly(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_ShowCellEditControl(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_HideCellEditControl(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SaveEditControlValue(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_YToRow(IntPtr self, int y);
            [DllImport("wx-c")] static extern int    wxGrid_XToCol(IntPtr self, int x);
            [DllImport("wx-c")] static extern int    wxGrid_YToEdgeOfRow(IntPtr self, int y);
            [DllImport("wx-c")] static extern int    wxGrid_XToEdgeOfCol(IntPtr self, int x);
            [DllImport("wx-c")] static extern void   wxGrid_CellToRect(IntPtr self, int row, int col, ref Rectangle rect);
            [DllImport("wx-c")] static extern int    wxGrid_GetGridCursorRow(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetGridCursorCol(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_IsVisible(IntPtr self, int row, int col, bool wholeCellVisible);
            [DllImport("wx-c")] static extern void   wxGrid_MakeCellVisible(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetGridCursor(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorUp(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorDown(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorLeft(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorRight(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern bool   wxGrid_MovePageDown(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_MovePageUp(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorUpBlock(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorDownBlock(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorLeftBlock(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern bool   wxGrid_MoveCursorRightBlock(IntPtr self, bool expandSelection);
            [DllImport("wx-c")] static extern int    wxGrid_GetDefaultRowLabelSize(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetRowLabelSize(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetDefaultColLabelSize(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetColLabelSize(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetLabelBackgroundColour(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetLabelTextColour(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetLabelFont(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_GetRowLabelAlignment(IntPtr self, out int horiz, out int vert);
            [DllImport("wx-c")] static extern void   wxGrid_GetColLabelAlignment(IntPtr self, out int horiz, out int vert);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetRowLabelValue(IntPtr self, int row);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetColLabelValue(IntPtr self, int col);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetGridLineColour(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellHighlightColour(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetCellHighlightPenWidth(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetCellHighlightROPenWidth(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowLabelSize(IntPtr self, int width);
            [DllImport("wx-c")] static extern void   wxGrid_SetColLabelSize(IntPtr self, int height);
            [DllImport("wx-c")] static extern void   wxGrid_SetLabelBackgroundColour(IntPtr self, IntPtr col);
            [DllImport("wx-c")] static extern void   wxGrid_SetLabelTextColour(IntPtr self, IntPtr col);
            [DllImport("wx-c")] static extern void   wxGrid_SetLabelFont(IntPtr self, IntPtr fnt);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowLabelAlignment(IntPtr self, int horiz, int vert);
            [DllImport("wx-c")] static extern void   wxGrid_SetColLabelAlignment(IntPtr self, int horiz, int vert);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowLabelValue(IntPtr self, int row, string val);
            [DllImport("wx-c")] static extern void   wxGrid_SetColLabelValue(IntPtr self, int col, string val);
            [DllImport("wx-c")] static extern void   wxGrid_SetGridLineColour(IntPtr self, IntPtr col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellHighlightColour(IntPtr self, IntPtr col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellHighlightPenWidth(IntPtr self, int width);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellHighlightROPenWidth(IntPtr self, int width);
            [DllImport("wx-c")] static extern void   wxGrid_EnableDragRowSize(IntPtr self, bool enable);
            [DllImport("wx-c")] static extern void   wxGrid_DisableDragRowSize(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_CanDragRowSize(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_EnableDragColSize(IntPtr self, bool enable);
            [DllImport("wx-c")] static extern void   wxGrid_DisableDragColSize(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_CanDragColSize(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_EnableDragGridSize(IntPtr self, bool enable);
            [DllImport("wx-c")] static extern void   wxGrid_DisableDragGridSize(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_CanDragGridSize(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetAttr(IntPtr self, int row, int col, IntPtr attr);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowAttr(IntPtr self, int row, IntPtr attr);
            [DllImport("wx-c")] static extern void   wxGrid_SetColAttr(IntPtr self, int col, IntPtr attr);
            [DllImport("wx-c")] static extern void   wxGrid_SetColFormatBool(IntPtr self, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetColFormatNumber(IntPtr self, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetColFormatFloat(IntPtr self, int col, int width, int precision);
            [DllImport("wx-c")] static extern void   wxGrid_SetColFormatCustom(IntPtr self, int col, string typeName);
            [DllImport("wx-c")] static extern void   wxGrid_EnableGridLines(IntPtr self, bool enable);
            [DllImport("wx-c")] static extern bool   wxGrid_GridLinesEnabled(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetDefaultRowSize(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetRowSize(IntPtr self, int row);
            [DllImport("wx-c")] static extern int    wxGrid_GetDefaultColSize(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetColSize(IntPtr self, int col);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultCellBackgroundColour(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellBackgroundColour(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultCellTextColour(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellTextColour(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultCellFont(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellFont(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_GetDefaultCellAlignment(IntPtr self, ref int horiz, ref int vert);
            [DllImport("wx-c")] static extern void   wxGrid_GetCellAlignment(IntPtr self, int row, int col, ref int horiz, ref int vert);
            [DllImport("wx-c")] static extern bool   wxGrid_GetDefaultCellOverflow(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_GetCellOverflow(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_GetCellSize(IntPtr self, int row, int col, ref int num_rows, ref int num_cols);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultRowSize(IntPtr self, int height, bool resizeExistingRows);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowSize(IntPtr self, int row, int height);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultColSize(IntPtr self, int width, bool resizeExistingCols);
            [DllImport("wx-c")] static extern void   wxGrid_SetColSize(IntPtr self, int col, int width);
            [DllImport("wx-c")] static extern void   wxGrid_AutoSizeColumn(IntPtr self, int col, bool setAsMin);
            [DllImport("wx-c")] static extern void   wxGrid_AutoSizeRow(IntPtr self, int row, bool setAsMin);
            [DllImport("wx-c")] static extern void   wxGrid_AutoSizeColumns(IntPtr self, bool setAsMin);
            [DllImport("wx-c")] static extern void   wxGrid_AutoSizeRows(IntPtr self, bool setAsMin);
            [DllImport("wx-c")] static extern void   wxGrid_AutoSize(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetColMinimalWidth(IntPtr self, int col, int width);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowMinimalHeight(IntPtr self, int row, int width);
            [DllImport("wx-c")] static extern void   wxGrid_SetColMinimalAcceptableWidth(IntPtr self, int width);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowMinimalAcceptableHeight(IntPtr self, int width);
            [DllImport("wx-c")] static extern int    wxGrid_GetColMinimalAcceptableWidth(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetRowMinimalAcceptableHeight(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultCellBackgroundColour(IntPtr self, IntPtr wxColour);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultCellTextColour(IntPtr self, IntPtr wxColour);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultCellFont(IntPtr self, IntPtr wxFont);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellFont(IntPtr self, int row, int col, IntPtr wxFont );
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultCellAlignment(IntPtr self, int horiz, int vert);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellAlignmentHV(IntPtr self, int row, int col, int horiz, int vert);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultCellOverflow(IntPtr self, bool allow);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellOverflow(IntPtr self, int row, int col, bool allow);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellSize(IntPtr self, int row, int col, int num_rows, int num_cols);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultRenderer(IntPtr self, IntPtr renderer);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellRenderer(IntPtr self, int row, int col, IntPtr renderer);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultRenderer(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellRenderer(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetDefaultEditor(IntPtr self, IntPtr editor);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellEditor(IntPtr self, int row, int col, IntPtr editor);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultEditor(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellEditor(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellValue(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellValue(IntPtr self, int row, int col, string s);
            [DllImport("wx-c")] static extern bool   wxGrid_IsReadOnly(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetReadOnly(IntPtr self, int row, int col, bool isReadOnly);
            [DllImport("wx-c")] static extern void   wxGrid_SelectRow(IntPtr self, int row, bool addToSelected);
            [DllImport("wx-c")] static extern void   wxGrid_SelectCol(IntPtr self, int col, bool addToSelected);
            [DllImport("wx-c")] static extern void   wxGrid_SelectBlock(IntPtr self, int topRow, int leftCol, int bottomRow, int rightCol, bool addToSelected);
            [DllImport("wx-c")] static extern void   wxGrid_SelectAll(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_IsSelection(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_DeselectRow(IntPtr self, int row);
            [DllImport("wx-c")] static extern void   wxGrid_DeselectCol(IntPtr self, int col);
            [DllImport("wx-c")] static extern void   wxGrid_DeselectCell(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_ClearSelection(IntPtr self);
            [DllImport("wx-c")] static extern bool   wxGrid_IsInSelection(IntPtr self, int row, int col);
            //[DllImport("wx-c")] static extern IntPtr wxGrid_GetSelectedCells(IntPtr self);
            //[DllImport("wx-c")] static extern IntPtr wxGrid_GetSelectionBlockTopLeft(IntPtr self);
            //[DllImport("wx-c")] static extern IntPtr wxGrid_GetSelectionBlockBottomRight(IntPtr self);
            //[DllImport("wx-c")] static extern IntPtr wxGrid_GetSelectedRows(IntPtr self);
            //[DllImport("wx-c")] static extern IntPtr wxGrid_GetSelectedCols(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_BlockToDeviceRect(IntPtr self, IntPtr topLeft, IntPtr bottomRight, ref Rectangle rect);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetSelectionBackground(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetSelectionForeground(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetSelectionBackground(IntPtr self, IntPtr c);
            [DllImport("wx-c")] static extern void   wxGrid_SetSelectionForeground(IntPtr self, IntPtr c);
            [DllImport("wx-c")] static extern void   wxGrid_RegisterDataType(IntPtr self, string typeName, IntPtr renderer, IntPtr editor);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultEditorForCell(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultRendererForCell(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultEditorForType(IntPtr self, string typeName);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDefaultRendererForType(IntPtr self, string typeName);
            [DllImport("wx-c")] static extern void   wxGrid_SetMargins(IntPtr self, int extraWidth, int extraHeight);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetGridWindow(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetGridRowLabelWindow(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetGridColLabelWindow(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetGridCornerLabelWindow(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_UpdateDimensions(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetRows(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetCols(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetCursorRow(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetCursorColumn(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetScrollPosX(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetScrollPosY(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetScrollX(IntPtr self, int x);
            [DllImport("wx-c")] static extern void   wxGrid_SetScrollY(IntPtr self, int y);
            [DllImport("wx-c")] static extern void   wxGrid_SetColumnWidth(IntPtr self, int col, int width);
            [DllImport("wx-c")] static extern int    wxGrid_GetColumnWidth(IntPtr self, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetRowHeight(IntPtr self, int row, int height);
            [DllImport("wx-c")] static extern int    wxGrid_GetViewHeight(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetViewWidth(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetLabelSize(IntPtr self, int orientation, int sz);
            [DllImport("wx-c")] static extern int    wxGrid_GetLabelSize(IntPtr self, int orientation);
            [DllImport("wx-c")] static extern void   wxGrid_SetLabelAlignment(IntPtr self, int orientation, int align);
            [DllImport("wx-c")] static extern int    wxGrid_GetLabelAlignment(IntPtr self, int orientation, int align);
            [DllImport("wx-c")] static extern void   wxGrid_SetLabelValue(IntPtr self, int orientation, string val, int pos);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetLabelValue(IntPtr self, int orientation, int pos);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellTextFontGrid(IntPtr self);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetCellTextFont(IntPtr self, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellTextFontGrid(IntPtr self, IntPtr fnt);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellTextFont(IntPtr self, IntPtr fnt, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellTextColour(IntPtr self, int row, int col, IntPtr val);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellTextColourGrid(IntPtr self, IntPtr col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellBackgroundColourGrid(IntPtr self, IntPtr col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellBackgroundColour(IntPtr self, int row, int col, IntPtr colour);
            [DllImport("wx-c")] static extern bool   wxGrid_GetEditable(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetEditable(IntPtr self, bool edit);
            [DllImport("wx-c")] static extern bool   wxGrid_GetEditInPlace(IntPtr self);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellAlignment(IntPtr self, int align, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellAlignmentGrid(IntPtr self, int align);
            [DllImport("wx-c")] static extern void   wxGrid_SetCellBitmap(IntPtr self, IntPtr bitmap, int row, int col);
            [DllImport("wx-c")] static extern void   wxGrid_SetDividerPen(IntPtr self, IntPtr pen);
            [DllImport("wx-c")] static extern IntPtr wxGrid_GetDividerPen(IntPtr self);
            [DllImport("wx-c")] static extern int    wxGrid_GetRowHeight(IntPtr self, int row);

        //-----------------------------------------------------------------------------

        public Grid(IntPtr wxObject)
            : base(wxObject) { }

        public Grid()
            : this(wxGrid_ctor()) { }

        public Grid(Window parent, int id)
            : this(parent, id, wxDefaultPosition, wxDefaultSize, wxWANTS_CHARS, "grid") { }
	    
        public Grid(Window parent, int id, Point pos)
            : this(parent, id, pos, wxDefaultSize, wxWANTS_CHARS, "grid") { }
	    
        public Grid(Window parent, int id, Point pos, Size size)
            : this(parent, id, pos, size, wxWANTS_CHARS, "grid") { }
	    
        public Grid(Window parent, int id, Point pos, Size size, long style)
            : this(parent, id, pos, size, style, "grid") { }

        public Grid(Window parent, int id, Point pos, Size size, long style, string name)
            : this(wxGrid_ctorFull(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name)) { }

        //public  Grid(Window parent, int x, int y, int w, int h, long style, string name)
        //    : base(wxGrid_ctor(Object.SafePtr(parent), x, y, w, h, style, name)) { }
	
	//---------------------------------------------------------------------
	// ctors with self created id
	
	public Grid(Window parent)
            : this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxWANTS_CHARS, "grid") { }
	    
        public Grid(Window parent, Point pos)
            : this(parent, Window.UniqueID, pos, wxDefaultSize, wxWANTS_CHARS, "grid") { }
	    
        public Grid(Window parent, Point pos, Size size)
            : this(parent, Window.UniqueID, pos, size, wxWANTS_CHARS, "grid") { }
	    
        public Grid(Window parent, Point pos, Size size, long style)
            : this(parent, Window.UniqueID, pos, size, style, "grid") { }

        public Grid(Window parent, Point pos, Size size, long style, string name)
		: this(parent, Window.UniqueID, pos, size, style, name) {}

        //-----------------------------------------------------------------------------

        public bool CreateGrid(int numRows, int numCols)
        { return CreateGrid(numRows, numCols, GridSelectionMode.wxGridSelectCells); }

            public bool CreateGrid(int numRows, int numCols, GridSelectionMode selmode)
            {
            return wxGrid_CreateGrid(wxObject, numRows, numCols, (int)selmode);
            }

        //-----------------------------------------------------------------------------

            public GridSelectionMode SelectionMode
            {
            set { wxGrid_SetSelectionMode(wxObject, (int)value); }
            //get { return wxGrid_GetSelectionMode(wxObject); }
            }
    
            //-----------------------------------------------------------------------------

            public int NumberRows
            {
            get { return wxGrid_GetNumberRows(wxObject); }
            }
    
            public int NumberCols
            {
            get { return wxGrid_GetNumberCols(wxObject); }
            }

        //-----------------------------------------------------------------------------

            public GridTableBase Table
            {
            get { return (GridTableBase)FindObject(wxGrid_GetTable(wxObject), typeof(GridTableBase)); }
            }
        
        public bool SetTable(GridTableBase table)
        {
            return SetTable(table, false, GridSelectionMode.wxGridSelectCells ); 
        }
        
        public bool SetTable(GridTableBase table, bool takeOwnerShip)
        {
            return SetTable(table, takeOwnerShip, GridSelectionMode.wxGridSelectCells);
        }
    
            public bool SetTable(GridTableBase table, bool takeOwnership, GridSelectionMode select)
            {
            return wxGrid_SetTable(wxObject, Object.SafePtr(table), takeOwnership, (int)select);
            }
    
            //-----------------------------------------------------------------------------
    
            public void ClearGrid()
            {
            wxGrid_ClearGrid(wxObject);
            }

            //-----------------------------------------------------------------------------
        
        public bool InsertRows()
        {
            return InsertRows(0, 1, true);
        }
        
        public bool InsertRows(int pos)
        {
            return InsertRows(pos, 1, true);
        }
        
        public bool InsertRows(int pos, int numRows)
        {
            return InsertRows(pos, numRows, true);
        }   
    
            public bool InsertRows(int pos, int numRows, bool updateLabels)
            {
            return wxGrid_InsertRows(wxObject, pos, numRows, updateLabels);
        }
        
        public bool AppendRows()
        {
            return AppendRows(1, true);
        }
        
        public bool AppendRows(int numRows)
        {
            return AppendRows(numRows, true);
        }
    
            public bool AppendRows(int numRows, bool updateLabels)
            {
            return wxGrid_AppendRows(wxObject, numRows, updateLabels);
            }
        
        public bool DeleteRows()
        {
            return DeleteRows(0, 1, true);
        }
        
        public bool DeleteRows(int pos)
        {
            return DeleteRows(pos, 1, true);
        }
        
        public bool DeleteRows(int pos, int numRows)
        {
            return DeleteRows(pos, numRows, true);
        }
    
            public bool DeleteRows(int pos, int numRows, bool updateLabels)
            {
            return wxGrid_DeleteRows(wxObject, pos, numRows, updateLabels);
            }

        //-----------------------------------------------------------------------------
    
        public bool InsertCols()
        {
            return InsertCols(0, 1, true);
        }
        
        public bool InsertCols(int pos)
        {
            return InsertCols(pos, 1, true);
        }
        
        public bool InsertCols(int pos, int numRows)
        {
            return InsertCols(pos, numRows, true);
        }   
    
            public bool InsertCols(int pos, int numCols, bool updateLabels)
            {
            return wxGrid_InsertCols(wxObject, pos, numCols, updateLabels);
            }
        
        public bool AppendCols()
        {
            return AppendCols(1, true);
        }
        
        public bool AppendCols(int numCols)
        {
            return AppendCols(numCols, true);
        }
    
            public bool AppendCols(int numCols, bool updateLabels)
            {
            return wxGrid_AppendCols(wxObject, numCols, updateLabels);
            }
        
        public bool DeleteCols()
        {
            return DeleteCols(0, 1, true);
        }
        
        public bool DeleteCols(int pos)
        {
            return DeleteCols(pos, 1, true);
        }
        
        public bool DeleteCols(int pos, int numRows)
        {
            return DeleteCols(pos, numRows, true);
        }
    
            public bool DeleteCols(int pos, int numCols, bool updateLabels)
            {
            return wxGrid_DeleteCols(wxObject, pos, numCols, updateLabels);
            }

            //-----------------------------------------------------------------------------
    
            public void BeginBatch()
            {
            wxGrid_BeginBatch(wxObject);
            }
    
            public void EndBatch()
            {
            wxGrid_EndBatch(wxObject);
            }
    
            public int BatchCount
            {
            get { return wxGrid_GetBatchCount(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void ForceRefresh()
            {
            wxGrid_ForceRefresh(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool IsEditable
            {
            get { return wxGrid_IsEditable(wxObject); }
            set { wxGrid_EnableEditing(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public bool CellEditControlEnabled
            {
            set { wxGrid_EnableCellEditControl(wxObject, value); }
            get { return wxGrid_IsCellEditControlEnabled(wxObject); }
            }
    
            public void DisableCellEditControl()
            {
            wxGrid_DisableCellEditControl(wxObject);
            }
    
            public bool CanEnableCellControl
            {
            get { return wxGrid_CanEnableCellControl(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public bool IsCellEditControlShown
            {
            get { return wxGrid_IsCellEditControlShown(wxObject); }
            }
    
            public bool IsCurrentCellReadOnly
            {
            get { return wxGrid_IsCurrentCellReadOnly(wxObject); }
            }

            //-----------------------------------------------------------------------------
    
            public void ShowCellEditControl()
            {
            wxGrid_ShowCellEditControl(wxObject);
            }
    
            public void HideCellEditControl()
            {
            wxGrid_HideCellEditControl(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SaveEditControlValue()
            {
            wxGrid_SaveEditControlValue(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            /*public void XYToCell(int x, int y,  GridCellCoords )
            {
                    wxGrid_XYToCell(wxObject, x, y, Object.SafePtr(GridCellCoords ));
            }*/
    
            //-----------------------------------------------------------------------------
    
            public int YToRow(int y)
            {
            return wxGrid_YToRow(wxObject, y);
            }
    
            public int XToCol(int x)
            {
            return wxGrid_XToCol(wxObject, x);
            }
    
            public int YToEdgeOfRow(int y)
            {
            return wxGrid_YToEdgeOfRow(wxObject, y);
            }
    
            public int XToEdgeOfCol(int x)
            {
            return wxGrid_XToEdgeOfCol(wxObject, x);
            }
    
            //-----------------------------------------------------------------------------
    
            public Rectangle CellToRect(int row, int col)
            {
            Rectangle rect = new Rectangle();
            wxGrid_CellToRect(wxObject, row, col, ref rect);
            return rect;
            }
    
            //-----------------------------------------------------------------------------
    
            public int GridCursorRow
            {
            get { return wxGrid_GetGridCursorRow(wxObject); }
            }
    
            public int GridCursorCol
            {
            get { return wxGrid_GetGridCursorCol(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public bool IsVisible(int row, int col, bool wholeCellVisible)
            {
            return wxGrid_IsVisible(wxObject, row, col, wholeCellVisible);
            }
    
            //-----------------------------------------------------------------------------
    
            public void MakeCellVisible(int row, int col)
            {
            wxGrid_MakeCellVisible(wxObject, row, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetGridCursor(int row, int col)
            {
            wxGrid_SetGridCursor(wxObject, row, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool MoveCursorUp(bool expandSelection)
            {
            return wxGrid_MoveCursorUp(wxObject, expandSelection);
            }
    
            public bool MoveCursorDown(bool expandSelection)
            {
            return wxGrid_MoveCursorDown(wxObject, expandSelection);
            }
    
            public bool MoveCursorLeft(bool expandSelection)
            {
            return wxGrid_MoveCursorLeft(wxObject, expandSelection);
            }
    
            public bool MoveCursorRight(bool expandSelection)
            {
            return wxGrid_MoveCursorRight(wxObject, expandSelection);
            }
    
            public bool MovePageDown()
            {
            return wxGrid_MovePageDown(wxObject);
            }
    
            public bool MovePageUp()
            {
            return wxGrid_MovePageUp(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool MoveCursorUpBlock(bool expandSelection)
            {
            return wxGrid_MoveCursorUpBlock(wxObject, expandSelection);
            }
    
            public bool MoveCursorDownBlock(bool expandSelection)
            {
            return wxGrid_MoveCursorDownBlock(wxObject, expandSelection);
            }
    
            public bool MoveCursorLeftBlock(bool expandSelection)
            {
            return wxGrid_MoveCursorLeftBlock(wxObject, expandSelection);
            }
    
            public bool MoveCursorRightBlock(bool expandSelection)
            {
            return wxGrid_MoveCursorRightBlock(wxObject, expandSelection);
            }
    
            //-----------------------------------------------------------------------------
    
            public int DefaultRowLabelSize
            {
            get { return wxGrid_GetDefaultRowLabelSize(wxObject); }
            }
    
            public int RowLabelSize
            {
            get { return wxGrid_GetRowLabelSize(wxObject); }
            set { wxGrid_SetRowLabelSize(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int DefaultColLabelSize
            {
            get { return wxGrid_GetDefaultColLabelSize(wxObject); }
            }
    
            public int ColLabelSize
            {
            get { return wxGrid_GetColLabelSize(wxObject); }
            set { wxGrid_SetColLabelSize(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour LabelBackgroundColour
            {
            get { return new Colour(wxGrid_GetLabelBackgroundColour(wxObject), true); }
            set { wxGrid_SetLabelBackgroundColour(wxObject, Object.SafePtr(value)); }
            }
    
            public Colour LabelTextColour
            {
            get { return new Colour(wxGrid_GetLabelTextColour(wxObject), true); }
            set { wxGrid_SetLabelTextColour(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public Font LabelFont
            {
            get { return new Font(wxGrid_GetLabelFont(wxObject)); }
            set { wxGrid_SetLabelFont(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void GetRowLabelAlignment(out int horiz, out int vert)
            {
            wxGrid_GetRowLabelAlignment(wxObject, out horiz, out vert);
            }
    
            public void GetColLabelAlignment(out int horiz, out int vert)
            {
            wxGrid_GetColLabelAlignment(wxObject, out horiz, out vert);
            }
    
            //-----------------------------------------------------------------------------
    
            public string GetRowLabelValue(int row)
            {
            return new wxString(wxGrid_GetRowLabelValue(wxObject, row), true);
            }
    
            public string GetColLabelValue(int col)
            {
            return new wxString(wxGrid_GetColLabelValue(wxObject, col), true);
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour GridLineColour
            {
            get { return new Colour(wxGrid_GetGridLineColour(wxObject), true); }
            set { wxGrid_SetGridLineColour(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour CellHighlightColour
            {
            get { return new Colour(wxGrid_GetCellHighlightColour(wxObject), true); }
            set { wxGrid_SetCellHighlightColour(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int CellHighlightPenWidth
            {
            get { return wxGrid_GetCellHighlightPenWidth(wxObject); }
            set { wxGrid_SetCellHighlightPenWidth(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int CellHighlightROPenWidth
            {
            get { return wxGrid_GetCellHighlightROPenWidth(wxObject); }
            set { wxGrid_SetCellHighlightROPenWidth(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetRowLabelAlignment(int horiz, int vert)
            {
            wxGrid_SetRowLabelAlignment(wxObject, horiz, vert);
            }
    
            public void SetColLabelAlignment(int horiz, int vert)
            {
            wxGrid_SetColLabelAlignment(wxObject, horiz, vert);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetRowLabelValue(int row, string str)
            {
            wxGrid_SetRowLabelValue(wxObject, row, str);
            }
    
            public void SetColLabelValue(int col, string str)
            {
            wxGrid_SetColLabelValue(wxObject, col, str);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool DragRowSizeEnabled
            {
            set { wxGrid_EnableDragRowSize(wxObject, value); }
            get { return wxGrid_CanDragRowSize(wxObject); }
            }
    
            public void DisableDragRowSize()
            {
            wxGrid_DisableDragRowSize(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool DragColSizeEnabled
            {
            set { wxGrid_EnableDragColSize(wxObject, value); }
            get { return wxGrid_CanDragColSize(wxObject); }
            }
    
            public void DisableDragColSize()
            {
            wxGrid_DisableDragColSize(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool DragGridSizeEnabled
            {
            set { wxGrid_EnableDragGridSize(wxObject, value); }
            get { return wxGrid_CanDragGridSize(wxObject); }
            }
    
            public void DisableDragGridSize()
            {
            wxGrid_DisableDragGridSize(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetAttr(int row, int col, GridCellAttr attr)
            {
            wxGrid_SetAttr(wxObject, row, col, Object.SafePtr(attr));
            }
    
            public void SetRowAttr(int row, GridCellAttr attr)
            {
            wxGrid_SetRowAttr(wxObject, row, Object.SafePtr(attr));
            }
    
            public void SetColAttr(int col, GridCellAttr attr)
            {
            wxGrid_SetColAttr(wxObject, col, Object.SafePtr(attr));
            }
    
            //-----------------------------------------------------------------------------
    
            public int ColFormatBool
            {
            set { wxGrid_SetColFormatBool(wxObject, value); }
            }
    
            public int ColFormatNumber
            {
            set { wxGrid_SetColFormatNumber(wxObject, value); }
            }
        
        public void SetColFormatFloat(int col)
        {
            SetColFormatFloat(col, -1, -1);
        }
        
        public void SetColFormatFloat(int col, int width)
        {
            SetColFormatFloat(col, width, -1);
        }
    
            public void SetColFormatFloat(int col, int width, int precision)
            {
            wxGrid_SetColFormatFloat(wxObject, col, width, precision);
            }
    
            public void SetColFormatCustom(int col, string typeName)
            {
            wxGrid_SetColFormatCustom(wxObject, col, typeName);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool GridLinesEnabled
            {
            set { wxGrid_EnableGridLines(wxObject, value); } 
            get { return wxGrid_GridLinesEnabled(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int DefaultRowSize
            {
            get { return wxGrid_GetDefaultRowSize(wxObject); }
            }
    
            public int GetRowSize(int row)
            {
            return wxGrid_GetRowSize(wxObject, row);
            }
    
            public int DefaultColSize
            {
            get { return wxGrid_GetDefaultColSize(wxObject); }
            }
    
            public int GetColSize(int col)
            {
            return wxGrid_GetColSize(wxObject, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour DefaultCellBackgroundColour
            {
            get { return new Colour(wxGrid_GetDefaultCellBackgroundColour(wxObject), true); }
            set { wxGrid_SetDefaultCellBackgroundColour(wxObject, Object.SafePtr(value)); }
            }
    
            public Colour DefaultCellTextColour
            {
            get { return new Colour(wxGrid_GetDefaultCellTextColour(wxObject), true); }
            set { wxGrid_SetDefaultCellTextColour(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public Font DefaultCellFont
            {
            get { return new Font(wxGrid_GetDefaultCellFont(wxObject)); }
            set { wxGrid_SetDefaultCellFont(wxObject, Object.SafePtr(value)); }
            }
    
            public Font GetCellFont(int row, int col)
            {
            return new Font(wxGrid_GetCellFont(wxObject, row, col));
            }
    
            //-----------------------------------------------------------------------------
    
            public void GetDefaultCellAlignment(ref int horiz, ref int vert)
            {
            wxGrid_GetDefaultCellAlignment(wxObject, ref horiz, ref vert);
            }
    
            //-----------------------------------------------------------------------------
    
            public void GetCellAlignment(int row, int col, ref int horiz, ref int vert)
            {
            wxGrid_GetCellAlignment(wxObject, row, col, ref horiz, ref vert);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool DefaultCellOverflow
            {
            get { return wxGrid_GetDefaultCellOverflow(wxObject); }
            set { wxGrid_SetDefaultCellOverflow(wxObject, value); }
            }
    
            public bool GetCellOverflow(int row, int col)
            {
            return wxGrid_GetCellOverflow(wxObject, row, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public void GetCellSize(int row, int col, ref int num_rows, ref int num_cols)
            {
            wxGrid_GetCellSize(wxObject, row, col, ref num_rows, ref num_cols);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetDefaultRowSize(int height, bool resizeExistingRows)
            {
            wxGrid_SetDefaultRowSize(wxObject, height, resizeExistingRows);
            }
    
            public void SetRowSize(int row, int height)
            {
            wxGrid_SetRowSize(wxObject, row, height);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetDefaultColSize(int width, bool resizeExistingCols)
            {
            wxGrid_SetDefaultColSize(wxObject, width, resizeExistingCols);
            }
    
            public void SetColSize(int col, int width)
            {
            wxGrid_SetColSize(wxObject, col, width);
            }
    
            //-----------------------------------------------------------------------------
    
            public void AutoSizeColumn(int col, bool setAsMin)
            {
            wxGrid_AutoSizeColumn(wxObject, col, setAsMin);
            }
    
            public void AutoSizeRow(int row, bool setAsMin)
            {
            wxGrid_AutoSizeRow(wxObject, row, setAsMin);
            }
    
            //-----------------------------------------------------------------------------
        
        public void AutoSizeColumns()
        {
            AutoSizeColumns(true);
        }
    
            public void AutoSizeColumns(bool setAsMin)
            {
            wxGrid_AutoSizeColumns(wxObject, setAsMin);
            }
        
        public void AutoSizeRows()
        {
            AutoSizeRows(true);
        }
    
            public void AutoSizeRows(bool setAsMin)
            {
            wxGrid_AutoSizeRows(wxObject, setAsMin);
            }
    
            //-----------------------------------------------------------------------------
    
            public void AutoSize()
            {
            wxGrid_AutoSize(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetColMinimalWidth(int col, int width)
            {
            wxGrid_SetColMinimalWidth(wxObject, col, width);
            }
    
            public void SetRowMinimalHeight(int row, int width)
            {
            wxGrid_SetRowMinimalHeight(wxObject, row, width);
            }
    
            //-----------------------------------------------------------------------------
    
            public int ColMinimalAcceptableWidth
            {
            set { wxGrid_SetColMinimalAcceptableWidth(wxObject, value); }
            get { return wxGrid_GetColMinimalAcceptableWidth(wxObject); }
            }
    
            public int RowMinimalAcceptableHeight
            {
            set { wxGrid_SetRowMinimalAcceptableHeight(wxObject, value); }
            get { return wxGrid_GetRowMinimalAcceptableHeight(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellFont(int row, int col, Font fnt)
            {
            wxGrid_SetCellFont(wxObject, row, col, Object.SafePtr(fnt));
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetDefaultCellAlignment(int horiz, int vert)
            {
            wxGrid_SetDefaultCellAlignment(wxObject, horiz, vert);
            }
    
            public void SetCellAlignment(int row, int col, int horiz, int vert)
            {
            wxGrid_SetCellAlignmentHV(wxObject, row, col, horiz, vert);
            }
    
            public void SetCellOverflow(int row, int col, bool allow)
            {
            wxGrid_SetCellOverflow(wxObject, row, col, allow);
            }
    
            public void SetCellSize(int row, int col, int num_rows, int num_cols)
            {
            wxGrid_SetCellSize(wxObject, row, col, num_rows, num_cols);
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellRenderer DefaultRenderer
            {
            set { wxGrid_SetDefaultRenderer(wxObject, Object.SafePtr(value)); }
            //get { return wxGrid_GetDefaultRenderer(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellRenderer(int row, int col, GridCellRenderer renderer)
            {
            wxGrid_SetCellRenderer(wxObject, row, col, Object.SafePtr(renderer));
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellRenderer GetCellRenderer(int row, int col)
            {
                    return (GridCellRenderer)Object.FindObject(wxGrid_GetCellRenderer(wxObject, row, col), typeof(GridCellRenderer));
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellEditor DefaultEditor
            {
                set { wxGrid_SetDefaultEditor(wxObject, Object.SafePtr(value)); }
                get { return (GridCellEditor)Object.FindObject(wxGrid_GetDefaultEditor(wxObject), typeof(GridCellEditor)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellEditor(int row, int col, GridCellEditor editor)
            {
                wxGrid_SetCellEditor(wxObject, row, col, Object.SafePtr(editor));
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellEditor GetCellEditor(int row, int col)
            {
                return (GridCellEditor)Object.FindObject(wxGrid_GetCellEditor(wxObject, row, col), typeof(GridCellEditor));
            }
    
            //-----------------------------------------------------------------------------
    
            public string GetCellValue(int row, int col)
            {
                return new wxString(wxGrid_GetCellValue(wxObject, row, col), true);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellValue(int row, int col, string s)
            {
                wxGrid_SetCellValue(wxObject, row, col, s);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool IsReadOnly(int row, int col)
            {
                return wxGrid_IsReadOnly(wxObject, row, col);
            }
        
        public void SetReadOnly(int row, int col)
        {
            SetReadOnly(row, col, true);
        }
    
            public void SetReadOnly(int row, int col, bool isReadOnly)
            {
            wxGrid_SetReadOnly(wxObject, row, col, isReadOnly);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SelectRow(int row, bool addToSelected)
            {
            wxGrid_SelectRow(wxObject, row, addToSelected);
            }
    
            public void SelectCol(int col, bool addToSelected)
            {
            wxGrid_SelectCol(wxObject, col, addToSelected);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SelectBlock(int topRow, int leftCol, int bottomRow, int rightCol, bool addToSelected)
            {
            wxGrid_SelectBlock(wxObject, topRow, leftCol, bottomRow, rightCol, addToSelected);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SelectAll()
            {
            wxGrid_SelectAll(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool IsSelection
            {
            get { return wxGrid_IsSelection(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void DeselectRow(int row)
            {
            wxGrid_DeselectRow(wxObject, row);
            }
    
            public void DeselectCol(int col)
            {
            wxGrid_DeselectCol(wxObject, col);
            }
    
            public void DeselectCell(int row, int col)
            {
            wxGrid_DeselectCell(wxObject, row, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public void ClearSelection()
            {
            wxGrid_ClearSelection(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public bool IsInSelection(int row, int col)
            {
            return wxGrid_IsInSelection(wxObject, row, col);
            }
    
            //-----------------------------------------------------------------------------

#if NOT_IMPLEMENTED
            public GridCellCoordsArray GetSelectedCells()
        {
            return wxGrid_GetSelectedCells(wxObject);
            }

            //-----------------------------------------------------------------------------
    
            public GridCellCoordsArray GetSelectionBlockTopLeft()
            {
            return wxGrid_GetSelectionBlockTopLeft(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellCoordsArray GetSelectionBlockBottomRight()
            {
            return wxGrid_GetSelectionBlockBottomRight(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public ArrayInt GetSelectedRows()
            {
            return wxGrid_GetSelectedRows(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public ArrayInt GetSelectedCols()
            {
            return wxGrid_GetSelectedCols(wxObject);
            }
#endif

            //-----------------------------------------------------------------------------
    
            public Rectangle BlockToDeviceRect(GridCellCoords topLeft, GridCellCoords bottomRight)
            {
            Rectangle rect = new Rectangle();
            wxGrid_BlockToDeviceRect(wxObject, Object.SafePtr(topLeft), Object.SafePtr(bottomRight), ref rect);
            return rect;
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour SelectionBackground
            {
            get { return new Colour(wxGrid_GetSelectionBackground(wxObject), true); }
            set { wxGrid_SetSelectionBackground(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour SelectionForeground
            {
            get { return new Colour(wxGrid_GetSelectionForeground(wxObject), true); }
            set { wxGrid_SetSelectionForeground(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void RegisterDataType(string typeName, GridCellRenderer renderer, GridCellEditor editor)
            {
            wxGrid_RegisterDataType(wxObject, typeName, Object.SafePtr(renderer), Object.SafePtr(editor));
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellEditor GetDefaultEditorForCell(int row, int col)
            {
            return (GridCellEditor)Object.FindObject(wxGrid_GetDefaultEditorForCell(wxObject, row, col), typeof(GridCellEditor));
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellRenderer GetDefaultRendererForCell(int row, int col)
            {
                    return (GridCellRenderer)Object.FindObject(wxGrid_GetDefaultRendererForCell(wxObject, row, col), typeof(GridCellRenderer));
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellEditor GetDefaultEditorForType(string typeName)
            {
            return (GridCellEditor)Object.FindObject(wxGrid_GetDefaultEditorForType(wxObject, typeName), typeof(GridCellEditor));
            }
    
            //-----------------------------------------------------------------------------
    
            public GridCellRenderer GetDefaultRendererForType(string typeName)
            {
                    return (GridCellRenderer)Object.FindObject(wxGrid_GetDefaultRendererForType(wxObject, typeName), typeof(GridCellRenderer));
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetMargins(int extraWidth, int extraHeight)
            {
            wxGrid_SetMargins(wxObject, extraWidth, extraHeight);
            }
    
            //-----------------------------------------------------------------------------
    
            public Window GridWindow
            {
            get { return (Window)FindObject(wxGrid_GetGridWindow(wxObject)); }
            }
    
            public Window GridRowLabelWindow
            {
            get { return (Window)FindObject(wxGrid_GetGridRowLabelWindow(wxObject)); }
            }
    
            public Window GridColLabelWindow
            {
            get { return (Window)FindObject(wxGrid_GetGridColLabelWindow(wxObject)); }
            }
    
            public Window GridCornerLabelWindow
            {
            get { return (Window)FindObject(wxGrid_GetGridCornerLabelWindow(wxObject)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void UpdateDimensions()
            {
            wxGrid_UpdateDimensions(wxObject);
            }
    
            //-----------------------------------------------------------------------------
    
            public int Rows
            {
            get { return wxGrid_GetRows(wxObject); }
            }
    
            public int Cols
            {
            get { return wxGrid_GetCols(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int CursorRow
            {
            get { return wxGrid_GetCursorRow(wxObject); }
            }
    
            public int CursorColumn
            {
            get { return wxGrid_GetCursorColumn(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int ScrollPosX
            {
            get { return wxGrid_GetScrollPosX(wxObject); }
            set { wxGrid_SetScrollX(wxObject, value); }
            }
    
            public int ScrollPosY
            {
            get { return wxGrid_GetScrollPosY(wxObject); }
            set { wxGrid_SetScrollY(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetColumnWidth(int col, int width)
            {
            wxGrid_SetColumnWidth(wxObject, col, width);
            }
    
            public int GetColumnWidth(int col)
            {
            return wxGrid_GetColumnWidth(wxObject, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetRowHeight(int row, int height)
            {
            wxGrid_SetRowHeight(wxObject, row, height);
            }
    
            //-----------------------------------------------------------------------------
    
            public int ViewHeight
            {
            get{ return wxGrid_GetViewHeight(wxObject); }
            }
    
            public int ViewWidth
            {
            get { return wxGrid_GetViewWidth(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetLabelSize(int orientation, int sz)
            {
            wxGrid_SetLabelSize(wxObject, orientation, sz);
            }
    
            public int GetLabelSize(int orientation)
            {
            return wxGrid_GetLabelSize(wxObject, orientation);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetLabelAlignment(int orientation, int align)
            {
            wxGrid_SetLabelAlignment(wxObject, orientation, align);
            }
    
            public int GetLabelAlignment(int orientation, int align)
            {
            return wxGrid_GetLabelAlignment(wxObject, orientation, align);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetLabelValue(int orientation, string val, int pos)
            {
            wxGrid_SetLabelValue(wxObject, orientation, val, pos);
            }
    
            public string GetLabelValue(int orientation, int pos)
            {
            return new wxString(wxGrid_GetLabelValue(wxObject, orientation, pos), true);
            }
    
            //-----------------------------------------------------------------------------
    
            public Font CellTextFont
            {
            get { return new Font(wxGrid_GetCellTextFontGrid(wxObject)); }
            set { wxGrid_SetCellTextFontGrid(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public Font GetCellTextFont(int row, int col)
            {
            return new Font(wxGrid_GetCellTextFont(wxObject, row, col));
            }
    
            public void SetCellTextFont(Font fnt, int row, int col)
            {
            wxGrid_SetCellTextFont(wxObject, Object.SafePtr(fnt), row, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellTextColour(int row, int col, Colour val)
            {
            wxGrid_SetCellTextColour(wxObject, row, col, Object.SafePtr(val));
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour CellTextColour
            {
            set { wxGrid_SetCellTextColourGrid(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
                
            public Colour GetCellTextColour(int row, int col)
            {
            return new Colour(wxGrid_GetCellTextColour(wxObject, row, col), true); 
            }
    
            //-----------------------------------------------------------------------------
    
            public Colour CellBackgroundColour
            {
            set { wxGrid_SetCellBackgroundColourGrid(wxObject, Object.SafePtr(value)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellBackgroundColour(int row, int col, Colour colour)
            {
            wxGrid_SetCellBackgroundColour(wxObject, row, col, Object.SafePtr(colour));
            }
    
            public Colour GetCellBackgroundColour(int row, int col)
            {
            return new Colour(wxGrid_GetCellBackgroundColour(wxObject, row, col), true); 
            }
    
            //-----------------------------------------------------------------------------
    
            public bool Editable
            {
            get { return wxGrid_GetEditable(wxObject); }
            set { wxGrid_SetEditable(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public bool EditInPlace
            {
            get { return wxGrid_GetEditInPlace(wxObject); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellAlignment(int align, int row, int col)
            {
            wxGrid_SetCellAlignment(wxObject, align, row, col);
            }
    
            public int CellAlignment
            {
            set { wxGrid_SetCellAlignmentGrid(wxObject, value); }
            }
    
            //-----------------------------------------------------------------------------
    
            public void SetCellBitmap(Bitmap bitmap, int row, int col)
            {
            wxGrid_SetCellBitmap(wxObject, Object.SafePtr(bitmap), row, col);
            }
    
            //-----------------------------------------------------------------------------
    
            public Pen DividerPen
            {
            set { wxGrid_SetDividerPen(wxObject, Object.SafePtr(value)); }
            get { return new Pen(wxGrid_GetDividerPen(wxObject)); }
            }
    
            //-----------------------------------------------------------------------------
    
            public int GetRowHeight(int row)
            {
            return wxGrid_GetRowHeight(wxObject, row);
            }

        //-----------------------------------------------------------------------------

		public event EventListener CellLeftClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_CELL_LEFT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener CellRightClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_CELL_RIGHT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener CellLeftDoubleClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_CELL_LEFT_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener CellRightDoubleClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_CELL_RIGHT_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener LabelLeftClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_LABEL_LEFT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener LabelRightClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_LABEL_RIGHT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener LabelLeftDoubleClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_LABEL_LEFT_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener LabelRightDoubleClick
		{
			add { AddCommandListener(Event.wxEVT_GRID_LABEL_RIGHT_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener RowSize
		{
			add { AddCommandListener(Event.wxEVT_GRID_ROW_SIZE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ColumnSize
		{
			add { AddCommandListener(Event.wxEVT_GRID_COL_SIZE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener RangeSelect
		{
			add { AddCommandListener(Event.wxEVT_GRID_RANGE_SELECT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener CellChange
		{
			add { AddCommandListener(Event.wxEVT_GRID_CELL_CHANGE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener SelectCell
		{
			add { AddCommandListener(Event.wxEVT_GRID_SELECT_CELL, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener EditorShown
		{
			add { AddCommandListener(Event.wxEVT_GRID_EDITOR_SHOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener EditorHidden
		{
			add { AddCommandListener(Event.wxEVT_GRID_EDITOR_HIDDEN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener EditorCreate
		{
			add { AddCommandListener(Event.wxEVT_GRID_EDITOR_CREATED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
    }

    public class GridCellCoords : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellCoords_ctor();
	[DllImport("wx-c")] static extern void   wxGridCellCoords_dtor(IntPtr self);
        [DllImport("wx-c")] static extern int    wxGridCellCoords_GetRow(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellCoords_SetRow(IntPtr self, int n);
        [DllImport("wx-c")] static extern int    wxGridCellCoords_GetCol(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellCoords_SetCol(IntPtr self, int n);
        [DllImport("wx-c")] static extern void   wxGridCellCoords_Set(IntPtr self, int row, int col);
	
        //-----------------------------------------------------------------------------
    
        public GridCellCoords(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellCoords(IntPtr wxObject, bool memOwn)
			: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}
    
        public GridCellCoords()
            : this(wxGridCellCoords_ctor(), true) { }
    
        public GridCellCoords(int r, int c)
            : this()
        {
            Set(r, c);
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
						wxGridCellCoords_dtor(wxObject);
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
		
		~GridCellCoords() 
		{
			Dispose();
		}
    
        //-----------------------------------------------------------------------------
    
        public int Row
        {
            set { wxGridCellCoords_SetRow(wxObject, value); }
            get { return wxGridCellCoords_GetRow(wxObject); }
        }
    
        //-----------------------------------------------------------------------------
    
        public int Col
        {
            set { wxGridCellCoords_SetCol(wxObject, value); }
            get { return wxGridCellCoords_GetCol(wxObject); }
        }
    
        //-----------------------------------------------------------------------------
    
        public void Set(int row, int col)
        {
            wxGridCellCoords_Set(wxObject, row, col);
        }
    }

    public class GridCellAttr : Object
    {
        public enum AttrKind
        {
            Any, Default, Cell, Row, Col, Merged
        }
    
        //-----------------------------------------------------------------------------
    
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_ctor(IntPtr colText, IntPtr colBack, IntPtr font, int hAlign, int vAlign);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_ctor2();
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_ctor3(IntPtr attrDefault);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_Clone(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_MergeWith(IntPtr self, IntPtr mergefrom);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_IncRef(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_DecRef(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetTextColour(IntPtr self, IntPtr colText);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetBackgroundColour(IntPtr self, IntPtr colBack);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetFont(IntPtr self, IntPtr font);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetAlignment(IntPtr self, int hAlign, int vAlign);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetSize(IntPtr self, int num_rows, int num_cols);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetOverflow(IntPtr self, bool allow);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetReadOnly(IntPtr self, bool isReadOnly);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetRenderer(IntPtr self, IntPtr renderer);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetEditor(IntPtr self, IntPtr editor);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_HasTextColour(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_HasBackgroundColour(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_HasFont(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_HasAlignment(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_HasRenderer(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_HasEditor(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_HasReadWriteMode(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_GetTextColour(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_GetBackgroundColour(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_GetFont(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_GetAlignment(IntPtr self, ref int hAlign, ref int vAlign);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_GetSize(IntPtr self, ref int num_rows, ref int num_cols);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_GetOverflow(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_GetRenderer(IntPtr self, IntPtr grid, int row, int col);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttr_GetEditor(IntPtr self, IntPtr grid, int row, int col);
        [DllImport("wx-c")] static extern bool   wxGridCellAttr_IsReadOnly(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridCellAttr_SetDefAttr(IntPtr self, IntPtr defAttr);
	
        //-----------------------------------------------------------------------------
    
        public GridCellAttr(IntPtr wxObject) 
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellAttr(IntPtr wxObject, bool memOwn)
			: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}
            
        public GridCellAttr()
            : this(wxGridCellAttr_ctor2(), true) { }
            
        public GridCellAttr(GridCellAttr attrDefault)
            : this(wxGridCellAttr_ctor3(Object.SafePtr(attrDefault)), true) { }
    
        public GridCellAttr(Colour colText, Colour colBack, Font font, int hAlign, int vAlign)
            : this(wxGridCellAttr_ctor(Object.SafePtr(colText), Object.SafePtr(colBack), Object.SafePtr(font), hAlign, vAlign), true) { }
	    
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
		
		~GridCellAttr() 
		{
			Dispose();
		}
    
        //-----------------------------------------------------------------------------
    
        public GridCellAttr Clone()
        {
            return new GridCellAttr(wxGridCellAttr_Clone(wxObject));
        }
    
        //-----------------------------------------------------------------------------
    
        public void MergeWith(GridCellAttr mergefrom)
        {
            wxGridCellAttr_MergeWith(wxObject, Object.SafePtr(mergefrom));
        }
    
        //-----------------------------------------------------------------------------
    
        public void IncRef()
        {
            wxGridCellAttr_IncRef(wxObject);
        }
    
        //-----------------------------------------------------------------------------
    
        public void DecRef()
        {
            wxGridCellAttr_DecRef(wxObject);
        }
    
        //-----------------------------------------------------------------------------
    
        public Colour TextColour
        {
            set { wxGridCellAttr_SetTextColour(wxObject, Object.SafePtr(value)); }
            get { return new Colour(wxGridCellAttr_GetTextColour(wxObject), true); }
        }
    
        //-----------------------------------------------------------------------------
        
        public Colour BackgroundColour
        {
            set { wxGridCellAttr_SetBackgroundColour(wxObject, Object.SafePtr(value)); }
            get { return new Colour(wxGridCellAttr_GetBackgroundColour(wxObject), true); }
        }
        
        //-----------------------------------------------------------------------------
        
        public Font Font
        {
            set { wxGridCellAttr_SetFont(wxObject, Object.SafePtr(value)); }
            get { return new Font(wxGridCellAttr_GetFont(wxObject)); }
        }
        
        //-----------------------------------------------------------------------------
        
        public void SetAlignment(int hAlign, int vAlign)
        {
            wxGridCellAttr_SetAlignment(wxObject, hAlign, vAlign);
        }
        
        public void GetAlignment(ref int hAlign, ref int vAlign)
        {
            wxGridCellAttr_GetAlignment(wxObject, ref hAlign, ref vAlign);
        }
        
        public void SetSize(int num_rows, int num_cols)
        {
            wxGridCellAttr_SetSize(wxObject, num_rows, num_cols);
        }
        
        public void GetSize(ref int num_rows, ref int num_cols)
        {
            wxGridCellAttr_GetSize(wxObject, ref num_rows, ref num_cols);
        }
        
        //-----------------------------------------------------------------------------
        
        public bool Overflow
        {
            set { wxGridCellAttr_SetOverflow(wxObject, value); }
            get { return wxGridCellAttr_GetOverflow(wxObject); }
        }
        
        //-----------------------------------------------------------------------------
        
        public bool ReadOnly
        {
            set { wxGridCellAttr_SetReadOnly(wxObject, value); }
            get { return wxGridCellAttr_IsReadOnly(wxObject); }
        }
        
        //-----------------------------------------------------------------------------
        
        public void SetRenderer(GridCellRenderer renderer)
        {
            wxGridCellAttr_SetRenderer(wxObject, Object.SafePtr(renderer));
        }
        
        //-----------------------------------------------------------------------------
        
        public GridCellEditor Editor
        {
            set { wxGridCellAttr_SetEditor(wxObject, Object.SafePtr(value)); }
        }
        
        public GridCellEditor GetEditor(Grid grid, int row, int col)
        {
            return (GridCellEditor)FindObject(wxGridCellAttr_GetEditor(wxObject, Object.SafePtr(grid), row, col), typeof(GridCellEditor));
        }
        
        //-----------------------------------------------------------------------------
        
        public bool HasTextColour
        {
            get { return wxGridCellAttr_HasTextColour(wxObject); }
        }
        
        public bool HasBackgroundColour
        {
            get { return wxGridCellAttr_HasBackgroundColour(wxObject); }
        }
        
        public bool HasFont
        {
            get { return wxGridCellAttr_HasFont(wxObject); }
        }
        
        public bool HasAlignment
        {
            get { return wxGridCellAttr_HasAlignment(wxObject); }
        }
        
        public bool HasRenderer
        {
            get { return wxGridCellAttr_HasRenderer(wxObject); }
        }
        
        public bool HasEditor
        {
            get { return wxGridCellAttr_HasEditor(wxObject); }
        }
        
        public bool HasReadWriteMode
        {
            get { return wxGridCellAttr_HasReadWriteMode(wxObject); }
        }
        
        //-----------------------------------------------------------------------------
        
        public GridCellRenderer GetRenderer(Grid grid, int row, int col)
        {
            return (GridCellRenderer)FindObject(wxGridCellAttr_GetRenderer(wxObject, Object.SafePtr(grid), row, col), typeof(GridCellRenderer));
        }
        
        //-----------------------------------------------------------------------------
        
        public GridCellAttr DefAttr
        {
            set { wxGridCellAttr_SetDefAttr(wxObject, Object.SafePtr(value)); }
        }
    }

    public class GridSizeEvent : Event 
    {
        [DllImport("wx-c")] static extern IntPtr wxGridSizeEvent_ctor();
        [DllImport("wx-c")] static extern IntPtr wxGridSizeEvent_ctorParam(int id, int type, IntPtr obj, int rowOrCol, int x, int y, bool control, bool shift, bool alt, bool meta);
        [DllImport("wx-c")] static extern int    wxGridSizeEvent_GetRowOrCol(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridSizeEvent_GetPosition(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern bool   wxGridSizeEvent_ControlDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridSizeEvent_MetaDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridSizeEvent_ShiftDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridSizeEvent_AltDown(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridSizeEvent_Veto(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridSizeEvent_Allow(IntPtr self);
        [DllImport("wx-c")] static extern bool wxGridSizeEvent_IsAllowed(IntPtr self);          
    
        //-----------------------------------------------------------------------------
        
        public GridSizeEvent(IntPtr wxObject) 
            : base(wxObject) { }
        
        public GridSizeEvent()
            : this(wxGridSizeEvent_ctor()) { }
        
        public GridSizeEvent(int id, int type, Object obj, int rowOrCol, int x, int y, bool control, bool shift, bool alt, bool meta)
            : this(wxGridSizeEvent_ctorParam(id, type, Object.SafePtr(obj), rowOrCol, x, y, control, shift, alt, meta)) { }
        
        //-----------------------------------------------------------------------------
        
        public int RowOrCol
        {
            get { return wxGridSizeEvent_GetRowOrCol(wxObject); }
        }
        
        //-----------------------------------------------------------------------------
        
        public Point Position
        {
            get { 
                Point pt = new Point();
                wxGridSizeEvent_GetPosition(wxObject, ref pt); 
                return pt;
            }
        }
        
        //-----------------------------------------------------------------------------
        
        public bool ControlDown
        {
            get { return wxGridSizeEvent_ControlDown(wxObject); }
        }
    
        public bool MetaDown
        {
            get { return wxGridSizeEvent_MetaDown(wxObject); }
        }
        
        public bool ShiftDown
        {
            get { return wxGridSizeEvent_ShiftDown(wxObject); }
        }
        
        public bool AltDown
        {
            get { return wxGridSizeEvent_AltDown(wxObject); }
        }
        
        //-----------------------------------------------------------------------------     
        
        public void Veto()
        {
            wxGridSizeEvent_Veto(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public void Allow()
        {
            wxGridSizeEvent_Allow(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public bool Allowed
        {
            get { return wxGridSizeEvent_IsAllowed(wxObject); }
        }                       
    }
    
    //-----------------------------------------------------------------------------

    public abstract class GridCellRenderer : GridCellWorker
    {
        private delegate void Virtual_Draw(IntPtr grid, IntPtr attr, IntPtr dc, IntPtr rect, int row, int col, bool isSelected);
        private delegate IntPtr Virtual_GetBestSize(IntPtr grid, IntPtr attr, IntPtr dc, int row, int col);
        private delegate IntPtr Virtual_RendererClone();

		private Virtual_Draw virtual_Draw;
		private Virtual_GetBestSize virtual_GetBestSize;
		private Virtual_RendererClone virtual_RendererClone;
        
        //-----------------------------------------------------------------------------
        
        [DllImport("wx-c")] static extern IntPtr wxGridCellRenderer_ctor();
	[DllImport("wx-c")] static extern void wxGridCellRenderer_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellRenderer_RegisterVirtual(IntPtr self, Virtual_Draw draw, Virtual_GetBestSize getBestSize, Virtual_RendererClone clone);
	
	//-----------------------------------------------------------------------------
	
        public GridCellRenderer()
            : this(wxGridCellRenderer_ctor(), true) 
        {
			virtual_Draw = new Virtual_Draw(DoDraw);
            virtual_GetBestSize = new Virtual_GetBestSize(DoGetBestSize);
            virtual_RendererClone = new Virtual_RendererClone(DoClone);

            wxGridCellRenderer_RegisterVirtual(wxObject,
                virtual_Draw,
                virtual_GetBestSize,
                virtual_RendererClone);
        }
        
        public GridCellRenderer(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellRenderer_dtor(wxObject);
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
		
		~GridCellRenderer() 
		{
			Dispose();
		}
        
        //-----------------------------------------------------------------------------
        
        private void DoDraw(IntPtr grid, IntPtr attr, IntPtr dc, IntPtr rect, int row, int col, bool isSelected)
        {
            //if ( FindObject(grid) == null ) Console.WriteLine("grid == null"); else Console.WriteLine("grid found");
            Draw((Grid)Object.FindObject(grid, typeof(Grid)), (GridCellAttr)FindObject(attr, typeof(GridCellAttr)), (DC)Object.FindObject(dc), new wxRect(rect), row, col, isSelected);
        }
        
        public abstract void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected);
        
        //-----------------------------------------------------------------------------
        
        private IntPtr DoGetBestSize(IntPtr grid, IntPtr attr, IntPtr dc,  int row, int col)
        {
            return wxSize.SafePtr( new wxSize(GetBestSize((Grid)Object.FindObject(grid, typeof(Grid)), (GridCellAttr)FindObject(attr, typeof(GridCellAttr)), (DC)Object.FindObject(dc, typeof(DC)), row, col)));
            
        }
        
        public abstract Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col);
        
        //-----------------------------------------------------------------------------
        
        private IntPtr DoClone()
        {
            return Object.SafePtr(Clone());
        }
        
        public abstract GridCellRenderer Clone();
    }
    
    //-----------------------------------------------------------------------------
    
    public class GridCellStringRenderer : GridCellRenderer
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellStringRenderer_ctor();
	[DllImport("wx-c")] static extern void wxGridCellStringRenderer_dtor(IntPtr self);
	[DllImport("wx-c")] static extern void wxGridCellStringRenderer_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
        [DllImport("wx-c")] static extern void wxGridCellStringRenderer_Draw(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, ref Rectangle rect, int row, int col, bool isSelected);
        [DllImport("wx-c")] static extern void wxGridCellStringRenderer_GetBestSize(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, int row, int col, out Size size);
        [DllImport("wx-c")] static extern IntPtr wxGridCellStringRenderer_Clone(IntPtr self);
	
        public GridCellStringRenderer()
            : this(wxGridCellStringRenderer_ctor(), true) 
	{ 
		virtual_Dispose = new Virtual_Dispose(VirtualDispose);
		wxGridCellStringRenderer_RegisterDisposable(wxObject, virtual_Dispose);
	}
            
        public GridCellStringRenderer(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellStringRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellStringRenderer_dtor(wxObject);
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
		
		~GridCellStringRenderer() 
		{
			Dispose();
		}
        
        public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
        {
            wxGridCellStringRenderer_Draw(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), ref rect, row, col, isSelected);
        }
        
        public override Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col)
        {
            Size size = new Size();
            wxGridCellStringRenderer_GetBestSize(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), row, col, out size);         
            return size;
        }
        
        public override GridCellRenderer Clone()
        {
            return (GridCellRenderer)FindObject(wxGridCellStringRenderer_Clone(wxObject), typeof(GridCellRenderer));
        }       
    }
    
    //-----------------------------------------------------------------------------
    
    public class GridCellNumberRenderer : GridCellStringRenderer
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellNumberRenderer_ctor();
	[DllImport("wx-c")] static extern void wxGridCellNumberRenderer_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellNumberRenderer_Draw(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, ref Rectangle rect, int row, int col, bool isSelected);
        [DllImport("wx-c")] static extern void wxGridCellNumberRenderer_GetBestSize(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, int row, int col, out Size size);
        [DllImport("wx-c")] static extern IntPtr wxGridCellNumberRenderer_Clone(IntPtr self);
	
        public GridCellNumberRenderer()
            : this(wxGridCellNumberRenderer_ctor(), true) { }
            
        public GridCellNumberRenderer(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellNumberRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellNumberRenderer_dtor(wxObject);
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
		
		~GridCellNumberRenderer() 
		{
			Dispose();
		}
        
        public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
        {
            wxGridCellNumberRenderer_Draw(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), ref rect, row, col, isSelected);
        }
        
        public override Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col)
        {
            Size size = new Size();
            wxGridCellNumberRenderer_GetBestSize(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), row, col, out size);         
            return size;
        }
        
        public override GridCellRenderer Clone()
        {
            return (GridCellRenderer)FindObject(wxGridCellNumberRenderer_Clone(wxObject), typeof(GridCellRenderer));
        }               
    }
    
    //-----------------------------------------------------------------------------
    
    public class GridCellFloatRenderer : GridCellStringRenderer
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellFloatRenderer_ctor(int width, int precision);
	[DllImport("wx-c")] static extern void wxGridCellFloatRenderer_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellFloatRenderer_Draw(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, ref Rectangle rect, int row, int col, bool isSelected);
        [DllImport("wx-c")] static extern void wxGridCellFloatRenderer_GetBestSize(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, int row, int col, out Size size);
        [DllImport("wx-c")] static extern IntPtr wxGridCellFloatRenderer_Clone(IntPtr self);
        [DllImport("wx-c")] static extern int wxGridCellFloatRenderer_GetWidth(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellFloatRenderer_SetWidth(IntPtr self, int width);
        [DllImport("wx-c")] static extern int wxGridCellFloatRenderer_GetPrecision(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellFloatRenderer_SetPrecision(IntPtr self, int precision);
        [DllImport("wx-c")] static extern void wxGridCellFloatRenderer_SetParameters(IntPtr self, string parameter);
	
        public GridCellFloatRenderer()
            : this(-1, -1) { }
            
        public GridCellFloatRenderer(int width)
            : this(width, -1) { }
            
        public GridCellFloatRenderer(int width, int precision)
            : this(wxGridCellFloatRenderer_ctor(width, precision), true) { }
                
        public GridCellFloatRenderer(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellFloatRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellFloatRenderer_dtor(wxObject);
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
		
		~GridCellFloatRenderer() 
		{
			Dispose();
		}
        
        public override void SetParameters(string parameter)
        {
            wxGridCellFloatRenderer_SetParameters(wxObject, parameter);
        }
        
        public int Width
        {
            get { return wxGridCellFloatRenderer_GetWidth(wxObject); }
            set { wxGridCellFloatRenderer_SetWidth(wxObject,value); }
        }
        
        public int Precision
        {
            get { return wxGridCellFloatRenderer_GetPrecision(wxObject); }
            set { wxGridCellFloatRenderer_SetPrecision(wxObject, value); }
        }
        
        public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
        {
            wxGridCellFloatRenderer_Draw(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), ref rect, row, col, isSelected);
        }
        
        public override Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col)
        {
            Size size = new Size();
            wxGridCellFloatRenderer_GetBestSize(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), row, col, out size);          
            return size;
        }
        
        public override GridCellRenderer Clone()
        {
            return (GridCellRenderer)FindObject(wxGridCellFloatRenderer_Clone(wxObject), typeof(GridCellRenderer));
        }                       
    }
    
    //-----------------------------------------------------------------------------
    
    public class GridCellBoolRenderer : GridCellRenderer
    {
        [DllImport("wx-c")] static extern IntPtr wxGridCellBoolRenderer_ctor();
	[DllImport("wx-c")] static extern void wxGridCellBoolRenderer_dtor(IntPtr self);
	[DllImport("wx-c")] static extern void wxGridCellBoolRenderer_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
        [DllImport("wx-c")] static extern void wxGridCellBoolRenderer_Draw(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, ref Rectangle rect, int row, int col, bool isSelected);
        [DllImport("wx-c")] static extern void wxGridCellBoolRenderer_GetBestSize(IntPtr self, IntPtr grid, IntPtr attr, IntPtr dc, int row, int col, out Size size);
        [DllImport("wx-c")] static extern IntPtr wxGridCellBoolRenderer_Clone(IntPtr self);
	
        public GridCellBoolRenderer()
            : this(wxGridCellBoolRenderer_ctor(), true) 
	{ 
		virtual_Dispose = new Virtual_Dispose(VirtualDispose);
		wxGridCellBoolRenderer_RegisterDisposable(wxObject, virtual_Dispose);
	}
            
        public GridCellBoolRenderer(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellBoolRenderer(IntPtr wxObject, bool memOwn)
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
						wxGridCellBoolRenderer_dtor(wxObject);
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
		
		~GridCellBoolRenderer() 
		{
			Dispose();
		}
        
        public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
        {
            wxGridCellBoolRenderer_Draw(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), ref rect, row, col, isSelected);
        }
        
        public override Size GetBestSize(Grid grid, GridCellAttr attr, DC dc, int row, int col)
        {
            Size size = new Size();
            wxGridCellBoolRenderer_GetBestSize(wxObject, Object.SafePtr(grid), Object.SafePtr(attr), Object.SafePtr(dc), row, col, out size);           
            return size;
        }
        
        public override GridCellRenderer Clone()
        {
            return (GridCellRenderer)FindObject(wxGridCellBoolRenderer_Clone(wxObject), typeof(GridCellRenderer));
        }       
    }
    
    //-----------------------------------------------------------------------------
    

    public abstract class GridTableBase : Object//ClientData 
    {
        private delegate int Virtual_GetNumberRows();
        private delegate int Virtual_GetNumberCols();
        private delegate bool Virtual_IsEmptyCell(int row, int col);
        private delegate string Virtual_GetValue(int row, int col);
        private delegate void Virtual_SetValue(int row, int col, IntPtr val);
        private delegate bool Virtual_CanGetValueAs(int row, int col, IntPtr typeName);
        private delegate long Virtual_GetValueAsLong(int row, int col);
        private delegate double Virtual_GetValueAsDouble(int row, int col);
        private delegate void Virtual_SetValueAsLong(int row, int col, long value);
        private delegate void Virtual_SetValueAsDouble(int row, int col, double value);
        private delegate void Virtual_SetValueAsBool(int row, int col, bool value);
        private delegate IntPtr Virtual_GetValueAsCustom(int row, int col, IntPtr typeName);
        private delegate void Virtual_SetValueAsCustom(int row, int col, IntPtr typeName, IntPtr value);
        private delegate string Virtual_GetColLabelValue(int col);
        private delegate void Virtual_SetView(IntPtr grid);
        private delegate IntPtr Virtual_GetView();
        private delegate void Virtual_Clear();
        private delegate bool Virtual_InsertRows(int pos, int numRows);
        private delegate bool Virtual_AppendRows(int numRows);
        private delegate void Virtual_SetRowLabelValue(int row, IntPtr val);
        private delegate void Virtual_SetAttrProvider(IntPtr attrProvider);
        private delegate IntPtr Virtual_GetAttrProvider();
        private delegate bool Virtual_CanHaveAttributes();
        private delegate IntPtr Virtual_GetAttr(int row, int col, int kind);
        private delegate void Virtual_SetAttr(IntPtr attr, int row, int col);
        private delegate void Virtual_SetRowAttr(IntPtr attr, int row);

		private Virtual_GetNumberRows getNumberRows;
		private Virtual_GetNumberCols getNumberCols; 
		private Virtual_IsEmptyCell isEmptyCell;
		private Virtual_GetValue getValue;
		private Virtual_SetValue setValue; 
		private Virtual_GetValue getTypeName;
		private Virtual_CanGetValueAs canGetValueAs;
		private Virtual_CanGetValueAs canSetValueAs; 
		private Virtual_GetValueAsLong getValueAsLong;
		private Virtual_GetValueAsDouble getValueAsDouble;
		private Virtual_IsEmptyCell getValueAsBool;
		private Virtual_SetValueAsLong setValueAsLong;
		private Virtual_SetValueAsDouble setValueAsDouble;
		private Virtual_SetValueAsBool setValueAsBool;
		private Virtual_GetValueAsCustom getValueAsCustom;
		private Virtual_SetValueAsCustom setValueAsCustom;
		private Virtual_SetView setView;
		private Virtual_GetView getView;
		private Virtual_Clear clear;
		private Virtual_InsertRows insertRows;
		private Virtual_AppendRows appendRows;
		private Virtual_InsertRows deleteRows;
		private Virtual_InsertRows insertCols;
		private Virtual_AppendRows appendCols;
		private Virtual_InsertRows deleteCols;
		private Virtual_GetColLabelValue getRowLabelValue;
		private Virtual_GetColLabelValue getColLabelValue;
		private Virtual_SetRowLabelValue setRowLabelValue;
		private Virtual_SetRowLabelValue setColLabelValue;
		private Virtual_SetAttrProvider setAttrProvider;
		private Virtual_GetAttrProvider getAttrProvider;
		private Virtual_CanHaveAttributes canHaveAttributes;
		private Virtual_GetAttr getAttr;
		private Virtual_SetAttr setAttr;
		private Virtual_SetRowAttr setRowAttr;
		private Virtual_SetRowAttr setColAttr;
        
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_ctor();
        [DllImport("wx-c")] static extern void wxGridTableBase_RegisterVirtual(IntPtr self, 
            Virtual_GetNumberRows getNumberRows, 
            Virtual_GetNumberCols getNumberCols, 
            Virtual_IsEmptyCell isEmptyCell, 
            Virtual_GetValue getValue, 
            Virtual_SetValue setValue, 
            Virtual_GetValue getTypeName, 
            Virtual_CanGetValueAs canGetValueAs, 
            Virtual_CanGetValueAs canSetValueAs, 
            Virtual_GetValueAsLong getValueAsLong,
            Virtual_GetValueAsDouble getValueAsDouble, 
            Virtual_IsEmptyCell getValueAsBool,
            Virtual_SetValueAsLong setValueAsLong,
            Virtual_SetValueAsDouble setValueAsDouble,
            Virtual_SetValueAsBool setValueAsBool,
            Virtual_GetValueAsCustom getValueAsCustom,
            Virtual_SetValueAsCustom setValueAsCustom,
            Virtual_SetView setView,
            Virtual_GetView getView,
            Virtual_Clear clear,
            Virtual_InsertRows insertRows,
            Virtual_AppendRows appendRows,
            Virtual_InsertRows deleteRows,
            Virtual_InsertRows insertCols,
            Virtual_AppendRows appendCols,
            Virtual_InsertRows deleteCols,
            Virtual_GetColLabelValue getRowLabelValue,
            Virtual_GetColLabelValue getColLabelValue,
            Virtual_SetRowLabelValue setRowLabelValue,
            Virtual_SetRowLabelValue setColLabelValue,
            Virtual_SetAttrProvider setAttrProvider,
            Virtual_GetAttrProvider getAttrProvider,
            Virtual_CanHaveAttributes canHaveAttributes,
            Virtual_GetAttr getAttr,
            Virtual_SetAttr setAttr,
            Virtual_SetRowAttr setRowAttr,
            Virtual_SetRowAttr setColAttr);

        [DllImport("wx-c")] static extern int    wxGridTableBase_GetNumberRows(IntPtr self);
        [DllImport("wx-c")] static extern int    wxGridTableBase_GetNumberCols(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_IsEmptyCell(IntPtr self, int row, int col);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetValue(IntPtr self, int row, int col);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetValue(IntPtr self, int row, int col, string val);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetTypeName(IntPtr self, int row, int col);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_CanGetValueAs(IntPtr self, int row, int col, string typeName);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_CanSetValueAs(IntPtr self, int row, int col, string typeName);
        [DllImport("wx-c")] static extern long   wxGridTableBase_GetValueAsLong(IntPtr self, int row, int col);
        [DllImport("wx-c")] static extern double wxGridTableBase_GetValueAsDouble(IntPtr self, int row, int col);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_GetValueAsBool(IntPtr self, int row, int col);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetValueAsLong(IntPtr self, int row, int col, long val);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetValueAsDouble(IntPtr self, int row, int col, double val);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetValueAsBool(IntPtr self, int row, int col, bool val);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetValueAsCustom(IntPtr self, int row, int col, string typeName);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetValueAsCustom(IntPtr self, int row, int col, string typeName, IntPtr val);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetView(IntPtr self, IntPtr grid);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetView(IntPtr self);
        [DllImport("wx-c")] static extern void   wxGridTableBase_Clear(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_InsertRows(IntPtr self, int pos, int numRows);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_AppendRows(IntPtr self, int numRows);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_DeleteRows(IntPtr self, int pos, int numRows);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_InsertCols(IntPtr self, int pos, int numCols);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_AppendCols(IntPtr self, int numCols);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_DeleteCols(IntPtr self, int pos, int numCols);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetRowLabelValue(IntPtr self, int row);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetColLabelValue(IntPtr self, int col);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetRowLabelValue(IntPtr self, int row, string val);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetColLabelValue(IntPtr self, int col, string val);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetAttrProvider(IntPtr self, IntPtr attrProvider);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetAttrProvider(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxGridTableBase_CanHaveAttributes(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxGridTableBase_GetAttr(IntPtr self, int row, int col, int kind);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetAttr(IntPtr self, IntPtr attr, int row, int col);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetRowAttr(IntPtr self, IntPtr attr, int row);
        [DllImport("wx-c")] static extern void   wxGridTableBase_SetColAttr(IntPtr self, IntPtr attr, int col);
        
        //-----------------------------------------------------------------------------
    
        public GridTableBase()
            : this(wxGridTableBase_ctor()) 
        {
			getNumberRows = new Virtual_GetNumberRows(GetNumberRows);
            getNumberCols = new Virtual_GetNumberCols(GetNumberCols);
            isEmptyCell = new Virtual_IsEmptyCell(IsEmptyCell);
            getValue = new Virtual_GetValue(GetValue);
            setValue = new Virtual_SetValue(DoSetValue);
            getTypeName = new Virtual_GetValue(GetTypeName);
            canGetValueAs = new Virtual_CanGetValueAs(DoCanGetValueAs);
			canSetValueAs = new Virtual_CanGetValueAs(DoCanSetValueAs);
            getValueAsLong = new Virtual_GetValueAsLong(GetValueAsLong);
            getValueAsDouble = new Virtual_GetValueAsDouble(GetValueAsDouble);
            getValueAsBool = new Virtual_IsEmptyCell(GetValueAsBool);
            setValueAsLong = new Virtual_SetValueAsLong(SetValueAsLong);
            setValueAsDouble = new Virtual_SetValueAsDouble(SetValueAsDouble);
            setValueAsBool = new Virtual_SetValueAsBool(SetValueAsBool);
            getValueAsCustom = new Virtual_GetValueAsCustom(DoGetValueAsCustom);
            setValueAsCustom = new Virtual_SetValueAsCustom(DoSetValueAsCustom);
            setView = new Virtual_SetView(DoSetView);
            getView = new Virtual_GetView(DoGetView);
            clear = new Virtual_Clear(Clear);
            insertRows = new Virtual_InsertRows(InsertRows);
            appendRows = new Virtual_AppendRows(AppendRows);
            deleteRows = new Virtual_InsertRows(DeleteRows);
            insertCols = new Virtual_InsertRows(InsertCols);
            appendCols = new Virtual_AppendRows(AppendCols);
            deleteCols = new Virtual_InsertRows(DeleteCols);
            getRowLabelValue = new Virtual_GetColLabelValue(GetRowLabelValue);
            getColLabelValue = new Virtual_GetColLabelValue(GetColLabelValue);
            setRowLabelValue = new Virtual_SetRowLabelValue(DoSetRowLabelValue);
            setColLabelValue = new Virtual_SetRowLabelValue(DoSetColLabelValue);
            setAttrProvider = new Virtual_SetAttrProvider(DoSetAttrProvider);
            getAttrProvider = new Virtual_GetAttrProvider(DoGetAttrProvider);
            canHaveAttributes = new Virtual_CanHaveAttributes(CanHaveAttributes);
            getAttr = new Virtual_GetAttr(DoGetAttr);
            setAttr = new Virtual_SetAttr(DoSetAttr);
            setRowAttr = new Virtual_SetRowAttr(DoSetRowAttr);
            setColAttr = new Virtual_SetRowAttr(DoSetColAttr);

            wxGridTableBase_RegisterVirtual(wxObject, 
                getNumberRows,
                getNumberCols,
                isEmptyCell,
                getValue,
                setValue,
                getTypeName,
                canGetValueAs,
                canSetValueAs,
                getValueAsLong,
                getValueAsDouble,
                getValueAsBool,
                setValueAsLong,
                setValueAsDouble,
                setValueAsBool,
                getValueAsCustom,
                setValueAsCustom,
                setView,
                getView,
                clear,
                insertRows,
                appendRows,
                deleteRows,
                insertCols,
                appendCols,
                deleteCols,
                getRowLabelValue,
                getColLabelValue,
                setRowLabelValue,
                setColLabelValue,
                setAttrProvider,
                getAttrProvider,
                canHaveAttributes,
                getAttr,
                setAttr,
                setRowAttr,
                setColAttr
            );
        }
        
        public GridTableBase(IntPtr wxObject)
            : base(wxObject) { }
            
        //-----------------------------------------------------------------------------
        
        public virtual int GetNumberRows()
        {
            return wxGridTableBase_GetNumberRows(wxObject);
        }
        
        public virtual int GetNumberCols()
        {
            return wxGridTableBase_GetNumberCols(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual bool IsEmptyCell(int row, int col)
        {
            return wxGridTableBase_IsEmptyCell(wxObject, row, col);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual string GetValue(int row, int col)
        {
            return new wxString(wxGridTableBase_GetValue(wxObject, row, col), true);
        }

        private void DoSetValue(int row, int col, IntPtr val)
        {
            SetValue(row, col, new wxString(val));
        }       
        
        public virtual void SetValue(int row, int col, string val)
        {
            wxGridTableBase_SetValue(wxObject, row, col, val);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual string GetTypeName(int row, int col)
        {
            return new wxString(wxGridTableBase_GetTypeName(wxObject, row, col), true);
        }
        
        private bool DoCanGetValueAs(int row, int col, IntPtr typeName)
        {
            return CanGetValueAs(row, col, new wxString(typeName));
        }
        
        public virtual bool CanGetValueAs(int row, int col, string typeName)
        {
            return wxGridTableBase_CanGetValueAs(wxObject, row, col, typeName);
        }

        private bool DoCanSetValueAs(int row, int col, IntPtr typeName)
        {
            return CanSetValueAs(row, col, new wxString(typeName));
        }
        
        public virtual bool CanSetValueAs(int row, int col, string typeName)
        {
            return wxGridTableBase_CanSetValueAs(wxObject, row, col, typeName);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual long GetValueAsLong(int row, int col)
        {
            return wxGridTableBase_GetValueAsLong(wxObject, row, col);
        }
        
        public virtual double GetValueAsDouble(int row, int col)
        {
            return wxGridTableBase_GetValueAsDouble(wxObject, row, col);
        }
        
        public virtual bool GetValueAsBool(int row, int col)
        {
            return wxGridTableBase_GetValueAsBool(wxObject, row, col);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual void SetValueAsLong(int row, int col, long val)
        {
            wxGridTableBase_SetValueAsLong(wxObject, row, col, val);
        }
        
        public virtual void SetValueAsDouble(int row, int col, double val)
        {
            wxGridTableBase_SetValueAsDouble(wxObject, row, col, val);
        }
        
        public virtual void SetValueAsBool(int row, int col, bool val)
        {
            wxGridTableBase_SetValueAsBool(wxObject, row, col, val);
        }
        
        //-----------------------------------------------------------------------------
        
        private IntPtr DoGetValueAsCustom(int row, int col, IntPtr typeName)
        {
            return Object.SafePtr(GetValueAsCustom(row, col, new wxString(typeName)));
        }
        
        public virtual Object GetValueAsCustom(int row, int col, string typeName)
        {
            return FindObject(wxGridTableBase_GetValueAsCustom(wxObject, row, col, typeName));
        }
        
        private void DoSetValueAsCustom(int row, int col, IntPtr typeName, IntPtr val)
        {
            SetValueAsCustom(row, col, new wxString(typeName), FindObject(val));
        }
        
        public virtual void SetValueAsCustom(int row, int col, string typeName, Object val)
        {
            wxGridTableBase_SetValueAsCustom(wxObject, row, col, typeName, Object.SafePtr(val));
        }
        
        //-----------------------------------------------------------------------------
        
        private void DoSetView(IntPtr grid)
        {
            SetView((Grid)FindObject(grid, typeof(Grid)));
        }
        
        public virtual void SetView(Grid grid)
        {
            wxGridTableBase_SetView(wxObject, Object.SafePtr(grid));
        }
        
        private IntPtr DoGetView()
        {
            return Object.SafePtr(GetView());
        }
        
        public virtual Grid GetView()
        {
            return (Grid)FindObject(wxGridTableBase_GetView(wxObject), typeof(Grid));
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual void Clear()
        {
            wxGridTableBase_Clear(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual bool InsertRows(int pos, int numRows)
        {
            return wxGridTableBase_InsertRows(wxObject, pos, numRows);
        }
        
        public virtual bool AppendRows(int numRows)
        {
            return wxGridTableBase_AppendRows(wxObject, numRows);
        }
        
        public virtual bool DeleteRows(int pos, int numRows)
        {
            return wxGridTableBase_DeleteRows(wxObject, pos, numRows);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual bool InsertCols(int pos, int numCols)
        {
            return wxGridTableBase_InsertCols(wxObject, pos, numCols);
        }
        
        public virtual bool AppendCols(int numCols)
        {
            return wxGridTableBase_AppendCols(wxObject, numCols);
        }
        
        public virtual bool DeleteCols(int pos, int numCols)
        {
            return wxGridTableBase_DeleteCols(wxObject, pos, numCols);
        }
        
        //-----------------------------------------------------------------------------
        
        public virtual string GetRowLabelValue(int row)
        {
            return new wxString(wxGridTableBase_GetRowLabelValue(wxObject, row), true);
        }
        
        public virtual string GetColLabelValue(int col)
        {
            return new wxString(wxGridTableBase_GetColLabelValue(wxObject, col), true);
        }
        
        private void DoSetRowLabelValue(int row, IntPtr val)
        {
            SetRowLabelValue(row, new wxString(val));
        }       
        
        public virtual void SetRowLabelValue(int row, string val)
        {
            wxGridTableBase_SetRowLabelValue(wxObject, row, val);
        }
        
        private void DoSetColLabelValue(int col, IntPtr val)
        {
            SetColLabelValue(col, new wxString(val));
        }       
        
        public virtual void SetColLabelValue(int col, string val)
        {
            wxGridTableBase_SetColLabelValue(wxObject, col, val);
        }       
        
        //-----------------------------------------------------------------------------
        
        private void DoSetAttrProvider(IntPtr attrProvider)
        {
            SetAttrProvider((GridCellAttrProvider)Object.FindObject(attrProvider, typeof(GridCellAttrProvider)));
        }
        
        public void SetAttrProvider(GridCellAttrProvider attrProvider)
        {
            wxGridTableBase_SetAttrProvider(wxObject, Object.SafePtr(attrProvider));
        }
        
        private IntPtr DoGetAttrProvider()
        {
            return Object.SafePtr(GetAttrProvider());
        }
        
        public GridCellAttrProvider GetAttrProvider()
        {
            return new GridCellAttrProvider(wxGridTableBase_GetAttrProvider(wxObject));
        }
        
        public virtual bool CanHaveAttributes()
        {
            return wxGridTableBase_CanHaveAttributes(wxObject);
        }
        
        //-----------------------------------------------------------------------------
        
        private IntPtr DoGetAttr(int row, int col, int kind)
        {
            return Object.SafePtr(GetAttr(row, col, (GridCellAttr.AttrKind) kind));
        }
        
        public virtual GridCellAttr GetAttr(int row, int col, GridCellAttr.AttrKind kind)
        {
            return (GridCellAttr)Object.FindObject(wxGridTableBase_GetAttr(wxObject, row, col, (int)kind), typeof(GridCellAttr));
        }
        
        private void DoSetAttr(IntPtr attr, int row, int col)
        {
            SetAttr((GridCellAttr)Object.FindObject(attr, typeof(GridCellAttr)), row, col);
        }
        
        public virtual void SetAttr(GridCellAttr attr, int row, int col)
        {
            wxGridTableBase_SetAttr(wxObject, Object.SafePtr(attr), row, col);
        }
        
        //-----------------------------------------------------------------------------
        
        private void DoSetRowAttr(IntPtr attr, int row)
        {
            SetRowAttr((GridCellAttr)Object.FindObject(attr, typeof(GridCellAttr)), row);
        }
        
        public virtual void SetRowAttr(GridCellAttr attr, int row)
        {
            wxGridTableBase_SetRowAttr(wxObject, Object.SafePtr(attr), row);
        }
        
        private void DoSetColAttr(IntPtr attr, int col)
        {
            SetColAttr((GridCellAttr)Object.FindObject(attr, typeof(GridCellAttr)), col);
        }       
        
        public virtual void SetColAttr(GridCellAttr attr, int col)
        {
            wxGridTableBase_SetColAttr(wxObject, Object.SafePtr(attr), col);
        }
    }
    
    public class GridCellAttrProvider : Object  // ClientData
    {
        private delegate IntPtr Virtual_GetAttr(int row, int col, int kind);
        private delegate void Virtual_SetAttr(IntPtr attr, int row, int col);
        private delegate void Virtual_SetRowAttr(IntPtr attr, int row);

		private Virtual_GetAttr getAttr;
		private Virtual_SetAttr setAttr;
		private Virtual_SetRowAttr setRowAttr;
		private Virtual_SetRowAttr setColAttr;
        
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttrProvider_ctor();
	[DllImport("wx-c")] static extern void wxGridCellAttrProvider_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxGridCellAttrProvider_RegisterVirtual(IntPtr self,
            Virtual_GetAttr getAttr,
            Virtual_SetAttr setAttr,
            Virtual_SetRowAttr setRowAttr,
            Virtual_SetRowAttr setColAttr);
        [DllImport("wx-c")] static extern IntPtr wxGridCellAttrProvider_GetAttr(IntPtr self, int row, int col, int kind);
        [DllImport("wx-c")] static extern void wxGridCellAttrProvider_SetAttr(IntPtr self, IntPtr attr, int row, int col); 
        [DllImport("wx-c")] static extern void wxGridCellAttrProvider_SetRowAttr(IntPtr self, IntPtr attr, int row); 
        [DllImport("wx-c")] static extern void wxGridCellAttrProvider_SetColAttr(IntPtr self, IntPtr attr, int col); 
        [DllImport("wx-c")] static extern void wxGridCellAttrProvider_UpdateAttrRows(IntPtr self, int pos, int numRows);
        [DllImport("wx-c")] static extern void wxGridCellAttrProvider_UpdateAttrCols(IntPtr self, int pos, int numCols);
	
        //-----------------------------------------------------------------------------
        
        public GridCellAttrProvider(IntPtr wxObject) 
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal GridCellAttrProvider(IntPtr wxObject, bool memOwn)
			: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}
        
        public GridCellAttrProvider()
            : this(wxGridCellAttrProvider_ctor(), true) 
        { 
			getAttr = new Virtual_GetAttr(DoGetAttr);
			setAttr = new Virtual_SetAttr(DoSetAttr);
			setRowAttr = new Virtual_SetRowAttr(DoSetRowAttr);
			setColAttr = new Virtual_SetRowAttr(DoSetColAttr);

            wxGridCellAttrProvider_RegisterVirtual(wxObject,
                getAttr,
                setAttr,
                setRowAttr,
                setColAttr);
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
						wxGridCellAttrProvider_dtor(wxObject);
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
		
		~GridCellAttrProvider() 
		{
			Dispose();
		}
        
        //-----------------------------------------------------------------------------
        
        private IntPtr DoGetAttr(int row, int col, int kind)
        {
            return Object.SafePtr(GetAttr(row, col, (GridCellAttr.AttrKind) kind));
        }
        
        public virtual GridCellAttr GetAttr(int row, int col, GridCellAttr.AttrKind kind)
        {
            return (GridCellAttr)FindObject(wxGridCellAttrProvider_GetAttr(wxObject, row, col, (int)kind), typeof(GridCellAttr));
        }
        
        private void DoSetAttr(IntPtr attr, int row, int col)
        {
            SetAttr((GridCellAttr)FindObject(attr, typeof(GridCellAttr)), row, col);
        }
        
        public virtual void SetAttr(GridCellAttr attr, int row, int col)
        {
            wxGridCellAttrProvider_SetAttr(wxObject, Object.SafePtr(attr), row, col);
        }
        
        //-----------------------------------------------------------------------------
        
        private void DoSetRowAttr(IntPtr attr, int row)
        {
            SetRowAttr((GridCellAttr)FindObject(attr, typeof(GridCellAttr)), row);
        }
        
        public virtual void SetRowAttr(GridCellAttr attr, int row)
        {
            wxGridCellAttrProvider_SetRowAttr(wxObject, Object.SafePtr(attr), row);
        }
        
        private void DoSetColAttr(IntPtr attr, int col)
        {
            SetColAttr((GridCellAttr)FindObject(attr, typeof(GridCellAttr)), col);
        }       
        
        public virtual void SetColAttr(GridCellAttr attr, int col)
        {
            wxGridCellAttrProvider_SetColAttr(wxObject, Object.SafePtr(attr), col);
        }
        
        //-----------------------------------------------------------------------------
        
        public void UpdateAttrRows(int pos, int numRows)
        {
            wxGridCellAttrProvider_UpdateAttrRows(wxObject, pos, numRows);
        }
        
        public void UpdateAttrCols(int pos, int numCols)
        {
            wxGridCellAttrProvider_UpdateAttrCols(wxObject, pos, numCols);
        }       
    }
}
