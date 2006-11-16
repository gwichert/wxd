//-----------------------------------------------------------------------------
// wx.NET - VLBox.cs
//
// The wxVListBox wrapper class.
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
	public abstract class VListBox : VScrolledWindow
	{
		private delegate int Virtual_IntInt(int n);
		private delegate void Virtual_VoidDcRectSizeT(IntPtr dc, IntPtr rect, int n);

		private Virtual_VoidDcRectSizeT onDrawItem;
		private Virtual_IntInt onMeasureItem;
		private Virtual_VoidDcRectSizeT onDrawSeparator;
		private Virtual_VoidDcRectSizeT onDrawBackground;
		private Virtual_IntInt onGetLineHeight;
		
		[DllImport("wx-c")] static extern IntPtr wxVListBox_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void wxVListBox_RegisterVirtual(IntPtr self, 
			Virtual_VoidDcRectSizeT onDrawItem, 
			Virtual_IntInt onMeasureItem, 
			Virtual_VoidDcRectSizeT onDrawSeparator,
			Virtual_VoidDcRectSizeT onDrawBackground,
			Virtual_IntInt onGetLineHeight);
		[DllImport("wx-c")] static extern bool wxVListBox_Create(IntPtr self,IntPtr parent, int id, ref Point pos, ref Size size, int style, string name);		
		[DllImport("wx-c")] static extern void wxVListBox_OnDrawSeparator(IntPtr self, IntPtr dc, ref Rectangle rect, int n);
		[DllImport("wx-c")] static extern void wxVListBox_OnDrawBackground(IntPtr self, IntPtr dc, ref Rectangle rect, int n);
		[DllImport("wx-c")] static extern int wxVListBox_OnGetLineHeight(IntPtr self, int line);
		[DllImport("wx-c")] static extern int wxVListBox_GetItemCount(IntPtr self);
		[DllImport("wx-c")] static extern bool wxVListBox_HasMultipleSelection(IntPtr self);
		[DllImport("wx-c")] static extern int wxVListBox_GetSelection(IntPtr self);
		[DllImport("wx-c")] static extern bool wxVListBox_IsCurrent(IntPtr self, int item);
		[DllImport("wx-c")] static extern bool wxVListBox_IsSelected(IntPtr self, int item);
		[DllImport("wx-c")] static extern int wxVListBox_GetSelectedCount(IntPtr self);
		[DllImport("wx-c")] static extern int wxVListBox_GetFirstSelected(IntPtr self, out ulong cookie);
		[DllImport("wx-c")] static extern int wxVListBox_GetNextSelected(IntPtr self, out ulong cookie);
		[DllImport("wx-c")] static extern void wxVListBox_GetMargins(IntPtr self, out Point pt);
		[DllImport("wx-c")] static extern IntPtr wxVListBox_GetSelectionBackground(IntPtr self);
		[DllImport("wx-c")] static extern void wxVListBox_SetItemCount(IntPtr self, int count);
		[DllImport("wx-c")] static extern void wxVListBox_Clear(IntPtr self);
		[DllImport("wx-c")] static extern void wxVListBox_SetSelection(IntPtr self, int selection);
		[DllImport("wx-c")] static extern bool wxVListBox_Select(IntPtr self, int item, bool select);
		[DllImport("wx-c")] static extern bool wxVListBox_SelectRange(IntPtr self, int from, int to);
		[DllImport("wx-c")] static extern void wxVListBox_Toggle(IntPtr self, int item);
		[DllImport("wx-c")] static extern bool wxVListBox_SelectAll(IntPtr self);
		[DllImport("wx-c")] static extern bool wxVListBox_DeselectAll(IntPtr self);
		[DllImport("wx-c")] static extern void wxVListBox_SetMargins(IntPtr self, ref Point pt);
		[DllImport("wx-c")] static extern void wxVListBox_SetMargins2(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern void wxVListBox_SetSelectionBackground(IntPtr self, IntPtr col);
		
		public VListBox(IntPtr wxObject)
			: base(wxObject) {}
			
		public VListBox()
			: this(null, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "") {}	
			
		public VListBox(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "") {}
			
		public VListBox(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, "") {}
			
		public VListBox(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, "") {}
			
		public VListBox(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, "") {}
			
		public VListBox(Window parent, int id, Point pos, Size size, int style)
			: this(parent, id, pos, size, style, "") {}
		
		public VListBox(Window parent, int id, Point pos, Size size, int style, string name)
			: this(wxVListBox_ctor(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name))
		{
			onDrawItem = new Virtual_VoidDcRectSizeT(DoOnDrawItem);
			onMeasureItem = new Virtual_IntInt(OnMeasureItem);
			onDrawSeparator = new Virtual_VoidDcRectSizeT(DoOnDrawSeparator);
			onDrawBackground = new Virtual_VoidDcRectSizeT(DoOnDrawBackground);
			onGetLineHeight = new Virtual_IntInt(OnGetLineHeight);

			wxVListBox_RegisterVirtual(wxObject, 
				onDrawItem,
				onMeasureItem,
				onDrawSeparator,
				onDrawBackground,
				onGetLineHeight);
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public VListBox(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, "") {}
			
		public VListBox(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, "") {}
			
		public VListBox(Window parent, Point pos, Size size, int style)
			: this(parent, Window.UniqueID, pos, size, style, "") {}
		
		public VListBox(Window parent, Point pos, Size size, int style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------
		
		public new bool Create(Window parent, int id, Point pos, Size size, int style, string name)
		{
			return wxVListBox_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, style, name); 
		}
		
		//-----------------------------------------------------------------------------
		
		protected abstract void OnDrawItem(DC dc, Rectangle rect, int n);
		
		private void DoOnDrawItem(IntPtr dc, IntPtr rect, int n)
		{
			OnDrawItem((DC)FindObject(dc, typeof(DC)), new wxRect(rect), n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected abstract int OnMeasureItem(int n);
		
		//-----------------------------------------------------------------------------
		
		protected virtual void OnDrawSeparator(DC dc, Rectangle rect, int n)
		{
			wxVListBox_OnDrawSeparator(wxObject, Object.SafePtr(dc), ref rect, n);
		}
		
		private void DoOnDrawSeparator(IntPtr dc, IntPtr rect, int n)
		{
			OnDrawSeparator((DC)FindObject(dc, typeof(DC)), new wxRect(rect), n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected virtual void OnDrawBackground(DC dc, Rectangle rect, int n)
		{
			wxVListBox_OnDrawBackground(wxObject, Object.SafePtr(dc), ref rect, n);
		}
		
		private void DoOnDrawBackground(IntPtr dc, IntPtr rect, int n)
		{
			OnDrawBackground((DC)FindObject(dc, typeof(DC)), new wxRect(rect), n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected override int OnGetLineHeight(int line)
		{
			return wxVListBox_OnGetLineHeight(wxObject, line);
		}
		
		//-----------------------------------------------------------------------------
		
		public int ItemCount
		{
			get { return wxVListBox_GetItemCount(wxObject); }
			set { wxVListBox_SetItemCount(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool HasMultipleSelection
		{
			get { return wxVListBox_HasMultipleSelection(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int Selection
		{
			get { return wxVListBox_GetSelection(wxObject); }
			set { wxVListBox_SetSelection(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public bool IsCurrent(int item)
		{
			return wxVListBox_IsCurrent(wxObject, item);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool IsSelected(int item)
		{
			return wxVListBox_IsSelected(wxObject, item);
		}
		
		//-----------------------------------------------------------------------------
		
		public int SelectedCount
		{
			get { return wxVListBox_GetSelectedCount(wxObject); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int GetFirstSelected(out ulong cookie)
		{
			return wxVListBox_GetFirstSelected(wxObject, out cookie);
		}
		
		//-----------------------------------------------------------------------------
		
		public int GetNextSelected(out ulong cookie)
		{
			return wxVListBox_GetNextSelected(wxObject, out cookie);
		}
		
		//-----------------------------------------------------------------------------
		
		public Point Margins
		{
			get { 
				Point pt = new Point();
				wxVListBox_GetMargins(wxObject, out pt);
				return pt;
			}
			
			set { wxVListBox_SetMargins(wxObject, ref value); }
		}
		
		public void SetMargins(int x, int y)
		{
			wxVListBox_SetMargins2(wxObject, x, y);
		}
		
		//-----------------------------------------------------------------------------
		
		public Colour SelectionBackground
		{
			get { return new Colour(wxVListBox_GetSelectionBackground(wxObject), true); }
			set { wxVListBox_SetSelectionBackground(wxObject, Object.SafePtr(value)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public void Clear()
		{
			wxVListBox_Clear(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Select(int item)
		{
			return Select(item, true);
		}
		
		public bool Select(int item, bool select)
		{
			return wxVListBox_Select(wxObject, item, select);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SelectRange(int from, int to)
		{
			return wxVListBox_SelectRange(wxObject, from, to);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Toggle(int item)
		{
			wxVListBox_Toggle(wxObject, item);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SelectAll()
		{
			return wxVListBox_SelectAll(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool DeselectAll()
		{
			return wxVListBox_DeselectAll(wxObject);
		}
	}
}