//-----------------------------------------------------------------------------
// wxD - MiniFrame.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
// wx.NET - MiniFrame.cs
// 
// The wxMiniFrame wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.MiniFrame;
import wx.common;
import wx.Frame;

        static extern (C) IntPtr wxMiniFrame_ctor();
        static extern (C) bool   wxMiniFrame_Create(IntPtr self, IntPtr parent, int id, string title, inout Point pos, inout Size size, uint style, string name);

        //-----------------------------------------------------------------------------

    public class MiniFrame : Frame
    {
        public this(IntPtr wxobj) 
            { super(wxobj); }

        public this()
            { this(wxMiniFrame_ctor()); }

        public this(Window parent, int id, string title)
            { this(parent, id, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame"); }
	    
        public this(Window parent, int id, string title, inout Point pos)
            { this(parent, id, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame"); }
	    
        public this(Window parent, int id, string title, inout Point pos, inout Size size)
            { this(parent, id, title, pos, size, wxDEFAULT_FRAME_STYLE, "miniFrame"); }
	    
        public this(Window parent, int id, string title, inout Point pos, inout Size size, int style)
            { this(parent, id, title, pos, size, style, "miniFrame"); }

        public this(Window parent, int id, string title, inout Point pos, inout Size size, int style, string name)
        {
        	this();
            if (!Create(parent, id, title, pos, size, style, name))
            {
                throw new InvalidOperationException("Could not create MiniFrame");
            }
        }
	
	//---------------------------------------------------------------------
		// ctors with self created id
	
	public this(Window parent, string title)
            { this(parent, Window.UniqueID, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame"); }
	    
        public this(Window parent, string title, inout Point pos)
            { this(parent, Window.UniqueID, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame"); }
	    
        public this(Window parent, string title, inout Point pos, inout Size size)
            { this(parent, Window.UniqueID, title, pos, size, wxDEFAULT_FRAME_STYLE, "miniFrame"); }
	    
        public this(Window parent, string title, inout Point pos, inout Size size, int style)
            { this(parent, Window.UniqueID, title, pos, size, style, "miniFrame"); }

        public this(Window parent, string title, inout Point pos, inout Size size, int style, string name)
	    { this(parent, Window.UniqueID, title, pos, size, style, name);}
	
	//-----------------------------------------------------------------------------

        public bool Create(Window parent, int id, string title, inout Point pos, inout Size size, int style, string name)
        {
            return wxMiniFrame_Create(wxobj, wxObject.SafePtr(parent), id, title, pos, size, cast(uint)style, name);
        }

        //-----------------------------------------------------------------------------

        // Helper constructors

        public this(string title)
            { this(null, -1, title); }
        public this(string title, inout Point pos, inout Size size)
            { this(null, -1, title, pos, size); }
        public this(string title, inout Point pos, inout Size size, int style)
            { this(null, -1, title, pos, size, style); }

        //-----------------------------------------------------------------------------
    }

