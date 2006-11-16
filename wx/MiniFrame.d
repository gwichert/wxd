//-----------------------------------------------------------------------------
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

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class MiniFrame : Frame
    {
        [DllImport("wx-c")] static extern IntPtr wxMiniFrame_ctor();
        [DllImport("wx-c")] static extern bool   wxMiniFrame_Create(IntPtr self, IntPtr parent, int id, string title, ref Point pos, ref Size size, uint style, string name);

        //-----------------------------------------------------------------------------

        public MiniFrame(IntPtr wxObject) 
            : base(wxObject) { }

        public MiniFrame()
            : this(wxMiniFrame_ctor()) { }

        public MiniFrame(Window parent, int id, string title)
            : this(parent, id, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame") { }
	    
        public MiniFrame(Window parent, int id, string title, Point pos)
            : this(parent, id, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame") { }
	    
        public MiniFrame(Window parent, int id, string title, Point pos, Size size)
            : this(parent, id, title, pos, size, wxDEFAULT_FRAME_STYLE, "miniFrame") { }
	    
        public MiniFrame(Window parent, int id, string title, Point pos, Size size, long style)
            : this(parent, id, title, pos, size, style, "miniFrame") { }

        public MiniFrame(Window parent, int id, string title, Point pos, Size size, long style, string name)
            : this()
        {
            if (!Create(parent, id, title, pos, size, style, name))
            {
                throw new InvalidOperationException("Could not create MiniFrame");
            }
        }
	
	//---------------------------------------------------------------------
		// ctors with self created id
	
	public MiniFrame(Window parent, string title)
            : this(parent, Window.UniqueID, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame") { }
	    
        public MiniFrame(Window parent, string title, Point pos)
            : this(parent, Window.UniqueID, title, pos, wxDefaultSize, wxDEFAULT_FRAME_STYLE, "miniFrame") { }
	    
        public MiniFrame(Window parent, string title, Point pos, Size size)
            : this(parent, Window.UniqueID, title, pos, size, wxDEFAULT_FRAME_STYLE, "miniFrame") { }
	    
        public MiniFrame(Window parent, string title, Point pos, Size size, long style)
            : this(parent, Window.UniqueID, title, pos, size, style, "miniFrame") { }

        public MiniFrame(Window parent, string title, Point pos, Size size, long style, string name)
	    : this(parent, Window.UniqueID, title, pos, size, style, name) {}
	
	//-----------------------------------------------------------------------------

        public new bool Create(Window parent, int id, string title, Point pos, Size size, long style, string name)
        {
            return wxMiniFrame_Create(wxObject, Object.SafePtr(parent), id, title, ref pos, ref size, (uint)style, name);
        }

        //-----------------------------------------------------------------------------

        // Helper constructors

        public MiniFrame(string title)
            : this(null, -1, title) { }
        public MiniFrame(string title, Point pos, Size size)
            : this(null, -1, title, pos, size) { }
        public MiniFrame(string title, Point pos, Size size, long style)
            : this(null, -1, title, pos, size, style) { }

        //-----------------------------------------------------------------------------
    }
}

