//-----------------------------------------------------------------------------
// wx.NET - FindReplaceDialog.cs
//
// The wxFindReplaceDialog wrapper class.
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
    public class FindReplaceDialog : Dialog
    {
        public const int wxFR_DOWN       = 1;
        public const int wxFR_WHOLEWORD  = 2;
        public const int wxFR_MATCHCASE  = 4;

        public const long wxFR_REPLACEDIALOG = 1;
        public const long wxFR_NOUPDOWN      = 2;
        public const long wxFR_NOMATCHCASE   = 4;
        public const long wxFR_NOWHOLEWORD   = 8;

        //-----------------------------------------------------------------------------

        [DllImport("wx-c")] static extern IntPtr wxFindReplaceDialog_ctor();
        [DllImport("wx-c")] static extern bool   wxFindReplaceDialog_Create(IntPtr self, IntPtr parent, IntPtr data, string title, uint style);

        [DllImport("wx-c")] static extern IntPtr wxFindReplaceDialog_GetData(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFindReplaceDialog_SetData(IntPtr self, IntPtr data);

        //-----------------------------------------------------------------------------

        public FindReplaceDialog(IntPtr wxObject) 
            : base(wxObject) { }

        public FindReplaceDialog()
            : base(wxFindReplaceDialog_ctor()) { }

        public FindReplaceDialog(Window parent, FindReplaceData data, string title)
            : this(parent, data, title, 0) { }

        public FindReplaceDialog(Window parent, FindReplaceData data, string title, long style)
            : base(wxFindReplaceDialog_ctor())
        {
            if (!Create(parent, data, title, style))
            {
                throw new InvalidOperationException("Could not create FindReplaceDialog");
            }
        }

        public bool Create(Window parent, FindReplaceData data, string title, long style)
        {
            return wxFindReplaceDialog_Create(wxObject, Object.SafePtr(parent), Object.SafePtr(data), title, (uint)style);
        }

        //-----------------------------------------------------------------------------

        public FindReplaceData Data
        {
            get { return (FindReplaceData)FindObject(wxFindReplaceDialog_GetData(wxObject), typeof(FindReplaceData)); }
            set { wxFindReplaceDialog_SetData(wxObject, Object.SafePtr(value)); } 
        }

        //-----------------------------------------------------------------------------

		public event EventListener Find
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_FIND, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener FindNext
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_FIND_NEXT, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener FindReplace
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_FIND_REPLACE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener FindReplaceAll
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_FIND_REPLACE_ALL, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}

		public event EventListener FindClose
		{
			add { AddCommandListener(Event.wxEVT_COMMAND_FIND_CLOSE, ID, value, this); }
			remove { RemoveHandler(value, this); }
		}
    }

	//-----------------------------------------------------------------------------

    public class FindDialogEvent : CommandEvent
    {
        [DllImport("wx-c")] static extern IntPtr wxFindDialogEvent_ctor(int commandType, int id);

        [DllImport("wx-c")] static extern int    wxFindDialogEvent_GetFlags(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFindDialogEvent_SetFlags(IntPtr self, int flags);

        [DllImport("wx-c")] static extern IntPtr wxFindDialogEvent_GetFindString(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFindDialogEvent_SetFindString(IntPtr self, string str);

        [DllImport("wx-c")] static extern IntPtr wxFindDialogEvent_GetReplaceString(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFindDialogEvent_SetReplaceString(IntPtr self, string str);

        [DllImport("wx-c")] static extern IntPtr wxFindDialogEvent_GetDialog(IntPtr self);

        //-----------------------------------------------------------------------------

        public FindDialogEvent(IntPtr wxObject)
            : base(wxObject) { }

        public FindDialogEvent(int commandType, int id)
            : base(wxFindDialogEvent_ctor(commandType, id)) { }

        //-----------------------------------------------------------------------------

        public int Flags
        {
            get { return wxFindDialogEvent_GetFlags(wxObject); }
            set { wxFindDialogEvent_SetFlags(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public string FindString
        {
            get { return new wxString(wxFindDialogEvent_GetFindString(wxObject), true); }
            set { wxFindDialogEvent_SetFindString(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public string ReplaceString
        {
            get { return new wxString(wxFindDialogEvent_GetReplaceString(wxObject), true); }
            set { wxFindDialogEvent_SetReplaceString(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public FindReplaceDialog Dialog
        {
            get { return (FindReplaceDialog)FindObject(wxFindDialogEvent_GetDialog(wxObject)); }
        }
    }

	//-----------------------------------------------------------------------------

    public class FindReplaceData : Object
    {
        [DllImport("wx-c")] static extern IntPtr wxFindReplaceData_ctor(uint flags);

        [DllImport("wx-c")] static extern IntPtr wxFindReplaceData_GetFindString(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFindReplaceData_SetFindString(IntPtr self, string str);

        [DllImport("wx-c")] static extern int    wxFindReplaceData_GetFlags(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFindReplaceData_SetFlags(IntPtr self, int flags);

        [DllImport("wx-c")] static extern void   wxFindReplaceData_SetReplaceString(IntPtr self, string str);
        [DllImport("wx-c")] static extern IntPtr wxFindReplaceData_GetReplaceString(IntPtr self);

        //-----------------------------------------------------------------------------

        public FindReplaceData(IntPtr wxObject)
            : base(wxObject) { }

        public FindReplaceData()
            : this(0) { }

        public FindReplaceData(int flags)
            : base(wxFindReplaceData_ctor((uint)flags)) {}

        //-----------------------------------------------------------------------------

        public string FindString
        {
            get { return new wxString(wxFindReplaceData_GetFindString(wxObject), true); }
            set { wxFindReplaceData_SetFindString(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public string ReplaceString
        {
            get { return new wxString(wxFindReplaceData_GetReplaceString(wxObject), true); }
            set { wxFindReplaceData_SetReplaceString(wxObject, value); }
        }

        //-----------------------------------------------------------------------------

        public int Flags
        {
            get { return wxFindReplaceData_GetFlags(wxObject); }
            set { wxFindReplaceData_SetFlags(wxObject, value); }
        }
    }
}

