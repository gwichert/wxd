//-----------------------------------------------------------------------------
// wxD - scrollbar.cpp
// (C) 2005 bero <berobero.sourceforge.net>
// based on
// wx.NET - scrollbar.cxx
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include "common.h"
#include <wx/scrolbar.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _ScrollBar : public wxScrollBar
{
public:
    DECLARE_OBJECTDELETED(_ScrollBar)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxScrollBar* wxScrollBar_ctor()
{
    return new _ScrollBar();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxScrollBar_Create(wxScrollBar* self, wxWindow* parent, wxWindowID id, const wxPoint* pos, const wxSize* size, int style, const wxValidator* validator, dstr name)
{
	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

	if (validator == NULL)
		validator = &wxDefaultValidator;

	if (name.data==NULL)
		name = dstr("scrollbar");
		
    return self->Create(parent, id, *pos, *size, style, *validator, wxString(name.data, wxConvUTF8, name.length))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxScrollBar_GetThumbPosition(wxScrollBar* self)
{
    return self->GetThumbPosition();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxScrollBar_GetThumbSize(wxScrollBar* self)
{
    return self->GetThumbSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxScrollBar_GetPageSize(wxScrollBar* self)
{
    return self->GetPageSize();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
int wxScrollBar_GetRange(wxScrollBar* self)
{
    return self->GetRange();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxScrollBar_IsVertical(wxScrollBar* self)
{
    return self->IsVertical()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollBar_SetThumbPosition(wxScrollBar* self, int viewStart)
{
    self->SetThumbPosition(viewStart);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxScrollBar_SetScrollbar(wxScrollBar* self, int position, int thumbSize, int range, int pageSize, bool refresh)
{
    self->SetScrollbar(position, thumbSize, range, pageSize, refresh);
}

//-----------------------------------------------------------------------------

