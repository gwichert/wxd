//-----------------------------------------------------------------------------
// wx.NET - vlbox.cxx
//
// The wxVListBox proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/vlbox.h>
#include "local_events.h"

#if defined(_WINDOWS)
#define CALLBACK __stdcall
#else
#define CALLBACK
#endif

//-----------------------------------------------------------------------------

typedef void (CALLBACK* Virtual_voidDcRectSizeT) (wxDC*, wxRect*, size_t);
typedef int (CALLBACK* Virtual_IntInt) (int);

class _VListBox : public wxVListBox
{
public:
	_VListBox(wxWindow* parent, wxWindowID id, const wxPoint& pos,
					const wxSize& size, long style, const wxString& name)
		: wxVListBox(parent, id, pos, size, style, name) { }
		
	void RegisterVirtual(Virtual_voidDcRectSizeT onDrawItem,
		Virtual_IntInt onMeasureItem,
		Virtual_voidDcRectSizeT onDrawSeparator,
		Virtual_voidDcRectSizeT onDrawBackground,
		Virtual_IntInt onGetLineHeight)
		{
			m_OnDrawItem = onDrawItem;
			m_OnMeasureItem = onMeasureItem;
			m_OnDrawSeparator = onDrawSeparator;
			m_OnDrawBackground = onDrawBackground;
			m_OnGetLineHeight = onGetLineHeight;
		}
		
	void POnDrawSeparator(wxDC& dc, wxRect& rect, size_t n)
		{
			wxVListBox::OnDrawSeparator(dc, rect, n);
		}
		
	void POnDrawBackground(wxDC& dc, wxRect& rect, size_t n)
		{
			wxVListBox::OnDrawBackground(dc, rect, n);
		}
		
	wxCoord POnGetLineHeight(int n)
		{
			return wxVListBox::OnGetLineHeight(n); 
		}
		
protected:
	void OnDrawItem( wxDC& dc, const wxRect& rect, size_t n) const
		{ m_OnDrawItem( &dc, new wxRect(rect), n); }	
		
	wxCoord OnMeasureItem( size_t n) const
		{ return m_OnMeasureItem( n); }		
		
	void OnDrawSeparator(wxDC& dc, wxRect& rect, size_t n) const
		{ return m_OnDrawSeparator(&dc, new wxRect(rect), n); }
		
	void OnDrawBackground(wxDC& dc, const wxRect& rect, size_t n) const
		{ return m_OnDrawBackground(&dc, new wxRect(rect), n); }
		
	wxCoord OnGetLineHeight( size_t n) const
		{ return m_OnGetLineHeight(n); }	
				
private:
	Virtual_voidDcRectSizeT m_OnDrawItem;
	Virtual_IntInt m_OnMeasureItem;
	Virtual_voidDcRectSizeT m_OnDrawSeparator;
	Virtual_voidDcRectSizeT m_OnDrawBackground;
	Virtual_IntInt m_OnGetLineHeight;
	
public: 
	DECLARE_OBJECTDELETED(_VListBox)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxVListBox* wxVListBox_ctor(wxWindow *parent, wxWindowID id, const wxPoint* pos,
					               const wxSize* size, long style, const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name == NULL)
		name = "vlistbox";

	return new _VListBox(parent, id, *pos, *size, style, wxString(name, wxConvUTF8));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_RegisterVirtual(_VListBox* self, Virtual_voidDcRectSizeT onDrawItem,
		Virtual_IntInt onMeasureItem,
		Virtual_voidDcRectSizeT onDrawSeparator,
		Virtual_voidDcRectSizeT onDrawBackground,
		Virtual_IntInt onGetLineHeight)
{
	self->RegisterVirtual(onDrawItem, onMeasureItem, onDrawSeparator, onDrawBackground, onGetLineHeight);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_Create(_VListBox* self, wxWindow *parent, wxWindowID id, const wxPoint* pos,
					               const wxSize* size, long style, const char* name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name == NULL)
		name = "vlistbox";	
			
	return self->Create(parent, id, *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_OnDrawSeparator(_VListBox* self, wxDC* dc, wxRect* rect, int n)
{
	self->POnDrawSeparator(*dc, *rect, n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_OnDrawBackground(_VListBox* self, wxDC* dc, wxRect* rect, int n)
{
	self->POnDrawBackground(*dc, *rect, n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxVListBox_OnGetLineHeight(_VListBox* self, int line)
{
	return self->POnGetLineHeight(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxVListBox_GetItemCount(_VListBox* self)
{
	return self->GetItemCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_HasMultipleSelection(_VListBox* self)
{
	return self->HasMultipleSelection()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxVListBox_GetSelection(_VListBox* self)
{
	return self->GetSelection();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_IsCurrent(_VListBox* self, int item)
{
	return self->IsCurrent(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_IsSelected(_VListBox* self, int item)
{
	return self->IsSelected(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxVListBox_GetSelectedCount(_VListBox* self)
{
	return self->GetSelectedCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxVListBox_GetFirstSelected(_VListBox* self, unsigned long *cookie)
{
	return self->GetFirstSelected(*cookie);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxVListBox_GetNextSelected(_VListBox* self, unsigned long *cookie)
{
	return self->GetNextSelected(*cookie);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_GetMargins(_VListBox* self, wxPoint* pt)
{
	*pt = self->GetMargins();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxVListBox_GetSelectionBackground(_VListBox* self)
{
	return new wxColour(self->GetSelectionBackground());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_SetItemCount(_VListBox* self, int count)
{
	self->SetItemCount(count);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_Clear(_VListBox* self)
{
	self->Clear();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_SetSelection(_VListBox* self, int selection)
{
	self->SetSelection(selection);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_Select(_VListBox* self, int item, bool select)
{
	return self->Select(item, select)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_SelectRange(_VListBox* self, int from, int to)
{
	return self->SelectRange(from, to)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_Toggle(_VListBox* self, int item)
{
	self->Toggle(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_SelectAll(_VListBox* self)
{
	return self->SelectAll()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxVListBox_DeselectAll(_VListBox* self)
{
	return self->DeselectAll()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_SetMargins(_VListBox* self, const wxPoint* pt)
{
	self->SetMargins(*pt);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_SetMargins2(_VListBox* self, int x, int y)
{
	self->SetMargins(x, y);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_SetSelectionBackground(_VListBox* self, wxColour* col)
{
	self->SetSelectionBackground(*col);
}
