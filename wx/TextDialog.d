//-----------------------------------------------------------------------------
// wx.NET - TextDialog.cs
//
// The wxTextEntryDialog wrapper class.
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
    public class TextEntryDialog : Dialog
    {
        public const long wxTextEntryDialogStyle = (Dialog.wxOK | Dialog.wxCANCEL | Dialog.wxCENTRE );

        [DllImport("wx-c")] static extern IntPtr wxTextEntryDialog_ctor(IntPtr parent, string message, string caption, string value, uint style, ref Point pos);
        [DllImport("wx-c")] static extern void wxTextEntryDialog_dtor(IntPtr self);
        [DllImport("wx-c")] static extern void wxTextEntryDialog_SetValue(IntPtr self, string val);
        [DllImport("wx-c")] static extern IntPtr wxTextEntryDialog_GetValue(IntPtr self);
        [DllImport("wx-c")] static extern int wxTextEntryDialog_ShowModal(IntPtr self);

        //-----------------------------------------------------------------------------

        public TextEntryDialog(IntPtr wxObject)
            : base(wxObject) {}

        public TextEntryDialog(Window parent)
            : this(parent, "Enter text", "", "", (int)wxTextEntryDialogStyle, wxDefaultPosition) {}

        public TextEntryDialog(Window parent, string message)
            : this(parent, message, "", "", (int)wxTextEntryDialogStyle, wxDefaultPosition) {}

        public TextEntryDialog(Window parent, string message, string caption)
            : this(parent, message, caption, "", (int)wxTextEntryDialogStyle, wxDefaultPosition) {}

        public TextEntryDialog(Window parent, string message, string caption, string value)
            : this(parent, message, caption, value, (int)wxTextEntryDialogStyle, wxDefaultPosition) {}

        public TextEntryDialog(Window parent, string message, string caption, string value, long style)
            : this(parent, message, caption, value, (int)style, wxDefaultPosition) {}

        public  TextEntryDialog(Window parent, string message, string caption, string value, int style, Point pos)
            : this(wxTextEntryDialog_ctor(Object.SafePtr(parent), message, caption, value, (uint)style, ref pos)) { }

        //-----------------------------------------------------------------------------

        public string Value
        {
            get { return new wxString(wxTextEntryDialog_GetValue(wxObject), true); }
            set { wxTextEntryDialog_SetValue(wxObject, value); }
        }

        //---------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxTextEntryDialog_ShowModal(wxObject);
        }
    }

    //-----------------------------------------------------------------------------

    public class GetPasswordFromUser
    {
        private string value = "";

        [DllImport("wx-c")] static extern IntPtr wxGetPasswordFromUser_func(string message, string caption, string defaultValue, IntPtr parent);

        //-----------------------------------------------------------------------------

        public GetPasswordFromUser(string message)
            : this(message, "", "",  null) {}

        public GetPasswordFromUser(string message, string caption)
            : this(message, caption, "", null) {}

        public GetPasswordFromUser(string message, string caption, string defaultValue)
            : this(message, caption, defaultValue, null) {}

        public GetPasswordFromUser(string message, string caption, string defaultValue, Window parent)
        {
            value = new wxString(wxGetPasswordFromUser_func(message, caption, defaultValue, Object.SafePtr(parent)), true);
        }

        //-----------------------------------------------------------------------------

        public static implicit operator string(GetPasswordFromUser g)
        {
            return g.value;
        }
    }

    //-----------------------------------------------------------------------------

    public class GetTextFromUser
    {
        private string value = "";

        [DllImport("wx-c")] static extern IntPtr wxGetTextFromUser_func(string message, string caption, string defaultValue, IntPtr parent, int x, int y, bool centre);

        //-----------------------------------------------------------------------------

        public GetTextFromUser(string message)
            : this(message, "", "",  null, -1, -1, true) {}

        public GetTextFromUser(string message, string caption)
            : this(message, caption, "", null, -1, -1, true) {}

        public GetTextFromUser(string message, string caption, string defaultValue)
            : this(message, caption, defaultValue, null, -1, -1, true) {}

        public GetTextFromUser(string message, string caption, string defaultValue, Window parent)
            : this(message, caption, defaultValue, parent, -1, -1, true) {}

        public GetTextFromUser(string message, string caption, string defaultValue, Window parent, int x)
            : this(message, caption, defaultValue, parent, x, -1, true) {}

        public GetTextFromUser(string message, string caption, string defaultValue, Window parent, int x, int y)
            : this(message, caption, defaultValue, parent, x, y, true) {}

        public GetTextFromUser(string message, string caption, string defaultValue, Window parent, int x, int y, bool centre)
        {
            value = new wxString(wxGetTextFromUser_func( message, caption, defaultValue, Object.SafePtr(parent), x, y, centre), true);
        }

        //-----------------------------------------------------------------------------

        public static implicit operator string(GetTextFromUser g)
        {
            return g.value;
        }
    }
}

