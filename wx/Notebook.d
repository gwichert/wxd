//-----------------------------------------------------------------------------
// wx.NET - Notebook.cs
//
// The wxNotebook wrapper class.
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
	public class NotebookEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxNotebookEvent_ctor(int commandType, int id, int nSel, int nOldSel);
		[DllImport("wx-c")] static extern int    wxNotebookEvent_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxNotebookEvent_SetSelection(IntPtr self, int nSel);
		[DllImport("wx-c")] static extern int    wxNotebookEvent_GetOldSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxNotebookEvent_SetOldSelection(IntPtr self, int nOldSel);
		[DllImport("wx-c")] static extern void wxNotebookEvent_Veto(IntPtr self);
		[DllImport("wx-c")] static extern void wxNotebookEvent_Allow(IntPtr self);
		[DllImport("wx-c")] static extern bool wxNotebookEvent_IsAllowed(IntPtr self);		

		//-----------------------------------------------------------------------------

		public NotebookEvent(IntPtr wxObject)
			: base(wxObject) { }

		public NotebookEvent(int commandType, int id, int nSel, int nOldSel)
			: base(wxNotebookEvent_ctor(commandType, id, nSel, nOldSel)) { }

		//-----------------------------------------------------------------------------

		public int Selection
		{
			get { return wxNotebookEvent_GetSelection(wxObject); }
			set { wxNotebookEvent_SetSelection(wxObject, value); }
		}

		//-----------------------------------------------------------------------------

		public int OldSelection
		{
			get { return wxNotebookEvent_GetOldSelection(wxObject); }
			set { wxNotebookEvent_SetOldSelection(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------		
		
		public void Veto()
		{
			wxNotebookEvent_Veto(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Allow()
		{
			wxNotebookEvent_Allow(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Allowed
		{
			get { return wxNotebookEvent_IsAllowed(wxObject); }
		}		
	}

	public class Notebook : Control
	{
		public const long wxNB_FIXEDWIDTH       = 0x0010;
		public const long wxNB_TOP              = 0x0000;
		public const long wxNB_LEFT             = 0x0020;
		public const long wxNB_RIGHT            = 0x0040;
		public const long wxNB_BOTTOM           = 0x0080;
		public const long wxNB_MULTILINE        = 0x0100;
	
		//-----------------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxNotebook_ctor();
		[DllImport("wx-c")] static extern bool   wxNotebook_AddPage(IntPtr self, IntPtr page, string text, bool select, int imageId);
		[DllImport("wx-c")] static extern bool   wxNotebook_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern int    wxNotebook_GetPageCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxNotebook_GetPage(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern int    wxNotebook_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxNotebook_SetPageText(IntPtr self, int nPage, string strText);
		[DllImport("wx-c")] static extern IntPtr wxNotebook_GetPageText(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern void   wxNotebook_SetImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern void   wxNotebook_AssignImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern IntPtr wxNotebook_GetImageList(IntPtr self);
		[DllImport("wx-c")] static extern int    wxNotebook_GetPageImage(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern bool   wxNotebook_SetPageImage(IntPtr self, int nPage, int nImage);
		[DllImport("wx-c")] static extern int    wxNotebook_GetRowCount(IntPtr self);
		[DllImport("wx-c")] static extern void   wxNotebook_SetPageSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern void   wxNotebook_SetPadding(IntPtr self, ref Size padding);
		[DllImport("wx-c")] static extern void   wxNotebook_SetTabSize(IntPtr self, ref Size sz);
		[DllImport("wx-c")] static extern bool   wxNotebook_DeletePage(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern bool   wxNotebook_RemovePage(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern bool   wxNotebook_DeleteAllPages(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxNotebook_InsertPage(IntPtr self, int nPage, IntPtr pPage, string strText, bool bSelect, int imageId);
		[DllImport("wx-c")] static extern int    wxNotebook_SetSelection(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern void   wxNotebook_AdvanceSelection(IntPtr self, bool forward);

		//---------------------------------------------------------------------
		
		public Notebook(IntPtr wxObject) 
			: base(wxObject) { }

		public Notebook()
			: base(wxNotebook_ctor()) { }

		public Notebook(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public Notebook(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, null) { }

		public Notebook(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, null) { }

		public Notebook(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, null) { }

		public Notebook(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxNotebook_ctor())
		{
			if (!wxNotebook_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name)) 
			{
				throw new InvalidOperationException("Failed to create Notebook");
			}
		}

		//---------------------------------------------------------------------
		// ctors with self created id
			
		public Notebook(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, null) { }

		public Notebook(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, null) { }

		public Notebook(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
        
		//---------------------------------------------------------------------

		// TODO: Switch window with NotebookPage

		public bool AddPage(Window page, string text)
		{ return AddPage(page, text, false, -1); }
		
		public bool AddPage(Window page, string text, bool select)
		{ return AddPage(page, text, select, -1); }
		
		public bool AddPage(Window page, string text, bool select, int imageId)
		{
			return wxNotebook_AddPage(wxObject, Object.SafePtr(page), text, select, imageId);
		}

		//---------------------------------------------------------------------

		public ImageList Images
		{
			set { wxNotebook_SetImageList(wxObject, Object.SafePtr(value)); }
			get { return (ImageList)FindObject(wxNotebook_GetImageList(wxObject)); }
		}

		//---------------------------------------------------------------------

		public int PageCount
		{
			get { return wxNotebook_GetPageCount(wxObject); }
		}

		// TODO: Switch window with NotebookPage
		public Window GetPage(int page)
		{
			return (Window)FindObject(wxNotebook_GetPage(wxObject, page));
		}

		//---------------------------------------------------------------------

		public int Selection
		{
			get { return wxNotebook_GetSelection(wxObject); }
			set { wxNotebook_SetSelection(wxObject, value); }
		}

		public void AdvanceSelection(bool forward)
		{
			wxNotebook_AdvanceSelection(wxObject, forward);
		}

		//---------------------------------------------------------------------

		public bool SetPageText(int page, string text)
		{
			return wxNotebook_SetPageText(wxObject, page, text);
		}

		public string GetPageText(int page)
		{
			return new wxString(wxNotebook_GetPageText(wxObject, page), true);
		}

		//---------------------------------------------------------------------

		public void AssignImageList(ImageList imageList)
		{
			wxNotebook_AssignImageList(wxObject, Object.SafePtr(imageList));
		}

		//---------------------------------------------------------------------

		public int GetPageImage(int page)
		{
			return wxNotebook_GetPageImage(wxObject, page);
		}

		public bool SetPageImage(int page, int image)
		{
			return wxNotebook_SetPageImage(wxObject, page, image);
		}

		//---------------------------------------------------------------------

		public int RowCount
		{
			get { return wxNotebook_GetRowCount(wxObject); }
		}

		//---------------------------------------------------------------------

		public Size PageSize
		{
			set { wxNotebook_SetPageSize(wxObject, ref value); }
		}

		public Size Padding
		{
			set { wxNotebook_SetPadding(wxObject, ref value); }
		}

		public Size TabSize
		{
			set { wxNotebook_SetTabSize(wxObject, ref value); }
		}

		//---------------------------------------------------------------------

		public bool DeletePage(int page)
		{
			return wxNotebook_DeletePage(wxObject, page);
		}

		public bool RemovePage(int page)
		{
			return wxNotebook_RemovePage(wxObject, page);
		}

		public bool DeleteAllPages()
		{
			return wxNotebook_DeleteAllPages(wxObject);
		}

		//---------------------------------------------------------------------

		// TODO: Switch window with NotebookPage
		public bool InsertPage(int page, Window window, string text,
							   bool select, int image)
		{
			return wxNotebook_InsertPage(wxObject, page,
										 Object.SafePtr(window), text, select,
										 image);
		}

		//---------------------------------------------------------------------

		public event EventListener PageChange
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener PageChanging
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}
