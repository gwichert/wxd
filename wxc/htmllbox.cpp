//-----------------------------------------------------------------------------
// wxD - htmllbox.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - htmllbox.cxx
//
// The wxHtmlListBox proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/htmllbox.h>
#include "local_events.h"

typedef void (CALLBACK* Virtual_VoidNoParams) (dobj);
typedef void (CALLBACK* Virtual_VoidSizeT) (dobj, size_t);
typedef dstr (CALLBACK* Virtual_wxStringSizeT) (dobj, size_t);
typedef wxColour* (CALLBACK* Virtual_wxColourwxColour) (dobj, wxColour*);
typedef void (CALLBACK* Virtual_OnDrawItem) (dobj, wxDC*, const wxRect*, size_t);
typedef wxCoord (CALLBACK* Virtual_OnMeasureItem) (dobj, size_t);

class _HtmlListBox : public wxHtmlListBox
{
	public:
		_HtmlListBox( wxWindow* parent, wxWindowID id, const wxPoint& pos, const wxSize& size, long style, const wxString& name) :
			wxHtmlListBox(parent, id, pos, size, style, name) {}
			
		void RefreshAll()
			{ return m_RefreshAll(m_dobj); }
			
		void SetItemCount( size_t count)
			{ return m_SetItemCount(m_dobj, count); }
			
		wxString VPOnGetItemMarkup( size_t n)
			{ return wxHtmlListBox::OnGetItemMarkup(n); }
			
		wxColour VPGetSelectedTextColour( const wxColour& colFg)
			{ return wxHtmlListBox::GetSelectedTextColour(colFg); }	
			
		wxColour VPGetSelectedTextBgColour( const wxColour& colBg)
			{ return wxHtmlListBox::GetSelectedTextBgColour(colBg); }	
			
		void VPOnDrawItem( wxDC& dc, const wxRect& rect, size_t n)
			{ return wxHtmlListBox::OnDrawItem(dc, rect, n); }	
			
		wxCoord VPOnMeasureItem( size_t n)
			{ return wxHtmlListBox::OnMeasureItem( n); }			
			
		void POnSize(wxSizeEvent& event)
			{ return OnSize(event); }
			
		void PInit()
			{ return Init(); }
			
		void PCacheItem(size_t n)
			{ return CacheItem(n); }
		
		// from vlbox	
		void POnDrawSeparator(wxDC& dc, wxRect& rect, size_t n)
			{ wxHtmlListBox::OnDrawSeparator(dc, rect, n); }
		
		void POnDrawBackground(wxDC& dc, wxRect& rect, size_t n)
			{ wxHtmlListBox::OnDrawBackground(dc, rect, n); }		
			
		wxCoord POnGetLineHeight(int n) 
			{ return wxHtmlListBox::OnGetLineHeight(n); }
		
			
	protected:
			
		wxString OnGetItem( size_t n) const
			{ dstr tmp = m_OnGetItem(m_dobj, n); return wxString(tmp.data, wxConvUTF8, tmp.length); }
			
		wxString OnGetItemMarkup( size_t n) const
			{ dstr tmp = m_OnGetItemMarkup(m_dobj, n); return wxString(tmp.data, wxConvUTF8, tmp.length); }
			
		wxColour GetSelectedTextColour( const wxColour& colFg) const
			{ return wxColour(*m_GetSelectedTextColour(m_dobj, new wxColour(colFg))); }
			
		wxColour GetSelectedTextBgColour( const wxColour& colBg) const
			{ return wxColour(*m_GetSelectedTextBgColour(m_dobj, new wxColour(colBg))); }
			
		void OnDrawItem( wxDC& dc, const wxRect& rect, size_t n) const
			{ m_OnDrawItem(m_dobj,  &dc, &rect, n); }
			
		wxCoord OnMeasureItem( size_t n) const
			{ return m_OnMeasureItem(m_dobj,  n); }
			
		void OnDrawSeparator(wxDC& dc, wxRect& rect, size_t n) const
			{ return m_OnDrawSeparator(m_dobj, &dc, &rect, n); }
			
		void OnDrawBackground(wxDC& dc, const wxRect& rect, size_t n) const
			{ return m_OnDrawBackground(m_dobj, &dc, &rect, n); }
			
		wxCoord OnGetLineHeight( size_t n) const
			{ return m_OnGetLineHeight(m_dobj, n); }		
			
	public:
			
