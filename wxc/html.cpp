//-----------------------------------------------------------------------------
// wxD - html.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - html.cxx
//
// The wxHTML proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/html/htmlwin.h>
#include <wx/html/htmlproc.h>
#include <wx/html/htmprint.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

typedef void (CALLBACK* Virtual_OnLinkClicked) (dobj, wxHtmlLinkInfo* );
typedef void (CALLBACK* Virtual_OnSetTitle) (dobj, dstr );
typedef void (CALLBACK* Virtual_OnCellMouseHover) (dobj, wxHtmlCell*, wxCoord, wxCoord);
typedef void (CALLBACK* Virtual_OnCellClicked) (dobj, wxHtmlCell*, wxCoord, wxCoord, wxMouseEvent*);
typedef wxHtmlOpeningStatus (CALLBACK* Virtual_OnOpeningURL) (dobj, wxHtmlURLType, dstr, dstr);

class _HtmlWindow : public wxHtmlWindow
{
public:
	_HtmlWindow()
		: wxHtmlWindow() {}

	_HtmlWindow(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxString& name)
		: wxHtmlWindow(parent, id, pos, size, style, name) {}

	void OnLinkClicked(const wxHtmlLinkInfo& link)
	{ m_OnLinkClicked(m_dobj, new wxHtmlLinkInfo(link)); }
	
	void OnSetTitle(const wxString& title)
	{ m_OnSetTitle(m_dobj, dstr(title)); }
	
	void OnCellMouseHover(wxHtmlCell* cell, wxCoord x, wxCoord y)
	{ m_OnCellMouseHover(m_dobj, cell, x, y); }
	
	void OnCellClicked(wxHtmlCell* cell, wxCoord x, wxCoord y, const wxMouseEvent& event)
	{ m_OnCellClicked(m_dobj, cell, x, y, new wxMouseEvent(event)); }
	
	wxHtmlOpeningStatus OnOpeningURL(wxHtmlURLType type, const wxString& url, wxString * redirect) const
	{ return m_OnOpeningURL(m_dobj, type, dstr(url), dstr(*redirect)); }

