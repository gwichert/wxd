module wx.common;

/*! \mainpage
 *  <p>wxD is <a href="http://www.wxwidgets.org/">wxWidgets</a> bindings for
 *  <a href="http://www.digitalmars.com/d/">the D programming language</a>.</p>
 */   

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

version (linux) {
  version = __WXGTK__;
}

version (darwin) {
  version = __WXMAC__;
}

	struct c_obj;
	typedef c_obj* IntPtr;

	alias char[] string;

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

/** struct constructor */
Point new_Point(int x,int y)
{
	Point pt;
	pt.X = x;
	pt.Y = y;
	return pt;
}

/** struct constructor */
Size new_Size(int w,int h)
{
	Size sz;
	sz.Width = w;
	sz.Height = h;
	return sz;
}

/** struct constructor */
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

