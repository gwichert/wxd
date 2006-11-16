//-----------------------------------------------------------------------------
// wxD - Clipboard.d
//
// The wxClipboard wrapper class.
//
// Written by Bryan Bulten (bryan@bulten.ca)
// (C) 2003 Bryan Bulten
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.Clipboard;
import wx.common;
import wx.DataFormat;
import wx.DataObject;

		static extern (C) IntPtr wxClipboard_ctor();
		static extern (C) bool   wxClipboard_Open(IntPtr self);
		static extern (C) void   wxClipboard_Close(IntPtr self);
		static extern (C) bool   wxClipboard_IsOpened(IntPtr self);
		static extern (C) bool   wxClipboard_AddData(IntPtr self, IntPtr data);
		static extern (C) bool   wxClipboard_SetData(IntPtr self, IntPtr data);
		static extern (C) bool   wxClipboard_IsSupported(IntPtr self, IntPtr format);
		static extern (C) bool   wxClipboard_GetData(IntPtr self, IntPtr data);
		static extern (C) void   wxClipboard_Clear(IntPtr self);
		static extern (C) bool   wxClipboard_Flush(IntPtr self);
		static extern (C) void   wxClipboard_UsePrimarySelection(IntPtr self, bool primary);
		static extern (C) IntPtr wxClipboard_Get();

		//-----------------------------------------------------------------------------
		
	public class Clipboard : wxObject
	{
		static Clipboard TheClipboard;

		static this()
		{
			TheClipboard = new Clipboard(wxClipboard_Get());
		}

		public this(IntPtr wxobj)
			{ super(wxobj);}

		public  this()
			{ super(wxClipboard_ctor()); }
		
		//-----------------------------------------------------------------------------

		public bool Open()
		{
			return wxClipboard_Open(wxobj);
		}

		public void Close()
		{
			wxClipboard_Close(wxobj);
		}

		//-----------------------------------------------------------------------------

		public bool IsOpened()
		{
			return wxClipboard_IsOpened(wxobj);
		}

		//-----------------------------------------------------------------------------

		public bool AddData(DataObject data)
		{
			return wxClipboard_AddData(wxobj, wxObject.SafePtr(data));
		}

		public bool SetData(DataObject data)
		{
			return wxClipboard_SetData(wxobj, wxObject.SafePtr(data));
		}

		public bool GetData(DataObject data)
		{
			return wxClipboard_GetData(wxobj, wxObject.SafePtr(data));
		}

		//-----------------------------------------------------------------------------

		public bool IsSupported(DataFormat format)
		{
			return wxClipboard_IsSupported(wxobj, wxObject.SafePtr(format));
		}

		//-----------------------------------------------------------------------------

		public void Clear()
		{
			wxClipboard_Clear(wxobj);
		}

		public bool Flush()
		{
			return wxClipboard_Flush(wxobj);
		}
		
		//-----------------------------------------------------------------------------
	
		public /+virtual+/ void UsePrimarySelection(bool primary)
		{
			wxClipboard_UsePrimarySelection(wxobj, primary);
		}
	}
		
	//-----------------------------------------------------------------------------
	
		static extern (C) IntPtr wxClipboardLocker_ctor(IntPtr clipboard);
		static extern (C) void   wxClipboardLocker_dtor(IntPtr self);
		static extern (C) bool   wxClipboardLocker_IsOpen(IntPtr self);
		
		//-----------------------------------------------------------------------------
		
	public auto class ClipboardLocker // not wxObject
	{
		public this(Clipboard clipboard = null)
		{
			m_clipboard = clipboard? clipboard : Clipboard.TheClipboard;
			if (m_clipboard) {
				m_clipboard.Open();
			}
		}
		
		public ~this()
		{
			if (m_clipboard) {
				m_clipboard.Close();
			}
		}
		
		private Clipboard m_clipboard;
/*
		private IntPtr wxobj;
	
		public this()
			{ this(null);}
			
		public this(Clipboard clipboard)
			{ wxobj = wxClipboardLocker_ctor(wxObject.SafePtr(clipboard)); }
			

		public ~this()
		{
			wxClipBoardLocker_dtor(wxobj);
		}
			
		//-----------------------------------------------------------------------------
			
		public bool IsOpen() { return wxClipboardLocker_IsOpen(wxobj); }
*/
	}
