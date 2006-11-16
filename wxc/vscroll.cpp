//-----------------------------------------------------------------------------
// wxD - vscroll.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - vscroll.cxx
//
// The wxVScrolledWindow proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/vscroll.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

typedef int (CALLBACK* Virtual_IntInt) (dobj, int);

class _VScrolledWindow : public wxVScrolledWindow
{
public:
	_VScrolledWindow()
		: wxVScrolledWindow() {}

	_VScrolledWindow(wxWindow* parent, wxWindowID id, const wxPoint& pos,
					const wxSize& size, long style, const wxString& name)
		: wxVScrolledWindow(parent, id, pos, size, style, name) { }
		
	void RegisterVirtual(dobj obj, Virtual_IntInt onGetLineHeight)
		{
			m_dobj = obj;
			m_OnGetLineHeight = onGetLineHeight;
		}
		
protected:
	wxCoord OnGetLineHeight( size_t n) const
		{ return m_OnGetLineHeight(m_dobj, n); }	
		
private:
	Virtual_IntInt m_OnGetLineHeight;
	dobj m_dobj;
	
public:
	DECLARE_OBJECTDELETED(_VScrolledWindow)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxVScrolledWindow* wxVScrolledWindow_ctor()
{
	return new _VScrolledWindow();
}

extern "C" WXEXPORT
wxVScrolledWindow* wxVScrolledWindow_ctor2(wxWindow *parent, wxWindowID id, const wxPoint* pos,
					               const wxSize* size, long style, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("vscrolled");

	return new _VScrolledWindow(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVScrolledWindow_RegisterVirtual(_VScrolledWindow* self, dobj obj, Virtual_IntInt onGetLineHeight)
{
	self->RegisterVirtual(obj, onGetLineHeight);
}

extern "C" WXEXPORT
bool wxVScrolledWindow_Create(_VScrolledWindow* self, wxWindow *parent, wxWindowID id, const wxPoint* pos,
					               const wxSize* size, long style, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = dstr("vscrolled");
			
	return self->Create(parent, id, *pos, *size, style, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

extern "C" WXEXPORT
void wxVScrolledWindow_SetLineCount(_VScrolledWindow* self, int count)
{
	self->SetLineCount(count);
}

extern "C" WXEXPORT
bool wxVScrolledWindow_ScrollToLine(_VScrolledWindow* self, int line)
{
	return self->ScrollToLine(line)?1:0;
}

extern "C" WXEXPORT
bool wxVScrolledWindow_ScrollLines(_VScrolledWindow* self, int lines)
{
	return self->ScrollLines(lines)?1:0;
}

extern "C" WXEXPORT
bool wxVScrolledWindow_ScrollPages(_VScrolledWindow* self, int pages)
{
	return self->ScrollPages(pages)?1:0;
}

extern "C" WXEXPORT
void wxVScrolledWindow_RefreshLine(_VScrolledWindow* self, int line)
{
	self->RefreshLine(line);
}

extern "C" WXEXPORT
void wxVScrolledWindow_RefreshLines(_VScrolledWindow* self, int from, int to)
{
	self->RefreshLines(from, to);
}

extern "C" WXEXPORT
int wxVScrolledWindow_HitTest(_VScrolledWindow* self, wxCoord x, wxCoord y)
{
	return self->HitTest(x, y);	
}

extern "C" WXEXPORT
int wxVScrolledWindow_HitTest2(_VScrolledWindow* self, const wxPoint* pt)
{
	return self->HitTest(*pt);
}

extern "C" WXEXPORT
void wxVScrolledWindow_RefreshAll(_VScrolledWindow* self)
{
	self->RefreshAll();
}

extern "C" WXEXPORT
int wxVScrolledWindow_GetLineCount(_VScrolledWindow* self)
{
	return self->GetLineCount();
}

extern "C" WXEXPORT
int wxVScrolledWindow_GetFirstVisibleLine(_VScrolledWindow* self)
{
	return self->GetFirstVisibleLine();
}

extern "C" WXEXPORT
int wxVScrolledWindow_GetLastVisibleLine(_VScrolledWindow* self)
{
	return self->GetLastVisibleLine();
}

extern "C" WXEXPORT
bool wxVScrolledWindow_IsVisible(_VScrolledWindow* self, int line)
{
	return self->IsVisible(line)?1:0;
}

