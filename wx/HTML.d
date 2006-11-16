//-----------------------------------------------------------------------------
// wxD - HTML.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.HTML;
import wx.common;
import wx.ScrolledWindow;
import wx.Frame;
import wx.Config;
import wx.PrintData;
import wx.MouseEvent;

//class HtmlContainerCell;
//class HtmlFilter;
//class HtmlTag;

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

        static extern (C) IntPtr wxHtmlTag_GetParent(IntPtr self);
        static extern (C) IntPtr wxHtmlTag_GetFirstSibling(IntPtr self);
        static extern (C) IntPtr wxHtmlTag_GetLastSibling(IntPtr self);
        static extern (C) IntPtr wxHtmlTag_GetChildren(IntPtr self);
        static extern (C) IntPtr wxHtmlTag_GetPreviousSibling(IntPtr self);
        static extern (C) IntPtr wxHtmlTag_GetNextSibling(IntPtr self);
        static extern (C) IntPtr wxHtmlTag_GetNextTag(IntPtr self);
        static extern (C) string wxHtmlTag_GetName(IntPtr self);
        static extern (C) bool   wxHtmlTag_HasParam(IntPtr self, string par);
        static extern (C) string wxHtmlTag_GetParam(IntPtr self, string par, bool with_commas);
        static extern (C) bool   wxHtmlTag_GetParamAsColour(IntPtr self, string par, IntPtr clr);
        static extern (C) bool   wxHtmlTag_GetParamAsInt(IntPtr self, string par, inout int clr);
        static extern (C) int    wxHtmlTag_ScanParam(IntPtr self, string par, string format, IntPtr param);
        static extern (C) string wxHtmlTag_GetAllParams(IntPtr self);
        static extern (C) bool   wxHtmlTag_IsEnding(IntPtr self);
        static extern (C) bool   wxHtmlTag_HasEnding(IntPtr self);
        static extern (C) int    wxHtmlTag_GetBeginPos(IntPtr self);
        static extern (C) int    wxHtmlTag_GetEndPos1(IntPtr self);
        static extern (C) int    wxHtmlTag_GetEndPos2(IntPtr self);

        //-----------------------------------------------------------------------------

    public class HtmlTag : wxObject
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

	public static wxObject New(IntPtr ptr) { return new HtmlTag(ptr); }
        //-----------------------------------------------------------------------------
	private static HtmlTag FindObj(IntPtr ptr) { return cast(HtmlTag)FindObject(ptr, &HtmlTag.New); }

        public HtmlTag Parent() { return HtmlTag.FindObj(wxHtmlTag_GetParent(wxobj)); }

        public HtmlTag FirstSibling() { return HtmlTag.FindObj(wxHtmlTag_GetFirstSibling(wxobj)); }

        public HtmlTag LastSibling() { return HtmlTag.FindObj(wxHtmlTag_GetLastSibling(wxobj)); }

        public HtmlTag Children() { return HtmlTag.FindObj(wxHtmlTag_GetChildren(wxobj)); }

        //-----------------------------------------------------------------------------

        public HtmlTag PreviousSibling() { return HtmlTag.FindObj(wxHtmlTag_GetPreviousSibling(wxobj)); }

        public HtmlTag NextSibling() { return HtmlTag.FindObj(wxHtmlTag_GetNextSibling(wxobj)); }

        //-----------------------------------------------------------------------------

        public HtmlTag NextTag() { return HtmlTag.FindObj(wxHtmlTag_GetNextTag(wxobj)); }

        //-----------------------------------------------------------------------------

        public string Name() { return wxHtmlTag_GetName(wxobj).dup; }

        //-----------------------------------------------------------------------------

        public bool HasParam(string par)
        {
            return wxHtmlTag_HasParam(wxobj, par);
        }

        public string GetParam(string par, bool with_commas)
        {
            return wxHtmlTag_GetParam(wxobj, par, with_commas).dup;
        }

        //-----------------------------------------------------------------------------

        public bool GetParamAsColour(string par, Colour clr)
        {
            return wxHtmlTag_GetParamAsColour(wxobj, par, wxObject.SafePtr(clr));
        }

        //-----------------------------------------------------------------------------

        public bool GetParamAsInt(string par, out int clr)
        {
            clr = 0;
            return wxHtmlTag_GetParamAsInt(wxobj, par, clr);
        }

        //-----------------------------------------------------------------------------

        public int ScanParam(string par, string format, wxObject param)
        {
            return wxHtmlTag_ScanParam(wxobj, par, format, wxObject.SafePtr(param));
        }

        //-----------------------------------------------------------------------------

        public string AllParams() { return wxHtmlTag_GetAllParams(wxobj).dup; }

        //-----------------------------------------------------------------------------

        /* public bool IsEnding() { return wxHtmlTag_IsEnding(wxobj); } */

        public bool HasEnding() { return wxHtmlTag_HasEnding(wxobj); }

        //-----------------------------------------------------------------------------

        public int BeginPos() { return wxHtmlTag_GetBeginPos(wxobj); }

        public int EndPos1() { return wxHtmlTag_GetEndPos1(wxobj); }

        public int EndPos2() { return wxHtmlTag_GetEndPos2(wxobj); }

        //-----------------------------------------------------------------------------
/+
        public static implicit operator HtmlTag (IntPtr obj) 
        {
            return cast(HtmlTag)FindObject(obj, &HtmlTag.New);
        }
