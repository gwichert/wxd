//-----------------------------------------------------------------------------
// wx.NET - TabCtrl.cs
//
// The wxTabCtrl wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#if ! __WXMSW__
#warning TabCtrl not supported by wxGTK and Mac, Win only 
#else

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class TabEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxTabEvent_ctor(int commandType, int id, int nSel, int nOldSel);
		[DllImport("wx-c")] static extern int    wxTabEvent_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTabEvent_SetSelection(IntPtr self, int nSel);
		[DllImport("wx-c")] static extern int    wxTabEvent_GetOldSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTabEvent_SetOldSelection(IntPtr self, int nOldSel);
		[DllImport("wx-c")] static extern void wxTabEvent_Veto(IntPtr self);
		[DllImport("wx-c")] static extern void wxTabEvent_Allow(IntPtr self);
		[DllImport("wx-c")] static extern bool wxTabEvent_IsAllowed(IntPtr self);		

		//-----------------------------------------------------------------------------

		public TabEvent(IntPtr wxObject)
			: base(wxObject) { }

		public TabEvent(int commandType, int id, int nSel, int nOldSel)
			: base(wxTabEvent_ctor(commandType, id, nSel, nOldSel)) { }

		//-----------------------------------------------------------------------------

		public int Selection
		{
			get { return wxTabEvent_GetSelection(wxObject); }
			set { wxTabEvent_SetSelection(wxObject, value); }
		}

		//-----------------------------------------------------------------------------

		public int OldSelection
		{
			get { return wxTabEvent_GetOldSelection(wxObject); }
			set { wxTabEvent_SetOldSelection(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------		
		
		public void Veto()
		{
			wxTabEvent_Veto(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Allow()
		{
			wxTabEvent_Allow(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Allowed
		{
			get { return wxTabEvent_IsAllowed(wxObject); }
		}		
	}

	//-----------------------------------------------------------------------------

	public class TabCtrl : Control
	{
		[DllImport("wx-c")] static extern IntPtr wxTabCtrl_ctor();
		[DllImport("wx-c")] static extern IntPtr wxTabCtrl_ctor2(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern int wxTabCtrl_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern int wxTabCtrl_GetCurFocus(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTabCtrl_GetImageList(IntPtr self);
		[DllImport("wx-c")] static extern int wxTabCtrl_GetItemCount(IntPtr self);
		[DllImport("wx-c")] static extern bool wxTabCtrl_GetItemRect(IntPtr self, int item, out Rectangle rect);
		[DllImport("wx-c")] static extern int wxTabCtrl_GetRowCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTabCtrl_GetItemText(IntPtr self, int item);
		[DllImport("wx-c")] static extern int wxTabCtrl_GetItemImage(IntPtr self, int item);
		[DllImport("wx-c")] static extern IntPtr wxTabCtrl_GetItemData(IntPtr self, int item);
		[DllImport("wx-c")] static extern int wxTabCtrl_SetSelection(IntPtr self, int item);
		[DllImport("wx-c")] static extern void wxTabCtrl_SetImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern bool wxTabCtrl_SetItemText(IntPtr self, int item, string text);
		[DllImport("wx-c")] static extern bool wxTabCtrl_SetItemImage(IntPtr self, int item, int image);
		[DllImport("wx-c")] static extern bool wxTabCtrl_SetItemData(IntPtr self, int item, IntPtr data);
		[DllImport("wx-c")] static extern void wxTabCtrl_SetItemSize(IntPtr self, ref Size size);
		[DllImport("wx-c")] static extern bool wxTabCtrl_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void wxTabCtrl_SetPadding(IntPtr self, ref Size padding);
		[DllImport("wx-c")] static extern bool wxTabCtrl_DeleteAllItems(IntPtr self);
		[DllImport("wx-c")] static extern bool wxTabCtrl_DeleteItem(IntPtr self, int item);
		[DllImport("wx-c")] static extern int wxTabCtrl_HitTest(IntPtr self, ref Point pt, out long flags);
		[DllImport("wx-c")] static extern bool wxTabCtrl_InsertItem(IntPtr self, int item, string text, int imageId, IntPtr data);

		//-----------------------------------------------------------------------------

		public TabCtrl(IntPtr wxObject) 
			: base(wxObject) { }

		public TabCtrl()
			: base(wxTabCtrl_ctor()) {}

		public TabCtrl(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, "tabCtrl") {}

		public TabCtrl(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, "tabCtrl") {}

		public TabCtrl(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, "tabCtrl") {}

		public TabCtrl(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "tabCtrl") {}

		public TabCtrl(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxTabCtrl_ctor2(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name)) {}
			
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public TabCtrl(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "tabCtrl") {}

		public TabCtrl(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, "tabCtrl") {}

		public TabCtrl(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, "tabCtrl") {}

		public TabCtrl(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "tabCtrl") {}

		public TabCtrl(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}

		//-----------------------------------------------------------------------------

		public bool Create(Window parent, int id)
		{
			return Create(parent, id, wxDefaultPosition, wxDefaultSize, 0, "tabCtrl");
		}

		public bool Create(Window parent, int id, Point pos)
		{
			return Create(parent, id, pos, wxDefaultSize, 0, "tabCtrl");
		}

		public bool Create(Window parent, int id, Point pos, Size size)
		{
			return Create(parent, id, pos, size, 0, "tabCtrl");
		}

		public bool Create(Window parent, int id, Point pos, Size size, long style)
		{
			return Create(parent, id, pos, size, style, "tabCtrl");
		}

		public bool Create(Window parent, int id, Point pos, Size size, long style, string name)
		{
			return wxTabCtrl_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name);
		}
		
		//-----------------------------------------------------------------------------

		public int Selection
		{
			get { return wxTabCtrl_GetSelection(wxObject); }
			set { wxTabCtrl_SetSelection(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------

		public int CurFocus
		{
			get { return wxTabCtrl_GetCurFocus(wxObject); }
		}
		
		//-----------------------------------------------------------------------------

		public ImageList ImageList
		{
			get { return (ImageList)FindObject(wxTabCtrl_GetImageList(wxObject), typeof(ImageList)); }
			set { wxTabCtrl_SetImageList(wxObject, Object.SafePtr(value)); }
		}
		
		//-----------------------------------------------------------------------------

		public int ItemCount
		{
			get { return wxTabCtrl_GetItemCount(wxObject); }
		}
		
		//-----------------------------------------------------------------------------

		public bool GetItemRect(int item, out Rectangle rect)
		{
			return wxTabCtrl_GetItemRect(wxObject, item, out rect);
		}
		
		//-----------------------------------------------------------------------------

		public int RowCount
		{
			get { return wxTabCtrl_GetRowCount(wxObject); }
		}
		
		//-----------------------------------------------------------------------------

		public string GetItemText(int item)
		{
			return new wxString(wxTabCtrl_GetItemText(wxObject, item), true);
		}
		
		//-----------------------------------------------------------------------------

		public int GetItemImage(int item)
		{
			return wxTabCtrl_GetItemImage(wxObject, item);
		}
		
		//-----------------------------------------------------------------------------

		public IntPtr GetItemData(int item)
		{
			return wxTabCtrl_GetItemData(wxObject, item);
		}
		
		//-----------------------------------------------------------------------------

		public bool SetItemText(int item, string text)
		{
			return wxTabCtrl_SetItemText(wxObject, item, text);
		}
		
		//-----------------------------------------------------------------------------

		public bool SetItemImage(int item, int image)
		{
			return wxTabCtrl_SetItemImage(wxObject, item, image);
		}
		
		//-----------------------------------------------------------------------------

		public bool SetItemData(int item, IntPtr data)
		{
			return wxTabCtrl_SetItemData(wxObject, item, data);
		}
		
		//-----------------------------------------------------------------------------

		public Size ItemSize
		{
			set { wxTabCtrl_SetItemSize(wxObject, ref value); }
		}
		
		//-----------------------------------------------------------------------------

		public Size Padding
		{
			set { wxTabCtrl_SetPadding(wxObject, ref value); }
		}
		
		//-----------------------------------------------------------------------------

		public bool DeleteAllItems()
		{
			return wxTabCtrl_DeleteAllItems(wxObject);
		}
		
		//-----------------------------------------------------------------------------

		public bool DeleteItem(int item)
		{
			return wxTabCtrl_DeleteItem(wxObject, item);
		}
		
		//-----------------------------------------------------------------------------

		public int HitTest(Point pt, out long flags)
		{
			return wxTabCtrl_HitTest(wxObject, ref pt, out flags);
		}
		
		//-----------------------------------------------------------------------------

		public bool InsertItem(int item, string text)
		{
			return InsertItem(item, text, -1, IntPtr.Zero);
		}
		
		public bool InsertItem(int item, string text, int imageId)
		{
			return InsertItem(item, text, imageId, IntPtr.Zero);
		}
		
		public bool InsertItem(int item, string text, int imageId, IntPtr data)
		{
			return wxTabCtrl_InsertItem(wxObject, item, text, imageId, data);
		}

		//---------------------------------------------------------------------

		public event EventListener SelectionChange
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TAB_SEL_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener SelectionChanging
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TAB_SEL_CHANGING, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
}

#endif
