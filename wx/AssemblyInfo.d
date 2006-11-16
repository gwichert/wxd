//------------------------------------------------------------------------
// wx.NET - AssemblyInfo.cs
// 
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//------------------------------------------------------------------------

using System;
using System.Reflection;
using System.Resources;
using System.Security;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// Manually maintained to release version. Example version:
//    0.6.0.1 - 6.0 Beta 1
[assembly: AssemblyVersion("0.7.0.2")]

[assembly: AssemblyTitle("wx.NET.dll")]
[assembly: AssemblyDescription("wxWidgets for .NET Library; see http://wxnet.sf.net/")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("wx.NET Development Team")]
[assembly: AssemblyProduct("")]
[assembly: AssemblyCopyright("(C) 2004,2005 Various Authors")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]	

[assembly: AllowPartiallyTrustedCallers()]

// Currently use an unsecured private/public keypair. Given the pre-release
// nature of the project this simplifies strong naming.
#if __WXMSW__
[assembly: AssemblyKeyFile("../../keys.snk")]
#else
[assembly: AssemblyKeyFile("keys.snk")]
#endif
[assembly: AssemblyDelaySign(false)]
