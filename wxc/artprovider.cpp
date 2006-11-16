//-----------------------------------------------------------------------------
// wx.NET - artprovider.cxx
//
// The wxArtProvider proxy interface.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

#include <wx/wx.h>
#include <wx/artprov.h>

wxArtID GetArtId(int id)
{
	switch (id)
		{
			case 1: return wxART_ADD_BOOKMARK; break;
			case 2: return wxART_DEL_BOOKMARK; break;
			case 3: return wxART_HELP_SIDE_PANEL; break;
			case 4: return wxART_HELP_SETTINGS; break;
			case 5: return wxART_HELP_BOOK; break;
			case 6: return wxART_HELP_FOLDER; break;
			case 7: return wxART_HELP_PAGE; break;
			case 8: return wxART_GO_BACK; break;
			case 9: return wxART_GO_FORWARD; break;
			case 10: return wxART_GO_UP; break;
			case 11: return wxART_GO_DOWN; break;
			case 12: return wxART_GO_TO_PARENT; break;
			case 13: return wxART_GO_HOME; break;
			case 14: return wxART_FILE_OPEN; break;
			case 15: return wxART_PRINT; break;
			case 16: return wxART_HELP; break;
			case 17: return wxART_TIP; break;
			case 18: return wxART_REPORT_VIEW; break;
			case 19: return wxART_LIST_VIEW; break;
			case 20: return wxART_NEW_DIR; break;
			case 21: return wxART_FOLDER; break;
			case 22: return wxART_GO_DIR_UP; break;
			case 23: return wxART_EXECUTABLE_FILE; break;
			case 24: return wxART_NORMAL_FILE; break;
			case 25: return wxART_TICK_MARK; break;
			case 26: return wxART_CROSS_MARK; break;
			case 27: return wxART_ERROR; break;
			case 28: return wxART_QUESTION; break;
			case 29: return wxART_WARNING; break;
			case 30: return wxART_INFORMATION; break;
		}
	//changed to wxART_MISSING_IMAGE, 03.09.2004 alex
	return wxART_MISSING_IMAGE;
}

wxArtClient GetArtClient(int id)
{
	switch (id)
		{
			case 1: return wxART_TOOLBAR; break;
			case 2: return wxART_MENU; break;
			case 3: return wxART_FRAME_ICON; break;
			case 4: return wxART_CMN_DIALOG; break;
			case 5: return wxART_HELP_BROWSER; break;
			case 6: return wxART_MESSAGE_BOX; break;
			case 7: return wxART_BUTTON; break;
		}
	return wxART_OTHER;
}

extern "C" WXEXPORT
wxBitmap* wxArtProvider_GetBitmap(int artid, int artclient, const wxSize* size)
{
	return new wxBitmap(wxArtProvider::GetBitmap(GetArtId(artid), GetArtClient(artclient), *size));
}

extern "C" WXEXPORT
wxIcon* wxArtProvider_GetIcon(int artid, int artclient, const wxSize* size)
{
	return new wxIcon(wxArtProvider::GetIcon(GetArtId(artid), GetArtClient(artclient), *size));
}
