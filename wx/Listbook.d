//-----------------------------------------------------------------------------
// wx.NET - Listbook.cs
//
// The wxListbook wrapper class.
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
	public class ListbookEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxListbookEvent_ctor(int commandType, int id, int nSel, int nOldSel);
		[DllImport("wx-c")] static extern int    wxListbookEvent_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListbookEvent_SetSelection(IntPtr self, int nSel);
		[DllImport("wx-c")] static extern int    wxListbookEvent_GetOldSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListbookEvent_SetOldSelection(IntPtr self, int nOldSel);
		[DllImport("wx-c")] static extern void wxListbookEvent_Veto(IntPtr self);
		[DllImport("wx-c")] static extern void wxListbookEvent_Allow(IntPtr self);
		[DllImport("wx-c")] static extern bool wxListbookEvent_IsAllowed(IntPtr self);		

		//-----------------------------------------------------------------------------

		public ListbookEvent(IntPtr wxObject)
			: base(wxObject) { }

		public ListbookEvent(int commandType, int id, int nSel, int nOldSel)
			: base(wxListbookEvent_ctor(commandType, id, nSel, nOldSel)) { }

		//-----------------------------------------------------------------------------

		public int Selection
		{
			get { return wxListbookEvent_GetSelection(wxObject); }
			set { wxListbookEvent_SetSelection(wxObject, value); }
		}

		//-----------------------------------------------------------------------------

		public int OldSelection
		{
			get { return wxListbookEvent_GetOldSelection(wxObject); }
			set { wxListbookEvent_SetOldSelection(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------		
		
		public void Veto()
		{
			wxListbookEvent_Veto(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Allow()
		{
			wxListbookEvent_Allow(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Allowed
		{
			get { return wxListbookEvent_IsAllowed(wxObject); }
		}		
	}
	
	//-----------------------------------------------------------------------------

	public class Listbook : Control
	{
		public const long wxLB_DEFAULT		= 0;
		public const long wxLB_TOP		= 0x1;
		public const long wxLB_BOTTOM		= 0x2;
		public const long wxLB_LEFT		= 0x4;
		public const long wxLB_RIGHT		= 0x8;
		public const long wxLB_ALIGN_MASK	= 0xf;
		
		//-----------------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxListbook_ctor();
		[DllImport("wx-c")] static extern bool wxListbook_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern int wxListbook_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern bool wxListbook_SetPageText(IntPtr self, int n, string strText);
		[DllImport("wx-c")] static extern IntPtr wxListbook_GetPageText(IntPtr self, int n);
		[DllImport("wx-c")] static extern int wxListbook_GetPageImage(IntPtr self, int n);
		[DllImport("wx-c")] static extern bool wxListbook_SetPageImage(IntPtr self, int n, int imageId);
		[DllImport("wx-c")] static extern void wxListbook_CalcSizeFromPage(IntPtr self, ref Size sizePage, out Size outSize);
		[DllImport("wx-c")] static extern bool wxListbook_InsertPage(IntPtr self, int n, IntPtr page, string text, bool bSelect, int imageId);
		[DllImport("wx-c")] static extern int wxListbook_SetSelection(IntPtr self, int n);
		[DllImport("wx-c")] static extern void wxListbook_SetImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern bool wxListbook_IsVertical(IntPtr self);
		[DllImport("wx-c")] static extern int wxListbook_GetPageCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListbook_GetPage(IntPtr self, int n);
		[DllImport("wx-c")] static extern void wxListbook_AssignImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern IntPtr wxListbook_GetImageList(IntPtr self);
		[DllImport("wx-c")] static extern void wxListbook_SetPageSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern bool wxListbook_DeletePage(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern bool wxListbook_RemovePage(IntPtr self, int nPage);
		[DllImport("wx-c")] static extern bool wxListbook_DeleteAllPages(IntPtr self);
		[DllImport("wx-c")] static extern bool wxListbook_AddPage(IntPtr self, IntPtr page, string text, bool bselect, int imageId);
		[DllImport("wx-c")] static extern void wxListbook_AdvanceSelection(IntPtr self, bool forward);
		
		//-----------------------------------------------------------------------------

		public Listbook(IntPtr wxObject) 
			: base(wxObject) { }

		public Listbook()
			: base(wxListbook_ctor()) {}

		public Listbook(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, "") {}

		public Listbook(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, "") {}

		public Listbook(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, "") {}

		public Listbook(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "") {}

		public Listbook(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxListbook_ctor())
		{
			wxListbook_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name);
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Listbook(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "") {}

		public Listbook(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, "") {}

		public Listbook(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, "") {}

		public Listbook(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "") {}

		public Listbook(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------

		public int Selection
		{
			get { return wxListbook_GetSelection(wxObject); }
			set { wxListbook_SetSelection(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------

		public bool SetPageText(int n, string strText)
		{
			return wxListbook_SetPageText(wxObject, n, strText);
		}
		
		//-----------------------------------------------------------------------------

		public string GetPageText(int n)
		{
			return new wxString(wxListbook_GetPageText(wxObject, n), true);
		}
		
		//-----------------------------------------------------------------------------

		public int GetPageImage(int n)
		{
			return wxListbook_GetPageImage(wxObject, n);
		}
		
		//-----------------------------------------------------------------------------

		public bool SetPageImage(int n, int imageId)
		{
			return wxListbook_SetPageImage(wxObject, n, imageId);
		}
		
		//-----------------------------------------------------------------------------

		public Size CalcSizeFromPage(Size sizePage)
		{
			Size s = new Size();
			wxListbook_CalcSizeFromPage(wxObject, ref sizePage, out s);
			return s;
		}
		
		//-----------------------------------------------------------------------------

		
		public bool InsertPage(int n, Window page, string text)
		{
			return InsertPage(n, page, text, false, -1);
		}
		

		public bool InsertPage(int n, Window page, string text, bool bSelect)
		{
			return InsertPage(n, page, text, bSelect, -1);
		}
		
		public bool InsertPage(int n, Window page, string text, bool bSelect, int imageId)
		{
			return wxListbook_InsertPage(wxObject, n, Object.SafePtr(page), text, bSelect, imageId);
		}
		
		//-----------------------------------------------------------------------------

		public ImageList ImageList
		{
			set { wxListbook_SetImageList(wxObject, Object.SafePtr(value)); }
			get { return (ImageList)FindObject(wxListbook_GetImageList(wxObject), typeof(ImageList)); }
		}
		
		//-----------------------------------------------------------------------------

		public bool Vertical
		{
			get { return wxListbook_IsVertical(wxObject); }
		}
		
		//-----------------------------------------------------------------------------

		public int PageCount
		{
			get { return wxListbook_GetPageCount(wxObject); }
		}
		
		//-----------------------------------------------------------------------------

		public Window GetPage(int n)
		{
			return (Window)FindObject(wxListbook_GetPage(wxObject, n), typeof(Window));
		}
		
		//-----------------------------------------------------------------------------

		public void AssignImageList(ImageList imageList)
		{
			wxListbook_AssignImageList(wxObject, Object.SafePtr(imageList));
		}
		
		//-----------------------------------------------------------------------------

		public Size PageSize
		{
			set { wxListbook_SetPageSize(wxObject, ref value); }
		}
		
		//-----------------------------------------------------------------------------

		public bool DeletePage(int nPage)
		{
			return wxListbook_DeletePage(wxObject, nPage);
		}
		
		//-----------------------------------------------------------------------------

		public bool RemovePage(int nPage)
		{
			return wxListbook_RemovePage(wxObject, nPage);
		}
		
		//-----------------------------------------------------------------------------

		public bool DeleteAllPages()
		{
			return wxListbook_DeleteAllPages(wxObject);
		}
		
		//-----------------------------------------------------------------------------

		public bool AddPage(Window page, string text, bool bSelect, int imageId)
		{
			return wxListbook_AddPage(wxObject, Object.SafePtr(page), text, bSelect, imageId);
		}
		
		//-----------------------------------------------------------------------------

		public void AdvanceSelection(bool forward)
		{
			wxListbook_AdvanceSelection(wxObject, forward);
		}

		//-----------------------------------------------------------------------------

		public event EventListener PageChange
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener PageChanging
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}
		
