//-----------------------------------------------------------------------------
// wxD - ImageHandlers.d
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.ImageHandlers;
import wx.common;
import wx.Image;

  public static extern (C) IntPtr BMPHandler_ctor();
  public static extern (C) IntPtr ICOHandler_ctor();
  public static extern (C) IntPtr CURHandler_ctor();
  public static extern (C) IntPtr ANIHandler_ctor();
  public static extern (C) IntPtr GIFHandler_ctor();
  public static extern (C) IntPtr PNGHandler_ctor();
  public static extern (C) IntPtr PCXHandler_ctor();
  public static extern (C) IntPtr JPEGHandler_ctor();
  public static extern (C) IntPtr XPMHandler_ctor();
  public static extern (C) IntPtr PNMHandler_ctor();
  public static extern (C) IntPtr TIFFHandler_ctor();
  
  
  
public class BMPHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }
  
  public this()
  {
  	super(BMPHandler_ctor());
  }
}

public class ICOHandler : BMPHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(ICOHandler_ctor());
  }
}

public class CURHandler : ICOHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(CURHandler_ctor());
  }
}

public class ANIHandler : CURHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(ANIHandler_ctor());
  }
}

public class PNGHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(PNGHandler_ctor());
  }
}

public class GIFHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(GIFHandler_ctor());
  }
}

public class PCXHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(PCXHandler_ctor());
  }
}

public class JPEGHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(JPEGHandler_ctor());
  }
}


public class PNMHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(PNMHandler_ctor());
  }
}

public class XPMHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(XPMHandler_ctor());
  }
}

public class TIFFHandler : ImageHandler 
{
  public this(IntPtr ptr) { super(ptr); }

  public this()
  {
  	super(TIFFHandler_ctor());
  }
}
