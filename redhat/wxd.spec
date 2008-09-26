Summary: wxWidgets bindings for the D programming language
Name: wxd
Version: 0.13
Release: 0
Source: http://downloads.sourceforge.net/wxd/%{name}-%{version}.tgz
Group: Development/Libraries
URL: http://wxd.sourceforge.net/
License: wxWindows Library Licence
BuildRoot: %{_tmppath}/%{name}-%{version}-root

%description
wxWidgets is a C++ cross-platform GUI toolkit, which supports
Windows, Macintosh, and Unix-like OSs - such as Linux,FreeBSD with
X11/Motif/GTK - and more. Link with the appropriate library for
your platform and compiler, and your application will adopt the
look and feel appropriate to that platform.

D is a general purpose systems and applications programming
language. It is a higher level language than C++, but retains the
ability to write high performance code and interface directly
with the operating system API's and with hardware. D is not a
scripting language, nor an interpreted language.

%prep
%setup -n %{name}

%build
export CXXFLAGS=$RPM_OPT_FLAGS 
export DFLAGS=`echo $RPM_OPT_FLAGS | sed -e s/-mtune=generic//`
if [ "`arch`" = "x86_64" -a "%{_arch}" = "i386" ]; then DFLAGS="$DFLAGS -Wa,--32"; fi
make WX_CONFIG=wx-config COMPILER=GDC
make WX_CONFIG=wx-config build

%install
rm -rf $RPM_BUILD_ROOT
%makeinstall

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%doc README.txt LICENCE.txt COPYING.LIB
%{_includedir}/d/wx
%{_libdir}/libwxc.a
%{_libdir}/libwxd.a

%changelog
* Fri Nov 17 2006 Anders F Bjorklund <afb@users.sourceforge.net> 0.08-0
- Initial rpm package
