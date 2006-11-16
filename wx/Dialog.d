//-----------------------------------------------------------------------------
// wx.NET - Dialog.cs
//
// The wxDialog wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
	public class Dialog : Window
	{
		public const long wxCENTER		= 0x00000001;
		public const long wxCENTRE		= 0x00000001;
		public const long wxYES			= 0x00000002;
		public const long wxOK			= 0x00000004;
		public const long wxNO			= 0x00000008;
		public const long wxCANCEL		= 0x00000010;
		public const long wxYES_NO		= (wxYES | wxNO);

		public const long wxYES_DEFAULT		= 0x00000000;
		public const long wxNO_DEFAULT		= 0x00000080;

		public const long wxICON_EXCLAMATION 	= 0x00000100;
		public const long wxICON_HAND		= 0x00000200;
		public const long wxICON_WARNING	= wxICON_EXCLAMATION;
		public const long wxICON_ERROR		= wxICON_HAND;
		public const long wxICON_QUESTION	= 0x00000400;
		public const long wxICON_INFORMATION	= 0x00000800;
		public const long wxICON_STOP		= wxICON_HAND;
		public const long wxICON_ASTERISK	= wxICON_INFORMATION;
		public const long wxICON_MASK		= (0x00000100|0x00000200|0x00000400|0x00000800);

		public const long wxFORWARD		= 0x00001000;
		public const long wxBACKWARD		= 0x00002000;
		public const long wxRESET		= 0x00004000;
		public const long wxHELP		= 0x00008000;
		public const long wxMORE 		= 0x00010000;
		public const long wxSETUP		= 0x00020000;

		//---------------------------------------------------------------------

		[DllImport("wx-c")] static extern IntPtr wxDialog_ctor();
		[DllImport("wx-c")] static extern void   wxDialog_dtor(IntPtr self);

		[DllImport("wx-c")] static extern void   wxDialog_SetReturnCode(IntPtr self, int returnCode);
		[DllImport("wx-c")] static extern int    wxDialog_GetReturnCode(IntPtr self);

		[DllImport("wx-c")] static extern IntPtr wxDialog_GetTitle(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDialog_SetTitle(IntPtr self, string title);

		[DllImport("wx-c")] static extern bool   wxDialog_Create(IntPtr self, IntPtr parent, int id, string title, ref Point pos, ref Size size, uint style, string name);

		[DllImport("wx-c")] static extern void   wxDialog_EndModal(IntPtr self, int retCode);

		[DllImport("wx-c")] static extern bool   wxDialog_IsModal(IntPtr self);
		[DllImport("wx-c")] static extern void   wxDialog_SetModal(IntPtr self, bool modal);

		[DllImport("wx-c")] static extern void   wxDialog_SetIcon(IntPtr self, IntPtr icon);
		[DllImport("wx-c")] static extern void   wxDialog_SetIcons(IntPtr self, IntPtr icons);

		[DllImport("wx-c")] static extern int    wxDialog_ShowModal(IntPtr self);

		//---------------------------------------------------------------------
		
		public Dialog(IntPtr wxObject) 
			: base(wxObject) {}

		public Dialog()
			: base(wxDialog_ctor()) { }

		public Dialog(Window parent, string title)
			: this(parent, Window.UniqueID, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null) { }

		public Dialog(Window parent, int id, string title)
			: this(parent, id, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null) { }

		public Dialog(Window parent, int id, string title, Point pos)
			: this(parent, id, title, pos, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null) { }

		public Dialog(Window parent, int id, string title, Point pos, Size size)
			: this(parent, id, title, pos, size, wxDEFAULT_DIALOG_STYLE, null) { }

		public Dialog(Window parent, int id, string title, Point pos, Size size, long style)
			: this(parent, id, title, pos, size, style, null) { }

		public Dialog(Window parent, int id, string title, Point pos, Size size, long style, string name)
			: base(wxDialog_ctor())
		{
			if (!Create(parent, id, title, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create Dialog");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public Dialog(Window parent, string title, Point pos)
			: this(parent, Window.UniqueID, title, pos, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null) { }

		public Dialog(Window parent, string title, Point pos, Size size)
			: this(parent, Window.UniqueID, title, pos, size, wxDEFAULT_DIALOG_STYLE, null) { }

		public Dialog(Window parent, string title, Point pos, Size size, long style)
			: this(parent, Window.UniqueID, title, pos, size, style, null) { }

		public Dialog(Window parent, string title, Point pos, Size size, long style, string name)
			: this(parent, Window.UniqueID, title, pos, size, style, name) {}
		
		//---------------------------------------------------------------------

		public bool Create(Window window, int id, string title, Point pos,
						   Size size, long style, string name)
		{
			return wxDialog_Create(wxObject, Object.SafePtr(window), id, title,
								   ref pos, ref size, (uint)style, name);
		}

		//---------------------------------------------------------------------

		public int ReturnCode
		{
			get { return wxDialog_GetReturnCode(wxObject); }
			set { wxDialog_SetReturnCode(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public override string Title
		{
			get { return new wxString(wxDialog_GetTitle(wxObject), true); }
			set { wxDialog_SetTitle(wxObject, value); }
		}

		//---------------------------------------------------------------------

		public void EndModal(long retCode)
		{
			wxDialog_EndModal(wxObject, (int)retCode);
		}

		//---------------------------------------------------------------------

		public void SetIcon(Icon icon)
		{
			wxDialog_SetIcon(wxObject, Object.SafePtr(icon));
		}

		/*public void SetIcons(IconBundle icons)
		{
			wxDialog_SetIcons(wxObject, Object.SafePtr(icons);
		}*/

		//---------------------------------------------------------------------

		public virtual int ShowModal()
		{
			return wxDialog_ShowModal(wxObject);
		}

		//---------------------------------------------------------------------

		public bool Modal
		{
			set { wxDialog_SetModal(wxObject, value); }
			get { return wxDialog_IsModal(wxObject); }
		}
	}
}
