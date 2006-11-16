wxD - wxWidgets bindings for D language

	(c) 2005 BERO <berobero@users.sourceforge.net>

* About

wxD is wxWidgets bindings for D language.
it is delivered work from wx.NET bindings.


* Status

0.01
under development.
currently only work on Windows platform.


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


* Acknoredgement

- WxWidgets [http://www.wxwidgets.org/]
- wx.NET [http://wxnet.sourceforge.net/]
- D [http://www.digitakmars.com/d/]
