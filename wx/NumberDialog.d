//-----------------------------------------------------------------------------
// wxD - NumberDialog.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.NumberDialog;
import wx.common;
import wx.Dialog;

		//! \cond EXTERN
        static extern (C) IntPtr wxNumberEntryDialog_ctor(IntPtr parent, string message, string prompt, string caption, int value, int min, int max, inout Point pos);
        static extern (C) void wxNumberEntryDialog_dtor(IntPtr self);
        static extern (C) int wxNumberEntryDialog_GetValue(IntPtr self);
        static extern (C) int wxNumberEntryDialog_ShowModal(IntPtr self);
		//! \endcond

        //-----------------------------------------------------------------------------

    public class NumberEntryDialog : Dialog
    {
        public const int wxNumberEntryDialogStyle = (Dialog.wxOK | Dialog.wxCANCEL | Dialog.wxCENTRE );

        public this(IntPtr wxobj)
            { super(wxobj);}

        public  this(Window parent, string message, string prompt, string caption, int value, int min, int max, Point pos = wxDefaultPosition)
            { this(wxNumberEntryDialog_ctor(wxObject.SafePtr(parent), message, prompt, caption, value, min, max, pos)); }

        //-----------------------------------------------------------------------------

        public int Value() { return wxNumberEntryDialog_GetValue(wxobj); }

        //---------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxNumberEntryDialog_ShowModal(wxobj);
        }
    }

    //-----------------------------------------------------------------------------

		//! \cond EXTERN
        static extern (C) int wxGetNumberFromUser_func(string message, string prompt, string caption, int value, int min, int max, IntPtr parent, inout Point pos);
		//! \endcond

        //-----------------------------------------------------------------------------

        public int GetNumberFromUser(string message, string prompt, string caption, int value = 0, int min = 0, int max = 100, Window parent = null, Point pos = Dialog.wxDefaultPosition)
        {
            return wxGetNumberFromUser_func(message, prompt, caption, value, min, max, wxObject.SafePtr(parent), pos);
        }
