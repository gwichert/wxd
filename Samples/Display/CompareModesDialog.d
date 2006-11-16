//-----------------------------------------------------------------------------
// $Id$
// Michael S. Muegel mike _at_ muegel dot org
//
// Licensed	under the Widgets license, see LICENSE.txt for details.
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using wx;

namespace MyApp
{
	public class CompareModesDialog : Dialog
	{
		public CompareModesDialog( Window parent, int id, Display display )
			: base( parent, id , "VideoMode Euqlity/Match Results", 
			wxDefaultPosition, wxDefaultSize, 
			wxDEFAULT_DIALOG_STYLE | wxMAXIMIZE_BOX | wxRESIZE_BORDER)
		{
			// Instructions
			HtmlWindow html_instr = new HtmlWindow(this);
			// Force HTML font sizes to be same on all platforms
			html_instr.SetFonts("", "", new int[] { 7, 8, 10, 12, 16, 22, 30 });
			html_instr.SetPage("Testing current display's video modes for equality and \"match\" (non-zero fields are equal except for refresh, which is allowed to have a greater value).");
			html_instr.SetSizeHints(-1,75);

			// Test results
			ListCtrl list_results = new ListCtrl( this, -1, 
				wxDefaultPosition, wxDefaultSize, ListCtrl.wxLC_REPORT|wxSUNKEN_BORDER );
			list_results.InsertColumn(0, "Mode1");
			list_results.InsertColumn(1, "Mode2");
			list_results.InsertColumn(2, "Mode1 == Mode2");
			list_results.InsertColumn(3, "Mode1.Matches(Mode2)");
			VideoMode[] modes = display.GetModes();
			Array.Sort(modes);
			int row = 0;
			for (int m1 = 0; m1 < modes.Length; m1++)
			{
				for (int m2 = 0; m2 < modes.Length; m2++)
				{
					// The ListCtrl API is ugly IMHO in wxLC_REPORT mode. Should
					// have seperate InsertRow() method and then use SetItem
					// for each cell vs. InsertItem() does both for the 0 column.
					list_results.InsertItem(row, modes[m1].ToString());
					list_results.SetItem(row, 1, modes[m2].ToString());
					list_results.SetItem(row, 2, (modes[m1] == modes[m2]).ToString());
					list_results.SetItem(row, 3, modes[m1].Matches(modes[m2]).ToString());
					++row;
				}
			}

			// Ensure ListCtrl is as wide as it's data
			int width = 0;
			for (int col = 0; col <= 3; col++)
			{
				int sizing_mode = (col <= 1) ? ListCtrl.wxLIST_AUTOSIZE :
					ListCtrl.wxLIST_AUTOSIZE_USEHEADER;
				list_results.SetColumnWidth(col, sizing_mode);
				width += list_results.GetColumnWidth(col);
			}
			list_results.SetSizeHints(width + 25, 400);

			// OK button (built-in handler for wxID_OK will be invoked when 
			// button is clicked
			Button btn_ok = new Button( this, wxID_OK, "OK" );

			BoxSizer sizer = new BoxSizer( Orientation.wxVERTICAL );
			sizer.Add( html_instr, 0, Stretch.wxEXPAND|Direction.wxALL, 5 );
			sizer.Add( list_results, 1, Stretch.wxEXPAND|Direction.wxALL, 5 );
			sizer.Add( btn_ok, 0, Alignment.wxALIGN_CENTER_HORIZONTAL|Direction.wxALL, 5 );

			sizer.Fit(this);
			AutoLayout = true;
			SetSizer( sizer );
		}

	}
 
} // namespace