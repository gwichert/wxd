//-----------------------------------------------------------------------------
// wx.NET - calendarctrl.cxx
//
// The wxCalendarCtrl proxy interface.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 by Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/calctrl.h>
#include "local_events.h"

//-----------------------------------------------------------------------------

class _CalendarCtrl : public wxCalendarCtrl
{
public:
    DECLARE_OBJECTDELETED(_CalendarCtrl)
};

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCalendarCtrl* wxCalendarCtrl_ctor()
{
    return new _CalendarCtrl();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarCtrl_Create(wxCalendarCtrl* self, wxWindow* parent, wxWindowID id, wxDateTime* date, const wxPoint* pos, const wxSize* size, int style, char* name)
{
    	if (pos == NULL)
		pos = &wxDefaultPosition;

	if (size == NULL)
		size = &wxDefaultSize;

    if (name == NULL)
        name = "calendarCtrl";

    return self->Create(parent, id, *date, *pos, *size, style, wxString(name, wxConvUTF8))?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarCtrl_SetDate(wxCalendarCtrl* self, wxDateTime* date)
{
    return self->SetDate(*date)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDateTime* wxCalendarCtrl_GetDate(wxCalendarCtrl* self)
{
    return new wxDateTime(self->GetDate());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarCtrl_SetLowerDateLimit(wxCalendarCtrl* self, wxDateTime* date)
{
    return self->SetLowerDateLimit(*date)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDateTime* wxCalendarCtrl_GetLowerDateLimit(wxCalendarCtrl* self)
{
    return new wxDateTime(self->GetLowerDateLimit());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarCtrl_SetUpperDateLimit(wxCalendarCtrl* self, wxDateTime* date)
{
    return self->SetUpperDateLimit(*date)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDateTime* wxCalendarCtrl_GetUpperDateLimit(wxCalendarCtrl* self)
{
    return new wxDateTime(self->GetUpperDateLimit());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarCtrl_SetDateRange(wxCalendarCtrl* self, wxDateTime* lowerdate, wxDateTime* upperdate)
{
    return self->SetDateRange(*lowerdate, *upperdate)?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_EnableYearChange(wxCalendarCtrl* self, bool enable)
{
    self->EnableYearChange(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_EnableMonthChange(wxCalendarCtrl* self, bool enable)
{
    self->EnableMonthChange(enable);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_EnableHolidayDisplay(wxCalendarCtrl* self, bool display)
{
    self->EnableHolidayDisplay(display);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_SetHeaderColours(wxCalendarCtrl* self, wxColour* colFg, wxColour* colBg)
{
    self->SetHeaderColours(*colFg, *colBg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarCtrl_GetHeaderColourFg(wxCalendarCtrl* self)
{
    return new wxColour(self->GetHeaderColourFg());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarCtrl_GetHeaderColourBg(wxCalendarCtrl* self)
{
    return new wxColour(self->GetHeaderColourBg());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_SetHighlightColours(wxCalendarCtrl* self, wxColour* colFg, wxColour* colBg)
{
    self->SetHighlightColours(*colFg, *colBg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarCtrl_GetHighlightColourFg(wxCalendarCtrl* self)
{
    return new wxColour(self->GetHighlightColourFg());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarCtrl_GetHighlightColourBg(wxCalendarCtrl* self)
{
    return new wxColour(self->GetHighlightColourBg());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_SetHolidayColours(wxCalendarCtrl* self, wxColour* colFg, wxColour* colBg)
{
    self->SetHolidayColours(*colFg, *colBg);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarCtrl_GetHolidayColourFg(wxCalendarCtrl* self)
{
    return new wxColour(self->GetHolidayColourFg());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarCtrl_GetHolidayColourBg(wxCalendarCtrl* self)
{
    return new wxColour(self->GetHolidayColourBg());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCalendarDateAttr* wxCalendarCtrl_GetAttr(wxCalendarCtrl* self, int day)
{
    return self->GetAttr(day);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_SetAttr(wxCalendarCtrl* self, int day, wxCalendarDateAttr* attr)
{
    self->SetAttr(day, attr);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_SetHoliday(wxCalendarCtrl* self, int day)
{
    self->SetHoliday(day);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarCtrl_ResetAttr(wxCalendarCtrl* self, int day)
{
    self->ResetAttr(day);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCalendarHitTestResult wxCalendarCtrl_HitTest(wxCalendarCtrl* self, wxPoint* pos, wxDateTime* date, wxDateTime::WeekDay *wd)
{
    return self->HitTest(*pos, date, wd);
}

//-----------------------------------------------------------------------------

class _CalendarDateAttr : public wxCalendarDateAttr
{
public:
	_CalendarDateAttr()
		: wxCalendarDateAttr() {}

	DECLARE_DISPOSABLE(_CalendarDateAttr)
};

extern "C" WXEXPORT
wxCalendarDateAttr* wxCalendarDateAttr_ctor()
{
    return new _CalendarDateAttr();
}

extern "C" WXEXPORT
void wxCalendarDateAttr_dtor(wxCalendarDateAttr* self)
{
	if (self != NULL)
		delete self;
}

extern "C" WXEXPORT
void wxCalendarDateAttr_RegisterDisposable(_CalendarDateAttr* self, Virtual_Dispose onDispose)
{
	self->RegisterDispose(onDispose);
}

#if 0
//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCalendarDateAttr* wxCalendarDateAttr_ctor(wxColour* colText, wxColour* colBack, wxColour* colBorder, wxFont* font, wxCalendarDateBorder border)
{
    return new wxCalendarDateAttr(*colText, *colBack, *colBorder, *font, border);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCalendarDateAttr* wxCalendarDateAttr_ctor(wxCalendarDateBorder border, wxColour* colBorder)
{
    if (colBorder == NULL)
        colBorder = &wxNullColour;

    return new wxCalendarDateAttr(border, *colBorder);
}
#endif

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarDateAttr_SetTextColour(wxCalendarDateAttr* self, wxColour* colText)
{
    self->SetTextColour(*colText);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarDateAttr_SetBackgroundColour(wxCalendarDateAttr* self, wxColour* colBack)
{
    self->SetBackgroundColour(*colBack);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarDateAttr_SetBorderColour(wxCalendarDateAttr* self, wxColour* col)
{
    self->SetBorderColour(*col);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarDateAttr_SetFont(wxCalendarDateAttr* self, wxFont* font)
{
    self->SetFont(*font);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarDateAttr_SetBorder(wxCalendarDateAttr* self, wxCalendarDateBorder border)
{
    self->SetBorder(border);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
void wxCalendarDateAttr_SetHoliday(wxCalendarDateAttr* self, bool holiday)
{
    self->SetHoliday(holiday);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarDateAttr_HasTextColour(wxCalendarDateAttr* self)
{
    return self->HasTextColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarDateAttr_HasBackgroundColour(wxCalendarDateAttr* self)
{
    return self->HasBackgroundColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarDateAttr_HasBorderColour(wxCalendarDateAttr* self)
{
    return self->HasBorderColour()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarDateAttr_HasFont(wxCalendarDateAttr* self)
{
    return self->HasFont()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarDateAttr_HasBorder(wxCalendarDateAttr* self)
{
    return self->HasBorder()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
bool wxCalendarDateAttr_IsHoliday(wxCalendarDateAttr* self)
{
    return self->IsHoliday()?1:0;
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarDateAttr_GetTextColour(wxCalendarDateAttr* self)
{
    return new wxColour(self->GetTextColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarDateAttr_GetBackgroundColour(wxCalendarDateAttr* self)
{
    return new wxColour(self->GetBackgroundColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxColour* wxCalendarDateAttr_GetBorderColour(wxCalendarDateAttr* self)
{
    return new wxColour(self->GetBorderColour());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxFont* wxCalendarDateAttr_GetFont(wxCalendarDateAttr* self)
{
    return new wxFont(self->GetFont());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCalendarDateBorder wxCalendarDateAttr_GetBorder(wxCalendarDateAttr* self)
{
    return self->GetBorder();
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxCalendarEvent* wxCalendarEvent_ctor(wxCalendarCtrl* cal, wxEventType type)
{
    return new wxCalendarEvent(cal, type);
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDateTime* wxCalendarEvent_GetDate(wxCalendarEvent* self)
{
    return new wxDateTime(self->GetDate());
}

//-----------------------------------------------------------------------------

extern "C" WXEXPORT
wxDateTime::WeekDay GetWeekDay(wxCalendarEvent* self)
{
    return self->GetWeekDay();
}

//-----------------------------------------------------------------------------

