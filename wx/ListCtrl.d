//-----------------------------------------------------------------------------
// wx.NET - ListCtrl.cs
//
// The wxListCtrl wrapper class
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class ListItem : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxListItem_ctor();
		[DllImport("wx-c")] static extern void   wxListItem_Clear(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListItem_ClearAttributes(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListItem_GetAlign(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItem_GetBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListItem_GetColumn(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItem_GetData(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItem_GetFont(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListItem_GetId(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListItem_GetImage(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListItem_GetMask(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListItem_GetState(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItem_GetText(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItem_GetTextColour(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListItem_GetWidth(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListItem_SetAlign(IntPtr self, int align);
		[DllImport("wx-c")] static extern void   wxListItem_SetBackgroundColour(IntPtr self, IntPtr col);
		[DllImport("wx-c")] static extern void   wxListItem_SetColumn(IntPtr self, int col);
		[DllImport("wx-c")] static extern void   wxListItem_SetData(IntPtr self, IntPtr data);
		[DllImport("wx-c")] static extern void   wxListItem_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern void   wxListItem_SetId(IntPtr self, int id);
		[DllImport("wx-c")] static extern void   wxListItem_SetImage(IntPtr self, int image);
		[DllImport("wx-c")] static extern void   wxListItem_SetMask(IntPtr self, int mask);
		[DllImport("wx-c")] static extern void   wxListItem_SetState(IntPtr self, int state);
		[DllImport("wx-c")] static extern void   wxListItem_SetStateMask(IntPtr self, int stateMask);
		[DllImport("wx-c")] static extern void   wxListItem_SetText(IntPtr self, string text);
		[DllImport("wx-c")] static extern void   wxListItem_SetTextColour(IntPtr self, IntPtr col);
		[DllImport("wx-c")] static extern void   wxListItem_SetWidth(IntPtr self, int width);
		
		[DllImport("wx-c")] static extern IntPtr wxListItem_GetAttributes(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListItem_HasAttributes(IntPtr self);

		//---------------------------------------------------------------------

		public ListItem(IntPtr wxObject) 
			: base(wxObject) { }

		public ListItem() 
			: base(wxListItem_ctor()) { }

		//---------------------------------------------------------------------
        
		public void Clear()
		{
			wxListItem_Clear(wxObject);
		}
		
		//---------------------------------------------------------------------
        
		public void ClearAttributes()
		{
			wxListItem_ClearAttributes(wxObject);
		}

		//---------------------------------------------------------------------

		public int Align
		{
			get { return wxListItem_GetAlign(wxObject); }
			set { wxListItem_SetAlign(wxObject, value); }
		}
        
		//---------------------------------------------------------------------
        
		public Colour BackgroundColour
		{
			get { return new Colour(wxListItem_GetBackgroundColour(wxObject), true); }
			set {  wxListItem_SetBackgroundColour(wxObject, Object.SafePtr(value)); } 
		}

		//---------------------------------------------------------------------
        
		public int Column
		{
			get { return wxListItem_GetColumn(wxObject); }
			set { wxListItem_SetColumn(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public ClientData Data
		{
			get { return (ClientData)Object.FindObject(wxListItem_GetData(wxObject)); }
			set { wxListItem_SetData(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
        
		public Font Font
		{
			get { return new Font(wxListItem_GetFont(wxObject)); }
			set { wxListItem_SetFont(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------
        
		public int Id
		{
			get { return wxListItem_GetId(wxObject); }
			set { wxListItem_SetId(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public int Image
		{
			get { return wxListItem_GetImage(wxObject); }
			set { wxListItem_SetImage(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public int Mask
		{
			get { return wxListItem_GetMask(wxObject); }
			set { wxListItem_SetMask(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public int State
		{
			get { return wxListItem_GetState(wxObject); }
			set { wxListItem_SetState(wxObject, value); }
		}

		public int StateMask
		{
			set { wxListItem_SetStateMask(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public string Text
		{
			get { return new wxString(wxListItem_GetText(wxObject), true); }
			set { wxListItem_SetText(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public Colour TextColour
		{
			get { return new Colour(wxListItem_GetTextColour(wxObject), true); }
			set { wxListItem_SetTextColour(wxObject, Object.SafePtr(value)); } 
		}

		//---------------------------------------------------------------------
        
		public int Width
		{
			get { return wxListItem_GetWidth(wxObject); }
			set { wxListItem_SetWidth(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public ListItemAttr Attributes
		{
			get { return (ListItemAttr)FindObject(wxListItem_GetAttributes(wxObject), typeof(ListItemAttr)); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasAttributes()
		{
			return wxListItem_HasAttributes(wxObject);
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class ListItemAttr : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxListItemAttr_ctor();
		[DllImport("wx-c")] static extern IntPtr wxListItemAttr_ctor2(IntPtr colText, IntPtr colBack, IntPtr font);
		[DllImport("wx-c")] static extern void   wxListItemAttr_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListItemAttr_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxListItemAttr_SetTextColour(IntPtr self, IntPtr colText);
		[DllImport("wx-c")] static extern void   wxListItemAttr_SetBackgroundColour(IntPtr self, IntPtr colBack);
		[DllImport("wx-c")] static extern void   wxListItemAttr_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern bool   wxListItemAttr_HasTextColour(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListItemAttr_HasBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListItemAttr_HasFont(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItemAttr_GetTextColour(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItemAttr_GetBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListItemAttr_GetFont(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public ListItemAttr(IntPtr wxObject)
			: base(wxObject) 
		{ 
			this.wxObject = wxObject;
		}
			
		internal ListItemAttr(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public ListItemAttr()
			: this(wxListItemAttr_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxListItemAttr_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		public ListItemAttr(Colour colText, Colour colBack, Font font)
			: this(wxListItemAttr_ctor2(Object.SafePtr(colText), Object.SafePtr(colBack), Object.SafePtr(font)), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxListItemAttr_RegisterDisposable(wxObject, virtual_Dispose);
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
						wxListItemAttr_dtor(wxObject);
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
		
		~ListItemAttr() 
		{
			Dispose();
		}
		
		//---------------------------------------------------------------------
		
		public Colour TextColour
		{
			get { return new Colour(wxListItemAttr_GetTextColour(wxObject), true); }
			set { wxListItemAttr_SetTextColour(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Colour BackgroundColour
		{
			get { return new Colour(wxListItemAttr_GetBackgroundColour(wxObject), true); }
			set { wxListItemAttr_SetBackgroundColour(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Font Font
		{
			get { return new Font(wxListItemAttr_GetFont(wxObject), true); }
			set { wxListItemAttr_SetFont(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasTextColour
		{
			get { return wxListItemAttr_HasTextColour(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasBackgroundColour
		{
			get { return wxListItemAttr_HasBackgroundColour(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasFont
		{
			get { return wxListItemAttr_HasFont(wxObject); }
		}
	}
	
	//---------------------------------------------------------------------

	public class ListCtrl : Control
	{
		public const long wxLC_VRULES           = 0x0001;
		public const long wxLC_HRULES           = 0x0002;
	
		public const long wxLC_ICON             = 0x0004;
		public const long wxLC_SMALL_ICON       = 0x0008;
		public const long wxLC_LIST             = 0x0010;
		public const long wxLC_REPORT           = 0x0020;
	
		public const long wxLC_ALIGN_TOP        = 0x0040;
		public const long wxLC_ALIGN_LEFT       = 0x0080;
		public const long wxLC_AUTO_ARRANGE     = 0x0100;
		public const long wxLC_VIRTUAL          = 0x0200;
		public const long wxLC_EDIT_LABELS      = 0x0400;
		public const long wxLC_NO_HEADER        = 0x0800;
		public const long wxLC_NO_SORT_HEADER   = 0x1000;
		public const long wxLC_SINGLE_SEL       = 0x2000;
		public const long wxLC_SORT_ASCENDING   = 0x4000;
		public const long wxLC_SORT_DESCENDING  = 0x8000;
	
		public const long wxLC_MASK_TYPE        = (wxLC_ICON | wxLC_SMALL_ICON | wxLC_LIST | wxLC_REPORT);
		public const long wxLC_MASK_ALIGN       = (wxLC_ALIGN_TOP | wxLC_ALIGN_LEFT);
		public const long wxLC_MASK_SORT        = (wxLC_SORT_ASCENDING | wxLC_SORT_DESCENDING);
	
		public const int wxLIST_FORMAT_LEFT     = 0;
		public const int wxLIST_FORMAT_RIGHT    = 1;
		public const int wxLIST_FORMAT_CENTRE   = 2;
		public const int wxLIST_FORMAT_CENTER   = wxLIST_FORMAT_CENTRE;
	
		public const int wxLIST_MASK_STATE         = 0x0001;
		public const int wxLIST_MASK_TEXT          = 0x0002;
		public const int wxLIST_MASK_IMAGE         = 0x0004;
		public const int wxLIST_MASK_DATA          = 0x0008;
		public const int wxLIST_SET_ITEM           = 0x0010;
		public const int wxLIST_MASK_WIDTH         = 0x0020;
		public const int wxLIST_MASK_FORMAT        = 0x0040;
	
		public const int wxLIST_NEXT_ABOVE     = 1;
		public const int wxLIST_NEXT_ALL       = 2;
		public const int wxLIST_NEXT_BELOW     = 3;
		public const int wxLIST_NEXT_LEFT      = 4;
		public const int wxLIST_NEXT_RIGHT     = 5;
	
		public const int wxLIST_STATE_DONTCARE     = 0x0000;
		public const int wxLIST_STATE_DROPHILITED  = 0x0001;
		public const int wxLIST_STATE_FOCUSED      = 0x0002;
		public const int wxLIST_STATE_SELECTED     = 0x0004;
		public const int wxLIST_STATE_CUT          = 0x0008;
	
		public const int wxLIST_HITTEST_ABOVE          = 0x0001;
		public const int wxLIST_HITTEST_BELOW          = 0x0002;
		public const int wxLIST_HITTEST_NOWHERE        = 0x0004;
		public const int wxLIST_HITTEST_ONITEMICON     = 0x0020;
		public const int wxLIST_HITTEST_ONITEMLABEL    = 0x0080;
		public const int wxLIST_HITTEST_ONITEMRIGHT    = 0x0100;
		public const int wxLIST_HITTEST_ONITEMSTATEICON= 0x0200;
		public const int wxLIST_HITTEST_TOLEFT         = 0x0400;
		public const int wxLIST_HITTEST_TORIGHT        = 0x0800;
	
		public const int wxLIST_AUTOSIZE			= -1;
		public const int wxLIST_AUTOSIZE_USEHEADER	= -2;
		
		public delegate int wxListCtrlCompare(long item1, long item2, long sortData);
	
		//---------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_ctor();
		[DllImport("wx-c")] static extern void   wxListCtrl_dtor(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListCtrl_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern bool   wxListCtrl_GetColumn(IntPtr self, int col, ref IntPtr item);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetColumn(IntPtr self, int col, IntPtr item);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetColumnWidth(IntPtr self, int col);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetColumnWidth(IntPtr self, int col, int width);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetCountPerPage(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_GetItem(IntPtr self, IntPtr info, ref bool retval);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetItem(IntPtr self, IntPtr info);
		[DllImport("wx-c")] static extern int    wxListCtrl_SetItem_By_Row_Col(IntPtr self, int index, int col, string label, int imageId);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetItemState(IntPtr self, int item, int stateMask);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetItemState(IntPtr self, int item, int state, int stateMask);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetItemImage(IntPtr self, int item, int image, int selImage);
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_GetItemText(IntPtr self, int item);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetItemText(IntPtr self, int item, string str);
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_GetItemData(IntPtr self, int item);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetItemData(IntPtr self, int item, IntPtr data);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetItemData2(IntPtr self, int item, int data);
		[DllImport("wx-c")] static extern bool   wxListCtrl_GetItemRect(IntPtr self, int item, out Rectangle rect, int code);
		[DllImport("wx-c")] static extern bool   wxListCtrl_GetItemPosition(IntPtr self, int item, out Point pos);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SetItemPosition(IntPtr self, int item, ref Point pos);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetItemCount(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetColumnCount(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetItemTextColour(IntPtr self, int item, IntPtr col);
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_GetItemTextColour(IntPtr self, int item);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetItemBackgroundColour(IntPtr self, int item, IntPtr col);
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_GetItemBackgroundColour(IntPtr self, int item);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetSelectedItemCount(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_GetTextColour(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetTextColour(IntPtr self, IntPtr col);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetTopItem(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetSingleStyle(IntPtr self, uint style, bool add);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetWindowStyleFlag(IntPtr self, uint style);
		[DllImport("wx-c")] static extern int    wxListCtrl_GetNextItem(IntPtr self, int item, int geometry, int state);
		[DllImport("wx-c")] static extern IntPtr wxListCtrl_GetImageList(IntPtr self, int which);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetImageList(IntPtr self, IntPtr imageList, int which);
		[DllImport("wx-c")] static extern void   wxListCtrl_AssignImageList(IntPtr self, IntPtr imageList, int which);
		[DllImport("wx-c")] static extern bool   wxListCtrl_Arrange(IntPtr self, int flag);
		[DllImport("wx-c")] static extern void   wxListCtrl_ClearAll(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListCtrl_DeleteItem(IntPtr self, int item);
		[DllImport("wx-c")] static extern bool   wxListCtrl_DeleteAllItems(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListCtrl_DeleteAllColumns(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxListCtrl_DeleteColumn(IntPtr self, int col);
		[DllImport("wx-c")] static extern void   wxListCtrl_SetItemCount(IntPtr self, int count);
		[DllImport("wx-c")] static extern void   wxListCtrl_EditLabel(IntPtr self, int item);
		[DllImport("wx-c")] static extern bool   wxListCtrl_EnsureVisible(IntPtr self, int item);
		[DllImport("wx-c")] static extern int    wxListCtrl_FindItem(IntPtr self, int start, string str, bool partial);
		[DllImport("wx-c")] static extern int    wxListCtrl_FindItemData(IntPtr self, int start, IntPtr data);
		[DllImport("wx-c")] static extern int    wxListCtrl_FindItemPoint(IntPtr self, int start, ref Point pt, int direction);
		[DllImport("wx-c")] static extern int    wxListCtrl_HitTest(IntPtr self, ref Point point, int flags);
		[DllImport("wx-c")] static extern int    wxListCtrl_InsertItem(IntPtr self, IntPtr info);
		[DllImport("wx-c")] static extern int    wxListCtrl_InsertTextItem(IntPtr self, int index, string label);
		[DllImport("wx-c")] static extern int    wxListCtrl_InsertImageItem(IntPtr self, int index, int imageIndex);
		[DllImport("wx-c")] static extern int    wxListCtrl_InsertTextImageItem(IntPtr self, int index, string label, int imageIndex);
		[DllImport("wx-c")] static extern int    wxListCtrl_InsertColumn(IntPtr self, int col, IntPtr info);
		[DllImport("wx-c")] static extern int    wxListCtrl_InsertTextColumn(IntPtr self, int col, string heading, int format, int width);
		[DllImport("wx-c")] static extern bool   wxListCtrl_ScrollList(IntPtr self, int dx, int dy);
		[DllImport("wx-c")] static extern bool   wxListCtrl_SortItems(IntPtr self, wxListCtrlCompare fn, long data);
		
		[DllImport("wx-c")] static extern void   wxListCtrl_GetViewRect(IntPtr self, ref Rectangle rect);
		
		[DllImport("wx-c")] static extern void   wxListCtrl_RefreshItem(IntPtr self, int item);
		[DllImport("wx-c")] static extern void   wxListCtrl_RefreshItems(IntPtr self, int itemFrom, int itemTo);
	
		//---------------------------------------------------------------------
        
		public ListCtrl(IntPtr wxObject)
			: base(wxObject) { }

		public ListCtrl()
			: base(wxListCtrl_ctor()) { }

		public ListCtrl(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxLC_ICON, null, null) { }

		public ListCtrl(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxLC_ICON, null, null) { }

		public ListCtrl(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxLC_ICON, null, null) { }

		public ListCtrl(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxLC_ICON, null, null) { }

		public ListCtrl(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, null, null) { }

		public ListCtrl(Window parent, int id, Point pos, Size size, long style, Validator validator)
			: this(parent, id, pos, size, style, validator, null) { }

		public ListCtrl(Window parent, int id, Point pos, Size size, long style, Validator validator, string name)
			: base(wxListCtrl_ctor())
		{
			if (!Create(parent, id, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create ListCtrl");
			}
		}
	
		//---------------------------------------------------------------------
		// ctors with self created id
	
		public ListCtrl(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, wxLC_ICON, null, null) { }

		public ListCtrl(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxLC_ICON, null, null) { }

		public ListCtrl(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, null, null) { }

		public ListCtrl(Window parent, Point pos, Size size, long style, Validator validator)
			: this(parent, Window.UniqueID, pos, size, style, validator, null) { }

		public ListCtrl(Window parent, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, pos, size, style, validator, name) {}
	
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size, long style, Validator validator, string name)
		{
			return wxListCtrl_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, Object.SafePtr(validator), name);
		}

		//---------------------------------------------------------------------

		public bool GetColumn(int col, out ListItem item)
		{
			item = new ListItem();
			return wxListCtrl_GetColumn(wxObject, col, ref item.wxObject);
		}
		
		//---------------------------------------------------------------------

		public bool SetColumn(int col, ListItem item)
		{
			return wxListCtrl_SetColumn(wxObject, col, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public int GetColumnWidth(int col)
		{
			return wxListCtrl_GetColumnWidth(wxObject, col);
		}
		
		//---------------------------------------------------------------------

		public bool SetColumnWidth(int col, int width)
		{
			return wxListCtrl_SetColumnWidth(wxObject, col, width);
		}

		//---------------------------------------------------------------------

		public int CountPerPage
		{
			get { return wxListCtrl_GetCountPerPage(wxObject); }
		}

		//---------------------------------------------------------------------

		public bool GetItem(ref ListItem info)
		{
			bool retval = false;
			info  = (ListItem)FindObject(wxListCtrl_GetItem(wxObject, Object.SafePtr(info), ref retval), typeof(ListItem));
			return retval;
		}
		
		//---------------------------------------------------------------------

		public bool SetItem(ListItem info)
		{
			return wxListCtrl_SetItem(wxObject, Object.SafePtr(info));
		}

		public int SetItem(int index, int col, string label)
		{
			return SetItem(index, col, label, -1);
		}

		public int SetItem(int index, int col, string label, int imageId)
		{
			return wxListCtrl_SetItem_By_Row_Col(wxObject, index, col, label, imageId);
		}


		//---------------------------------------------------------------------

		public void SetItemText(int index, string label)
		{
			wxListCtrl_SetItemText(wxObject, index, label);
		}
		
		//---------------------------------------------------------------------

		public string GetItemText(int item)
		{
			return new wxString(wxListCtrl_GetItemText(wxObject, item), true);
		}

		//---------------------------------------------------------------------

		public int GetItemState(int item, int stateMask)
		{
			return wxListCtrl_GetItemState(wxObject, item , stateMask);
		}

		public bool SetItemState(int item, int state, int stateMask)
		{
			return wxListCtrl_SetItemState(wxObject, item, state, stateMask);
		}

		//---------------------------------------------------------------------

		public bool SetItemImage(int item, int image, int selImage)
		{
			return wxListCtrl_SetItemImage(wxObject, item, image, selImage);
		}

		//---------------------------------------------------------------------

		public ClientData GetItemData(int item)
		{
			return (ClientData)Object.FindObject(wxListCtrl_GetItemData(wxObject, item));
		}
		
		//---------------------------------------------------------------------

		public bool SetItemData(int item, ClientData data)
		{
			return wxListCtrl_SetItemData(wxObject, item, Object.SafePtr(data));
		}
		
		//---------------------------------------------------------------------

		public bool SetItemData(int item, int data)
		{
			return wxListCtrl_SetItemData2(wxObject, item, data);
		}

		//---------------------------------------------------------------------

		public bool GetItemRect(int item, out Rectangle rect, int code)
		{
			return wxListCtrl_GetItemRect(wxObject, item, out rect, code);
		}

		//---------------------------------------------------------------------

		public bool GetItemPosition(int item, out Point pos)
		{
			return wxListCtrl_GetItemPosition(wxObject, item, out pos);
		}
		
		//---------------------------------------------------------------------

		public bool SetItemPosition(int item, Point pos)
		{
			return wxListCtrl_SetItemPosition(wxObject, item, ref pos);
		}

		//---------------------------------------------------------------------

		public int ItemCount
		{
			get { return wxListCtrl_GetItemCount(wxObject); }
			set { wxListCtrl_SetItemCount(wxObject, value); }
		}
		
		//---------------------------------------------------------------------

		public int ColumnCount
		{
			get { return wxListCtrl_GetColumnCount(wxObject); }
		}
		
		//---------------------------------------------------------------------

		public void SetItemTextColour(int item, Colour col)
		{
			wxListCtrl_SetItemTextColour(wxObject, item, Object.SafePtr(col));
		}
		
		//---------------------------------------------------------------------

		public Colour GetItemTextColour(int item)
		{
			return new Colour(wxListCtrl_GetItemTextColour(wxObject, item), true);
		}

		//---------------------------------------------------------------------

		public void SetItemBackgroundColour(int item, Colour col)
		{
			wxListCtrl_SetItemBackgroundColour(wxObject, item, Object.SafePtr(col));
		}
		
		//---------------------------------------------------------------------

		public Colour GetItemBackgroundColour(int item)
		{
			return new Colour(wxListCtrl_GetItemBackgroundColour(wxObject, item), true);
		}

		//---------------------------------------------------------------------

		public int SelectedItemCount
		{
			get { return wxListCtrl_GetSelectedItemCount(wxObject); }
		}

		//---------------------------------------------------------------------

		public Colour TextColour
		{
			get { return new Colour(wxListCtrl_GetTextColour(wxObject), true); }
			set { wxListCtrl_SetTextColour(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public int TopItem
		{
			get { return wxListCtrl_GetTopItem(wxObject); }
		}

		//---------------------------------------------------------------------

		public void SetSingleStyle(long style, bool add)
		{
			wxListCtrl_SetSingleStyle(wxObject, (uint)style, add);
		}
		
		//---------------------------------------------------------------------

		public long WindowStyleFlag
		{
			set { wxListCtrl_SetWindowStyleFlag(wxObject, (uint)value); }
		}

		//---------------------------------------------------------------------

		public int GetNextItem(int item, int geometry, int state)
		{
			return wxListCtrl_GetNextItem(wxObject, item, geometry, state);
		}

		//---------------------------------------------------------------------

		public ImageList GetImageList(int which)
		{
			return (ImageList)FindObject(wxListCtrl_GetImageList(wxObject, which), typeof(ImageList));
		}
		
		//---------------------------------------------------------------------

		public void SetImageList(ImageList imageList, int which)
		{
			wxListCtrl_SetImageList(wxObject, Object.SafePtr(imageList), which);
		}
		
		//---------------------------------------------------------------------

		public void AssignImageList(ImageList imageList, int which)
		{
			wxListCtrl_AssignImageList(wxObject, Object.SafePtr(imageList), which);
		}

		//---------------------------------------------------------------------

		public bool Arrange(int flag)
		{
			return wxListCtrl_Arrange(wxObject, flag);
		}

		//---------------------------------------------------------------------

		public void ClearAll()
		{
			wxListCtrl_ClearAll(wxObject);
		}
		
		//---------------------------------------------------------------------

		public bool DeleteItem(int item)
		{
			return wxListCtrl_DeleteItem(wxObject, item);
		}
		
		//---------------------------------------------------------------------

		public bool DeleteAllItems()
		{
			return wxListCtrl_DeleteAllItems(wxObject);
		}
		
		//---------------------------------------------------------------------

		public bool DeleteAllColumns()
		{
			return wxListCtrl_DeleteAllColumns(wxObject);
		}
		
		//---------------------------------------------------------------------

		public bool DeleteColumn(int col)
		{
			return wxListCtrl_DeleteColumn(wxObject, col);
		}

		//---------------------------------------------------------------------

		public void EditLabel(int item)
		{
			wxListCtrl_EditLabel(wxObject, item);
		}

		//---------------------------------------------------------------------

		public bool EnsureVisible(int item)
		{
			return wxListCtrl_EnsureVisible(wxObject, item);
		}

		//---------------------------------------------------------------------

		public int FindItem(int start, string str, bool partial)
		{
			return wxListCtrl_FindItem(wxObject, start, str, partial);
		}

		// TODO: Verify data
		public int FindItem(int start, ClientData data)
		{
			return wxListCtrl_FindItemData(wxObject, start, Object.SafePtr(data));
		}

		public int FindItem(int start, Point pt, int direction)
		{
			return wxListCtrl_FindItemPoint(wxObject, start, ref pt, direction);
		}

		//---------------------------------------------------------------------

		public int HitTest(Point point, int flags)
		{
			return wxListCtrl_HitTest(wxObject, ref point, flags);
		}

		//---------------------------------------------------------------------

		public int InsertItem(ListItem info)
		{
			return wxListCtrl_InsertItem(wxObject, Object.SafePtr(info));
		}

		public int InsertItem(int index, string label)
		{
			return wxListCtrl_InsertTextItem(wxObject, index, label);
		}

		public int InsertItem(int index, int imageIndex)
		{
			return wxListCtrl_InsertImageItem(wxObject, index, imageIndex);
		}

		public int InsertItem(int index, string label, int imageIndex)
		{
			return wxListCtrl_InsertTextImageItem(wxObject, index, label, imageIndex);
		}

		//---------------------------------------------------------------------
        
		public int InsertColumn(int col, ListItem info)
		{
			return wxListCtrl_InsertColumn(wxObject, col, Object.SafePtr(info));
		}

		public int InsertColumn(int col, string heading)
		{ 
			return InsertColumn(col, heading, wxLIST_FORMAT_LEFT, -1); 
		}
			
		public int InsertColumn(int col, string heading, int format, int width)
		{
			return wxListCtrl_InsertTextColumn(wxObject, col, heading, format, width);
		}

		//---------------------------------------------------------------------

		public bool ScrollList(int dx, int dy)
		{
			return wxListCtrl_ScrollList(wxObject, dx, dy);
		}
		
		//---------------------------------------------------------------------
		
		public Rectangle ViewRect
		{
			get {
				Rectangle rect = new Rectangle();
				wxListCtrl_GetViewRect(wxObject, ref rect);
				return rect;
			}
		}
		
		//---------------------------------------------------------------------
		
		public void RefreshItem(int item)
		{
			wxListCtrl_RefreshItem(wxObject, item);
		}
		
		//---------------------------------------------------------------------
		
		public void RefreshItems(int itemFrom, int itemTo)
		{
			wxListCtrl_RefreshItems(wxObject, itemFrom, itemTo);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SortItems(wxListCtrlCompare fn, long data)
		{
			bool retval = wxListCtrl_SortItems(wxObject, fn, data);
			
			fn = null;
			
			return retval;
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener BeginDrag
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_BEGIN_DRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener BeginRightDrag
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_BEGIN_RDRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener BeginLabelEdit
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener EndLabelEdit
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_END_LABEL_EDIT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemDelete
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_DELETE_ITEM, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemDeleteAll
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------
		
		public event EventListener GetInfo
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_GET_INFO, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------
		
		public event EventListener SetInfo
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_SET_INFO, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemSelect
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_ITEM_SELECTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemDeselect
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_ITEM_DESELECTED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemActivate
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_ITEM_ACTIVATED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemFocus
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_ITEM_FOCUSED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemMiddleClick
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ItemRightClick
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public override event EventListener KeyDown
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_KEY_DOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener Insert
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_INSERT_ITEM, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ColumnClick
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_COL_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ColumnRightClick
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_COL_RIGHT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ColumnBeginDrag
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_COL_BEGIN_DRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ColumnDragging
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_COL_DRAGGING, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener ColumnEndDrag
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_COL_END_DRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
		
		//-----------------------------------------------------------------------------

		public event EventListener CacheHint
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_LIST_CACHE_HINT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
	
	//---------------------------------------------------------------------

	public class ListEvent : Event 
	{
		[DllImport("wx-c")] static extern IntPtr wxListEvent_ctor(int commandType, int id);
		[DllImport("wx-c")] static extern IntPtr wxListEvent_GetItem(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxListEvent_GetLabel(IntPtr self);
		[DllImport("wx-c")] static extern int   wxListEvent_GetIndex(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListEvent_GetKeyCode(IntPtr self);
		[DllImport("wx-c")] static extern int    wxListEvent_GetColumn(IntPtr self);
		[DllImport("wx-c")] static extern void   wxListEvent_GetPoint(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern IntPtr wxListEvent_GetText(IntPtr self);
		[DllImport("wx-c")] static extern int wxListEvent_GetImage(IntPtr self);
		[DllImport("wx-c")] static extern int wxListEvent_GetData(IntPtr self);
		[DllImport("wx-c")] static extern int wxListEvent_GetMask(IntPtr self);
		[DllImport("wx-c")] static extern int wxListEvent_GetCacheFrom(IntPtr self);
		[DllImport("wx-c")] static extern int wxListEvent_GetCacheTo(IntPtr self);
		[DllImport("wx-c")] static extern bool wxListEvent_IsEditCancelled(IntPtr self);
		[DllImport("wx-c")] static extern void wxListEvent_SetEditCanceled(IntPtr self, bool editCancelled);
		[DllImport("wx-c")] static extern void wxListEvent_Veto(IntPtr self);
		[DllImport("wx-c")] static extern void wxListEvent_Allow(IntPtr self);
		[DllImport("wx-c")] static extern bool wxListEvent_IsAllowed(IntPtr self);			
		
		//---------------------------------------------------------------------
       
		public ListEvent(IntPtr wxObject)
			: base(wxObject) { }
			
		public ListEvent(int commandType, int id)
			: base(wxListEvent_ctor(commandType, id)) { }

		//-----------------------------------------------------------------------------

		public string Label
		{
			get { return new wxString(wxListEvent_GetLabel(wxObject), true); }
		}

		//-----------------------------------------------------------------------------
       
		public int KeyCode
		{
			get { return wxListEvent_GetKeyCode(wxObject); }
		}
		
		//---------------------------------------------------------------------
	
		public int Index
		{
			get { return wxListEvent_GetIndex(wxObject); }
		}
		
		//---------------------------------------------------------------------
       
		public ListItem Item
		{
			get { return new ListItem(wxListEvent_GetItem(wxObject)); }
		}
		
		//---------------------------------------------------------------------
    
		public int Column
		{
			get { return wxListEvent_GetColumn(wxObject); }
		}
		
		//---------------------------------------------------------------------
    
		public Point Point
		{
			get { 
				Point pt = new Point();
				wxListEvent_GetPoint(wxObject, ref pt);
				return pt;
			}
		}
		
		//---------------------------------------------------------------------
    
		public string Text
		{
			get { return new wxString(wxListEvent_GetText(wxObject), true); }
		}
		
		//---------------------------------------------------------------------
	
		public int Image
		{
			get { return wxListEvent_GetImage(wxObject); }
		}
		
		//---------------------------------------------------------------------
	
		public int Data
		{
			get { return wxListEvent_GetData(wxObject); }
		}
		
		//---------------------------------------------------------------------
	
		public int Mask
		{
			get { return wxListEvent_GetMask(wxObject); }
		}
		
		//---------------------------------------------------------------------
	
		public int CacheFrom
		{
			get { return wxListEvent_GetCacheFrom(wxObject); }
		}
		
		//---------------------------------------------------------------------
	
		public int CacheTo
		{
			get { return wxListEvent_GetCacheTo(wxObject); }
		}
		
		//---------------------------------------------------------------------
	
		public bool EditCancelled
		{
			get { return wxListEvent_IsEditCancelled(wxObject); }
			set { wxListEvent_SetEditCanceled(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------		
		
		public void Veto()
		{
			wxListEvent_Veto(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Allow()
		{
			wxListEvent_Allow(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Allowed
		{
			get { return wxListEvent_IsAllowed(wxObject); }
		}								
	}

	//-----------------------------------------------------------------------------

	public class ListView : ListCtrl
	{
		[DllImport("wx-c")] static extern IntPtr wxListView_ctor();
		[DllImport("wx-c")] static extern bool wxListView_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, IntPtr validator, string name);
		[DllImport("wx-c")] static extern void wxListView_Select(IntPtr self, uint n, bool on);
		[DllImport("wx-c")] static extern void wxListView_Focus(IntPtr self, uint index);
		[DllImport("wx-c")] static extern uint wxListView_GetFocusedItem(IntPtr self);
		[DllImport("wx-c")] static extern uint wxListView_GetNextSelected(IntPtr self, uint item);
		[DllImport("wx-c")] static extern uint wxListView_GetFirstSelected(IntPtr self);
		[DllImport("wx-c")] static extern bool wxListView_IsSelected(IntPtr self, uint index);
		[DllImport("wx-c")] static extern void wxListView_SetColumnImage(IntPtr self, int col, int image);
		[DllImport("wx-c")] static extern void wxListView_ClearColumnImage(IntPtr self, int col);

		//-----------------------------------------------------------------------------

		public ListView(IntPtr wxObject)
			: base(wxObject) { }

		public ListView()
			: base(wxListView_ctor()) { }

		public ListView(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxLC_REPORT, null, null) { }

		public ListView(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxLC_REPORT, null, null) { }

		public ListView(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxLC_REPORT, null, null) { }

		public ListView(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxLC_REPORT, null, null) { }

		public ListView(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, null, null) { }

		public ListView(Window parent, int id, Point pos, Size size, long style, Validator validator)
			: this(parent, id, pos, size, style, validator, null) { }

		public ListView(Window parent, int id, Point pos, Size size, long style, Validator validator, string name)
			: base(wxListView_ctor())
		{
			if (!Create(parent, id, pos, size, style, validator, name))
			{
				throw new InvalidOperationException("Failed to create ListView");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public ListView(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, wxLC_REPORT, null, null) { }

		public ListView(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxLC_REPORT, null, null) { }

		public ListView(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, null, null) { }

		public ListView(Window parent, Point pos, Size size, long style, Validator validator)
			: this(parent, Window.UniqueID, pos, size, style, validator, null) { }

		public ListView(Window parent, Point pos, Size size, long style, Validator validator, string name)
			: this(parent, Window.UniqueID, pos, size, style, validator, name) {}

		//-----------------------------------------------------------------------------

		public new bool Create(Window parent, int id, Point pos, Size size, long style, Validator validator, string name)
		{
			return wxListView_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, Object.SafePtr(validator), name);
		}

		//-----------------------------------------------------------------------------

		public void Select(long n)
		{
			Select(n, true);
		}

		public void Select(long n, bool on)
		{
			wxListView_Select(wxObject, (uint)n, on);
		}

		//-----------------------------------------------------------------------------

		public void Focus(long index)
		{
			wxListView_Focus(wxObject, (uint)index);
		}

		//-----------------------------------------------------------------------------

		public long FocusedItem
		{
			get { return (long)wxListView_GetFocusedItem(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public long GetNextSelected(long item)
		{
			return (long)wxListView_GetNextSelected(wxObject, (uint)item);
		}

		//-----------------------------------------------------------------------------

		public long FirstSelected
		{
			get { return (long)wxListView_GetFirstSelected(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public bool IsSelected(long index)
		{
			return wxListView_IsSelected(wxObject, (uint)index);
		}

		//-----------------------------------------------------------------------------

		public void SetColumnImage(int col, int image)
		{
			wxListView_SetColumnImage(wxObject, col, image);
		}

		//-----------------------------------------------------------------------------

		public void ClearColumnImage(int col)
		{
			wxListView_ClearColumnImage(wxObject, col);
		}
	}
}
