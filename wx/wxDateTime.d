//-----------------------------------------------------------------------------
// wxD - DateTime.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - DateTime.cs
// 
// The wxDateTime wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.wxDateTime;
import wx.common;
//import std.date;

    alias wxDateTime DateTime;
    enum DayOfWeek
    {
        Sun, Mon, Tue, Wed, Thu, Fri, Sat, Inv_WeekDay
    };

/* wxDateTime imprementation is class { longlong } */

        static extern (C) IntPtr wxDefaultDateTime_Get();
        static extern (C) IntPtr wxDateTime_ctor();
        static extern (C) IntPtr wxDateTime_Now();
	static extern (C) void   wxDateTime_dtor(IntPtr self);
        static extern (C) void   wxDateTime_Set(IntPtr self, ushort day, int month, int year, ushort hour, ushort minute, ushort second, ushort millisec);
        static extern (C) ushort wxDateTime_GetYear(IntPtr self);
        static extern (C) int    wxDateTime_GetMonth(IntPtr self);
        static extern (C) ushort wxDateTime_GetDay(IntPtr self);
        static extern (C) ushort wxDateTime_GetHour(IntPtr self);
        static extern (C) ushort wxDateTime_GetMinute(IntPtr self);
        static extern (C) ushort wxDateTime_GetSecond(IntPtr self);
        static extern (C) ushort wxDateTime_GetMillisecond(IntPtr self);
	
        //-----------------------------------------------------------------------------

    public class wxDateTime : wxObject
    {
	static wxDateTime wxDefaultDateTime;
	static this()
	{
		wxDefaultDateTime = new wxDateTime(wxDefaultDateTime_Get());
	}

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
            { this(wxDateTime_ctor(), true); }
	    
	//---------------------------------------------------------------------
	
	override private void dtor() { wxDateTime_dtor(wxobj); }

        //-----------------------------------------------------------------------------

        public void Set(ushort day, int month, int year, ushort hour, ushort minute, ushort second, ushort millisec)
        {
            wxDateTime_Set(wxobj, day, month, year, hour, minute, second, millisec);
        }

        //-----------------------------------------------------------------------------

        public ushort Year() { return wxDateTime_GetYear(wxobj); }

        int Month() { return wxDateTime_GetMonth(wxobj); }

        ushort Day() { return wxDateTime_GetDay(wxobj); }

        ushort Hour() { return wxDateTime_GetHour(wxobj); }

        ushort Minute() { return wxDateTime_GetMinute(wxobj); }
        
        ushort Second() { return wxDateTime_GetSecond(wxobj); }

        ushort Millisecond() { return wxDateTime_GetMillisecond(wxobj); }

	static wxDateTime Now() { return new wxDateTime(wxDateTime_Now()); }
        //-----------------------------------------------------------------------------
/+
        public static implicit operator DateTime (wxDateTime wdt)
        {
            DateTime dt = new DateTime(wdt.Year, cast(int)wdt.Month, cast(int)wdt.Day, 
                                       cast(int)wdt.Hour, cast(int)wdt.Minute, 
                                       cast(int)wdt.Second, cast(int)wdt.Millisecond);
            return dt;
        }

        public static implicit operator wxDateTime (DateTime dt)
        {
            wxDateTime wdt = new this();
            wdt.Set((ushort)dt.Day, dt.Month, dt.Year, (ushort)dt.Hour, 
                    (ushort)dt.Minute, (ushort)dt.Second, 
                    (ushort)dt.Millisecond);
            return wdt;
        }
+/
        //-----------------------------------------------------------------------------
    }
