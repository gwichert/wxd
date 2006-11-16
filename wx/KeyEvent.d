//-----------------------------------------------------------------------------
// wx.NET - KeyEvent.cs
// 
// The wxKeyEvent wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class KeyEvent : Event
    {
        [DllImport("wx-c")] static extern IntPtr wxKeyEvent_ctor(int type);

        [DllImport("wx-c")] static extern bool   wxKeyEvent_ControlDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxKeyEvent_ShiftDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxKeyEvent_AltDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxKeyEvent_MetaDown(IntPtr self);

        [DllImport("wx-c")] static extern uint   wxKeyEvent_GetRawKeyCode(IntPtr self);
        [DllImport("wx-c")] static extern int    wxKeyEvent_GetKeyCode(IntPtr self);

        [DllImport("wx-c")] static extern uint   wxKeyEvent_GetRawKeyFlags(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxKeyEvent_HasModifiers(IntPtr self);

        [DllImport("wx-c")] static extern void   wxKeyEvent_GetPosition(IntPtr self, ref Point pt);
        [DllImport("wx-c")] static extern int    wxKeyEvent_GetX(IntPtr self);
        [DllImport("wx-c")] static extern int    wxKeyEvent_GetY(IntPtr self);
	
	[DllImport("wx-c")] static extern bool   wxKeyEvent_CmdDown(IntPtr self);

        //-----------------------------------------------------------------------------

        public KeyEvent(IntPtr wxObject) 
            : base(wxObject) { }

        public KeyEvent(int type)
            : this(wxKeyEvent_ctor(type)) { }

        //-----------------------------------------------------------------------------

        public bool ControlDown
        {
            get { return wxKeyEvent_ControlDown(wxObject); }
        }

        public bool MetaDown
        {
            get { return wxKeyEvent_MetaDown(wxObject); }
        }

        public bool ShiftDown
        {
            get { return wxKeyEvent_ShiftDown(wxObject); }
        }

        public bool AltDown
        {
            get { return wxKeyEvent_AltDown(wxObject); }
        }

        //-----------------------------------------------------------------------------

        /*public KeyCode KeyCode
        {
            get { return (KeyCode)wxKeyEvent_GetKeyCode(wxObject); }
        }*/
	
	public int KeyCode
        {
            get { return wxKeyEvent_GetKeyCode(wxObject); }
        }

        public long RawKeyCode
        {
            get { return wxKeyEvent_GetRawKeyCode(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public long RawKeyFlags
        {
            get { return wxKeyEvent_GetRawKeyFlags(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public bool HasModifiers
        {
            get { return wxKeyEvent_HasModifiers(wxObject); }
        }

        //-----------------------------------------------------------------------------

        public Point Position
        {
            get {
                Point pt = new Point();
                wxKeyEvent_GetPosition(wxObject, ref pt);
                return pt;
            }
        }

        //-----------------------------------------------------------------------------

        public int X
        {
            get { return wxKeyEvent_GetX(wxObject); }
        }

        public int Y
        {
            get { return wxKeyEvent_GetY(wxObject); }
        }

        //-----------------------------------------------------------------------------
	
	public bool CmdDown
	{
		get { return wxKeyEvent_CmdDown(wxObject); }
	}
    }
}
