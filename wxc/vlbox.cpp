//-----------------------------------------------------------------------------
// wxD - vlbox.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
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
#include "common.h"
#include <wx/vlbox.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

typedef void (CALLBACK* Virtual_voidDcRectSizeT) (wxc_object, wxDC*, const wxRect*, size_t);
typedef int (CALLBACK* Virtual_IntInt) (wxc_object, int);
typedef int (CALLBACK* Virtual_IntSizeT) (wxc_object, size_t);

class _VListBox : public wxVListBox
{
public:
	_VListBox(wxWindow* parent, wxWindowID id, const wxPoint& pos,
					const wxSize& size, long style, const wxString& name)
		: wxVListBox(parent, id, pos, size, style, name) { }
		
	void RegisterVirtual(wxc_object obj,
		Virtual_voidDcRectSizeT onDrawItem,
		Virtual_IntSizeT onMeasureItem,
		Virtual_voidDcRectSizeT onDrawSeparator,
		Virtual_voidDcRectSizeT onDrawBackground,
		Virtual_IntSizeT onGetLineHeight)
		{
			m_dobj = obj;
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
		
	wxCoord POnGetLineHeight(size_t n)
		{
			return wxVListBox::OnGetLineHeight(n); 
		}
		
protected:
	void OnDrawItem( wxDC& dc, const wxRect& rect, size_t n) const
		{ m_OnDrawItem(m_dobj,  &dc, &rect, n); }	
		
	wxCoord OnMeasureItem( size_t n) const
		{ return m_OnMeasureItem(m_dobj,  n); }		
		
	void OnDrawSeparator(wxDC& dc, wxRect& rect, size_t n) const
		{ return m_OnDrawSeparator(m_dobj, &dc, &rect, n); }
		
	void OnDrawBackground(wxDC& dc, const wxRect& rect, size_t n) const
		{ return m_OnDrawBackground(m_dobj, &dc, &rect, n); }
		
	wxCoord OnGetLineHeight(size_t n) const
		{ return m_OnGetLineHeight(m_dobj, n); }	
				
private:
	Virtual_voidDcRectSizeT m_OnDrawItem;
	Virtual_IntSizeT m_OnMeasureItem;
	Virtual_voidDcRectSizeT m_OnDrawSeparator;
	Virtual_voidDcRectSizeT m_OnDrawBackground;
	Virtual_IntSizeT m_OnGetLineHeight;
	wxc_object m_dobj;
	
public: 
	DECLARE_OBJECTDELETED(_VListBox)
};

//-----------------------------------------------------------------------------
// C stubs for class methods

extern "C" WXEXPORT
wxVListBox* wxVListBox_ctor(wxWindow *parent, wxWindowID id, const wxPoint* pos,
					               const wxSize* size, long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("vlistbox");

	return new _VListBox(parent, id, *pos, *size, style, wxstr(name));
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_RegisterVirtual(_VListBox* self, wxc_object obj,
		Virtual_voidDcRectSizeT onDrawItem,
		Virtual_IntSizeT onMeasureItem,
		Virtual_voidDcRectSizeT onDrawSeparator,
		Virtual_voidDcRectSizeT onDrawBackground,
		Virtual_IntSizeT onGetLineHeight)
{
	self->RegisterVirtual(obj, onDrawItem, onMeasureItem, onDrawSeparator, onDrawBackground, onGetLineHeight);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxVListBox_Create(_VListBox* self, wxWindow *parent, wxWindowID id, const wxPoint* pos,
					               const wxSize* size, long style, wxc_string name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (name.data==NULL)
		name = wxc_string("vlistbox");
			
	return self->Create(parent, id, *pos, *size, style, wxstr(name))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_OnDrawSeparator(_VListBox* self, wxDC* dc, wxRect* rect, size_t n)
{
	self->POnDrawSeparator(*dc, *rect, n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_OnDrawBackground(_VListBox* self, wxDC* dc, wxRect* rect, size_t n)
{
	self->POnDrawBackground(*dc, *rect, n);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCoord wxVListBox_OnGetLineHeight(_VListBox* self, size_t line)
{
	return self->POnGetLineHeight(line);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
size_t wxVListBox_GetItemCount(_VListBox* self)
{
	return self->GetItemCount();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxVListBox_HasMultipleSelection(_VListBox* self)
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
wxc_bool wxVListBox_IsCurrent(_VListBox* self, size_t item)
{
	return self->IsCurrent(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxVListBox_IsSelected(_VListBox* self, size_t item)
{
	return self->IsSelected(item)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
size_t wxVListBox_GetSelectedCount(_VListBox* self)
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
void wxVListBox_SetItemCount(_VListBox* self, size_t count)
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
wxc_bool wxVListBox_Select(_VListBox* self, size_t item, wxc_bool select)
{
	return self->Select(item, select)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxVListBox_SelectRange(_VListBox* self, size_t from, size_t to)
{
	return self->SelectRange(from, to)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxVListBox_Toggle(_VListBox* self, size_t item)
{
	self->Toggle(item);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxVListBox_SelectAll(_VListBox* self)
{
	return self->SelectAll()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxc_bool wxVListBox_DeselectAll(_VListBox* self)
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