	void RegisterVirtual(dobj obj, Virtual_OnLinkClicked onLinkClicked, 
		Virtual_OnSetTitle onSetTitle,
		Virtual_OnCellMouseHover onCellMouseHover,
		Virtual_OnCellClicked onCellClicked,
		Virtual_OnOpeningURL onOpeningURL)
	{
		m_dobj = obj;
		m_OnLinkClicked = onLinkClicked;
		m_OnSetTitle = onSetTitle;
		m_OnCellMouseHover = onCellMouseHover;
		m_OnCellClicked = onCellClicked;
		m_OnOpeningURL = onOpeningURL;
	}

private:
	Virtual_OnLinkClicked m_OnLinkClicked;
	Virtual_OnSetTitle m_OnSetTitle;
	Virtual_OnCellMouseHover m_OnCellMouseHover;
	Virtual_OnCellClicked m_OnCellClicked;
	Virtual_OnOpeningURL m_OnOpeningURL;
	dobj m_dobj;
	
public:
	DECLARE_OBJECTDELETED(_HtmlWindow)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlWindow* wxHtmlWindow_ctor()
{
    return new _HtmlWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlWindow* wxHtmlWindow_ctor2(wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, long style, dstr name)
{
	return new _HtmlWindow(parent, id, *pos, *size, style, wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_RegisterVirtual(_HtmlWindow* self, dobj obj,
	Virtual_OnLinkClicked onLinkClicked,
	Virtual_OnSetTitle onSetTitle,
	Virtual_OnCellMouseHover onCellMouseHover,
	Virtual_OnCellClicked onCellClicked,
	Virtual_OnOpeningURL onOpeningURL)
{
	self->RegisterVirtual(obj, onLinkClicked, onSetTitle, onCellMouseHover, onCellClicked, onOpeningURL);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_Create(_HtmlWindow* self, wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, long style, dstr name)
{
    return self->Create(parent, id, *pos, *size, style, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_SetPage(_HtmlWindow* self, dstr source)
{
    return self->SetPage(wxstr(source))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_AppendToPage(_HtmlWindow* self, dstr source)
{
    return self->AppendToPage(wxstr(source))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_LoadPage(_HtmlWindow* self, dstr location)
{
    return self->LoadPage(wxstr(location))?1:0;
}

//-----------------------------------------------------------------------------
// FIXME??: LoadFile uses wxFileName not wxString
extern "C" WXEXPORT
dbit wxHtmlWindow_LoadFile(_HtmlWindow* self, dstr filename)
{
    return self->LoadFile(wxstr(filename))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlWindow_GetOpenedPage(_HtmlWindow* self)
{
    return dstr_ret(self->GetOpenedPage());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlWindow_GetOpenedAnchor(_HtmlWindow* self)
{
    return dstr_ret(self->GetOpenedAnchor());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlWindow_GetOpenedPageTitle(_HtmlWindow* self)
{
    return dstr_ret(self->GetOpenedPageTitle());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SetRelatedFrame(_HtmlWindow* self, wxFrame* frame, dstr format)
{
    self->SetRelatedFrame(frame, wxstr(format));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFrame* wxHtmlWindow_GetRelatedFrame(_HtmlWindow* self)
{
    return self->GetRelatedFrame();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SetRelatedStatusBar(_HtmlWindow* self, int bar)
{
    self->SetRelatedStatusBar(bar);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SetFonts(_HtmlWindow* self, dstr normal_face, dstr fixed_face, int* sizes)
{
    self->SetFonts(wxstr(normal_face), wxstr(fixed_face), sizes);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SetBorders(_HtmlWindow* self, int b)
{
    self->SetBorders(b);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_ReadCustomization(_HtmlWindow* self, wxConfigBase* cfg, dstr path)
{
    self->ReadCustomization(cfg, wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_WriteCustomization(_HtmlWindow* self, wxConfigBase* cfg, dstr path)
{
    self->WriteCustomization(cfg, wxstr(path));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_HistoryBack(_HtmlWindow* self)
{
    return self->HistoryBack()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_HistoryForward(_HtmlWindow* self)
{
    return self->HistoryForward()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_HistoryCanBack(_HtmlWindow* self)
{
    return self->HistoryCanBack()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_HistoryCanForward(_HtmlWindow* self)
{
    return self->HistoryCanForward()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_HistoryClear(_HtmlWindow* self)
{
    self->HistoryClear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlContainerCell* wxHtmlWindow_GetInternalRepresentation(_HtmlWindow* self)
{
    return self->GetInternalRepresentation();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_AddFilter(wxHtmlFilter* filter)
{
    wxHtmlWindow::AddFilter(filter);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlWinParser* wxHtmlWindow_GetParser(_HtmlWindow* self)
{
    return self->GetParser();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_AddProcessor(_HtmlWindow* self, wxHtmlProcessor* processor)
{
    self->AddProcessor(processor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_AddGlobalProcessor(wxHtmlProcessor* processor)
{
    wxHtmlWindow::AddGlobalProcessor(processor);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlWindow_AcceptsFocusFromKeyboard(_HtmlWindow* self)
{
    return self->AcceptsFocusFromKeyboard()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_OnSetTitle(_HtmlWindow* self, dstr title)
{
    self->wxHtmlWindow::OnSetTitle(wxstr(title));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_OnCellClicked(_HtmlWindow* self, wxHtmlCell* cell, wxCoord x, wxCoord y, wxMouseEvent* event)
{
#if wxABI_VERSION < 20700
    self->wxHtmlWindow::OnCellClicked(cell, x, y, *event);
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_OnLinkClicked(_HtmlWindow* self, wxHtmlLinkInfo* link)
{
	self->wxHtmlWindow::OnLinkClicked(*link);
} 

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlOpeningStatus wxHtmlWindow_OnOpeningURL(_HtmlWindow* self, wxHtmlURLType type, dstr url, dstr redirect)
{
	wxString wxredirect = wxstr(redirect);
	return self->wxHtmlWindow::OnOpeningURL(type, wxstr(url), &wxredirect);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SelectAll(_HtmlWindow* self)
{
	self->SelectAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SelectWord(_HtmlWindow* self, wxPoint* pos)
{
	self->SelectWord(*pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SelectLine(_HtmlWindow* self, wxPoint* pos)
{
	self->SelectLine(*pos);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlWindow_ToText(_HtmlWindow* self)
{
	return dstr_ret(self->ToText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlWindow_SelectionToText(_HtmlWindow* self)
{
	return dstr_ret(self->SelectionToText());
}

//-----------------------------------------------------------------------------

// TODO

extern "C" WXEXPORT
wxHtmlFontCell* wxHtmlFontCell_ctor(wxFont* font)
{
    return new wxHtmlFontCell(font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlFontCell_Draw(wxHtmlFontCell* self, wxDC* dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo* info)
{
    self->Draw(*dc, x, y, view_y1, view_y2, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlFontCell_DrawInvisible(wxHtmlFontCell* self, wxDC* dc, int x, int y, wxHtmlRenderingInfo* info)
{
    self->DrawInvisible(*dc, x, y, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlColourCell* wxHtmlColourCell_ctor(wxColour* clr, int flags)
{
    return new wxHtmlColourCell(*clr, flags);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlColourCell_Draw(wxHtmlColourCell* self, wxDC* dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo* info)
{
    self->Draw(*dc, x, y, view_y1, view_y2, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlColourCell_DrawInvisible(wxHtmlColourCell* self, wxDC* dc, int x, int y, wxHtmlRenderingInfo* info)
{
    self->DrawInvisible(*dc, x, y, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlLinkInfo* wxHtmlLinkInfo_ctor()
{
    return new wxHtmlLinkInfo();
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
wxHtmlLinkInfo* wxHtmlLinkInfo_ctor(dstr href, dstr target)
{
    if (target == NULL)
        target = &wxEmptyString;

    return new wxHtmlLinkInfo(wxstr(href), wxstr(target));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlLinkInfo* wxHtmlLinkInfo_ctor(wxHtmlLinkInfo* l)
{
    return new wxHtmlLinkInfo(*l);
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlLinkInfo_SetEvent(wxHtmlLinkInfo* self, wxMouseEvent* e)
{
    self->SetEvent(e);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlLinkInfo_SetHtmlCell(wxHtmlLinkInfo* self, wxHtmlCell* e)
{
    self->SetHtmlCell(e);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlLinkInfo_GetHref(wxHtmlLinkInfo* self)
{
    return dstr_ret(self->GetHref());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlLinkInfo_GetTarget(wxHtmlLinkInfo* self)
{
    return dstr_ret(self->GetTarget());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxMouseEvent* wxHtmlLinkInfo_GetEvent(wxHtmlLinkInfo* self)
{
    return self->GetEvent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxHtmlCell* wxHtmlLinkInfo_GetHtmlCell(wxHtmlLinkInfo* self)
{
    return self->GetHtmlCell();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlWidgetCell* wxHtmlWidgetCell_ctor(wxWindow* wnd, int w)
{
    return new wxHtmlWidgetCell(wnd, w);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWidgetCell_Draw(wxHtmlWidgetCell* self, wxDC* dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo* info)
{
    self->Draw(*dc, x, y, view_y1, view_y2, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWidgetCell_DrawInvisible(wxHtmlWidgetCell* self, wxDC* dc, int x, int y, wxHtmlRenderingInfo* info)
{
    self->DrawInvisible(*dc, x, y, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWidgetCell_Layout(wxHtmlWidgetCell* self, int w)
{
    self->Layout(w);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlCell* wxHtmlCell_ctor()
{
    return new wxHtmlCell();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetParent(wxHtmlCell* self, wxHtmlContainerCell* p)
{
    self->SetParent(p);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlContainerCell* wxHtmlCell_GetParent(wxHtmlCell* self)
{
    return self->GetParent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlCell_GetPosX(wxHtmlCell* self)
{
    return self->GetPosX();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlCell_GetPosY(wxHtmlCell* self)
{
    return self->GetPosY();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlCell_GetWidth(wxHtmlCell* self)
{
    return self->GetWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlCell_GetHeight(wxHtmlCell* self)
{
    return self->GetHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlCell_GetDescent(wxHtmlCell* self)
{
    return self->GetDescent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlCell_GetId(wxHtmlCell* self)
{
    return dstr_ret(self->GetId());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetId(wxHtmlCell* self, dstr id)
{
    self->SetId(wxstr(id));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlCell* wxHtmlCell_GetNext(wxHtmlCell* self)
{
    return self->GetNext();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetPos(wxHtmlCell* self, int x, int y)
{
    self->SetPos(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetLink(wxHtmlCell* self, wxHtmlLinkInfo* link)
{
    self->SetLink(*link);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetNext(wxHtmlCell* self, wxHtmlCell* cell)
{
    self->SetNext(cell);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_Layout(wxHtmlCell* self, int w)
{
    self->Layout(w);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_Draw(wxHtmlCell* self, wxDC* dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo* info)
{
    self->Draw(*dc, x, y, view_y1, view_y2, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_DrawInvisible(wxHtmlCell* self, wxDC* dc, int x, int y, wxHtmlRenderingInfo* info)
{
    self->DrawInvisible(*dc, x, y, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxHtmlCell* wxHtmlCell_Find(wxHtmlCell* self, int condition, void* param)
{
    return self->Find(condition, param);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_OnMouseClick(wxHtmlCell* self, wxWindow* parent, int x, int y, wxMouseEvent* event)
{
    self->OnMouseClick(parent, x, y, *event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlCell_AdjustPagebreak(wxHtmlCell* self, int* pagebreak)
{
#if wxABI_VERSION < 20700
    return self->AdjustPagebreak(pagebreak)?1:0;
#else
    wxArrayInt ai;
    return self->AdjustPagebreak(pagebreak, ai)?1:0;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetCanLiveOnPagebreak(wxHtmlCell* self, dbit can)
{
    self->SetCanLiveOnPagebreak(can);
}

//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
void wxHtmlCell_GetHorizontalConstraints(wxHtmlCell* self, int* left, int* right)
{
    self->GetHorizontalConstraints(left, right);
}
*/
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlCell_IsTerminalCell(wxHtmlCell* self)
{
    return self->IsTerminalCell()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlCell* wxHtmlCell_FindCellByPos(wxHtmlCell* self, wxCoord x, wxCoord y)
{
    return self->FindCellByPos(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlWordCell* wxHtmlWordCell_ctor(dstr word, wxDC* dc)
{
    return new wxHtmlWordCell(wxstr(word), *dc);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWordCell_Draw(wxHtmlWordCell* self, wxDC* dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo* info)
{
    self->Draw(*dc, x, y, view_y1, view_y2, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlContainerCell* wxHtmlContainerCell_ctor(wxHtmlContainerCell* parent)
{
    return new wxHtmlContainerCell(parent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_Layout(wxHtmlContainerCell* self, int w)
{
    self->Layout(w);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_Draw(wxHtmlContainerCell* self, wxDC* dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo* info)
{
    self->Draw(*dc, x, y, view_y1, view_y2, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_DrawInvisible(wxHtmlContainerCell* self, wxDC* dc, int x, int y, wxHtmlRenderingInfo* info)
{
    self->DrawInvisible(*dc, x, y, *info);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlContainerCell_AdjustPagebreak(wxHtmlContainerCell* self, int* pagebreak)
{
#if wxABI_VERSION < 20700
    return self->AdjustPagebreak(pagebreak)?1:0;
#else
    wxArrayInt ai;
    return self->AdjustPagebreak(pagebreak, ai)?1:0;
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_InsertCell(wxHtmlContainerCell* self, wxHtmlCell* cell)
{
    self->InsertCell(cell);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetAlignHor(wxHtmlContainerCell* self, int al)
{
    self->SetAlignHor(al);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlContainerCell_GetAlignHor(wxHtmlContainerCell* self)
{
    return self->GetAlignHor();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetAlignVer(wxHtmlContainerCell* self, int al)
{
    self->SetAlignVer(al);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlContainerCell_GetAlignVer(wxHtmlContainerCell* self)
{
    return self->GetAlignVer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetIndent(wxHtmlContainerCell* self, int i, int what, int units)
{
    self->SetIndent(i, what, units);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlContainerCell_GetIndent(wxHtmlContainerCell* self, int ind)
{
    return self->GetIndent(ind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlContainerCell_GetIndentUnits(wxHtmlContainerCell* self, int ind)
{
    return self->GetIndentUnits(ind);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetAlign(wxHtmlContainerCell* self, wxHtmlTag* tag)
{
    self->SetAlign(*tag);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetWidthFloat(wxHtmlContainerCell* self, int w, int units)
{
    self->SetWidthFloat(w, units);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetWidthFloatTag(wxHtmlContainerCell* self, wxHtmlTag* tag, double pixel_scale)
{
    self->SetWidthFloat(*tag, pixel_scale);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetMinHeight(wxHtmlContainerCell* self, int h, int align)
{
    self->SetMinHeight(h, align);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetBackgroundColour(wxHtmlContainerCell* self, wxColour* clr)
{
    self->SetBackgroundColour(*clr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxHtmlContainerCell_GetBackgroundColour(wxHtmlContainerCell* self)
{
    return new wxColour(self->GetBackgroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_SetBorder(wxHtmlContainerCell* self, wxColour* clr1, wxColour* clr2)
{
    self->SetBorder(*clr1, *clr2);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlLinkInfo* wxHtmlContainerCell_GetLink(wxHtmlContainerCell* self, int x, int y)
{
    return self->GetLink(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxHtmlCell* wxHtmlContainerCell_Find(wxHtmlContainerCell* self, int condition, void* param)
{
    return self->Find(condition, param);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlContainerCell_OnMouseClick(wxHtmlContainerCell* self, wxWindow* parent, int x, int y, wxMouseEvent* event)
{
    self->OnMouseClick(parent, x, y, *event);
}

//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
void wxHtmlContainerCell_GetHorizontalConstraints(wxHtmlContainerCell* self, int* left, int* right)
{
    self->GetHorizontalConstraints(left, right);
}
*/
//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
wxHtmlCell* wxHtmlContainerCell_GetFirstCell(wxHtmlContainerCell* self)
{
    return self->GetFirstCell();
}
*/
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlContainerCell_IsTerminalCell(wxHtmlContainerCell* self)
{
    return self->IsTerminalCell()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlCell* wxHtmlContainerCell_FindCellByPos(wxHtmlContainerCell* self, wxCoord x, wxCoord y)
{
    return self->FindCellByPos(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlTag_GetParent(wxHtmlTag* self)
{
    return self->GetParent();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlTag_GetFirstSibling(wxHtmlTag* self)
{
    return self->GetFirstSibling();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlTag_GetLastSibling(wxHtmlTag* self)
{
    return self->GetLastSibling();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlTag_GetChildren(wxHtmlTag* self)
{
    return self->GetChildren();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlTag_GetPreviousSibling(wxHtmlTag* self)
{
    return self->GetPreviousSibling();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlTag_GetNextSibling(wxHtmlTag* self)
{
    return self->GetNextSibling();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlTag_GetNextTag(wxHtmlTag* self)
{
    return self->GetNextTag();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlTag_GetName(wxHtmlTag* self)
{
    return dstr_ret(self->GetName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlTag_HasParam(wxHtmlTag* self, dstr par)
{
    return self->HasParam(wxstr(par))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlTag_GetParam(wxHtmlTag* self, dstr par, dbit with_commas)
{
    return dstr_ret(self->GetParam(wxstr(par), with_commas));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlTag_GetParamAsColour(wxHtmlTag* self, dstr par, wxColour* clr)
{
    return self->GetParamAsColour(wxstr(par), clr)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlTag_GetParamAsInt(wxHtmlTag* self, dstr par, int* clr)
{
    return self->GetParamAsInt(wxstr(par), clr)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlTag_ScanParam(wxHtmlTag* self, dstr par, dstr format, void* param)
{
	wxString wxformat = wxstr(format);
    return self->ScanParam(wxstr(par), wxformat.c_str(), param);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlTag_GetAllParams(wxHtmlTag* self)
{
    return dstr_ret(self->GetAllParams());
}

//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
dbit wxHtmlTag_IsEnding(wxHtmlTag* self)
{
    return self->IsEnding();
}
*/
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlTag_HasEnding(wxHtmlTag* self)
{
    return self->HasEnding()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlTag_GetBeginPos(wxHtmlTag* self)
{
    return self->GetBeginPos();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlTag_GetEndPos1(wxHtmlTag* self)
{
    return self->GetEndPos1();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlTag_GetEndPos2(wxHtmlTag* self)
{
    return self->GetEndPos2();
}

//-----------------------------------------------------------------------------
// wxHtmlFilter

extern "C" WXEXPORT
dbit wxHtmlFilter_CanRead(wxHtmlFilter* self, wxFSFile* file)
{
    return self->CanRead(*file)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlFilter_ReadFile(wxHtmlFilter* self, wxFSFile* file)
{
	wxString str = self->ReadFile(*file);
	return dstr_ret(str);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlFilterPlainText_CanRead(wxHtmlFilterPlainText* self, wxFSFile* file)
{
    return self->CanRead(*file)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlFilterPlainText_ReadFile(wxHtmlFilterPlainText* self, wxFSFile* file)
{
	wxString str = self->ReadFile(*file);
    return dstr_ret(str);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlFilterHTML_CanRead(wxHtmlFilterHTML* self, wxFSFile* file)
{
    return self->CanRead(*file)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlFilterHTML_ReadFile(wxHtmlFilterHTML* self, wxFSFile* file)
{
	wxString str = self->ReadFile(*file);
    return dstr_ret(str);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTagsModule* wxHtmlTagsModule_ctor()
{
    return new wxHtmlTagsModule();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlTagsModule_OnInit(wxHtmlTagsModule* self)
{
    return self->OnInit()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlTagsModule_OnExit(wxHtmlTagsModule* self)
{
    self->OnExit();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlTagsModule_FillHandlersTable(wxHtmlTagsModule* self, wxHtmlWinParser * parser)
{
    self->FillHandlersTable(parser);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlWinParser* wxHtmlWinParser_ctor(wxHtmlWindow* wnd)
{
    return new wxHtmlWinParser(wnd);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_InitParser(wxHtmlWinParser* self, dstr source)
{
    self->InitParser(wxstr(source));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_DoneParser(wxHtmlWinParser* self)
{
    self->DoneParser();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxHtmlWinParser_GetProduct(wxHtmlWinParser* self)
{
    return self->GetProduct();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFSFile* wxHtmlWinParser_OpenURL(wxHtmlWinParser* self, wxHtmlURLType type, dstr url)
{
    return self->OpenURL(type, wxstr(url));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetDC(wxHtmlWinParser* self, wxDC* dc, double pixel_scale)
{
    self->SetDC(dc, pixel_scale);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDC* wxHtmlWinParser_GetDC(wxHtmlWinParser* self)
{
    return self->GetDC();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
double wxHtmlWinParser_GetPixelScale(wxHtmlWinParser* self)
{
    return self->GetPixelScale();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetCharHeight(wxHtmlWinParser* self)
{
    return self->GetCharHeight();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetCharWidth(wxHtmlWinParser* self)
{
    return self->GetCharWidth();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlWindow* wxHtmlWinParser_GetWindow(wxHtmlWinParser* self)
{
#if wxABI_VERSION < 20700
    return self->GetWindow();
#else
    return self->GetWindowInterface()->GetHTMLWindow();
#endif
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFonts(wxHtmlWinParser* self, dstr normal_face, dstr fixed_face, int* sizes)
{
    self->SetFonts(wxstr(normal_face), wxstr(fixed_face), sizes);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_AddModule(wxHtmlWinParser* self, wxHtmlTagsModule* module)
{
    self->AddModule(module);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_RemoveModule(wxHtmlWinParser* self, wxHtmlTagsModule* module)
{
    self->RemoveModule(module);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlContainerCell* wxHtmlWinParser_GetContainer(wxHtmlWinParser* self)
{
    return self->GetContainer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlContainerCell* wxHtmlWinParser_OpenContainer(wxHtmlWinParser* self)
{
    return self->OpenContainer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlContainerCell* wxHtmlWinParser_SetContainer(wxHtmlWinParser* self, wxHtmlContainerCell* c)
{
    return self->SetContainer(c);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlContainerCell* wxHtmlWinParser_CloseContainer(wxHtmlWinParser* self)
{
    return self->CloseContainer();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetFontSize(wxHtmlWinParser* self)
{
    return self->GetFontSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFontSize(wxHtmlWinParser* self, int s)
{
    self->SetFontSize(s);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetFontBold(wxHtmlWinParser* self)
{
    return self->GetFontBold();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFontBold(wxHtmlWinParser* self, int x)
{
    self->SetFontBold(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetFontItalic(wxHtmlWinParser* self)
{
    return self->GetFontItalic();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFontItalic(wxHtmlWinParser* self, int x)
{
    self->SetFontItalic(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetFontUnderlined(wxHtmlWinParser* self)
{
    return self->GetFontUnderlined();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFontUnderlined(wxHtmlWinParser* self, int x)
{
    self->SetFontUnderlined(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetFontFixed(wxHtmlWinParser* self)
{
    return self->GetFontFixed();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFontFixed(wxHtmlWinParser* self, int x)
{
    self->SetFontFixed(x);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlWinParser_GetFontFace(wxHtmlWinParser* self)
{
    return dstr_ret(self->GetFontFace());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFontFace(wxHtmlWinParser* self, dstr face)
{
    self->SetFontFace(wxstr(face));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlWinParser_GetAlign(wxHtmlWinParser* self)
{
    return self->GetAlign();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetAlign(wxHtmlWinParser* self, int a)
{
    self->SetAlign(a);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxHtmlWinParser_GetLinkColor(wxHtmlWinParser* self)
{
    return new wxColour(self->GetLinkColor());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetLinkColor(wxHtmlWinParser* self, wxColour* clr)
{
    self->SetLinkColor(*clr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxHtmlWinParser_GetActualColor(wxHtmlWinParser* self)
{
    return new wxColour(self->GetActualColor());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetActualColor(wxHtmlWinParser* self, wxColour* clr)
{
    self->SetActualColor(*clr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
const wxHtmlLinkInfo* wxHtmlWinParser_GetLink(wxHtmlWinParser* self)
{
    return &(self->GetLink());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetLink(wxHtmlWinParser* self, wxHtmlLinkInfo* link)
{
    self->SetLink(*link);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxHtmlWinParser_CreateCurrentFont(wxHtmlWinParser* self)
{
    return self->CreateCurrentFont();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlTagHandler_SetParser(wxHtmlTagHandler* self, wxHtmlParser* parser)
{
    self->SetParser(parser);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlTagHandler_HandleTag(wxHtmlTagHandler* self, wxHtmlTag* tag)
{
    return self->HandleTag(*tag)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlEntitiesParser* wxHtmlEntitiesParser_ctor()
{
    return new wxHtmlEntitiesParser();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEntitiesParser_dtor(wxHtmlEntitiesParser* self)
{
    delete self;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEntitiesParser_SetEncoding(wxHtmlEntitiesParser* self, wxFontEncoding encoding)
{
    self->SetEncoding(encoding);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlEntitiesParser_Parse(wxHtmlEntitiesParser* self, dstr input)
{
    return dstr_ret(self->Parse(wxstr(input)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
char wxHtmlEntitiesParser_GetEntityChar(wxHtmlEntitiesParser* self, dstr entity)
{
    return (char)self->GetEntityChar(wxstr(entity));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
char wxHtmlEntitiesParser_GetCharForCode(wxHtmlEntitiesParser* self, unsigned code)
{
    return self->GetCharForCode(code);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_SetFS(wxHtmlParser* self, wxFileSystem* fs)
{
    self->SetFS(fs);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFileSystem* wxHtmlParser_GetFS(wxHtmlParser* self)
{
    return self->GetFS();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFSFile* wxHtmlParser_OpenURL(wxHtmlParser* self, wxHtmlURLType type, dstr url)
{
    return self->OpenURL(type, wxstr(url));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxHtmlParser_Parse(wxHtmlParser* self, dstr source)
{
    return self->Parse(wxstr(source));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_InitParser(wxHtmlParser* self, dstr source)
{
    self->InitParser(wxstr(source));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_DoneParser(wxHtmlParser* self)
{
    self->DoneParser();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_StopParsing(wxHtmlParser* self)
{
    self->StopParsing();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_DoParsing(wxHtmlParser* self, int begin_pos, int end_pos)
{
    self->DoParsing(begin_pos, end_pos);
}

extern "C" WXEXPORT
void wxHtmlParser_DoParsingAll(wxHtmlParser* self)
{
    self->DoParsing();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTag* wxHtmlParser_GetCurrentTag(wxHtmlParser* self)
{
    return self->GetCurrentTag();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxHtmlParser_GetProduct(wxHtmlParser* self)
{
    return self->GetProduct();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_AddTagHandler(wxHtmlParser* self, wxHtmlTagHandler* handler)
{
    self->AddTagHandler(handler);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_PushTagHandler(wxHtmlParser* self, wxHtmlTagHandler* handler, dstr tags)
{
    self->PushTagHandler(handler, wxstr(tags));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_PopTagHandler(wxHtmlParser* self)
{
    self->PopTagHandler();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlParser_GetSource(wxHtmlParser* self)
{
	wxString *src = self->GetSource();
    return dstr_ret(*src);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_SetSource(wxHtmlParser* self, dstr src)
{
    self->SetSource(wxstr(src));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_SetSourceAndSaveState(wxHtmlParser* self, dstr src)
{
    self->SetSourceAndSaveState(wxstr(src));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlParser_RestoreState(wxHtmlParser* self)
{
    return self->RestoreState()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlParser_ExtractCharsetInformation(wxHtmlParser* self, dstr markup)
{
    return dstr_ret(self->ExtractCharsetInformation(wxstr(markup)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlProcessor_GetPriority(wxHtmlProcessor* self)
{
    return self->GetPriority();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlProcessor_Enable(wxHtmlProcessor* self, dbit enable)
{
    self->Enable(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlProcessor_IsEnabled(wxHtmlProcessor* self)
{
    return self->IsEnabled()?1:0;
}

//-----------------------------------------------------------------------------
// wxHtmlRenderingInfo > 2.5.1

extern "C" WXEXPORT
wxHtmlRenderingInfo* wxHtmlRenderingInfo_ctor()
{
	return new wxHtmlRenderingInfo();
}

extern "C" WXEXPORT
void wxHtmlRenderingInfo_dtor(wxHtmlRenderingInfo* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxHtmlRenderingInfo_SetSelection(wxHtmlRenderingInfo* self, wxHtmlSelection* s)
{
	self->SetSelection(s);
}

extern "C" WXEXPORT
wxHtmlSelection* wxHtmlRenderingInfo_GetSelection(wxHtmlRenderingInfo* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------
// wxHtmlSelection > 2.5.1

extern "C" WXEXPORT
wxHtmlSelection* wxHtmlSelection_ctor()
{
	return new wxHtmlSelection();
}

extern "C" WXEXPORT
void wxHtmlSelection_dtor(wxHtmlSelection* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxHtmlSelection_Set(wxHtmlSelection* self, wxPoint* fromPos, wxHtmlCell* fromCell, wxPoint* toPos, wxHtmlCell* toCell)
{
	self->Set(*fromPos, fromCell, *toPos, toCell);
}

extern "C" WXEXPORT
void wxHtmlSelection_Set2(wxHtmlSelection* self, wxHtmlCell* fromCell, wxHtmlCell* toCell)
{
	self->Set(fromCell, toCell);
}

extern "C" WXEXPORT
const wxHtmlCell* wxHtmlSelection_GetFromCell(wxHtmlSelection* self)
{
	return self->GetFromCell();
}

extern "C" WXEXPORT
const wxHtmlCell* wxHtmlSelection_GetToCell(wxHtmlSelection* self)
{
	return self->GetToCell();
}

extern "C" WXEXPORT
void wxHtmlSelection_GetFromPos(wxHtmlSelection* self, wxPoint* fromPos)
{
	fromPos = new wxPoint(self->GetFromPos());
}

extern "C" WXEXPORT
void wxHtmlSelection_GetToPos(wxHtmlSelection* self, wxPoint* toPos)
{
	toPos = new wxPoint(self->GetToPos());
}

extern "C" WXEXPORT
void wxHtmlSelection_GetFromPrivPos(wxHtmlSelection* self, wxPoint* fromPrivPos)
{
	fromPrivPos = new wxPoint(self->GetFromPrivPos());
}

extern "C" WXEXPORT
void wxHtmlSelection_GetToPrivPos(wxHtmlSelection* self, wxPoint* toPrivPos)
{
	toPrivPos = new wxPoint(self->GetToPrivPos());
}

extern "C" WXEXPORT
void wxHtmlSelection_SetFromPrivPos(wxHtmlSelection* self, wxPoint* pos)
{
	self->SetFromPrivPos(*pos);
}

extern "C" WXEXPORT
void wxHtmlSelection_SetToPrivPos(wxHtmlSelection* self, wxPoint* pos)
{
	self->SetToPrivPos(*pos);
}

extern "C" WXEXPORT
void wxHtmlSelection_ClearPrivPos(wxHtmlSelection* self)
{
	self->ClearPrivPos();
}

extern "C" WXEXPORT
dbit wxHtmlSelection_IsEmpty(wxHtmlSelection* self)
{
	return self->IsEmpty()?1:0;
}

//-----------------------------------------------------------------------------
// wxHtmlEasyPrinting

extern "C" WXEXPORT
wxHtmlEasyPrinting* wxHtmlEasyPrinting_ctor(dstr name, wxWindow* parent)
{
	return new wxHtmlEasyPrinting(wxstr(name), parent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlEasyPrinting_PreviewFile(wxHtmlEasyPrinting* self, dstr htmlfile)
{
	return self->PreviewFile(wxstr(htmlfile))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlEasyPrinting_PreviewText(wxHtmlEasyPrinting* self, dstr htmltext, dstr basepath)
{
	return self->PreviewText(wxstr(htmltext), wxstr(basepath))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlEasyPrinting_PrintFile(wxHtmlEasyPrinting* self, dstr htmlfile)
{
	return self->PrintFile(wxstr(htmlfile))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dbit wxHtmlEasyPrinting_PrintText(wxHtmlEasyPrinting* self, dstr htmltext, dstr basepath)
{
	return self->PrintText(wxstr(htmltext), wxstr(basepath))?1:0;
}

//-----------------------------------------------------------------------------

/*extern "C" WXEXPORT
void wxHtmlEasyPrinting_PrinterSetup(wxHtmlEasyPrinting* self)
{
	self->PrinterSetup();
}*/

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_PageSetup(wxHtmlEasyPrinting* self)
{
	self->PageSetup();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetHeader(wxHtmlEasyPrinting* self, dstr header, int pg)
{
	self->SetHeader(wxstr(header), pg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetFooter(wxHtmlEasyPrinting* self, dstr footer, int pg)
{
	self->SetFooter(wxstr(footer), pg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetFonts(wxHtmlEasyPrinting* self, dstr normal_face, dstr fixed_face, int* sizes)
{
	self->SetFonts(wxstr(normal_face), wxstr(fixed_face), sizes);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetStandardFonts(wxHtmlEasyPrinting* self, int size, dstr normal_face, dstr fixed_face)
{
	self->SetStandardFonts(size, wxstr(normal_face), wxstr(fixed_face));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPrintData* wxHtmlEasyPrinting_GetPrintData(wxHtmlEasyPrinting* self)
{
	return self->GetPrintData();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxPageSetupDialogData* wxHtmlEasyPrinting_GetPageSetupData(wxHtmlEasyPrinting* self)
{
	return self->GetPageSetupData();
}

