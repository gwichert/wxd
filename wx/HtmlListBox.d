//-----------------------------------------------------------------------------
// wx.NET - HtmlListBox.cs
//
// The wxHtmlListBox wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;
using System.Drawing;

namespace wx
{
	public abstract class HtmlListBox : VListBox
	{
		private delegate void Virtual_VoidNoParams();
		private delegate void Virtual_VoidSizeT(int n);
		private delegate string Virtual_wxStringSizeT(int n);
		private delegate IntPtr Virtual_wxColourwxColour(IntPtr colour);
		private delegate void Virtual_OnDrawItem(IntPtr dc, IntPtr rect, int n);
		private delegate int Virtual_OnMeasureItem(int n);

		private Virtual_VoidNoParams virtual_VoidNoParams;
		private Virtual_VoidSizeT virtual_VoidSizeT;
		private Virtual_wxStringSizeT virtual_wxStringSizeT1;
		private Virtual_wxStringSizeT virtual_wxStringSizeT2;
		private Virtual_wxColourwxColour virtual_wxColourwxColour1;
		private Virtual_wxColourwxColour virtual_wxColourwxColour2;
		private Virtual_OnDrawItem virtual_OnDrawItem1;
		private Virtual_OnDrawItem virtual_OnDrawItem2;
		private Virtual_OnDrawItem virtual_OnDrawItem3;
		private Virtual_OnMeasureItem virtual_OnMeasureItem1;
		private Virtual_OnMeasureItem virtual_OnMeasureItem2;
		
		//-----------------------------------------------------------------------------
		
		[DllImport("wx-c")] static extern IntPtr wxHtmlListBox_ctor2(IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern void wxHtmlListBox_RegisterVirtual(IntPtr self,
			Virtual_VoidNoParams refreshAll,
			Virtual_VoidSizeT setItemCount,
			Virtual_wxStringSizeT onGetItem,
			Virtual_wxStringSizeT onGetItemMarkup,
			Virtual_wxColourwxColour getSelectedTextColour,
			Virtual_wxColourwxColour getSelectedTextBgColour,
			Virtual_OnDrawItem onDrawItem,
			Virtual_OnMeasureItem onMeasureItem,
			Virtual_OnDrawItem onDrawSeparator,
			Virtual_OnDrawItem onDrawBackground,
			Virtual_OnMeasureItem onGetLineHeight);
		[DllImport("wx-c")] static extern bool wxHtmlListBox_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, int style, string name);
		[DllImport("wx-c")] static extern void wxHtmlListBox_RefreshAll(IntPtr self);
		[DllImport("wx-c")] static extern void wxHtmlListBox_SetItemCount(IntPtr self, int count);
		[DllImport("wx-c")] static extern IntPtr wxHtmlListBox_OnGetItemMarkup(IntPtr self, int n);
		[DllImport("wx-c")] static extern IntPtr wxHtmlListBox_GetSelectedTextColour(IntPtr self, IntPtr colFg);
		[DllImport("wx-c")] static extern IntPtr wxHtmlListBox_GetSelectedTextBgColour(IntPtr self, IntPtr colBg);
		[DllImport("wx-c")] static extern void wxHtmlListBox_OnDrawItem(IntPtr self, IntPtr dc, ref Rectangle rect, int n);
		[DllImport("wx-c")] static extern int wxHtmlListBox_OnMeasureItem(IntPtr self, int n);
		[DllImport("wx-c")] static extern void wxHtmlListBox_OnSize(IntPtr self, IntPtr evt);
		[DllImport("wx-c")] static extern void wxHtmlListBox_Init(IntPtr self);
		[DllImport("wx-c")] static extern void wxHtmlListBox_CacheItem(IntPtr self, int n);
		
		[DllImport("wx-c")] static extern void wxHtmlListBox_OnDrawSeparator(IntPtr self, IntPtr dc, ref Rectangle rect, int n);
		[DllImport("wx-c")] static extern void wxHtmlListBox_OnDrawBackground(IntPtr self, IntPtr dc, ref Rectangle rect, int n);
		[DllImport("wx-c")] static extern int wxHtmlListBox_OnGetLineHeight(IntPtr self, int line);		
		
		//-----------------------------------------------------------------------------
		
		public HtmlListBox(IntPtr wxObject)
			: base(wxObject) { }
            
		public HtmlListBox()
			: this(null, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "") {}	
			
		/*public HtmlListBox(Window parent)
			: this(parent, -1, wxDefaultPosition, wxDefaultSize, 0, "") {}*/
			
		public HtmlListBox(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, "") {}
			
		public HtmlListBox(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, "") {}
			
		public HtmlListBox(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, "") {}
			
		public HtmlListBox(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "") {}
		
