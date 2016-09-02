//-----------------------------------------------------------------------------
// wxD - VLBox.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - VLBox.cs
//
/// The wxVListBox wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.VLBox;
public import wx.common;
public import wx.VScroll;

		//! \cond EXTERN
		extern (C) {
		alias int function(VListBox obj, int n) Virtual_IntInt;
        alias int function(VListBox obj, size_t n) Virtual_IntSizeT;
		alias void function(VListBox obj, IntPtr dc, Rectangle rect, size_t n) Virtual_VoidDcRectSizeT;
		}

		static extern (C) IntPtr wxVListBox_ctor(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		static extern (C) void wxVListBox_RegisterVirtual(IntPtr self, VListBox obj, 
			Virtual_VoidDcRectSizeT onDrawItem, 
			Virtual_IntSizeT onMeasureItem, 
			Virtual_VoidDcRectSizeT onDrawSeparator,
			Virtual_VoidDcRectSizeT onDrawBackground,
			Virtual_IntSizeT onGetLineHeight);
		static extern (C) bool wxVListBox_Create(IntPtr self,IntPtr parent, int id, ref Point pos, ref Size size, int style, string name);		
		static extern (C) void wxVListBox_OnDrawSeparator(IntPtr self, IntPtr dc, ref Rectangle rect, size_t n);
		static extern (C) void wxVListBox_OnDrawBackground(IntPtr self, IntPtr dc, ref Rectangle rect, size_t n);
		static extern (C) int wxVListBox_OnGetLineHeight(IntPtr self, size_t line);
		static extern (C) size_t wxVListBox_GetItemCount(IntPtr self);
		static extern (C) bool wxVListBox_HasMultipleSelection(IntPtr self);
		static extern (C) int wxVListBox_GetSelection(IntPtr self);
		static extern (C) bool wxVListBox_IsCurrent(IntPtr self, size_t item);
		static extern (C) bool wxVListBox_IsSelected(IntPtr self, size_t item);
		static extern (C) size_t wxVListBox_GetSelectedCount(IntPtr self);
		static extern (C) size_t wxVListBox_GetFirstSelected(IntPtr self, out uint cookie);
		static extern (C) size_t wxVListBox_GetNextSelected(IntPtr self, ref uint cookie);
		static extern (C) void wxVListBox_GetMargins(IntPtr self, out Point pt);
		static extern (C) IntPtr wxVListBox_GetSelectionBackground(IntPtr self);
		static extern (C) void wxVListBox_SetItemCount(IntPtr self, size_t count);
		static extern (C) void wxVListBox_Clear(IntPtr self);
		static extern (C) void wxVListBox_SetSelection(IntPtr self, int selection);
		static extern (C) bool wxVListBox_Select(IntPtr self, size_t item, bool select);
		static extern (C) bool wxVListBox_SelectRange(IntPtr self, size_t from, size_t to);
		static extern (C) void wxVListBox_Toggle(IntPtr self, size_t item);
		static extern (C) bool wxVListBox_SelectAll(IntPtr self);
		static extern (C) bool wxVListBox_DeselectAll(IntPtr self);
		static extern (C) void wxVListBox_SetMargins(IntPtr self, ref Point pt);
		static extern (C) void wxVListBox_SetMargins2(IntPtr self, int x, int y);
		static extern (C) void wxVListBox_SetSelectionBackground(IntPtr self, IntPtr col);
		//! \endcond
		
	public abstract class VListBox : VScrolledWindow
	{
		const static string wxVListBoxNameStr = "wxVListBox";
	
		public this(IntPtr wxobj)
			{ super(wxobj);}
			
		public this()
			{ this(null, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "");}
			
		public this(Window parent, int id /*= wxID_ANY*/, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = 0, string name = wxVListBoxNameStr)
		{
			this(wxVListBox_ctor(wxObject.SafePtr(parent), id, pos, size, style, name));
			wxVListBox_RegisterVirtual(wxobj, this,
				&staticDoOnDrawItem,
				&staticOnMeasureItem,
				&staticDoOnDrawSeparator,
				&staticDoOnDrawBackground,
				&staticOnGetLineHeight);
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = 0, string name = wxVListBoxNameStr)
			{ this(parent, Window.UniqueID, pos, size, style, name);}
		
		//-----------------------------------------------------------------------------
		
		public override bool Create(Window parent, int id, ref Point pos, ref Size size, int style, string name)
		{
			return wxVListBox_Create(wxobj, wxObject.SafePtr(parent), id, pos, size, style, name); 
		}
		
		//-----------------------------------------------------------------------------
		
		protected abstract void OnDrawItem(DC dc, Rectangle rect, size_t n);
		
		static extern(C) private void staticDoOnDrawItem(VListBox obj, IntPtr dc, Rectangle rect, size_t n)
		{
			obj.OnDrawItem(cast(DC)FindObject(dc, &DC.New), rect, n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected abstract int OnMeasureItem(size_t n);
		
		static extern(C) private int staticOnMeasureItem(VListBox obj, size_t n)
		{
			return obj.OnMeasureItem(n);
		}

		//-----------------------------------------------------------------------------
		
		protected /+virtual+/ void OnDrawSeparator(DC dc, Rectangle rect, size_t n)
		{
			wxVListBox_OnDrawSeparator(wxobj, wxObject.SafePtr(dc), rect, n);
		}
		
		static extern(C) private void staticDoOnDrawSeparator(VListBox obj, IntPtr dc, Rectangle rect, size_t n)
		{
			obj.OnDrawSeparator(cast(DC)FindObject(dc, &DC.New), rect, n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected /+virtual+/ void OnDrawBackground(DC dc, Rectangle rect, size_t n)
		{
			wxVListBox_OnDrawBackground(wxobj, wxObject.SafePtr(dc), rect, n);
		}
		
		static extern(C) private void staticDoOnDrawBackground(VListBox obj, IntPtr dc, Rectangle rect, size_t n)
		{
			obj.OnDrawBackground(cast(DC)FindObject(dc, &DC.New), rect, n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected override int OnGetLineHeight(size_t line)
		{
			return wxVListBox_OnGetLineHeight(wxobj, line);
		}
		
		static extern(C) private int staticOnGetLineHeight(VListBox obj, size_t line)
		{
			return obj.OnGetLineHeight(line);
		}

		//-----------------------------------------------------------------------------
		
		public size_t ItemCount() { return wxVListBox_GetItemCount(wxobj); }
		public void ItemCount(size_t value) { wxVListBox_SetItemCount(wxobj, value); }
		
		//-----------------------------------------------------------------------------
		
		public bool HasMultipleSelection() { return wxVListBox_HasMultipleSelection(wxobj); }
		
		//-----------------------------------------------------------------------------
		
		public int Selection() { return wxVListBox_GetSelection(wxobj); }
		public void Selection(int value) { wxVListBox_SetSelection(wxobj, value); }
		
		//-----------------------------------------------------------------------------
		
		public bool IsCurrent(size_t item)
		{
			return wxVListBox_IsCurrent(wxobj, item);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool IsSelected(size_t item)
		{
			return wxVListBox_IsSelected(wxobj, item);
		}
		
		//-----------------------------------------------------------------------------
		
		public size_t SelectedCount() { return wxVListBox_GetSelectedCount(wxobj); }
		
		//-----------------------------------------------------------------------------
		
		public size_t GetFirstSelected(out uint cookie)
		{
			return wxVListBox_GetFirstSelected(wxobj, cookie);
		}
		
		//-----------------------------------------------------------------------------
		
		public size_t GetNextSelected(ref uint cookie)
		{
			return wxVListBox_GetNextSelected(wxobj, cookie);
		}
		
		//-----------------------------------------------------------------------------
		
		public Point Margins() { 
				Point pt;
				wxVListBox_GetMargins(wxobj, pt);
				return pt;
			}
			
		public void Margins(Point value) { wxVListBox_SetMargins(wxobj, value); }
		
		public void SetMargins(int x, int y)
		{
			wxVListBox_SetMargins2(wxobj, x, y);
		}
		
		//-----------------------------------------------------------------------------
		
		public Colour SelectionBackground() { return new Colour(wxVListBox_GetSelectionBackground(wxobj), true); }
		public void SelectionBackground(Colour value) { wxVListBox_SetSelectionBackground(wxobj, wxObject.SafePtr(value)); }
		
		//-----------------------------------------------------------------------------
		
		public void Clear()
		{
			wxVListBox_Clear(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Select(size_t item)
		{
			return Select(item, true);
		}
		
		public bool Select(size_t item, bool select)
		{
			return wxVListBox_Select(wxobj, item, select);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SelectRange(size_t from, size_t to)
		{
			return wxVListBox_SelectRange(wxobj, from, to);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Toggle(size_t item)
		{
			wxVListBox_Toggle(wxobj, item);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool SelectAll()
		{
			return wxVListBox_SelectAll(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool DeselectAll()
		{
			return wxVListBox_DeselectAll(wxobj);
		}
	}
