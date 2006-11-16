//-----------------------------------------------------------------------------
// wx.NET - CalendarCtrl.cs
// 
// The wxCalendarCtrl wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System.Runtime.InteropServices;
using System.Drawing;
using System;

namespace wx
{
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

    public class CalendarCtrl : Control
    {
        public const long wxCAL_SUNDAY_FIRST               = 0x0000;
        public const long wxCAL_MONDAY_FIRST               = 0x0001;
        public const long wxCAL_SHOW_HOLIDAYS              = 0x0002;
        public const long wxCAL_NO_YEAR_CHANGE             = 0x0004;
        public const long wxCAL_NO_MONTH_CHANGE            = 0x000c;
        public const long wxCAL_SEQUENTIAL_MONTH_SELECTION = 0x0010;
        public const long wxCAL_SHOW_SURROUNDING_WEEKS     = 0x0020;

        //-----------------------------------------------------------------------------

        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_ctor();
        [DllImport("wx-c")] static extern bool   wxCalendarCtrl_Create(IntPtr self, IntPtr parent, int id, IntPtr date, ref Point pos, ref Size size, uint style, string name);
        [DllImport("wx-c")] static extern bool   wxCalendarCtrl_SetDate(IntPtr self, IntPtr date);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetDate(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarCtrl_SetLowerDateLimit(IntPtr self, IntPtr date);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetLowerDateLimit(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarCtrl_SetUpperDateLimit(IntPtr self, IntPtr date);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetUpperDateLimit(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarCtrl_SetDateRange(IntPtr self, IntPtr lowerdate, IntPtr upperdate);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_EnableYearChange(IntPtr self, bool enable);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_EnableMonthChange(IntPtr self, bool enable);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_EnableHolidayDisplay(IntPtr self, bool display);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_SetHeaderColours(IntPtr self, IntPtr colFg, IntPtr colBg);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetHeaderColourFg(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetHeaderColourBg(IntPtr self);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_SetHighlightColours(IntPtr self, IntPtr colFg, IntPtr colBg);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetHighlightColourFg(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetHighlightColourBg(IntPtr self);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_SetHolidayColours(IntPtr self, IntPtr colFg, IntPtr colBg);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetHolidayColourFg(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetHolidayColourBg(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarCtrl_GetAttr(IntPtr self, int day);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_SetAttr(IntPtr self, int day, IntPtr attr);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_SetHoliday(IntPtr self, int day);
        [DllImport("wx-c")] static extern void   wxCalendarCtrl_ResetAttr(IntPtr self, int day);
        [DllImport("wx-c")] static extern int    wxCalendarCtrl_HitTest(IntPtr self, ref Point pos, IntPtr date, ref DayOfWeek wd);

        //-----------------------------------------------------------------------------

        public CalendarCtrl(IntPtr wxObject)
            : base(wxObject) { }
	    
        public CalendarCtrl()
            : this(wxCalendarCtrl_ctor()) { }

        public CalendarCtrl(Window parent, int id)
            : this(parent, id, DateTime.Now, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, int id, DateTime date)
            : this(parent, id, date, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, int id, DateTime date, Point pos)
            : this(parent, id, date, pos, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, int id, DateTime date, Point pos, Size size)
            : this(parent, id, date, pos, size, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, int id, DateTime date, Point pos, Size size, long style)
            : this(parent, id, date, pos, size, style, "calendarCtrl") { }

        public CalendarCtrl(Window parent, int id, DateTime date, Point pos, Size size, long style, string name)
            : this(wxCalendarCtrl_ctor())
        {
            if (!Create(parent, id, date, pos, size, style, name))
            {
				throw new InvalidOperationException("Failed to create CalendarCtrl");
            }
        }
	
	//-----------------------------------------------------------------------------
	// ctors with self created id
	
	public CalendarCtrl(Window parent)
            : this(parent, Window.UniqueID, DateTime.Now, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, DateTime date)
            : this(parent, Window.UniqueID, date, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, DateTime date, Point pos)
            : this(parent, Window.UniqueID, date, pos, wxDefaultSize, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, DateTime date, Point pos, Size size)
            : this(parent, Window.UniqueID, date, pos, size, wxCAL_SHOW_HOLIDAYS, "calendarCtrl") { }
	    
        public CalendarCtrl(Window parent, DateTime date, Point pos, Size size, long style)
            : this(parent, Window.UniqueID, date, pos, size, style, "calendarCtrl") { }

        public CalendarCtrl(Window parent, DateTime date, Point pos, Size size, long style, string name)
		: this(parent, Window.UniqueID, date, pos, size, style, name) {}
		
	//-----------------------------------------------------------------------------

        public bool Create(Window parent, int id, DateTime date, Point pos, Size size, long style, string name)
        {
            return wxCalendarCtrl_Create(wxObject, Object.SafePtr(parent), id, Object.SafePtr((wxDateTime)date), ref pos, ref size, (uint)style, name);
        }

        //-----------------------------------------------------------------------------

        public DateTime Date
        {
            set { wxCalendarCtrl_SetDate(wxObject, Object.SafePtr((wxDateTime)value)); }
            get { return new wxDateTime(wxCalendarCtrl_GetDate(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public DateTime LowerDateLimit
        {
            set { wxCalendarCtrl_SetLowerDateLimit(wxObject, Object.SafePtr((wxDateTime)value)); }
            get { return new wxDateTime(wxCalendarCtrl_GetLowerDateLimit(wxObject)); }
        }

        public DateTime UpperDateLimit
        {
            set { wxCalendarCtrl_SetUpperDateLimit(wxObject, Object.SafePtr((wxDateTime)value)); }
            get { return new wxDateTime(wxCalendarCtrl_GetUpperDateLimit(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public bool SetDateRange(DateTime lowerdate, DateTime upperdate)
        {
            return wxCalendarCtrl_SetDateRange(wxObject, Object.SafePtr((wxDateTime)lowerdate), Object.SafePtr((wxDateTime)upperdate));
        }

        //-----------------------------------------------------------------------------

        public bool EnableYearChange
        {
            set { wxCalendarCtrl_EnableYearChange(wxObject, value); }
        }

        public bool EnableMonthChange
        {
            set { wxCalendarCtrl_EnableMonthChange(wxObject, value); }
        }

        public bool EnableHolidayDisplay
        {
            set { wxCalendarCtrl_EnableHolidayDisplay(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public void SetHeaderColours(Colour colFg, Colour colBg)
        {
            wxCalendarCtrl_SetHeaderColours(wxObject, Object.SafePtr(colFg), Object.SafePtr(colBg));
        }

        public Colour HeaderColourFg
        {
            get { return new Colour(wxCalendarCtrl_GetHeaderColourFg(wxObject), true); }
        }

        public Colour HeaderColourBg
        {
            get { return new Colour(wxCalendarCtrl_GetHeaderColourBg(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public void SetHighlightColours(Colour colFg, Colour colBg)
        {
            wxCalendarCtrl_SetHighlightColours(wxObject, Object.SafePtr(colFg), Object.SafePtr(colBg));
        }

        public Colour HighlightColourFg
        {
            get { return new Colour(wxCalendarCtrl_GetHighlightColourFg(wxObject)); }
        }

        public Colour HighlightColourBg
        {
            get { return new Colour(wxCalendarCtrl_GetHighlightColourBg(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public void SetHolidayColours(Colour colFg, Colour colBg)
        {
            wxCalendarCtrl_SetHolidayColours(wxObject, Object.SafePtr(colFg), Object.SafePtr(colBg));
        }

        public Colour HolidayColourFg
        {
            get { return new Colour(wxCalendarCtrl_GetHolidayColourFg(wxObject)); }
        }

        public Colour HolidayColourBg
        {
            get { return new Colour(wxCalendarCtrl_GetHolidayColourBg(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public CalendarDateAttr GetAttr(int day)
        {
            return (CalendarDateAttr)Object.FindObject(wxCalendarCtrl_GetAttr(wxObject, day), typeof(CalendarDateAttr));
        }

        public void SetAttr(int day, CalendarDateAttr attr)
        {
            wxCalendarCtrl_SetAttr(wxObject, day, Object.SafePtr(attr));
        }

        //-----------------------------------------------------------------------------

        public void SetHoliday(int day)
        {
            wxCalendarCtrl_SetHoliday(wxObject, day);
        }

        //-----------------------------------------------------------------------------

        public void ResetAttr(int day)
        {
            wxCalendarCtrl_ResetAttr(wxObject, day);
        }

        //-----------------------------------------------------------------------------

        public CalendarHitTestResult HitTest(Point pos, ref DateTime date, ref DayOfWeek wd)
        {
            wxDateTime dt = date;
            CalendarHitTestResult res = (CalendarHitTestResult)wxCalendarCtrl_HitTest(wxObject, ref pos, Object.SafePtr(dt), ref wd);
            date = dt;

            return res;
        }

        //-----------------------------------------------------------------------------

		public event EventListener SelectionChange
		{
			add { AddCommandListener(Event.wxEVT_CALENDAR_SEL_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DayChange
		{
			add { AddCommandListener(Event.wxEVT_CALENDAR_DAY_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener MonthChange
		{
			add { AddCommandListener(Event.wxEVT_CALENDAR_MONTH_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener YearChange
		{
			add { AddCommandListener(Event.wxEVT_CALENDAR_YEAR_CHANGED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener DoubleClick
		{
			add { AddCommandListener(Event.wxEVT_CALENDAR_DOUBLECLICKED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener WeekdayClick
		{
			add { AddCommandListener(Event.wxEVT_CALENDAR_WEEKDAY_CLICKED, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
    }

    public class CalendarDateAttr : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxCalendarDateAttr_ctor();
        //[DllImport("wx-c")] static extern IntPtr wxCalendarDateAttr_ctor(IntPtr colText, IntPtr colBack, IntPtr colBorder, IntPtr font, wxCalendarDateBorder border);
        //[DllImport("wx-c")] static extern IntPtr wxCalendarDateAttr_ctor(wxCalendarDateBorder border, IntPtr colBorder);
	[DllImport("wx-c")] static extern void   wxCalendarDateAttr_dtor(IntPtr self);
	[DllImport("wx-c")] static extern void   wxCalendarDateAttr_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
        [DllImport("wx-c")] static extern void   wxCalendarDateAttr_SetTextColour(IntPtr self, IntPtr colText);
        [DllImport("wx-c")] static extern void   wxCalendarDateAttr_SetBackgroundColour(IntPtr self, IntPtr colBack);
        [DllImport("wx-c")] static extern void   wxCalendarDateAttr_SetBorderColour(IntPtr self, IntPtr col);
        [DllImport("wx-c")] static extern void   wxCalendarDateAttr_SetFont(IntPtr self, IntPtr font);
        [DllImport("wx-c")] static extern void   wxCalendarDateAttr_SetBorder(IntPtr self, int border);
        [DllImport("wx-c")] static extern void   wxCalendarDateAttr_SetHoliday(IntPtr self, bool holiday);
        [DllImport("wx-c")] static extern bool   wxCalendarDateAttr_HasTextColour(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarDateAttr_HasBackgroundColour(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarDateAttr_HasBorderColour(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarDateAttr_HasFont(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarDateAttr_HasBorder(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxCalendarDateAttr_IsHoliday(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarDateAttr_GetTextColour(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarDateAttr_GetBackgroundColour(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarDateAttr_GetBorderColour(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxCalendarDateAttr_GetFont(IntPtr self);
        [DllImport("wx-c")] static extern int    wxCalendarDateAttr_GetBorder(IntPtr self);
	
        //-----------------------------------------------------------------------------

        public CalendarDateAttr(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal CalendarDateAttr(IntPtr wxObject, bool memOwn)
			: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}

        public CalendarDateAttr()
            : this(wxCalendarDateAttr_ctor(), true) 
	{ 
		virtual_Dispose = new Virtual_Dispose(VirtualDispose);
		wxCalendarDateAttr_RegisterDisposable(wxObject, virtual_Dispose);
	}

        //public CalendarDateAttr(Colour colText, Colour colBack, Colour colBorder, Font font, CalendarDateBorder border)
        //    : base(wxCalendarDateAttr_ctor(Object.SafePtr(colText), Object.SafePtr(colBack), Object.SafePtr(colBorder), Object.SafePtr(font), border)) { }

        //public  CalendarDateAttr(CalendarDateBorder border, Colour colBorder)
        //    : base(wxCalendarDateAttr_ctor(Object.SafePtr(border), Object.SafePtr(colBorder))) { }
	
	//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxCalendarDateAttr_dtor(wxObject);
						memOwn = false;
					}
				}
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~CalendarDateAttr() 
		{
			Dispose();
		}

        //-----------------------------------------------------------------------------

        public Colour TextColour
        {
            set { wxCalendarDateAttr_SetTextColour(wxObject, Object.SafePtr(value)); }
            get { return new Colour(wxCalendarDateAttr_GetTextColour(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public Colour BackgroundColour
        {
            set { wxCalendarDateAttr_SetBackgroundColour(wxObject, Object.SafePtr(value)); }
            get { return new Colour(wxCalendarDateAttr_GetBackgroundColour(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public Colour BorderColour
        {
            set { wxCalendarDateAttr_SetBorderColour(wxObject, Object.SafePtr(value)); }
            get { return new Colour(wxCalendarDateAttr_GetBorderColour(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public Font Font
        {
            set { wxCalendarDateAttr_SetFont(wxObject, Object.SafePtr(value)); }
            get { return new Font(wxCalendarDateAttr_GetFont(wxObject)); }
        }

        //-----------------------------------------------------------------------------

        public CalendarDateBorder Border
        {
            set { wxCalendarDateAttr_SetBorder(wxObject, (int)value); }
            get { return (CalendarDateBorder)wxCalendarDateAttr_GetBorder(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool IsHoliday
        {
            set { wxCalendarDateAttr_SetHoliday(wxObject, value); }
            get { return wxCalendarDateAttr_IsHoliday(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool HasTextColour
        {
            get { return wxCalendarDateAttr_HasTextColour(wxObject); }
        }

        public bool HasBackgroundColour
        {
            get { return wxCalendarDateAttr_HasBackgroundColour(wxObject); }
        }

        public bool HasBorderColour
        {
            get { return wxCalendarDateAttr_HasBorderColour(wxObject); }
        }

        public bool HasFont
        {
            get { return wxCalendarDateAttr_HasFont(wxObject); }
        }

        public bool HasBorder
        {
            get { return wxCalendarDateAttr_HasBorder(wxObject); }
        }

        //-----------------------------------------------------------------------------
    }

    public class CalendarEvent : CommandEvent
    {
        [DllImport("wx-c")] static extern IntPtr wxCalendarEvent_ctor();
        //[DllImport("wx-c")] static extern IntPtr wxCalendarEvent_ctor(IntPtr cal, wxEventType type);
        [DllImport("wx-c")] static extern IntPtr wxCalendarEvent_GetDate(IntPtr self);
        [DllImport("wx-c")] static extern int    wxCalendarEvent_GetWeekDay(IntPtr self);

        //-----------------------------------------------------------------------------
	
	public CalendarEvent(IntPtr wxObject)
		: base(wxObject) {}

        public CalendarEvent()
            : this(wxCalendarEvent_ctor()) { }

        //-----------------------------------------------------------------------------

        //public CalendarEvent(CalendarCtrl cal, EventType type)
        //    : base(wxCalendarEvent_ctor(Object.SafePtr(cal), Object.SafePtr(type))) { }

        //-----------------------------------------------------------------------------

        public DateTime Date
        {
            get { return new wxDateTime(wxCalendarEvent_GetDate(wxObject)); }
        }

        public DayOfWeek WeekDay
        {
            get { return (DayOfWeek)wxCalendarEvent_GetWeekDay(wxObject); }
        }
    }
}

