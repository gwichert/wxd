//-----------------------------------------------------------------------------
// wx.NET - FileDialog.cs
//
// The wxFileDialog wrapper class.
//
// Written by Achim Breunig (achim.breunig@web.de)
// (C) 2003 Achim Breunig
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class FileDialogStyle
    {
        public const long wxOPEN              = 0x0001;
        public const long wxSAVE              = 0x0002;
        public const long wxOVERWRITE_PROMPT  = 0x0004;
        public const long wxHIDE_READONLY     = 0x0008;
        public const long wxFILE_MUST_EXIST   = 0x0010;
        public const long wxMULTIPLE          = 0x0020;
        public const long wxCHANGE_DIR        = 0x0040;
    }

    public class FileDialog : Dialog
    {
        [DllImport("wx-c")] static extern IntPtr wxFileDialog_ctor(IntPtr parent, string message, string defaultDir, string defaultFile, string wildcard, uint style, ref Point pos);
        [DllImport("wx-c")] static extern void   wxFileDialog_dtor(IntPtr self);

        [DllImport("wx-c")] static extern IntPtr wxFileDialog_GetDirectory(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFileDialog_SetDirectory(IntPtr self, string dir);

        [DllImport("wx-c")] static extern IntPtr wxFileDialog_GetFilename(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFileDialog_SetFilename(IntPtr self, string filename);

        [DllImport("wx-c")] static extern IntPtr wxFileDialog_GetPath(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFileDialog_SetPath(IntPtr self, string path);

        [DllImport("wx-c")] static extern void   wxFileDialog_SetFilterIndex(IntPtr self, int filterIndex);
        [DllImport("wx-c")] static extern int    wxFileDialog_GetFilterIndex(IntPtr self);

        [DllImport("wx-c")] static extern IntPtr wxFileDialog_GetWildcard(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFileDialog_SetWildcard(IntPtr self, string wildcard);

        [DllImport("wx-c")] static extern void   wxFileDialog_SetMessage(IntPtr self, string message);
        [DllImport("wx-c")] static extern IntPtr wxFileDialog_GetMessage(IntPtr self);

        [DllImport("wx-c")] static extern int    wxFileDialog_ShowModal(IntPtr self);

        [DllImport("wx-c")] static extern int    wxFileDialog_GetStyle(IntPtr self);
        [DllImport("wx-c")] static extern void   wxFileDialog_SetStyle(IntPtr self, int style);

        [DllImport("wx-c")] static extern IntPtr wxFileDialog_GetPaths(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxFileDialog_GetFilenames(IntPtr self);

        //---------------------------------------------------------------------

        public FileDialog(IntPtr wxObject)
            : base(wxObject) { }

        public FileDialog(Window parent)
            : this(parent, "Choose a file", "", "", "*.*", 0, wxDefaultPosition) { }

        public FileDialog(Window parent, string message)
            : this(parent, message, "", "", "*.*", 0, wxDefaultPosition) { }

        public FileDialog(Window parent, string message, string defaultDir)
            : this(parent, message, defaultDir, "", "*.*", 0, wxDefaultPosition) { }

        public FileDialog(Window parent, string message, string defaultDir, string defaultFile)
            : this(parent, message, defaultDir, defaultFile, "*.*", 0, wxDefaultPosition) { }

        public FileDialog(Window parent, string message, string defaultDir, string defaultFile, string wildcard)
            : this(parent, message, defaultDir, defaultFile, wildcard, 0, wxDefaultPosition) { }

        public FileDialog(Window parent, string message, string defaultDir, string defaultFile, string wildcard, long style)
            : this(parent, message, defaultDir, defaultFile, wildcard, style, wxDefaultPosition) { }

        public FileDialog(Window parent, string message, string defaultDir, string defaultFile, string wildcard, long style, Point pos)
            : this(wxFileDialog_ctor(Object.SafePtr(parent), message, defaultDir, defaultFile, wildcard, (uint)style, ref pos)) { }

        //---------------------------------------------------------------------

        public string Directory
        {
            get { return new wxString(wxFileDialog_GetDirectory(wxObject), true); }
            set { wxFileDialog_SetDirectory(wxObject, value); }
        }

        public string Filename
        {
            get { return new wxString(wxFileDialog_GetFilename(wxObject), true); }
            set { wxFileDialog_SetFilename(wxObject, value); }
        }

        public string Path
        {
            get { return new wxString(wxFileDialog_GetPath(wxObject), true); }
            set { wxFileDialog_SetPath(wxObject, value); }
        }

        public int FilterIndex
        {
            set { wxFileDialog_SetFilterIndex(wxObject,value); }
            get { return wxFileDialog_GetFilterIndex(wxObject); }
        }

        public string Message
        {
            set { wxFileDialog_SetMessage(wxObject,value); }
            get { return new wxString(wxFileDialog_GetMessage(wxObject), true); }
        }

        //---------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxFileDialog_ShowModal(wxObject);
        }

        //---------------------------------------------------------------------

        public string Wildcard
        {
            get { return new wxString(wxFileDialog_GetWildcard(wxObject), true); }
            set { wxFileDialog_SetWildcard(wxObject, value); }
        }

        public long Style
        {
            get { return (long)wxFileDialog_GetStyle(wxObject); }
            set { wxFileDialog_SetStyle(wxObject, (int)value); }
        }

        //---------------------------------------------------------------------

        public string[] Paths
        {
            get { return new ArrayString(wxFileDialog_GetPaths(wxObject), true); }
        }

        public string[] Filenames
        {
            get { return new ArrayString(wxFileDialog_GetFilenames(wxObject), true); }
        }
    }
}

