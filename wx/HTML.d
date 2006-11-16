//-----------------------------------------------------------------------------
// wx.NET - HTML.cs
// 
// The wxHTML wrapper classes.
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
	public enum HtmlURLType
	{
		wxHTML_URL_PAGE,
		wxHTML_URL_IMAGE,
		wxHTML_URL_OTHER
	}
	
	//-----------------------------------------------------------------------------
	
	public enum HtmlOpeningStatus
	{
		wxHTML_OPEN,
		wxHTML_BLOCK,
		wxHTML_REDIRECT
	}
	
	//-----------------------------------------------------------------------------

	public class HtmlWindow : ScrolledWindow
	{
		public const long wxHW_SCROLLBAR_NEVER   = 0x0002;
		public const long wxHW_SCROLLBAR_AUTO    = 0x0004;
		public const long wxHW_NO_SELECTION      = 0x0008;

		//-----------------------------------------------------------------------------

		private delegate void Virtual_OnLinkClicked(IntPtr link);
		private delegate void Virtual_OnSetTitle(IntPtr title);
		private delegate void Virtual_OnCellMouseHover(IntPtr cell, int x, int y);
		private delegate void Virtual_OnCellClicked(IntPtr cell, int x, int y, IntPtr mouseevent);
		private delegate int Virtual_OnOpeningURL(int type, IntPtr url, IntPtr redirect);

		private Virtual_OnLinkClicked virtual_OnLinkClicked;
		private Virtual_OnSetTitle virtual_OnSetTitle;
		private Virtual_OnCellMouseHover virtual_OnCellMouseHover;
		private Virtual_OnCellClicked virtual_OnCellClicked;
		private Virtual_OnOpeningURL virtual_OnOpeningUrl;
		
		//-----------------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_ctor();
		[DllImport("wx-c")] static extern void   wxHtmlWindow_RegisterVirtual(IntPtr self, 
			Virtual_OnLinkClicked onLinkClicked,
			Virtual_OnSetTitle onSetTitle,
			Virtual_OnCellMouseHover onCellMouseHover,
			Virtual_OnCellClicked onCellClicked,
			Virtual_OnOpeningURL onOpeningURL);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_SetPage(IntPtr self, string source);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_AppendToPage(IntPtr self, string source);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_LoadPage(IntPtr self, string location);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_LoadFile(IntPtr self, string filename);
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_GetOpenedPage(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_GetOpenedAnchor(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_GetOpenedPageTitle(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_SetRelatedFrame(IntPtr self, IntPtr frame, string format);
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_GetRelatedFrame(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_SetRelatedStatusBar(IntPtr self, int bar);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_SetFonts(IntPtr self, string normal_face, string fixed_face, int[] sizes);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_SetBorders(IntPtr self, int b);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_ReadCustomization(IntPtr self, IntPtr cfg, string path);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_WriteCustomization(IntPtr self, IntPtr cfg, string path);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_HistoryBack(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_HistoryForward(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_HistoryCanBack(IntPtr self);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_HistoryCanForward(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_HistoryClear(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_GetInternalRepresentation(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_AddFilter(IntPtr filter);
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_GetParser(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_AddProcessor(IntPtr self, IntPtr processor);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_AddGlobalProcessor(IntPtr processor);
		[DllImport("wx-c")] static extern bool   wxHtmlWindow_AcceptsFocusFromKeyboard(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_OnSetTitle(IntPtr self, string title);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_OnCellClicked(IntPtr self, IntPtr cell, int x, int y, IntPtr evt);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_OnLinkClicked(IntPtr self, IntPtr link);
		[DllImport("wx-c")] static extern int    wxHtmlWindow_OnOpeningURL(IntPtr self, int type, string url, string redirect);
		
		[DllImport("wx-c")] static extern void   wxHtmlWindow_SelectAll(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_SelectWord(IntPtr self, ref Point pos);
		[DllImport("wx-c")] static extern void   wxHtmlWindow_SelectLine(IntPtr self, ref Point pos);
		
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_ToText(IntPtr self);
		
		[DllImport("wx-c")] static extern IntPtr wxHtmlWindow_SelectionToText(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public HtmlWindow(IntPtr  wxObject)
			: base(wxObject) { }

		public HtmlWindow()
			: base(wxHtmlWindow_ctor()) { }
		
		public HtmlWindow(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, wxHW_SCROLLBAR_AUTO, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, wxHW_SCROLLBAR_AUTO, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, wxHW_SCROLLBAR_AUTO, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxHtmlWindow_ctor())
		{
			virtual_OnLinkClicked = new Virtual_OnLinkClicked( DoOnLinkClicked );
			virtual_OnSetTitle = new Virtual_OnSetTitle( DoOnSetTitle );
			virtual_OnCellMouseHover = new Virtual_OnCellMouseHover( DoOnCellMouseHover );
			virtual_OnCellClicked = new Virtual_OnCellClicked( DoOnCellClicked );
			virtual_OnOpeningUrl = new Virtual_OnOpeningURL( DoOnOpeningURL);

			wxHtmlWindow_RegisterVirtual(wxObject, 
				virtual_OnLinkClicked,
				virtual_OnSetTitle,
				virtual_OnCellMouseHover,
				virtual_OnCellClicked,
				virtual_OnOpeningUrl
				);

			if (!Create(parent, id, pos, size, style, name)) 
			{
				throw new InvalidOperationException("Failed to create HtmlWindow");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public HtmlWindow(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, wxHW_SCROLLBAR_AUTO, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, wxHW_SCROLLBAR_AUTO, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, wxHW_SCROLLBAR_AUTO, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "HtmlWindow") { }
		
		public HtmlWindow(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}

		//-----------------------------------------------------------------------------

		public new bool Create(Window parent, int id, Point pos, Size size, long style, string name)
		{
			return wxHtmlWindow_Create(wxObject, Object.SafePtr(parent), id, ref pos, ref size, (uint)style, name);
		}

		//-----------------------------------------------------------------------------

		public bool SetPage(string source)
		{
			return wxHtmlWindow_SetPage(wxObject, source);
		}
		
		public bool AppendToPage(string source)
		{
			return wxHtmlWindow_AppendToPage(wxObject, source);
		}

		//-----------------------------------------------------------------------------
		
		public virtual bool LoadPage(string location)
		{
			return wxHtmlWindow_LoadPage(wxObject, location);
		}
		
		public bool LoadFile(string filename)
		{
			return wxHtmlWindow_LoadFile(wxObject, filename);
		}
		
		//-----------------------------------------------------------------------------
		
		public string OpenedPage
		{
			get { return new wxString(wxHtmlWindow_GetOpenedPage(wxObject), true); } 
		}
		
		public string OpenedAnchor
		{
			get { return new wxString(wxHtmlWindow_GetOpenedAnchor(wxObject), true); }
		}
		
		public string OpenedPageTitle
		{
			get { return new wxString(wxHtmlWindow_GetOpenedPageTitle(wxObject), true); }
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetRelatedFrame(Frame frame, string format)
		{
			wxHtmlWindow_SetRelatedFrame(wxObject, Object.SafePtr(frame), format);
		}
		
		public Frame RelatedFrame
		{
			get { return (Frame)FindObject(wxHtmlWindow_GetRelatedFrame(wxObject), typeof(Frame)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public int RelatedStatusBar
		{
			set { wxHtmlWindow_SetRelatedStatusBar(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetFonts(string normal_face, string fixed_face, int[] sizes)
		{
			wxHtmlWindow_SetFonts(wxObject, normal_face, fixed_face, sizes);
		}
		
		//-----------------------------------------------------------------------------
		
		public int Borders
		{
			set { wxHtmlWindow_SetBorders(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public virtual void ReadCustomization(Config cfg, string path)
		{
			wxHtmlWindow_ReadCustomization(wxObject, Object.SafePtr(cfg), path);
		}
		
		//-----------------------------------------------------------------------------
		
		public virtual void WriteCustomization(Config cfg, string path)
		{
			wxHtmlWindow_WriteCustomization(wxObject, Object.SafePtr(cfg), path);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool HistoryBack()
		{
			return wxHtmlWindow_HistoryBack(wxObject);
		}
		
		public bool HistoryForward()
		{
			return wxHtmlWindow_HistoryForward(wxObject);
		}
		
		public bool HistoryCanBack()
		{
			return wxHtmlWindow_HistoryCanBack(wxObject);
		}
		
		public bool HistoryCanForward()
		{
			return wxHtmlWindow_HistoryCanForward(wxObject);
		}
		
		public void HistoryClear()
		{
			wxHtmlWindow_HistoryClear(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public HtmlContainerCell InternalRepresentation
		{
			get { return (HtmlContainerCell)FindObject(wxHtmlWindow_GetInternalRepresentation(wxObject), typeof(HtmlContainerCell)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public static void AddFilter(HtmlFilter filter)
		{
			wxHtmlWindow_AddFilter(Object.SafePtr(filter));
		}
		
		//-----------------------------------------------------------------------------
		
		public HtmlWinParser Parser
		{
			get { return (HtmlWinParser)FindObject(wxHtmlWindow_GetParser(wxObject), typeof(HtmlWinParser)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public void AddProcessor(HtmlProcessor processor)
		{
			wxHtmlWindow_AddProcessor(wxObject, Object.SafePtr(processor));
		}
		
		public static void AddGlobalProcessor(HtmlProcessor processor)
		{
			wxHtmlWindow_AddGlobalProcessor(Object.SafePtr(processor));
		}
		
		//-----------------------------------------------------------------------------
		
		public override bool AcceptsFocusFromKeyboard()
		{
			return wxHtmlWindow_AcceptsFocusFromKeyboard(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		private void DoOnSetTitle(IntPtr title)
		{			
			OnSetTitle(new wxString(title));
		}
		
		public virtual void OnSetTitle(string title)
		{
			wxHtmlWindow_OnSetTitle(wxObject, title);
		}
		
		//-----------------------------------------------------------------------------
		
		private void DoOnCellMouseHover(IntPtr cell, int x, int y)
		{
			OnCellMouseHover(new HtmlCell(cell), x, y);
		}
		
		public virtual void OnCellMouseHover(HtmlCell cell, int x, int y)
		{
			// Do nothing here
		}
		
		//-----------------------------------------------------------------------------
		
		private void DoOnCellClicked(IntPtr cell, int x, int y, IntPtr mouseevent)
		{
			OnCellClicked(new HtmlCell(cell), x, y, new MouseEvent(mouseevent));
		}
		
		public virtual void OnCellClicked(HtmlCell cell, int x, int y, MouseEvent evt)
		{
			wxHtmlWindow_OnCellClicked(wxObject, Object.SafePtr(cell), x, y, Object.SafePtr(evt));
		}
		
		//-----------------------------------------------------------------------------
		
		private void DoOnLinkClicked(IntPtr link)
		{
			OnLinkClicked(new HtmlLinkInfo(link));
		}
		
		public virtual void OnLinkClicked(HtmlLinkInfo link)
		{
			wxHtmlWindow_OnLinkClicked(wxObject, Object.SafePtr(link));
		}
		
		//-----------------------------------------------------------------------------
		
		private int DoOnOpeningURL(int type, IntPtr url, IntPtr redirect)
		{
			return (int)OnOpeningURL((HtmlURLType) type, new wxString(url), new wxString(redirect));
		}
		
		public HtmlOpeningStatus OnOpeningURL(HtmlURLType type, string url, string redirect)
		{
			return (HtmlOpeningStatus)wxHtmlWindow_OnOpeningURL(wxObject, (int)type, url, redirect);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SelectAll()
		{
			wxHtmlWindow_SelectAll(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SelectLine(Point pos)
		{
			wxHtmlWindow_SelectLine(wxObject, ref pos);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SelectWord(Point pos)
		{
			wxHtmlWindow_SelectWord(wxObject, ref pos);
		}
		
		//-----------------------------------------------------------------------------
		
		public string Text
		{
			get { return new wxString(wxHtmlWindow_ToText(wxObject), true); }
		}
		
		//-----------------------------------------------------------------------------
		
		public string SelectionText
		{
			get { return new wxString(wxHtmlWindow_SelectionToText(wxObject), true); }
		}
	}
		
	//-----------------------------------------------------------------------------

	public class HtmlFontCell : HtmlCell
	{
		[DllImport("wx-c")] static extern IntPtr wxHtmlFontCell_ctor(IntPtr font);
		[DllImport("wx-c")] static extern void   wxHtmlFontCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
		[DllImport("wx-c")] static extern void   wxHtmlFontCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);

		//-----------------------------------------------------------------------------

		public HtmlFontCell(IntPtr wxObject)
			: base(wxObject) {}

		public HtmlFontCell(Font font)
			: this(wxHtmlFontCell_ctor(Object.SafePtr(font))) { }

		//-----------------------------------------------------------------------------

		public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
		{
			wxHtmlFontCell_Draw(wxObject, Object.SafePtr(dc), x, y, view_y1, view_y2, Object.SafePtr(info));
		}
		
		//-----------------------------------------------------------------------------
		
		public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
		{
			wxHtmlFontCell_DrawInvisible(wxObject, Object.SafePtr(dc), x, y, Object.SafePtr(info));
		}
	}

	//-----------------------------------------------------------------------------

	public class HtmlColourCell : HtmlCell
	{
		[DllImport("wx-c")] static extern IntPtr wxHtmlColourCell_ctor(IntPtr clr, int flags);
		[DllImport("wx-c")] static extern void   wxHtmlColourCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
		[DllImport("wx-c")] static extern void   wxHtmlColourCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);

		//-----------------------------------------------------------------------------

		public HtmlColourCell(IntPtr wxObject)
			: base(wxObject) {}

		public  HtmlColourCell(Colour clr, int flags)
			: this(wxHtmlColourCell_ctor(Object.SafePtr(clr), flags)) { }

		//-----------------------------------------------------------------------------

		public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
		{
			wxHtmlColourCell_Draw(wxObject, Object.SafePtr(dc), x, y, view_y1, view_y2, Object.SafePtr(info));
		}

		//-----------------------------------------------------------------------------

		public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
		{
			wxHtmlColourCell_DrawInvisible(wxObject, Object.SafePtr(dc), x, y, Object.SafePtr(info));
		}
	}

	//-----------------------------------------------------------------------------

	public class HtmlLinkInfo : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxHtmlLinkInfo_ctor();
		[DllImport("wx-c")] static extern IntPtr wxHtmlLinkInfo_ctor(string href, string target);
		[DllImport("wx-c")] static extern IntPtr wxHtmlLinkInfo_ctor(IntPtr l);
		[DllImport("wx-c")] static extern void   wxHtmlLinkInfo_SetEvent(IntPtr self, IntPtr e);
		[DllImport("wx-c")] static extern void   wxHtmlLinkInfo_SetHtmlCell(IntPtr self, IntPtr e);
		[DllImport("wx-c")] static extern IntPtr wxHtmlLinkInfo_GetHref(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlLinkInfo_GetTarget(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlLinkInfo_GetEvent(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlLinkInfo_GetHtmlCell(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
		public HtmlLinkInfo(IntPtr wxObject)
			: base(wxObject) {}
		
		public  HtmlLinkInfo()
			: base(wxHtmlLinkInfo_ctor()) { }
		
		//-----------------------------------------------------------------------------
		
		public  HtmlLinkInfo(string href, string target)
			: base(wxHtmlLinkInfo_ctor(href, target)) { }
		
		//-----------------------------------------------------------------------------
		
		/*public  HtmlLinkInfo(HtmlLinkInfo l)
			: base(wxHtmlLinkInfo_ctor(Object.SafePtr(l))) { }*/
		
		//-----------------------------------------------------------------------------
		
		public MouseEvent Event
		{
			set { wxHtmlLinkInfo_SetEvent(wxObject, Object.SafePtr(value)); }
			get { return (MouseEvent)FindObject(wxHtmlLinkInfo_GetEvent(wxObject), typeof(MouseEvent)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public string Href
		{
			get { return new wxString(wxHtmlLinkInfo_GetHref(wxObject), true); }
		}
		
		//-----------------------------------------------------------------------------
		
		public string Target
		{
			get { return new wxString(wxHtmlLinkInfo_GetTarget(wxObject), true); }
		}
		
		//-----------------------------------------------------------------------------
		
		public HtmlCell HtmlCell
		{
			get { return (HtmlCell)FindObject(wxHtmlLinkInfo_GetHtmlCell(wxObject), typeof(HtmlCell)); }
			set { wxHtmlLinkInfo_SetHtmlCell(wxObject, Object.SafePtr(value)); }
		}
	}

	//-----------------------------------------------------------------------------

    public class HtmlWidgetCell : HtmlCell
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlWidgetCell_ctor(IntPtr wnd, int w);
        [DllImport("wx-c")] static extern void   wxHtmlWidgetCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
        [DllImport("wx-c")] static extern void   wxHtmlWidgetCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);
        [DllImport("wx-c")] static extern void   wxHtmlWidgetCell_Layout(IntPtr self, int w);

        //-----------------------------------------------------------------------------

		public HtmlWidgetCell(IntPtr wxObject)
			: base(wxObject) {}

        public HtmlWidgetCell(Window wnd, int w)
            : this(wxHtmlWidgetCell_ctor(Object.SafePtr(wnd), w)) { }

        //-----------------------------------------------------------------------------

        public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlWidgetCell_Draw(wxObject, Object.SafePtr(dc), x, y, view_y1, view_y2, Object.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
        {
            wxHtmlWidgetCell_DrawInvisible(wxObject, Object.SafePtr(dc), x, y, Object.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override void Layout(int w)
        {
            wxHtmlWidgetCell_Layout(wxObject, w);
        }
    }

	//-----------------------------------------------------------------------------

    public class HtmlCell : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlCell_ctor();
        [DllImport("wx-c")] static extern void   wxHtmlCell_SetParent(IntPtr self, IntPtr p);
        [DllImport("wx-c")] static extern IntPtr wxHtmlCell_GetParent(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlCell_GetPosX(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlCell_GetPosY(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlCell_GetWidth(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlCell_GetHeight(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlCell_GetDescent(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlCell_GetId(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlCell_SetId(IntPtr self, string id);
        [DllImport("wx-c")] static extern IntPtr wxHtmlCell_GetNext(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlCell_SetPos(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern void   wxHtmlCell_SetLink(IntPtr self, IntPtr link);
        [DllImport("wx-c")] static extern void   wxHtmlCell_SetNext(IntPtr self, IntPtr cell);
        [DllImport("wx-c")] static extern void   wxHtmlCell_Layout(IntPtr self, int w);
        [DllImport("wx-c")] static extern void   wxHtmlCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
        [DllImport("wx-c")] static extern void   wxHtmlCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);
        [DllImport("wx-c")] static extern IntPtr wxHtmlCell_Find(IntPtr self, int condition, IntPtr param);
        [DllImport("wx-c")] static extern void   wxHtmlCell_OnMouseClick(IntPtr self, IntPtr parent, int x, int y, IntPtr evt);
        [DllImport("wx-c")] static extern bool   wxHtmlCell_AdjustPagebreak(IntPtr self, ref int pagebreak);
        [DllImport("wx-c")] static extern void   wxHtmlCell_SetCanLiveOnPagebreak(IntPtr self, bool can);
        [DllImport("wx-c")] static extern void   wxHtmlCell_GetHorizontalConstraints(IntPtr self, ref int left, ref int right);
        [DllImport("wx-c")] static extern bool   wxHtmlCell_IsTerminalCell(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlCell_FindCellByPos(IntPtr self, int x, int y);

        //-----------------------------------------------------------------------------

        public HtmlCell(IntPtr wxObject) 
            : base(wxObject) { }

        public HtmlCell()
            : base(wxHtmlCell_ctor()) { }

        //-----------------------------------------------------------------------------

        public HtmlContainerCell Parent
        {
            set { wxHtmlCell_SetParent(wxObject, Object.SafePtr(value)); }
            get { return (HtmlContainerCell)FindObject(wxHtmlCell_GetParent(wxObject), typeof(HtmlContainerCell)); }
        }

        //-----------------------------------------------------------------------------

        public int PosX
        {
            get { return wxHtmlCell_GetPosX(wxObject); }
        }

        public int PosY
        {
            get { return wxHtmlCell_GetPosY(wxObject); }
        }

        public int Width
        {
            get { return wxHtmlCell_GetWidth(wxObject); }
        }

        public int Height
        {
            get { return wxHtmlCell_GetHeight(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int Descent
        {
            get { return wxHtmlCell_GetDescent(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public virtual string Id
        {
            get { return new wxString(wxHtmlCell_GetId(wxObject), true); }
            set { wxHtmlCell_SetId(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public HtmlCell Next
        {
            get { return (HtmlCell)FindObject(wxHtmlCell_GetNext(wxObject), typeof(HtmlCell)); }
            set { wxHtmlCell_SetNext(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public void SetPos(int x, int y)
        {
            wxHtmlCell_SetPos(wxObject, x, y);
        }

        //-----------------------------------------------------------------------------

        public HtmlLinkInfo Link
        {
            set { wxHtmlCell_SetLink(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public virtual void Layout(int w)
        {
            wxHtmlCell_Layout(wxObject, w);
        }

        //-----------------------------------------------------------------------------

        public virtual void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlCell_Draw(wxObject, Object.SafePtr(dc), x, y, view_y1, view_y2, Object.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public virtual void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
        {
            wxHtmlCell_DrawInvisible(wxObject, Object.SafePtr(dc), x, y, Object.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public virtual HtmlCell Find(int condition, Object param)
        {
            return (HtmlCell)FindObject(wxHtmlCell_Find(wxObject, condition, Object.SafePtr(param)), typeof(HtmlCell));
        }

        //-----------------------------------------------------------------------------

        public virtual void OnMouseClick(Window parent, int x, int y, MouseEvent evt)
        {
            wxHtmlCell_OnMouseClick(wxObject, Object.SafePtr(parent), x, y, Object.SafePtr(evt));
        }

        //-----------------------------------------------------------------------------

        public virtual bool AdjustPagebreak(ref int pagebreak)
        {
            return wxHtmlCell_AdjustPagebreak(wxObject, ref pagebreak);
        }

        //-----------------------------------------------------------------------------

        public bool CanLiveOnPagebreak
        {
            set { wxHtmlCell_SetCanLiveOnPagebreak(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void GetHorizontalConstraints(out int left, out int right)
        {
            left = right = 0;
            wxHtmlCell_GetHorizontalConstraints(wxObject, ref left, ref right);
        }

        //-----------------------------------------------------------------------------

        public virtual bool IsTerminalCell
        {
            get { return wxHtmlCell_IsTerminalCell(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public HtmlCell FindCellByPos(int x, int y)
        {
            return (HtmlCell)FindObject(wxHtmlCell_FindCellByPos(wxObject, x, y), typeof(HtmlCell));
        }

        //-----------------------------------------------------------------------------

        public static implicit operator HtmlCell (IntPtr obj) 
        {
            return (HtmlCell)FindObject(obj, typeof(HtmlCell));
        }
    }

	//-----------------------------------------------------------------------------

    public class HtmlWordCell : HtmlCell
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlWordCell_ctor(string word, IntPtr dc);
        [DllImport("wx-c")] static extern void   wxHtmlWordCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);

        //-----------------------------------------------------------------------------

		public HtmlWordCell(IntPtr wxObject)
			: base(wxObject) {}

        public  HtmlWordCell(string word, DC dc)
            : this(wxHtmlWordCell_ctor(word, Object.SafePtr(dc))) { }

        //-----------------------------------------------------------------------------

        public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlWordCell_Draw(wxObject, Object.SafePtr(dc), x, y, view_y1, view_y2, Object.SafePtr(info));
        }
    }

	//-----------------------------------------------------------------------------

    public class HtmlContainerCell : HtmlCell
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlContainerCell_ctor(IntPtr parent);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_Layout(IntPtr self, int w);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);
        [DllImport("wx-c")] static extern bool   wxHtmlContainerCell_AdjustPagebreak(IntPtr self, ref int pagebreak);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_InsertCell(IntPtr self, IntPtr cell);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetAlignHor(IntPtr self, int al);
        [DllImport("wx-c")] static extern int    wxHtmlContainerCell_GetAlignHor(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetAlignVer(IntPtr self, int al);
        [DllImport("wx-c")] static extern int    wxHtmlContainerCell_GetAlignVer(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetIndent(IntPtr self, int i, int what, int units);
        [DllImport("wx-c")] static extern int    wxHtmlContainerCell_GetIndent(IntPtr self, int ind);
        [DllImport("wx-c")] static extern int    wxHtmlContainerCell_GetIndentUnits(IntPtr self, int ind);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetAlign(IntPtr self, IntPtr tag);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetWidthFloat(IntPtr self, int w, int units);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetWidthFloatTag(IntPtr self, IntPtr tag, double pixel_scale);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetMinHeight(IntPtr self, int h, int align);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetBackgroundColour(IntPtr self, IntPtr clr);
        [DllImport("wx-c")] static extern IntPtr wxHtmlContainerCell_GetBackgroundColour(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_SetBorder(IntPtr self, IntPtr clr1, IntPtr clr2);
        [DllImport("wx-c")] static extern IntPtr wxHtmlContainerCell_GetLink(IntPtr self, int x, int y);
        [DllImport("wx-c")] static extern IntPtr wxHtmlContainerCell_Find(IntPtr self, int condition, IntPtr param);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_OnMouseClick(IntPtr self, IntPtr parent, int x, int y, IntPtr evt);
        [DllImport("wx-c")] static extern void   wxHtmlContainerCell_GetHorizontalConstraints(IntPtr self, ref int left, ref int right);
        [DllImport("wx-c")] static extern IntPtr wxHtmlContainerCell_GetFirstCell(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxHtmlContainerCell_IsTerminalCell(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlContainerCell_FindCellByPos(IntPtr self, int x, int y);

        //-----------------------------------------------------------------------------

        public HtmlContainerCell(IntPtr wxObject)
            : base(wxObject) { }

        public HtmlContainerCell(HtmlContainerCell parent)
            : this(wxHtmlContainerCell_ctor(Object.SafePtr(parent))) { }

        //-----------------------------------------------------------------------------

        public override void Layout(int w)
        {
            wxHtmlContainerCell_Layout(wxObject, w);
        }

        //-----------------------------------------------------------------------------

        public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlContainerCell_Draw(wxObject, Object.SafePtr(dc), x, y, view_y1, view_y2, Object.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
        {
            wxHtmlContainerCell_DrawInvisible(wxObject, Object.SafePtr(dc), x, y, Object.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override bool AdjustPagebreak(ref int pagebreak)
        {
            return wxHtmlContainerCell_AdjustPagebreak(wxObject, ref pagebreak);
        }

        //-----------------------------------------------------------------------------

        public void InsertCell(HtmlCell cell)
        {
            wxHtmlContainerCell_InsertCell(wxObject, Object.SafePtr(cell));
        }

        //-----------------------------------------------------------------------------

        public int AlignHor
        {
            set { wxHtmlContainerCell_SetAlignHor(wxObject, value); }
            get { return wxHtmlContainerCell_GetAlignHor(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int AlignVer
        {
            set { wxHtmlContainerCell_SetAlignVer(wxObject, value); }
            get { return wxHtmlContainerCell_GetAlignVer(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public void SetIndent(int i, int what, int units)
        {
            wxHtmlContainerCell_SetIndent(wxObject, i, what, units);
        }

        public int GetIndent(int ind)
        {
            return wxHtmlContainerCell_GetIndent(wxObject, ind);
        }

        public int GetIndentUnits(int ind)
        {
            return wxHtmlContainerCell_GetIndentUnits(wxObject, ind);
        }

        //-----------------------------------------------------------------------------

        public HtmlTag Align
        {
            set { wxHtmlContainerCell_SetAlign(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public void SetWidthFloat(int w, int units)
        {
            wxHtmlContainerCell_SetWidthFloat(wxObject, w, units);
        }

        public void SetWidthFloat(HtmlTag tag, double pixel_scale)
        {
            wxHtmlContainerCell_SetWidthFloatTag(wxObject, Object.SafePtr(tag), pixel_scale);
        }

        //-----------------------------------------------------------------------------

        public void SetMinHeight(int h, int align)
        {
            wxHtmlContainerCell_SetMinHeight(wxObject, h, align);
        }

        //-----------------------------------------------------------------------------

        public Colour BackgroundColour
        {
            set { wxHtmlContainerCell_SetBackgroundColour(wxObject, Object.SafePtr(value)); }
            get { return new Colour(wxHtmlContainerCell_GetBackgroundColour(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public void SetBorder(Colour clr1, Colour clr2)
        {
            wxHtmlContainerCell_SetBorder(wxObject, Object.SafePtr(clr1), Object.SafePtr(clr2));
        }

        //-----------------------------------------------------------------------------

        public virtual HtmlLinkInfo GetLink(int x, int y)
        {
            return (HtmlLinkInfo)FindObject(wxHtmlContainerCell_GetLink(wxObject, x, y), typeof(HtmlLinkInfo));
        }

        //-----------------------------------------------------------------------------

        public override HtmlCell Find(int condition, Object param)
        {
            return (HtmlCell)FindObject(wxHtmlContainerCell_Find(wxObject, condition, Object.SafePtr(param)), typeof(HtmlCell));
        }

        //-----------------------------------------------------------------------------

        public override void OnMouseClick(Window parent, int x, int y, MouseEvent evt)
        {
            wxHtmlContainerCell_OnMouseClick(wxObject, Object.SafePtr(parent), x, y, Object.SafePtr(evt));
        }

        //-----------------------------------------------------------------------------

        public new void GetHorizontalConstraints(out int left, out int right)
        {
            left = right = 0;
            wxHtmlContainerCell_GetHorizontalConstraints(wxObject, ref left, ref right);
        }

        //-----------------------------------------------------------------------------

        public HtmlCell FirstCell
        {
            get { return wxHtmlContainerCell_GetFirstCell(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public override bool IsTerminalCell
        {
            get { return wxHtmlContainerCell_IsTerminalCell(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public new HtmlCell FindCellByPos(int x, int y)
        {
            return wxHtmlContainerCell_FindCellByPos(wxObject, x, y);
        }
    }

	//-----------------------------------------------------------------------------

    public class HtmlTag : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetParent(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetFirstSibling(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetLastSibling(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetChildren(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetPreviousSibling(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetNextSibling(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetNextTag(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetName(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxHtmlTag_HasParam(IntPtr self, string par);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetParam(IntPtr self, string par, bool with_commas);
        [DllImport("wx-c")] static extern bool   wxHtmlTag_GetParamAsColour(IntPtr self, string par, IntPtr clr);
        [DllImport("wx-c")] static extern bool   wxHtmlTag_GetParamAsInt(IntPtr self, string par, ref int clr);
        [DllImport("wx-c")] static extern int    wxHtmlTag_ScanParam(IntPtr self, string par, string format, IntPtr param);
        [DllImport("wx-c")] static extern IntPtr wxHtmlTag_GetAllParams(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxHtmlTag_IsEnding(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxHtmlTag_HasEnding(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlTag_GetBeginPos(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlTag_GetEndPos1(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlTag_GetEndPos2(IntPtr self);

        //-----------------------------------------------------------------------------

        public HtmlTag(IntPtr wxObject) 
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        public HtmlTag Parent
        {
            get { return wxHtmlTag_GetParent(wxObject); }
        }

        public HtmlTag FirstSibling
        {
            get { return wxHtmlTag_GetFirstSibling(wxObject); }
        }

        public HtmlTag LastSibling
        {
            get { return wxHtmlTag_GetLastSibling(wxObject); }
        }

        public HtmlTag Children
        {
            get { return wxHtmlTag_GetChildren(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public HtmlTag PreviousSibling
        {
            get { return wxHtmlTag_GetPreviousSibling(wxObject); }
        }

        public HtmlTag NextSibling
        {
            get { return wxHtmlTag_GetNextSibling(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public HtmlTag NextTag
        {
            get { return wxHtmlTag_GetNextTag(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public string Name
        {
            get { return new wxString(wxHtmlTag_GetName(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public bool HasParam(string par)
        {
            return wxHtmlTag_HasParam(wxObject, par);
        }

        public string GetParam(string par, bool with_commas)
        {
            return new wxString(wxHtmlTag_GetParam(wxObject, par, with_commas), true);
        }

        //-----------------------------------------------------------------------------

        public bool GetParamAsColour(string par, Colour clr)
        {
            return wxHtmlTag_GetParamAsColour(wxObject, par, Object.SafePtr(clr));
        }

        //-----------------------------------------------------------------------------

        public bool GetParamAsInt(string par, out int clr)
        {
            clr = 0;
            return wxHtmlTag_GetParamAsInt(wxObject, par, ref clr);
        }

        //-----------------------------------------------------------------------------

        public int ScanParam(string par, string format, Object param)
        {
            return wxHtmlTag_ScanParam(wxObject, par, format, Object.SafePtr(param));
        }

        //-----------------------------------------------------------------------------

        public string AllParams
        {
            get { return new wxString(wxHtmlTag_GetAllParams(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public bool IsEnding
        {
            get { return wxHtmlTag_IsEnding(wxObject); }
        }

        public bool HasEnding
        {
            get { return wxHtmlTag_HasEnding(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int BeginPos
        {
            get { return wxHtmlTag_GetBeginPos(wxObject); }
        }

        public int EndPos1
        {
            get { return wxHtmlTag_GetEndPos1(wxObject); }
        }

        public int EndPos2
        {
            get { return wxHtmlTag_GetEndPos2(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public static implicit operator HtmlTag (IntPtr obj) 
        {
            return (HtmlTag)FindObject(obj, typeof(HtmlTag));
        }
    }

    public abstract class HtmlFilter : Object
    {
        // TODO

        public HtmlFilter(IntPtr wxObject) 
            : base(wxObject) { }

        /*public abstract bool CanRead(FSFile file);
        public abstract string ReadFile(FSFile file);*/
    }

	//-----------------------------------------------------------------------------

    public class HtmlFilterPlainText : HtmlFilter
    {
        [DllImport("wx-c")] static extern bool   wxHtmlFilterPlainText_CanRead(IntPtr self, IntPtr file);
        [DllImport("wx-c")] static extern IntPtr wxHtmlFilterPlainText_ReadFile(IntPtr self, IntPtr file);

        //-----------------------------------------------------------------------------

        public HtmlFilterPlainText(IntPtr wxObject) 
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        /*public override bool CanRead(FSFile file)
        {
            return wxHtmlFilterPlainText_CanRead(wxObject, Object.SafePtr(file));
        }

        //-----------------------------------------------------------------------------

        public override string ReadFile(FSFile file)
        {
            return new wxString(wxHtmlFilterPlainText_ReadFile(wxObject, Object.SafePtr(file)));
        }*/
    }

	//-----------------------------------------------------------------------------

    public class HtmlFilterHTML : HtmlFilter
    {
        [DllImport("wx-c")] static extern bool   wxHtmlFilterHTML_CanRead(IntPtr self, IntPtr file);
        [DllImport("wx-c")] static extern IntPtr wxHtmlFilterHTML_ReadFile(IntPtr self, IntPtr file);

        //-----------------------------------------------------------------------------

        public HtmlFilterHTML(IntPtr wxObject) 
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        /*public override bool CanRead(FSFile file)
        {
            return wxHtmlFilterHTML_CanRead(wxObject, Object.SafePtr(file));
        }

        //-----------------------------------------------------------------------------

        public override string ReadFile(FSFile file)
        {
            return new wxString(wxHtmlFilterHTML_ReadFile(wxObject, Object.SafePtr(file)));
        }*/
    }

	//-----------------------------------------------------------------------------

    public class HtmlTagsModule : Object // TODO: Module
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlTagsModule_ctor();
        [DllImport("wx-c")] static extern bool   wxHtmlTagsModule_OnInit(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlTagsModule_OnExit(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlTagsModule_FillHandlersTable(IntPtr self, IntPtr parser);

        //-----------------------------------------------------------------------------

		public HtmlTagsModule(IntPtr wxObject)
			: base(wxObject) {}

        public HtmlTagsModule()
            : base(wxHtmlTagsModule_ctor()) { }

        //-----------------------------------------------------------------------------

        public bool OnInit()
        {
            return wxHtmlTagsModule_OnInit(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void OnExit()
        {
            wxHtmlTagsModule_OnExit(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void FillHandlersTable(HtmlWinParser  parser)
        {
            wxHtmlTagsModule_FillHandlersTable(wxObject, Object.SafePtr(parser));
        }
    }

	//-----------------------------------------------------------------------------

    public abstract class HtmlWinTagHandler : HtmlTagHandler
    {
        public HtmlWinTagHandler(IntPtr wxObject) 
            : base(wxObject) { }
    }

	//-----------------------------------------------------------------------------

    public class HtmlWinParser : HtmlParser
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_ctor(IntPtr wnd);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_InitParser(IntPtr self, string source);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_DoneParser(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetProduct(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_OpenURL(IntPtr self, int type, string url);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetDC(IntPtr self, IntPtr dc, double pixel_scale);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetDC(IntPtr self);
        [DllImport("wx-c")] static extern double wxHtmlWinParser_GetPixelScale(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetCharHeight(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetCharWidth(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetWindow(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetFonts(IntPtr self, string normal_face, string fixed_face, int[] sizes);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_AddModule(IntPtr self, IntPtr module);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_RemoveModule(IntPtr self, IntPtr module);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetContainer(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_OpenContainer(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_SetContainer(IntPtr self, IntPtr c);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_CloseContainer(IntPtr self);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetFontSize(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetFontSize(IntPtr self, int s);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetFontBold(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetFontBold(IntPtr self, int x);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetFontItalic(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetFontItalic(IntPtr self, int x);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetFontUnderlined(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetFontUnderlined(IntPtr self, int x);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetFontFixed(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetFontFixed(IntPtr self, int x);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetFontFace(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetFontFace(IntPtr self, string face);
        [DllImport("wx-c")] static extern int    wxHtmlWinParser_GetAlign(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetAlign(IntPtr self, int a);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetLinkColor(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetLinkColor(IntPtr self, IntPtr clr);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetActualColor(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetActualColor(IntPtr self, IntPtr clr);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_GetLink(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlWinParser_SetLink(IntPtr self, IntPtr link);
        [DllImport("wx-c")] static extern IntPtr wxHtmlWinParser_CreateCurrentFont(IntPtr self);

        //-----------------------------------------------------------------------------

		public HtmlWinParser(IntPtr wxObject)
			: base(wxObject) {}

        public HtmlWinParser(HtmlWindow wnd)
            : base(wxHtmlWinParser_ctor(Object.SafePtr(wnd))) { }

        //-----------------------------------------------------------------------------

        public override void InitParser(string source)
        {
            wxHtmlWinParser_InitParser(wxObject, source);
        }

        //-----------------------------------------------------------------------------

        public override void DoneParser()
        {
            wxHtmlWinParser_DoneParser(wxObject);
        }

        //-----------------------------------------------------------------------------

        public override Object Product
        {
            get { return FindObject(wxHtmlWinParser_GetProduct(wxObject), typeof(Object)); }
        }

        //-----------------------------------------------------------------------------

        /*public FSFile OpenURL(HtmlURLType type, string url)
        {
            return wxHtmlWinParser_OpenURL(wxObject, Object.SafePtr(type), url);
        }*/

        //-----------------------------------------------------------------------------

        public void SetDC(DC dc, double pixel_scale)
        {
            wxHtmlWinParser_SetDC(wxObject, Object.SafePtr(dc), pixel_scale);
        }

        //-----------------------------------------------------------------------------

        public DC DC
        {
            get { return (DC)FindObject(wxHtmlWinParser_GetDC(wxObject), typeof(DC)); }
        }

        //-----------------------------------------------------------------------------

        public double PixelScale
        {
            get { return wxHtmlWinParser_GetPixelScale(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public int CharHeight
        {
            get { return wxHtmlWinParser_GetCharHeight(wxObject); }
        }

        public int CharWidth
        {
            get { return wxHtmlWinParser_GetCharWidth(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public HtmlWindow Window
        {
            get { return (HtmlWindow)FindObject(wxHtmlWinParser_GetWindow(wxObject), typeof(HtmlWindow)); }
        }

        //-----------------------------------------------------------------------------

        public void SetFonts(string normal_face, string fixed_face, int[] sizes)
        {
            wxHtmlWinParser_SetFonts(wxObject, normal_face, fixed_face, sizes);
        }

        //-----------------------------------------------------------------------------

        public void AddModule(HtmlTagsModule module)
        {
            wxHtmlWinParser_AddModule(wxObject, Object.SafePtr(module));
        }

        public void RemoveModule(HtmlTagsModule module)
        {
            wxHtmlWinParser_RemoveModule(wxObject, Object.SafePtr(module));
        }

        //-----------------------------------------------------------------------------

        public HtmlContainerCell Container
        {
            get { return (HtmlContainerCell)FindObject(wxHtmlWinParser_GetContainer(wxObject), typeof(HtmlContainerCell)); }
        }

        public HtmlContainerCell SetContainter(HtmlContainerCell cont)
        {
            return (HtmlContainerCell)FindObject(wxHtmlWinParser_SetContainer(wxObject, Object.SafePtr(cont)), typeof(HtmlContainerCell));
        }

        //-----------------------------------------------------------------------------

        public HtmlContainerCell OpenContainer()
        {
            return (HtmlContainerCell)FindObject(wxHtmlWinParser_OpenContainer(wxObject), typeof(HtmlContainerCell));
        }

        public HtmlContainerCell CloseContainer()
        {
            return (HtmlContainerCell)FindObject(wxHtmlWinParser_CloseContainer(wxObject), typeof(HtmlContainerCell));
        }

        //-----------------------------------------------------------------------------

        public int FontSize
        {
            get { return wxHtmlWinParser_GetFontSize(wxObject); }
            set { wxHtmlWinParser_SetFontSize(wxObject, value); }
        }

        public int FontBold
        {
            get { return wxHtmlWinParser_GetFontBold(wxObject); }
            set { wxHtmlWinParser_SetFontBold(wxObject, value); }
        }

        public int FontItalic
        {
            get { return wxHtmlWinParser_GetFontItalic(wxObject); }
            set { wxHtmlWinParser_SetFontItalic(wxObject, value); }
        }

        public int FontUnderlined
        {
            get { return wxHtmlWinParser_GetFontUnderlined(wxObject); }
            set { wxHtmlWinParser_SetFontUnderlined(wxObject, value); }
        }

        public int FontFixed
        {
            get { return wxHtmlWinParser_GetFontFixed(wxObject); }
            set { wxHtmlWinParser_SetFontFixed(wxObject, value); }
        }

        public string FontFace
        {
            get { return new wxString(wxHtmlWinParser_GetFontFace(wxObject), true); }
            set { wxHtmlWinParser_SetFontFace(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Align
        {
            get { return wxHtmlWinParser_GetAlign(wxObject); }
            set { wxHtmlWinParser_SetAlign(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public Colour LinkColor
        {
            get { return new Colour(wxHtmlWinParser_GetLinkColor(wxObject), true); }
            set { wxHtmlWinParser_SetLinkColor(wxObject, Object.SafePtr(value)); }
        }

        public Colour ActualColor
        {
            get { return new Colour(wxHtmlWinParser_GetActualColor(wxObject), true); }
            set { wxHtmlWinParser_SetActualColor(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public HtmlLinkInfo Link
        {
            get { return (HtmlLinkInfo)FindObject(wxHtmlWinParser_GetLink(wxObject), typeof(HtmlLinkInfo)); }
            set { wxHtmlWinParser_SetLink(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public Font CreateCurrentFont()
        {
            return new Font(wxHtmlWinParser_CreateCurrentFont(wxObject));
        }
    }

	//-----------------------------------------------------------------------------

    public abstract class HtmlTagHandler : Object
    {
        [DllImport("wx-c")] static extern void   wxHtmlTagHandler_SetParser(IntPtr self, IntPtr parser);

        //-----------------------------------------------------------------------------

        public HtmlTagHandler(IntPtr wxObject) 
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        public HtmlParser Parser
        {
            set { wxHtmlTagHandler_SetParser(wxObject, Object.SafePtr(value)); }
        }

        //-----------------------------------------------------------------------------

        public abstract string GetSupportedTags();
        public abstract bool HandleTag(HtmlTag tag);
    }

	//-----------------------------------------------------------------------------

    public class HtmlEntitiesParser : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxHtmlEntitiesParser_ctor();
        [DllImport("wx-c")] static extern void   wxHtmlEntitiesParser_SetEncoding(IntPtr self, int encoding);
        [DllImport("wx-c")] static extern IntPtr wxHtmlEntitiesParser_Parse(IntPtr self, string input);
        [DllImport("wx-c")] static extern char   wxHtmlEntitiesParser_GetEntityChar(IntPtr self, string entity);
        [DllImport("wx-c")] static extern char   wxHtmlEntitiesParser_GetCharForCode(IntPtr self, uint code);

        //-----------------------------------------------------------------------------

		public HtmlEntitiesParser(IntPtr wxObject)
			: base(wxObject) {}

        public  HtmlEntitiesParser()
            : base(wxHtmlEntitiesParser_ctor()) { }

        //-----------------------------------------------------------------------------

        public FontEncoding Encoding
        {
            set { wxHtmlEntitiesParser_SetEncoding(wxObject, (int)value); }
        }

        //-----------------------------------------------------------------------------

        public string Parse(string input)
        {
            return new wxString(wxHtmlEntitiesParser_Parse(wxObject, input), true);
        }

        //-----------------------------------------------------------------------------

        public char GetEntityChar(string entity)
        {
            return wxHtmlEntitiesParser_GetEntityChar(wxObject, entity);
        }

        public char GetCharForCode(long code)
        {
            return wxHtmlEntitiesParser_GetCharForCode(wxObject, (uint)code);
        }
    }

	//-----------------------------------------------------------------------------

    public abstract class HtmlParser : Object
    {
        [DllImport("wx-c")] static extern void   wxHtmlParser_SetFS(IntPtr self, IntPtr fs);
        [DllImport("wx-c")] static extern IntPtr wxHtmlParser_GetFS(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlParser_OpenURL(IntPtr self, int type, string url);
        [DllImport("wx-c")] static extern IntPtr wxHtmlParser_Parse(IntPtr self, string source);
        [DllImport("wx-c")] static extern void   wxHtmlParser_InitParser(IntPtr self, string source);
        [DllImport("wx-c")] static extern void   wxHtmlParser_DoneParser(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlParser_StopParsing(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlParser_DoParsing(IntPtr self, int begin_pos, int end_pos);
        [DllImport("wx-c")] static extern void   wxHtmlParser_DoParsingAll(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlParser_GetCurrentTag(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlParser_AddTagHandler(IntPtr self, IntPtr handler);
        [DllImport("wx-c")] static extern void   wxHtmlParser_PushTagHandler(IntPtr self, IntPtr handler, string tags);
        [DllImport("wx-c")] static extern void   wxHtmlParser_PopTagHandler(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlParser_GetSource(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlParser_SetSource(IntPtr self, string src);
        [DllImport("wx-c")] static extern void   wxHtmlParser_SetSourceAndSaveState(IntPtr self, string src);
        [DllImport("wx-c")] static extern bool   wxHtmlParser_RestoreState(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxHtmlParser_ExtractCharsetInformation(IntPtr self, string markup);

        //-----------------------------------------------------------------------------

        public HtmlParser(IntPtr wxObject) 
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        /*public void SetFS(FileSystem fs)
        {
            wxHtmlParser_SetFS(wxObject, Object.SafePtr(fs));
        }

        //-----------------------------------------------------------------------------

        public FileSystem GetFS()
        {
            return wxHtmlParser_GetFS(wxObject);
        }

        //-----------------------------------------------------------------------------

        public FSFile OpenURL(HtmlURLType type, string url)
        {
            return wxHtmlParser_OpenURL(wxObject, Object.SafePtr(type), url);
        }*/

        //-----------------------------------------------------------------------------

        public Object Parse(string source)
        {
            return new Object(wxHtmlParser_Parse(wxObject, source));
        }

        //-----------------------------------------------------------------------------

        public virtual void InitParser(string source)
        {
            wxHtmlParser_InitParser(wxObject, source);
        }

        //-----------------------------------------------------------------------------

        public virtual void DoneParser()
        {
            wxHtmlParser_DoneParser(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void StopParsing()
        {
            wxHtmlParser_StopParsing(wxObject);
        }

        //-----------------------------------------------------------------------------

        public void DoParsing(int begin_pos, int end_pos)
        {
            wxHtmlParser_DoParsing(wxObject, begin_pos, end_pos);
        }

        //-----------------------------------------------------------------------------

        public void DoParsing()
        {
            wxHtmlParser_DoParsingAll(wxObject);
        }

        //-----------------------------------------------------------------------------

        public HtmlTag GetCurrentTag()
        {
            return wxHtmlParser_GetCurrentTag(wxObject);
        }

        //-----------------------------------------------------------------------------

        public abstract Object Product { get; }

        //-----------------------------------------------------------------------------

        public void AddTagHandler(HtmlTagHandler handler)
        {
            wxHtmlParser_AddTagHandler(wxObject, Object.SafePtr(handler));
        }

        //-----------------------------------------------------------------------------

        public void PushTagHandler(HtmlTagHandler handler, string tags)
        {
            wxHtmlParser_PushTagHandler(wxObject, Object.SafePtr(handler), tags);
        }

        //-----------------------------------------------------------------------------

        public void PopTagHandler()
        {
            wxHtmlParser_PopTagHandler(wxObject);
        }

        //-----------------------------------------------------------------------------

        public string Source
        {
            get { return new wxString(wxHtmlParser_GetSource(wxObject), true); }
            set { wxHtmlParser_SetSource(wxObject, value); }
        }

        public string SourceAndSaveState
        {
            set { wxHtmlParser_SetSourceAndSaveState(wxObject, value); }
        }

        public bool RestoreState()
        {
            return wxHtmlParser_RestoreState(wxObject);
        }

        //-----------------------------------------------------------------------------

        public string ExtractCharsetInformation(string markup)
        {
            return new wxString(wxHtmlParser_ExtractCharsetInformation(wxObject, markup), true);
        }
    }

	//-----------------------------------------------------------------------------

    public abstract class HtmlProcessor : Object
    {
        [DllImport("wx-c")] static extern int    wxHtmlProcessor_GetPriority(IntPtr self);
        [DllImport("wx-c")] static extern void   wxHtmlProcessor_Enable(IntPtr self, bool enable);
        [DllImport("wx-c")] static extern bool   wxHtmlProcessor_IsEnabled(IntPtr self);

        //-----------------------------------------------------------------------------

        public HtmlProcessor(IntPtr wxObject) 
            : base(wxObject) { }

        //-----------------------------------------------------------------------------

        public abstract string Process(string text);

        //-----------------------------------------------------------------------------

        public int Priority
        {
            get { return wxHtmlProcessor_GetPriority(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool Enabled
        {
            set { wxHtmlProcessor_Enable(wxObject, value); }
            get { return wxHtmlProcessor_IsEnabled(wxObject); }
        }
    }
    
	//-----------------------------------------------------------------------------
    
	public class HtmlRenderingInfo : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxHtmlRenderingInfo_ctor();
		[DllImport("wx-c")] static extern void wxHtmlRenderingInfo_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxHtmlRenderingInfo_SetSelection(IntPtr self, IntPtr s);
		[DllImport("wx-c")] static extern IntPtr wxHtmlRenderingInfo_GetSelection(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
		public HtmlRenderingInfo(IntPtr wxObject)
			: base(wxObject) 
		{	
			this.wxObject = wxObject;
		}
		
		internal HtmlRenderingInfo(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public HtmlRenderingInfo()
			: this(wxHtmlRenderingInfo_ctor(), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxHtmlRenderingInfo_dtor(wxObject);
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
		
		~HtmlRenderingInfo() 
		{
			Dispose();
		}
			
		//-----------------------------------------------------------------------------
		
		public HtmlSelection Selection
		{
			get { return (HtmlSelection)FindObject(wxHtmlRenderingInfo_GetSelection(wxObject), typeof(HtmlSelection)); }
			set { wxHtmlRenderingInfo_SetSelection(wxObject, Object.SafePtr(value)); }
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class HtmlSelection : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxHtmlSelection_ctor();
		[DllImport("wx-c")] static extern void wxHtmlSelection_dtor(IntPtr self);
		[DllImport("wx-c")] static extern void wxHtmlSelection_Set(IntPtr self, ref Point fromPos, IntPtr fromCell, ref Point toPos, IntPtr toCell);
		[DllImport("wx-c")] static extern void wxHtmlSelection_Set2(IntPtr self, IntPtr fromCell, IntPtr toCell);
		[DllImport("wx-c")] static extern IntPtr wxHtmlSelection_GetFromCell(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlSelection_GetToCell(IntPtr self);
		[DllImport("wx-c")] static extern void wxHtmlSelection_GetFromPos(IntPtr self, out Point fromPos);
		[DllImport("wx-c")] static extern void wxHtmlSelection_GetToPos(IntPtr self, out Point toPos);
		[DllImport("wx-c")] static extern void wxHtmlSelection_GetFromPrivPos(IntPtr self, out Point fromPrivPos);
		[DllImport("wx-c")] static extern void wxHtmlSelection_GetToPrivPos(IntPtr self, out Point toPrivPos);
		[DllImport("wx-c")] static extern void wxHtmlSelection_SetFromPrivPos(IntPtr self, ref Point pos);
		[DllImport("wx-c")] static extern void wxHtmlSelection_SetToPrivPos(IntPtr self, ref Point pos);
		[DllImport("wx-c")] static extern void wxHtmlSelection_ClearPrivPos(IntPtr self);
		[DllImport("wx-c")] static extern bool wxHtmlSelection_IsEmpty(IntPtr self);
		
		//-----------------------------------------------------------------------------

		public HtmlSelection(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal HtmlSelection(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public HtmlSelection()
			: this(wxHtmlSelection_ctor(), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxHtmlSelection_dtor(wxObject);
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
		
		~HtmlSelection() 
		{
			Dispose();
		}
			
		//-----------------------------------------------------------------------------
		
		public void Set(Point fromPos, HtmlCell fromCell, Point toPos, HtmlCell toCell)
		{
			wxHtmlSelection_Set(wxObject, ref fromPos, Object.SafePtr(fromCell), ref toPos, Object.SafePtr(toCell));
		}
		
		public void Set(HtmlCell fromCell, HtmlCell toCell)
		{
			wxHtmlSelection_Set2(wxObject, Object.SafePtr(fromCell), Object.SafePtr(toCell));
		}
		
		//-----------------------------------------------------------------------------
		
		public HtmlCell FromCell
		{
			get { return (HtmlCell)Object.FindObject(wxHtmlSelection_GetFromCell(wxObject), typeof(HtmlCell)); }
		}
		
		public HtmlCell ToCell
		{
			get { return (HtmlCell)Object.FindObject(wxHtmlSelection_GetToCell(wxObject), typeof(HtmlCell)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public Point FromPos
		{
			get { 
				Point tpoint = new Point();
				wxHtmlSelection_GetFromPos(wxObject, out tpoint);
				return tpoint;
			}
		}
		
		public Point ToPos
		{
			get {
				Point tpoint = new Point();
				wxHtmlSelection_GetToPos(wxObject, out tpoint);
				return tpoint;
			}
		}
		
		//-----------------------------------------------------------------------------
		
		public Point FromPrivPos
		{
			get { 
				Point tpoint = new Point();
				wxHtmlSelection_GetFromPrivPos(wxObject, out tpoint);
				return tpoint;
			}
			
			set { wxHtmlSelection_SetFromPrivPos(wxObject, ref value); }
		}
		
		public Point ToPrivPos
		{
			get {
				Point tpoint = new Point();
				wxHtmlSelection_GetToPrivPos(wxObject, out tpoint);
				return tpoint;
			}
			
			set { wxHtmlSelection_SetToPrivPos(wxObject, ref value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public void ClearPrivPos()
		{
			wxHtmlSelection_ClearPrivPos(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Empty
		{
			get { return wxHtmlSelection_IsEmpty(wxObject); }
		}
	}
	
	//-----------------------------------------------------------------------------
	
	public class HtmlEasyPrinting : Object
	{
		public const int wxPAGE_ODD	= 0;
		public const int wxPAGE_EVEN	= 1;
		public const int wxPAGE_ALL	= 2;
		
		//-----------------------------------------------------------------------------
	
		[DllImport("wx-c")] static extern IntPtr wxHtmlEasyPrinting_ctor(string name, IntPtr parent);
		[DllImport("wx-c")] static extern bool   wxHtmlEasyPrinting_PreviewFile(IntPtr self, string htmlfile);
		[DllImport("wx-c")] static extern bool   wxHtmlEasyPrinting_PreviewText(IntPtr self, string htmltext, string basepath);
		[DllImport("wx-c")] static extern bool   wxHtmlEasyPrinting_PrintFile(IntPtr self, string htmlfile);
		[DllImport("wx-c")] static extern bool   wxHtmlEasyPrinting_PrintText(IntPtr self, string htmltext, string basepath);
		[DllImport("wx-c")] static extern void   wxHtmlEasyPrinting_PrinterSetup(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlEasyPrinting_PageSetup(IntPtr self);
		[DllImport("wx-c")] static extern void   wxHtmlEasyPrinting_SetHeader(IntPtr self, string header, int pg);
		[DllImport("wx-c")] static extern void   wxHtmlEasyPrinting_SetFooter(IntPtr self, string footer, int pg);
		[DllImport("wx-c")] static extern void   wxHtmlEasyPrinting_SetFonts(IntPtr self, string normal_face, string fixed_face, int[] sizes);
		[DllImport("wx-c")] static extern void   wxHtmlEasyPrinting_SetStandardFonts(IntPtr self, int size, string normal_face, string fixed_face);
		[DllImport("wx-c")] static extern IntPtr wxHtmlEasyPrinting_GetPrintData(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxHtmlEasyPrinting_GetPageSetupData(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
		public HtmlEasyPrinting(IntPtr wxObject)
			: base(wxObject) {}
			
		public HtmlEasyPrinting()
			: this("Printing", null) {}
			
		public HtmlEasyPrinting(string name)
			: this(name, null) {}
			
		public HtmlEasyPrinting(string name, Window parentWindow)
			: base(wxHtmlEasyPrinting_ctor(name, Object.SafePtr(parentWindow))) {}
			
		//-----------------------------------------------------------------------------
		
		public bool PreviewFile(string htmlfile)
		{
			return wxHtmlEasyPrinting_PreviewFile(wxObject, htmlfile);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool PreviewText(string htmltext)
		{
			return PreviewText(htmltext, "");
		}
		
		public bool PreviewText(string htmltext, string basepath)
		{
			return wxHtmlEasyPrinting_PreviewText(wxObject, htmltext, basepath);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool PrintFile(string htmlfile)
		{
			return wxHtmlEasyPrinting_PrintFile(wxObject, htmlfile);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool PrintText(string htmltext)
		{
			return PrintText(htmltext, "");
		}
		
		public bool PrintText(string htmltext, string basepath)
		{
			return wxHtmlEasyPrinting_PrintText(wxObject, htmltext, basepath);
		}
		
		//-----------------------------------------------------------------------------
		
		public void PrinterSetup()
		{
			wxHtmlEasyPrinting_PrinterSetup(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void PageSetup()
		{
			wxHtmlEasyPrinting_PageSetup(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetHeader(string header)
		{
			SetHeader(header, wxPAGE_ALL);
		}
		
		public void SetHeader(string header, int pg)
		{
			wxHtmlEasyPrinting_SetHeader(wxObject, header, pg);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetFooter(string footer)
		{
			SetFooter(footer, wxPAGE_ALL);
		}
		
		public void SetFooter(string footer, int pg)
		{
			wxHtmlEasyPrinting_SetFooter(wxObject, footer, pg);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetFonts(string normal_face, string fixed_face)
		{
			SetFonts(normal_face, fixed_face, null);
		}
		
		public void SetFonts(string normal_face, string fixed_face, int[] sizes)
		{
			wxHtmlEasyPrinting_SetFonts(wxObject, normal_face, fixed_face, sizes);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetStandardFonts()
		{
			SetStandardFonts(-1, "", "");
		}
		
		public void SetStandardFonts(int size)
		{
			SetStandardFonts(size, "", "");
		}
		
		public void SetStandardFonts(int size, string normal_face)
		{
			SetStandardFonts(size, normal_face, "");
		}
		
		public void SetStandardFonts(int size, string normal_face, string fixed_face)
		{
			wxHtmlEasyPrinting_SetStandardFonts(wxObject, size, normal_face, fixed_face);
		}
		
		//-----------------------------------------------------------------------------
		
		public PrintData PrintData
		{
			get { return (PrintData)FindObject(wxHtmlEasyPrinting_GetPrintData(wxObject), typeof(PrintData)); }
		}
		
		//-----------------------------------------------------------------------------
		
		public PageSetupDialogData PageSetupData
		{
			get { return (PageSetupDialogData)FindObject(wxHtmlEasyPrinting_GetPageSetupData(wxObject), typeof(PageSetupDialogData)); }
		}
	}
}

