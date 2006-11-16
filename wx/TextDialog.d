//-----------------------------------------------------------------------------
// wxD - TextDialog.d
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
    	enum {
        wxTextEntryDialogStyle = (wxOK | wxCANCEL | wxCENTRE),
	}
	public const string wxGetTextFromUserPromptStr = "Input Text";

        public this(IntPtr wxobj)
            { super(wxobj);}

        public  this(Window parent, string message=wxGetTextFromUserPromptStr, string caption="", string value="", int style=wxTextEntryDialogStyle, Point pos=wxDefaultPosition)
            { this(wxTextEntryDialog_ctor(wxObject.SafePtr(parent), message, caption, value, cast(uint)style, pos)); }

        //-----------------------------------------------------------------------------

        public string Value() { return wxTextEntryDialog_GetValue(wxobj); }
        public void Value(string value) { wxTextEntryDialog_SetValue(wxobj, value); }

        //---------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxTextEntryDialog_ShowModal(wxobj);
        }
    }

    //-----------------------------------------------------------------------------

        static extern (C) string wxGetPasswordFromUser_func(string message, string caption, string defaultValue, IntPtr parent);
        static extern (C) string wxGetTextFromUser_func(string message, string caption, string defaultValue, IntPtr parent, int x, int y, bool centre);

        //-----------------------------------------------------------------------------

        public string GetPasswordFromUser(string message, string caption=TextEntryDialog.wxGetTextFromUserPromptStr, string defaultValue="", Window parent=null)
        {
            return wxGetPasswordFromUser_func(message, caption, defaultValue, wxObject.SafePtr(parent)).dup;
        }

        //-----------------------------------------------------------------------------

        public string GetTextFromUser(string message, string caption=TextEntryDialog.wxGetTextFromUserPromptStr, string defaultValue="", Window parent=null, int x=-1, int y=-1, bool centre=true)
        {
            return wxGetTextFromUser_func(message, caption, defaultValue, wxObject.SafePtr(parent), x, y, centre).dup;
        }
