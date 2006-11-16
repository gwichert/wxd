//-----------------------------------------------------------------------------
// wx.NET - TreeCtrl.cs
//
// The wxTreeCtrl wrapper class.
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
using System.Collections;

namespace wx
{
	public enum TreeItemIcon
	{
		wxTreeItemIcon_Normal,
		wxTreeItemIcon_Selected,
		wxTreeItemIcon_Expanded,
		wxTreeItemIcon_SelectedExpanded,
		wxTreeItemIcon_Max
	}
	
	//-----------------------------------------------------------------------------

	public class TreeItemData : ClientData
	{
		[DllImport("wx-c")] static extern IntPtr wxTreeItemData_ctor();
		[DllImport("wx-c")] static extern void   wxTreeItemData_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxTreeItemData_dtor(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTreeItemData_GetId(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeItemData_SetId(IntPtr self, IntPtr param);
		
		//-----------------------------------------------------------------------------

		public TreeItemData(IntPtr wxObject)
			: base(wxObject) 
		{ 
			this.wxObject = wxObject;
		}
			
		internal TreeItemData(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public TreeItemData()
			: this(wxTreeItemData_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxTreeItemData_RegisterDisposable(wxObject, virtual_Dispose);
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
						wxTreeItemData_dtor(wxObject);
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
		
		~TreeItemData() 
		{
			Dispose();
		}

		//-----------------------------------------------------------------------------

		public TreeItemId Id 
		{
			get { return new TreeItemId(wxTreeItemData_GetId(wxObject), true); }
			set { wxTreeItemData_SetId(wxObject, Object.SafePtr(value)); }
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class TreeItemAttr : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxTreeItemAttr_ctor();
		[DllImport("wx-c")] static extern IntPtr wxTreeItemAttr_ctor2(IntPtr colText, IntPtr colBack, IntPtr font);
		[DllImport("wx-c")] static extern void   wxTreeItemAttr_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeItemAttr_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxTreeItemAttr_SetTextColour(IntPtr self, IntPtr colText);
		[DllImport("wx-c")] static extern void   wxTreeItemAttr_SetBackgroundColour(IntPtr self, IntPtr colBack);
		[DllImport("wx-c")] static extern void   wxTreeItemAttr_SetFont(IntPtr self, IntPtr font);
		[DllImport("wx-c")] static extern bool   wxTreeItemAttr_HasTextColour(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTreeItemAttr_HasBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTreeItemAttr_HasFont(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTreeItemAttr_GetTextColour(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTreeItemAttr_GetBackgroundColour(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTreeItemAttr_GetFont(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public TreeItemAttr(IntPtr wxObject)
			: base(wxObject) 
		{ 
			this.wxObject = wxObject;
		}
			
		internal TreeItemAttr(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public TreeItemAttr()
			: this(wxTreeItemAttr_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxTreeItemAttr_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		public TreeItemAttr(Colour colText, Colour colBack, Font font)
			: this(wxTreeItemAttr_ctor2(Object.SafePtr(colText), Object.SafePtr(colBack), Object.SafePtr(font)), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxTreeItemAttr_RegisterDisposable(wxObject, virtual_Dispose);
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
						wxTreeItemAttr_dtor(wxObject);
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
		
		~TreeItemAttr() 
		{
			Dispose();
		}
		
		//---------------------------------------------------------------------
		
		public Colour TextColour
		{
			get { return new Colour(wxTreeItemAttr_GetTextColour(wxObject), true); }
			set { wxTreeItemAttr_SetTextColour(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Colour BackgroundColour
		{
			get { return new Colour(wxTreeItemAttr_GetBackgroundColour(wxObject), true); }
			set { wxTreeItemAttr_SetBackgroundColour(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public Font Font
		{
			get { return new Font(wxTreeItemAttr_GetFont(wxObject), true); }
			set { wxTreeItemAttr_SetFont(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasTextColour
		{
			get { return wxTreeItemAttr_HasTextColour(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasBackgroundColour
		{
			get { return wxTreeItemAttr_HasBackgroundColour(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasFont
		{
			get { return wxTreeItemAttr_HasFont(wxObject); }
		}
	}
	
	//-----------------------------------------------------------------------------

	//[StructLayout(LayoutKind.Sequential)]
	public class TreeItemId : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxTreeItemId_ctor();
		[DllImport("wx-c")] static extern IntPtr wxTreeItemId_ctor2(IntPtr pItem);
		[DllImport("wx-c")] static extern void   wxTreeItemId_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeItem_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern bool   wxTreeItemId_Equal(IntPtr item1, IntPtr item2);
		[DllImport("wx-c")] static extern bool   wxTreeItemId_IsOk(IntPtr self);
		
		//---------------------------------------------------------------------

		public TreeItemId(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
			
		internal TreeItemId(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public TreeItemId()
			: this(wxTreeItemId_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxTreeItem_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		public TreeItemId(ClientData pItem)
			: this(wxTreeItemId_ctor2(Object.SafePtr(pItem)), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxTreeItem_RegisterDisposable(wxObject, virtual_Dispose);
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
						wxTreeItemId_dtor(wxObject);
					}
				}
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			virtual_Dispose = null;
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~TreeItemId() 
		{
			Dispose();
		}
		
		//---------------------------------------------------------------------
		
		public static bool operator == (TreeItemId id1, TreeItemId id2)
		{
			if (id1 == null && id2 == null)
				return false;	
			return wxTreeItemId_Equal(Object.SafePtr(id1), Object.SafePtr(id2));
		}

		//-----------------------------------------------------------------------------

		/*internal IntPtr id;

		public TreeItemId(IntPtr id)
		{ this.id = id; }*/

		//-----------------------------------------------------------------------------

		public override bool Equals(object o)
		{
			if (o == null) return false;
			if (o == (object)this) return true;

			return this.wxObject == ((TreeItemId)o).wxObject;
		}
		
		//-----------------------------------------------------------------------------

		public override int GetHashCode()
		{
			return wxObject.GetHashCode();
		}
		
		//-----------------------------------------------------------------------------

		/*public static bool operator == (TreeItemId i1, TreeItemId i2)
		{
			// Ensure id's are not null
			object o1 = i1, o2 = i2;
			if (o1 == null && o2 == null) return true;
			if (o1 == null || o2 == null) return false;

			return i1.Equals(i2);
		}*/
		
		//-----------------------------------------------------------------------------

		public static bool operator != (TreeItemId i1, TreeItemId i2)
		{
			return !(i1 == i2);
		}
		
		//-----------------------------------------------------------------------------

		/*public bool IsValid
		{
			get { return id != IntPtr.Zero; }
		}*/
		
		//-----------------------------------------------------------------------------
		
		public bool IsOk()
		{
			return wxTreeItemId_IsOk(wxObject);
		}
	}
	
	//-----------------------------------------------------------------------------

	public class TreeCtrl : Control
	{
		public const long wxTR_NO_BUTTONS                = 0x0000;
		public const long wxTR_HAS_BUTTONS                = 0x0001;
		public const long wxTR_TWIST_BUTTONS            = 0x0010;
		public const long wxTR_NO_LINES                    = 0x0004;
		public const long wxTR_LINES_AT_ROOT             = 0x0008;
		public const long wxTR_MAC_BUTTONS                = 0; // deprecated
		public const long wxTR_AQUA_BUTTONS                = 0; // deprecated

		public const long wxTR_SINGLE                    = 0x0000;
		public const long wxTR_MULTIPLE                    = 0x0020;
		public const long wxTR_EXTENDED                    = 0x0040;
		public const long wxTR_FULL_ROW_HIGHLIGHT         = 0x2000;

		public const long wxTR_EDIT_LABELS                = 0x0200;
		public const long wxTR_ROW_LINES                = 0x0400;
		public const long wxTR_HIDE_ROOT                = 0x0800;
		public const long wxTR_HAS_VARIABLE_ROW_HEIGHT    = 0x0080;

		public static readonly long wxTR_DEFAULT_STYLE    = wxTreeCtrl_GetDefaultStyle();

		//-----------------------------------------------------------------------------

		public const int wxTREE_HITTEST_ABOVE           = 0x0001;
		public const int wxTREE_HITTEST_BELOW           = 0x0002;
		public const int wxTREE_HITTEST_NOWHERE         = 0x0004;
		public const int wxTREE_HITTEST_ONITEMBUTTON    = 0x0008;
		public const int wxTREE_HITTEST_ONITEMICON      = 0x0010;
		public const int wxTREE_HITTEST_ONITEMINDENT    = 0x0020;
		public const int wxTREE_HITTEST_ONITEMLABEL     = 0x0040;
		public const int wxTREE_HITTEST_ONITEMRIGHT     = 0x0080;
		public const int wxTREE_HITTEST_ONITEMSTATEICON = 0x0100;
		public const int wxTREE_HITTEST_TOLEFT          = 0x0200;
		public const int wxTREE_HITTEST_TORIGHT         = 0x0400;
		public const int wxTREE_HITTEST_ONITEMUPPERPART = 0x0800;
		public const int wxTREE_HITTEST_ONITEMLOWERPART = 0x1000;

		public const int wxTREE_HITTEST_ONITEM = wxTREE_HITTEST_ONITEMICON | wxTREE_HITTEST_ONITEMLABEL;
		
		//-----------------------------------------------------------------------------
		
		private delegate int Virtual_OnCompareItems(IntPtr item1, IntPtr item2);
		private Virtual_OnCompareItems virtual_OnCompareItems;
		
		//-----------------------------------------------------------------------------

		[DllImport("wx-c")] static extern uint   wxTreeCtrl_GetDefaultStyle();
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_ctor();
		[DllImport("wx-c")] static extern void   wxTreeCtrl_RegisterVirtual(IntPtr self, Virtual_OnCompareItems onCompareItems);
		[DllImport("wx-c")] static extern int    wxTreeCtrl_OnCompareItems(IntPtr self, IntPtr item1, IntPtr item2);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_AddRoot(IntPtr self, string text, int image, int selImage, IntPtr data);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_AppendItem(IntPtr self, IntPtr parent, string text, int image, int selImage, IntPtr data);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_AssignImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_AssignStateImageList(IntPtr self, IntPtr imageList);
		//[DllImport("wx-c")] static extern void   wxTreeCtrl_AssignButtonsImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern bool   wxTreeCtrl_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, IntPtr val, string name);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetImageList(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetStateImageList(IntPtr self);
		//[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetButtonsImageList(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetStateImageList(IntPtr self, IntPtr imageList);
		//[DllImport("wx-c")] static extern void   wxTreeCtrl_SetButtonsImageList(IntPtr self, IntPtr imageList);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemImage(IntPtr self, IntPtr item, int image, TreeItemIcon which);
		[DllImport("wx-c")] static extern int    wxTreeCtrl_GetItemImage(IntPtr self, IntPtr item, TreeItemIcon which);

		[DllImport("wx-c")] static extern void   wxTreeCtrl_DeleteAllItems(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_Delete(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_DeleteChildren(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern void   wxTreeCtrl_Unselect(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_UnselectAll(IntPtr self);

		[DllImport("wx-c")] static extern bool   wxTreeCtrl_IsSelected(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SelectItem(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetItemText(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemText(IntPtr self, IntPtr item, string text);

		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_HitTest(IntPtr self, ref Point pt, ref int flags);

		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemData(IntPtr self, IntPtr item, IntPtr data);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetItemData(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetRootItem(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetItemParent(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetFirstChild(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetNextChild(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetLastChild(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetNextSibling(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetPrevSibling(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetFirstVisibleItem(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetNextVisible(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetPrevVisible(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern void   wxTreeCtrl_Expand(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern void   wxTreeCtrl_Collapse(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_CollapseAndReset(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern void   wxTreeCtrl_Toggle(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern void   wxTreeCtrl_EnsureVisible(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_ScrollTo(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern int    wxTreeCtrl_GetChildrenCount(IntPtr self, IntPtr item, bool recursively);
		[DllImport("wx-c")] static extern int    wxTreeCtrl_GetCount(IntPtr self);

		[DllImport("wx-c")] static extern bool   wxTreeCtrl_IsVisible(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern bool   wxTreeCtrl_ItemHasChildren(IntPtr self, IntPtr item);

		[DllImport("wx-c")] static extern bool   wxTreeCtrl_IsExpanded(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern uint   wxTreeCtrl_GetIndent(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetIndent(IntPtr self, uint indent);
		
		[DllImport("wx-c")] static extern uint   wxTreeCtrl_GetSpacing(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetSpacing(IntPtr self, uint indent);
		
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetItemTextColour(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetItemBackgroundColour(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetItemFont(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemHasChildren(IntPtr self, IntPtr item, bool has);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemBold(IntPtr self, IntPtr item, bool bold);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemTextColour(IntPtr self, IntPtr item, IntPtr col);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemBackgroundColour(IntPtr self, IntPtr item, IntPtr col);
		
		[DllImport("wx-c")] static extern void   wxTreeCtrl_EditLabel(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern bool   wxTreeCtrl_GetBoundingRect(IntPtr self, IntPtr item, ref Rectangle rect, bool textOnly);
		
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_InsertItem(IntPtr self, IntPtr parent, IntPtr idPrevious, string text, int image, int selectedImage, IntPtr data);
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_InsertItem2(IntPtr self, IntPtr parent, int before, string text, int image, int selectedImage, IntPtr data);
		
		[DllImport("wx-c")] static extern bool   wxTreeCtrl_IsBold(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_PrependItem(IntPtr self, IntPtr parent, string text, int image, int selectedImage, IntPtr data);
		
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemSelectedImage(IntPtr self, IntPtr item, int selImage);
		
		[DllImport("wx-c")] static extern void   wxTreeCtrl_ToggleItemSelection(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern void   wxTreeCtrl_UnselectItem(IntPtr self, IntPtr item);
		
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetMyCookie(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetMyCookie(IntPtr self, IntPtr newval);
		
		[DllImport("wx-c")] static extern IntPtr wxTreeCtrl_GetSelections(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SetItemFont(IntPtr self, IntPtr item, IntPtr font);
		[DllImport("wx-c")] static extern void   wxTreeCtrl_SortChildren(IntPtr self, IntPtr item);

		//---------------------------------------------------------------------

		public TreeCtrl(IntPtr wxObject)
			: base(wxObject) { }
			
		public TreeCtrl()
			: this(wxTreeCtrl_ctor()) 
		{ 
			virtual_OnCompareItems = new Virtual_OnCompareItems(DoOnCompareItems);
			wxTreeCtrl_RegisterVirtual(wxObject, virtual_OnCompareItems);
		}

		public TreeCtrl(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxTR_HAS_BUTTONS, null, "treectrl") { }
			
		public TreeCtrl(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxTR_HAS_BUTTONS, null, "treectrl") { }
			
		public TreeCtrl(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxTR_HAS_BUTTONS, null, "treectrl") { }
			
		public TreeCtrl(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, null, "treectrl") { }
			
		public TreeCtrl(Window parent, int id, Point pos, Size size, long style, Validator val)
			: this(parent, id, pos, size, style, val, "treectrl") { }

		public TreeCtrl(Window parent, int id, Point pos, Size size, long style, Validator val, string name)
			: this()
		{
			if (!Create(parent, id, pos, size, style, val, name)) 
			{
				throw new InvalidOperationException("Could not create TreeCtrl");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public TreeCtrl(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxTR_HAS_BUTTONS, null, "treectrl") { }
			
		public TreeCtrl(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, wxTR_HAS_BUTTONS, null, "treectrl") { }
			
		public TreeCtrl(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxTR_HAS_BUTTONS, null, "treectrl") { }
			
		public TreeCtrl(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, null, "treectrl") { }
			
		public TreeCtrl(Window parent, Point pos, Size size, long style, Validator val)
			: this(parent, Window.UniqueID, pos, size, style, val, "treectrl") { }

		public TreeCtrl(Window parent, Point pos, Size size, long style, Validator val, string name)
			: this(parent, Window.UniqueID, pos, size, style, val, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size, long style, Validator val, string name)
		{
			return wxTreeCtrl_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, Object.SafePtr(val), name);
		}

		//---------------------------------------------------------------------
		
		private int DoOnCompareItems(IntPtr item1, IntPtr item2)
		{
			return OnCompareItems(new TreeItemId(item1, true), new TreeItemId(item2, true));
		}
		
		public virtual int OnCompareItems(TreeItemId item1, TreeItemId item2)
		{
			return wxTreeCtrl_OnCompareItems(wxObject, Object.SafePtr(item1), Object.SafePtr(item2));
		}
		
		//---------------------------------------------------------------------

		public TreeItemId AddRoot(string text)
		{ 
			return AddRoot(text, -1, -1, null); 
		}
		
		public TreeItemId AddRoot(string text, int image)
		{ 
			return AddRoot(text, image, -1, null); 
		}
		
		public TreeItemId AddRoot(string text, int image, int selImage)
		{ 
			return AddRoot(text, image, selImage, null); 
		}
		
		public TreeItemId AddRoot(string text, int image, int selImage, TreeItemData data)
		{
			return new TreeItemId(wxTreeCtrl_AddRoot(wxObject, text, image, selImage, Object.SafePtr(data)), true);
		}

		//---------------------------------------------------------------------

		public TreeItemId AppendItem(TreeItemId parentId, string text)
		{ 
			return AppendItem(parentId, text, -1, -1, null); 
		}
		
		public TreeItemId AppendItem(TreeItemId parentId, string text, int image)
		{ 
			return AppendItem(parentId, text, image, -1, null); 
		}
		
		public TreeItemId AppendItem(TreeItemId parentId, string text, int image, int selImage)
		{ 
			return AppendItem(parentId, text, image, selImage, null); 
		}
		
		public TreeItemId AppendItem(TreeItemId parentId, string text, int image, int selImage, TreeItemData data)
		{
			return new TreeItemId(wxTreeCtrl_AppendItem(wxObject, Object.SafePtr(parentId), text, image, selImage, Object.SafePtr(data)), true);
		}

		//---------------------------------------------------------------------

		public void AssignImageList(ImageList imageList)
		{
			wxTreeCtrl_AssignImageList(wxObject, Object.SafePtr(imageList));
		}
		
		//---------------------------------------------------------------------

		public void AssignStateImageList(ImageList imageList)
		{
			wxTreeCtrl_AssignStateImageList(wxObject, Object.SafePtr(imageList));
		}
		
		//---------------------------------------------------------------------

		/*public void AssignButtonsImageList(ImageList imageList)
		{
			wxTreeCtrl_AssignButtonsImageList(wxObject, Object.SafePtr(imageList));
		}*/

		//---------------------------------------------------------------------

		public ImageList ImageList
		{
			get { return (ImageList)FindObject(wxTreeCtrl_GetImageList(wxObject), typeof(ImageList)); }
			
			set { wxTreeCtrl_SetImageList(wxObject, Object.SafePtr(value)); }
		}

		//---------------------------------------------------------------------

		public void SetImageList(ImageList imageList)
		{
			wxTreeCtrl_SetImageList(wxObject, Object.SafePtr(imageList));
		}
		
		//---------------------------------------------------------------------
		
		public ImageList StateImageList
		{
			get { return (ImageList)FindObject(wxTreeCtrl_GetStateImageList(wxObject), typeof(ImageList)); }
			
			set { wxTreeCtrl_SetStateImageList(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		/*public ImageList ButtonsImageList
		{
			get { return (ImageList)FindObject(wxTreeCtrl_GetButtonsImageList(wxObject), typeof(ImageList)); }
			
			set { wxTreeCtrl_SetButtonsImageList(wxObject, Object.SafePtr(value)); }
		}*/

		//---------------------------------------------------------------------
		
		public void SetItemImage(TreeItemId item, int image)
		{
			SetItemImage(item, image, TreeItemIcon.wxTreeItemIcon_Normal);
		}

		public void SetItemImage(TreeItemId item, int image, TreeItemIcon which)
		{
			wxTreeCtrl_SetItemImage(wxObject, Object.SafePtr(item), image, which);
		}

		//---------------------------------------------------------------------
		
		public int GetItemImage(TreeItemId item)
		{
			return GetItemImage(item, TreeItemIcon.wxTreeItemIcon_Normal);
		}

		public int GetItemImage(TreeItemId item, TreeItemIcon which)
		{
			return wxTreeCtrl_GetItemImage(wxObject, Object.SafePtr(item), which);
		}

		//---------------------------------------------------------------------

		public void DeleteAllItems()
		{
			wxTreeCtrl_DeleteAllItems(wxObject);
		}

		public void Delete(TreeItemId item)
		{
			wxTreeCtrl_Delete(wxObject, Object.SafePtr(item));
		}

		public void DeleteChildren(TreeItemId item)
		{
			wxTreeCtrl_DeleteChildren(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public void Unselect()
		{
			wxTreeCtrl_Unselect(wxObject);
		}

		public void UnselectAll()
		{
			wxTreeCtrl_UnselectAll(wxObject);
		}

		//---------------------------------------------------------------------

		public bool IsSelected(TreeItemId item)
		{
			return wxTreeCtrl_IsSelected(wxObject, Object.SafePtr(item));
		}

		public void SelectItem(TreeItemId item)
		{
			wxTreeCtrl_SelectItem(wxObject, Object.SafePtr(item));
		}

		public TreeItemId Selection
		{
			get { return new TreeItemId(wxTreeCtrl_GetSelection(wxObject), true); }
			set { SelectItem(value); }
		}

		//---------------------------------------------------------------------

		public void SetItemText(TreeItemId item, string text)
		{
			wxTreeCtrl_SetItemText(wxObject, Object.SafePtr(item), text);
		}

		public string GetItemText(TreeItemId item)
		{
			return new wxString(wxTreeCtrl_GetItemText(wxObject, Object.SafePtr(item)), true);
		}

		//---------------------------------------------------------------------

		public void SetItemData(TreeItemId item, TreeItemData data)
		{
			wxTreeCtrl_SetItemData(wxObject, Object.SafePtr(item), Object.SafePtr(data));
		}

		public TreeItemData GetItemData(TreeItemId item)
		{
			return (TreeItemData)Object.FindObject(wxTreeCtrl_GetItemData(wxObject, Object.SafePtr(item)));
		}

		//---------------------------------------------------------------------
        
		public TreeItemId HitTest(Point pt, out int flags)
		{
			flags = new int();
			return new TreeItemId(wxTreeCtrl_HitTest(wxObject, ref pt, ref flags), true);
		}

		//---------------------------------------------------------------------

		public TreeItemId RootItem
		{
			get { return new TreeItemId(wxTreeCtrl_GetRootItem(wxObject), true); }
		}

		public TreeItemId GetItemParent(TreeItemId item)
		{
			return new TreeItemId(wxTreeCtrl_GetItemParent(wxObject, Object.SafePtr(item)), true);
		}

		//---------------------------------------------------------------------
        
		public TreeItemId GetFirstChild(TreeItemId item, ref IntPtr cookie)
		{
			TreeItemId id = new TreeItemId(wxTreeCtrl_GetFirstChild(wxObject, Object.SafePtr(item)), true);
			
			cookie = wxTreeCtrl_GetMyCookie(wxObject);
			
			return id;
		}

		public TreeItemId GetNextChild(TreeItemId item, ref IntPtr cookie)
		{
			wxTreeCtrl_SetMyCookie(wxObject, cookie);
			
			TreeItemId id = new TreeItemId(wxTreeCtrl_GetNextChild(wxObject, Object.SafePtr(item)), true);
			
			cookie =  wxTreeCtrl_GetMyCookie(wxObject);
			
			return id;
		}

		public TreeItemId GetLastChild(TreeItemId item)
		{
			return new TreeItemId(wxTreeCtrl_GetLastChild(wxObject, Object.SafePtr(item)), true);
		}

		//---------------------------------------------------------------------

		public TreeItemId GetNextSibling(TreeItemId item)
		{
			return new TreeItemId(wxTreeCtrl_GetNextSibling(wxObject, Object.SafePtr(item)), true);
		}

		public TreeItemId GetPrevSibling(TreeItemId item)
		{
			return new TreeItemId(wxTreeCtrl_GetPrevSibling(wxObject, Object.SafePtr(item)), true);
		}

		//---------------------------------------------------------------------

		public TreeItemId GetFirstVisibleItem()
		{
			return new TreeItemId(wxTreeCtrl_GetFirstVisibleItem(wxObject), true);
		}

		public TreeItemId GetNextVisible(TreeItemId item)
		{
			return new TreeItemId(wxTreeCtrl_GetNextVisible(wxObject, Object.SafePtr(item)), true);
		}

		public TreeItemId GetPrevVisible(TreeItemId item)
		{
			return new TreeItemId(wxTreeCtrl_GetPrevVisible(wxObject, Object.SafePtr(item)), true);
		}

		//---------------------------------------------------------------------

		public void Expand(TreeItemId item)
		{
			wxTreeCtrl_Expand(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public void Collapse(TreeItemId item)
		{
			wxTreeCtrl_Collapse(wxObject, Object.SafePtr(item));
		}

		public void CollapseAndReset(TreeItemId item)
		{
			wxTreeCtrl_CollapseAndReset(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public void Toggle(TreeItemId item)
		{
			wxTreeCtrl_Toggle(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public void EnsureVisible(TreeItemId item)
		{
			wxTreeCtrl_EnsureVisible(wxObject, Object.SafePtr(item));
		}

		public void ScrollTo(TreeItemId item)
		{
			wxTreeCtrl_ScrollTo(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------
		
		public int GetChildrenCount(TreeItemId item)
		{
			return GetChildrenCount(item, true);
		}

		public int GetChildrenCount(TreeItemId item, bool recursively)
		{
			return wxTreeCtrl_GetChildrenCount(wxObject, Object.SafePtr(item), recursively);
		}

		public int Count
		{
			get { return wxTreeCtrl_GetCount(wxObject); }
		}

		//---------------------------------------------------------------------

		public bool IsVisible(TreeItemId item)
		{
			return wxTreeCtrl_IsVisible(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public bool ItemHasChildren(TreeItemId item)
		{
			return wxTreeCtrl_ItemHasChildren(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public bool IsExpanded(TreeItemId item)
		{
			return wxTreeCtrl_IsExpanded(wxObject, Object.SafePtr(item));
		}

		//---------------------------------------------------------------------

		public bool HasChildren(TreeItemId item)
		{
			return GetChildrenCount(item, false) > 0;
		}

		// A brute force way to get list of selections (if wxTR_MULTIPLE has been
		// enabled) by inspecting each item. May want to replace with Interop
		// invocation of GetSelections() if it is implemented more efficiently
		// (such as the TreeCtrl has a built-in list of currect selections).
		public TreeItemId[] SelectionsOld()
		{
			return Get_Items(GetItemsMode.Selections, this.RootItem, true);
		}
		
		// This is now interop...
		public TreeItemId[] Selections()
		{
			return new ArrayTreeItemIds(wxTreeCtrl_GetSelections(wxObject), true);
		}

		// This is an addition to the standard API. Limits the selection
		// search to parent_item and below.
		public TreeItemId[] SelectionsAtOrBelow(TreeItemId parent_item)
		{
			return Get_Items(GetItemsMode.Selections, parent_item, false);
		}

		// This is an addition to the standard API. Limits the selection
		// search to those items below parent_item.
		public TreeItemId[] SelectionsBelow(TreeItemId parent_item)
		{
			return Get_Items(GetItemsMode.Selections, parent_item, true);
		}

		// This is an addition to the standard API. Returns all items
		// except for the root node.
		public TreeItemId[] AllItems()
		{
			return Get_Items(GetItemsMode.All, this.RootItem, true);
		}

		// This is an addition to the standard API. Only returns items
		// that are at or below parent_item (i.e. returns parent_item).
		public TreeItemId[] AllItemsAtOrBelow(TreeItemId parent_item)
		{
			return Get_Items(GetItemsMode.All, parent_item, false);
		}

		// This is an addition to the standard API. Only returns items
		// that are below parent_item.
		public TreeItemId[] AllItemsBelow(TreeItemId parent_item)
		{
			return Get_Items(GetItemsMode.All, parent_item, true);
		}

		private enum GetItemsMode
		{
			Selections,
			All,
		}

		private TreeItemId[] Get_Items(GetItemsMode mode, TreeItemId parent_item, 
			bool skip_parent)
		{
			// Console.WriteLine("---");
			ArrayList list = new ArrayList();
			Add_Items(mode, parent_item, list, IntPtr.Zero, skip_parent);
			TreeItemId[] array = new TreeItemId[list.Count];
			list.CopyTo(array);
			return array;
		}

		private void Add_Items(GetItemsMode mode, TreeItemId parent, 
			ArrayList list, IntPtr cookie, bool skip_parent)
		{
			TreeItemId id;

			if ( cookie == IntPtr.Zero)
			{
				if ( (! skip_parent) && 
					((mode == GetItemsMode.All) || (this.IsSelected(parent))))
				{
					// Console.WriteLine(this.GetItemText(parent));
					list.Add(parent);
				}
				id = GetFirstChild(parent, ref cookie);
			}
			else
			{
				id = GetNextChild(parent, ref cookie);
			}

			if ( ! id.IsOk() )
				return;

			if ((mode == GetItemsMode.All) || (this.IsSelected(id)))
			{
				// Console.WriteLine(this.GetItemText(id));
				list.Add(id);
			}

			if (ItemHasChildren(id))
			{
				Add_Items(mode, id, list, IntPtr.Zero, false);
			}

			Add_Items(mode, parent, list, cookie, false);
		}
		
		//---------------------------------------------------------------------
		
		public uint Indent
		{
			get { return wxTreeCtrl_GetIndent(wxObject); }
			set { wxTreeCtrl_SetIndent(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public uint Spacing
		{
			get { return wxTreeCtrl_GetSpacing(wxObject); }
			set { wxTreeCtrl_SetSpacing(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public Colour GetItemTextColour(TreeItemId item)
		{
			return new Colour(wxTreeCtrl_GetItemTextColour(wxObject, Object.SafePtr(item)), true);
		}
		
		//---------------------------------------------------------------------
		
		public Colour GetItemBackgroundColour(TreeItemId item)
		{
			return new Colour(wxTreeCtrl_GetItemBackgroundColour(wxObject, Object.SafePtr(item)), true);
		}
		
		//---------------------------------------------------------------------
		
		public Font GetItemFont(TreeItemId item)
		{
			return new Font(wxTreeCtrl_GetItemFont(wxObject, Object.SafePtr(item)), true);
		}
		
		public void SetItemFont(TreeItemId item, Font font)
		{
			wxTreeCtrl_SetItemFont(wxObject, Object.SafePtr(item), Object.SafePtr(font));
		}

		//---------------------------------------------------------------------
		
		public void SetItemHasChildren(TreeItemId item)
		{
			SetItemHasChildren(item, true);
		}
		
		public void SetItemHasChildren(TreeItemId item, bool has)
		{
			wxTreeCtrl_SetItemHasChildren(wxObject, Object.SafePtr(item), has);
		}
		
		//---------------------------------------------------------------------
		
		public void SetItemBold(TreeItemId item)
		{
			SetItemBold(item, true);
		}
		
		public void SetItemBold(TreeItemId item, bool bold)
		{
			wxTreeCtrl_SetItemBold(wxObject, Object.SafePtr(item), bold);
		}
		
		//---------------------------------------------------------------------
		
		public void SetItemTextColour(TreeItemId item, Colour col)
		{
			wxTreeCtrl_SetItemTextColour(wxObject, Object.SafePtr(item), Object.SafePtr(col));
		}
		
		//---------------------------------------------------------------------
		
		public void SetItemBackgroundColour(TreeItemId item, Colour col)
		{
			wxTreeCtrl_SetItemBackgroundColour(wxObject, Object.SafePtr(item), Object.SafePtr(col));
		}
		
		//---------------------------------------------------------------------
		
		public void EditLabel(TreeItemId item)
		{
			wxTreeCtrl_EditLabel(wxObject, Object.SafePtr(item));
		}
		
		//---------------------------------------------------------------------
		
		public bool GetBoundingRect(TreeItemId item, ref Rectangle rect)
		{
			return GetBoundingRect(item, ref rect, false);
		}
		
		public bool GetBoundingRect(TreeItemId item, ref Rectangle rect, bool textOnly)
		{
			return wxTreeCtrl_GetBoundingRect(wxObject, Object.SafePtr(item), ref rect, textOnly);
		}
		
		//---------------------------------------------------------------------
		
		public TreeItemId InsertItem(TreeItemId parent, TreeItemId previous, string text)
		{
			return InsertItem(parent, previous, text, -1, -1, null);
		}
		
		public TreeItemId InsertItem(TreeItemId parent, TreeItemId previous, string text, int image)
		{
			return InsertItem(parent, previous, text, image, -1, null);
		}
		
		public TreeItemId InsertItem(TreeItemId parent, TreeItemId previous, string text, int image, int sellimage)
		{
			return InsertItem(parent, previous, text, image, sellimage, null);
		}
		
		public TreeItemId InsertItem(TreeItemId parent, TreeItemId previous, string text, int image, int sellimage, TreeItemData data)
		{
			return new TreeItemId(wxTreeCtrl_InsertItem(wxObject, Object.SafePtr(parent), Object.SafePtr(previous), text, image, sellimage, Object.SafePtr(data)), true);
		}
		
		//---------------------------------------------------------------------
		
		public TreeItemId InsertItem(TreeItemId parent, int before, string text)
		{
			return InsertItem(parent, before, text, -1, -1, null);
		}
		
		public TreeItemId InsertItem(TreeItemId parent, int before, string text, int image)
		{
			return InsertItem(parent, before, text, image, -1, null);
		}
		
		public TreeItemId InsertItem(TreeItemId parent, int before, string text, int image, int sellimage)
		{
			return InsertItem(parent, before, text, image, sellimage, null);
		}
		
		public TreeItemId InsertItem(TreeItemId parent, int before, string text, int image, int sellimage, TreeItemData data)
		{
			return new TreeItemId(wxTreeCtrl_InsertItem2(wxObject, Object.SafePtr(parent), before, text, image, sellimage, Object.SafePtr(data)), true);
		}
		
		//---------------------------------------------------------------------
		
		public bool IsBold(TreeItemId item)
		{
			return wxTreeCtrl_IsBold(wxObject, Object.SafePtr(item));
		}
		
		//---------------------------------------------------------------------
		
		public TreeItemId PrependItem(TreeItemId parent, string text)
		{
			return PrependItem(parent, text, -1, -1, null);
		}
		
		public TreeItemId PrependItem(TreeItemId parent, string text, int image)
		{
			return PrependItem(parent, text, image, -1, null);
		}
		
		public TreeItemId PrependItem(TreeItemId parent, string text, int image, int sellimage)
		{
			return PrependItem(parent, text, image, sellimage, null);
		}
		
		public TreeItemId PrependItem(TreeItemId parent, string text, int image, int sellimage, TreeItemData data)
		{
			return new TreeItemId(wxTreeCtrl_PrependItem(wxObject, Object.SafePtr(parent), text, image, sellimage, Object.SafePtr(data)), true);
		}
		
		//---------------------------------------------------------------------
		
		public void SetItemSelectedImage(TreeItemId item, int selImage)
		{
			wxTreeCtrl_SetItemSelectedImage(wxObject, Object.SafePtr(item), selImage);
		}
		
		//---------------------------------------------------------------------
		
		public void ToggleItemSelection(TreeItemId item)
		{
			wxTreeCtrl_ToggleItemSelection(wxObject, Object.SafePtr(item));
		}
		
		//---------------------------------------------------------------------
		
		public void UnselectItem(TreeItemId item)
		{
			wxTreeCtrl_UnselectItem(wxObject, Object.SafePtr(item));
		}
		
		//---------------------------------------------------------------------
		
		public void SortChildren(TreeItemId item)
		{
			wxTreeCtrl_SortChildren(wxObject, Object.SafePtr(item));
		}
		
		//---------------------------------------------------------------------

		public event EventListener BeginDrag
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_BEGIN_DRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener BeginRightDrag
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_BEGIN_RDRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener BeginLabelEdit
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener EndLabelEdit
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_END_LABEL_EDIT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DeleteItem
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_DELETE_ITEM, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener GetInfo
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_GET_INFO, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener SetInfo
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_SET_INFO, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ItemExpand
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_ITEM_EXPANDED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ItemExpanding
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_ITEM_EXPANDING, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ItemCollapse
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_ITEM_COLLAPSED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ItemCollapsing
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_ITEM_COLLAPSING, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener SelectionChange
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_SEL_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener SelectionChanging
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_SEL_CHANGING, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public override event EventListener KeyDown
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_KEY_DOWN, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ItemActivate
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_ITEM_ACTIVATED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ItemRightClick
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener ItemMiddleClick
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener EndDrag
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_TREE_END_DRAG, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
	}
	
	//-----------------------------------------------------------------------------

	public class TreeEvent : Event
	{
		[DllImport("wx-c")] static extern IntPtr wxTreeEvent_ctor(int commandType, int id);
		[DllImport("wx-c")] static extern IntPtr wxTreeEvent_GetItem(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeEvent_SetItem(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern IntPtr wxTreeEvent_GetOldItem(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeEvent_SetOldItem(IntPtr self, IntPtr item);
		[DllImport("wx-c")] static extern void   wxTreeEvent_GetPoint(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern void   wxTreeEvent_SetPoint(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern IntPtr wxTreeEvent_GetKeyEvent(IntPtr self);
		[DllImport("wx-c")] static extern int    wxTreeEvent_GetKeyCode(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeEvent_SetKeyEvent(IntPtr self, IntPtr evt);
		[DllImport("wx-c")] static extern IntPtr wxTreeEvent_GetLabel(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeEvent_SetLabel(IntPtr self, string label);
		[DllImport("wx-c")] static extern bool   wxTreeEvent_IsEditCancelled(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeEvent_SetEditCanceled(IntPtr self, bool editCancelled);
		//[DllImport("wx-c")] static extern int    wxTreeEvent_GetCode(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeEvent_Veto(IntPtr self);
		[DllImport("wx-c")] static extern void   wxTreeEvent_Allow(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxTreeEvent_IsAllowed(IntPtr self);       
		
		[DllImport("wx-c")] static extern void   wxTreeEvent_SetToolTip(IntPtr self, string toolTip);

		//-----------------------------------------------------------------------------

		public TreeEvent(IntPtr wxObject)
			: base(wxObject) { }
		public TreeEvent(int commandType, int id)
			: base(wxTreeEvent_ctor(commandType, id)) { }

		//-----------------------------------------------------------------------------

		public TreeItemId Item
		{
			get { return new TreeItemId(wxTreeEvent_GetItem(wxObject), true); }
			set { wxTreeEvent_SetItem(wxObject, Object.SafePtr(value)); }
		}

		public TreeItemId OldItem
		{
			get { return new TreeItemId(wxTreeEvent_GetOldItem(wxObject), true); }
			set { wxTreeEvent_SetOldItem(wxObject, Object.SafePtr(value)); }
		}

		//-----------------------------------------------------------------------------

		public Point Point
		{
			get 
			{ 
				Point pt = new Point();
				wxTreeEvent_GetPoint(wxObject, ref pt);
				return pt;
			}
			set { wxTreeEvent_SetPoint(wxObject, ref value); }
		}

		//-----------------------------------------------------------------------------

		public KeyEvent KeyEvent
		{
			get { return (KeyEvent)FindObject(wxTreeEvent_GetKeyEvent(wxObject), typeof(KeyEvent)); }
			set { wxTreeEvent_SetKeyEvent(wxObject, Object.SafePtr(value)); }
		}

		//-----------------------------------------------------------------------------

		public int KeyCode
		{
			get { return wxTreeEvent_GetKeyCode(wxObject); }
		}

		//-----------------------------------------------------------------------------

		public string Label
		{
			get { return new wxString(wxTreeEvent_GetLabel(wxObject), true); }
			set { wxTreeEvent_SetLabel(wxObject, value); }
		}

		//-----------------------------------------------------------------------------

		public bool IsEditCancelled
		{
			get { return wxTreeEvent_IsEditCancelled(wxObject); } 
			set { wxTreeEvent_SetEditCanceled(wxObject, value); }
		}
		
		public string ToolTip
		{
			set { wxTreeEvent_SetToolTip(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------        
        
		public void Veto()
		{
			wxTreeEvent_Veto(wxObject);
		}
        
		//-----------------------------------------------------------------------------
        
		public void Allow()
		{
			wxTreeEvent_Allow(wxObject);
		}
        
		//-----------------------------------------------------------------------------
        
		public bool Allowed
		{
			get { return  wxTreeEvent_IsAllowed(wxObject); }
		}
	}
	
	//---------------------------------------------------------------------

	public class ArrayTreeItemIds : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxArrayTreeItemIds_ctor();
		[DllImport("wx-c")] static extern void   wxArrayTreeItemIds_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void   wxArrayTreeItemIds_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		[DllImport("wx-c")] static extern void   wxArrayTreeItemIds_Add(IntPtr self, IntPtr toadd);
		[DllImport("wx-c")] static extern IntPtr wxArrayTreeItemIds_Item(IntPtr self, int num);
		[DllImport("wx-c")] static extern int    wxArrayTreeItemIds_GetCount(IntPtr self);
		
		//---------------------------------------------------------------------

		public ArrayTreeItemIds(IntPtr wxObject)
			: base(wxObject)
		{
			this.wxObject = wxObject;
		}
			
		internal ArrayTreeItemIds(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		public ArrayTreeItemIds()
			: this(wxArrayTreeItemIds_ctor(), true) 
		{
			virtual_Dispose = new Virtual_Dispose(VirtualDispose);
			wxArrayTreeItemIds_RegisterDisposable(wxObject, virtual_Dispose);
		}
		
		//---------------------------------------------------------------------

		public static implicit operator TreeItemId[] (ArrayTreeItemIds ars)
		{
			TreeItemId[] tmps = new TreeItemId[ars.Count];
			for (int i = 0; i < ars.Count; i++)
				tmps[i] = ars.Item(i);
			return tmps;
		}
	
		public TreeItemId Item(int num)
		{
			return new TreeItemId(wxArrayTreeItemIds_Item(wxObject, num), true);
		}	
	
		public void Add(TreeItemId toadd)
		{
			wxArrayTreeItemIds_Add(wxObject, Object.SafePtr(toadd));
		}

		public int Count
		{
			get { return wxArrayTreeItemIds_GetCount(wxObject); }
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
						wxArrayTreeItemIds_dtor(wxObject);
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
		
		~ArrayTreeItemIds() 
		{
			Dispose();
		}
	}
}
