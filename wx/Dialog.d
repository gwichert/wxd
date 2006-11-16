//-----------------------------------------------------------------------------
// wxD - Dialog.cs
// (C) 2005 bero <berobero@users.sourceforge.net>
// based on
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

module wx.Dialog;
import wx.common;
import wx.Window;

		static extern (C) IntPtr wxDialog_ctor();
		static extern (C) void   wxDialog_dtor(IntPtr self);

		static extern (C) void   wxDialog_SetReturnCode(IntPtr self, int returnCode);
		static extern (C) int    wxDialog_GetReturnCode(IntPtr self);

		static extern (C) string wxDialog_GetTitle(IntPtr self);
		static extern (C) void   wxDialog_SetTitle(IntPtr self, string title);

		static extern (C) bool   wxDialog_Create(IntPtr self, IntPtr parent, int id, string title, inout Point pos, inout Size size, uint style, string name);

		static extern (C) void   wxDialog_EndModal(IntPtr self, int retCode);

		static extern (C) bool   wxDialog_IsModal(IntPtr self);
		static extern (C) void   wxDialog_SetModal(IntPtr self, bool modal);

		static extern (C) void   wxDialog_SetIcon(IntPtr self, IntPtr icon);
		static extern (C) void   wxDialog_SetIcons(IntPtr self, IntPtr icons);

		static extern (C) int    wxDialog_ShowModal(IntPtr self);

		//---------------------------------------------------------------------
		
	public class Dialog : Window
	{
		public const int wxCENTER		= 0x00000001;
		public const int wxCENTRE		= 0x00000001;
		public const int wxYES			= 0x00000002;
		public const int wxOK			= 0x00000004;
		public const int wxNO			= 0x00000008;
		public const int wxCANCEL		= 0x00000010;
		public const int wxYES_NO		= (wxYES | wxNO);

		public const int wxYES_DEFAULT		= 0x00000000;
		public const int wxNO_DEFAULT		= 0x00000080;

		public const int wxICON_EXCLAMATION 	= 0x00000100;
		public const int wxICON_HAND		= 0x00000200;
		public const int wxICON_WARNING	= wxICON_EXCLAMATION;
		public const int wxICON_ERROR		= wxICON_HAND;
		public const int wxICON_QUESTION	= 0x00000400;
		public const int wxICON_INFORMATION	= 0x00000800;
		public const int wxICON_STOP		= wxICON_HAND;
		public const int wxICON_ASTERISK	= wxICON_INFORMATION;
		public const int wxICON_MASK		= (0x00000100|0x00000200|0x00000400|0x00000800);

		public const int wxFORWARD		= 0x00001000;
		public const int wxBACKWARD		= 0x00002000;
		public const int wxRESET		= 0x00004000;
		public const int wxHELP		= 0x00008000;
		public const int wxMORE 		= 0x00010000;
		public const int wxSETUP		= 0x00020000;

		//---------------------------------------------------------------------

		public this(IntPtr wxobj) 
			{ super(wxobj);}

		public this()
			{ super(wxDialog_ctor()); }

		public this(Window parent, string title)
			{ this(parent, Window.UniqueID, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null); }

		public this(Window parent, int id, string title)
			{ this(parent, id, title, wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null); }

		public this(Window parent, int id, string title, Point pos)
			{ this(parent, id, title, pos, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null); }

		public this(Window parent, int id, string title, Point pos, Size size)
			{ this(parent, id, title, pos, size, wxDEFAULT_DIALOG_STYLE, null); }

		public this(Window parent, int id, string title, Point pos, Size size, int style)
			{ this(parent, id, title, pos, size, style, null); }

		public this(Window parent, int id, string title, Point pos, Size size, int style, string name)
		{
			super(wxDialog_ctor());
			if (!Create(parent, id, title, pos, size, style, name))
			{
				throw new InvalidOperationException("Failed to create Dialog");
			}
		}
		
		//---------------------------------------------------------------------
		// ctors with self created id
		
		public this(Window parent, string title, Point pos)
			{ this(parent, Window.UniqueID, title, pos, wxDefaultSize, wxDEFAULT_DIALOG_STYLE, null); }

		public this(Window parent, string title, Point pos, Size size)
			{ this(parent, Window.UniqueID, title, pos, size, wxDEFAULT_DIALOG_STYLE, null); }

		public this(Window parent, string title, Point pos, Size size, int style)
			{ this(parent, Window.UniqueID, title, pos, size, style, null); }

		public this(Window parent, string title, Point pos, Size size, int style, string name)
			{ this(parent, Window.UniqueID, title, pos, size, style, name);}
		
		//---------------------------------------------------------------------

		public bool Create(Window window, int id, string title, Point pos,
						   Size size, int style, string name)
		{
			return wxDialog_Create(wxobj, wxObject.SafePtr(window), id, title,
								   pos, size, cast(uint)style, name);
		}

		//---------------------------------------------------------------------

		public int ReturnCode() { return wxDialog_GetReturnCode(wxobj); }
		public void ReturnCode(int value) { wxDialog_SetReturnCode(wxobj, value); }

		//---------------------------------------------------------------------

		public override string Title() { return wxDialog_GetTitle(wxobj).dup; }
		public override void Title(string value) { wxDialog_SetTitle(wxobj, value); }

		//---------------------------------------------------------------------

		public void EndModal(int retCode)
		{
			wxDialog_EndModal(wxobj, cast(int)retCode);
		}

		//---------------------------------------------------------------------

		public void SetIcon(Icon icon)
		{
			wxDialog_SetIcon(wxobj, wxObject.SafePtr(icon));
		}

		/*public void SetIcons(IconBundle icons)
		{
			wxDialog_SetIcons(wxobj, wxObject.SafePtr(icons);
		}*/

		//---------------------------------------------------------------------

		public /+virtual+/ int ShowModal()
		{
			return wxDialog_ShowModal(wxobj);
		}

		//---------------------------------------------------------------------

		public void Modal(bool value) { wxDialog_SetModal(wxobj, value); }
		public bool Modal() { return wxDialog_IsModal(wxobj); }
	}