		public HtmlListBox(Window parent, int id, Point pos, Size size, long style, string name)
			: this(wxHtmlListBox_ctor2(Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name))
		{
				virtual_VoidNoParams = new Virtual_VoidNoParams(RefreshAll);
				virtual_VoidSizeT = new Virtual_VoidSizeT(SetItemCount);
				virtual_wxStringSizeT1 = new Virtual_wxStringSizeT(OnGetItem);
				virtual_wxStringSizeT2 = new Virtual_wxStringSizeT(OnGetItemMarkup);
				virtual_wxColourwxColour1 = new Virtual_wxColourwxColour(DoGetSelectedTextColour);
				virtual_wxColourwxColour2 = new Virtual_wxColourwxColour(DoGetSelectedTextBgColour);
				virtual_OnDrawItem1 = new Virtual_OnDrawItem(DoOnDrawItem);
				virtual_OnMeasureItem1 = new Virtual_OnMeasureItem(OnMeasureItem);
				virtual_OnDrawItem2 = new Virtual_OnDrawItem(DoOnDrawSeparator);
				virtual_OnDrawItem3 = new Virtual_OnDrawItem(DoOnDrawBackground);
				virtual_OnMeasureItem2 = new Virtual_OnMeasureItem(OnGetLineHeight);


			wxHtmlListBox_RegisterVirtual(wxObject, virtual_VoidNoParams,
				virtual_VoidSizeT,
				virtual_wxStringSizeT1,
				virtual_wxStringSizeT2,
				virtual_wxColourwxColour1,
				virtual_wxColourwxColour2,
				virtual_OnDrawItem1,
				virtual_OnMeasureItem1,
				virtual_OnDrawItem2,
				virtual_OnDrawItem3,
				virtual_OnMeasureItem2);   
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public HtmlListBox(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "") {}
			
		public HtmlListBox(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, "") {}
			
		public HtmlListBox(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, "") {}
			
		public HtmlListBox(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "") {}
		
		public HtmlListBox(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//-----------------------------------------------------------------------------
		
		public new bool Create(Window parent, int id, Point pos, Size size, int style, string name)
		{
			return wxHtmlListBox_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, style, name);
		}
		
		//-----------------------------------------------------------------------------
		
		public override void RefreshAll()
		{
			wxHtmlListBox_RefreshAll(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public virtual void SetItemCount(int count)
		{
			wxHtmlListBox_SetItemCount(wxObject, count);
		}
		
		//-----------------------------------------------------------------------------
		
		protected abstract string OnGetItem(int n);
		
		//-----------------------------------------------------------------------------
		
		protected virtual string OnGetItemMarkup(int n)
		{
			return new wxString(wxHtmlListBox_OnGetItemMarkup(wxObject, n), true);
		}
		
		//-----------------------------------------------------------------------------
		
		private IntPtr DoGetSelectedTextColour(IntPtr colFg)
		{
			return Object.SafePtr(GetSelectedTextColour((Colour)FindObject(colFg, typeof(Colour))));
		}
		
		protected virtual Colour GetSelectedTextColour(Colour colFg)
		{
			return new Colour(wxHtmlListBox_GetSelectedTextColour(wxObject, Object.SafePtr(colFg)), true);
		}
		
		//-----------------------------------------------------------------------------
		
		private IntPtr DoGetSelectedTextBgColour(IntPtr colBg)
		{
			return Object.SafePtr(GetSelectedTextBgColour((Colour)FindObject(colBg, typeof(Colour))));
		}
		
		protected virtual Colour GetSelectedTextBgColour(Colour colBg)
		{
			return new Colour(wxHtmlListBox_GetSelectedTextBgColour(wxObject, Object.SafePtr(colBg)), true);
		}		
		
		//-----------------------------------------------------------------------------
		
		private void DoOnDrawItem(IntPtr dc, IntPtr rect, int n)
		{
			OnDrawItem((DC)FindObject(dc, typeof(DC)), new wxRect(rect), n);
		}
		
		protected override void OnDrawItem(DC dc, Rectangle rect, int n)
		{
			wxHtmlListBox_OnDrawItem(wxObject, Object.SafePtr(dc), ref rect, n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected override int OnMeasureItem(int n)
		{
			return wxHtmlListBox_OnMeasureItem(wxObject, n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected void OnSize(SizeEvent evt)
		{
			wxHtmlListBox_OnSize(wxObject, Object.SafePtr(evt));
		}
		
		//-----------------------------------------------------------------------------
		
		protected void Init()
		{
			wxHtmlListBox_Init(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		protected void CacheItem(int n)
		{
			wxHtmlListBox_CacheItem(wxObject, n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected override void OnDrawSeparator(DC dc, Rectangle rect, int n)
		{
			wxHtmlListBox_OnDrawSeparator(wxObject, Object.SafePtr(dc), ref rect, n);
		}
		
		private void DoOnDrawSeparator(IntPtr dc, IntPtr rect, int n)
		{
			OnDrawSeparator((DC)FindObject(dc, typeof(DC)), new wxRect(rect), n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected override void OnDrawBackground(DC dc, Rectangle rect, int n)
		{
			wxHtmlListBox_OnDrawBackground(wxObject, Object.SafePtr(dc), ref rect, n);
		}
		
		private void DoOnDrawBackground(IntPtr dc, IntPtr rect, int n)
		{
			OnDrawBackground((DC)FindObject(dc, typeof(DC)), new wxRect(rect), n);
		}
		
		//-----------------------------------------------------------------------------
		
		protected override int OnGetLineHeight(int line)
		{
			return wxHtmlListBox_OnGetLineHeight(wxObject, line);
		}
		
	}
}