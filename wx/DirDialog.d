//-----------------------------------------------------------------------------
// wxD - DirDialog.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - DirDialog.cs
// 
// The wxDirDialog wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.DirDialog;
import wx.common;
import wx.Dialog;

        static extern (C) IntPtr wxDirDialog_ctor(IntPtr parent, string message, string defaultPath, uint style, inout Point pos, inout Size size, string name);

        static extern (C) void   wxDirDialog_SetPath(IntPtr self, string path);
        static extern (C) string wxDirDialog_GetPath(IntPtr self);

        static extern (C) int    wxDirDialog_GetStyle(IntPtr self);
        static extern (C) void   wxDirDialog_SetStyle(IntPtr self, int style);

        static extern (C) void   wxDirDialog_SetMessage(IntPtr self, string message);
        static extern (C) string wxDirDialog_GetMessage(IntPtr self);

        static extern (C) int    wxDirDialog_ShowModal(IntPtr self);

        //-----------------------------------------------------------------------------

    public class DirDialog : Dialog
    {
	public const int wxDD_DEFAULT_STYLE = 0; //(Dialog.wxDEFAULT_DIALOG_STYLE | Dialog.wxRESIZE_BORDER | wxDD_NEW_DIR_BUTTON);
    
        public this(IntPtr wxobj) 
            { super(wxobj); }

        public this(Window parent)
            { this(parent, "Choose a directory", "", wxDD_DEFAULT_STYLE, wxDefaultPosition, wxDefaultSize, "DirDialog"); }

        public this(Window parent, string message)
            { this(parent, message, "", wxDD_DEFAULT_STYLE, wxDefaultPosition, wxDefaultSize, "DirDialog"); }

        public this(Window parent, string message, string defaultPath)
            { this(parent, message, defaultPath, wxDD_DEFAULT_STYLE, wxDefaultPosition, wxDefaultSize, "DirDialog"); }

        public this(Window parent, string message, string defaultPath, int style)
            { this(parent, message, defaultPath, style, wxDefaultPosition, wxDefaultSize, "DirDialog"); }

        public this(Window parent, string message, string defaultPath, int style, Point pos)
            { this(parent, message, defaultPath, style, pos, wxDefaultSize, "DirDialog"); }

        public this(Window parent, string message, string defaultPath, int style, Point pos, Size size)
            { this(parent, message, defaultPath, style, pos, size, "DirDialog"); }

        public this(Window parent, string message, string defaultPath, int style, Point pos, Size size, string name)
            { this(wxDirDialog_ctor(wxObject.SafePtr(parent), message, defaultPath, cast(uint)style, pos, size, name)); }

        //-----------------------------------------------------------------------------

        public void Path(string value) { wxDirDialog_SetPath(wxobj, value); }
        public string Path() { return wxDirDialog_GetPath(wxobj).dup; }

        //-----------------------------------------------------------------------------

        public void Message(string value) { wxDirDialog_SetMessage(wxobj, value); }
        public string Message() { return wxDirDialog_GetMessage(wxobj).dup; }

        //-----------------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxDirDialog_ShowModal(wxobj);
        }

        //-----------------------------------------------------------------------------

        public void Style(int value) { wxDirDialog_SetStyle(wxobj, value); }
        public int Style() { return wxDirDialog_GetStyle(wxobj); }

        //-----------------------------------------------------------------------------
    }

	extern (C) string wxDirSelector_func(string message,
              string defaultPath,
              int style,
              inout Point pos,
              IntPtr parent);

	string DirSelector(string message = null,
              string defaultPath = null,
              int style = DirDialog.wxDD_DEFAULT_STYLE ,
              Point pos = Dialog.wxDefaultPosition,
              Window parent = null)
	{
		return wxDirSelector_func(message,defaultPath,style,pos,wxObject.SafePtr(parent));
	}
