//-----------------------------------------------------------------------------
// wx.NET - ProgressDialog.cs
//
// The wxProgressDialog wrapper class.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class ProgressDialog : Dialog
    {
        public const int wxPD_CAN_ABORT      = 0x0001;
        public const int wxPD_APP_MODAL      = 0x0002;
        public const int wxPD_AUTO_HIDE      = 0x0004;
        public const int wxPD_ELAPSED_TIME   = 0x0008;
        public const int wxPD_ESTIMATED_TIME = 0x0010;
        public const int wxPD_REMAINING_TIME = 0x0040;
	
	internal bool xdisposed = false;

		//---------------------------------------------------------------------

        [DllImport("wx-c")] static extern IntPtr wxProgressDialog_ctor(string title, string message, int maximum, IntPtr parent, uint style);
	[DllImport("wx-c")] static extern void wxProgressDialog_dtor(IntPtr self);
        [DllImport("wx-c")] static extern bool wxProgressDialog_Update(IntPtr self, int value, string newmsg);
        [DllImport("wx-c")] static extern void wxProgressDialog_Resume(IntPtr self);
        [DllImport("wx-c")] static extern bool wxProgressDialog_Show(IntPtr self, bool show);

        //-----------------------------------------------------------------------------

        public ProgressDialog(IntPtr wxObject)
            : base(wxObject) {}

        public ProgressDialog(string title, string message)
            : this(title, message, 100, null, wxPD_APP_MODAL | wxPD_AUTO_HIDE) {}

        public ProgressDialog(string title, string message, int maximum)
            : this(title, message, maximum, null, wxPD_APP_MODAL | wxPD_AUTO_HIDE) {}

        public ProgressDialog(string title, string message, int maximum, Window parent)
            : this(title, message, maximum, parent, wxPD_APP_MODAL | wxPD_AUTO_HIDE) {}

        public ProgressDialog(string title, string message, int maximum, Window parent, int style)
            : this(wxProgressDialog_ctor(title, message, maximum, Object.SafePtr(parent), (uint)style)) {}

        //-----------------------------------------------------------------------------

        public bool Update(int value)
        {
            return wxProgressDialog_Update(wxObject, value, "");
        }

		//---------------------------------------------------------------------

        public bool Update(int value, string newmsg)
        {
            return wxProgressDialog_Update(wxObject, value, newmsg);
        }

		//---------------------------------------------------------------------

        public void Resume()
        {
            wxProgressDialog_Resume(wxObject);
        }

		//---------------------------------------------------------------------

        public override bool Show()
        {
            return wxProgressDialog_Show(wxObject, true);
        }

		//---------------------------------------------------------------------

        public new bool Show(bool show)
        {
            return wxProgressDialog_Show(wxObject, show);
        }
	
	//---------------------------------------------------------------------
	
	public new void Dispose()
        {
            XDispose(true);
        }
	
	//---------------------------------------------------------------------

        public void XDispose(bool disposing)
        {
            if (!disposed)
            {
                wxProgressDialog_dtor(wxObject);
            }
            xdisposed = true;
        }
    }
}

