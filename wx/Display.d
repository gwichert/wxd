//------------------------------------------------------------------------
// wx.NET - Display.cs
// 
// Michael S. Muegel mike _at_ muegel dot org
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// TODO:
//    + Memory management review
//
// wxWidgets-based quirks of note:
//    + Display resolution did not change on my Fedora1 test system
//      under both wxWidgets display sample and my port.
//    + IsPrimary is wrong, at least on WIN32: assumes display #0
//      is primary, which may not be the case. For example, I have
//      three horizontally aligned displays. wxWidgets numbers them
//      0, 1, 2. But it's #1 is actually the primary, not 0. Note also
//      that the numbering scheme differs from how windows numbers
//      them, which has more to do with the display adapter used. This
//      is not an issue really, but something to be aware of should
//      you be expecting them to match.
//------------------------------------------------------------------------

#if WXNET_DISPLAY

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class Display : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxDisplay_ctor(int index);
		[DllImport("wx-c")] static extern IntPtr wxDisplay_ctor(ref VideoMode mode);
		[DllImport("wx-c")] static extern int wxDisplay_GetCount();
		[DllImport("wx-c")] static extern int wxDisplay_GetFromPoint(ref Point pt);
		[DllImport("wx-c")] static extern int wxDisplay_GetFromWindow(IntPtr window);
		[DllImport("wx-c")] static extern void wxDisplay_GetGeometry(IntPtr self, out Rectangle rect);
		[DllImport("wx-c")] static extern IntPtr wxDisplay_GetName(IntPtr self);
		[DllImport("wx-c")] static extern bool wxDisplay_IsPrimary(IntPtr self);
		[DllImport("wx-c")] static extern void wxDisplay_GetCurrentMode(IntPtr self, out VideoMode mode);
		[DllImport("wx-c")] static extern bool wxDisplay_ChangeMode(IntPtr self, VideoMode mode);


		[DllImport("wx-c")] static extern int wxDisplay_GetNumModes(IntPtr self, VideoMode mode);
		[DllImport("wx-c")] static extern void wxDisplay_GetModes(IntPtr self, VideoMode mode, [In, Out] VideoMode[] modes);

		
		[DllImport("wx-c")] static extern void wxDisplay_ResetMode(IntPtr self);
		[DllImport("wx-c")] static extern void wxDisplay_dtor(IntPtr self);

		//------------------------------------------------------------------------

		// Symbolic constant used by all Find()-like functions returning positive
		// integer on success as failure indicator. While this is global in
		// wxWidgets it makes more sense to be in each class that uses it??? 
		// Or maybe move it to Window.cs.
		public const int wxNOT_FOUND = -1;
		
		//------------------------------------------------------------------------
		
		public Display(IntPtr wxObject)
			: base(wxObject)
		{ 
			this.wxObject = wxObject;
		}
			
		internal Display(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}

		//------------------------------------------------------------------------

		public Display(int index)
			: this(wxDisplay_ctor(index), true) { }

		//------------------------------------------------------------------------

		public Display(VideoMode mode)
			: this(wxDisplay_ctor(ref mode), true) { }
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxDisplay_dtor(wxObject);
						memOwn = false;
					}
				}
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~Display() 
		{
			Dispose();
		}

		//------------------------------------------------------------------------
		public static int Count
		{
			get { return wxDisplay_GetCount(); }
		}

		// an array of all Displays indexed by display number
		public static Display[] GetDisplays()
		{
			Display[] displays = new Display[Count];
			for (int i = 0; i < Count; i++)
			{
				displays[i] = new Display(i);
			}
			return displays;
		}

		//------------------------------------------------------------------------
		// An array of available VideoModes for this display.
		virtual public VideoMode[] GetModes()
		{
			return GetModes(new VideoMode(0,0,0,0));
		}

		// An array of the VideoModes that match mode. A match occurs when
		// the resolution and depth matches and the refresh frequency in 
		// equal to or greater than mode.RefreshFrequency.
		virtual public VideoMode[] GetModes(VideoMode mode)
		{
			int num_modes = wxDisplay_GetNumModes(wxObject, mode);
			VideoMode[] modes = new VideoMode[num_modes];
			wxDisplay_GetModes(wxObject, mode, modes);
			return modes;
		}


		//------------------------------------------------------------------------

		public static int GetFromPoint(Point pt)
		{
			return wxDisplay_GetFromPoint(ref pt);
		}

		//------------------------------------------------------------------------

		virtual public int GetFromWindow(Window window)
		{
			#if __WXMSW__
				return wxDisplay_GetFromWindow(Object.SafePtr(window));
			#else
				throw new ApplicationException("Display.GetFromWindow is only available on WIN32");
			#endif
		}

		//------------------------------------------------------------------------

		virtual public Rectangle Geometry
		{
			get 
			{
				Rectangle rect = new Rectangle();
				wxDisplay_GetGeometry(wxObject, out rect);
				return rect;
			}
		}

		//------------------------------------------------------------------------

		virtual public string Name
		{
			get 
			{
				return new wxString(wxDisplay_GetName(wxObject), true);
			}
		}

		//------------------------------------------------------------------------

		virtual public bool IsPrimary
		{
			get 
			{ 
				return wxDisplay_IsPrimary(wxObject);
			}
		}

		//------------------------------------------------------------------------


		virtual public VideoMode CurrentMode
		{
			get
			{
				VideoMode mode;
				wxDisplay_GetCurrentMode(wxObject, out mode);
				return mode;
			}
		}

		//------------------------------------------------------------------------

		virtual public bool ChangeMode(VideoMode mode)
		{
			return wxDisplay_ChangeMode(wxObject, mode);
		}

		//------------------------------------------------------------------------

		virtual public void ResetMode()
		{
			wxDisplay_ResetMode(wxObject);
		}

		//------------------------------------------------------------------------

	}

}

#endif
