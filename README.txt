wxD - wxWidgets bindings for D language

	(c) 2005 BERO <berobero@users.sourceforge.net>
	(c) 2005 afb <afb@users.sourceforge.net>

* About

wxD is wxWidgets bindings for the D programming language.

wxWidgets is a cross-platform GUI toolkit, which supports Windows,
Mac OS X, *nix-like OSs - such as Linux,FreeBSD with X11/Motif/GTK.

wxD is delivered work from wx.NET bindings 0.7.2 (wxWidgets 2.6.1)

It is composed of two parts:
   + wxc is a C++ library which exposes the wxWidgets API as a 
     collection of D friendly functions.
   + wxd is a library written in D which parallels the wxWidgets 
     class hierarchy, ported from wx.NET.


* Status

0.03 (afb)
Update to wx26
Fixed some wxChar issues with Unicode builds
Added support for wxVersion constants
Additionally checked on Linux/Mac OS X platforms.

0.02 (bero)
some bug fix and missing C function implement.
more example works.
fix event
change multiple constructor to single constructor with default args
fix box sizer
 return struct func to void func(struct*)
 in my view, D's extern (C) and C++'s extern "C" is not compatible when return struct
most example work.

0.01 (bero)
Under development.
Currently only checked on Windows platform.
Some example program crashed.


* How to compile

** build wxWidgets

- get wxWidgets-2.6.1
- extract
- compile
windows:
  cd build\msw
  make -f makefile.dmc
unix:
  ./configure
  make
  make install

** build wxD
- extract
- compile
windows:
  set WXDIR=<path to wxWidgets>
  make
unix:
  make


* Naming rules

- constant/enum wxXXXX is wxXXXX
- class/method wxXXX is XXX
- method SetXXX/GetXXX change to property XXX,
  but if XXX is class name, change first character to lower case 
  ex: void SetColour(wxColour)/wxColor GetColour() -> void colour(Color)/Colour colour()

Point,Size,Rect is native D struct instead of wxWidgets struct.
in D, struct can't have constructor.
for convenience, use constructor like function:
 Point new_Point(int x,int y);
 Size  new_Size(int w,int h);
 Rect  new_Rect(int x,int y,int w,int h)
(Rect is an alias of Rectangle)

    C++ API passing array and number of element change to passing array only.
    D array knows number of element.
    ex:

    wxListBox(wxWindow *parent, wxWindowID id,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
    --->    int n = 0, const wxString choices[] = NULL,
            long style = 0,
            const wxValidator validator = wxDefaultValidator,
            const wxString& name = wxListBoxNameStr)

    ListBox(Window parent, WindowID id,
            Point pos = wxDefaultPosition,
            Size size = wxDefaultSize,
    -->     char[] choices[] = null,
            long style = 0,
            Validator validator = wxDefaultValidator,
            string name = wxListBoxNameStr)
   

* Licence

wxD is licensed under the wxWindows Licence which is LGPL, with a
special exception to allow distributing as a static linked binary.

For more information, see files:
LICENCE.txt and COPYING.LIB

wxWindows Licence is OSI approved Open Source:
http://www.opensource.org/licenses/wxwindows.php


* Acknowledgements

- wxWidgets [http://www.wxwidgets.org/]
- wx.NET [http://wxnet.sourceforge.net/]
- D [http://www.digitalmars.com/d/]
- gdcmac [http://gdcmac.sourceforge.net/]
