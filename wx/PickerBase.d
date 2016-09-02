//-----------------------------------------------------------------------------
// wxD - PickerBase.d
/// The wxPickerBase wrapper class.
//
// Written by Gerrit Wichert (gwichert@yahoo.com)
// (C) 2013 Gerrit Wichert
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.PickerBase;

public import wx.common;
public import wx.Control;
public import wx.TextCtrl;

extern (C) 
{
  static bool   wxPickerBase_HasTextCtrl(IntPtr self);
  static IntPtr wxPickerBase_GetTextCtrl(IntPtr self);
  static void   wxPickerBase_SetInternalMargin(IntPtr self, int margin);
  static int    wxPickerBase_GetInternalMargin(IntPtr self);
  static void   wxPickerBase_SetTextCtrlProportion(IntPtr self, int prop);
  static void   wxPickerBase_SetPickerCtrlProportion(IntPtr self, int prop);
  static int    wxPickerBase_GetTextCtrlProportion(IntPtr self);
  static int    wxPickerBase_GetPickerCtrlProportion(IntPtr self);
  static bool   wxPickerBase_IsTextCtrlGrowable(IntPtr self);
  static void   wxPickerBase_SetTextCtrlGrowable(IntPtr self, bool grow);
  static bool   wxPickerBase_IsPickerCtrlGrowable(IntPtr self);
  static void   wxPickerBase_SetPickerCtrlGrowable(IntPtr self, bool grow);
}

public static const int wxPB_USE_TEXTCTRL = 0x0002;

alias PickerBase wxPickerBase;

public abstract class PickerBase : Control 
{
  public:
  this( IntPtr wxobj) {
    super( wxobj);
  }
  
  bool HasTextCtrl() {
    return wxPickerBase_HasTextCtrl( wxobj);
  }

  TextCtrl GetTextCtrl() {
    return new TextCtrl( wxPickerBase_GetTextCtrl( wxobj));
  }  
  
  void InternalMargin( int margin) {
    wxPickerBase_SetInternalMargin( wxobj, margin);
  }

  int InternalMargin() {
    return wxPickerBase_GetInternalMargin( wxobj);
  }

  void TextCtrlProportion( int prop) {
    wxPickerBase_SetTextCtrlProportion( wxobj, prop);
  }

  void PickerCtrlProportion( int prop) {
    wxPickerBase_SetPickerCtrlProportion( wxobj, prop);
  }

  int TextCtrlProportion() {
    return wxPickerBase_GetTextCtrlProportion( wxobj);
  }

  int PickerCtrlProportion() {
    return wxPickerBase_GetPickerCtrlProportion( wxobj);
  }

  bool IsTextCtrlGrowable() {
    return wxPickerBase_IsTextCtrlGrowable( wxobj);
  }

  void TextCtrlGrowable( bool grow) {
    wxPickerBase_SetTextCtrlGrowable( wxobj, grow);
  }

  bool IsPickerCtrlGrowable() {
    return wxPickerBase_IsPickerCtrlGrowable( wxobj);
  }

  void PickerCtrlGroable( bool grow) {
    wxPickerBase_SetPickerCtrlGrowable( wxobj, grow);
  }  
}
