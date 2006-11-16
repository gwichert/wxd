//-----------------------------------------------------------------------------
// wxD - TextDialog.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.TextDialog;
import wx.common;
import wx.Dialog;

        static extern (C) IntPtr wxTextEntryDialog_ctor(IntPtr parent, string message, string caption, string value, uint style, inout Point pos);
        static extern (C) void wxTextEntryDialog_dtor(IntPtr self);
        static extern (C) void wxTextEntryDialog_SetValue(IntPtr self, string val);
        static extern (C) string wxTextEntryDialog_GetValue(IntPtr self);
        static extern (C) int wxTextEntryDialog_ShowModal(IntPtr self);

        //-----------------------------------------------------------------------------

    public class TextEntryDialog : Dialog
    {
        public const int wxTextEntryDialogStyle = (Dialog.wxOK | Dialog.wxCANCEL | Dialog.wxCENTRE );

        public this(IntPtr wxobj)
            { super(wxobj);}

        public this(Window parent)
            { this(parent, "Enter text", "", "", cast(int)wxTextEntryDialogStyle, wxDefaultPosition);}

        public this(Window parent, string message)
            { this(parent, message, "", "", cast(int)wxTextEntryDialogStyle, wxDefaultPosition);}

        public this(Window parent, string message, string caption)
            { this(parent, message, caption, "", cast(int)wxTextEntryDialogStyle, wxDefaultPosition);}

        public this(Window parent, string message, string caption, string value)
            { this(parent, message, caption, value, cast(int)wxTextEntryDialogStyle, wxDefaultPosition);}

        public this(Window parent, string message, string caption, string value, int style)
            { this(parent, message, caption, value, cast(int)style, wxDefaultPosition);}

        public  this(Window parent, string message, string caption, string value, int style, Point pos)
            { this(wxTextEntryDialog_ctor(wxObject.SafePtr(parent), message, caption, value, cast(uint)style, pos)); }

        //-----------------------------------------------------------------------------

        public string Value() { return wxTextEntryDialog_GetValue(wxobj).dup; }
        public void Value(string value) { wxTextEntryDialog_SetValue(wxobj, value); }

        //---------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxTextEntryDialog_ShowModal(wxobj);
        }
    }

    //-----------------------------------------------------------------------------

        static extern (C) string wxGetPasswordFromUser_func(string message, string caption, string defaultValue, IntPtr parent);

        //-----------------------------------------------------------------------------

        public string GetPasswordFromUser(string message, string caption="", string defaultValue="", Window parent=null)
        {
            return wxGetPasswordFromUser_func(message, caption, defaultValue, wxObject.SafePtr(parent)).dup;
        }

    //-----------------------------------------------------------------------------

        static extern (C) string wxGetTextFromUser_func(string message, string caption, string defaultValue, IntPtr parent, int x, int y, bool centre);

        //-----------------------------------------------------------------------------

        public string GetTextFromUser(string message, string caption="", string defaultValue="", Window parent=null, int x=-1, int y=-1, bool centre=true)
        {
            return wxGetTextFromUser_func( message, caption, defaultValue, wxObject.SafePtr(parent), x, y, centre).dup;
        }