+/
    }

    public abstract class HtmlFilter : wxObject
    {
        // TODO

        public this(IntPtr wxobj) 
            { super(wxobj); }

        /*public abstract bool CanRead(FSFile file);
        public abstract string ReadFile(FSFile file);*/
    }

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxHtmlCell_ctor();
        static extern (C) void   wxHtmlCell_SetParent(IntPtr self, IntPtr p);
        static extern (C) IntPtr wxHtmlCell_GetParent(IntPtr self);
        static extern (C) int    wxHtmlCell_GetPosX(IntPtr self);
        static extern (C) int    wxHtmlCell_GetPosY(IntPtr self);
        static extern (C) int    wxHtmlCell_GetWidth(IntPtr self);
        static extern (C) int    wxHtmlCell_GetHeight(IntPtr self);
        static extern (C) int    wxHtmlCell_GetDescent(IntPtr self);
        static extern (C) string wxHtmlCell_GetId(IntPtr self);
        static extern (C) void   wxHtmlCell_SetId(IntPtr self, string id);
        static extern (C) IntPtr wxHtmlCell_GetNext(IntPtr self);
        static extern (C) void   wxHtmlCell_SetPos(IntPtr self, int x, int y);
        static extern (C) void   wxHtmlCell_SetLink(IntPtr self, IntPtr link);
        static extern (C) void   wxHtmlCell_SetNext(IntPtr self, IntPtr cell);
        static extern (C) void   wxHtmlCell_Layout(IntPtr self, int w);
        static extern (C) void   wxHtmlCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
        static extern (C) void   wxHtmlCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);
        static extern (C) IntPtr wxHtmlCell_Find(IntPtr self, int condition, IntPtr param);
        static extern (C) void   wxHtmlCell_OnMouseClick(IntPtr self, IntPtr parent, int x, int y, IntPtr evt);
        static extern (C) bool   wxHtmlCell_AdjustPagebreak(IntPtr self, inout int pagebreak);
        static extern (C) void   wxHtmlCell_SetCanLiveOnPagebreak(IntPtr self, bool can);
        static extern (C) void   wxHtmlCell_GetHorizontalConstraints(IntPtr self, inout int left, inout int right);
        static extern (C) bool   wxHtmlCell_IsTerminalCell(IntPtr self);
        static extern (C) IntPtr wxHtmlCell_FindCellByPos(IntPtr self, int x, int y);

    public class HtmlCell : wxObject
    {
        //-----------------------------------------------------------------------------

        public this(IntPtr wxobj) 
            { super(wxobj); }

        public this()
            { super(wxHtmlCell_ctor()); }

	public static wxObject New(IntPtr ptr) { return new HtmlCell(ptr); }
	public static HtmlCell FindObj(IntPtr ptr) { return cast(HtmlCell)FindObject(ptr, &HtmlCell.New); }
	
        //-----------------------------------------------------------------------------

        public void Parent(HtmlContainerCell value) { wxHtmlCell_SetParent(wxobj, wxObject.SafePtr(value)); }
        public HtmlContainerCell Parent() { return cast(HtmlContainerCell)FindObject(wxHtmlCell_GetParent(wxobj), &HtmlContainerCell.New); }

        //-----------------------------------------------------------------------------

        public int X() { return wxHtmlCell_GetPosX(wxobj); }

        public int Y() { return wxHtmlCell_GetPosY(wxobj); }

        public int Width() { return wxHtmlCell_GetWidth(wxobj); }

        public int Height() { return wxHtmlCell_GetHeight(wxobj); }

	/* helper */
	public int PosX() { return X; }
	public int PosY() { return Y; }

	public Point Position() { return new_Point(X,Y); }
	public void  Position(Point pt) { SetPos(pt.X,pt.Y); }

	public Size size() { return new_Size(Width,Height); }

	public Rectangle rect() { return new_Rectangle(X,Y,Width,Height); }

        //-----------------------------------------------------------------------------

        public int Descent() { return wxHtmlCell_GetDescent(wxobj); }

        //-----------------------------------------------------------------------------

        public /+virtual+/ string Id() { return wxHtmlCell_GetId(wxobj).dup; }
        public /+virtual+/ void Id(string value) { wxHtmlCell_SetId(wxobj, value); }

        //-----------------------------------------------------------------------------

        public HtmlCell Next() { return cast(HtmlCell)FindObject(wxHtmlCell_GetNext(wxobj), &HtmlCell.New); }
        public void Next(HtmlCell value) { wxHtmlCell_SetNext(wxobj, wxObject.SafePtr(value)); }

        //-----------------------------------------------------------------------------

        public void SetPos(int x, int y)
        {
            wxHtmlCell_SetPos(wxobj, x, y);
        }

        //-----------------------------------------------------------------------------

        public void Link(HtmlLinkInfo value) { wxHtmlCell_SetLink(wxobj, wxObject.SafePtr(value)); }

        //-----------------------------------------------------------------------------

        public /+virtual+/ void Layout(int w)
        {
            wxHtmlCell_Layout(wxobj, w);
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlCell_Draw(wxobj, wxObject.SafePtr(dc), x, y, view_y1, view_y2, wxObject.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
        {
            wxHtmlCell_DrawInvisible(wxobj, wxObject.SafePtr(dc), x, y, wxObject.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ HtmlCell Find(int condition, wxObject param)
        {
            return cast(HtmlCell)FindObject(wxHtmlCell_Find(wxobj, condition, wxObject.SafePtr(param)), &HtmlCell.New);
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ void OnMouseClick(Window parent, int x, int y, MouseEvent evt)
        {
            wxHtmlCell_OnMouseClick(wxobj, wxObject.SafePtr(parent), x, y, wxObject.SafePtr(evt));
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ bool AdjustPagebreak(inout int pagebreak)
        {
            return wxHtmlCell_AdjustPagebreak(wxobj, pagebreak);
        }

        //-----------------------------------------------------------------------------

        public void CanLiveOnPagebreak(bool value) { wxHtmlCell_SetCanLiveOnPagebreak(wxobj, value); }

        //-----------------------------------------------------------------------------
/*
        public void GetHorizontalConstraints(out int left, out int right)
        {
            left = right = 0;
            wxHtmlCell_GetHorizontalConstraints(wxobj, left, right);
        }
*/
        //-----------------------------------------------------------------------------

        public /+virtual+/ bool IsTerminalCell() { return wxHtmlCell_IsTerminalCell(wxobj); }

        //-----------------------------------------------------------------------------

        public HtmlCell FindCellByPos(int x, int y)
        {
            return cast(HtmlCell)FindObject(wxHtmlCell_FindCellByPos(wxobj, x, y), &HtmlCell.New);
        }

        //-----------------------------------------------------------------------------
/+
        public static implicit operator HtmlCell (IntPtr obj) 
        {
            return cast(HtmlCell)FindObject(obj, &HtmlCell.New);
        }
+/
    }

	//-----------------------------------------------------------------------------

		static extern (C) IntPtr wxHtmlFontCell_ctor(IntPtr font);
		static extern (C) void   wxHtmlFontCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
		static extern (C) void   wxHtmlFontCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);

	public class HtmlFontCell : HtmlCell
	{
		//-----------------------------------------------------------------------------

		public this(IntPtr wxobj)
			{ super(wxobj);}

		public this(Font font)
			{ this(wxHtmlFontCell_ctor(wxObject.SafePtr(font))); }

		//-----------------------------------------------------------------------------

		public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
		{
			wxHtmlFontCell_Draw(wxobj, wxObject.SafePtr(dc), x, y, view_y1, view_y2, wxObject.SafePtr(info));
		}
		
		//-----------------------------------------------------------------------------
		
		public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
		{
			wxHtmlFontCell_DrawInvisible(wxobj, wxObject.SafePtr(dc), x, y, wxObject.SafePtr(info));
		}
	}

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxHtmlContainerCell_ctor(IntPtr parent);
        static extern (C) void   wxHtmlContainerCell_Layout(IntPtr self, int w);
        static extern (C) void   wxHtmlContainerCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
        static extern (C) void   wxHtmlContainerCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);
        static extern (C) bool   wxHtmlContainerCell_AdjustPagebreak(IntPtr self, inout int pagebreak);
        static extern (C) void   wxHtmlContainerCell_InsertCell(IntPtr self, IntPtr cell);
        static extern (C) void   wxHtmlContainerCell_SetAlignHor(IntPtr self, int al);
        static extern (C) int    wxHtmlContainerCell_GetAlignHor(IntPtr self);
        static extern (C) void   wxHtmlContainerCell_SetAlignVer(IntPtr self, int al);
        static extern (C) int    wxHtmlContainerCell_GetAlignVer(IntPtr self);
        static extern (C) void   wxHtmlContainerCell_SetIndent(IntPtr self, int i, int what, int units);
        static extern (C) int    wxHtmlContainerCell_GetIndent(IntPtr self, int ind);
        static extern (C) int    wxHtmlContainerCell_GetIndentUnits(IntPtr self, int ind);
        static extern (C) void   wxHtmlContainerCell_SetAlign(IntPtr self, IntPtr tag);
        static extern (C) void   wxHtmlContainerCell_SetWidthFloat(IntPtr self, int w, int units);
        static extern (C) void   wxHtmlContainerCell_SetWidthFloatTag(IntPtr self, IntPtr tag, double pixel_scale);
        static extern (C) void   wxHtmlContainerCell_SetMinHeight(IntPtr self, int h, int alignment);
        static extern (C) void   wxHtmlContainerCell_SetBackgroundColour(IntPtr self, IntPtr clr);
        static extern (C) IntPtr wxHtmlContainerCell_GetBackgroundColour(IntPtr self);
        static extern (C) void   wxHtmlContainerCell_SetBorder(IntPtr self, IntPtr clr1, IntPtr clr2);
        static extern (C) IntPtr wxHtmlContainerCell_GetLink(IntPtr self, int x, int y);
        static extern (C) IntPtr wxHtmlContainerCell_Find(IntPtr self, int condition, IntPtr param);
        static extern (C) void   wxHtmlContainerCell_OnMouseClick(IntPtr self, IntPtr parent, int x, int y, IntPtr evt);
        static extern (C) void   wxHtmlContainerCell_GetHorizontalConstraints(IntPtr self, inout int left, inout int right);
        static extern (C) IntPtr wxHtmlContainerCell_GetFirstCell(IntPtr self);
        static extern (C) bool   wxHtmlContainerCell_IsTerminalCell(IntPtr self);
        static extern (C) IntPtr wxHtmlContainerCell_FindCellByPos(IntPtr self, int x, int y);

    public class HtmlContainerCell : HtmlCell
    {
        //-----------------------------------------------------------------------------

        public this(IntPtr wxobj)
            { super(wxobj); }

        public this(HtmlContainerCell parent)
            { this(wxHtmlContainerCell_ctor(wxObject.SafePtr(parent))); }

	public static wxObject New(IntPtr ptr) { return new HtmlContainerCell(ptr); }

        //-----------------------------------------------------------------------------

        public override void Layout(int w)
        {
            wxHtmlContainerCell_Layout(wxobj, w);
        }

        //-----------------------------------------------------------------------------

        public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlContainerCell_Draw(wxobj, wxObject.SafePtr(dc), x, y, view_y1, view_y2, wxObject.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
        {
            wxHtmlContainerCell_DrawInvisible(wxobj, wxObject.SafePtr(dc), x, y, wxObject.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override bool AdjustPagebreak(inout int pagebreak)
        {
            return wxHtmlContainerCell_AdjustPagebreak(wxobj, pagebreak);
        }

        //-----------------------------------------------------------------------------

        public void InsertCell(HtmlCell cell)
        {
            wxHtmlContainerCell_InsertCell(wxobj, wxObject.SafePtr(cell));
        }

        //-----------------------------------------------------------------------------

        public void AlignHor(int value) { wxHtmlContainerCell_SetAlignHor(wxobj, value); }
        public int AlignHor() { return wxHtmlContainerCell_GetAlignHor(wxobj); }

        //-----------------------------------------------------------------------------

        public void AlignVer(int value) { wxHtmlContainerCell_SetAlignVer(wxobj, value); }
        public int AlignVer() { return wxHtmlContainerCell_GetAlignVer(wxobj); }

        //-----------------------------------------------------------------------------

        public void SetIndent(int i, int what, int units)
        {
            wxHtmlContainerCell_SetIndent(wxobj, i, what, units);
        }

        public int GetIndent(int ind)
        {
            return wxHtmlContainerCell_GetIndent(wxobj, ind);
        }

        public int GetIndentUnits(int ind)
        {
            return wxHtmlContainerCell_GetIndentUnits(wxobj, ind);
        }

        //-----------------------------------------------------------------------------

        public void Align(HtmlTag value) { wxHtmlContainerCell_SetAlign(wxobj, wxObject.SafePtr(value)); }

        //-----------------------------------------------------------------------------

        public void SetWidthFloat(int w, int units)
        {
            wxHtmlContainerCell_SetWidthFloat(wxobj, w, units);
        }

        public void SetWidthFloat(HtmlTag tag, double pixel_scale)
        {
            wxHtmlContainerCell_SetWidthFloatTag(wxobj, wxObject.SafePtr(tag), pixel_scale);
        }

        //-----------------------------------------------------------------------------

        public void SetMinHeight(int h, int alignment)
        {
            wxHtmlContainerCell_SetMinHeight(wxobj, h, alignment);
        }

        //-----------------------------------------------------------------------------

        public void BackgroundColour(Colour value) { wxHtmlContainerCell_SetBackgroundColour(wxobj, wxObject.SafePtr(value)); }
        public Colour BackgroundColour() { return new Colour(wxHtmlContainerCell_GetBackgroundColour(wxobj), true); }

        //-----------------------------------------------------------------------------

        public void SetBorder(Colour clr1, Colour clr2)
        {
            wxHtmlContainerCell_SetBorder(wxobj, wxObject.SafePtr(clr1), wxObject.SafePtr(clr2));
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ HtmlLinkInfo GetLink(int x, int y)
        {
            return cast(HtmlLinkInfo)FindObject(wxHtmlContainerCell_GetLink(wxobj, x, y), &HtmlLinkInfo.New);
        }

        //-----------------------------------------------------------------------------

        public override HtmlCell Find(int condition, wxObject param)
        {
//            return cast(HtmlCell)FindObject(wxHtmlContainerCell_Find(wxobj, condition, wxObject.SafePtr(param)), &HtmlCell.New);
            return HtmlCell.FindObj(wxHtmlContainerCell_Find(wxobj, condition, wxObject.SafePtr(param)));
        }

        //-----------------------------------------------------------------------------

        public override void OnMouseClick(Window parent, int x, int y, MouseEvent evt)
        {
            wxHtmlContainerCell_OnMouseClick(wxobj, wxObject.SafePtr(parent), x, y, wxObject.SafePtr(evt));
        }

        //-----------------------------------------------------------------------------
/*
        public void GetHorizontalConstraints(out int left, out int right)
        {
            left = right = 0;
            wxHtmlContainerCell_GetHorizontalConstraints(wxobj, left, right);
        }
*/
        //-----------------------------------------------------------------------------
/*
        public HtmlCell FirstCell() { return HtmlCell.FindObj(wxHtmlContainerCell_GetFirstCell(wxobj)); }
*/
        //-----------------------------------------------------------------------------

        public override bool IsTerminalCell() { return wxHtmlContainerCell_IsTerminalCell(wxobj); }

        //-----------------------------------------------------------------------------

        public HtmlCell FindCellByPos(int x, int y)
        {
            return HtmlCell.FindObj(wxHtmlContainerCell_FindCellByPos(wxobj, x, y));
        }
    }

	//-----------------------------------------------------------------------------

		static extern (C) IntPtr wxHtmlColourCell_ctor(IntPtr clr, int flags);
		static extern (C) void   wxHtmlColourCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
		static extern (C) void   wxHtmlColourCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);

	public class HtmlColourCell : HtmlCell
	{
		//-----------------------------------------------------------------------------

		public this(IntPtr wxobj)
			{ super(wxobj);}

		public  this(Colour clr, int flags)
			{ this(wxHtmlColourCell_ctor(wxObject.SafePtr(clr), flags)); }

		//-----------------------------------------------------------------------------

		public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
		{
			wxHtmlColourCell_Draw(wxobj, wxObject.SafePtr(dc), x, y, view_y1, view_y2, wxObject.SafePtr(info));
		}

		//-----------------------------------------------------------------------------

		public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
		{
			wxHtmlColourCell_DrawInvisible(wxobj, wxObject.SafePtr(dc), x, y, wxObject.SafePtr(info));
		}
	}

	//-----------------------------------------------------------------------------

		static extern (C) IntPtr wxHtmlLinkInfo_ctor();
		static extern (C) IntPtr wxHtmlLinkInfo_ctor(string href, string target);
		static extern (C) IntPtr wxHtmlLinkInfo_ctor(IntPtr l);
		static extern (C) void   wxHtmlLinkInfo_SetEvent(IntPtr self, IntPtr e);
		static extern (C) void   wxHtmlLinkInfo_SetHtmlCell(IntPtr self, IntPtr e);
		static extern (C) string wxHtmlLinkInfo_GetHref(IntPtr self);
		static extern (C) string wxHtmlLinkInfo_GetTarget(IntPtr self);
		static extern (C) IntPtr wxHtmlLinkInfo_GetEvent(IntPtr self);
		static extern (C) IntPtr wxHtmlLinkInfo_GetHtmlCell(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
	public class HtmlLinkInfo : wxObject
	{
		public this(IntPtr wxobj)
			{ super(wxobj);}
		
		public  this()
			{ super(wxHtmlLinkInfo_ctor()); }
		
		//-----------------------------------------------------------------------------
		
		public  this(string href, string target)
			{ super(wxHtmlLinkInfo_ctor(href, target)); }

		public static wxObject New(IntPtr ptr) { return new HtmlCell(ptr); }
		
		//-----------------------------------------------------------------------------
		
		public  this(HtmlLinkInfo l)
			{ super(wxHtmlLinkInfo_ctor(wxObject.SafePtr(l))); }
		//-----------------------------------------------------------------------------
		
		public void event(MouseEvent value) { wxHtmlLinkInfo_SetEvent(wxobj, wxObject.SafePtr(value)); }
		public MouseEvent event() { return cast(MouseEvent)FindObject(wxHtmlLinkInfo_GetEvent(wxobj), cast(wxObject function (IntPtr))&MouseEvent.New); }
		
		//-----------------------------------------------------------------------------
		
		public string Href() { return wxHtmlLinkInfo_GetHref(wxobj).dup; }
		
		//-----------------------------------------------------------------------------
		
		public string Target() { return wxHtmlLinkInfo_GetTarget(wxobj).dup; }
		
		//-----------------------------------------------------------------------------
		
		public HtmlCell htmlCell() { return cast(HtmlCell)FindObject(wxHtmlLinkInfo_GetHtmlCell(wxobj), &HtmlCell.New); }
		public void htmlCell(HtmlCell value) { wxHtmlLinkInfo_SetHtmlCell(wxobj, wxObject.SafePtr(value)); }
	}

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxHtmlWidgetCell_ctor(IntPtr wnd, int w);
        static extern (C) void   wxHtmlWidgetCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);
        static extern (C) void   wxHtmlWidgetCell_DrawInvisible(IntPtr self, IntPtr dc, int x, int y, IntPtr info);
        static extern (C) void   wxHtmlWidgetCell_Layout(IntPtr self, int w);

        //-----------------------------------------------------------------------------

    public class HtmlWidgetCell : HtmlCell
    {
		public this(IntPtr wxobj)
			{ super(wxobj);}

        public this(Window wnd, int w)
            { this(wxHtmlWidgetCell_ctor(wxObject.SafePtr(wnd), w)); }

        //-----------------------------------------------------------------------------

        public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlWidgetCell_Draw(wxobj, wxObject.SafePtr(dc), x, y, view_y1, view_y2, wxObject.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override void DrawInvisible(DC dc, int x, int y, HtmlRenderingInfo info)
        {
            wxHtmlWidgetCell_DrawInvisible(wxobj, wxObject.SafePtr(dc), x, y, wxObject.SafePtr(info));
        }

        //-----------------------------------------------------------------------------

        public override void Layout(int w)
        {
            wxHtmlWidgetCell_Layout(wxobj, w);
        }
    }

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxHtmlWordCell_ctor(string word, IntPtr dc);
        static extern (C) void   wxHtmlWordCell_Draw(IntPtr self, IntPtr dc, int x, int y, int view_y1, int view_y2, IntPtr info);

        //-----------------------------------------------------------------------------

    public class HtmlWordCell : HtmlCell
    {
		public this(IntPtr wxobj)
			{ super(wxobj);}

        public  this(string word, DC dc)
            { this(wxHtmlWordCell_ctor(word, wxObject.SafePtr(dc))); }

        //-----------------------------------------------------------------------------

        public override void Draw(DC dc, int x, int y, int view_y1, int view_y2, HtmlRenderingInfo info)
        {
            wxHtmlWordCell_Draw(wxobj, wxObject.SafePtr(dc), x, y, view_y1, view_y2, wxObject.SafePtr(info));
        }
    }

	//-----------------------------------------------------------------------------

        static extern (C) bool   wxHtmlFilterPlainText_CanRead(IntPtr self, IntPtr file);
        static extern (C) IntPtr wxHtmlFilterPlainText_ReadFile(IntPtr self, IntPtr file);

        //-----------------------------------------------------------------------------

    public class HtmlFilterPlainText : HtmlFilter
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

        //-----------------------------------------------------------------------------

        /*public override bool CanRead(FSFile file)
        {
            return wxHtmlFilterPlainText_CanRead(wxobj, wxObject.SafePtr(file));
        }

        //-----------------------------------------------------------------------------

        public override string ReadFile(FSFile file)
        {
            return new wxString(wxHtmlFilterPlainText_ReadFile(wxobj, wxObject.SafePtr(file)));
        }
    }

	//-----------------------------------------------------------------------------

        static extern (C) bool   wxHtmlFilterHTML_CanRead(IntPtr self, IntPtr file);
        static extern (C) IntPtr wxHtmlFilterHTML_ReadFile(IntPtr self, IntPtr file);

        //-----------------------------------------------------------------------------

    public class HtmlFilterHTML : HtmlFilter
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

        //-----------------------------------------------------------------------------

        /*public override bool CanRead(FSFile file)
        {
            return wxHtmlFilterHTML_CanRead(wxobj, wxObject.SafePtr(file));
        }

        //-----------------------------------------------------------------------------

        public override string ReadFile(FSFile file)
        {
            return new wxString(wxHtmlFilterHTML_ReadFile(wxobj, wxObject.SafePtr(file)));
        }*/
    }

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxHtmlTagsModule_ctor();
        static extern (C) bool   wxHtmlTagsModule_OnInit(IntPtr self);
        static extern (C) void   wxHtmlTagsModule_OnExit(IntPtr self);
        static extern (C) void   wxHtmlTagsModule_FillHandlersTable(IntPtr self, IntPtr parser);

        //-----------------------------------------------------------------------------

    public class HtmlTagsModule : wxObject // TODO: Module
    {
		public this(IntPtr wxobj)
			{ super(wxobj);}

        public this()
            { super(wxHtmlTagsModule_ctor()); }

        //-----------------------------------------------------------------------------

        public bool OnInit()
        {
            return wxHtmlTagsModule_OnInit(wxobj);
        }

        //-----------------------------------------------------------------------------

        public void OnExit()
        {
            wxHtmlTagsModule_OnExit(wxobj);
        }

        //-----------------------------------------------------------------------------

        public void FillHandlersTable(HtmlWinParser  parser)
        {
            wxHtmlTagsModule_FillHandlersTable(wxobj, wxObject.SafePtr(parser));
        }
    }

	//-----------------------------------------------------------------------------

    public abstract class HtmlWinTagHandler : HtmlTagHandler
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }
    }

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxHtmlWinParser_ctor(IntPtr wnd);
        static extern (C) void   wxHtmlWinParser_InitParser(IntPtr self, string source);
        static extern (C) void   wxHtmlWinParser_DoneParser(IntPtr self);
        static extern (C) IntPtr wxHtmlWinParser_GetProduct(IntPtr self);
        static extern (C) IntPtr wxHtmlWinParser_OpenURL(IntPtr self, int type, string url);
        static extern (C) void   wxHtmlWinParser_SetDC(IntPtr self, IntPtr dc, double pixel_scale);
        static extern (C) IntPtr wxHtmlWinParser_GetDC(IntPtr self);
        static extern (C) double wxHtmlWinParser_GetPixelScale(IntPtr self);
        static extern (C) int    wxHtmlWinParser_GetCharHeight(IntPtr self);
        static extern (C) int    wxHtmlWinParser_GetCharWidth(IntPtr self);
        static extern (C) IntPtr wxHtmlWinParser_GetWindow(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetFonts(IntPtr self, string normal_face, string fixed_face, int* sizes);
        static extern (C) void   wxHtmlWinParser_AddModule(IntPtr self, IntPtr mod);
        static extern (C) void   wxHtmlWinParser_RemoveModule(IntPtr self, IntPtr mod);
        static extern (C) IntPtr wxHtmlWinParser_GetContainer(IntPtr self);
        static extern (C) IntPtr wxHtmlWinParser_OpenContainer(IntPtr self);
        static extern (C) IntPtr wxHtmlWinParser_SetContainer(IntPtr self, IntPtr c);
        static extern (C) IntPtr wxHtmlWinParser_CloseContainer(IntPtr self);
        static extern (C) int    wxHtmlWinParser_GetFontSize(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetFontSize(IntPtr self, int s);
        static extern (C) int    wxHtmlWinParser_GetFontBold(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetFontBold(IntPtr self, int x);
        static extern (C) int    wxHtmlWinParser_GetFontItalic(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetFontItalic(IntPtr self, int x);
        static extern (C) int    wxHtmlWinParser_GetFontUnderlined(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetFontUnderlined(IntPtr self, int x);
        static extern (C) int    wxHtmlWinParser_GetFontFixed(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetFontFixed(IntPtr self, int x);
        static extern (C) string wxHtmlWinParser_GetFontFace(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetFontFace(IntPtr self, string face);
        static extern (C) int    wxHtmlWinParser_GetAlign(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetAlign(IntPtr self, int a);
        static extern (C) IntPtr wxHtmlWinParser_GetLinkColor(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetLinkColor(IntPtr self, IntPtr clr);
        static extern (C) IntPtr wxHtmlWinParser_GetActualColor(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetActualColor(IntPtr self, IntPtr clr);
        static extern (C) IntPtr wxHtmlWinParser_GetLink(IntPtr self);
        static extern (C) void   wxHtmlWinParser_SetLink(IntPtr self, IntPtr link);
        static extern (C) IntPtr wxHtmlWinParser_CreateCurrentFont(IntPtr self);

        //-----------------------------------------------------------------------------

    public class HtmlWinParser : HtmlParser
    {
		public this(IntPtr wxobj)
			{ super(wxobj);}

        public this(HtmlWindow wnd)
            { super(wxHtmlWinParser_ctor(wxObject.SafePtr(wnd))); }

	public static wxObject New(IntPtr ptr) { return new HtmlWinParser(ptr); }
        //-----------------------------------------------------------------------------

        public override void InitParser(string source)
        {
            wxHtmlWinParser_InitParser(wxobj, source);
        }

        //-----------------------------------------------------------------------------

        public override void DoneParser()
        {
            wxHtmlWinParser_DoneParser(wxobj);
        }

        //-----------------------------------------------------------------------------

        public override wxObject Product()
        {
//FIXME            return FindObject(wxHtmlWinParser_GetProduct(wxobj), typeof(wxObject));
              return FindObject(wxHtmlWinParser_GetProduct(wxobj));
        }

        //-----------------------------------------------------------------------------

        /*public FSFile OpenURL(HtmlURLType type, string url)
        {
            return wxHtmlWinParser_OpenURL(wxobj, wxObject.SafePtr(type), url);
        }*/

        //-----------------------------------------------------------------------------

        public void SetDC(DC dc, double pixel_scale)
        {
            wxHtmlWinParser_SetDC(wxobj, wxObject.SafePtr(dc), pixel_scale);
        }

        //-----------------------------------------------------------------------------

        public DC GetDC() { return cast(DC)FindObject(wxHtmlWinParser_GetDC(wxobj), &DC.New); }

        //-----------------------------------------------------------------------------

        public double PixelScale() { return wxHtmlWinParser_GetPixelScale(wxobj); }

        //-----------------------------------------------------------------------------

        public int CharHeight() { return wxHtmlWinParser_GetCharHeight(wxobj); }

        public int CharWidth() { return wxHtmlWinParser_GetCharWidth(wxobj); }

        //-----------------------------------------------------------------------------

        public HtmlWindow window() { return cast(HtmlWindow)FindObject(wxHtmlWinParser_GetWindow(wxobj), &HtmlWindow.New); }

        //-----------------------------------------------------------------------------

        public void SetFonts(string normal_face, string fixed_face, int[] sizes)
        {
            wxHtmlWinParser_SetFonts(wxobj, normal_face, fixed_face, sizes);
        }

        //-----------------------------------------------------------------------------

        public void AddModule(HtmlTagsModule mod)
        {
            wxHtmlWinParser_AddModule(wxobj, wxObject.SafePtr(mod));
        }

        public void RemoveModule(HtmlTagsModule mod)
        {
            wxHtmlWinParser_RemoveModule(wxobj, wxObject.SafePtr(mod));
        }

        //-----------------------------------------------------------------------------

        public HtmlContainerCell Container() { return cast(HtmlContainerCell)FindObject(wxHtmlWinParser_GetContainer(wxobj), &HtmlContainerCell.New); }

        public HtmlContainerCell SetContainter(HtmlContainerCell cont)
        {
            return cast(HtmlContainerCell)FindObject(wxHtmlWinParser_SetContainer(wxobj, wxObject.SafePtr(cont)), &HtmlContainerCell.New);
        }

        //-----------------------------------------------------------------------------

        public HtmlContainerCell OpenContainer()
        {
            return cast(HtmlContainerCell)FindObject(wxHtmlWinParser_OpenContainer(wxobj), &HtmlContainerCell.New);
        }

        public HtmlContainerCell CloseContainer()
        {
            return cast(HtmlContainerCell)FindObject(wxHtmlWinParser_CloseContainer(wxobj), &HtmlContainerCell.New);
        }

        //-----------------------------------------------------------------------------

        public int FontSize() { return wxHtmlWinParser_GetFontSize(wxobj); }
        public void FontSize(int value) { wxHtmlWinParser_SetFontSize(wxobj, value); }

        public int FontBold() { return wxHtmlWinParser_GetFontBold(wxobj); }
        public void FontBold(int value) { wxHtmlWinParser_SetFontBold(wxobj, value); }

        public int FontItalic() { return wxHtmlWinParser_GetFontItalic(wxobj); }
        public void FontItalic(int value) { wxHtmlWinParser_SetFontItalic(wxobj, value); }

        public int FontUnderlined() { return wxHtmlWinParser_GetFontUnderlined(wxobj); }
        public void FontUnderlined(int value) { wxHtmlWinParser_SetFontUnderlined(wxobj, value); }

        public int FontFixed() { return wxHtmlWinParser_GetFontFixed(wxobj); }
        public void FontFixed(int value) { wxHtmlWinParser_SetFontFixed(wxobj, value); }

        public string FontFace() { return wxHtmlWinParser_GetFontFace(wxobj).dup; }
        public void FontFace(string value) { wxHtmlWinParser_SetFontFace(wxobj, value); }

        //-----------------------------------------------------------------------------

        public int Align() { return wxHtmlWinParser_GetAlign(wxobj); }
        public void Align(int value) { wxHtmlWinParser_SetAlign(wxobj, value); }

        //-----------------------------------------------------------------------------

        public Colour LinkColor() { return new Colour(wxHtmlWinParser_GetLinkColor(wxobj), true); }
        public void LinkColor(Colour value) { wxHtmlWinParser_SetLinkColor(wxobj, wxObject.SafePtr(value)); }

        public Colour ActualColor() { return new Colour(wxHtmlWinParser_GetActualColor(wxobj), true); }
        public void ActualColor(Colour value) { wxHtmlWinParser_SetActualColor(wxobj, wxObject.SafePtr(value)); }

        //-----------------------------------------------------------------------------

        public HtmlLinkInfo Link() { return cast(HtmlLinkInfo)FindObject(wxHtmlWinParser_GetLink(wxobj), &HtmlLinkInfo.New); }
        public void Link(HtmlLinkInfo value) { wxHtmlWinParser_SetLink(wxobj, wxObject.SafePtr(value)); }

        //-----------------------------------------------------------------------------

        public Font CreateCurrentFont()
        {
            return new Font(wxHtmlWinParser_CreateCurrentFont(wxobj));
        }
    }

	//-----------------------------------------------------------------------------

        static extern (C) void   wxHtmlTagHandler_SetParser(IntPtr self, IntPtr parser);

        //-----------------------------------------------------------------------------

    public abstract class HtmlTagHandler : wxObject
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

        //-----------------------------------------------------------------------------

        public void Parser(HtmlParser value) { wxHtmlTagHandler_SetParser(wxobj, wxObject.SafePtr(value)); }

        //-----------------------------------------------------------------------------

        public abstract string GetSupportedTags();
        public abstract bool HandleTag(HtmlTag tag);
    }

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxHtmlEntitiesParser_ctor();
        static extern (C) void   wxHtmlEntitiesParser_SetEncoding(IntPtr self, int encoding);
        static extern (C) string wxHtmlEntitiesParser_Parse(IntPtr self, string input);
        static extern (C) char   wxHtmlEntitiesParser_GetEntityChar(IntPtr self, string entity);
        static extern (C) char   wxHtmlEntitiesParser_GetCharForCode(IntPtr self, uint code);

        //-----------------------------------------------------------------------------

    public class HtmlEntitiesParser : wxObject
    {
		public this(IntPtr wxobj)
			{ super(wxobj);}

        public  this()
            { super(wxHtmlEntitiesParser_ctor()); }

        //-----------------------------------------------------------------------------

        public void Encoding(FontEncoding value) { wxHtmlEntitiesParser_SetEncoding(wxobj, cast(int)value); }

        //-----------------------------------------------------------------------------

        public string Parse(string input)
        {
            return wxHtmlEntitiesParser_Parse(wxobj, input).dup;
        }

        //-----------------------------------------------------------------------------

        public char GetEntityChar(string entity)
        {
            return wxHtmlEntitiesParser_GetEntityChar(wxobj, entity);
        }

        public char GetCharForCode(int code)
        {
            return wxHtmlEntitiesParser_GetCharForCode(wxobj, cast(uint)code);
        }
    }

	//-----------------------------------------------------------------------------

        static extern (C) void   wxHtmlParser_SetFS(IntPtr self, IntPtr fs);
        static extern (C) IntPtr wxHtmlParser_GetFS(IntPtr self);
        static extern (C) IntPtr wxHtmlParser_OpenURL(IntPtr self, int type, string url);
        static extern (C) IntPtr wxHtmlParser_Parse(IntPtr self, string source);
        static extern (C) void   wxHtmlParser_InitParser(IntPtr self, string source);
        static extern (C) void   wxHtmlParser_DoneParser(IntPtr self);
        static extern (C) void   wxHtmlParser_StopParsing(IntPtr self);
        static extern (C) void   wxHtmlParser_DoParsing(IntPtr self, int begin_pos, int end_pos);
        static extern (C) void   wxHtmlParser_DoParsingAll(IntPtr self);
        static extern (C) IntPtr wxHtmlParser_GetCurrentTag(IntPtr self);
        static extern (C) void   wxHtmlParser_AddTagHandler(IntPtr self, IntPtr handler);
        static extern (C) void   wxHtmlParser_PushTagHandler(IntPtr self, IntPtr handler, string tags);
        static extern (C) void   wxHtmlParser_PopTagHandler(IntPtr self);
        static extern (C) string wxHtmlParser_GetSource(IntPtr self);
        static extern (C) void   wxHtmlParser_SetSource(IntPtr self, string src);
        static extern (C) void   wxHtmlParser_SetSourceAndSaveState(IntPtr self, string src);
        static extern (C) bool   wxHtmlParser_RestoreState(IntPtr self);
        static extern (C) string wxHtmlParser_ExtractCharsetInformation(IntPtr self, string markup);

        //-----------------------------------------------------------------------------

    public abstract class HtmlParser : wxObject
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

        //-----------------------------------------------------------------------------

        /*public void SetFS(FileSystem fs)
        {
            wxHtmlParser_SetFS(wxobj, wxObject.SafePtr(fs));
        }

        //-----------------------------------------------------------------------------

        public FileSystem GetFS()
        {
            return wxHtmlParser_GetFS(wxobj);
        }

        //-----------------------------------------------------------------------------

        public FSFile OpenURL(HtmlURLType type, string url)
        {
            return wxHtmlParser_OpenURL(wxobj, wxObject.SafePtr(type), url);
        }*/

        //-----------------------------------------------------------------------------

        public wxObject Parse(string source)
        {
            return new wxObject(wxHtmlParser_Parse(wxobj, source));
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ void InitParser(string source)
        {
            wxHtmlParser_InitParser(wxobj, source);
        }

        //-----------------------------------------------------------------------------

        public /+virtual+/ void DoneParser()
        {
            wxHtmlParser_DoneParser(wxobj);
        }

        //-----------------------------------------------------------------------------

        public void StopParsing()
        {
            wxHtmlParser_StopParsing(wxobj);
        }

        //-----------------------------------------------------------------------------

        public void DoParsing(int begin_pos, int end_pos)
        {
            wxHtmlParser_DoParsing(wxobj, begin_pos, end_pos);
        }

        //-----------------------------------------------------------------------------

        public void DoParsing()
        {
            wxHtmlParser_DoParsingAll(wxobj);
        }

        //-----------------------------------------------------------------------------

        public HtmlTag GetCurrentTag()
        {
            return HtmlTag.FindObj(wxHtmlParser_GetCurrentTag(wxobj));
        }

        //-----------------------------------------------------------------------------

        public abstract wxObject Product();

        //-----------------------------------------------------------------------------

        public void AddTagHandler(HtmlTagHandler handler)
        {
            wxHtmlParser_AddTagHandler(wxobj, wxObject.SafePtr(handler));
        }

        //-----------------------------------------------------------------------------

        public void PushTagHandler(HtmlTagHandler handler, string tags)
        {
            wxHtmlParser_PushTagHandler(wxobj, wxObject.SafePtr(handler), tags);
        }

        //-----------------------------------------------------------------------------

        public void PopTagHandler()
        {
            wxHtmlParser_PopTagHandler(wxobj);
        }

        //-----------------------------------------------------------------------------

        public string Source() { return wxHtmlParser_GetSource(wxobj).dup; }
        public void Source(string value) { wxHtmlParser_SetSource(wxobj, value); }

        public void SourceAndSaveState(string value) { wxHtmlParser_SetSourceAndSaveState(wxobj, value); }

        public bool RestoreState()
        {
            return wxHtmlParser_RestoreState(wxobj);
        }

        //-----------------------------------------------------------------------------

        public string ExtractCharsetInformation(string markup)
        {
            return wxHtmlParser_ExtractCharsetInformation(wxobj, markup).dup;
        }
    }

	//-----------------------------------------------------------------------------

        static extern (C) int    wxHtmlProcessor_GetPriority(IntPtr self);
        static extern (C) void   wxHtmlProcessor_Enable(IntPtr self, bool enable);
        static extern (C) bool   wxHtmlProcessor_IsEnabled(IntPtr self);

        //-----------------------------------------------------------------------------

    public abstract class HtmlProcessor : wxObject
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

        //-----------------------------------------------------------------------------

        public abstract string Process(string text);

        //-----------------------------------------------------------------------------

        public int Priority() { return wxHtmlProcessor_GetPriority(wxobj); }

        //-----------------------------------------------------------------------------

        public void Enabled(bool value) { wxHtmlProcessor_Enable(wxobj, value); }
        public bool Enabled() { return wxHtmlProcessor_IsEnabled(wxobj); }
    }
    
	//-----------------------------------------------------------------------------
    
		static extern (C) IntPtr wxHtmlRenderingInfo_ctor();
		static extern (C) void wxHtmlRenderingInfo_dtor(IntPtr self);
		static extern (C) void wxHtmlRenderingInfo_SetSelection(IntPtr self, IntPtr s);
		static extern (C) IntPtr wxHtmlRenderingInfo_GetSelection(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
	public class HtmlRenderingInfo : wxObject
	{
		public this(IntPtr wxobj)
		{	
			super(wxobj);
		}
		
		private this(IntPtr wxobj, bool memOwn)
		{ 
			super(wxobj);
			this.memOwn = memOwn;
		}
			
		public this()
			{ this(wxHtmlRenderingInfo_ctor(), true);}
			
		//---------------------------------------------------------------------
				
		override private void dtor() { wxHtmlRenderingInfo_dtor(wxobj); }
			
		//-----------------------------------------------------------------------------
		
		public HtmlSelection Selection() { return cast(HtmlSelection)FindObject(wxHtmlRenderingInfo_GetSelection(wxobj), &HtmlSelection.New); }
		public void Selection(HtmlSelection value) { wxHtmlRenderingInfo_SetSelection(wxobj, wxObject.SafePtr(value)); }
	}
	
	//-----------------------------------------------------------------------------
	
		static extern (C) IntPtr wxHtmlSelection_ctor();
		static extern (C) void wxHtmlSelection_dtor(IntPtr self);
		static extern (C) void wxHtmlSelection_Set(IntPtr self, inout Point fromPos, IntPtr fromCell, inout Point toPos, IntPtr toCell);
		static extern (C) void wxHtmlSelection_Set2(IntPtr self, IntPtr fromCell, IntPtr toCell);
		static extern (C) IntPtr wxHtmlSelection_GetFromCell(IntPtr self);
		static extern (C) IntPtr wxHtmlSelection_GetToCell(IntPtr self);
		static extern (C) void wxHtmlSelection_GetFromPos(IntPtr self, out Point fromPos);
		static extern (C) void wxHtmlSelection_GetToPos(IntPtr self, out Point toPos);
		static extern (C) void wxHtmlSelection_GetFromPrivPos(IntPtr self, out Point fromPrivPos);
		static extern (C) void wxHtmlSelection_GetToPrivPos(IntPtr self, out Point toPrivPos);
		static extern (C) void wxHtmlSelection_SetFromPrivPos(IntPtr self, inout Point pos);
		static extern (C) void wxHtmlSelection_SetToPrivPos(IntPtr self, inout Point pos);
		static extern (C) void wxHtmlSelection_ClearPrivPos(IntPtr self);
		static extern (C) bool wxHtmlSelection_IsEmpty(IntPtr self);
		
		//-----------------------------------------------------------------------------

	public class HtmlSelection : wxObject
	{
		public this(IntPtr wxobj)
		{
			super(wxobj);
		}
		
		private this(IntPtr wxobj, bool memOwn)
		{ 
			super(wxobj);
			this.memOwn = memOwn;
		}
			
		public this()
			{ this(wxHtmlSelection_ctor(), true);}
			
		public static wxObject New(IntPtr ptr) { return new HtmlSelection(ptr); }
		
		//---------------------------------------------------------------------
				
		override private void dtor() { wxHtmlSelection_dtor(wxobj); }
			
		//-----------------------------------------------------------------------------
		
		public void Set(Point fromPos, HtmlCell fromCell, Point toPos, HtmlCell toCell)
		{
			wxHtmlSelection_Set(wxobj, fromPos, wxObject.SafePtr(fromCell), toPos, wxObject.SafePtr(toCell));
		}
		
		public void Set(HtmlCell fromCell, HtmlCell toCell)
		{
			wxHtmlSelection_Set2(wxobj, wxObject.SafePtr(fromCell), wxObject.SafePtr(toCell));
		}
		
		//-----------------------------------------------------------------------------
		
		public HtmlCell FromCell() { return cast(HtmlCell)FindObject(wxHtmlSelection_GetFromCell(wxobj), &HtmlCell.New); }
		
		public HtmlCell ToCell() { return cast(HtmlCell)FindObject(wxHtmlSelection_GetToCell(wxobj), &HtmlCell.New); }
		
		//-----------------------------------------------------------------------------
		
		public Point FromPos() { 
				Point tpoint;
				wxHtmlSelection_GetFromPos(wxobj, tpoint);
				return tpoint;
			}
		
		public Point ToPos() {
				Point tpoint;
				wxHtmlSelection_GetToPos(wxobj, tpoint);
				return tpoint;
			}
		
		//-----------------------------------------------------------------------------
		
		public Point FromPrivPos() { 
				Point tpoint;
				wxHtmlSelection_GetFromPrivPos(wxobj, tpoint);
				return tpoint;
			}
			
		public void FromPrivPos(Point value) { wxHtmlSelection_SetFromPrivPos(wxobj, value); }
		
		public Point ToPrivPos() {
				Point tpoint;
				wxHtmlSelection_GetToPrivPos(wxobj, tpoint);
				return tpoint;
			}
			
		public void ToPrivPos(Point value) { wxHtmlSelection_SetToPrivPos(wxobj, value); }
		
		//-----------------------------------------------------------------------------
		
		public void ClearPrivPos()
		{
			wxHtmlSelection_ClearPrivPos(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Empty() { return wxHtmlSelection_IsEmpty(wxobj); }
	}
	
	//-----------------------------------------------------------------------------
	
		static extern (C) IntPtr wxHtmlEasyPrinting_ctor(string name, IntPtr parent);
		static extern (C) bool   wxHtmlEasyPrinting_PreviewFile(IntPtr self, string htmlfile);
		static extern (C) bool   wxHtmlEasyPrinting_PreviewText(IntPtr self, string htmltext, string basepath);
		static extern (C) bool   wxHtmlEasyPrinting_PrintFile(IntPtr self, string htmlfile);
		static extern (C) bool   wxHtmlEasyPrinting_PrintText(IntPtr self, string htmltext, string basepath);
		static extern (C) void   wxHtmlEasyPrinting_PrinterSetup(IntPtr self);
		static extern (C) void   wxHtmlEasyPrinting_PageSetup(IntPtr self);
		static extern (C) void   wxHtmlEasyPrinting_SetHeader(IntPtr self, string header, int pg);
		static extern (C) void   wxHtmlEasyPrinting_SetFooter(IntPtr self, string footer, int pg);
		static extern (C) void   wxHtmlEasyPrinting_SetFonts(IntPtr self, string normal_face, string fixed_face, int* sizes);
		static extern (C) void   wxHtmlEasyPrinting_SetStandardFonts(IntPtr self, int size, string normal_face, string fixed_face);
		static extern (C) IntPtr wxHtmlEasyPrinting_GetPrintData(IntPtr self);
		static extern (C) IntPtr wxHtmlEasyPrinting_GetPageSetupData(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
	public class HtmlEasyPrinting : wxObject
	{
		public const int wxPAGE_ODD	= 0;
		public const int wxPAGE_EVEN	= 1;
		public const int wxPAGE_ALL	= 2;
		
		//-----------------------------------------------------------------------------
	
		public this(IntPtr wxobj)
			{ super(wxobj);}
			
		public this()
			{ this("Printing", null);}
			
		public this(string name)
			{ this(name, null);}
			
		public this(string name, Window parentWindow)
			{ super(wxHtmlEasyPrinting_ctor(name, wxObject.SafePtr(parentWindow)));}
			
		//-----------------------------------------------------------------------------
		
		public bool PreviewFile(string htmlfile)
		{
			return wxHtmlEasyPrinting_PreviewFile(wxobj, htmlfile);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool PreviewText(string htmltext)
		{
			return PreviewText(htmltext, "");
		}
		
		public bool PreviewText(string htmltext, string basepath)
		{
			return wxHtmlEasyPrinting_PreviewText(wxobj, htmltext, basepath);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool PrintFile(string htmlfile)
		{
			return wxHtmlEasyPrinting_PrintFile(wxobj, htmlfile);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool PrintText(string htmltext)
		{
			return PrintText(htmltext, "");
		}
		
		public bool PrintText(string htmltext, string basepath)
		{
			return wxHtmlEasyPrinting_PrintText(wxobj, htmltext, basepath);
		}
		
		//-----------------------------------------------------------------------------
		
		public void PrinterSetup()
		{
			wxHtmlEasyPrinting_PrinterSetup(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		public void PageSetup()
		{
			wxHtmlEasyPrinting_PageSetup(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetHeader(string header)
		{
			SetHeader(header, wxPAGE_ALL);
		}
		
		public void SetHeader(string header, int pg)
		{
			wxHtmlEasyPrinting_SetHeader(wxobj, header, pg);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetFooter(string footer)
		{
			SetFooter(footer, wxPAGE_ALL);
		}
		
		public void SetFooter(string footer, int pg)
		{
			wxHtmlEasyPrinting_SetFooter(wxobj, footer, pg);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SetFonts(string normal_face, string fixed_face)
		{
			SetFonts(normal_face, fixed_face, null);
		}
		
		public void SetFonts(string normal_face, string fixed_face, int[] sizes)
		{
			wxHtmlEasyPrinting_SetFonts(wxobj, normal_face, fixed_face, sizes);
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
			wxHtmlEasyPrinting_SetStandardFonts(wxobj, size, normal_face, fixed_face);
		}
		
		//-----------------------------------------------------------------------------
		
		public PrintData printData() { return cast(PrintData)FindObject(wxHtmlEasyPrinting_GetPrintData(wxobj), &PrintData.New); }
		
		//-----------------------------------------------------------------------------
		
		public PageSetupDialogData PageSetupData() { return cast(PageSetupDialogData)FindObject(wxHtmlEasyPrinting_GetPageSetupData(wxobj), &PageSetupDialogData.New); }
	}

	//-----------------------------------------------------------------------------

		extern (C) {
		alias void function(HtmlWindow obj, IntPtr link) Virtual_OnLinkClicked;
		alias void function(HtmlWindow obj, string title) Virtual_OnSetTitle;
		alias void function(HtmlWindow obj, IntPtr cell, int x, int y) Virtual_OnCellMouseHover;
		alias void function(HtmlWindow obj, IntPtr cell, int x, int y, IntPtr mouseevent) Virtual_OnCellClicked;
		alias int function(HtmlWindow obj, int type, string url, string redirect) Virtual_OnOpeningURL;
		}

		//-----------------------------------------------------------------------------

		static extern (C) IntPtr wxHtmlWindow_ctor();
		static extern (C) void   wxHtmlWindow_RegisterVirtual(IntPtr self, HtmlWindow obj, 
			Virtual_OnLinkClicked onLinkClicked,
			Virtual_OnSetTitle onSetTitle,
			Virtual_OnCellMouseHover onCellMouseHover,
			Virtual_OnCellClicked onCellClicked,
			Virtual_OnOpeningURL onOpeningURL);
		static extern (C) bool   wxHtmlWindow_Create(IntPtr self, IntPtr parent, int id, inout Point pos, inout Size size, uint style, string name);
		static extern (C) bool   wxHtmlWindow_SetPage(IntPtr self, string source);
		static extern (C) bool   wxHtmlWindow_AppendToPage(IntPtr self, string source);
		static extern (C) bool   wxHtmlWindow_LoadPage(IntPtr self, string location);
		static extern (C) bool   wxHtmlWindow_LoadFile(IntPtr self, string filename);
		static extern (C) string wxHtmlWindow_GetOpenedPage(IntPtr self);
		static extern (C) string wxHtmlWindow_GetOpenedAnchor(IntPtr self);
		static extern (C) string wxHtmlWindow_GetOpenedPageTitle(IntPtr self);
		static extern (C) void   wxHtmlWindow_SetRelatedFrame(IntPtr self, IntPtr frame, string format);
		static extern (C) IntPtr wxHtmlWindow_GetRelatedFrame(IntPtr self);
		static extern (C) void   wxHtmlWindow_SetRelatedStatusBar(IntPtr self, int bar);
		static extern (C) void   wxHtmlWindow_SetFonts(IntPtr self, string normal_face, string fixed_face, int* sizes);
		static extern (C) void   wxHtmlWindow_SetBorders(IntPtr self, int b);
		static extern (C) void   wxHtmlWindow_ReadCustomization(IntPtr self, IntPtr cfg, string path);
		static extern (C) void   wxHtmlWindow_WriteCustomization(IntPtr self, IntPtr cfg, string path);
		static extern (C) bool   wxHtmlWindow_HistoryBack(IntPtr self);
		static extern (C) bool   wxHtmlWindow_HistoryForward(IntPtr self);
		static extern (C) bool   wxHtmlWindow_HistoryCanBack(IntPtr self);
		static extern (C) bool   wxHtmlWindow_HistoryCanForward(IntPtr self);
		static extern (C) void   wxHtmlWindow_HistoryClear(IntPtr self);
		static extern (C) IntPtr wxHtmlWindow_GetInternalRepresentation(IntPtr self);
		static extern (C) void   wxHtmlWindow_AddFilter(IntPtr filter);
		static extern (C) IntPtr wxHtmlWindow_GetParser(IntPtr self);
		static extern (C) void   wxHtmlWindow_AddProcessor(IntPtr self, IntPtr processor);
		static extern (C) void   wxHtmlWindow_AddGlobalProcessor(IntPtr processor);
		static extern (C) bool   wxHtmlWindow_AcceptsFocusFromKeyboard(IntPtr self);
		static extern (C) void   wxHtmlWindow_OnSetTitle(IntPtr self, string title);
		static extern (C) void   wxHtmlWindow_OnCellClicked(IntPtr self, IntPtr cell, int x, int y, IntPtr evt);
		static extern (C) void   wxHtmlWindow_OnLinkClicked(IntPtr self, IntPtr link);
		static extern (C) int    wxHtmlWindow_OnOpeningURL(IntPtr self, int type, string url, string redirect);
		
		static extern (C) void   wxHtmlWindow_SelectAll(IntPtr self);
		static extern (C) void   wxHtmlWindow_SelectWord(IntPtr self, inout Point pos);
		static extern (C) void   wxHtmlWindow_SelectLine(IntPtr self, inout Point pos);
		
		static extern (C) string wxHtmlWindow_ToText(IntPtr self);
		
		static extern (C) string wxHtmlWindow_SelectionToText(IntPtr self);
		
		//-----------------------------------------------------------------------------

	public class HtmlWindow : ScrolledWindow
	{
		public const int wxHW_SCROLLBAR_NEVER   = 0x0002;
		public const int wxHW_SCROLLBAR_AUTO    = 0x0004;
		public const int wxHW_NO_SELECTION      = 0x0008;

		//-----------------------------------------------------------------------------

		public this(IntPtr  wxobj)
			{ super(wxobj); }

		public this()
			{ super(wxHtmlWindow_ctor()); }
		
		public this(Window parent, int id /*= wxID_ANY*/, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = wxHW_SCROLLBAR_AUTO, string name = "htmlWindow")
		{
			super(wxHtmlWindow_ctor());

			wxHtmlWindow_RegisterVirtual(wxobj, this,
				&staticDoOnLinkClicked,
				&staticDoOnSetTitle,
				&staticDoOnCellMouseHover,
				&staticDoOnCellClicked,
				&staticDoOnOpeningURL
				);

			if (!Create(parent, id, pos, size, style, name)) 
			{
				throw new InvalidOperationException("Failed to create HtmlWindow");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, Point pos = wxDefaultPosition, Size size = wxDefaultSize, int style = wxHW_SCROLLBAR_AUTO, string name = "htmlWindow")
			{ this(parent, Window.UniqueID, pos, size, style, name);}

		//-----------------------------------------------------------------------------

		public bool Create(Window parent, int id, inout Point pos, inout Size size, int style, string name)
		{
			return wxHtmlWindow_Create(wxobj, wxObject.SafePtr(parent), id, pos, size, cast(uint)style, name);
		}

		//-----------------------------------------------------------------------------

		public bool SetPage(string source)
		{
			return wxHtmlWindow_SetPage(wxobj, source);
		}
		
		public bool AppendToPage(string source)
		{
			return wxHtmlWindow_AppendToPage(wxobj, source);
		}

		//-----------------------------------------------------------------------------
		
		public /+virtual+/ bool LoadPage(string location)
		{
			return wxHtmlWindow_LoadPage(wxobj, location);
		}
		
		public bool LoadFile(string filename)
		{
			return wxHtmlWindow_LoadFile(wxobj, filename);
		}
		
		//-----------------------------------------------------------------------------
		
		public string OpenedPage() { return wxHtmlWindow_GetOpenedPage(wxobj).dup; } 
		
		public string OpenedAnchor() { return wxHtmlWindow_GetOpenedAnchor(wxobj).dup; }
		
		public string OpenedPageTitle() { return wxHtmlWindow_GetOpenedPageTitle(wxobj).dup; }
		
		//-----------------------------------------------------------------------------
		
		public void SetRelatedFrame(Frame frame, string format)
		{
			wxHtmlWindow_SetRelatedFrame(wxobj, wxObject.SafePtr(frame), format);
		}
		
		public Frame RelatedFrame() { return cast(Frame)FindObject(wxHtmlWindow_GetRelatedFrame(wxobj), &Frame.New); }
		
		//-----------------------------------------------------------------------------
		
		public void RelatedStatusBar(int value) { wxHtmlWindow_SetRelatedStatusBar(wxobj, value); }
		
		//-----------------------------------------------------------------------------
		
		public void SetFonts(string normal_face, string fixed_face, int[] sizes)
		{
			wxHtmlWindow_SetFonts(wxobj, normal_face, fixed_face, sizes);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Borders(int value) { wxHtmlWindow_SetBorders(wxobj, value); }
		
		//-----------------------------------------------------------------------------
		
		public /+virtual+/ void ReadCustomization(Config cfg, string path)
		{
			wxHtmlWindow_ReadCustomization(wxobj, wxObject.SafePtr(cfg), path);
		}
		
		//-----------------------------------------------------------------------------
		
		public /+virtual+/ void WriteCustomization(Config cfg, string path)
		{
			wxHtmlWindow_WriteCustomization(wxobj, wxObject.SafePtr(cfg), path);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool HistoryBack()
		{
			return wxHtmlWindow_HistoryBack(wxobj);
		}
		
		public bool HistoryForward()
		{
			return wxHtmlWindow_HistoryForward(wxobj);
		}
		
		public bool HistoryCanBack()
		{
			return wxHtmlWindow_HistoryCanBack(wxobj);
		}
		
		public bool HistoryCanForward()
		{
			return wxHtmlWindow_HistoryCanForward(wxobj);
		}
		
		public void HistoryClear()
		{
			wxHtmlWindow_HistoryClear(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		public HtmlContainerCell InternalRepresentation() { return cast(HtmlContainerCell)FindObject(wxHtmlWindow_GetInternalRepresentation(wxobj), &HtmlContainerCell.New); }
		
		//-----------------------------------------------------------------------------
		
		public static void AddFilter(HtmlFilter filter)
		{
			wxHtmlWindow_AddFilter(wxObject.SafePtr(filter));
		}
		
		//-----------------------------------------------------------------------------
		
		public HtmlWinParser Parser() { return cast(HtmlWinParser)FindObject(wxHtmlWindow_GetParser(wxobj), &HtmlWinParser.New); }
		
		//-----------------------------------------------------------------------------
		
		public void AddProcessor(HtmlProcessor processor)
		{
			wxHtmlWindow_AddProcessor(wxobj, wxObject.SafePtr(processor));
		}
		
		public static void AddGlobalProcessor(HtmlProcessor processor)
		{
			wxHtmlWindow_AddGlobalProcessor(wxObject.SafePtr(processor));
		}
		
		//-----------------------------------------------------------------------------
		
		public override bool AcceptsFocusFromKeyboard()
		{
			return wxHtmlWindow_AcceptsFocusFromKeyboard(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		static extern(C) private void staticDoOnSetTitle(HtmlWindow obj, string title)
		{			
			obj.OnSetTitle(title);
		}
		
		public /+virtual+/ void OnSetTitle(string title)
		{
			wxHtmlWindow_OnSetTitle(wxobj, title);
		}
		
		//-----------------------------------------------------------------------------
		
		static extern(C) private void staticDoOnCellMouseHover(HtmlWindow obj, IntPtr cell, int x, int y)
		{
			obj.OnCellMouseHover(new HtmlCell(cell), x, y);
		}
		
		public /+virtual+/ void OnCellMouseHover(HtmlCell cell, int x, int y)
		{
			// Do nothing here
		}
		
		//-----------------------------------------------------------------------------
		
		static extern(C) private void staticDoOnCellClicked(HtmlWindow obj, IntPtr cell, int x, int y, IntPtr mouseevent)
		{
			obj.OnCellClicked(new HtmlCell(cell), x, y, new MouseEvent(mouseevent));
		}
		
		public /+virtual+/ void OnCellClicked(HtmlCell cell, int x, int y, MouseEvent evt)
		{
			wxHtmlWindow_OnCellClicked(wxobj, wxObject.SafePtr(cell), x, y, wxObject.SafePtr(evt));
		}
		
		//-----------------------------------------------------------------------------
		
		static extern(C) private void staticDoOnLinkClicked(HtmlWindow obj, IntPtr link)
		{
			obj.OnLinkClicked(new HtmlLinkInfo(link));
		}
		
		public /+virtual+/ void OnLinkClicked(HtmlLinkInfo link)
		{
			wxHtmlWindow_OnLinkClicked(wxobj, wxObject.SafePtr(link));
		}
		
		//-----------------------------------------------------------------------------
		
		static extern(C) private int staticDoOnOpeningURL(HtmlWindow obj, int type, string url, string redirect)
		{
			return cast(int)obj.OnOpeningURL(cast(HtmlURLType) type, url, redirect);
		}
		
		public HtmlOpeningStatus OnOpeningURL(HtmlURLType type, string url, string redirect)
		{
			return cast(HtmlOpeningStatus)wxHtmlWindow_OnOpeningURL(wxobj, cast(int)type, url, redirect);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SelectAll()
		{
			wxHtmlWindow_SelectAll(wxobj);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SelectLine(Point pos)
		{
			wxHtmlWindow_SelectLine(wxobj, pos);
		}
		
		//-----------------------------------------------------------------------------
		
		public void SelectWord(Point pos)
		{
			wxHtmlWindow_SelectWord(wxobj, pos);
		}
		
		//-----------------------------------------------------------------------------
		
		public string Text() { return wxHtmlWindow_ToText(wxobj).dup; }
		
		//-----------------------------------------------------------------------------
		
		public string SelectionText() { return wxHtmlWindow_SelectionToText(wxobj).dup; }
	}
		
