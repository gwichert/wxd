module wx.common;

interface IDisposable
{
	void Dispose();
}

interface ICloneable
{
	Object Clone();
}

class NullPointerException : Exception
{
	this(char[] msg) { super(msg); }
}

class NullReferenceException : Exception
{
	this(char[] msg) { super(msg); }
}

class ArgumentException : Exception
{
	this(char[] msg) { super(msg); }
}

class InvalidOperationException : Exception
{
	this(char[] msg) { super(msg); }
}

class ArgumentNullException : Exception
{
	this(char[] msg) { super(msg); }
}


version (Windows) {
  version = __WXMSW__;
}

//import wx.Defs;
import wx.wxObject;
//import wx.wxString;
//import wx.Log;
//import wx.Event;
//import wx.EvtHandler;
//import wx.App;
//import wx.Utils;

struct Point
{
	int X,Y;
}

struct Size
{
	int Width,Height;
}

struct Rectangle
{
	int X,Y,Width,Height;
	int  Left() { return X; }
	void Left(int value) { X = value; }
	int  Top() { return Y; }
	void Top(int value) { Y = value; }

	int  Right() { return X + Width - 1; }
	void Right(int value) { Width = value - X + 1; }
	int  Bottom() { return Y + Height - 1; }
	void Bottom(int value) { Height = value - Y + 1; }
}

/* struct constructor */
Point new_Point(int x,int y)
{
	Point pt;
	pt.X = x;
	pt.Y = y;
	return pt;
}
Size new_Size(int w,int h)
{
	Size sz;
	sz.Width = w;
	sz.Height = h;
	return sz;
}

Rectangle new_Rectangle(int x,int y,int w,int h)
{
	Rectangle rect;
	rect.X = x;
	rect.Y = y;
	rect.Width = w;
	rect.Height = h;
	return rect;
}

alias Rectangle Rect;

alias new_Rectangle new_Rect;

/+
import wx.GDIObject;
import wx.Colour;
import wx.Palette;
import wx.Icon;

import wx.Bitmap;
import wx.Brush;
import wx.Cursor;
import wx.Font;
import wx.Pen;
import wx.Region;

import wx.Window;


import wx.Defs;
import wx.wxObjects;
import wx.wxString;
import wx.Log;
import wx.Locale;
import wx.Event;
import wx.Utils:
#include "wx/defs.h"
#include "wx/object.h"
#include "wx/dynarray.h"
#include "wx/list.h"
#include "wx/hash.h"
#include "wx/string.h"
#include "wx/intl.h"
#include "wx/log.h"
#include "wx/event.h"
#include "wx/app.h"
#include "wx/utils.h"
#include "wx/stream.h"

#if wxUSE_GUI

#include "wx/window.h"
#include "wx/panel.h"
#include "wx/frame.h"
#include "wx/dc.h"
#include "wx/dcclient.h"
#include "wx/dcmemory.h"
#include "wx/dcprint.h"
#include "wx/dcscreen.h"
#include "wx/button.h"
#include "wx/menu.h"
#include "wx/pen.h"
#include "wx/brush.h"
#include "wx/palette.h"
#include "wx/icon.h"
#include "wx/cursor.h"
#include "wx/dialog.h"
#include "wx/timer.h"
#include "wx/settings.h"
#include "wx/msgdlg.h"
#include "wx/cmndata.h"
import wx.Window;
import wx.Panel;
import wx.Frame;
import wx.DC;
import wx.memoryDC;
import wx.Button;
import wx.Menu;
import wx.Pen;
import wx.Brush;
import wx.Palette;
import wx.Icon;
import wx.Dialog;
//import wx.Timer;
//import wx.Setting;
import wx.Palette;

#include "wx/control.h"
#include "wx/ctrlsub.h"
#include "wx/bmpbuttn.h"
#include "wx/checkbox.h"
#include "wx/checklst.h"
#include "wx/choice.h"
#include "wx/scrolbar.h"
#include "wx/stattext.h"
#include "wx/statbmp.h"
#include "wx/statbox.h"
#include "wx/listbox.h"
#include "wx/radiobox.h"
#include "wx/radiobut.h"
#include "wx/textctrl.h"
#include "wx/slider.h"
#include "wx/gauge.h"
#include "wx/scrolwin.h"
#include "wx/dirdlg.h"
#include "wx/toolbar.h"
#include "wx/combobox.h"
#include "wx/layout.h"
#include "wx/sizer.h"
#include "wx/memory.h"
#include "wx/mdi.h"
#include "wx/statusbr.h"
#include "wx/scrolbar.h"
#include "wx/choicdlg.h"
#include "wx/textdlg.h"
#include "wx/filedlg.h"

import wx.Control;
import wx.BitmapButton;
import wx.CheckBox;

// always include, even if !wxUSE_VALIDATORS because we need wxDefaultValidator
#include "wx/validate.h"

#if wxUSE_VALIDATORS
    #include "wx/valtext.h"
#endif // wxUSE_VALIDATORS

#endif // wxUSE_GUI

+/
