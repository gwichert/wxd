//-----------------------------------------------------------------------------
// wx.NET - window.inc
//
// The wxWindow virtual function dispatchers.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

virtual bool TransferDataFromWindow()
{
	FunctionEvent e(wxEVT_TRANSFERDATAFROMWINDOW);
	ProcessEvent(e);
	return (!e.GetSkipped());
}

