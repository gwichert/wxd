wxD - wxWidgets bindings for D language

	(c) 2005 BERO <berobero@users.sourceforge.net>

* About

wxD is wxWidgets bindings for D language.
wxWidgets is cross-platform GUI toolkit, which supports Windows, Mac OS X, *nix like OSs such as Linux,FreeBSD with X11/Motif/GTK.
wxD is delivered work from wx.NET bindings 0.6.1.


* Status

0.02
some bug fix and missing C function implement.
more example works.
fix event
change multiple consructor to single constructor with default args
fix box sizer
 return struct func to void func(struct*)
 in my view, D's extern (C) and C++'s extern "C" is not compatible when return struct
most example work.

0.01
Under development.
Currently only checked on Windows platform.
Some example program crashed.


* How to compile

** build wxWindows

- get wxWidgets-2.5.3
- extract
- compile
windows:
  cd build\msw
  make -f makefile.dmc
linux:
  ./configure
  make
  make install

** build wxD
- extract
- compile
windows:
  set WXDIR=<path to wxWidget>
  make
linux:
  make -f Makefile.linux


* Naming rules

- constant/enum wxXXXX is wxXXXX
- class/method wxXXX is XXX
- method SetXXX/GetXXX change to property XXX,
  but if XXX is class name, change first charactor to lower case 
  ex: void SetColour(wxColour)/wxColor GetColour() -> void colour(Color)/Colour colour()

Point,Size,Rect is native D struct instead of wxWidgets struct.
in D, struct can't have constructor.
for convinience, use constructor like function:
 Point new_Point(int x,int y);
 Size  new_Size(int w,int h);
 Rect  new_Rect(int x,int y,int w,int h)
(Rect is alias of Rectangle)

    C++ API passing array and number of element change to passing array only. D array knows number of element.
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
    -->     string choices[] = null,
            long style = 0,
            Validator validator = wxDefaultValidator,
            string name = wxListBoxNameStr)
   

* Licence

wxD is licenced under wxWindows Lincence which is LGPL with special exception to allow distirbute static linked binary.
wxWindows Licence is OSI approved.
for more infomation, see LICENCE.txt and COPYING.LIB


* Acknoredgement

- WxWidgets [http://www.wxwidgets.org/]
- wx.NET [http://wxnet.sourceforge.net/]
- D [http://www.digitalmars.com/d/]
