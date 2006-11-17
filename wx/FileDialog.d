//-----------------------------------------------------------------------------
// wxD - FileDialog.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// (C) 2005 afb <afb@users.sourceforge.net>
// based on
// wx.NET - FileDialog.cs
//
/// The wxFileDialog wrapper class.
//
// Written by Achim Breunig (achim.breunig@web.de)
// (C) 2003 Achim Breunig
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.FileDialog;
public import wx.common;
public import wx.Dialog;
public import wx.ArrayString;

//! \cond STD
private import std.string;
//! \endcond

		//! \cond EXTERN
        static extern (C) IntPtr wxFileDialog_ctor(IntPtr parent, string message, string defaultDir, string defaultFile, string wildcard, uint style, inout Point pos);
        static extern (C) void   wxFileDialog_dtor(IntPtr self);

        static extern (C) string wxFileDialog_GetDirectory(IntPtr self);
        static extern (C) void   wxFileDialog_SetDirectory(IntPtr self, string dir);

        static extern (C) string wxFileDialog_GetFilename(IntPtr self);
        static extern (C) void   wxFileDialog_SetFilename(IntPtr self, string filename);

        static extern (C) string wxFileDialog_GetPath(IntPtr self);
        static extern (C) void   wxFileDialog_SetPath(IntPtr self, string path);

        static extern (C) void   wxFileDialog_SetFilterIndex(IntPtr self, int filterIndex);
        static extern (C) int    wxFileDialog_GetFilterIndex(IntPtr self);

        static extern (C) string wxFileDialog_GetWildcard(IntPtr self);
        static extern (C) void   wxFileDialog_SetWildcard(IntPtr self, string wildcard);

        static extern (C) void   wxFileDialog_SetMessage(IntPtr self, string message);
        static extern (C) string wxFileDialog_GetMessage(IntPtr self);

        static extern (C) int    wxFileDialog_ShowModal(IntPtr self);

        static extern (C) int    wxFileDialog_GetStyle(IntPtr self);
        static extern (C) void   wxFileDialog_SetStyle(IntPtr self, int style);

        static extern (C) IntPtr wxFileDialog_GetPaths(IntPtr self);
        static extern (C) IntPtr wxFileDialog_GetFilenames(IntPtr self);
		//! \endcond

        //---------------------------------------------------------------------

    alias FileDialog wxFileDialog;
    public class FileDialog : Dialog
    {
        public const int wxOPEN              = 0x0001;
        public const int wxSAVE              = 0x0002;
        public const int wxOVERWRITE_PROMPT  = 0x0004;
        public const int wxHIDE_READONLY     = 0x0008;
        public const int wxFILE_MUST_EXIST   = 0x0010;
        public const int wxMULTIPLE          = 0x0020;
        public const int wxCHANGE_DIR        = 0x0040;

	public const string wxFileSelectorPromptStr = "Select a file";
	version(__WXMSW__) {
		public const string wxFileSelectorDefaultWildcardStr = "*.*";
	} else {
		public const string wxFileSelectorDefaultWildcardStr = "*";
	}

        public this(IntPtr wxobj)
            { super(wxobj); }

        public this(Window parent, string message = wxFileSelectorPromptStr, string defaultDir = "", string defaultFile = "", string wildcard = wxFileSelectorDefaultWildcardStr , int style = 0, Point pos = wxDefaultPosition)
            { this(wxFileDialog_ctor(wxObject.SafePtr(parent), message, defaultDir, defaultFile, wildcard, cast(uint)style, pos)); }

        //---------------------------------------------------------------------

        public string Directory() { return wxFileDialog_GetDirectory(wxobj).dup; }
        public void Directory(string value) { wxFileDialog_SetDirectory(wxobj, value); }

        public string Filename() { return wxFileDialog_GetFilename(wxobj).dup; }
        public void Filename(string value) { wxFileDialog_SetFilename(wxobj, value); }

        public string Path() { return wxFileDialog_GetPath(wxobj).dup; }
        public void Path(string value) { wxFileDialog_SetPath(wxobj, value); }

        public void FilterIndex(int value) { wxFileDialog_SetFilterIndex(wxobj,value); }
        public int FilterIndex() { return wxFileDialog_GetFilterIndex(wxobj); }

        public void Message(string value) { wxFileDialog_SetMessage(wxobj,value); }
        public string Message() { return wxFileDialog_GetMessage(wxobj).dup; }

        //---------------------------------------------------------------------

        public override int ShowModal()
        {
            return wxFileDialog_ShowModal(wxobj);
        }

        //---------------------------------------------------------------------

        public string Wildcard() { return wxFileDialog_GetWildcard(wxobj).dup; }
        public void Wildcard(string value) { wxFileDialog_SetWildcard(wxobj, value); }

        public int Style() { return cast(int)wxFileDialog_GetStyle(wxobj); }
        public void Style(int value) { wxFileDialog_SetStyle(wxobj, cast(int)value); }

        //---------------------------------------------------------------------

        public string[] Paths() { return (new ArrayString(wxFileDialog_GetPaths(wxobj), true)).toArray(); }

        public string[] Filenames() { return (new ArrayString(wxFileDialog_GetFilenames(wxobj), true)).toArray(); }
    }

	//! \cond EXTERN
	static extern (C) string wxFileSelector_func(char[] message, char[] default_path,char[] default_filename,char[] default_extension, char[] wildcard, int flags, IntPtr parent, int x, int y);
	static extern (C) string wxFileSelectorEx_func(char[] message, char[] default_path,char[] default_filename,int *indexDefaultExtension, char[] wildcard, int flags, IntPtr parent, int x, int y);
	static extern (C) string wxLoadFileSelector_func(char[] what, char[] extension, char[] default_name, IntPtr parent);
	static extern (C) string wxSaveFileSelector_func(char[] what, char[] extension, char[] default_name, IntPtr parent);
	//! \endcond

string FileSelector(
	string message = FileDialog.wxFileSelectorPromptStr,
	string default_path = null,
	string default_filename = null,
	string default_extension = null,
	string wildcard = FileDialog.wxFileSelectorDefaultWildcardStr,
	int flags = 0,
	Window parent = null, int x = -1, int y = -1)
{
	return wxFileSelector_func(
		message,
		default_path,
		default_filename,
		default_extension,
		wildcard,
		flags,
		wxObject.SafePtr(parent),x,y);
}

string FileSelectorEx(
	string message = FileDialog.wxFileSelectorPromptStr,
	string default_path = null,
	string default_filename = null,
	int *indexDefaultExtension = null,
	string wildcard = FileDialog.wxFileSelectorDefaultWildcardStr,
	int flags = 0,
	Window parent = null, int x = -1, int y = -1)
{
	return wxFileSelectorEx_func(
		message,
		default_path,
		default_filename,
		indexDefaultExtension,
		wildcard,
		flags,
		wxObject.SafePtr(parent),x,y);
}

string LoadFileSelector(
	string what,
	string extension,
	string default_name = null,
	Window parent = null)
{
	return wxLoadFileSelector_func(
		what,
		extension,
		default_name,
		wxObject.SafePtr(parent));
}

string SaveFileSelector(
	string what,
	string extension,
	string default_name = null,
	Window parent = null)
{
	return wxSaveFileSelector_func(
		what,
		extension,
		default_name,
		wxObject.SafePtr(parent));
}

