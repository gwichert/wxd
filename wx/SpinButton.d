//-----------------------------------------------------------------------------
// wx.NET - SpinButton.cs
//
// The wxSpinButton wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class SpinEvent : CommandEvent
	{
		[DllImport("wx-c")] static extern IntPtr wxSpinEvent_ctor(int commandType, int id);
		[DllImport("wx-c")] static extern int wxSpinEvent_GetPosition(IntPtr self);
		[DllImport("wx-c")] static extern void wxSpinEvent_SetPosition(IntPtr self, int pos);
		[DllImport("wx-c")] static extern void wxSpinEvent_Veto(IntPtr self);
		[DllImport("wx-c")] static extern void wxSpinEvent_Allow(IntPtr self);
		[DllImport("wx-c")] static extern bool wxSpinEvent_IsAllowed(IntPtr self);	

		//-----------------------------------------------------------------------------
	
		public SpinEvent(IntPtr wxObject)
			: base(wxObject) { }	
			
		public SpinEvent(int commandType, int id)
			: base(wxSpinEvent_ctor(commandType, id)) { }		

		//-----------------------------------------------------------------------------	

		public int Position
		{
			get { return wxSpinEvent_GetPosition(wxObject); }
			set { wxSpinEvent_SetPosition(wxObject, value); }
		}
		
		//-----------------------------------------------------------------------------
		
		public void Veto()
		{
			wxSpinEvent_Veto(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public void Allow()
		{
			wxSpinEvent_Allow(wxObject);
		}
		
		//-----------------------------------------------------------------------------
		
		public bool Allowed
		{
			get { return wxSpinEvent_IsAllowed(wxObject); }
		}		
	}
	
	//-----------------------------------------------------------------------------
	
	public class SpinButton : Control
	{
		// These are duplicated in SpinCtrl.cs (for easier access)
		public const long wxSP_HORIZONTAL       = Orientation.wxHORIZONTAL;
		public const long wxSP_VERTICAL         = Orientation.wxVERTICAL;
		public const long wxSP_ARROW_KEYS       = 0x1000;
		public const long wxSP_WRAP             = 0x2000;
	
		//---------------------------------------------------------------------
        
		[DllImport("wx-c")] static extern IntPtr wxSpinButton_ctor();
		[DllImport("wx-c")] static extern bool   wxSpinButton_Create(IntPtr self, IntPtr parent, int id, ref Point pos, ref Size size, uint style, string name);
		[DllImport("wx-c")] static extern int    wxSpinButton_GetValue(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSpinButton_GetMin(IntPtr self);
		[DllImport("wx-c")] static extern int    wxSpinButton_GetMax(IntPtr self);
		[DllImport("wx-c")] static extern void   wxSpinButton_SetValue(IntPtr self, int val);
		[DllImport("wx-c")] static extern void   wxSpinButton_SetRange(IntPtr self, int minVal, int maxVal);

		//---------------------------------------------------------------------
		
		public SpinButton(IntPtr wxObject) 
			: base(wxObject) {}

		public SpinButton()
			: base(wxSpinButton_ctor()) { }
			
		public SpinButton(Window parent, int id)
			: this(parent, id, wxDefaultPosition, wxDefaultSize, 0, "spinButton") { }
			
		public SpinButton(Window parent, int id, Point pos)
			: this(parent, id, pos, wxDefaultSize, 0, "spinButton") { }
			
		public SpinButton(Window parent, int id, Point pos, Size size)
			: this(parent, id, pos, size, 0, "spinButton") { }

		public SpinButton(Window parent, int id, Point pos, Size size, long style)
			: this(parent, id, pos, size, style, "spinButton") { }

		public SpinButton(Window parent, int id, Point pos, Size size, long style, string name)
			: base(wxSpinButton_ctor())
		{
			if(!Create(parent, id, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create SpinButton");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public SpinButton(Window parent)
			: this(parent, Window.UniqueID, wxDefaultPosition, wxDefaultSize, 0, "spinButton") { }
			
		public SpinButton(Window parent, Point pos)
			: this(parent, Window.UniqueID, pos, wxDefaultSize, 0, "spinButton") { }
			
		public SpinButton(Window parent, Point pos, Size size)
			: this(parent, Window.UniqueID, pos, size, 0, "spinButton") { }

		public SpinButton(Window parent, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, pos, size, style, "spinButton") { }

		public SpinButton(Window parent, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, pos, size, style, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window parent, int id, Point pos, Size size,  long style, string name)
		{
			return wxSpinButton_Create(wxObject, Object.SafePtr(parent), id,
						ref pos, ref size, (uint)style, name);
		}

		//---------------------------------------------------------------------
        
		public int Value
		{
			get { return wxSpinButton_GetValue(wxObject); }
			set { wxSpinButton_SetValue(wxObject, value); }
		}

		//---------------------------------------------------------------------
        
		public int Max
		{
			get { return wxSpinButton_GetMax(wxObject); }
		}

		public int Min
		{
			get { return wxSpinButton_GetMin(wxObject); }
		}

		public void SetRange(int min, int max)
		{
			wxSpinButton_SetRange(wxObject, min, max);
		}
	}
}
