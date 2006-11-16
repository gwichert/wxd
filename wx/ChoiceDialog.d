//-----------------------------------------------------------------------------
// wx.NET - ChoiceDialog.cs
//
// The wxChoiceDialog wrapper classes.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    public class SingleChoiceDialog : Dialog
    {
        public const long wxCHOICEDLG_STYLE	= (wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER | wxOK | wxCANCEL | wxCENTRE);

        [DllImport("wx-c")] static extern IntPtr wxSingleChoiceDialog_ctor(IntPtr parent, string message, string caption, int n, string[] choices, IntPtr clientData, uint style, ref Point pos);
        [DllImport("wx-c")] static extern void wxSingleChoiceDialog_SetSelection(IntPtr self, int sel);
        [DllImport("wx-c")] static extern int wxSingleChoiceDialog_GetSelection(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxSingleChoiceDialog_GetStringSelection(IntPtr self);
        [DllImport("wx-c")] static extern IntPtr wxSingleChoiceDialog_GetSelectionClientData(IntPtr self);

        //-----------------------------------------------------------------------------

        // TODO: ClientData... !?!

        public SingleChoiceDialog(IntPtr wxObject)
            : base(wxObject) {}

        public SingleChoiceDialog(Window parent, string message, string caption, string[] choices)
            : this(parent, message, caption, choices, null, wxCHOICEDLG_STYLE, wxDefaultPosition) {}

        public SingleChoiceDialog(Window parent, string message, string caption, string[] choices, ClientData clientData)
            : this(parent, message, caption, choices, clientData, wxCHOICEDLG_STYLE, wxDefaultPosition) {}

        public SingleChoiceDialog(Window parent, string message, string caption, string[] choices, ClientData clientData, long style)
            : this(parent, message, caption, choices, clientData, style, wxDefaultPosition) {}

        public  SingleChoiceDialog(Window parent, string message, string caption, string[] choices, ClientData clientData, long style, Point pos)
            : base(wxSingleChoiceDialog_ctor(Object.SafePtr(parent), message, caption, choices.Length, choices, Object.SafePtr(clientData), (uint)style, ref pos)) {}

        //-----------------------------------------------------------------------------

        public void SetSelection(int sel)
        {
            wxSingleChoiceDialog_SetSelection(wxObject, sel);
        }

        //-----------------------------------------------------------------------------

        public int GetSelection()
        {
            return wxSingleChoiceDialog_GetSelection(wxObject);
        }

        //-----------------------------------------------------------------------------

        public string GetStringSelection()
        {
            return new wxString(wxSingleChoiceDialog_GetStringSelection(wxObject), true);
        }

        //-----------------------------------------------------------------------------

        public ClientData GetSelectionClientData()
        {
            return (ClientData)Object.FindObject(wxSingleChoiceDialog_GetSelectionClientData(wxObject));
        }
    }

	//-----------------------------------------------------------------------------

    public class MultiChoiceDialog : Dialog
    {
        [DllImport("wx-c")] static extern IntPtr wxMultiChoiceDialog_ctor(IntPtr parent, string message, string caption, int n, string[] choices, uint style, ref Point pos);
        [DllImport("wx-c")] static extern void wxMultiChoiceDialog_SetSelections(IntPtr self, int[] sel, int numsel);
        [DllImport("wx-c")] static extern IntPtr wxMultiChoiceDialog_GetSelections(IntPtr self);

        //-----------------------------------------------------------------------------

        public MultiChoiceDialog(IntPtr wxObject)
            : base(wxObject) {}

        public MultiChoiceDialog(Window parent, string message, string caption, string[] choices)
            : this(parent, message, caption, choices, SingleChoiceDialog.wxCHOICEDLG_STYLE, wxDefaultPosition) {}

        public MultiChoiceDialog(Window parent, string message, string caption, string[] choices, long style)
            : this(parent, message, caption, choices, style, wxDefaultPosition) {}

        public  MultiChoiceDialog(Window parent, string message, string caption, string[] choices, long style, Point pos)
            : base(wxMultiChoiceDialog_ctor(Object.SafePtr(parent), message, caption, choices.Length, choices, (uint)style, ref pos)) {}

        //-----------------------------------------------------------------------------

        public void SetSelections(int[] sel)
        {
            wxMultiChoiceDialog_SetSelections(wxObject, sel, sel.Length);
        }

        //-----------------------------------------------------------------------------

        public int[] GetSelections()
        {
            return new ArrayInt(wxMultiChoiceDialog_GetSelections(wxObject), true);
        }
    }

	//-----------------------------------------------------------------------------

	public class GetSingleChoice
	{
		public const int wxCHOICE_HEIGHT = 150;
		public const int wxCHOICE_WIDTH  = 200;
		public string value = "";

		//-----------------------------------------------------------------------------

	        [DllImport("wx-c")] static extern IntPtr wxGetSingleChoice_func(string message, string caption, int n, string[] choices, IntPtr parent, int x, int y, bool centre, int width, int height);

        	//-----------------------------------------------------------------------------

		public GetSingleChoice(string message, string caption, string[] choices)
		{
			value = new wxString(wxGetSingleChoice_func(message, caption, choices.Length, choices, IntPtr.Zero, -1, -1, true, wxCHOICE_WIDTH, wxCHOICE_HEIGHT), true);
		}

        	//-----------------------------------------------------------------------------

		public GetSingleChoice(string message, string caption, string[] choices, Window parent, int x, int y, bool centre, int width, int height)
		{
			value = new wxString(wxGetSingleChoice_func(message, caption, choices.Length, choices, Object.SafePtr(parent), x, y, centre, width, height), true);
		}

		//-----------------------------------------------------------------------------

		public static implicit operator string(GetSingleChoice g)
		{
			return g.value;
		}
	}
}

