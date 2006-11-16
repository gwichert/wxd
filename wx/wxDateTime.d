//-----------------------------------------------------------------------------
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

using System.Runtime.InteropServices;
using System.Drawing;
using System;

namespace wx
{
    public class wxDateTime : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxDateTime_ctor();
	[DllImport("wx-c")] static extern void   wxDateTime_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDateTime_Set(IntPtr self, ushort day, int month, int year, ushort hour, ushort minute, ushort second, ushort millisec);
        [DllImport("wx-c")] static extern ushort wxDateTime_GetYear(IntPtr self);
        [DllImport("wx-c")] static extern int    wxDateTime_GetMonth(IntPtr self);
        [DllImport("wx-c")] static extern ushort wxDateTime_GetDay(IntPtr self);
        [DllImport("wx-c")] static extern ushort wxDateTime_GetHour(IntPtr self);
        [DllImport("wx-c")] static extern ushort wxDateTime_GetMinute(IntPtr self);
        [DllImport("wx-c")] static extern ushort wxDateTime_GetSecond(IntPtr self);
        [DllImport("wx-c")] static extern ushort wxDateTime_GetMillisecond(IntPtr self);
	
        //-----------------------------------------------------------------------------

        public wxDateTime(IntPtr wxObject)
            : base(wxObject) 
	{ 
		this.wxObject = wxObject;
	}
	
	internal wxDateTime(IntPtr wxObject, bool memOwn)
			: base(wxObject)
	{ 
		this.memOwn = memOwn;
		this.wxObject = wxObject;
	}

        public wxDateTime()
            : this(wxDateTime_ctor(), true) { } 
	    
	//---------------------------------------------------------------------
				
	public override void Dispose()
	{
		if (!disposed)
		{
			if (wxObject != IntPtr.Zero)
			{
				if (memOwn)
				{
					wxDateTime_dtor(wxObject);
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
	
	~wxDateTime() 
	{
		Dispose();
	}

        //-----------------------------------------------------------------------------

        public void Set(ushort day, int month, int year, ushort hour, ushort minute, ushort second, ushort millisec)
        {
            wxDateTime_Set(wxObject, day, month, year, hour, minute, second, millisec);
        }

        //-----------------------------------------------------------------------------

        public ushort Year
        {
            get { return wxDateTime_GetYear(wxObject); }
        }

        int Month
        {
            get { return wxDateTime_GetMonth(wxObject); }
        }

        ushort Day
        {
            get { return wxDateTime_GetDay(wxObject); }
        }

        ushort Hour
        {
            get { return wxDateTime_GetHour(wxObject); }
        }

        ushort Minute
        {
            get { return wxDateTime_GetMinute(wxObject); }
        }
        
        ushort Second
        {
            get { return wxDateTime_GetSecond(wxObject); }
        }

        ushort Millisecond
        {
            get { return wxDateTime_GetMillisecond(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public static implicit operator DateTime (wxDateTime wdt)
        {
            DateTime dt = new DateTime(wdt.Year, (int)wdt.Month, (int)wdt.Day, 
                                       (int)wdt.Hour, (int)wdt.Minute, 
                                       (int)wdt.Second, (int)wdt.Millisecond);
            return dt;
        }

        public static implicit operator wxDateTime (DateTime dt)
        {
            wxDateTime wdt = new wxDateTime();
            wdt.Set((ushort)dt.Day, dt.Month, dt.Year, (ushort)dt.Hour, 
                    (ushort)dt.Minute, (ushort)dt.Second, 
                    (ushort)dt.Millisecond);
            return wdt;
        }

        //-----------------------------------------------------------------------------
    }
}

