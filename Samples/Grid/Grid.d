//-----------------------------------------------------------------------------
// wxD/Samples - Grid.d
//
// wxD "grid" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
private import std.string;

static if (__VERSION__ >= 2050) {
import std.conv : to;
version(D_Version2) mixin("alias to!string toString;");
}

	public class GridFrame : Frame
	{
		enum Cmd  
		{
			ID_TOGGLEROWLABELS = 100,
			ID_TOGGLECOLLABELS,
			ID_TOGGLEEDIT,
			ID_TOGGLEROWSIZING,
			ID_TOGGLECOLSIZING,
			ID_TOGGLEGRIDSIZING,
			ID_TOGGLEGRIDLINES,
			ID_AUTOSIZECOLS,
			ID_CELLOVERFLOW,
			ID_RESIZECELL,
			ID_SETLABELCOLOUR,
			ID_SETLABELTEXTCOLOUR,
			ID_SETLABEL_FONT,
			ID_ROWLABELALIGN,
			ID_ROWLABELHORIZALIGN,
			ID_ROWLABELVERTALIGN,
			ID_COLLABELALIGN,
			ID_COLLABELHORIZALIGN,
			ID_COLLABELVERTALIGN,
			ID_GRIDLINECOLOUR,
			ID_INSERTROW,
			ID_INSERTCOL,
			ID_DELETEROW,
			ID_DELETECOL,
			ID_CLEARGRID,
			ID_CHANGESEL,
			ID_SELCELLS,
			ID_SELROWS,
			ID_SELCOLS,
			ID_SET_CELL_FG_COLOUR,
			ID_SET_CELL_BG_COLOUR,
			ID_ABOUT,
			ID_VTABLE,
			ID_BUGS_TABLE,
			ID_SMALL_GRID,
			ID_SELECT_UNSELECT,
			ID_SELECT_ALL,
			ID_SELECT_ROW,
			ID_SELECT_COL,
			ID_SELECT_CELL,
			ID_DESELECT_ALL,
			ID_DESELECT_ROW,
			ID_DESELECT_COL,
			ID_DESELECT_CELL,
			
			ID_SET_HIGHLIGHT_WIDTH,
			ID_SET_RO_HIGHLIGHT_WIDTH,

			ID_TESTFUNC,
			ID_EXIT
		}
		
		//-----------------------------------------------------------------------------
		
		private Grid grid;
		private TextCtrl logWin;
		private string logBuf;
		
		public bool m_addToSel = false;
		
		public static int s_sizeGrid = 10000;
		
		//-----------------------------------------------------------------------------
		
		public this()
		{
			super( null, -1, "wxWidgets grid class demo", wxDefaultPosition, wxDefaultSize );
			icon = new Icon( "../Samples/Grid/mondrian.png" );
			
			int gridW = 600;
			int gridH = 300;
			int logW = gridW;
			int logH = 100;
			
			Menu fileMenu = new Menu();
			fileMenu.Append( Cmd.ID_VTABLE, "&Virtual table test\tCtrl-V" );
			fileMenu.Append( Cmd.ID_BUGS_TABLE, "&Bugs table test\tCtrl-B" );
			fileMenu.Append( Cmd.ID_SMALL_GRID, "&Small Grid test\tCtrl-S" );
			fileMenu.AppendSeparator();
			fileMenu.Append( Cmd.ID_EXIT, "E&xit\tAlt-X" );

			Menu viewMenu = new Menu();
			viewMenu.AppendCheckItem( Cmd.ID_TOGGLEROWLABELS,  "&Row labels", "" );
			viewMenu.AppendCheckItem( Cmd.ID_TOGGLECOLLABELS,  "&Col labels", "" );
			viewMenu.AppendCheckItem( Cmd.ID_TOGGLEEDIT,  "&Editable", "" );
			viewMenu.AppendCheckItem( Cmd.ID_TOGGLEROWSIZING, "Ro&w drag-resize", "" );
			viewMenu.AppendCheckItem( Cmd.ID_TOGGLECOLSIZING, "C&ol drag-resize", "" );
			viewMenu.AppendCheckItem( Cmd.ID_TOGGLEGRIDSIZING, "&Grid drag-resize", "" );
			viewMenu.AppendCheckItem( Cmd.ID_TOGGLEGRIDLINES, "&Grid Lines", "" );
			viewMenu.Append( Cmd.ID_SET_HIGHLIGHT_WIDTH, "&Set Cell Highlight Width...", "" );
			viewMenu.Append( Cmd.ID_SET_RO_HIGHLIGHT_WIDTH, "&Set Cell RO Highlight Width...", "" );
			viewMenu.Append( Cmd.ID_AUTOSIZECOLS, "&Auto-size cols" );
			viewMenu.AppendCheckItem( Cmd.ID_CELLOVERFLOW, "&Overflow cells", "" );
			viewMenu.AppendCheckItem( Cmd.ID_RESIZECELL, "&Resize cell (7,1)", "" );

			Menu rowLabelMenu = new Menu();

			viewMenu.Append( Cmd.ID_ROWLABELALIGN, "R&ow label alignment", rowLabelMenu, "Change alignment of row labels" );

			rowLabelMenu.Append( Cmd.ID_ROWLABELHORIZALIGN, "&Horizontal" );
			rowLabelMenu.Append( Cmd.ID_ROWLABELVERTALIGN, "&Vertical" );

			Menu colLabelMenu = new Menu();

			viewMenu.Append( Cmd.ID_COLLABELALIGN, "Col l&abel alignment", colLabelMenu, "Change alignment of col labels" );

			colLabelMenu.Append( Cmd.ID_COLLABELHORIZALIGN, "&Horizontal" );
			colLabelMenu.Append( Cmd.ID_COLLABELVERTALIGN, "&Vertical" );

			Menu colMenu = new Menu();
			colMenu.Append( Cmd.ID_SETLABELCOLOUR, "Set &label colour..." );
			colMenu.Append( Cmd.ID_SETLABELTEXTCOLOUR, "Set label &text colour..." );
			colMenu.Append( Cmd.ID_SETLABEL_FONT, "Set label fo&nt..." );
			colMenu.Append( Cmd.ID_GRIDLINECOLOUR, "&Grid line colour..." );
			colMenu.Append( Cmd.ID_SET_CELL_FG_COLOUR, "Set cell &foreground colour..." );
			colMenu.Append( Cmd.ID_SET_CELL_BG_COLOUR, "Set cell &background colour..." );

			Menu editMenu = new Menu();
			editMenu.Append( Cmd.ID_INSERTROW, "Insert &row" );
			editMenu.Append( Cmd.ID_INSERTCOL, "Insert &column" );
			editMenu.Append( Cmd.ID_DELETEROW, "Delete selected ro&ws" );
			editMenu.Append( Cmd.ID_DELETECOL, "Delete selected co&ls" );
			editMenu.Append( Cmd.ID_CLEARGRID, "Cl&ear grid cell contents" );

			Menu selectMenu = new Menu();
			selectMenu.AppendCheckItem( Cmd.ID_SELECT_UNSELECT, "Add new cells to the selection",
				"When off, old selection is deselected before selecting the new cells" );
			selectMenu.Append( Cmd.ID_SELECT_ALL, "Select all" );
			selectMenu.Append( Cmd.ID_SELECT_ROW, "Select row 2" );
			selectMenu.Append( Cmd.ID_SELECT_COL, "Select col 2" );
			selectMenu.Append( Cmd.ID_SELECT_CELL, "Select cell (3, 1)" );
			selectMenu.Append( Cmd.ID_DESELECT_ALL, "Deselect all" );
			selectMenu.Append( Cmd.ID_DESELECT_ROW, "Deselect row 2" );
			selectMenu.Append( Cmd.ID_DESELECT_COL, "Deselect col 2" );
			selectMenu.Append( Cmd.ID_DESELECT_CELL, "Deselect cell (3, 1)" );
			
			Menu selectionMenu = new Menu();
			selectMenu.Append( Cmd.ID_CHANGESEL, "Change &selection mode", selectionMenu, "Change selection mode" );

			selectionMenu.Append( Cmd.ID_SELCELLS, "Select &Cells" );
			selectionMenu.Append( Cmd.ID_SELROWS, "Select &Rows" );
			selectionMenu.Append( Cmd.ID_SELCOLS, "Select C&ols" );


			Menu helpMenu = new Menu();
			helpMenu.Append( Cmd.ID_ABOUT, "&About wxGrid demo" );

			MenuBar menuBar = new MenuBar();
			menuBar.Append( fileMenu, "&File" );
			menuBar.Append( viewMenu, "&View" );
			menuBar.Append( colMenu,  "&Colours" );
			menuBar.Append( editMenu, "&Edit" );
			menuBar.Append( selectMenu, "&Select" );
			menuBar.Append( helpMenu, "&Help" );

			this.menuBar = menuBar ;	
			
			grid = new Grid( this, -1, Point( 0, 0 ), Size( 400, 300 ) );
			
			logWin = new TextCtrl( this, -1, "", Point( 0, gridH + 20 ), Size( logW, logH ), TextCtrl.wxTE_MULTILINE );
			
			Log.SetActiveTarget( logWin ); 
			
			grid.CreateGrid( 0, 0 );
			grid.AppendRows( 100 );
			grid.AppendCols( 100 );
			
			int ir = grid.NumberRows;
			grid.DeleteRows( 0, ir );
			grid.AppendRows( ir );
			
			grid.SetRowSize( 0, 60 );
			grid.SetCellValue( 0, 0, "Ctrl+Home\nwill go to\nthis cell" );
			
			grid.SetCellValue( 0, 1, "A long piece of text to demonstrate wrapping." );
			grid.SetCellRenderer( 0 , 1, new GridCellAutoWrapStringRenderer() );
			grid.SetCellEditor( 0,  1 , new GridCellAutoWrapStringEditor() );

			grid.SetCellValue( 0, 2, "Blah" );
			grid.SetCellValue( 0, 3, "Read only" );
			grid.SetReadOnly( 0, 3 );

			grid.SetCellValue( 0, 4, "Can veto edit this cell" );

			grid.SetCellValue( 0, 5, "Press\nCtrl+arrow\nto skip over\ncells" );

			grid.SetRowSize( 99, 60 );
			grid.SetCellValue( 99, 99, "Ctrl+End\nwill go to\nthis cell" );
			grid.SetCellValue( 1, 0, "This default cell will overflow into neighboring cells, but not if you turn overflow off." );

			grid.SetCellTextColour( 1, 2, Colour.wxRED );
			grid.SetCellBackgroundColour( 1, 2, Colour.wxGREEN );

			grid.SetCellValue( 1, 4, "I'm in the middle" );

			grid.SetCellValue( 2, 2, "red" );

			grid.SetCellTextColour( 2, 2, Colour.wxRED );
			grid.SetCellValue( 3, 3, "green on grey" );
			grid.SetCellTextColour( 3, 3, Colour.wxGREEN );
			grid.SetCellBackgroundColour( 3, 3, Colour.wxLIGHT_GREY );

			grid.SetCellValue( 4, 4, "a weird looking cell" );
			grid.SetCellAlignment( 4, 4, Alignment.wxALIGN_CENTRE, Alignment.wxALIGN_CENTRE );
			grid.SetCellRenderer( 4, 4, new MyGridCellRenderer() );

			grid.SetCellValue( 3, 0, "0" );
			grid.SetCellRenderer( 3, 0, new GridCellBoolRenderer() );
			grid.SetCellEditor( 3, 0, new GridCellBoolEditor() );	
			
			GridCellAttr attr = new GridCellAttr();
			attr.TextColour = Colour.wxBLUE;
			grid.SetColAttr( 5, attr );
			attr = new GridCellAttr();	
			attr.BackgroundColour = Colour.wxRED;
			grid.SetRowAttr( 5, attr );

			grid.SetCellValue( 2, 4, "a wider column" );
			grid.SetColSize( 4, 120 );
			grid.SetColMinimalWidth( 4, 120 );

			grid.SetCellTextColour( 5, 8, Colour.wxGREEN );
			grid.SetCellValue( 5, 8, "Bg from row attr\nText col from cell attr" );
			grid.SetCellValue( 5, 5, "Bg from row attr Text col from col attr and this text is so long that it covers over many many empty cells but is broken by one that isn't" );

			grid.SetColFormatFloat( 6 );
			grid.SetCellValue( 0, 6, "3.1415" );
			grid.SetCellValue( 1, 6, "1415" );
			grid.SetCellValue( 2, 6, "12345.67890" );

			grid.SetColFormatFloat( 7, 6, 2 );
			grid.SetCellValue( 0, 7, "3.1415" );
			grid.SetCellValue( 1, 7, "1415" );
			grid.SetCellValue( 2, 7, "12345.67890" );

			string[] choices =
			[
				"Please select a choice",
				"This takes two cells",
				"Another choice"
			];
			
			grid.SetCellEditor( 4, 0, new GridCellChoiceEditor( choices ) );
			grid.SetCellSize( 4, 0, 1, 2 );
			grid.SetCellValue( 4, 0, choices[0] );
			grid.SetCellOverflow( 4, 0, false );

			grid.SetCellSize( 7, 1, 3, 4 );
			grid.SetCellAlignment( 7, 1, Alignment.wxALIGN_CENTRE, Alignment.wxALIGN_CENTRE );
			grid.SetCellValue( 7, 1, "Big box!" );

			BoxSizer topSizer = new BoxSizer( Orientation.wxVERTICAL );
			topSizer.Add( grid, 1, Stretch.wxEXPAND );

			topSizer.Add( logWin, 0, Stretch.wxEXPAND );

			AutoLayout = true;
			this.sizer = topSizer ;

			topSizer.Fit( this );
			topSizer.SetSizeHints( this );

			Centre();
			SetDefaults();			
			
			EVT_MENU( Cmd.ID_TOGGLEROWLABELS,  & ToggleRowLabels ) ;
			EVT_MENU( Cmd.ID_TOGGLECOLLABELS,  & ToggleColLabels ) ;
			EVT_MENU( Cmd.ID_TOGGLEEDIT, & ToggleEditing ) ;
			EVT_MENU( Cmd.ID_TOGGLEROWSIZING, & ToggleRowSizing ) ;
			EVT_MENU( Cmd.ID_TOGGLECOLSIZING, & ToggleColSizing ) ;
			EVT_MENU( Cmd.ID_TOGGLEGRIDSIZING, & ToggleGridSizing ) ;
			EVT_MENU( Cmd.ID_TOGGLEGRIDLINES, & ToggleGridLines ) ;
			EVT_MENU( Cmd.ID_AUTOSIZECOLS, & AutoSizeCols ) ;
			EVT_MENU( Cmd.ID_CELLOVERFLOW, & CellOverflow ) ;
			EVT_MENU( Cmd.ID_RESIZECELL, & ResizeCell ) ;
			EVT_MENU( Cmd.ID_SETLABELCOLOUR, & SetLabelColour ) ;
			EVT_MENU( Cmd.ID_SETLABELTEXTCOLOUR, & SetLabelTextColour ) ;
			EVT_MENU( Cmd.ID_SETLABEL_FONT, & SetLabelFont ) ;
			EVT_MENU( Cmd.ID_ROWLABELHORIZALIGN, & SetRowLabelHorizAlignment ) ;
			EVT_MENU( Cmd.ID_ROWLABELVERTALIGN, & SetRowLabelVertAlignment ) ;
			EVT_MENU( Cmd.ID_COLLABELHORIZALIGN, & SetColLabelHorizAlignment ) ;
			EVT_MENU( Cmd.ID_COLLABELVERTALIGN, & SetColLabelVertAlignment ) ;
			EVT_MENU( Cmd.ID_GRIDLINECOLOUR, & SetGridLineColour ) ;
			EVT_MENU( Cmd.ID_INSERTROW, & InsertRow ) ;
			EVT_MENU( Cmd.ID_INSERTCOL, & InsertCol ) ;
			EVT_MENU( Cmd.ID_DELETEROW, & DeleteSelectedRows ) ;
			EVT_MENU( Cmd.ID_DELETECOL, & DeleteSelectedCols ) ;
			EVT_MENU( Cmd.ID_CLEARGRID, & ClearGrid ) ;
			EVT_MENU( Cmd.ID_SELCELLS,  & SelectCells ) ;
			EVT_MENU( Cmd.ID_SELROWS,  & SelectRows ) ;
			EVT_MENU( Cmd.ID_SELCOLS,  & SelectCols ) ;
			
			EVT_MENU( Cmd.ID_SET_CELL_FG_COLOUR, & SetCellFgColour ) ;
			EVT_MENU( Cmd.ID_SET_CELL_BG_COLOUR, & SetCellBgColour ) ;
			
			EVT_MENU( Cmd.ID_ABOUT, & About ) ;
			EVT_MENU( Cmd.ID_EXIT, & OnQuit ) ;
			EVT_MENU( Cmd.ID_VTABLE, & OnVTable) ;
			EVT_MENU( Cmd.ID_BUGS_TABLE, & OnBugsTable) ;
			EVT_MENU( Cmd.ID_SMALL_GRID, & OnSmallGrid) ;
			
			EVT_MENU( Cmd.ID_DESELECT_CELL, & DeselectCell) ;
			EVT_MENU( Cmd.ID_DESELECT_COL, & DeselectCol) ;
			EVT_MENU( Cmd.ID_DESELECT_ROW, & DeselectRow) ;
			EVT_MENU( Cmd.ID_DESELECT_ALL, & DeselectAll) ;
			EVT_MENU( Cmd.ID_SELECT_CELL, & SelectCell) ;
			EVT_MENU( Cmd.ID_SELECT_COL, & SelectCol) ;
			EVT_MENU( Cmd.ID_SELECT_ROW, & SelectRow) ;
			EVT_MENU( Cmd.ID_SELECT_ALL, & SelectAll) ;
			EVT_MENU( Cmd.ID_SELECT_UNSELECT, & OnAddToSelectToggle) ;
			
			EVT_MENU( Cmd.ID_SET_HIGHLIGHT_WIDTH, & OnSetHighlightWidth) ;
			EVT_MENU( Cmd.ID_SET_RO_HIGHLIGHT_WIDTH, & OnSetROHighlightWidth) ;
			
			EVT_GRID_LABEL_LEFT_CLICK( & OnLabelLeftClick ) ;
			EVT_GRID_CELL_LEFT_CLICK( & OnCellLeftClick ) ;
			EVT_GRID_ROW_SIZE( & OnRowSize ) ;
			EVT_GRID_COL_SIZE( & OnColSize ) ;
			EVT_GRID_SELECT_CELL( & OnSelectCell ) ;
			EVT_GRID_RANGE_SELECT( & OnRangeSelected ) ;
			EVT_GRID_CELL_CHANGE( & OnCellValueChanged ) ;
			
			EVT_GRID_EDITOR_SHOWN( & OnEditorShown ) ;
			EVT_GRID_EDITOR_HIDDEN( & OnEditorHidden ) ;			
			
		}
		
		public void SetDefaults()
		{
			menuBar.Check( Cmd.ID_TOGGLEROWLABELS, true );
			menuBar.Check( Cmd.ID_TOGGLECOLLABELS, true );
			menuBar.Check( Cmd.ID_TOGGLEEDIT, true );
			menuBar.Check( Cmd.ID_TOGGLEROWSIZING, true );
			menuBar.Check( Cmd.ID_TOGGLECOLSIZING, true );
			menuBar.Check( Cmd.ID_TOGGLEGRIDSIZING, true );
			menuBar.Check( Cmd.ID_TOGGLEGRIDLINES, true );
			menuBar.Check( Cmd.ID_CELLOVERFLOW, true );
		}
		
		public void ToggleRowLabels( Object sender, Event e )
		{
			if ( menuBar.IsChecked( Cmd.ID_TOGGLEROWLABELS ) )
			{
				grid.RowLabelSize = grid.DefaultRowLabelSize;
			}
			else
			{
				grid.RowLabelSize = 0;
			}
		}
		
		public void ToggleColLabels( Object sender, Event e )
		{
			if ( menuBar.IsChecked( Cmd.ID_TOGGLECOLLABELS ) )
			{
				grid.ColLabelSize = grid.DefaultColLabelSize;
			}
			else
			{
				grid.ColLabelSize = 0;
			}			
		}
		
		public void ToggleEditing( Object sender, Event e )
		{
			grid.IsEditable = menuBar.IsChecked( Cmd. ID_TOGGLEEDIT );
		}

		public void ToggleRowSizing( Object sender, Event e )
		{
			grid.DragRowSizeEnabled = menuBar.IsChecked( Cmd.ID_TOGGLEROWSIZING );			
		}

		public void ToggleColSizing( Object sender, Event e )
		{
			grid.DragColSizeEnabled = menuBar.IsChecked( Cmd.ID_TOGGLECOLSIZING );
			
		}

		public void ToggleGridSizing( Object sender, Event e )
		{
			grid.DragGridSizeEnabled = menuBar.IsChecked( Cmd.ID_TOGGLEGRIDSIZING );			
		}

		public void ToggleGridLines( Object sender, Event e )
		{
			grid.GridLinesEnabled = menuBar.IsChecked( Cmd.ID_TOGGLEGRIDLINES );			
		}

		public void AutoSizeCols( Object sender, Event e )
		{
			grid.AutoSizeColumns();
			grid.Refresh();			
		}

		public void CellOverflow( Object sender, Event e )
		{
			CommandEvent ce = cast(CommandEvent) e;
			grid.DefaultCellOverflow = ce.IsChecked;
			grid.Refresh();
		}

		public void ResizeCell( Object sender, Event e )
		{
			CommandEvent ce = cast(CommandEvent) e;
			
			if ( ce.IsChecked )
				grid.SetCellSize( 7, 1, 5, 5 );
			else
				grid.SetCellSize( 7, 1, 1, 5 );
				
			grid.Refresh();
		}

		public void SetLabelColour( Object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog(this);
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.colourData;
				Colour colour = retData.colour;

				grid.LabelBackgroundColour = colour;
			}			
		}
		
		public void SetLabelTextColour( Object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog(this);
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.colourData;
				Colour colour = retData.colour;

				grid.LabelTextColour = colour;
			}				
		}		
		
		public void SetLabelFont( Object sender, Event e )
		{
			FontData data = new FontData();
			data.InitialFont = grid.LabelFont;
			
			FontDialog fd = new FontDialog(this, data);
			
			if ( fd.ShowModal() == wxID_OK )
			{			
				Font font = fd.fontData.ChosenFont;
				if ( font.Ok )
				{
					grid.LabelFont = font;
				}
			}
			
		}		

		public void SetRowLabelHorizAlignment( Object sender, Event e )
		{
			int horiz, vert;
			grid.GetRowLabelAlignment( horiz, vert );

			switch ( horiz )
			{
				case Alignment.wxALIGN_LEFT:
					horiz = Alignment.wxALIGN_CENTRE;
				break;

				case Alignment.wxALIGN_CENTRE:
					horiz = Alignment.wxALIGN_RIGHT;
				break;

				case Alignment.wxALIGN_RIGHT:
					horiz = Alignment.wxALIGN_LEFT;
				break;

				default:
			}

			grid.SetRowLabelAlignment( horiz, -1 );			
		}		

		public void SetRowLabelVertAlignment( Object sender, Event e )
		{
			int horiz, vert;
			grid.GetRowLabelAlignment( horiz, vert );

			switch ( vert )
			{
				case Alignment.wxALIGN_TOP:
					vert = Alignment.wxALIGN_CENTRE;
				break;

				case Alignment.wxALIGN_CENTRE:
					vert = Alignment.wxALIGN_BOTTOM;
				break;

				case Alignment.wxALIGN_BOTTOM:
					vert = Alignment.wxALIGN_TOP;
				break;

				default:
			}

			grid.SetRowLabelAlignment( -1, vert );			
		}		

		public void SetColLabelHorizAlignment( Object sender, Event e )
		{
			int horiz, vert;
			grid.GetColLabelAlignment( horiz, vert );

			switch ( horiz )
			{
				case Alignment.wxALIGN_LEFT:
					horiz = Alignment.wxALIGN_CENTRE;
				break;

				case Alignment.wxALIGN_CENTRE:
					horiz = Alignment.wxALIGN_RIGHT;
				break;

				case Alignment.wxALIGN_RIGHT:
					horiz = Alignment.wxALIGN_LEFT;
				break;

				default:
			}

			grid.SetColLabelAlignment( horiz, -1 );			
		}		

		public void SetColLabelVertAlignment( Object sender, Event e )
		{
			int horiz, vert;
			grid.GetColLabelAlignment( horiz, vert );

			switch ( vert )
			{
				case Alignment.wxALIGN_TOP:
					vert = Alignment.wxALIGN_CENTRE;
				break;

				case Alignment.wxALIGN_CENTRE:
					vert = Alignment.wxALIGN_BOTTOM;
				break;

				case Alignment.wxALIGN_BOTTOM:
				vert = Alignment.wxALIGN_TOP;
				break;

				default:
			}

			grid.SetColLabelAlignment( -1, vert );			
		}		

		public void SetGridLineColour( Object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog(this);
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.colourData;
				Colour colour = retData.colour;

				grid.GridLineColour = colour;
			}							
		}		
		
		public void InsertRow( Object sender, Event e )
		{
			grid.InsertRows( grid.GridCursorRow, 1 );			
		}		

		public void InsertCol( Object sender, Event e )
		{
			grid.InsertCols( grid.GridCursorCol, 1 );
		}		

		public void DeleteSelectedRows( Object sender, Event e )
		{
			if ( grid.IsSelection )
			{
				grid.BeginBatch();
				for ( int n = 0; n < grid.NumberRows; )
					if ( grid.IsInSelection( n , 0 ) )
						grid.DeleteRows( n, 1 );
					else
						n++;
				grid.EndBatch();
			}			
		}		

		public void DeleteSelectedCols( Object sender, Event e )
		{
			if ( grid.IsSelection )
			{
				grid.BeginBatch();
				for ( int n = 0; n < grid.NumberCols; )
					if ( grid.IsInSelection( 0 , n ) )
						grid.DeleteCols( n, 1 );
					else
						n++;
				grid.EndBatch();
			}			
		}		
		
		public void ClearGrid( Object sender, Event e )
		{
			grid.ClearGrid();
		}		
		
		public void SelectCells( Object sender, Event e )
		{
			grid.SelectionMode = GridSelectionMode.wxGridSelectCells;
		}		
		
		public void SelectRows( Object sender, Event e )
		{
			grid.SelectionMode = GridSelectionMode.wxGridSelectRows;
		}		

		public void SelectCols( Object sender, Event e )
		{
			grid.SelectionMode = GridSelectionMode.wxGridSelectColumns;
		}		

		public void SetCellFgColour( Object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog(this);
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.colourData;
				Colour colour = retData.colour;

				if ( colour.Ok() )
				{
					grid.DefaultCellTextColour = colour;
					grid.Refresh();
				}
			}										
		}		

		public void SetCellBgColour( Object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog(this);
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.colourData;
				Colour colour = retData.colour;

				if ( colour.Ok() )
				{
					grid.DefaultCellBackgroundColour = colour;
					Rectangle r = Rectangle( 0, 0, grid.size.Width, grid.size.Height );
					grid.Refresh( true, r);
				}
			}													
		}		
	
		public void About( Object sender, Event e )
		{
			MessageBox( "\n\nwxGrid demo \n\n" ~
				"Ported to wxD \nby BERO\n" ,
				"About",
				Dialog.wxOK );			
		}		

		public void OnQuit( Object sender, Event e )
		{
			Close( true );
		}		

		public void OnVTable( Object sender, Event e )
		{
			s_sizeGrid = GetNumberFromUser( "Size of the table to create",
                                     "Size: ",
                                     "wxGridDemo question",
                                     s_sizeGrid,
                                     0, 32000, this);
				
			if ( s_sizeGrid != -1 )
			{
				BigGridFrame win = new BigGridFrame( s_sizeGrid );
				win.Show( true );
			}
		}		
		
		public void OnBugsTable( Object sender, Event e )
		{
			BugsGridFrame frame = new BugsGridFrame();
			frame.Show( true );
		}		
		
		public void OnSmallGrid( Object sender, Event e )
		{
			Frame frame = new Frame( null, -1, "A Small Grid", wxDefaultPosition, Size( 640, 480 ) );
			Panel panel = new Panel( frame, -1 );
			Grid agrid = new Grid( panel, -1, Point( 10, 10 ), Size( 400, 400 ), wxWANTS_CHARS | wxSIMPLE_BORDER );
			agrid.CreateGrid( 3, 3 );
			frame.Show( true );
		}		
		
		public void DeselectCell( Object sender, Event e )
		{
			grid.DeselectCell( 3, 1 );
		}		

		public void DeselectCol( Object sender, Event e )
		{
			grid.DeselectCol( 2 );
		}		
		
		public void DeselectRow( Object sender, Event e )
		{
			grid.DeselectRow( 2 );
		}		
	
		public void DeselectAll( Object sender, Event e )
		{
			grid.ClearSelection();
		}		

		public void SelectCell( Object sender, Event e )
		{
			grid.SelectBlock( 3, 1, 3, 1, m_addToSel );
		}		
		
		public void SelectCol( Object sender, Event e )
		{
			grid.SelectCol( 2, m_addToSel );
		}		
		
		public void SelectRow( Object sender, Event e )
		{
			grid.SelectRow( 2, m_addToSel );
		}		

		public void SelectAll( Object sender, Event e )
		{
			grid.SelectAll();
		}		
		
		public void OnAddToSelectToggle( Object sender, Event e )
		{
			CommandEvent ce = cast(CommandEvent) e;
			m_addToSel = ce.IsChecked;
		}		

		public void OnSetHighlightWidth( Object sender, Event e )
		{
			string[] choices = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" ];

			SingleChoiceDialog dlg = new SingleChoiceDialog(this, "Choose the thickness of the highlight pen:",
				"Pen Width", choices);

			int current = grid.CellHighlightPenWidth;
			dlg.Selection = current;
			if ( dlg.ShowModal() == wxID_OK ) 
			{
				grid.CellHighlightPenWidth = dlg.Selection;
			}			
		}		

		public void OnSetROHighlightWidth( Object sender, Event e )
		{
			string[] choices = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" ];

			SingleChoiceDialog dlg = new SingleChoiceDialog(this, "Choose the thickness of the highlight pen:",
				"Pen Width", choices);

			int current = grid.CellHighlightROPenWidth;
			dlg.Selection = current ;
			if ( dlg.ShowModal() == wxID_OK ) 
			{
				grid.CellHighlightROPenWidth = dlg.Selection;
			}			
		}		
		
		public void OnLabelLeftClick( Object sender, Event e )
		{
			GridEvent ge = cast(GridEvent) e;
			
			if ( ge.Row != -1 )
			{
				logBuf = "Left click on row label " ~ .toString(ge.Row);
			}
			else if ( ge.Col != -1 )
			{
				logBuf = "Left click on col label " ~ .toString(ge.Col);
			}
			else
			{
				logBuf = "Left click on corner label";
			}

			if ( ge.ShiftDown ) logBuf ~= " (shift down)";
			if ( ge.ControlDown ) logBuf ~= " (control down)";
			Log.LogMessage( logBuf );

			// you must call event skip if you want default grid processing
			
			ge.Skip();			
		}		
		
		public void OnCellLeftClick( Object sender, Event e )
		{
			GridEvent ge = cast(GridEvent) e;
			logBuf = "Left click at row " ~ .toString(ge.Row) ~ " col " ~ .toString(ge.Col);
			Log.LogMessage( logBuf );

			// you must call event skip if you want default grid processing
			// (cell highlighting etc.)
			
			ge.Skip();			
		}		

		public void OnRowSize( Object sender, Event e )
		{
			GridSizeEvent ge = cast(GridSizeEvent) e;
			logBuf = "Resized row " ~ .toString(ge.RowOrCol);
			Log.LogMessage( logBuf );

			ge.Skip();			
		}		
		
		public void OnColSize( Object sender, Event e )
		{
			GridSizeEvent ge = cast(GridSizeEvent) e;
			logBuf = "Resized col " ~ .toString(ge.RowOrCol);
			Log.LogMessage( logBuf );

			ge.Skip();			
		}		

		public void OnSelectCell( Object sender, Event e )
		{
			GridEvent ge = cast(GridEvent) e;
			if ( ge.Selecting )
				logBuf = "Selected ";
			else
				logBuf = "Deselected ";
				
			logBuf ~= "cell at row " ~ .toString(ge.Row) ~
				" col " ~ .toString(ge.Col) ~
				" ( ControlDown: " ~ ( ge.ControlDown ? "T":"F" ) ~
				", ShiftDown: " ~ (ge.ShiftDown ? "T":"F") ~
				", AltDown: " ~ (ge.AltDown ? "T":"F") ~
				", MetaDown: " ~ (ge.MetaDown ? "T":"F") ~ " )";
				
			Log.LogMessage( logBuf );

			// you must call Skip() if you want the default processing
			// to occur in wxGrid
			ge.Skip();			
		}		
		
		public void OnRangeSelected( Object sender, Event e )
		{
			GridRangeSelectEvent ge = cast(GridRangeSelectEvent) e;
			
			if ( ge.Selecting )
				logBuf = "Selected ";
			else
				logBuf = "Deselected ";
				
			logBuf ~= "cells from row " ~ .toString(ge.TopRow) ~
				" col " ~ .toString(ge.LeftCol) ~
				" to row " ~ .toString(ge.BottomRow) ~
				" col " ~ .toString(ge.RightCol) ~
				" ( ControlDown: " ~ (ge.ControlDown ? "T":"F") ~
				", ShiftDown: " ~ (ge.ShiftDown ? "T":"F") ~
				", AltDown: " ~ (ge.AltDown ? "T":"F") ~
				", MetaDown: " ~ (ge.MetaDown ? "T":"F") ~ " )";
				
			Log.LogMessage( logBuf );

			ge.Skip();			
		}		

		public void OnCellValueChanged( Object sender, Event e )
		{
			GridEvent ge = cast(GridEvent) e;
			
			logBuf = "Value changed for cell at" ~
				" row " ~ .toString(ge.Row) ~
				" col " ~ .toString(ge.Col);

				Log.LogMessage( logBuf );

			ge.Skip();			
		}		

		public void OnEditorShown( Object sender, Event e )
		{
			GridEvent ge = cast(GridEvent) e;
			if ( ( ge.Col == 4 ) &&
				( ge.Row == 0 ) &&
				( MessageBox( "Are you sure you wish to edit this cell",
						"Checking", Dialog.wxYES_NO ) == Dialog.wxNO ) ) 
			{

				ge.Veto();
				return;
			}
			
			Log.LogMessage( "Cell editor shown." );

			ge.Skip();
		}		

		public void OnEditorHidden( Object sender, Event e )
		{
			GridEvent ge = cast(GridEvent) e;
			if ( ( ge.Col == 4 ) &&
				( ge.Row == 0 ) &&
				( MessageBox( "Are you sure you wish to finish editing this cell",
						"Checking", Dialog.wxYES_NO ) == Dialog.wxNO ) ) 
			{

				ge.Veto();
				return;
			}

			Log.LogMessage( "Cell editor hidden." );

			ge.Skip();			
		}				
	}
	
	//---------------------------------------------------------------------
	
	public class BugsGridFrame : Frame
	{
		public enum Columns
		{
			Col_Id,
			Col_Summary,
			Col_Severity, 
			Col_Priority,
			Col_Platform,
			Col_Opened,
			Col_Max
		}
		
		const public string[] severities =
		[
			"wishlist",
			"minor",
			"normal",
			"major",
			"critical"
		];
		
		public this()
		{
			super( null, -1, "Bugs table", wxDefaultPosition, Size( 500, 300 ) );
			Grid grid = new Grid( this, -1, wxDefaultPosition );
			GridTableBase table = new BugsGridTable();
			table.SetAttrProvider( new MyGridCellAttrProvider() );
			grid.SetTable(table, true);

			GridCellAttr attrRO    = new GridCellAttr();
			GridCellAttr attrRange = new GridCellAttr();
			GridCellAttr attrCombo = new GridCellAttr();

			attrRO.ReadOnly  = true;
			attrRange.Editor = new GridCellNumberEditor( 1, 5 );
			attrCombo.Editor = new GridCellChoiceEditor( cast(string[]) severities );

			grid.SetColAttr(Columns.Col_Id,       attrRO);
			grid.SetColAttr(Columns.Col_Priority, attrRange);
			grid.SetColAttr(Columns.Col_Severity, attrCombo);

			grid.SetMargins(0, 0);

			grid.Fit();
			ClientSize = grid.size;			
		}
	}
	
	//---------------------------------------------------------------------
	
	public class BugsGridTable : GridTableBase
	{
		public enum Columns
		{
			Col_Id,
			Col_Summary,
			Col_Severity,
			Col_Priority,
			Col_Platform,
			Col_Opened,
			Col_Max
		}	
		
		public enum Severity
		{
			Sev_Wish,
			Sev_Minor,
			Sev_Normal,
			Sev_Major,
			Sev_Critical,
			Sev_Max
		}
		
		public class BugsGridData
		{
			public int id;
			public string summary;
			public Severity severity;
			public int prio;
			public string platform;
			public bool opened;
			
            public this(int id, string summary, Severity severity, 
                                int prio, string platform, bool opened)
			{
				this.id = id;
				this.summary = summary;
				this.severity = severity;
				this.prio = prio;
				this.platform = platform;
				this.opened = opened;
			}
		}
		
		public static string[] severities =
		[
			"wishlist",
			"minor",
			"normal",
			"major",
			"critical"
		];
		
		public static string[] headers =
		[
			"Id",
			"Summary",
			"Severity",
			"Priority",
			"Platform",
			"Opened?"
		];
		
		public static BugsGridData[4]  gs_dataBugsGrid;
		
		public this() 
		{
			super();
			gs_dataBugsGrid[0] = new BugsGridData( 18, "foo doesn't work", Severity.Sev_Major, 1, "wxMSW", true );
			gs_dataBugsGrid[1] = new BugsGridData( 27, "bar crashes", Severity.Sev_Critical, 1, "all", false );
			gs_dataBugsGrid[2] = new BugsGridData( 45, "printing is slow", Severity.Sev_Minor, 3, "wxMSW", true );
			gs_dataBugsGrid[3] = new BugsGridData( 68, "Rectangle() fails", Severity.Sev_Normal, 1, "wxMSW", false );
		}
		
		public override int GetNumberRows()
		{
			return gs_dataBugsGrid.length;
		}
		
		public override int GetNumberCols()
		{
			return Columns.Col_Max;
		}
		
		public override bool IsEmptyCell( int row, int col )
		{
			return false;
		}
		
		public override string GetValue( int row, int col )
		{
			BugsGridData gd = gs_dataBugsGrid[row];
			
			switch( col )
			{
				case Columns.Col_Id:
				case Columns.Col_Priority:
				case Columns.Col_Opened:
					Log.LogError( "unexpected column" );
				break;

				case Columns.Col_Severity:
					return severities[gd.severity];

				case Columns.Col_Summary:
					return gd.summary;

				case Columns.Col_Platform:
					return gd.platform;

				default:
			}

			return "";				
		}
		
		public override void SetValue( int row, int col, string value)
		{
			BugsGridData gd = gs_dataBugsGrid[row];

			switch ( col )
			{
				case Columns.Col_Id:
				case Columns.Col_Priority:
				case Columns.Col_Opened:
					Log.LogError( "unexpected column" );
				break;

				case Columns.Col_Severity:
				{
					int n;
					for ( n = 0; n < severities.length; n++ )
					{
						if ( severities[n] == value )
						{
							gd.severity = cast(Severity)n;
							break;
						} 
					}

					if ( n == severities.length )
					{
						Log.LogWarning( "Invalid severity value '{0}'.", value );
						gd.severity = Severity.Sev_Normal;
					}
				}
				break;

				case Columns.Col_Summary:
					gd.summary = value;
				break;

				case Columns.Col_Platform:
					gd.platform = value;
				break;

				default:
			}			
		}
		
		public override string GetColLabelValue( int col )
		{
			return headers[col];
		}
		
		public override string GetTypeName( int row, int col )
		{
			switch ( col )
			{
				case Columns.Col_Id:
					return "long";
				
				case Columns.Col_Priority:
					return "long";

				case Columns.Col_Severity:
					return "string:80";

				case Columns.Col_Summary:
					return "string:80";

				case Columns.Col_Platform:
					return "choice:all,MSW,GTK,other";

				case Columns.Col_Opened:
					return "bool";

				default:
			}

			return "";			
		}
		
		public override bool CanGetValueAs( int row, int col, string typeName )
		{
			if ( typeName == "string" )
			{
				return true;
			}
			else if ( typeName == "bool" )
			{
				return col == Columns.Col_Opened;
			}
			else if ( typeName == "long" )
			{
				return col == Columns.Col_Id || col == Columns.Col_Priority || col == Columns.Col_Severity;
			}
			else
			{
				return false;
			}			
		}
		
		public override bool CanSetValueAs( int row, int col, string typeName )
		{
			return CanGetValueAs(row, col, typeName);
		}

		public override int GetValueAsLong( int row, int col )
		{
			BugsGridData gd = gs_dataBugsGrid[row];
			
			switch ( col )
			{
				case Columns.Col_Id:
					return gd.id;

				case Columns.Col_Priority:
					return gd.prio;

				case Columns.Col_Severity:
					return gd.severity;

				default:
					Log.LogError( "unexpected column" );
					return -1;
			}			
		}
		
		public override bool GetValueAsBool( int row, int col )
		{
			if ( col == Columns.Col_Opened )
			{
				return gs_dataBugsGrid[row].opened;
			}
			else 
			{
				Log.LogError( "unexpected column" );

				return false;
			}			
		} 

		public override void SetValueAsLong( int row, int col, int value )
		{
			BugsGridData gd = gs_dataBugsGrid[row];
			

			switch ( col )
			{
				case Columns.Col_Priority:
					gd.prio = value;
				break;

				default:
					Log.LogError( "unexpected column" );
				break;
			}			
		}
		
		public override void SetValueAsBool( int row, int col, bool value )
		{
			if ( col == Columns.Col_Opened )
			{
				gs_dataBugsGrid[row].opened = value;
			}
			else
			{
				Log.LogError( "unexpected column" );
			}			
		}
	} 
	 
	//---------------------------------------------------------------------
	
	public class MyGridCellAttrProvider : GridCellAttrProvider
	{
		private GridCellAttr m_attrForOddRows;
		
		public this()
		{
			m_attrForOddRows = new GridCellAttr();
			m_attrForOddRows.BackgroundColour = Colour.wxLIGHT_GREY;
		}
		
		public override GridCellAttr GetAttr( int row, int col, GridCellAttr.AttrKind kind)
		{
		
			GridCellAttr attr = super.GetAttr(row, col, kind);

			if ( ( row % 2 ) > 0 )
			{
				if ( attr is null )
				{
					attr = m_attrForOddRows;
					attr.IncRef();
				}
				else
				{
					if ( !attr.HasBackgroundColour )
					{
						GridCellAttr attrNew = attr.Clone();
						attr.DecRef();
						attr = attrNew;
						attr.BackgroundColour = Colour.wxLIGHT_GREY;
					}
				}
			}

			return attr;			
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyGridCellRenderer : GridCellStringRenderer
	{
		public this()
			
			{ super(); };
		public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
		{
			Draw(grid, attr, dc, rect, row, col, isSelected);
			
			dc.pen = Pen.wxGREEN_PEN;
			dc.brush = Brush.wxTRANSPARENT_BRUSH;
			dc.DrawEllipse( rect.X, rect.Y, rect.Width, rect.Height );
		}
	}
	
	//---------------------------------------------------------------------
	
	public class BigGridFrame : Frame
	{
		private Grid m_grid;
		private BigGridTable m_table;
		
		public this(int sizeGrid)
		{
			super(null, -1, "Plugin Virtual Table", wxDefaultPosition, Size( 500, 450 ) );
			m_grid = new Grid( this, -1, wxDefaultPosition, wxDefaultSize );
			m_table = new BigGridTable( sizeGrid );
			 
			m_grid.SetTable( m_table, true );
		}
	}
	
	//---------------------------------------------------------------------
	
	public class BigGridTable : GridTableBase
	{
		private int m_sizeGrid;
		
		public this( int sizeGrid)
		{
			super();
			m_sizeGrid = sizeGrid;
		}
		
		public override int GetNumberRows()
		{
			return m_sizeGrid;
		}
		
		public override int GetNumberCols()
		{
			return m_sizeGrid;
		}
		
		public override string GetValue( int row, int col )
		{
			string ret = "(" ~ .toString(row) ~ ", " ~ .toString(col) ~ ")";
			return ret;
		}
		
		public override void SetValue( int row, int col, string val )
		{
		}
		
		public override bool IsEmptyCell( int row, int col )
		{
			return false;
		}
	}
	
	//---------------------------------------------------------------------

	public class GridApp : App
	{
		public override bool OnInit()
		{
			GridFrame frame = new GridFrame();
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main()
		{
			GridApp app = new GridApp();
			app.Run();
		}
	}	

void main()
{
	GridApp.Main();
}
