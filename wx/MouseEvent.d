//-----------------------------------------------------------------------------
// wx.NET - MouseEvent.cs
//
// The wxMouseEvent wrapper class.
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
    public class MouseEvent : Event
    {
        [DllImport("wx-c")] static extern IntPtr wxMouseEvent_ctor(int mouseType);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_IsButton(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_ButtonDown(IntPtr self);
	[DllImport("wx-c")] static extern bool   wxMouseEvent_ButtonDown2(IntPtr self, int button);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_ButtonDClick(IntPtr self, int but);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_ButtonUp(IntPtr self, int but);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_Button(IntPtr self, int but);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_ButtonIsDown(IntPtr self, int but);
        [DllImport("wx-c")] static extern int    wxMouseEvent_GetButton(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_ControlDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_MetaDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_AltDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_ShiftDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_LeftDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_MiddleDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_RightDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_LeftUp(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_MiddleUp(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_RightUp(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_LeftDClick(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_MiddleDClick(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_RightDClick(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_LeftIsDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_MiddleIsDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_RightIsDown(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_Dragging(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_Moving(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_Entering(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_Leaving(IntPtr self);
        [DllImport("wx-c")] static extern void   wxMouseEvent_GetPosition(IntPtr self, ref Point pos);
        [DllImport("wx-c")] static extern void   wxMouseEvent_LogicalPosition(IntPtr self, IntPtr dc, ref Point pos);
        [DllImport("wx-c")] static extern int    wxMouseEvent_GetWheelRotation(IntPtr self);
        [DllImport("wx-c")] static extern int    wxMouseEvent_GetWheelDelta(IntPtr self);
        [DllImport("wx-c")] static extern int    wxMouseEvent_GetLinesPerAction(IntPtr self);
        [DllImport("wx-c")] static extern bool   wxMouseEvent_IsPageScroll(IntPtr self);

		//----------------------------------------------------------------------------

		public MouseEvent(IntPtr wxObject) 
            : base(wxObject) { }

        public MouseEvent(int mouseType)
            : base(wxMouseEvent_ctor(mouseType)) { }

		//----------------------------------------------------------------------------

        public bool IsButton
        {
            get { return wxMouseEvent_IsButton(wxObject); }
        }
	
	//----------------------------------------------------------------------------

        public bool ButtonDown()
        {
            //get { return wxMouseEvent_ButtonDown(wxObject); }
	    return ButtonDown(MouseButton.wxMOUSE_BTN_ANY);
        }
	
	public bool ButtonDown(MouseButton but)
	{
		return wxMouseEvent_ButtonDown2(wxObject, (int)but);
	}
	
	//----------------------------------------------------------------------------
	
	public bool ButtonDClick()
	{
		return ButtonDClick(MouseButton.wxMOUSE_BTN_ANY);
	}

        public bool ButtonDClick(MouseButton but)
        {
            return wxMouseEvent_ButtonDClick(wxObject, (int)but);
        }
	
	//----------------------------------------------------------------------------
	
	public bool ButtonUp()
	{
		return ButtonUp(MouseButton.wxMOUSE_BTN_ANY);
	}

        public bool ButtonUp(MouseButton but)
        {
            return wxMouseEvent_ButtonUp(wxObject, (int)but);
        }
	
	//----------------------------------------------------------------------------

        public bool Button(int but)
        {
            return wxMouseEvent_Button(wxObject, but);
        }

        public bool ButtonIsDown(int but)
        {
            return wxMouseEvent_ButtonIsDown(wxObject, but);
        }

        public int Button()
        {
            return wxMouseEvent_GetButton(wxObject);
        }

		//----------------------------------------------------------------------------

        public bool ControlDown
        {
            get { return wxMouseEvent_ControlDown(wxObject); }
        }

        public bool MetaDown
        {
            get { return wxMouseEvent_MetaDown(wxObject); }
        }

        public bool AltDown
        {
            get { return wxMouseEvent_AltDown(wxObject); }
        }

        public bool ShiftDown
        {
            get { return wxMouseEvent_ShiftDown(wxObject); }
        }

		//----------------------------------------------------------------------------

        public bool LeftDown
        {
            get { return wxMouseEvent_LeftDown(wxObject); }
        }

        public bool MiddleDown
        {
            get { return wxMouseEvent_MiddleDown(wxObject); }
        }

        public bool RightDown
        {
            get { return wxMouseEvent_RightDown(wxObject); }
        }

		//----------------------------------------------------------------------------

        public bool LeftUp
        {
            get { return wxMouseEvent_LeftUp(wxObject); }
        }

        public bool MiddleUp
        {
            get { return wxMouseEvent_MiddleUp(wxObject); }
        }

        public bool RightUp
        {
            get { return wxMouseEvent_RightUp(wxObject); }
        }

		//----------------------------------------------------------------------------

        public bool LeftDClick
        {
            get { return wxMouseEvent_LeftDClick(wxObject); }
        }

        public bool MiddleDClick
        {
            get { return wxMouseEvent_MiddleDClick(wxObject); }
        }

        public bool RightDClick
        {
            get { return wxMouseEvent_RightDClick(wxObject); }
        }

		//----------------------------------------------------------------------------

        public bool LeftIsDown
        {
            get { return wxMouseEvent_LeftIsDown(wxObject); }
        }

        public bool MiddleIsDown
        {
            get { return wxMouseEvent_MiddleIsDown(wxObject); }
        }

        public bool RightIsDown
        {
            get { return wxMouseEvent_RightIsDown(wxObject); }
        }

		//----------------------------------------------------------------------------

        public bool Dragging
        {
            get { return wxMouseEvent_Dragging(wxObject); }
        }

        public bool Moving
        {
            get { return wxMouseEvent_Moving(wxObject); }
        }

        public bool Entering
        {
            get { return wxMouseEvent_Entering(wxObject); }
        }

        public bool Leaving
        {
            get { return wxMouseEvent_Leaving(wxObject); }
        }

		//----------------------------------------------------------------------------

        public Point Position
        {
            get { 
                Point pos = new Point();
                wxMouseEvent_GetPosition(wxObject, ref pos);
                return pos;
            }
        }

        public Point LogicalPosition(DC dc)
        {
			Point pos = new Point();
            wxMouseEvent_LogicalPosition(wxObject, Object.SafePtr(dc), ref pos);
			return pos;
        }

		//----------------------------------------------------------------------------

        public int WheelRotation
        {
            get { return wxMouseEvent_GetWheelRotation(wxObject); }
        }

        public int WheelDelta
        {
            get { return wxMouseEvent_GetWheelDelta(wxObject); }
        }

        public int LinesPerAction
        {
            get { return wxMouseEvent_GetLinesPerAction(wxObject); }
        }

        public bool IsPageScroll
        {
            get { return wxMouseEvent_IsPageScroll(wxObject); }
        }

		//----------------------------------------------------------------------------
    }
}

