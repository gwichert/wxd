//-----------------------------------------------------------------------------
// wxD - CalendarCtrl.d
// 
// The wxCalendarCtrl wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.CalendarCtrl;
import wx.common;
import wx.wxDateTime;
import wx.Colour;
import wx.Font;
import wx.Control;
import wx.CommandEvent;

    public enum CalendarHitTestResult
    {
        wxCAL_HITTEST_NOWHERE,
        wxCAL_HITTEST_HEADER,
        wxCAL_HITTEST_DAY,
        wxCAL_HITTEST_INCMONTH,
        wxCAL_HITTEST_DECMONTH,
        wxCAL_HITTEST_SURROUNDING_WEEK
    }

    public enum CalendarDateBorder
    {
        wxCAL_BORDER_NONE,
        wxCAL_BORDER_SQUARE,
        wxCAL_BORDER_ROUND
    }

        static extern (C) IntPtr wxCalendarCtrl_ctor();
        static extern (C) bool   wxCalendarCtrl_Create(IntPtr self, IntPtr parent, int id, IntPtr date, inout Point pos, inout Size size, uint style, string name);
        static extern (C) bool   wxCalendarCtrl_SetDate(IntPtr self, IntPtr date);
        static extern (C) IntPtr wxCalendarCtrl_GetDate(IntPtr self);
        static extern (C) bool   wxCalendarCtrl_SetLowerDateLimit(IntPtr self, IntPtr date);
        static extern (C) IntPtr wxCalendarCtrl_GetLowerDateLimit(IntPtr self);
        static extern (C) bool   wxCalendarCtrl_SetUpperDateLimit(IntPtr self, IntPtr date);
        static extern (C) IntPtr wxCalendarCtrl_GetUpperDateLimit(IntPtr self);
        static extern (C) bool   wxCalendarCtrl_SetDateRange(IntPtr self, IntPtr lowerdate, IntPtr upperdate);
        static extern (C) void   wxCalendarCtrl_EnableYearChange(IntPtr self, bool enable);
        static extern (C) void   wxCalendarCtrl_EnableMonthChange(IntPtr self, bool enable);
        static extern (C) void   wxCalendarCtrl_EnableHolidayDisplay(IntPtr self, bool display);
        static extern (C) void   wxCalendarCtrl_SetHeaderColours(IntPtr self, IntPtr colFg, IntPtr colBg);
        static extern (C) IntPtr wxCalendarCtrl_GetHeaderColourFg(IntPtr self);
        static extern (C) IntPtr wxCalendarCtrl_GetHeaderColourBg(IntPtr self);
        static extern (C) void   wxCalendarCtrl_SetHighlightColours(IntPtr self, IntPtr colFg, IntPtr colBg);
        static extern (C) IntPtr wxCalendarCtrl_GetHighlightColourFg(IntPtr self);
        static extern (C) IntPtr wxCalendarCtrl_GetHighlightColourBg(IntPtr self);
        static extern (C) void   wxCalendarCtrl_SetHolidayColours(IntPtr self, IntPtr colFg, IntPtr colBg);
        static extern (C) IntPtr wxCalendarCtrl_GetHolidayColourFg(IntPtr self);
        static extern (C) IntPtr wxCalendarCtrl_GetHolidayColourBg(IntPtr self);
        static extern (C) IntPtr wxCalendarCtrl_GetAttr(IntPtr self, int day);
        static extern (C) void   wxCalendarCtrl_SetAttr(IntPtr self, int day, IntPtr attr);
        static extern (C) void   wxCalendarCtrl_SetHoliday(IntPtr self, int day);
        static extern (C) void   wxCalendarCtrl_ResetAttr(IntPtr self, int day);
        static extern (C) int    wxCalendarCtrl_HitTest(IntPtr self, inout Point pos, IntPtr date, inout DayOfWeek wd);

        //-----------------------------------------------------------------------------

    public class CalendarCtrl : Control
    {
        public const int wxCAL_SUNDAY_FIRST               = 0x0000;
        public const int wxCAL_MONDAY_FIRST               = 0x0001;
        public const int wxCAL_SHOW_HOLIDAYS              = 0x0002;
        public const int wxCAL_NO_YEAR_CHANGE             = 0x0004;
        public const int wxCAL_NO_MONTH_CHANGE            = 0x000c;
        public const int wxCAL_SEQUENTIAL_MONTH_SELECTION = 0x0010;
        public const int wxCAL_SHOW_SURROUNDING_WEEKS     = 0x0020;

        //-----------------------------------------------------------------------------

        public this(IntPtr wxobj)
            { super(wxobj); }
	    
        public this()
            { this(wxCalendarCtrl_ctor()); }

        public this(Window parent, int id)
            { this(parent, id, DateTime.Now, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, int id, DateTime date)
            { this(parent, id, date, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, int id, DateTime date, Point pos)
            { this(parent, id, date, pos, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, int id, DateTime date, Point pos, Size size)
            { this(parent, id, date, pos, size, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, int id, DateTime date, Point pos, Size size, int style)
            { this(parent, id, date, pos, size, style, "calendarCtrl"); }

        public this(Window parent, int id, DateTime date, Point pos, Size size, int style, string name)
        {
        	this(wxCalendarCtrl_ctor());
            if (!Create(parent, id, date, pos, size, style, name))
            {
				throw new InvalidOperationException("Failed to create CalendarCtrl");
            }
        }
	
	//-----------------------------------------------------------------------------
	// ctors with self created id
	
	public this(Window parent)
            { this(parent, Window.UniqueID, DateTime.Now, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, DateTime date)
            { this(parent, Window.UniqueID, date, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, DateTime date, Point pos)
            { this(parent, Window.UniqueID, date, pos, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, DateTime date, Point pos, Size size)
            { this(parent, Window.UniqueID, date, pos, size, wxCAL_SHOW_HOLIDAYS, "calendarCtrl"); }
	    
        public this(Window parent, DateTime date, Point pos, Size size, int style)
            { this(parent, Window.UniqueID, date, pos, size, style, "calendarCtrl"); }

        public this(Window parent, DateTime date, Point pos, Size size, int style, string name)
		{ this(parent, Window.UniqueID, date, pos, size, style, name);}
		
	//-----------------------------------------------------------------------------

        public bool Create(Window parent, int id, DateTime date, Point pos, Size size, int style, string name)
        {
            return wxCalendarCtrl_Create(wxobj, wxObject.SafePtr(parent), id, wxObject.SafePtr(cast(wxDateTime)date), pos, size, cast(uint)style, name);
        }

        //-----------------------------------------------------------------------------

        public void Date(DateTime value) { wxCalendarCtrl_SetDate(wxobj, wxObject.SafePtr(cast(wxDateTime)value)); }
        public DateTime Date() { return new wxDateTime(wxCalendarCtrl_GetDate(wxobj)); }

        //-----------------------------------------------------------------------------

        public void LowerDateLimit(DateTime value) { wxCalendarCtrl_SetLowerDateLimit(wxobj, wxObject.SafePtr(cast(wxDateTime)value)); }
        public DateTime LowerDateLimit() { return new wxDateTime(wxCalendarCtrl_GetLowerDateLimit(wxobj)); }

        public void UpperDateLimit(DateTime value) { wxCalendarCtrl_SetUpperDateLimit(wxobj, wxObject.SafePtr(cast(wxDateTime)value)); }
        public DateTime UpperDateLimit() { return new wxDateTime(wxCalendarCtrl_GetUpperDateLimit(wxobj)); }

        //-----------------------------------------------------------------------------

        public bool SetDateRange(DateTime lowerdate, DateTime upperdate)
        {
            return wxCalendarCtrl_SetDateRange(wxobj, wxObject.SafePtr(cast(wxDateTime)lowerdate), wxObject.SafePtr(cast(wxDateTime)upperdate));
        }

        //-----------------------------------------------------------------------------

        public void EnableYearChange(bool value) { wxCalendarCtrl_EnableYearChange(wxobj, value); }

        public void EnableMonthChange(bool value) { wxCalendarCtrl_EnableMonthChange(wxobj, value); }

        public void EnableHolidayDisplay(bool value) { wxCalendarCtrl_EnableHolidayDisplay(wxobj, value); }

        //-----------------------------------------------------------------------------

        public void SetHeaderColours(Colour colFg, Colour colBg)
        {
            wxCalendarCtrl_SetHeaderColours(wxobj, wxObject.SafePtr(colFg), wxObject.SafePtr(colBg));
        }

        public Colour HeaderColourFg() { return new Colour(wxCalendarCtrl_GetHeaderColourFg(wxobj), true); }

        public Colour HeaderColourBg() { return new Colour(wxCalendarCtrl_GetHeaderColourBg(wxobj), true); }

        //-----------------------------------------------------------------------------

        public void SetHighlightColours(Colour colFg, Colour colBg)
        {
            wxCalendarCtrl_SetHighlightColours(wxobj, wxObject.SafePtr(colFg), wxObject.SafePtr(colBg));
        }

        public Colour HighlightColourFg() { return new Colour(wxCalendarCtrl_GetHighlightColourFg(wxobj)); }

        public Colour HighlightColourBg() { return new Colour(wxCalendarCtrl_GetHighlightColourBg(wxobj)); }

        //-----------------------------------------------------------------------------

        public void SetHolidayColours(Colour colFg, Colour colBg)
        {
            wxCalendarCtrl_SetHolidayColours(wxobj, wxObject.SafePtr(colFg), wxObject.SafePtr(colBg));
        }

        public Colour HolidayColourFg() { return new Colour(wxCalendarCtrl_GetHolidayColourFg(wxobj)); }

        public Colour HolidayColourBg() { return new Colour(wxCalendarCtrl_GetHolidayColourBg(wxobj)); }

        //-----------------------------------------------------------------------------

        public CalendarDateAttr GetAttr(int day)
        {
            return cast(CalendarDateAttr)FindObject(wxCalendarCtrl_GetAttr(wxobj, day), &CalendarDateAttr.New);
        }

        public void SetAttr(int day, CalendarDateAttr attr)
        {
            wxCalendarCtrl_SetAttr(wxobj, day, wxObject.SafePtr(attr));
        }

        //-----------------------------------------------------------------------------

        public void SetHoliday(int day)
        {
            wxCalendarCtrl_SetHoliday(wxobj, day);
        }

        //-----------------------------------------------------------------------------

        public void ResetAttr(int day)
        {
            wxCalendarCtrl_ResetAttr(wxobj, day);
        }

        //-----------------------------------------------------------------------------

        public CalendarHitTestResult HitTest(Point pos, inout DateTime date, inout DayOfWeek wd)
        {
            wxDateTime dt = date;
            CalendarHitTestResult res = cast(CalendarHitTestResult)wxCalendarCtrl_HitTest(wxobj, pos, wxObject.SafePtr(dt), wd);
            date = dt;

            return res;
        }

        //-----------------------------------------------------------------------------

		public void SelectionChange_Add(EventListener value) { AddCommandListener(Event.wxEVT_CALENDAR_SEL_CHANGED, ID, value, this); }
		public void SelectionChange_Remove(EventListener value) { RemoveHandler(value, this); }

		public void DayChange_Add(EventListener value) { AddCommandListener(Event.wxEVT_CALENDAR_DAY_CHANGED, ID, value, this); }
		public void DayChange_Remove(EventListener value) { RemoveHandler(value, this); }

		public void MonthChange_Add(EventListener value) { AddCommandListener(Event.wxEVT_CALENDAR_MONTH_CHANGED, ID, value, this); }
		public void MonthChange_Remove(EventListener value) { RemoveHandler(value, this); }

		public void YearChange_Add(EventListener value) { AddCommandListener(Event.wxEVT_CALENDAR_YEAR_CHANGED, ID, value, this); }
		public void YearChange_Remove(EventListener value) { RemoveHandler(value, this); }

		public void DoubleClick_Add(EventListener value) { AddCommandListener(Event.wxEVT_CALENDAR_DOUBLECLICKED, ID, value, this); }
		public void DoubleClick_Remove(EventListener value) { RemoveHandler(value, this); }

		public void WeekdayClick_Add(EventListener value) { AddCommandListener(Event.wxEVT_CALENDAR_WEEKDAY_CLICKED, ID, value, this); }
		public void WeekdayClick_Remove(EventListener value) { RemoveHandler(value, this); }
    }

        static extern (C) IntPtr wxCalendarDateAttr_ctor();
        //static extern (C) IntPtr wxCalendarDateAttr_ctor(IntPtr colText, IntPtr colBack, IntPtr colBorder, IntPtr font, wxCalendarDateBorder border);
        //static extern (C) IntPtr wxCalendarDateAttr_ctor(wxCalendarDateBorder border, IntPtr colBorder);
	static extern (C) void   wxCalendarDateAttr_dtor(IntPtr self);
	static extern (C) void   wxCalendarDateAttr_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
        static extern (C) void   wxCalendarDateAttr_SetTextColour(IntPtr self, IntPtr colText);
        static extern (C) void   wxCalendarDateAttr_SetBackgroundColour(IntPtr self, IntPtr colBack);
        static extern (C) void   wxCalendarDateAttr_SetBorderColour(IntPtr self, IntPtr col);
        static extern (C) void   wxCalendarDateAttr_SetFont(IntPtr self, IntPtr font);
        static extern (C) void   wxCalendarDateAttr_SetBorder(IntPtr self, int border);
        static extern (C) void   wxCalendarDateAttr_SetHoliday(IntPtr self, bool holiday);
        static extern (C) bool   wxCalendarDateAttr_HasTextColour(IntPtr self);
        static extern (C) bool   wxCalendarDateAttr_HasBackgroundColour(IntPtr self);
        static extern (C) bool   wxCalendarDateAttr_HasBorderColour(IntPtr self);
        static extern (C) bool   wxCalendarDateAttr_HasFont(IntPtr self);
        static extern (C) bool   wxCalendarDateAttr_HasBorder(IntPtr self);
        static extern (C) bool   wxCalendarDateAttr_IsHoliday(IntPtr self);
        static extern (C) IntPtr wxCalendarDateAttr_GetTextColour(IntPtr self);
        static extern (C) IntPtr wxCalendarDateAttr_GetBackgroundColour(IntPtr self);
        static extern (C) IntPtr wxCalendarDateAttr_GetBorderColour(IntPtr self);
        static extern (C) IntPtr wxCalendarDateAttr_GetFont(IntPtr self);
        static extern (C) int    wxCalendarDateAttr_GetBorder(IntPtr self);
	
        //-----------------------------------------------------------------------------

    public class CalendarDateAttr : wxObject
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
	{ 
		this(wxCalendarDateAttr_ctor(), true);
		wxCalendarDateAttr_RegisterDisposable(wxobj, &VirtualDispose);
	}

        //public this(Colour colText, Colour colBack, Colour colBorder, Font font, CalendarDateBorder border)
        //    { super(wxCalendarDateAttr_ctor(wxObject.SafePtr(colText), wxObject.SafePtr(colBack), wxObject.SafePtr(colBorder), wxObject.SafePtr(font), border)); }

        //public  this(CalendarDateBorder border, Colour colBorder)
        //    { super(wxCalendarDateAttr_ctor(wxObject.SafePtr(border), wxObject.SafePtr(colBorder))); }
	
	//---------------------------------------------------------------------
				
	override private void dtor() { wxCalendarDateAttr_dtor(wxobj); }

        //-----------------------------------------------------------------------------

        public void TextColour(Colour value) { wxCalendarDateAttr_SetTextColour(wxobj, wxObject.SafePtr(value)); }
        public Colour TextColour() { return new Colour(wxCalendarDateAttr_GetTextColour(wxobj)); }

        //-----------------------------------------------------------------------------

        public void BackgroundColour(Colour value) { wxCalendarDateAttr_SetBackgroundColour(wxobj, wxObject.SafePtr(value)); }
        public Colour BackgroundColour() { return new Colour(wxCalendarDateAttr_GetBackgroundColour(wxobj)); }

        //-----------------------------------------------------------------------------

        public void BorderColour(Colour value) { wxCalendarDateAttr_SetBorderColour(wxobj, wxObject.SafePtr(value)); }
        public Colour BorderColour() { return new Colour(wxCalendarDateAttr_GetBorderColour(wxobj)); }

        //-----------------------------------------------------------------------------

        public void font(Font value) { wxCalendarDateAttr_SetFont(wxobj, wxObject.SafePtr(value)); }
        public Font font() { return new Font(wxCalendarDateAttr_GetFont(wxobj)); }

        //-----------------------------------------------------------------------------

        public void Border(CalendarDateBorder value) { wxCalendarDateAttr_SetBorder(wxobj, cast(int)value); }
        public CalendarDateBorder Border() { return cast(CalendarDateBorder)wxCalendarDateAttr_GetBorder(wxobj); }

        //-----------------------------------------------------------------------------

        public void IsHoliday(bool value) { wxCalendarDateAttr_SetHoliday(wxobj, value); }
        public bool IsHoliday() { return wxCalendarDateAttr_IsHoliday(wxobj); }

        //-----------------------------------------------------------------------------

        public bool HasTextColour() { return wxCalendarDateAttr_HasTextColour(wxobj); }

        public bool HasBackgroundColour() { return wxCalendarDateAttr_HasBackgroundColour(wxobj); }

        public bool HasBorderColour() { return wxCalendarDateAttr_HasBorderColour(wxobj); }

        public bool HasFont() { return wxCalendarDateAttr_HasFont(wxobj); }

        public bool HasBorder() { return wxCalendarDateAttr_HasBorder(wxobj); }


	public static wxObject New(IntPtr ptr) { return new CalendarDateAttr(ptr); }
        //-----------------------------------------------------------------------------
    }

        static extern (C) IntPtr wxCalendarEvent_ctor();
        //static extern (C) IntPtr wxCalendarEvent_ctor(IntPtr cal, wxEventType type);
        static extern (C) IntPtr wxCalendarEvent_GetDate(IntPtr self);
        static extern (C) int    wxCalendarEvent_GetWeekDay(IntPtr self);

        //-----------------------------------------------------------------------------
	
    public class CalendarEvent : CommandEvent
    {
	public this(IntPtr wxobj)
		{ super(wxobj);}

        public this()
            { this(wxCalendarEvent_ctor()); }

        //-----------------------------------------------------------------------------

        //public this(CalendarCtrl cal, EventType type)
        //    { super(wxCalendarEvent_ctor(wxObject.SafePtr(cal), wxObject.SafePtr(type))); }

        //-----------------------------------------------------------------------------

        public DateTime Date() { return new wxDateTime(wxCalendarEvent_GetDate(wxobj)); }

        public DayOfWeek WeekDay() { return cast(DayOfWeek)wxCalendarEvent_GetWeekDay(wxobj); }

		private static Event New(IntPtr obj) { return new CalendarEvent(obj); }

		static this()
		{
			AddEventType(wxEVT_CALENDAR_SEL_CHANGED,            &CalendarEvent.New);
			AddEventType(wxEVT_CALENDAR_DAY_CHANGED,            &CalendarEvent.New);
			AddEventType(wxEVT_CALENDAR_MONTH_CHANGED,          &CalendarEvent.New);
			AddEventType(wxEVT_CALENDAR_YEAR_CHANGED,           &CalendarEvent.New);
			AddEventType(wxEVT_CALENDAR_DOUBLECLICKED,          &CalendarEvent.New);
			AddEventType(wxEVT_CALENDAR_WEEKDAY_CLICKED,        &CalendarEvent.New);
		}
    }

