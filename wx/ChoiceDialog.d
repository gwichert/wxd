//-----------------------------------------------------------------------------
// wxD - ChoiceDialog.d
//
// The wxChoiceDialog wrapper classes.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Modified by BERO <berobero.sourceforge.net>
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

module wx.ChoiceDialog;
import wx.common;
import wx.Dialog;
import wx.ClientData;
import wx.ArrayInt;

        static extern (C) IntPtr wxSingleChoiceDialog_ctor(IntPtr parent, string message, string caption, int n, string* choices, IntPtr clientData, uint style, inout Point pos);
        static extern (C) void wxSingleChoiceDialog_SetSelection(IntPtr self, int sel);
        static extern (C) int wxSingleChoiceDialog_GetSelection(IntPtr self);
        static extern (C) string wxSingleChoiceDialog_GetStringSelection(IntPtr self);
        static extern (C) IntPtr wxSingleChoiceDialog_GetSelectionClientData(IntPtr self);

        //-----------------------------------------------------------------------------

    public class SingleChoiceDialog : Dialog
    {
        public const int wxCHOICEDLG_STYLE	= (wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER | wxOK | wxCANCEL | wxCENTRE);
	public const int wxCHOICE_HEIGHT = 150;
	public const int wxCHOICE_WIDTH  = 200;


        // TODO: ClientData... !?!

        public this(IntPtr wxobj)
            { super(wxobj);}

        public this(Window parent, string message, string caption, string[] choices)
            { this(parent, message, caption, choices, null, wxCHOICEDLG_STYLE, wxDefaultPosition);}

        public this(Window parent, string message, string caption, string[] choices, ClientData clientData)
            { this(parent, message, caption, choices, clientData, wxCHOICEDLG_STYLE, wxDefaultPosition);}

        public this(Window parent, string message, string caption, string[] choices, ClientData clientData, int style)
            { this(parent, message, caption, choices, clientData, style, wxDefaultPosition);}

        public  this(Window parent, string message, string caption, string[] choices, ClientData clientData, int style, Point pos)
            { super(wxSingleChoiceDialog_ctor(wxObject.SafePtr(parent), message, caption, choices.length, choices, wxObject.SafePtr(clientData), cast(uint)style, pos));}

        //-----------------------------------------------------------------------------

        public void Selection(int sel)
        {
            wxSingleChoiceDialog_SetSelection(wxobj, sel);
        }

        //-----------------------------------------------------------------------------

        public int Selection()
        {
            return wxSingleChoiceDialog_GetSelection(wxobj);
        }

        //-----------------------------------------------------------------------------

        public string StringSelection()
        {
            return wxSingleChoiceDialog_GetStringSelection(wxobj).dup;
        }

        //-----------------------------------------------------------------------------

        public ClientData SelectionClientData()
        {
            return cast(ClientData)FindObject(wxSingleChoiceDialog_GetSelectionClientData(wxobj));
        }
    }

	//-----------------------------------------------------------------------------

        static extern (C) IntPtr wxMultiChoiceDialog_ctor(IntPtr parent, string message, string caption, int n, string* choices, uint style, inout Point pos);
        static extern (C) void wxMultiChoiceDialog_SetSelections(IntPtr self, int* sel, int numsel);
        static extern (C) IntPtr wxMultiChoiceDialog_GetSelections(IntPtr self);

        //-----------------------------------------------------------------------------

    public class MultiChoiceDialog : Dialog
    {
        public this(IntPtr wxobj)
            { super(wxobj);}

        public this(Window parent, string message, string caption, string[] choices)
            { this(parent, message, caption, choices, SingleChoiceDialog.wxCHOICEDLG_STYLE, wxDefaultPosition);}

        public this(Window parent, string message, string caption, string[] choices, int style)
            { this(parent, message, caption, choices, style, wxDefaultPosition);}

        public  this(Window parent, string message, string caption, string[] choices, int style, Point pos)
            { super(wxMultiChoiceDialog_ctor(wxObject.SafePtr(parent), message, caption, choices.length, choices, cast(uint)style, pos));}

        //-----------------------------------------------------------------------------

        public void SetSelections(int[] sel)
        {
            wxMultiChoiceDialog_SetSelections(wxobj, sel, sel.length);
        }

        //-----------------------------------------------------------------------------
	
        public int[] GetSelections()
        {
            return (new ArrayInt(wxMultiChoiceDialog_GetSelections(wxobj), true)).toArray();
        }
        
    }

	//-----------------------------------------------------------------------------

	static extern (C) string wxGetSingleChoice_func(string message, string caption, int n, string* choices, IntPtr parent, int x, int y, bool centre, int width, int height);
	static extern (C) int wxGetSingleChoiceIndex_func(string message, string caption, int n, string* choices, IntPtr parent, int x, int y, bool centre, int width, int height);
	static extern (C) void* wxGetSingleChoiceData_func(string message, string caption, int n, string* choices, void **client_data, IntPtr parent, int x, int y, bool centre, int width, int height);
	static extern (C) uint wxGetMultipleChoices_func(IntPtr selections,string message, string caption, int n, string* choices, IntPtr parent, int x, int y, bool centre, int width, int height);

	public string GetSingleChoice(string message, string caption, string[] choices, Window parent = null, int x = -1, int y= -1, bool centre = true, int width = SingleChoiceDialog.wxCHOICE_WIDTH, int height = SingleChoiceDialog.wxCHOICE_HEIGHT)
	{
		return wxGetSingleChoice_func(message, caption, choices.length, choices, wxObject.SafePtr(parent), x, y, centre, width, height).dup;
	}

	public int GetSingleChoiceIndex(string message, string caption, string[] choices, Window parent = null, int x = -1, int y= -1, bool centre = true, int width = SingleChoiceDialog.wxCHOICE_WIDTH, int height = SingleChoiceDialog.wxCHOICE_HEIGHT)
	{
		return wxGetSingleChoiceIndex_func(message, caption, choices.length, choices, wxObject.SafePtr(parent), x, y, centre, width, height);
	}

	public void* GetSingleChoiceData(string message, string caption, string[] choices, void **client_data, Window parent = null, int x = -1, int y= -1, bool centre = true, int width = SingleChoiceDialog.wxCHOICE_WIDTH, int height = SingleChoiceDialog.wxCHOICE_HEIGHT)
	{
		return wxGetSingleChoiceData_func(message, caption, choices.length, choices, client_data, wxObject.SafePtr(parent), x, y, centre, width, height);
	}

	public int[] GetMultipleChoices(string message, string caption, string[] choices, Window parent = null, int x = -1, int y= -1, bool centre = true, int width = SingleChoiceDialog.wxCHOICE_WIDTH, int height = SingleChoiceDialog.wxCHOICE_HEIGHT)
	{
		ArrayInt ari = new ArrayInt();
		uint sz = wxGetMultipleChoices_func(wxObject.SafePtr(ari), message, caption, choices.length, choices, wxObject.SafePtr(parent), x, y, centre, width, height);
		return ari.toArray();
	}
