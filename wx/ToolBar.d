//-----------------------------------------------------------------------------
// wx.NET - Tbarbase.cs
// 
// The wxToolBar wrapper class.
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
	public class ToolBarTool : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_ctor(IntPtr tbar, int toolid, string label, IntPtr bmpNormal, IntPtr bmpDisabled, int kind, IntPtr clientData, string shortHelpString, string longHelpString);
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_ctorCtrl(IntPtr tbar, IntPtr control);
		[DllImport("wx-c")] static extern int    wxToolBarToolBase_GetId(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_GetControl(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_GetToolBar(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_IsButton(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_IsControl(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_IsSeparator(IntPtr self);
		[DllImport("wx-c")] static extern int    wxToolBarToolBase_GetStyle(IntPtr self);
		[DllImport("wx-c")] static extern int    wxToolBarToolBase_GetKind(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_IsEnabled(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_IsToggled(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_CanBeToggled(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_GetLabel(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_GetShortHelp(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_GetLongHelp(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBarToolBase_GetClientData(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_Enable(IntPtr self, bool enable);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_Toggle(IntPtr self, bool toggle);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_SetToggle(IntPtr self, bool toggle);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_SetShortHelp(IntPtr self, string help);
		[DllImport("wx-c")] static extern bool   wxToolBarToolBase_SetLongHelp(IntPtr self, string help);
		[DllImport("wx-c")] static extern void   wxToolBarToolBase_Toggle(IntPtr self);
		[DllImport("wx-c")] static extern void   wxToolBarToolBase_SetNormalBitmap(IntPtr self, IntPtr bmp);
		[DllImport("wx-c")] static extern void   wxToolBarToolBase_SetDisabledBitmap(IntPtr self, IntPtr bmp);
		[DllImport("wx-c")] static extern void   wxToolBarToolBase_SetLabel(IntPtr self, string label);
		[DllImport("wx-c")] static extern void   wxToolBarToolBase_SetClientData(IntPtr self, IntPtr clientData);
		[DllImport("wx-c")] static extern void   wxToolBarToolBase_Detach(IntPtr self);
		[DllImport("wx-c")] static extern void   wxToolBarToolBase_Attach(IntPtr self, IntPtr tbar);

        //---------------------------------------------------------------------
        
        public ToolBarTool(IntPtr wxObject) 
            : base(wxObject) { }

        public ToolBarTool(ToolBar tbar, int toolid, string label, Bitmap bmpNormal, Bitmap bmpDisabled, ItemKind kind, ClientData clientData, string shortHelpString, string longHelpString)
            : this(wxToolBarToolBase_ctor(Object.SafePtr(tbar), toolid, label, Object.SafePtr(bmpNormal), Object.SafePtr(bmpDisabled), (int)kind, Object.SafePtr(clientData), shortHelpString, longHelpString)) { }

        public ToolBarTool(ToolBar tbar, Control control)
            : this(wxToolBarToolBase_ctorCtrl(Object.SafePtr(tbar), Object.SafePtr(control))) { }

        //---------------------------------------------------------------------

		public int ID
        {
            get {return wxToolBarToolBase_GetId(wxObject); }
        }

		public Control Control
        {
            get { return (Control)FindObject(wxToolBarToolBase_GetControl(wxObject)); }
        }

		public ToolBar ToolBar
        {
            get { return (ToolBar)FindObject(wxToolBarToolBase_GetToolBar(wxObject), typeof(ToolBar)); }
        }

        //---------------------------------------------------------------------

		public bool IsButton
        {
            get { return wxToolBarToolBase_IsButton(wxObject); }
        }

		bool IsControl
        {
            get { return wxToolBarToolBase_IsControl(wxObject); }
        }

		bool IsSeparator
        {
            get { return wxToolBarToolBase_IsSeparator(wxObject); }
        }

        //---------------------------------------------------------------------

		public int Style
        {
            get { return wxToolBarToolBase_GetStyle(wxObject); }
        }

		public ItemKind Kind
        {
            get { return (ItemKind)wxToolBarToolBase_GetKind(wxObject); }
        }

        //---------------------------------------------------------------------

		bool CanBeToggled()
        {
            return wxToolBarToolBase_CanBeToggled(wxObject);
        }

        //---------------------------------------------------------------------

		public string Label
        {
            get { return new wxString(wxToolBarToolBase_GetLabel(wxObject), true); }
            set { wxToolBarToolBase_SetLabel(wxObject, value); }
        }

		public string ShortHelp
        {
            get { return new wxString(wxToolBarToolBase_GetShortHelp(wxObject), true); }
            set { wxToolBarToolBase_SetShortHelp(wxObject, value); }
        }

		public string LongHelp
        {
            get { return new wxString(wxToolBarToolBase_GetLongHelp(wxObject), true); }
            set { wxToolBarToolBase_SetLongHelp(wxObject, value); }
        }

        //---------------------------------------------------------------------
        
		public ClientData ClientData
        {
            get { return (ClientData)Object.FindObject(wxToolBarToolBase_GetClientData(wxObject)); }
            set { wxToolBarToolBase_SetClientData(wxObject, Object.SafePtr(value)); }
        }

        //---------------------------------------------------------------------

		public bool Enabled
        {
            set { wxToolBarToolBase_Enable(wxObject, value); }
            get {return wxToolBarToolBase_IsEnabled(wxObject); }
        }

		public bool Toggled
        {
            set { wxToolBarToolBase_SetToggle(wxObject, value); }
            get { return wxToolBarToolBase_IsToggled(wxObject); }
        }

        //---------------------------------------------------------------------

		public Bitmap NormalBitmap
        {
            set { wxToolBarToolBase_SetNormalBitmap(wxObject, Object.SafePtr(value)); }
        }

		public Bitmap DisabledBitmap
        {
            set { wxToolBarToolBase_SetDisabledBitmap(wxObject, Object.SafePtr(value)); }
        }

        //---------------------------------------------------------------------

		void Detach()
        {
            wxToolBarToolBase_Detach(wxObject);
        }

		void Attach(ToolBar tbar)
        {
            wxToolBarToolBase_Attach(wxObject, Object.SafePtr(tbar));
        }

        //---------------------------------------------------------------------
	}

	public class ToolBar : Control
	{
		public const long wxTB_HORIZONTAL   = Orientation.wxHORIZONTAL;
		public const long wxTB_VERTICAL     = Orientation.wxVERTICAL;
		public const long wxTB_3DBUTTONS    = 0x0010;
		public const long wxTB_FLAT         = 0x0020;
		public const long wxTB_DOCKABLE     = 0x0040;
		public const long wxTB_NOICONS      = 0x0080;
		public const long wxTB_TEXT         = 0x0100;
		public const long wxTB_NODIVIDER    = 0x0200;
		public const long wxTB_NOALIGN      = 0x0400;
	
		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxToolBar_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddTool1(IntPtr self, int toolid, string label, IntPtr bitmap, IntPtr bmpDisabled, int kind, string shortHelp, string longHelp, IntPtr data);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddTool2(IntPtr self, int toolid, string label, IntPtr bitmap, string shortHelp, int kind);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddCheckTool(IntPtr self, int toolid, string label, IntPtr bitmap, IntPtr bmpDisabled, string shortHelp, string longHelp, IntPtr data);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddRadioTool(IntPtr self, int toolid, string label, IntPtr bitmap, IntPtr bmpDisabled, string shortHelp, string longHelp, IntPtr data);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddControl(IntPtr self, IntPtr control);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_InsertControl(IntPtr self, int pos, IntPtr control);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_FindControl(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddSeparator(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_InsertSeparator(IntPtr self, int pos);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_RemoveTool(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern bool   wxToolBar_DeleteToolByPos(IntPtr self, int pos);
		[DllImport("wx-c")] static extern bool   wxToolBar_DeleteTool(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern void   wxToolBar_ClearTools(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxToolBar_Realize(IntPtr self);
		[DllImport("wx-c")] static extern void   wxToolBar_EnableTool(IntPtr self, int toolid, bool enable);
		[DllImport("wx-c")] static extern void   wxToolBar_ToggleTool(IntPtr self, int toolid, bool toggle);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_GetToolClientData(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern void   wxToolBar_SetToolClientData(IntPtr self, int toolid, IntPtr clientData);
		[DllImport("wx-c")] static extern bool   wxToolBar_GetToolState(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern bool   wxToolBar_GetToolEnabled(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern void   wxToolBar_SetToolShortHelp(IntPtr self, int toolid, string helpString);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_GetToolShortHelp(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern void   wxToolBar_SetToolLongHelp(IntPtr self, int toolid, string helpString);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_GetToolLongHelp(IntPtr self, int toolid);
		[DllImport("wx-c")] static extern void   wxToolBar_SetMargins(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void   wxToolBar_SetToolPacking(IntPtr self, int packing);
		[DllImport("wx-c")] static extern void   wxToolBar_SetToolSeparation(IntPtr self, int separation);
		[DllImport("wx-c")] static extern void   wxToolBar_GetToolMargins(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern int    wxToolBar_GetToolPacking(IntPtr self);
		[DllImport("wx-c")] static extern int    wxToolBar_GetToolSeparation(IntPtr self);
		[DllImport("wx-c")] static extern void   wxToolBar_SetRows(IntPtr self, int nRows);
		[DllImport("wx-c")] static extern void   wxToolBar_SetMaxRowsCols(IntPtr self, int rows, int cols);
		[DllImport("wx-c")] static extern int    wxToolBar_GetMaxRows(IntPtr self);
		[DllImport("wx-c")] static extern int    wxToolBar_GetMaxCols(IntPtr self);
		[DllImport("wx-c")] static extern void   wxToolBar_SetToolBitmapSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxToolBar_GetToolBitmapSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxToolBar_GetToolSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_FindToolForPosition(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern bool   wxToolBar_IsVertical(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddTool3(IntPtr self, int toolid, IntPtr bitmap, IntPtr bmpDisabled, bool toggle, IntPtr clientData, string shortHelpString, string longHelpString);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddTool4(IntPtr self, int toolid, IntPtr bitmap, string shortHelpString, string longHelpString);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_AddTool5(IntPtr self, int toolid, IntPtr bitmap, IntPtr bmpDisabled, bool toggle, int xPos, int yPos, IntPtr clientData, string shortHelp, string longHelp);
		[DllImport("wx-c")] static extern IntPtr wxToolBar_InsertTool(IntPtr self, int pos, int toolid, IntPtr bitmap, IntPtr bmpDisabled, bool toggle, IntPtr clientData, string shortHelp, string longHelp);
		[DllImport("wx-c")] static extern bool   wxToolBar_AcceptsFocus(IntPtr self);

        //---------------------------------------------------------------------

        public ToolBar(IntPtr wxObject) 
            : base(wxObject) { }

        public ToolBar(Window parent, int id)
            : this(parent, id, wxDefaultPosition, wxDefaultSize, wxTB_HORIZONTAL | /*Border.*/wxNO_BORDER) { }

        public ToolBar(Window parent, int id, Point pos)
            : this(parent, id, pos, wxDefaultSize, wxTB_HORIZONTAL | /*Border.*/wxNO_BORDER) { }

        public ToolBar(Window parent, int id, Point pos, Size size)
            : this(parent, id, pos, size, wxTB_HORIZONTAL | /*Border.*/wxNO_BORDER) { }

        public ToolBar(Window parent, int id, Point pos, Size size, long style)
            : this(wxToolBar_ctor(Object.SafePtr(parent), id, ref pos, ref size, (uint)style)) { }
	    
	//---------------------------------------------------------------------
	// ctors with self created id
	    
	public ToolBar(Window parent)
            : this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxTB_HORIZONTAL | /*Border.*/wxNO_BORDER) { }

        public ToolBar(Window parent, Point pos)
            : this(parent, Window.UniqueID, pos, wxDefaultSize, wxTB_HORIZONTAL | /*Border.*/wxNO_BORDER) { }

        public ToolBar(Window parent, Point pos, Size size)
            : this(parent, Window.UniqueID, pos, size, wxTB_HORIZONTAL | /*Border.*/wxNO_BORDER) { }

        public ToolBar(Window parent, Point pos, Size size, long style)
	    : this(parent, Window.UniqueID, pos, size, style) {}

        //---------------------------------------------------------------------

        public ToolBarTool AddTool(int toolid, string label, Bitmap bitmap)
        {
            return AddTool(toolid, label, bitmap, "", 0);
        }

        public ToolBarTool AddTool(int toolid, string label, Bitmap bitmap, Bitmap bmpDisabled, ItemKind kind, string shortHelp, string longHelp, ClientData clientData)
        {
            return new ToolBarTool(wxToolBar_AddTool1(wxObject, toolid, label, Object.SafePtr(bitmap), Object.SafePtr(bmpDisabled), (int)kind, shortHelp, longHelp, Object.SafePtr(clientData)));
        }

        public ToolBarTool AddTool(int toolid, string label, Bitmap bitmap, string shortHelp, ItemKind kind)
        {
            return new ToolBarTool(wxToolBar_AddTool2(wxObject, toolid, label, Object.SafePtr(bitmap), shortHelp, (int)kind));
        }

        public ToolBarTool AddTool(int toolid, Bitmap bitmap, Bitmap bmpDisabled, bool toggle, ClientData clientData, string shortHelpString, string longHelpString)
        {
            return new ToolBarTool(wxToolBar_AddTool3(wxObject, toolid, Object.SafePtr(bitmap), Object.SafePtr(bmpDisabled), toggle, Object.SafePtr(clientData), shortHelpString, longHelpString));
        }

        public ToolBarTool AddTool(int toolid, Bitmap bitmap, string shortHelpString)
            { return AddTool(toolid, bitmap, shortHelpString, ""); }
        public ToolBarTool AddTool(int toolid, Bitmap bitmap, string shortHelpString, string longHelpString)
        {
            return new ToolBarTool(wxToolBar_AddTool4(wxObject, toolid, Object.SafePtr(bitmap), shortHelpString, longHelpString));
        }

        public ToolBarTool AddTool(int toolid, Bitmap bitmap, Bitmap bmpDisabled, bool toggle, int xPos, int yPos, ClientData clientData, string shortHelp, string longHelp)
        {
            return new ToolBarTool(wxToolBar_AddTool5(wxObject, toolid, Object.SafePtr(bitmap), Object.SafePtr(bmpDisabled), toggle, xPos, yPos, Object.SafePtr(clientData), shortHelp, longHelp));
        }

        //---------------------------------------------------------------------
        
        public ToolBarTool InsertTool(int pos, int toolid, Bitmap bitmap, Bitmap bmpDisabled, bool toggle, ClientData clientData, string shortHelp, string longHelp)
        {
            return new ToolBarTool(wxToolBar_InsertTool(wxObject, pos, toolid, Object.SafePtr(bitmap), Object.SafePtr(bmpDisabled), toggle, Object.SafePtr(clientData), shortHelp, longHelp));
        }

        //---------------------------------------------------------------------

        public ToolBarTool AddCheckTool(int toolid, string label, Bitmap bitmap, Bitmap bmpDisabled, string shortHelp, string longHelp)
        {
            return new ToolBarTool(wxToolBar_AddCheckTool(wxObject, toolid, label, Object.SafePtr(bitmap), Object.SafePtr(bmpDisabled), shortHelp, longHelp, Object.SafePtr(null)));
        }

        public ToolBarTool AddRadioTool(int toolid, string label, Bitmap bitmap, Bitmap bmpDisabled, string shortHelp, string longHelp)
        {
            return new ToolBarTool(wxToolBar_AddRadioTool(wxObject, toolid, label, Object.SafePtr(bitmap), Object.SafePtr(bmpDisabled), shortHelp, longHelp, Object.SafePtr(null)));
        }

        //---------------------------------------------------------------------

        public ToolBarTool AddControl(Control ctrl)
        {
            return new ToolBarTool(wxToolBar_AddControl(wxObject, Object.SafePtr(ctrl)));
        }

        public ToolBarTool InsertControl(int pos, Control ctrl)
        {
            return new ToolBarTool(wxToolBar_InsertControl(wxObject, pos, Object.SafePtr(ctrl)));
        }

        public ToolBarTool FindControl(int toolid)
        {
            return (ToolBarTool)FindObject(wxToolBar_FindControl(wxObject, toolid), typeof(ToolBarTool));
        }

        //---------------------------------------------------------------------

        public ToolBarTool AddSeparator()
        {
            return new ToolBarTool(wxToolBar_AddSeparator(wxObject));
        }

        public ToolBarTool InsertSeparator(int pos)
        {
            return new ToolBarTool(wxToolBar_InsertSeparator(wxObject, pos));
        }

        //---------------------------------------------------------------------

        public ToolBarTool RemoveTool(int toolid)
        {
            return (ToolBarTool)FindObject(wxToolBar_RemoveTool(wxObject, toolid), typeof(ToolBarTool));
        }

        public bool DeleteToolByPos(int pos)
        {
            return wxToolBar_DeleteToolByPos(wxObject, pos);
        }

        public bool DeleteTool(int toolid)
        {
            return wxToolBar_DeleteTool(wxObject, toolid);
        }

        public void ClearTools()
        {
            wxToolBar_ClearTools(wxObject);
        }

        //---------------------------------------------------------------------

        public bool Realize()
        {
            return wxToolBar_Realize(wxObject);
        }

        //---------------------------------------------------------------------

        public void EnableTool(int toolid, bool enable)
        {
            wxToolBar_EnableTool(wxObject, toolid, enable);
        }

        public void ToggleTool(int toolid, bool toggle)
        {
            wxToolBar_ToggleTool(wxObject, toolid, toggle);
        }

        //---------------------------------------------------------------------

        public void SetToolClientData(int toolid, ClientData clientData)
        {
            wxToolBar_SetToolClientData(wxObject, toolid, Object.SafePtr(clientData));
        }

        public ClientData GetToolClientData(int toolid)
        {
            return (ClientData)Object.FindObject(wxToolBar_GetToolClientData(wxObject, toolid));
        }

        //---------------------------------------------------------------------
        
        public bool GetToolState(int toolid)
        {
            return wxToolBar_GetToolState(wxObject, toolid);
        }

        public bool GetToolEnable(int toolid)
        {
            return wxToolBar_GetToolEnabled(wxObject, toolid);
        }

        //---------------------------------------------------------------------

        public string GetToolShortHelp(int toolid)
        {
            return new wxString(wxToolBar_GetToolShortHelp(wxObject, toolid), true);
        }

        public void SetToolShortHelp(int toolid, string helpString)
        {
            wxToolBar_SetToolShortHelp(wxObject, toolid, helpString);
        }

        //---------------------------------------------------------------------

        public string GetToolLongHelp(int toolid)
        {
            return new wxString(wxToolBar_GetToolLongHelp(wxObject, toolid), true);
        }

        public void SetToolLongHelp(int toolid, string helpString)
        {
            wxToolBar_SetToolLongHelp(wxObject, toolid, helpString);
        }

        //---------------------------------------------------------------------

        public void SetMargins(int x, int y)
        {
            Margins = new Size(x, y);
        }

        public Size Margins
        {
            get { 
			    Size size = new Size();
			    wxToolBar_GetToolMargins(wxObject, ref size);
                return size;
			}
            set { wxToolBar_SetMargins(wxObject, value.Width, value.Height); }
        }

        //---------------------------------------------------------------------

        public int ToolPacking
        {
            get { return wxToolBar_GetToolPacking(wxObject); }
            set { wxToolBar_SetToolPacking(wxObject, value); }
        }

        //---------------------------------------------------------------------

        public int Separation
        {
            get { return wxToolBar_GetToolSeparation(wxObject); }
            set { wxToolBar_SetToolSeparation(wxObject, value); }
        }

        //---------------------------------------------------------------------

        public int Rows
        {
            set { wxToolBar_SetRows(wxObject, value); }
        }

        public int MaxRows
        {
            get { return wxToolBar_GetMaxRows(wxObject); }
        }

        public int MaxCols
        {
            get { return wxToolBar_GetMaxCols(wxObject); }
        }

        //---------------------------------------------------------------------

        public void SetMaxRowsCols(int rows, int cols)
        {
            wxToolBar_SetMaxRowsCols(wxObject, rows, cols);
        }

        //---------------------------------------------------------------------

        public Size ToolBitmapSize
        {
            get { 
                Size size = new Size();
                wxToolBar_GetToolBitmapSize(wxObject, ref size); 
                return size;
            }
            set { wxToolBar_SetToolBitmapSize(wxObject, ref value); }
        }

        //---------------------------------------------------------------------

        public Size ToolSize
        {
            get { 
                Size size = new Size();
                wxToolBar_GetToolSize(wxObject, ref size); 
                return size;
            }
        }

        //---------------------------------------------------------------------

        public ToolBarTool FindToolForPosition(int x, int y)
        {
            return (ToolBarTool)FindObject(wxToolBar_FindToolForPosition(wxObject, x, y), typeof(ToolBarTool));
        }

        //---------------------------------------------------------------------

        public bool IsVertical
        {
            get { return wxToolBar_IsVertical(wxObject); }
        }

        //---------------------------------------------------------------------

        public override bool AcceptsFocus()
        {
            return wxToolBar_AcceptsFocus(wxObject); 
        }

	}
}

