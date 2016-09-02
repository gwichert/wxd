//-----------------------------------------------------------------------------
// wxD - FilePicker.d
/// The wxFilePickerCtrl and wxDirPickerCtrl wrapper classes.
//
// Written by Gerrit Wichert (gwichert@yahoo.com)
// (C) 2013 Gerrit Wichert
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------
module wx.FilePicker;

public import wx.common;
public import wx.Control;
public import wx.TextCtrl;
public import wx.PickerBase;

extern (C) {
  static IntPtr wxFilePickerCtrl_ctor();
  static bool   wxFilePickerCtrl_Create( IntPtr self, IntPtr parent, int id,
                                         string path, string message,
                                         string wildcard,
                                         ref Point pos, ref Size size,
                                         uint style, IntPtr validator,
                                         string name);
  static IntPtr wxFilePickerCtrl_GetPath( IntPtr self);
  static void   wxFilePickerCtrl_SetPath( IntPtr self, string filename);
  static IntPtr wxDirPickerCtrl_ctor();
  static bool   wxDirPickerCtrl_Create( IntPtr self, IntPtr parent, int id,
                                        string path, string message,
                                        ref Point pos, ref Size size,
                                        uint style, IntPtr validator,
                                        string name);
  static IntPtr wxDirPickerCtrl_GetPath( IntPtr self);
  static void   wxDirPickerCtrl_SetPath( IntPtr self, string dirname);
}

public static const int wxFLP_OPEN             = 0x0400;
public static const int wxFLP_SAVE             = 0x0800;
public static const int wxFLP_OVERWRITE_PROMPT = 0x1000;
public static const int wxFLP_FILE_MUST_EXIST  = 0x2000;
public static const int wxFLP_CHANGE_DIR       = 0x4000;
// NOTE: wxMULTIPLE is not supported !
public static const int wxDIRP_DIR_MUST_EXIST  = 0x0008;
public static const int wxDIRP_CHANGE_DIR      = 0x0010;

public static const int wxFLP_USE_TEXTCTRL  = wxPB_USE_TEXTCTRL;
version(__WXGTK__) {
  public static const int wxFLP_DEFAULT_STYLE = wxFLP_OPEN | wxFLP_FILE_MUST_EXIST;
} else {
  public static const int wxFLP_DEFAULT_STYLE = wxFLP_USE_TEXTCTRL | wxFLP_OPEN | wxFLP_FILE_MUST_EXIST;
}
  
alias FilePickerCtrl wxFilePickerCtrl;
public class FilePickerCtrl : PickerBase 
{
  public:
  const static string wxFilePickerCtrlNameStr = "filepickerctrl";
  //----------------------------------------------------------------------------
  public:
  this( IntPtr wxobj) {
    super( wxobj);
  }

  this( Window parent, int id, string path = "",
        string message = "select a file", string wildcard = "*.*",
        Point pos = wxDefaultPosition, Size size = wxDefaultSize,
        int style = wxFLP_DEFAULT_STYLE,
        Validator validator = null,
        string name = wxFilePickerCtrlNameStr)
  {
    this( wxFilePickerCtrl_ctor());
    if (!wxFilePickerCtrl_Create( wxobj, wxObject.SafePtr( parent), id,
                                  path, message, wildcard, pos, size,
                                  cast(uint)style,
                                  wxObject.SafePtr( validator), name)) {
      throw new InvalidOperationException( "Failed to create FilePickerCtrl");
    }
  }

  public static wxObject New( IntPtr wxobj) {
    return new FilePickerCtrl( wxobj);
  }

  string Path() {
    return cast(string) new wxString( wxFilePickerCtrl_GetPath( wxobj));
  }

  void Path( string filename) {
    wxFilePickerCtrl_SetPath( wxobj, filename);
  }
}



public static const int wxDIRP_USE_TEXTCTRL  = wxPB_USE_TEXTCTRL;
version(__WXGTK__) {
  public static const int wxDIRP_DEFAULT_STYLE = wxFLP_FILE_MUST_EXIST;
} else {
  public static const int wxDIRP_DEFAULT_STYLE = wxFLP_USE_TEXTCTRL | wxFLP_FILE_MUST_EXIST;
}

alias DirPickerCtrl wxDirPickerCtrl;
public class DirPickerCtrl : PickerBase 
{
  public:
  const static string wxDirPickerCtrlNameStr = "dirpickerctrl";
  //----------------------------------------------------------------------------
  public:
  this( IntPtr wxobj) {
    super( wxobj);
  }

  this( Window parent, int id, string path = "",
        string message = "select a folder",
        Point pos = wxDefaultPosition, Size size = wxDefaultSize,
        int style = wxDIRP_DEFAULT_STYLE,
        Validator validator = null,
        string name = wxDirPickerCtrlNameStr)
  {
    this( wxDirPickerCtrl_ctor());
    if (!wxDirPickerCtrl_Create( wxobj, wxObject.SafePtr( parent), id,
                                 path, message, pos, size, cast(uint)style,
                                 wxObject.SafePtr( validator), name)) {
      throw new InvalidOperationException( "Failed to create DirPickerCtrl");
    }
  }

  public static wxObject New( IntPtr wxobj) {
    return new DirPickerCtrl( wxobj);
  }

  string Path() {
    return cast(string) new wxString( wxDirPickerCtrl_GetPath( wxobj));
  }

  void Path( string filename) {
    wxDirPickerCtrl_SetPath( wxobj, filename);
  }
}



  
