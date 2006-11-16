//-----------------------------------------------------------------------------
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

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class DirDialog : Dialog
    {
        [DllImport("wx-c")] static extern IntPtr wxDirDialog_ctor(IntPtr parent, string message, string defaultPath, uint style, ref Point pos, ref Size size, string name);

        [DllImport("wx-c")] static extern void   wxDirDialog_SetPath(IntPtr self, string path);
        [DllImport("wx-c")] static extern IntPtr wxDirDialog_GetPath(IntPtr self);

        [DllImport("wx-c")] static extern int    wxDirDialog_GetStyle(IntPtr self);
        [DllImport("wx-c")] static extern void   wxDirDialog_SetStyle(IntPtr self, int style);

        [DllImport("wx-c")] static extern void   wxDirDialog_SetMessage(IntPtr self, string message);
        [DllImport("wx-c")] static extern IntPtr wxDirDialog_GetMessage(IntPtr self);

        [DllImport("wx-c")] static extern int    wxDirDialog_ShowModal(IntPtr self);

        //-----------------------------------------------------------------------------

        public DirDialog(IntPtr wxObject) 
            : base(wxObject) { }

        public DirDialog(Window parent)
            : this(parent, "Choose a directory", "", 0, wxDefaultPosition, wxDefaultSize, "DirDialog") { }

        public DirDialog(Window parent, string message)
            : this(parent, message, "", 0, wxDefaultPosition, wxDefaultSize, "DirDialog") { }

        public DirDialog(Window parent, string message, string defaultPath)
            : this(parent, message, defaultPath, 0, wxDefaultPosition, wxDefaultSize, "DirDialog") { }

        public DirDialog(Window parent, string message, string defaultPath, int style)
            : this(parent, message, defaultPath, style, wxDefaultPosition, wxDefaultSize, "DirDialog") { }

        public DirDialog(Window parent, string message, string defaultPath, int style, Point pos)
            : this(parent, message, defaultPath, style, pos, wxDefaultSize, "DirDialog") { }

        public DirDialog(Window parent, string message, string defaultPath, int style, Point pos, Size size)
            : this(parent, message, defaultPath, style, pos, size, "DirDialog") { }

        public DirDialog(Window parent, string message, string defaultPath, int style, Point pos, Size size, string name)
            : this(wxDirDialog_ctor(Object.SafePtr(parent), message, defaultPath, (uint)style, ref pos, ref size, name)) { }

        //-----------------------------------------------------------------------------

        public string Path
        {
            set { wxDirDialog_SetPath(wxObject, value); }
            get { return new wxString(wxDirDialog_GetPath(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public string Message
        {
            set { wxDirDialog_SetMessage(wxObject, value); }
            get { return new wxString(wxDirDialog_GetMessage(wxObject), true); }
        }

        //-----------------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxDirDialog_ShowModal(wxObject);
        }

        //-----------------------------------------------------------------------------

        public int Style
        {
            set { wxDirDialog_SetStyle(wxObject, value); }
            get { return wxDirDialog_GetStyle(wxObject); }
        }

        //-----------------------------------------------------------------------------
    }
}

