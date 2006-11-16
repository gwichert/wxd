//-----------------------------------------------------------------------------
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
#include <wx/html/htmlwin.h>
#include <wx/html/htmlproc.h>
#include <wx/html/htmprint.h>
#include "local_events.h"

#if defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif

//-----------------------------------------------------------------------------

typedef void (CALLBACK* Virtual_OnLinkClicked) (wxHtmlLinkInfo* );
typedef void (CALLBACK* Virtual_OnSetTitle) (wxString* );
typedef void (CALLBACK* Virtual_OnCellMouseHover) (wxHtmlCell*, wxCoord, wxCoord);
typedef void (CALLBACK* Virtual_OnCellClicked) (wxHtmlCell*, wxCoord, wxCoord, wxMouseEvent*);
typedef wxHtmlOpeningStatus (CALLBACK* Virtual_OnOpeningURL) (wxHtmlURLType, wxString*, wxString*);

class _HtmlWindow : public wxHtmlWindow
{
public:
	_HtmlWindow()
		: wxHtmlWindow() {}

	_HtmlWindow(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxString& name)
		: wxHtmlWindow(parent, id, pos, size, style, name) {}

	void OnLinkClicked(const wxHtmlLinkInfo& link)
	{ m_OnLinkClicked(new wxHtmlLinkInfo(link)); }
	
	void OnSetTitle(const wxString& title)
	{ m_OnSetTitle(new wxString(title)); }
	
	void OnCellMouseHover(wxHtmlCell* cell, wxCoord x, wxCoord y)
	{ m_OnCellMouseHover(cell, x, y); }
	
	void OnCellClicked(wxHtmlCell* cell, wxCoord x, wxCoord y, const wxMouseEvent& event)
	{ m_OnCellClicked(cell, x, y, new wxMouseEvent(event)); }
	
	wxHtmlOpeningStatus OnOpeningURL(wxHtmlURLType type, const wxString& url, wxString * redirect) const
	{ return m_OnOpeningURL(type, new wxString(url), redirect); }

