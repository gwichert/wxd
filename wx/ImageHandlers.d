//-----------------------------------------------------------------------------
// wx.NET - ImageHandlers.cs
//
// The wxImageHandlers wrapper classes.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
public class BMPHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_BMPHandler")] public static extern IntPtr new_BMPHandler();
  
  public BMPHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public BMPHandler()
    : this(new_BMPHandler())
  {
  }
}

public class ICOHandler : BMPHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_ICOHandler")] public static extern IntPtr new_ICOHandler();
  
  public ICOHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public ICOHandler()
    : this(new_ICOHandler())
  {
  }
}

public class CURHandler : ICOHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_CURHandler")] public static extern IntPtr new_CURHandler();
  
  public CURHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public CURHandler()
    : this(new_CURHandler())
  {
  }
}

public class ANIHandler : CURHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_ANIHandler")] public static extern IntPtr new_ANIHandler();

  public ANIHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public ANIHandler()
    : this(new_ANIHandler())
  {
  }
}

public class PNGHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_PNGHandler")] public static extern IntPtr new_PNGHandler();

  public PNGHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public PNGHandler()
    : this(new_PNGHandler())
  {
  }
}

public class GIFHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_GIFHandler")] public static extern IntPtr new_GIFHandler();

  public GIFHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public GIFHandler()
    : this(new_GIFHandler())
  {
  }
}

public class PCXHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_PCXHandler")] public static extern IntPtr new_PCXHandler();

  public PCXHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public PCXHandler()
    : this(new_PCXHandler())
  {
  }
}

public class JPEGHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_JPEGHandler")] public static extern IntPtr new_JPEGHandler();

  public JPEGHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public JPEGHandler()
    : this(new_JPEGHandler())
  {
  }
}

public class PNMHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_PNMHandler")] public static extern IntPtr new_PNMHandler();

  public PNMHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public PNMHandler()
    : this(new_PNMHandler())
  {
  }
}

public class XPMHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_XPMHandler")] public static extern IntPtr new_XPMHandler();

  public XPMHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public XPMHandler()
    : this(new_XPMHandler())
  {
  }
}

public class TIFFHandler : ImageHandler 
{
  [DllImport("wx-c", EntryPoint="CSharp_new_TIFFHandler")] public static extern IntPtr new_TIFFHandler();

  public TIFFHandler(IntPtr wxObject) 
    : base(wxObject) {}

  public TIFFHandler()
    : this(new_TIFFHandler())
  {
  }
}

}