		void RegisterVirtual(dobj obj, Virtual_VoidNoParams refreshAll,
				Virtual_VoidSizeT setItemCount,
				Virtual_wxStringSizeT onGetItem,
				Virtual_wxStringSizeT onGetItemMarkup,
				Virtual_wxColourwxColour getSelectedTextColour,
				Virtual_wxColourwxColour getSelectedTextBgColour,
				Virtual_OnDrawItem onDrawItem,
				Virtual_OnMeasureItem onMeasureItem,
				Virtual_OnDrawItem onDrawSeparator,
				Virtual_OnDrawItem onDrawBackground,
				Virtual_OnMeasureItem onGetLineHeight)
			{
				m_dobj = obj;
				m_RefreshAll = refreshAll;
				m_SetItemCount = setItemCount;
				m_OnGetItem = onGetItem;
				m_OnGetItemMarkup = onGetItemMarkup;
				m_GetSelectedTextColour = getSelectedTextColour;
				m_GetSelectedTextBgColour = getSelectedTextBgColour;
				m_OnDrawItem = onDrawItem;
				m_OnMeasureItem = onMeasureItem;
				m_OnDrawSeparator = onDrawSeparator;
				m_OnDrawBackground = onDrawBackground;
				m_OnGetLineHeight = onGetLineHeight;
			}
			
	private:
		Virtual_VoidNoParams m_RefreshAll;
		Virtual_VoidSizeT m_SetItemCount;
		Virtual_wxStringSizeT m_OnGetItem;
		Virtual_wxStringSizeT m_OnGetItemMarkup;
		Virtual_wxColourwxColour m_GetSelectedTextColour;
		Virtual_wxColourwxColour m_GetSelectedTextBgColour;
		Virtual_OnDrawItem m_OnDrawItem;
		Virtual_OnMeasureItem m_OnMeasureItem;
		Virtual_OnDrawItem m_OnDrawSeparator;
		Virtual_OnDrawItem m_OnDrawBackground;
		Virtual_OnMeasureItem m_OnGetLineHeight;
		dobj m_dobj;
		
	public:
		DECLARE_OBJECTDELETED(_HtmlListBox)
};

extern "C" WXEXPORT
wxHtmlListBox* wxHtmlListBox_ctor2(wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, int style, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("htmllistbox");
		
	return new _HtmlListBox(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length));
}

extern "C" WXEXPORT
void wxHtmlListBox_RegisterVirtual(_HtmlListBox* self, dobj obj,
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
				Virtual_OnMeasureItem onGetLineHeight)
{
    self->RegisterVirtual(obj, refreshAll, setItemCount, onGetItem, onGetItemMarkup, getSelectedTextColour,
    	getSelectedTextBgColour, onDrawItem, onMeasureItem, onDrawSeparator, onDrawBackground, onGetLineHeight);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxHtmlListBox_Create(_HtmlListBox* self, wxWindow* parent, wxWindowID id, wxPoint* pos, wxSize* size, int style, dstr name)
{
	return self->Create(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_RefreshAll(_HtmlListBox* self)
{
    self->wxHtmlListBox::RefreshAll();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_SetItemCount(_HtmlListBox* self, int count)
{
    self->wxHtmlListBox::SetItemCount(count);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
dstrret wxHtmlListBox_OnGetItemMarkup(_HtmlListBox* self, int n)
{
    return dstr_ret(self->VPOnGetItemMarkup(n).c_str());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxHtmlListBox_GetSelectedTextColour(_HtmlListBox* self, const wxColour* colFg)
{
    return new wxColour(self->VPGetSelectedTextColour(*colFg));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxHtmlListBox_GetSelectedTextBgColour(_HtmlListBox* self, const wxColour* colBg)
{
    return new wxColour(self->VPGetSelectedTextBgColour(*colBg));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_OnDrawItem(_HtmlListBox* self, wxDC* dc, wxRect* rect, int n)
{
    return self->VPOnDrawItem(*dc, *rect, n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxHtmlListBox_OnMeasureItem(_HtmlListBox* self, int n)
{
    return self->VPOnMeasureItem(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_OnSize(_HtmlListBox* self, wxSizeEvent* event)
{
    return self->POnSize(*event);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_Init(_HtmlListBox* self)
{
    return self->PInit();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_CacheItem(_HtmlListBox* self, int n)
{
    return self->PCacheItem(n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_OnDrawSeparator(_HtmlListBox* self, wxDC* dc, wxRect* rect, int n)
{
	self->POnDrawSeparator(*dc, *rect, n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxHtmlListBox_OnDrawBackground(_HtmlListBox* self, wxDC* dc, wxRect* rect, int n)
{
	self->POnDrawBackground(*dc, *rect, n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxHtmlListBox_OnGetLineHeight(_HtmlListBox* self, int line)
{
	return self->POnGetLineHeight(line);
}