	void RegisterVirtual(Virtual_OnLinkClicked onLinkClicked, 
		Virtual_OnSetTitle onSetTitle,
		Virtual_OnCellMouseHover onCellMouseHover,
		Virtual_OnCellClicked onCellClicked,
		Virtual_OnOpeningURL onOpeningURL)
	{
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
wxHtmlWindow* wxHtmlWindow_ctor2(wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, long style, char* name)
{
	return new _HtmlWindow(parent, id, *pos, *size, style, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_RegisterVirtual(_HtmlWindow* self, 
	Virtual_OnLinkClicked onLinkClicked,
	Virtual_OnSetTitle onSetTitle,
	Virtual_OnCellMouseHover onCellMouseHover,
	Virtual_OnCellClicked onCellClicked,
	Virtual_OnOpeningURL onOpeningURL)
{
	self->RegisterVirtual(onLinkClicked, onSetTitle, onCellMouseHover, onCellClicked, onOpeningURL);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_Create(_HtmlWindow* self, wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, long style, char* name)
{
    return self->Create(parent, id, *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_SetPage(_HtmlWindow* self, const char* source)
{
    return self->SetPage(wxString(source, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_AppendToPage(_HtmlWindow* self, const char* source)
{
    return self->AppendToPage(wxString(source, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_LoadPage(_HtmlWindow* self, const char* location)
{
    return self->LoadPage(wxString(location, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------
// FIXME??: LoadFile uses wxFileName not wxString
extern "C" WXEXPORT
bool wxHtmlWindow_LoadFile(_HtmlWindow* self, const char* filename)
{
    return self->LoadFile(wxString(filename, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlWindow_GetOpenedPage(_HtmlWindow* self)
{
    return new wxString(self->GetOpenedPage());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlWindow_GetOpenedAnchor(_HtmlWindow* self)
{
    return new wxString(self->GetOpenedAnchor());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlWindow_GetOpenedPageTitle(_HtmlWindow* self)
{
    return new wxString(self->GetOpenedPageTitle());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SetRelatedFrame(_HtmlWindow* self, wxFrame* frame, char* format)
{
    self->SetRelatedFrame(frame, wxString(format, wxConvUTF8));
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
void wxHtmlWindow_SetFonts(_HtmlWindow* self, char* normal_face, char* fixed_face, int* sizes)
{
    self->SetFonts(wxString(normal_face, wxConvUTF8), wxString(fixed_face, wxConvUTF8), sizes);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_SetBorders(_HtmlWindow* self, int b)
{
    self->SetBorders(b);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_ReadCustomization(_HtmlWindow* self, wxConfigBase* cfg, char* path)
{
    self->ReadCustomization(cfg, wxString(path, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_WriteCustomization(_HtmlWindow* self, wxConfigBase* cfg, char* path)
{
    self->WriteCustomization(cfg, wxString(path, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_HistoryBack(_HtmlWindow* self)
{
    return self->HistoryBack()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_HistoryForward(_HtmlWindow* self)
{
    return self->HistoryForward()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_HistoryCanBack(_HtmlWindow* self)
{
    return self->HistoryCanBack()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlWindow_HistoryCanForward(_HtmlWindow* self)
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
bool wxHtmlWindow_AcceptsFocusFromKeyboard(_HtmlWindow* self)
{
    return self->AcceptsFocusFromKeyboard()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_OnSetTitle(_HtmlWindow* self, char* title)
{
    self->wxHtmlWindow::OnSetTitle(wxString(title, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_OnCellClicked(_HtmlWindow* self, wxHtmlCell* cell, wxCoord x, wxCoord y, wxMouseEvent* event)
{
    self->wxHtmlWindow::OnCellClicked(cell, x, y, *event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWindow_OnLinkClicked(_HtmlWindow* self, wxHtmlLinkInfo* link)
{
	self->wxHtmlWindow::OnLinkClicked(*link);
} 

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlOpeningStatus wxHtmlWindow_OnOpeningURL(_HtmlWindow* self, wxHtmlURLType type, const char * url, const char* redirect)
{
	return self->wxHtmlWindow::OnOpeningURL(type, wxString(url, wxConvUTF8), new wxString(redirect, wxConvUTF8));
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
wxString* wxHtmlWindow_ToText(_HtmlWindow* self)
{
	return new wxString(self->ToText());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlWindow_SelectionToText(_HtmlWindow* self)
{
	return new wxString(self->SelectionToText());
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
wxHtmlLinkInfo* wxHtmlLinkInfo_ctor(char* href, char* target)
{
    if (target == NULL)
        target = &wxEmptyString;

    return new wxHtmlLinkInfo(wxString(href, wxConvUTF8), wxString(target, wxConvUTF8));
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
wxString* wxHtmlLinkInfo_GetHref(wxHtmlLinkInfo* self)
{
    return new wxString(self->GetHref());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlLinkInfo_GetTarget(wxHtmlLinkInfo* self)
{
    return new wxString(self->GetTarget());
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
wxString* wxHtmlCell_GetId(wxHtmlCell* self)
{
    return new wxString(self->GetId());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetId(wxHtmlCell* self, char* id)
{
    self->SetId(wxString(id, wxConvUTF8));
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
bool wxHtmlCell_AdjustPagebreak(wxHtmlCell* self, int* pagebreak)
{
    return self->AdjustPagebreak(pagebreak)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlCell_SetCanLiveOnPagebreak(wxHtmlCell* self, bool can)
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
bool wxHtmlCell_IsTerminalCell(wxHtmlCell* self)
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
wxHtmlWordCell* wxHtmlWordCell_ctor(char* word, wxDC* dc)
{
    return new wxHtmlWordCell(wxString(word, wxConvUTF8), *dc);
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
bool wxHtmlContainerCell_AdjustPagebreak(wxHtmlContainerCell* self, int* pagebreak)
{
    return self->AdjustPagebreak(pagebreak)?1:0;
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
bool wxHtmlContainerCell_IsTerminalCell(wxHtmlContainerCell* self)
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
wxString* wxHtmlTag_GetName(wxHtmlTag* self)
{
    return new wxString(self->GetName());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlTag_HasParam(wxHtmlTag* self, char* par)
{
    return self->HasParam(wxString(par, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlTag_GetParam(wxHtmlTag* self, char* par, bool with_commas)
{
    return new wxString(self->GetParam(wxString(par, wxConvUTF8), with_commas));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlTag_GetParamAsColour(wxHtmlTag* self, char* par, wxColour* clr)
{
    return self->GetParamAsColour(wxString(par, wxConvUTF8), clr)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlTag_GetParamAsInt(wxHtmlTag* self, char* par, int* clr)
{
    return self->GetParamAsInt(wxString(par, wxConvUTF8), clr)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlTag_ScanParam(wxHtmlTag* self, char* par, char* format, void* param)
{
    return self->ScanParam(wxString(par, wxConvUTF8), wxString(format, wxConvUTF8).c_str(), param);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlTag_GetAllParams(wxHtmlTag* self)
{
    return new wxString(self->GetAllParams());
}

//-----------------------------------------------------------------------------
/*
extern "C" WXEXPORT
bool wxHtmlTag_IsEnding(wxHtmlTag* self)
{
    return self->IsEnding();
}
*/
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlTag_HasEnding(wxHtmlTag* self)
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
bool wxHtmlFilter_CanRead(wxHtmlFilter* self, wxFSFile* file)
{
    return self->CanRead(*file)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlFilter_ReadFile(wxHtmlFilter* self, wxFSFile* file)
{
	wxString str = self->ReadFile(*file);
	return new wxString(str);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlFilterPlainText_CanRead(wxHtmlFilterPlainText* self, wxFSFile* file)
{
    return self->CanRead(*file)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlFilterPlainText_ReadFile(wxHtmlFilterPlainText* self, wxFSFile* file)
{
	wxString str = self->ReadFile(*file);
    return new wxString(str);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlFilterHTML_CanRead(wxHtmlFilterHTML* self, wxFSFile* file)
{
    return self->CanRead(*file)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlFilterHTML_ReadFile(wxHtmlFilterHTML* self, wxFSFile* file)
{
	wxString str = self->ReadFile(*file);
    return new wxString(str);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxHtmlTagsModule* wxHtmlTagsModule_ctor()
{
    return new wxHtmlTagsModule();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlTagsModule_OnInit(wxHtmlTagsModule* self)
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
void wxHtmlWinParser_InitParser(wxHtmlWinParser* self, char* source)
{
    self->InitParser(wxString(source, wxConvUTF8));
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
wxFSFile* wxHtmlWinParser_OpenURL(wxHtmlWinParser* self, wxHtmlURLType type, char* url)
{
    return self->OpenURL(type, wxString(url, wxConvUTF8));
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
    return self->GetWindow();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFonts(wxHtmlWinParser* self, char* normal_face, char* fixed_face, int* sizes)
{
    self->SetFonts(wxString(normal_face, wxConvUTF8), wxString(fixed_face, wxConvUTF8), sizes);
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
wxString* wxHtmlWinParser_GetFontFace(wxHtmlWinParser* self)
{
    return new wxString(self->GetFontFace());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlWinParser_SetFontFace(wxHtmlWinParser* self, char* face)
{
    self->SetFontFace(wxString(face, wxConvUTF8));
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
bool wxHtmlTagHandler_HandleTag(wxHtmlTagHandler* self, wxHtmlTag* tag)
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
wxString* wxHtmlEntitiesParser_Parse(wxHtmlEntitiesParser* self, char* input)
{
    return new wxString(self->Parse(wxString(input, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
char wxHtmlEntitiesParser_GetEntityChar(wxHtmlEntitiesParser* self, char* entity)
{
    return (char)self->GetEntityChar(wxString(entity, wxConvUTF8));
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
wxFSFile* wxHtmlParser_OpenURL(wxHtmlParser* self, wxHtmlURLType type, char* url)
{
    return self->OpenURL(type, wxString(url, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxObject* wxHtmlParser_Parse(wxHtmlParser* self, char* source)
{
    return self->Parse(wxString(source, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_InitParser(wxHtmlParser* self, char* source)
{
    self->InitParser(wxString(source, wxConvUTF8));
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
void wxHtmlParser_PushTagHandler(wxHtmlParser* self, wxHtmlTagHandler* handler, char* tags)
{
    self->PushTagHandler(handler, wxString(tags, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_PopTagHandler(wxHtmlParser* self)
{
    self->PopTagHandler();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlParser_GetSource(wxHtmlParser* self)
{
    return self->GetSource();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_SetSource(wxHtmlParser* self, char* src)
{
    self->SetSource(wxString(src, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlParser_SetSourceAndSaveState(wxHtmlParser* self, char* src)
{
    self->SetSourceAndSaveState(wxString(src, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlParser_RestoreState(wxHtmlParser* self)
{
    return self->RestoreState()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxString* wxHtmlParser_ExtractCharsetInformation(wxHtmlParser* self, char* markup)
{
    return new wxString(self->ExtractCharsetInformation(wxString(markup, wxConvUTF8)));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxHtmlProcessor_GetPriority(wxHtmlProcessor* self)
{
    return self->GetPriority();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlProcessor_Enable(wxHtmlProcessor* self, bool enable)
{
    self->Enable(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlProcessor_IsEnabled(wxHtmlProcessor* self)
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
bool wxHtmlSelection_IsEmpty(wxHtmlSelection* self)
{
	return self->IsEmpty()?1:0;
}

//-----------------------------------------------------------------------------
// wxHtmlEasyPrinting

extern "C" WXEXPORT
wxHtmlEasyPrinting* wxHtmlEasyPrinting_ctor(const char* name, wxWindow* parent)
{
	return new wxHtmlEasyPrinting(wxString(name, wxConvUTF8), parent);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlEasyPrinting_PreviewFile(wxHtmlEasyPrinting* self, const char* htmlfile)
{
	return self->PreviewFile(wxString(htmlfile, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlEasyPrinting_PreviewText(wxHtmlEasyPrinting* self, const char* htmltext, const char* basepath)
{
	return self->PreviewText(wxString(htmltext, wxConvUTF8), wxString(basepath, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlEasyPrinting_PrintFile(wxHtmlEasyPrinting* self, const char* htmlfile)
{
	return self->PrintFile(wxString(htmlfile, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlEasyPrinting_PrintText(wxHtmlEasyPrinting* self, const char* htmltext, const char* basepath)
{
	return self->PrintText(wxString(htmltext, wxConvUTF8), wxString(basepath, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_PrinterSetup(wxHtmlEasyPrinting* self)
{
	self->PrinterSetup();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_PageSetup(wxHtmlEasyPrinting* self)
{
	self->PageSetup();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetHeader(wxHtmlEasyPrinting* self, const char* header, int pg)
{
	self->SetHeader(wxString(header, wxConvUTF8), pg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetFooter(wxHtmlEasyPrinting* self, const char* footer, int pg)
{
	self->SetFooter(wxString(footer, wxConvUTF8), pg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetFonts(wxHtmlEasyPrinting* self, const char* normal_face, const char* fixed_face, int* sizes)
{
	self->SetFonts(wxString(normal_face, wxConvUTF8), wxString(fixed_face, wxConvUTF8), sizes);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlEasyPrinting_SetStandardFonts(wxHtmlEasyPrinting* self, int size, const char* normal_face, const char* fixed_face)
{
	self->SetStandardFonts(size, wxString(normal_face, wxConvUTF8), wxString(fixed_face, wxConvUTF8));
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
