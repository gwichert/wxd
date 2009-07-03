wxD - wxWidgets bindings for D language

	(c) 2005 BERO <berobero@users.sourceforge.net>
	(c) 2007 afb <afb@users.sourceforge.net>

* About

wxD is wxWidgets bindings for the D programming language.

wxWidgets is a cross-platform GUI toolkit, which supports Windows,
Mac OS X, *nix-like OSs - such as Linux,FreeBSD with X11/Motif/GTK.

wxD is delivered work from wx.NET bindings 0.7.2 (wxWidgets 2.6.1)
It should also work compiled with the later versions of wxWidgets.

It is composed of two parts:
   + wxc is a C++ library which exposes the wxWidgets API as a 
     collection of D friendly functions.
   + wxd is a library written in D which parallels the wxWidgets 
     class hierarchy, ported from wx.NET.


* Status

0.15 (afb)
Add support for DMD on Mac OS X (i386 only)
Fix setting of version=Posix and ldmd usage
Support for building on Windows without MSYS

0.14 (afb)
Handled strange wxWidgets --libs, on Ubuntu
Fixed building with LDC 0.9 (LLVM) compiler

0.13 (afb)
Fixed linking with DMD 2 under Linux (-L)
Converted more of the samples to D2 syntax
Added projects for Xcode 2 (with D plugin)
Tested with SVN GDC, and DMD 1.030 / 2.019

0.12 (afb)
Added new TaskBarIcon class, by Mike Wey
Preliminary invariant string (D2) support
Tango "toString()" support, for 0.99.4+
Updated projects for Code::Blocks release

0.11 (afb)
Added "release" information to D versions
Support for DMD 1.016+ and "string" alias
Added new classes Thread (todo) and Timer
StyledText sample completed, by Mike Wey

0.10 (afb)
Support for building with wxWidgets 2.8.x
Support for compiling with Tango as well

0.09 (afb)
Redid string handling with Unicode support
Support for using wx-config.exe on Windows
Merge changes / share code with new wx.NET
Support for the DSSS (and bu[il]d) systems

0.08 (afb)
Added StyledText sample for wxSTC testing
Cleaned up Makefiles, and "DFLAGS" usage
Not build Samples by default ("make test")
Added project files for Code::Blocks / GDC

0.07 (afb)
Updated imports for DMD 0.164 ("public")
Moved all config files to a sub-directory
Fixed MSW issue with Update/UpdateContext
Now compiles with D warnings enabled too

0.06 (afb)
Lots of bugfixes by Matrix, thanks a lot!
Fixed issue with wxValidator* constness
Fixed issue with null GL context on Linux
Added Launcher sample and continued port

0.05 (afb)
Fixed issue with D bool versus C++ bool
Deprecated the new_ struct constructors
Added wxSound class and the Sound sample
Extra documentation comments for the modules

0.04 (afb)
Removed the extra gcc linking for Darwin
Added wxGLCanvas class and the GLCube sample
Added Doxygen documentation (and \cond+\endcond)
Extra configuration files for MinGW32 (Windows)

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

- get wxWidgets-2.6.x
- extract
- regenerate, if needed
windows: (Digital Mars)
    cd build\bakefiles
    bakefile_gen
unix: (GNU)
    ./autogen.sh
- compile and install
windows: (Digital Mars)
  cd build\msw
  make -f makefile.dmc
unix: (GNU)
  ./configure
  make
  sudo make install
macosx: (Xcode)
  cd src; open wxWindows.xcodeproj and "Build" /or/
  xcodebuild -target dynamic -configuration Deployment

** build wxD

- extract
- compile
windows:
  set WXDIR=<path to wxWidgets>
  make all test
unix:
  make all test
  sudo make install
macosx: (Xcode)
  set WXWIN=<path to wxWidgets>
  xcodebuild -alltargets
freebsd:
  gmake all test
  su -c "make install"
bud: (see http://dsource.org/projects/build/)
  make bud
rebuild: (see http://dsource.org/projects/dsss/wiki/Rebuild)
  make rebuild
DSSS: (see http://dsource.org/projects/dsss/)
  dsss build
  dsss install
Code::Blocks: (see http://codeblocks.org)
  codeblocks --build wxc.cbp
  codeblocks --build wxd.cbp

* Linking

When compiling programs using wxD, you need to make sure to include all of:
wxd (D linkage), wxc (C linkage), wxWidgets (C++ linkage), stdc++ libraries

Unix systems can use the output from `wx-config --libs` to determine wx libs.
Build systems should set up pragmas, in wx.libs module, by using "make build".

* Naming rules

- constant/enum wxXXXX is wxXXXX
- class/method wxXXX is XXX
- method SetXXX/GetXXX change to property XXX,
  but if XXX is class name, change first character to lower case 
  ex: void SetColour(wxColour)/wxColor GetColour() -> void colour(Color)/Colour colour()

Point,Size,Rect is native D struct instead of wxWidgets struct.
in D, struct can't have constructor.
for convenience, use constructor like function:
 Point Point(int x,int y);
 Size  Size(int w,int h);
 Rect  Rect(int x,int y,int w,int h)
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
    -->     string choices[] = null,
            long style = 0,
            Validator validator = wxDefaultValidator,
            string name = wxListBoxNameStr)
   
* Platforms

When compiling wxD programs, you need to tell it which version of
wxWidgets that you want (i.e. what platform you are targetting)

Your platform name should be available in the file "wxc/PLATFORM".
(Build systems such as Bud/Rebuild will have it set by "wx.libs")

Here are the main supported ones:
Windows XP     version=__WXMSW__
Linux/GTK+     version=__WXGTK__
Macintosh      version=__WXMAC__

For checking the wx platform at runtime, see the wxPlatform class.

* Encodings

There are two ways to compile wxWidgets, as "ansi" or as "unicode"
The former uses "char" characters, and the latter uses "wchar_t".

Your encoding name should be available in the file "wxc/ENCODING".
(Build systems such as Bud/Rebuild will have it set by "wx.libs")

wx-config:     DFLAGS:
--unicode=no   version=ANSI
--unicode=yes  version=UNICODE

The alias "string" is used in wxD, for char[] strings (UTF-8 format)

* Licence

wxD is licensed under the wxWindows Licence which is LGPL, with a
special exception to allow distributing as a static linked binary.

This is a solution that satisfies those who wish to produce GPL'ed
software with wxD, and also those producing proprietary software.

For more information, see files:
LICENCE.txt and COPYING.LIB

wxWindows Licence is OSI approved Open Source:
http://www.opensource.org/licenses/wxwindows.php


* Acknowledgements

- wxWidgets [http://www.wxwidgets.org/]
- wx.NET [http://wxnet.sourceforge.net/]
- DMD [http://www.digitalmars.com/d/]
- GDC [http://dgcc.sourceforge.net/]
- D [http://www.d-programming-language.org/]
- gdcmac [http://gdcmac.sourceforge.net/]
- gdcgnu [http://gdcgnu.sourceforge.net/]
- gdcwin [http://gdcwin.sourceforge.net/]
