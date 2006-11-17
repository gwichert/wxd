/// Common structs that do not belong to any particular class
module wx.common;

/*! \mainpage
 *  <p><a href="http://wxd.sourceforge.net/"><b>wxD</b></a> is
 *  <a href="http://www.wxwidgets.org/">wxWidgets</a> bindings for the
 *  <a href="http://www.d-programming-language.org/">D programming language</a>.</p>
 */   

//! \cond STD
private import std.c.stddef;
//! \endcond

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


	/// An implementation-specific type that is used to represent a pointer or a handle.
	typedef void* IntPtr;

version(UNICODE)
	alias wchar_t wxChar;
else // ANSI
	alias char wxChar;

	alias char[] string;


//public import wx.Defs;
public public import wx.wxObject;
//public import wx.wxString;
//public import wx.Log;
//public import wx.Event;
//public import wx.EvtHandler;
//public import wx.App;
//public import wx.Utils;

alias Point wxPoint;
struct Point
{
	int X,Y;

	/** struct constructor */
	static Point opCall(int x,int y)
	{
	    Point pt;
	    pt.X = x;
	    pt.Y = y;
	    return pt;
	}
}

alias Size wxSize;
struct Size
{
	int Width,Height;

	/** struct constructor */
	static Size opCall(int w,int h) {
	    Size sz;
	    sz.Width = w;
	    sz.Height = h;
	    return sz;
	}
}

alias Rectangle wxRectangle;
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

	/** struct constructor */
	static Rectangle opCall(int x,int y,int w,int h)
	{
	    Rectangle rect;
	    rect.X = x;
	    rect.Y = y;
	    rect.Width = w;
	    rect.Height = h;
	    return rect;
	}
}

alias Rect wxRect;
alias Rectangle Rect;

alias new_Rectangle new_Rect;


deprecated Point new_Point(int x,int y)
{
	return Point(x,y);
}

deprecated Size new_Size(int w,int h)
{
	return Size(w,h);
}

deprecated Rectangle new_Rectangle(int x,int y,int w,int h)
{
	return Rectangle(x,y,w,h);
}


