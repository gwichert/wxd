//-----------------------------------------------------------------------------
// wx.NET - Window.cs
//
// The wxWindow wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public enum WindowVariant
	{
		wxWINDOW_VARIANT_NORMAL,  // Normal size
		wxWINDOW_VARIANT_SMALL,   // Smaller size (about 25 % smaller than normal)
		wxWINDOW_VARIANT_MINI,    // Mini size (about 33 % smaller than normal)
		wxWINDOW_VARIANT_LARGE,   // Large size (about 25 % larger than normal)
		wxWINDOW_VARIANT_MAX
	};	
	
	//---------------------------------------------------------------------
	
	public enum BackgroundStyle
	{
		wxBG_STYLE_SYSTEM,
		wxBG_STYLE_COLOUR,
		wxBG_STYLE_CUSTOM
	};
	
	//---------------------------------------------------------------------
	
	public enum Border
	{
		wxBORDER_DEFAULT = 0,

		wxBORDER_NONE   = 0x00200000,
		wxBORDER_STATIC = 0x01000000,
		wxBORDER_SIMPLE = 0x02000000,
		wxBORDER_RAISED = 0x04000000,
		wxBORDER_SUNKEN = 0x08000000,
		wxBORDER_DOUBLE = 0x10000000,

		wxBORDER_MASK   = 0x1f200000,
		
		wxDOUBLE_BORDER   = wxBORDER_DOUBLE,
		wxSUNKEN_BORDER   = wxBORDER_SUNKEN,
		wxRAISED_BORDER   = wxBORDER_RAISED,
		wxBORDER          = wxBORDER_SIMPLE,
		wxSIMPLE_BORDER   = wxBORDER_SIMPLE,
		wxSTATIC_BORDER   = wxBORDER_STATIC,
		wxNO_BORDER       = wxBORDER_NONE
	};
	
	//---------------------------------------------------------------------
	
	public class VisualAttributes : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxVisualAttributes_ctor();
		[DllImport("wx-c")] static extern void   wxVisualAttributes_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxVisualAttributes_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxVisualAttributes_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern IntPtr wxVisualAttributes_GetFont(IntPtr self);
		[DllImport("wx-c")] static extern void   wxVisualAttributes_SetColourFg(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxVisualAttributes_GetColourFg(IntPtr self);
		[DllImport("wx-c")] static extern void   wxVisualAttributes_SetColourBg(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxVisualAttributes_GetColourBg(IntPtr self);
		
		//---------------------------------------------------------------------

		public VisualAttributes(IntPtr wxObject)
			: base(wxObject)
		{ 
			this.wxObject = wxObject;
		}
		
		internal VisualAttributes(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public VisualAttributes()
			: this(wxVisualAttributes_ctor(), true) 
		{ 
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxVisualAttributes_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		//---------------------------------------------------------------------

		public Font font 
		{
			get { return new Font(wxVisualAttributes_GetFont(wxObject), true); }
			set { wxVisualAttributes_SetFont(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Colour colFg
		{
			get { return new Colour(wxVisualAttributes_GetColourFg(wxObject), true); }
			set { wxVisualAttributes_SetColourFg(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Colour colBg
		{
			get { return new Colour(wxVisualAttributes_GetColourBg(wxObject), true); }
			set { wxVisualAttributes_SetColourBg(wxObject, Object.SafePtr(value)); }
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
						wxVisualAttributes_dtor(wxObject);
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
		
		~VisualAttributes() 
		{
			Dispose();
		}
	}

	//---------------------------------------------------------------------

	public class Window : EvtHandler
	{
		public const long wxVSCROLL			= 0x80000000;
		public const long wxHSCROLL			= 0x40000000;
		public const long wxCAPTION			= 0x20000000;

		public const long wxDEFAULT_FRAME		= wxSYSTEM_MENU | wxRESIZE_BORDER |
									wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxCAPTION |
									wxCLIP_CHILDREN | wxCLOSE_BOX;
		public const long wxDEFAULT_FRAME_STYLE		= wxDEFAULT_FRAME;

		public const long wxDEFAULT_DIALOG_STYLE	= wxSYSTEM_MENU | wxCAPTION | wxCLOSE_BOX;

		public const long wxCLIP_CHILDREN		= 0x00400000;
		public const long wxMINIMIZE_BOX 		= 0x00000400;
		public const long wxCLOSE_BOX			= 0x1000;
		public const long wxMAXIMIZE_BOX		= 0x0200;
		public const long wxNO_3D			= 0x00800000;
		public const long wxRESIZE_BORDER		= 0x00000040;
		public const long wxSYSTEM_MENU			= 0x00000800;
		public const long wxTAB_TRAVERSAL		= 0x00008000;

		public const long wxNO_FULL_REPAINT_ON_RESIZE	= 0x00010000;

		public const int  wxID_OK			= 5100;
		public const int  wxID_CANCEL			= 5101;
		public const int  wxID_YES			= 5103;
		public const int  wxID_NO			= 5104;
	 
		public const int wxID_ANY			= -1;
		public const int wxID_ABOUT			= 5013;
	
		public const long wxSTAY_ON_TOP			= 0x8000;
		public const long wxICONIZE			= 0x4000;
		public const long wxMINIMIZE			= wxICONIZE;
		public const long wxMAXIMIZE			= 0x2000;
	
		public const long wxTINY_CAPTION_HORIZ		= 0x0100;
		public const long wxTINY_CAPTION_VERT		= 0x0080;
	
		public const long wxDIALOG_NO_PARENT		= 0x0001;
		public const long wxFRAME_NO_TASKBAR		= 0x0002;
		public const long wxFRAME_TOOL_WINDOW		= 0x0004;
		public const long wxFRAME_FLOAT_ON_PARENT	= 0x0008;
		public const long wxFRAME_SHAPED		= 0x0010;
		public const long wxFRAME_EX_CONTEXTHELP	= 0x00000004;

		//---------------------------------------------------------------------
	
		public const long wxBORDER_DEFAULT		= 0x00000000;
		public const long wxBORDER_NONE			= 0x00200000;
		public const long wxBORDER_STATIC		= 0x01000000;
		public const long wxBORDER_SIMPLE		= 0x02000000;
		public const long wxBORDER_RAISED		= 0x04000000;
		public const long wxBORDER_SUNKEN		= 0x08000000;
		public const long wxBORDER_DOUBLE		= 0x10000000;
		public const long wxBORDER_MASK			= 0x1f200000;
	
		// Border flags
		public const long wxDOUBLE_BORDER		= wxBORDER_DOUBLE;
		public const long wxSUNKEN_BORDER		= wxBORDER_SUNKEN;
		public const long wxRAISED_BORDER		= wxBORDER_RAISED;
		public const long wxBORDER			= wxBORDER_SIMPLE;
		public const long wxSIMPLE_BORDER		= wxBORDER_SIMPLE;
		public const long wxSTATIC_BORDER		= wxBORDER_STATIC;
		public const long wxNO_BORDER			= wxBORDER_NONE;
	
		public const long wxWANTS_CHARS			= 0x00040000;
		
		private static int uniqueID			= 10000; // start with 10000 to not interfere with the old id system

		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxWindow_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern bool   wxWindow_Close(IntPtr self, bool force);
		[DllImport("wx-c")] static extern void   wxWindow_GetBestSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern void   wxWindow_GetClientSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern int    wxWindow_GetId(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxWindow_GetWindowStyleFlag(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxWindow_Layout(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetAutoLayout(IntPtr self, bool autoLayout);
		[DllImport("wx-c")] static extern void   wxWindow_SetBackgroundColour(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetForegroundColour(IntPtr self, IntPtr colour);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetForegroundColour(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetCursor(IntPtr self, IntPtr cursor);
		[DllImport("wx-c")] static extern void   wxWindow_SetId(IntPtr self, int id);
		[DllImport("wx-c")] static extern void   wxWindow_SetSize(IntPtr self, int x, int y, int width, int height, uint flags);
		[DllImport("wx-c")] static extern void   wxWindow_SetSize2(IntPtr self, int width, int height);
		[DllImport("wx-c")] static extern void   wxWindow_SetSize3(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxWindow_SetSizer(IntPtr self, IntPtr sizer, bool deleteOld);
		[DllImport("wx-c")] static extern void   wxWindow_SetWindowStyleFlag(IntPtr self, uint style);
		[DllImport("wx-c")] static extern bool   wxWindow_Show(IntPtr self, bool show);
		[DllImport("wx-c")] static extern bool   wxWindow_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetFont(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetToolTip(IntPtr self, string tip);
		[DllImport("wx-c")] static extern bool 	 wxWindow_Enable(IntPtr self, bool enable);
		[DllImport("wx-c")] static extern bool   wxWindow_IsEnabled(IntPtr self);

		[DllImport("wx-c")] static extern int    wxWindow_EVT_TRANSFERDATAFROMWINDOW();
		[DllImport("wx-c")] static extern int    wxWindow_EVT_TRANSFERDATATOWINDOW();

		//[DllImport("wx-c")] static extern bool wxWindow_LoadFromResource(IntPtr self, IntPtr parent, string resourceName, IntPtr table);
		//[DllImport("wx-c")] static extern IntPtr wxWindow_CreateItem(IntPtr self, IntPtr childResource, IntPtr parentResource, IntPtr table);
		[DllImport("wx-c")] static extern bool   wxWindow_Destroy(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_DestroyChildren(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetTitle(IntPtr self, string title);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetTitle(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetName(IntPtr self, string name);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetName(IntPtr self);
		[DllImport("wx-c")] static extern int    wxWindow_NewControlId();
		[DllImport("wx-c")] static extern int    wxWindow_NextControlId(int id);
		[DllImport("wx-c")] static extern int    wxWindow_PrevControlId(int id);
		[DllImport("wx-c")] static extern void   wxWindow_Move(IntPtr self, int x, int y, int flags);
		[DllImport("wx-c")] static extern void   wxWindow_Raise(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_Lower(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetClientSize(IntPtr self, int width, int height);
		[DllImport("wx-c")] static extern void   wxWindow_GetPosition(IntPtr self, out Point point);
		[DllImport("wx-c")] static extern void   wxWindow_GetSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern void   wxWindow_GetRect(IntPtr self, out Rectangle rect);
		[DllImport("wx-c")] static extern void   wxWindow_GetClientAreaOrigin(IntPtr self, out Point point);
		[DllImport("wx-c")] static extern void   wxWindow_GetClientRect(IntPtr self, out Rectangle rect);
		[DllImport("wx-c")] static extern void   wxWindow_GetAdjustedBestSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern void   wxWindow_Center(IntPtr self, int direction);
		[DllImport("wx-c")] static extern void   wxWindow_CenterOnScreen(IntPtr self, int dir);
		[DllImport("wx-c")] static extern void   wxWindow_CenterOnParent(IntPtr self, int dir);
		[DllImport("wx-c")] static extern void   wxWindow_Fit(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_FitInside(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetSizeHints(IntPtr self, int minW, int minH, int maxW, int maxH, int incW, int incH);
		[DllImport("wx-c")] static extern void   wxWindow_SetVirtualSizeHints(IntPtr self, int minW, int minH, int maxW, int maxH);
		[DllImport("wx-c")] static extern int    wxWindow_GetMinWidth(IntPtr self);
		[DllImport("wx-c")] static extern int    wxWindow_GetMinHeight(IntPtr self);
		[DllImport("wx-c")] static extern int    wxWindow_GetMaxWidth(IntPtr self);
		[DllImport("wx-c")] static extern int    wxWindow_GetMaxHeight(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_GetMaxSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern void   wxWindow_SetVirtualSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxWindow_GetVirtualSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern void   wxWindow_GetBestVirtualSize(IntPtr self, out Size size);
		[DllImport("wx-c")] static extern bool   wxWindow_Hide(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_Disable(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_IsShown(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetWindowStyle(IntPtr self, uint style);
		[DllImport("wx-c")] static extern uint   wxWindow_GetWindowStyle(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_HasFlag(IntPtr self, int flag);
		[DllImport("wx-c")] static extern bool   wxWindow_IsRetained(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetExtraStyle(IntPtr self, uint exStyle);
		[DllImport("wx-c")] static extern uint   wxWindow_GetExtraStyle(IntPtr self);
		//[DllImport("wx-c")] static extern void wxWindow_MakeModal(IntPtr self, bool modal);
		[DllImport("wx-c")] static extern void   wxWindow_SetThemeEnabled(IntPtr self, bool enableTheme);
		[DllImport("wx-c")] static extern bool   wxWindow_GetThemeEnabled(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetFocus(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetFocusFromKbd(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_FindFocus();
		[DllImport("wx-c")] static extern bool   wxWindow_AcceptsFocus(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_AcceptsFocusFromKeyboard(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetParent(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetGrandParent(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_IsTopLevel(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetParent(IntPtr self, IntPtr parent);
		[DllImport("wx-c")] static extern bool   wxWindow_Reparent(IntPtr self, IntPtr newParent);
		[DllImport("wx-c")] static extern void   wxWindow_AddChild(IntPtr self, IntPtr child);
		[DllImport("wx-c")] static extern void   wxWindow_RemoveChild(IntPtr self, IntPtr child);
		[DllImport("wx-c")] static extern IntPtr wxWindow_FindWindowId(IntPtr self, int id);
		[DllImport("wx-c")] static extern IntPtr wxWindow_FindWindowName(IntPtr self, string name);
		[DllImport("wx-c")] static extern IntPtr wxWindow_FindWindowById(int id, IntPtr parent);
		[DllImport("wx-c")] static extern IntPtr wxWindow_FindWindowByName(string name, IntPtr parent);
		[DllImport("wx-c")] static extern IntPtr wxWindow_FindWindowByLabel(string label, IntPtr parent);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetEventHandler(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetEventHandler(IntPtr self, IntPtr handler);
		[DllImport("wx-c")] static extern void   wxWindow_PushEventHandler(IntPtr self, IntPtr handler);
		[DllImport("wx-c")] static extern IntPtr wxWindow_PopEventHandler(IntPtr self, bool deleteHandler);
		[DllImport("wx-c")] static extern bool   wxWindow_RemoveEventHandler(IntPtr self, IntPtr handler);
		[DllImport("wx-c")] static extern void   wxWindow_SetValidator(IntPtr self, IntPtr validator);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetValidator(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_Validate(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_TransferDataToWindow(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_TransferDataFromWindow(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_InitDialog(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetAcceleratorTable(IntPtr self, IntPtr accel);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetAcceleratorTable(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_ConvertPixelsToDialogPoint(IntPtr self, ref Point pt, out Point point);
		[DllImport("wx-c")] static extern void   wxWindow_ConvertDialogToPixelsPoint(IntPtr self, ref Point pt, out Point point);
		[DllImport("wx-c")] static extern void   wxWindow_ConvertPixelsToDialogSize(IntPtr self, ref Size sz, out Size size);
		[DllImport("wx-c")] static extern void   wxWindow_ConvertDialogToPixelsSize(IntPtr self, ref Size sz, out Size size);
		[DllImport("wx-c")] static extern void   wxWindow_WarpPointer(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void   wxWindow_CaptureMouse(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_ReleaseMouse(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetCapture();
		[DllImport("wx-c")] static extern bool   wxWindow_HasCapture(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_Refresh(IntPtr self, bool eraseBackground, ref Rectangle rect);
		[DllImport("wx-c")] static extern void   wxWindow_RefreshRect(IntPtr self, ref Rectangle rect);
		[DllImport("wx-c")] static extern void   wxWindow_Update(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_ClearBackground(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_Freeze(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_Thaw(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_PrepareDC(IntPtr self, IntPtr dc);
		[DllImport("wx-c")] static extern bool   wxWindow_IsExposed(IntPtr self, int x, int y, int w, int h);
		[DllImport("wx-c")] static extern void   wxWindow_SetCaret(IntPtr self, IntPtr caret);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetCaret(IntPtr self);
		[DllImport("wx-c")] static extern int    wxWindow_GetCharHeight(IntPtr self);
		[DllImport("wx-c")] static extern int    wxWindow_GetCharWidth(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_GetTextExtent(IntPtr self, string str, out int x, out int y, out int descent, out int externalLeading, IntPtr theFont);
		[DllImport("wx-c")] static extern void   wxWindow_ClientToScreen(IntPtr self, ref int x, ref int y);
		[DllImport("wx-c")] static extern void   wxWindow_ScreenToClient(IntPtr self, ref int x, ref int y);
		[DllImport("wx-c")] static extern void   wxWindow_ClientToScreen(IntPtr self, ref Point pt, out Point point);
		[DllImport("wx-c")] static extern void   wxWindow_ScreenToClient(IntPtr self, ref Point pt, out Point point);
		//[DllImport("wx-c")] static extern wxHitTest wxWindow_HitTest(IntPtr self, Coord x, Coord y);
		//[DllImport("wx-c")] static extern wxHitTest wxWindow_HitTest(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern int    wxWindow_GetBorder(IntPtr self);
		[DllImport("wx-c")] static extern int    wxWindow_GetBorderByFlags(IntPtr self, uint flags);
		[DllImport("wx-c")] static extern void   wxWindow_UpdateWindowUI(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_PopupMenu(IntPtr self, IntPtr menu, ref Point pos);
		[DllImport("wx-c")] static extern bool   wxWindow_HasScrollbar(IntPtr self, int orient);
		[DllImport("wx-c")] static extern void   wxWindow_SetScrollbar(IntPtr self, int orient, int pos, int thumbvisible, int range, bool refresh);
		[DllImport("wx-c")] static extern void   wxWindow_SetScrollPos(IntPtr self, int orient, int pos, bool refresh);
		[DllImport("wx-c")] static extern int    wxWindow_GetScrollPos(IntPtr self, int orient);
		[DllImport("wx-c")] static extern int    wxWindow_GetScrollThumb(IntPtr self, int orient);
		[DllImport("wx-c")] static extern int    wxWindow_GetScrollRange(IntPtr self, int orient);
		[DllImport("wx-c")] static extern void   wxWindow_ScrollWindow(IntPtr self, int dx, int dy, ref Rectangle rect);
		[DllImport("wx-c")] static extern bool   wxWindow_ScrollLines(IntPtr self, int lines);
		[DllImport("wx-c")] static extern bool   wxWindow_ScrollPages(IntPtr self, int pages);
		[DllImport("wx-c")] static extern bool   wxWindow_LineUp(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_LineDown(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_PageUp(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_PageDown(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetHelpText(IntPtr self, string text);
		[DllImport("wx-c")] static extern void   wxWindow_SetHelpTextForId(IntPtr self, string text);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetHelpText(IntPtr self);
		//[DllImport("wx-c")] static extern void wxWindow_SetToolTip(IntPtr self, IntPtr tip);
		//[DllImport("wx-c")] static extern IntPtr wxWindow_GetToolTip(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetDropTarget(IntPtr self, IntPtr dropTarget);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetDropTarget(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetConstraints(IntPtr self, IntPtr constraints);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetConstraints(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_GetAutoLayout(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetSizerAndFit(IntPtr self, IntPtr sizer, bool deleteOld);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetSizer(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetContainingSizer(IntPtr self, IntPtr sizer);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetContainingSizer(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetPalette(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_SetPalette(IntPtr self, IntPtr pal);
		[DllImport("wx-c")] static extern bool   wxWindow_HasCustomPalette(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetUpdateRegion(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxWindow_SetWindowVariant(IntPtr self, int variant);
		[DllImport("wx-c")] static extern int    wxWindow_GetWindowVariant(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_IsBeingDeleted(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_InvalidateBestSize(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_CacheBestSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxWindow_GetBestFittingSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxWindow_SetBestFittingSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetChildren(IntPtr self, int num);
		[DllImport("wx-c")] static extern int    wxWindow_GetChildrenCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetDefaultAttributes(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetClassDefaultAttributes(int variant);
		[DllImport("wx-c")] static extern void   wxWindow_SetBackgroundStyle(IntPtr self, int style);
		[DllImport("wx-c")] static extern int    wxWindow_GetBackgroundStyle(IntPtr self);
		//[DllImport("wx-c")] static extern IntPtr wxWindow_GetToolTipText(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxWindow_GetAncestorWithCustomPalette(IntPtr self);
		[DllImport("wx-c")] static extern void   wxWindow_InheritAttributes(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxWindow_ShouldInheritColours(IntPtr self);

		//---------------------------------------------------------------------

		public static Point wxDefaultPosition = new Point(-1, -1);
		public static Size  wxDefaultSize     = new Size(-1, -1);

		//---------------------------------------------------------------------

		public Window(Window parent)
			: this(parent, -1, wxDefaultPosition, wxDefaultSize, 0, null) {}

		public Window(Window parent, int id, Point pos, Size size, long style, string name)
			: this(wxWindow_ctor(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name), true) {}
			
		public Window(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}

		public Window(IntPtr wxObject) 
			: base(wxObject)
		{
			AddEventListener(wxWindow_EVT_TRANSFERDATATOWINDOW(), new EventListener(OnTransferDataToWindow));
			AddEventListener(wxWindow_EVT_TRANSFERDATAFROMWINDOW(), new EventListener(OnTransferDataFromWindow));
		}
		
		internal Window(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
			
			AddEventListener(wxWindow_EVT_TRANSFERDATATOWINDOW(), new EventListener(OnTransferDataToWindow));
			AddEventListener(wxWindow_EVT_TRANSFERDATAFROMWINDOW(), new EventListener(OnTransferDataFromWindow));
		}

		//---------------------------------------------------------------------

		public virtual Colour BackgroundColour
		{
			set
			{
				wxWindow_SetBackgroundColour(wxObject, Object.SafePtr(value));
			}
			get
			{
				return new Colour(wxWindow_GetBackgroundColour(wxObject), true);
			}
		}

		public virtual Colour ForegroundColour
		{
			get
			{
				return new Colour(wxWindow_GetForegroundColour(wxObject), true);
			}
			set
			{
				wxWindow_SetForegroundColour(wxObject, Object.SafePtr(value));
			}
		}

		//---------------------------------------------------------------------

		// Note: was previously defined as WindowFont
		public virtual Font Font
		{
			set
			{
				wxWindow_SetFont(wxObject, value.wxObject);
			}
			
			get
			{
				return new Font(wxWindow_GetFont(wxObject), true);
			}
		}


		//---------------------------------------------------------------------

		public virtual Size BestSize
		{
			get
			{
				Size size;
				wxWindow_GetBestSize(wxObject, out size);
				return size;
			}
		}

		//---------------------------------------------------------------------

		public virtual Size ClientSize
		{
			get
			{
				Size size = new Size();
				wxWindow_GetClientSize(wxObject, out size);
				return size;
			}
			set
			{
				wxWindow_SetClientSize(wxObject, value.Width, value.Height);
			}
		}

		//---------------------------------------------------------------------

		public virtual bool Close()
		{
			return wxWindow_Close(wxObject, false);
		}

		public virtual bool Close(bool force)
		{
			return wxWindow_Close(wxObject, force);
		}

		//---------------------------------------------------------------------

		public virtual int ID 
		{
			get { return wxWindow_GetId(wxObject); }
			set { wxWindow_SetId(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public static int UniqueID
		{
			get {
				uniqueID++;
				return uniqueID;
			}
		}
		
		//---------------------------------------------------------------------

		public virtual void Layout()
		{
			wxWindow_Layout(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual Cursor Cursor 
		{
			set { wxWindow_SetCursor(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public virtual void SetSize(int x, int y, int width, int height)
		{
			wxWindow_SetSize(wxObject, x, y, width, height, 0);
		}
		
		public virtual void SetSize(int width, int height)
		{
			wxWindow_SetSize2(wxObject, width, height);
		}
		
		public virtual void SetSize(Size size)
		{
			wxWindow_SetSize3(wxObject, ref size);
		}

		//---------------------------------------------------------------------

		public virtual void SetSizer(Sizer sizer )
		{ 
			SetSizer( sizer, true); 
		}

		public virtual void SetSizer(Sizer sizer, bool deleteOld)
		{
			wxWindow_SetSizer(wxObject, sizer.wxObject, deleteOld);
		}

		//---------------------------------------------------------------------
		
		public virtual bool Show()
		{
			return Show(true);
		}

		public virtual bool Show(bool show)
		{
			return wxWindow_Show(wxObject, show);
		}

		//---------------------------------------------------------------------

		public virtual long StyleFlags
		{
			get
			{
				return wxWindow_GetWindowStyleFlag(wxObject);
			}
			set
			{
				wxWindow_SetWindowStyleFlag(wxObject, (uint)value);
			}
		}

		//---------------------------------------------------------------------

		private void OnTransferDataFromWindow(object sender, Event e)
		{
			if (!TransferDataFromWindow())
				e.Skip();
		}

		//---------------------------------------------------------------------

		private void OnTransferDataToWindow(object sender, Event e)
		{
			if (!TransferDataToWindow())
				e.Skip();
		}

		//---------------------------------------------------------------------

		public virtual string ToolTip
		{
			set
			{
				wxWindow_SetToolTip(wxObject, value);
			}
		}

		//---------------------------------------------------------------------

		public virtual bool Enabled
		{
			set
			{
				wxWindow_Enable(wxObject, value);
			}
			get
			{
				return wxWindow_IsEnabled(wxObject);
			}
		}

		//---------------------------------------------------------------------

		public virtual bool Destroy()
		{
			return wxWindow_Destroy(wxObject);
		}

		public virtual bool DestroyChildren()
		{
			return wxWindow_DestroyChildren(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual string Title
		{
			set
			{
				wxWindow_SetTitle(wxObject, value);
			}
			get
			{
				return new wxString(wxWindow_GetTitle(wxObject), true);
			}
		}

		//---------------------------------------------------------------------

		public virtual string Name
		{
			set
			{
				wxWindow_SetName(wxObject, value);
			}
			get
			{
				return new wxString(wxWindow_GetName(wxObject), true);
			}
		}

		//---------------------------------------------------------------------

		public static int NewControlId()
		{
			return wxWindow_NewControlId();
		}

		public static int NextControlId(int id)
		{
			return wxWindow_NextControlId(id);
		}

		public static int PrevControlId(int id)
		{
			return wxWindow_PrevControlId(id);
		}

		//---------------------------------------------------------------------

		public virtual void Move(int x, int y, int flags)
		{
			wxWindow_Move(wxObject, x, y, flags);
		}

		//---------------------------------------------------------------------

		public virtual void Raise()
		{
			wxWindow_Raise(wxObject);
		}

		public virtual void Lower()
		{
			wxWindow_Lower(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual Point Position
		{
			get
			{
				Point point = new Point();
				wxWindow_GetPosition(wxObject, out point);
				return point;
			}
			set
			{
				Move(value.X, value.Y, 0);
			}
		}

		//---------------------------------------------------------------------

		public virtual Size Size
		{
			get
			{
				Size size = new Size();
				wxWindow_GetSize(wxObject, out size);
				return size;
			}
			set
			{
				wxWindow_SetSize(wxObject, Position.X, Position.Y,
								 value.Width, value.Height, 0);
			}
		}

		//---------------------------------------------------------------------

		public virtual Rectangle Rect
		{
			get
			{
				Rectangle rect = new Rectangle();
				wxWindow_GetRect(wxObject, out rect);
				return rect;
			}
		}

		//---------------------------------------------------------------------

		public virtual Point ClientAreaOrigin
		{
			get 
			{
				Point point = new Point();
				wxWindow_GetClientAreaOrigin(wxObject, out point);
				return point;
			}
		}

		//---------------------------------------------------------------------

		public virtual Rectangle ClientRect
		{
			get
			{
				Rectangle rect = new Rectangle();
				wxWindow_GetClientRect(wxObject, out rect);
				return rect;
			}
		}

		//---------------------------------------------------------------------

		public virtual Size AdjustedBestSize
		{
			get { 
				Size size = new Size();
				wxWindow_GetAdjustedBestSize(wxObject, out size);
				return size;
			}
		}

		//---------------------------------------------------------------------

		public virtual void Centre()
		{ 
			Center( Orientation.wxBOTH ); 
		}
		
		public virtual void Center()
		{ 
			Center( Orientation.wxBOTH ); 
		}
		
		public virtual void Centre(int direction)
		{ 
			Center( direction ); 
		}
		
		public virtual void Center(int direction)
		{
			wxWindow_Center(wxObject, direction);
		}

		public virtual void CentreOnScreen()
		{ 
			CenterOnScreen( Orientation.wxBOTH ); 
		}
		
		public virtual void CenterOnScreen()
		{ 
			CenterOnScreen( Orientation.wxBOTH ); 
		}
		
		public virtual void CentreOnScreen(int direction)
		{ 
			CenterOnScreen( direction ); 
		}
		
		public virtual void CenterOnScreen(int direction)
		{
			wxWindow_CenterOnScreen(wxObject, direction);
		}

		public virtual void CentreOnParent()
		{ 
			CenterOnParent( Orientation.wxBOTH ); 
		}
		
		public virtual void CenterOnParent()
		{ 
			CenterOnParent( Orientation.wxBOTH ); 
		}
		
		public virtual void CentreOnParent(int direction)
		{ 
			CenterOnParent( direction ); 
		}
		
		public virtual void CenterOnParent(int direction)
		{
			wxWindow_CenterOnParent(wxObject, direction);
		}

		//---------------------------------------------------------------------

		public virtual void Fit()
		{
			wxWindow_Fit(wxObject);
		}

		public virtual void FitInside()
		{
			wxWindow_FitInside(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual void SetSizeHints(int minW, int minH)
		{ 
			SetSizeHints(minW, minH, -1, -1, -1, -1); 
		}
		
		public virtual void SetSizeHints(int minW, int minH, int maxW, int maxH)
		{ 
			SetSizeHints(minW, minH, maxW, maxH, -1, -1); 
		}
		
		public virtual void SetSizeHints(int minW, int minH, int maxW, int maxH, int incW, int incH)
		{
			wxWindow_SetSizeHints(wxObject, minW, minH, maxW, maxH, incW, incH);
		}

		public virtual void SetVirtualSizeHints(int minW, int minH, int maxW, int maxH)
		{
			wxWindow_SetVirtualSizeHints(wxObject, minW, minH, maxW, maxH);
		}

		//---------------------------------------------------------------------

		public virtual int MinWidth
		{
			get
			{
				return wxWindow_GetMinWidth(wxObject);
			}
		}

		public virtual int MinHeight
		{
			get
			{
				return wxWindow_GetMinHeight(wxObject);
			}
		}

		public virtual int MaxWidth
		{
			get
			{
				return wxWindow_GetMaxWidth(wxObject);
			}
		}

		public virtual int MaxHeight
		{
			get
			{
				return wxWindow_GetMaxHeight(wxObject);
			}
		}

		//---------------------------------------------------------------------

		public virtual Size MaxSize
		{
			get {
				Size size = new Size();
				wxWindow_GetMaxSize(wxObject, out size);
				return size;
			}
		}

		//---------------------------------------------------------------------

		public virtual Size VirtualSize
		{
			get
			{
				Size size = new Size();
				wxWindow_GetVirtualSize(wxObject, out size);
				return size;
			}
			set
			{
				wxWindow_SetVirtualSize(wxObject, ref value);
			}
		}

		//---------------------------------------------------------------------

		public virtual Size BestVirtualSize
		{
			get {
				Size size = new Size();
				wxWindow_GetBestVirtualSize(wxObject, out size);
				return size;
			}
		}

		//---------------------------------------------------------------------

		public virtual bool Hide()
		{
			return wxWindow_Hide(wxObject);
		}

		public virtual bool Disable()
		{
			return wxWindow_Disable(wxObject);
		}

		public virtual bool IsShown
		{
			get { return wxWindow_IsShown(wxObject); }
		}

		//---------------------------------------------------------------------

		public virtual long WindowStyle
		{
			get
			{
				return wxWindow_GetWindowStyle(wxObject);
			}
			set
			{
				wxWindow_SetWindowStyle(wxObject, (uint)value);
			}
		}

		public virtual bool HasFlag(int flag)
		{
			return wxWindow_HasFlag(wxObject, flag);
		}

		//---------------------------------------------------------------------

		public virtual bool IsRetained
		{
			get { return wxWindow_IsRetained(wxObject); }
		}

		//---------------------------------------------------------------------

		public virtual long ExtraStyle
		{
			get
			{
				return wxWindow_GetExtraStyle(wxObject);
			}
			set
			{
				wxWindow_SetExtraStyle(wxObject, (uint)value);
			}
		}

		//---------------------------------------------------------------------

		public bool ThemeEnabled
		{
			get
			{
				return wxWindow_GetThemeEnabled(wxObject);
			}
			set
			{
				wxWindow_SetThemeEnabled(wxObject, value);
			}
		}

		//---------------------------------------------------------------------

		public virtual void SetFocus()
		{
			wxWindow_SetFocus(wxObject);
		}

		public virtual void SetFocusFromKbd()
		{
			wxWindow_SetFocusFromKbd(wxObject);
		}

		public static Window FindFocus()
		{
			return (Window)FindObject(wxWindow_FindFocus());
		}

		//---------------------------------------------------------------------

		public virtual bool AcceptsFocus()
		{
			return wxWindow_AcceptsFocus(wxObject);
		}

		public virtual bool AcceptsFocusFromKeyboard()
		{
			return wxWindow_AcceptsFocusFromKeyboard(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual Window Parent
		{
			get { return (Window)FindObject(wxWindow_GetParent(wxObject)); }
			set { wxWindow_SetParent(wxObject, Object.SafePtr(value)); }
		}

		public virtual Window GrandParent
		{
			get { return (Window)FindObject(wxWindow_GetGrandParent(wxObject)); }
		}

		public virtual bool Reparent(Window newParent)
		{
			return wxWindow_Reparent(wxObject, Object.SafePtr(newParent));
		}

		//---------------------------------------------------------------------

		public virtual bool IsTopLevel
		{
			get { return wxWindow_IsTopLevel(wxObject); }
		}
		//---------------------------------------------------------------------

		public virtual void AddChild(Window child)
		{
			wxWindow_AddChild(wxObject, Object.SafePtr(child));
		}

		public virtual void RemoveChild(Window child)
		{
			wxWindow_RemoveChild(wxObject, Object.SafePtr(child));
		}

		//---------------------------------------------------------------------

		public virtual Window FindWindow(int id)
		{
			return (Window)FindObject(wxWindow_FindWindowId(wxObject, id));
		}

		public virtual Window FindWindow(int id, Type type)
		{
			return (Window)FindObject(wxWindow_FindWindowId(wxObject, id), type);
		}

		public virtual Window FindWindow(string name)
		{
			return (Window)FindObject(wxWindow_FindWindowName(wxObject, name));
		}

		//---------------------------------------------------------------------

		public static Window FindWindowById(int id, Window parent)
		{
			return (Window)FindObject(wxWindow_FindWindowById(id, Object.SafePtr(parent)));
		}

		public static Window FindWindowByName(string name, Window parent)
		{
			return (Window)FindObject(wxWindow_FindWindowByName(name, Object.SafePtr(parent)));
		}

		public static Window FindWindowByLabel(string label, Window parent)
		{
			return (Window)FindObject(wxWindow_FindWindowByLabel(label, Object.SafePtr(parent)));
		}

		//---------------------------------------------------------------------

		public EvtHandler EventHandler
		{
			get
			{
				return (EvtHandler)FindObject(
						wxWindow_GetEventHandler(wxObject),
						typeof(EvtHandler)
					);
			}
			set
			{
				wxWindow_SetEventHandler(wxObject, Object.SafePtr(value));
			}
		}

		//---------------------------------------------------------------------

		public void PushEventHandler(EvtHandler handler)
		{
			wxWindow_PushEventHandler(wxObject, Object.SafePtr(handler));
		}

		public EvtHandler PopEventHandler(bool deleteHandler)
		{
			return (EvtHandler)FindObject(
					wxWindow_PopEventHandler(wxObject, deleteHandler),
					typeof(EvtHandler)
	                        );
		}

		public bool RemoveEventHandler(EvtHandler handler)
		{
			return wxWindow_RemoveEventHandler(wxObject, Object.SafePtr(handler));
		}

		//---------------------------------------------------------------------

		public virtual Validator Validator
		{
			get
			{
				return (Validator)FindObject(wxWindow_GetValidator(wxObject));
			}
			set
			{
				wxWindow_SetValidator(wxObject, Object.SafePtr(value));
			}
		}

		public virtual bool Validate()
		{
			return wxWindow_Validate(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual bool TransferDataToWindow()
		{
			//return wxWindow_TransferDataToWindow(wxObject);
			return true;
		}

		public virtual bool TransferDataFromWindow()
		{
			//return wxWindow_TransferDataFromWindow(wxObject);
			return true;
		}

		//---------------------------------------------------------------------

		public virtual void InitDialog()
		{
			wxWindow_InitDialog(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual Point ConvertPixelsToDialog(Point pt)
		{
			Point point = new Point();
			wxWindow_ConvertPixelsToDialogPoint(wxObject, ref pt, out point);
			return point;
		}

		public virtual Point ConvertDialogToPixels(Point pt)
		{
			Point point = new Point();
			wxWindow_ConvertDialogToPixelsPoint(wxObject, ref pt, out point);
			return point;
		}

		public virtual Size ConvertPixelsToDialog(Size sz)
		{
			Size size = new Size();
			wxWindow_ConvertPixelsToDialogSize(wxObject, ref sz, out size);
			return size;
		}

		public virtual Size ConvertDialogToPixels(Size sz)
		{
			Size size = new Size();
			wxWindow_ConvertPixelsToDialogSize(wxObject, ref sz, out size);
			return size;
		}

		//---------------------------------------------------------------------

		public virtual void WarpPointer(int x, int y)
		{
			wxWindow_WarpPointer(wxObject, x, y);
		}

		public virtual void CaptureMouse()
		{
			wxWindow_CaptureMouse(wxObject);
		}

		public virtual void ReleaseMouse()
		{
			wxWindow_ReleaseMouse(wxObject);
		}

		public static Window GetCapture()
		{
			return (Window)FindObject(wxWindow_GetCapture());
		}

		public virtual bool HasCapture()
		{
			return wxWindow_HasCapture(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual void Refresh()
		{
			Refresh(true, ClientRect);
		}

		public virtual void Refresh(bool eraseBackground, Rectangle rect)
		{
			wxWindow_Refresh(wxObject, eraseBackground, ref rect);
		}

		public virtual void RefreshRectangle(Rectangle rect)
		{
			wxWindow_RefreshRect(wxObject, ref rect);
		}

		//---------------------------------------------------------------------

		public virtual void Update()
		{
			wxWindow_Update(wxObject);
		}

		public virtual void ClearBackground()
		{
			wxWindow_ClearBackground(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual void Freeze()
		{
			wxWindow_Freeze(wxObject);
		}

		public virtual void Thaw()
		{
			wxWindow_Thaw(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual void PrepareDC(DC dc)
		{
			wxWindow_PrepareDC(wxObject, Object.SafePtr(dc));
		}

		//---------------------------------------------------------------------

		public virtual bool  IsExposed(int x, int y, int w, int h)
		{
			return wxWindow_IsExposed(wxObject, x, y, w, h);
		}

		//---------------------------------------------------------------------

		public virtual Caret Caret
		{
			get
			{
				return (Caret)Object.FindObject(wxWindow_GetCaret(wxObject),
						typeof(Caret));
			}
			set
			{
				wxWindow_SetCaret(wxObject, Object.SafePtr(value));
			}
		}

		//---------------------------------------------------------------------

		public virtual int CharHeight
		{
			get { return wxWindow_GetCharHeight(wxObject); }
		}

		public virtual int CharWidth
		{
			get { return wxWindow_GetCharWidth(wxObject); }
		}

		//---------------------------------------------------------------------

		public void GetTextExtent(string str, out int x, out int y, out int descent,
								  out int externalLeading, Font font)
		{
			wxWindow_GetTextExtent(wxObject, str, out x, out y, out descent,
								   out externalLeading, Object.SafePtr(font));
		}

		//---------------------------------------------------------------------

		public void ClientToScreen(ref int x, ref int y)
		{
			wxWindow_ClientToScreen(wxObject, ref x, ref y);
		}

		public Point ClientToScreen(Point clientPoint)
		{
			Point screenPoint;
			wxWindow_ClientToScreen(wxObject, ref clientPoint, out screenPoint);
			return screenPoint;
		}

		public virtual void ScreenToClient(ref int x, ref int y)
		{
			wxWindow_ScreenToClient(wxObject, ref x, ref y);
		}

		public Point ScreenToClient(Point screenPoint)
		{
			Point clientPoint;
			wxWindow_ScreenToClient(wxObject, ref screenPoint, out clientPoint);
			return clientPoint;
		}

		//---------------------------------------------------------------------

		public virtual void UpdateWindowUI()
		{
			wxWindow_UpdateWindowUI(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual bool PopupMenu(Menu menu, Point pos)
		{
			bool tmpbool = wxWindow_PopupMenu(wxObject, Object.SafePtr(menu), ref pos);
			
			menu.ConnectEvents(this);
			
			return tmpbool;
		}

		//---------------------------------------------------------------------

		public virtual bool HasScrollbar(int orient)
		{
			return wxWindow_HasScrollbar(wxObject, orient);
		}

		public virtual void SetScrollbar(int orient, int pos, int thumbSize, int range, bool refresh)
		{
			wxWindow_SetScrollbar(wxObject, orient, pos, thumbSize, range, refresh);
		}

		public virtual void SetScrollPos(int orient, int pos, bool refresh)
		{
			wxWindow_SetScrollPos(wxObject, orient, pos, refresh);
		}

		//---------------------------------------------------------------------

		public virtual int GetScrollPos(int orient)
		{
			return wxWindow_GetScrollPos(wxObject, orient);
		}

		public virtual int GetScrollThumb(int orient)
		{
			return wxWindow_GetScrollThumb(wxObject, orient);
		}

		public virtual int GetScrollRange(int orient)
		{
			return wxWindow_GetScrollRange(wxObject, orient);
		}

		//---------------------------------------------------------------------

		public virtual void ScrollWindow(int dx, int dy, Rectangle rect)
		{
			wxWindow_ScrollWindow(wxObject, dx, dy, ref rect);
		}

		public virtual bool ScrollLines(int lines)
		{
			return wxWindow_ScrollLines(wxObject, lines);
		}

		public virtual bool ScrollPages(int pages)
		{
			return wxWindow_ScrollPages(wxObject, pages);
		}

		//---------------------------------------------------------------------

		public virtual bool LineUp()
		{
			return wxWindow_LineUp(wxObject);
		}

		public virtual bool LineDown()
		{
			return wxWindow_LineDown(wxObject);
		}

		public virtual bool PageUp()
		{
			return wxWindow_PageUp(wxObject);
		}

		public virtual bool PageDown()
		{
			return wxWindow_PageDown(wxObject);
		}

		//---------------------------------------------------------------------

		public virtual string HelpText
		{
			get
			{
				return new wxString(wxWindow_GetHelpText(wxObject), true);
			}
			set
			{
				wxWindow_SetHelpText(wxObject, value);
			}
		}

		public virtual void SetHelpTextForId(string text)
		{
			wxWindow_SetHelpTextForId(wxObject, text);
		}

		//---------------------------------------------------------------------

		public virtual DropTarget DropTarget
		{
			get
			{
				return (DropTarget)Object.FindObject(wxWindow_GetDropTarget(wxObject),
							typeof(DropTarget));
			}
			set
			{
				wxWindow_SetDropTarget(wxObject, Object.SafePtr(value));
			}
		}

		//---------------------------------------------------------------------

		// LayoutConstraints are now depreciated.  Should this be implemented?
		/*public LayoutContraints Constraints
		{
			get
			{
				return new LayoutConstraints(wxWindow_GetConstraints(wxObject));
			}
			set
			{
				wxWindow_SetConstraints(wxObject, Object.SafePtr(value));
			}
		}*/

		//---------------------------------------------------------------------

		public virtual bool AutoLayout
		{
			get
			{
				return wxWindow_GetAutoLayout(wxObject);
			}
			set
			{
				wxWindow_SetAutoLayout(wxObject, value);
			}
		}

		//---------------------------------------------------------------------

		public virtual void SetSizerAndFit(Sizer sizer, bool deleteOld)
		{
			wxWindow_SetSizerAndFit(wxObject, Object.SafePtr(sizer), deleteOld);
		}

		//---------------------------------------------------------------------

		public virtual Sizer Sizer
		{
			get
			{
				return (Sizer)FindObject(wxWindow_GetSizer(wxObject));
			}
			set
			{
				SetSizer(value, true);
			}
		}

		//---------------------------------------------------------------------

		public virtual Sizer ContainingSizer
		{
			get
			{
				return (Sizer)FindObject(wxWindow_GetContainingSizer(wxObject));
			}
			set
			{
				wxWindow_SetContainingSizer(wxObject, Object.SafePtr(value));
			}
		}

		//---------------------------------------------------------------------

		public virtual Palette Palette
		{
			get
			{
				return new Palette(wxWindow_GetPalette(wxObject));
			}
			set
			{
				wxWindow_SetPalette(wxObject, Object.SafePtr(value));
			}
		}

		//---------------------------------------------------------------------

		public virtual bool HasCustomPalette()
		{
			return wxWindow_HasCustomPalette(wxObject);
		}

		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern int wxGlobal_GetNumberFromUser(string msg, string prompt, string caption, int value, int min, int max, IntPtr parent, ref Point pos);
		
		public static int GetNumberFromUser(string msg, string prompt,
					string caption, int value)
		{
			return GetNumberFromUser(msg, prompt, caption,
					value, 0, 100, null,
					wxDefaultPosition);
		}
		
		public static int GetNumberFromUser(string msg, string prompt,
					string caption, int value, int min)
		{
			return GetNumberFromUser(msg, prompt, caption,
					value, min, 100, null,
					wxDefaultPosition);
		}
		
		public static int GetNumberFromUser(string msg, string prompt,
					string caption, int value, int min, int max)
		{
			return GetNumberFromUser(msg, prompt, caption,
					value, min, max, null,
					wxDefaultPosition);
		}
		
		public static int GetNumberFromUser(string msg, string prompt,
					string caption, int value, int min, int max, Window parent)
		{
			return GetNumberFromUser(msg, prompt, caption,
					value, min, max, parent,
					wxDefaultPosition);
		}

		public static int GetNumberFromUser(string msg, string prompt,
					string caption, int value, int min, int max,
					Window parent, Point pos)
		{
			return wxGlobal_GetNumberFromUser(msg, prompt, caption,
					value, min, max, Object.SafePtr(parent),
					ref pos);
		}
		//---------------------------------------------------------------------

		public virtual Region UpdateRegion
		{
			get { return new wx.Region(wxWindow_GetUpdateRegion(wxObject)); }
		}

		//---------------------------------------------------------------------
		
		// Implement very common System.Windows.Forms.Control members

		public virtual int Top 
		{
			get	{ return this.Position.Y; }
			set	{ this.Move(this.Position.X, value,	0);	}
		}

		public virtual int Left	
		{
			get	{ return this.Position.X; }
			set	{ this.Move(value, this.Position.Y,	0);	}
		}

		public virtual int Right 
		{
			get	{ return this.Position.X + this.Size.Width;	}
			set	{ this.Move(value -	this.Size.Width, this.Position.Y, 0); }
		}

		public virtual int Bottom 
		{
			get	{ return this.Position.Y + this.Size.Height; }
			set	{ this.Move(this.Position.X, value - this.Size.Height, 0); }
		}

		public virtual int Width 
		{
			get	{ return this.Size.Width; }
			set	{ this.Size	= new Size(value, this.Size.Height); }
		}

		public virtual int Height 
		{
			get	{ return this.Size.Height; }
			set	{ this.Size	= new Size(this.Size.Width,	value);	}
		}

		//---------------------------------------------------------------------
		
		public WindowVariant WindowVariant
		{
			get { return (WindowVariant)wxWindow_GetWindowVariant(wxObject); }
			set { wxWindow_SetWindowVariant(wxObject, (int)value); }
		}
		
		//---------------------------------------------------------------------
		
		public bool IsBeingDeleted()
		{
			return wxWindow_IsBeingDeleted(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public void CacheBestSize(Size size)
		{
			wxWindow_CacheBestSize(wxObject, ref size);
		}
		
		//---------------------------------------------------------------------
		
		public void InvalidateBestSize()
		{
			wxWindow_InvalidateBestSize(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public Size BestFittingSize
		{
			get {
				Size size = new Size();
				wxWindow_GetBestFittingSize(wxObject, ref size);
				return size;
			}
			
			set { wxWindow_SetBestFittingSize(wxObject, ref value); }
		}
		
		//---------------------------------------------------------------------
		
		public System.Collections.ArrayList Children
		{
			get {
				int count = wxWindow_GetChildrenCount(wxObject);
				System.Collections.ArrayList al = new System.Collections.ArrayList(count);
				
				for (int num = 0; num < count; num++)
				{
					al.Add((Window)FindObject(wxWindow_GetChildren(wxObject, num)));
				}
				
				return al;
			}
		}
		
		//---------------------------------------------------------------------
		
		public AcceleratorTable AcceleratorTable
		{
			get { return (AcceleratorTable)FindObject(wxWindow_GetAcceleratorTable(wxObject), typeof(AcceleratorTable)); }
			set { wxWindow_SetAcceleratorTable(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public virtual VisualAttributes DefaultAttributes
		{
			get { return new VisualAttributes(wxWindow_GetDefaultAttributes(wxObject), true); }
		}
		
		//---------------------------------------------------------------------
		
		public static VisualAttributes ClassDefaultAttributes()
		{
			return ClassDefaultAttributes(WindowVariant.wxWINDOW_VARIANT_NORMAL);
		}
		
		public static VisualAttributes ClassDefaultAttributes(WindowVariant variant)
		{
			return new VisualAttributes(wxWindow_GetClassDefaultAttributes((int)variant), true);
		}
		
		//---------------------------------------------------------------------
		
		public virtual BackgroundStyle BackgroundStyle
		{
			get { return (BackgroundStyle)wxWindow_GetBackgroundStyle(wxObject); }
			set { wxWindow_SetBackgroundStyle(wxObject, (int)value); }
		}
		
		//---------------------------------------------------------------------
		
		public Border Border
		{
			get { return (Border)wxWindow_GetBorder(wxObject); }
		}
		
		public Border BorderByFlags(long flags)
		{
			return (Border)wxWindow_GetBorderByFlags(wxObject, (uint)flags);
		}
		
		//---------------------------------------------------------------------
		
                // TODO Not available in OS X
                /*
		public string ToolTipText
		{
			get { return new wxString(wxWindow_GetToolTipText(wxObject), true); }
		}
                */
		
		//---------------------------------------------------------------------
		
		public Window AncestorWithCustomPalette
		{
			get { return (Window)FindObject(wxWindow_GetAncestorWithCustomPalette(wxObject), typeof(Window)); }
		}
		
		//---------------------------------------------------------------------
		
		public virtual void InheritAttributes()
		{
			wxWindow_InheritAttributes(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public virtual bool ShouldInheritColours()
		{
			return wxWindow_ShouldInheritColours(wxObject);
		}
		
		//---------------------------------------------------------------------

		public event EventListener LeftUp
		{
			add { AddCommandListener(Event.wxEVT_LEFT_UP, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener RightUp
		{
			add { AddCommandListener(Event.wxEVT_RIGHT_UP, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MiddleUp
		{
			add { AddCommandListener(Event.wxEVT_MIDDLE_UP, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener LeftDown
		{
			add { AddCommandListener(Event.wxEVT_LEFT_DOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MiddleDown
		{
			add { AddCommandListener(Event.wxEVT_MIDDLE_DOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener RightDown
		{
			add { AddCommandListener(Event.wxEVT_RIGHT_DOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener LeftDoubleClick
		{
			add { AddCommandListener(Event.wxEVT_LEFT_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener RightDoubleClick
		{
			add { AddCommandListener(Event.wxEVT_RIGHT_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MiddleDoubleClick
		{
			add { AddCommandListener(Event.wxEVT_MIDDLE_DCLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MouseMove
		{
			add { AddCommandListener(Event.wxEVT_MOTION, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MouseThumbTrack
		{
			add { AddCommandListener(Event.wxEVT_SCROLL_THUMBTRACK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MouseEnter
		{
			add { AddCommandListener(Event.wxEVT_ENTER_WINDOW, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MouseLeave
		{
			add { AddCommandListener(Event.wxEVT_LEAVE_WINDOW, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ScrollLineUp
		{
			add { AddCommandListener(Event.wxEVT_SCROLL_LINEUP, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ScrollLineDown
		{
			add { AddCommandListener(Event.wxEVT_SCROLL_LINEDOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public virtual event EventListener UpdateUI
		{
			add { AddCommandListener(Event.wxEVT_UPDATE_UI, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public virtual event EventListener KeyDown
		{
			add { AddCommandListener(Event.wxEVT_KEY_DOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener KeyUp
		{
			add { AddCommandListener(Event.wxEVT_KEY_UP, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Char
		{
			add { AddCommandListener(Event.wxEVT_CHAR, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Closing
		{
			add { AddCommandListener(Event.wxEVT_CLOSE_WINDOW, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Activated
		{
			add { AddCommandListener(Event.wxEVT_ACTIVATE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Moved
		{
			add { AddCommandListener(Event.wxEVT_MOVE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener Resized
		{
			add { AddCommandListener(Event.wxEVT_SIZE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}

