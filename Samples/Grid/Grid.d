//-----------------------------------------------------------------------------
// wx.NET/Samples - Grid.cs
//
// wx.NET "grid" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2004 by Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing; 

namespace wx.Samples
{
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
		
		public static long s_sizeGrid = 10000;
		
		//-----------------------------------------------------------------------------
		
		public GridFrame()
			: base( null, -1, "wxWidgets grid class demo", wxDefaultPosition, wxDefaultSize )
		{
			Icon = new wx.Icon( "../Samples/Grid/mondrian.png" );
			
			int gridW = 600;
			int gridH = 300;
			int logW = gridW;
			int logH = 100;
			
			Menu fileMenu = new Menu();
			fileMenu.Append( (int)Cmd.ID_VTABLE, "&Virtual table test\tCtrl-V" );
			fileMenu.Append( (int)Cmd.ID_BUGS_TABLE, "&Bugs table test\tCtrl-B" );
			fileMenu.Append( (int)Cmd.ID_SMALL_GRID, "&Small Grid test\tCtrl-S" );
			fileMenu.AppendSeparator();
			fileMenu.Append( (int)Cmd.ID_EXIT, "E&xit\tAlt-X" );

			Menu viewMenu = new Menu();
			viewMenu.AppendCheckItem( (int)Cmd.ID_TOGGLEROWLABELS,  "&Row labels", "" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_TOGGLECOLLABELS,  "&Col labels", "" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_TOGGLEEDIT,  "&Editable", "" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_TOGGLEROWSIZING, "Ro&w drag-resize", "" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_TOGGLECOLSIZING, "C&ol drag-resize", "" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_TOGGLEGRIDSIZING, "&Grid drag-resize", "" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_TOGGLEGRIDLINES, "&Grid Lines", "" );
			viewMenu.Append( (int)Cmd.ID_SET_HIGHLIGHT_WIDTH, "&Set Cell Highlight Width...", "" );
			viewMenu.Append( (int)Cmd.ID_SET_RO_HIGHLIGHT_WIDTH, "&Set Cell RO Highlight Width...", "" );
			viewMenu.Append( (int)Cmd.ID_AUTOSIZECOLS, "&Auto-size cols" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_CELLOVERFLOW, "&Overflow cells", "" );
			viewMenu.AppendCheckItem( (int)Cmd.ID_RESIZECELL, "&Resize cell (7,1)", "" );

			Menu rowLabelMenu = new Menu();

			viewMenu.Append( (int)Cmd.ID_ROWLABELALIGN, "R&ow label alignment", rowLabelMenu, "Change alignment of row labels" );

			rowLabelMenu.Append( (int)Cmd.ID_ROWLABELHORIZALIGN, "&Horizontal" );
			rowLabelMenu.Append( (int)Cmd.ID_ROWLABELVERTALIGN, "&Vertical" );

			Menu colLabelMenu = new Menu();

			viewMenu.Append( (int)Cmd.ID_COLLABELALIGN, "Col l&abel alignment", colLabelMenu, "Change alignment of col labels" );

			colLabelMenu.Append( (int)Cmd.ID_COLLABELHORIZALIGN, "&Horizontal" );
			colLabelMenu.Append( (int)Cmd.ID_COLLABELVERTALIGN, "&Vertical" );

			Menu colMenu = new Menu();
			colMenu.Append( (int)Cmd.ID_SETLABELCOLOUR, "Set &label colour..." );
			colMenu.Append( (int)Cmd.ID_SETLABELTEXTCOLOUR, "Set label &text colour..." );
			colMenu.Append( (int)Cmd.ID_SETLABEL_FONT, "Set label fo&nt..." );
			colMenu.Append( (int)Cmd.ID_GRIDLINECOLOUR, "&Grid line colour..." );
			colMenu.Append( (int)Cmd.ID_SET_CELL_FG_COLOUR, "Set cell &foreground colour..." );
			colMenu.Append( (int)Cmd.ID_SET_CELL_BG_COLOUR, "Set cell &background colour..." );

			Menu editMenu = new Menu();
			editMenu.Append( (int)Cmd.ID_INSERTROW, "Insert &row" );
			editMenu.Append( (int)Cmd.ID_INSERTCOL, "Insert &column" );
			editMenu.Append( (int)Cmd.ID_DELETEROW, "Delete selected ro&ws" );
			editMenu.Append( (int)Cmd.ID_DELETECOL, "Delete selected co&ls" );
			editMenu.Append( (int)Cmd.ID_CLEARGRID, "Cl&ear grid cell contents" );

			Menu selectMenu = new Menu();
			selectMenu.AppendCheckItem( (int)Cmd.ID_SELECT_UNSELECT, "Add new cells to the selection",
				"When off, old selection is deselected before selecting the new cells" );
			selectMenu.Append( (int)Cmd.ID_SELECT_ALL, "Select all" );
			selectMenu.Append( (int)Cmd.ID_SELECT_ROW, "Select row 2" );
			selectMenu.Append( (int)Cmd.ID_SELECT_COL, "Select col 2" );
			selectMenu.Append( (int)Cmd.ID_SELECT_CELL, "Select cell (3, 1)" );
			selectMenu.Append( (int)Cmd.ID_DESELECT_ALL, "Deselect all" );
			selectMenu.Append( (int)Cmd.ID_DESELECT_ROW, "Deselect row 2" );
			selectMenu.Append( (int)Cmd.ID_DESELECT_COL, "Deselect col 2" );
			selectMenu.Append( (int)Cmd.ID_DESELECT_CELL, "Deselect cell (3, 1)" );
			
			Menu selectionMenu = new Menu();
			selectMenu.Append( (int)Cmd.ID_CHANGESEL, "Change &selection mode", selectionMenu, "Change selection mode" );

			selectionMenu.Append( (int)Cmd.ID_SELCELLS, "Select &Cells" );
			selectionMenu.Append( (int)Cmd.ID_SELROWS, "Select &Rows" );
			selectionMenu.Append( (int)Cmd.ID_SELCOLS, "Select C&ols" );


			Menu helpMenu = new Menu();
			helpMenu.Append( (int)Cmd.ID_ABOUT, "&About wxGrid demo" );

			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append( fileMenu, "&File" );
			menuBar.Append( viewMenu, "&View" );
			menuBar.Append( colMenu,  "&Colours" );
			menuBar.Append( editMenu, "&Edit" );
			menuBar.Append( selectMenu, "&Select" );
			menuBar.Append( helpMenu, "&Help" );

			MenuBar = menuBar ;	
			
			grid = new Grid( this, -1, new Point( 0, 0 ), new Size( 400, 300 ) );
			
			logWin = new TextCtrl( this, -1, "", new Point( 0, gridH + 20 ), new Size( logW, logH ), TextCtrl.wxTE_MULTILINE );
			
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
			grid.SetCellAlignment( 4, 4, (int)Alignment.wxALIGN_CENTRE, (int)Alignment.wxALIGN_CENTRE );
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
			{
				"Please select a choice",
				"This takes two cells",
				"Another choice"
			};
			
			grid.SetCellEditor( 4, 0, new GridCellChoiceEditor( choices ) );
			grid.SetCellSize( 4, 0, 1, 2 );
			grid.SetCellValue( 4, 0, choices[0] );
			grid.SetCellOverflow( 4, 0, false );

			grid.SetCellSize( 7, 1, 3, 4 );
			grid.SetCellAlignment( 7, 1, (int)Alignment.wxALIGN_CENTRE, (int)Alignment.wxALIGN_CENTRE );
			grid.SetCellValue( 7, 1, "Big box!" );

			BoxSizer topSizer = new BoxSizer( Orientation.wxVERTICAL );
			topSizer.Add( grid, 1, Stretch.wxEXPAND );

			topSizer.Add( logWin, 0, Stretch.wxEXPAND );

			AutoLayout = true;
			Sizer = topSizer ;

			topSizer.Fit( this );
			topSizer.SetSizeHints( this );

			Centre();
			SetDefaults();			
			
			EVT_MENU( (int)Cmd.ID_TOGGLEROWLABELS,  new EventListener( ToggleRowLabels ) );
			EVT_MENU( (int)Cmd.ID_TOGGLECOLLABELS,  new EventListener( ToggleColLabels ) );
			EVT_MENU( (int)Cmd.ID_TOGGLEEDIT, new EventListener( ToggleEditing ) );
			EVT_MENU( (int)Cmd.ID_TOGGLEROWSIZING, new EventListener( ToggleRowSizing ) );
			EVT_MENU( (int)Cmd.ID_TOGGLECOLSIZING, new EventListener( ToggleColSizing ) );
			EVT_MENU( (int)Cmd.ID_TOGGLEGRIDSIZING, new EventListener( ToggleGridSizing ) );
			EVT_MENU( (int)Cmd.ID_TOGGLEGRIDLINES, new EventListener( ToggleGridLines ) );
			EVT_MENU( (int)Cmd.ID_AUTOSIZECOLS, new EventListener( AutoSizeCols ) );
			EVT_MENU( (int)Cmd.ID_CELLOVERFLOW, new EventListener( CellOverflow ) );
			EVT_MENU( (int)Cmd.ID_RESIZECELL, new EventListener( ResizeCell ) );
			EVT_MENU( (int)Cmd.ID_SETLABELCOLOUR, new EventListener( SetLabelColour ) );
			EVT_MENU( (int)Cmd.ID_SETLABELTEXTCOLOUR, new EventListener( SetLabelTextColour ) );
			EVT_MENU( (int)Cmd.ID_SETLABEL_FONT, new EventListener( SetLabelFont ) );
			EVT_MENU( (int)Cmd.ID_ROWLABELHORIZALIGN, new EventListener( SetRowLabelHorizAlignment ) );
			EVT_MENU( (int)Cmd.ID_ROWLABELVERTALIGN, new EventListener( SetRowLabelVertAlignment ) );
			EVT_MENU( (int)Cmd.ID_COLLABELHORIZALIGN, new EventListener( SetColLabelHorizAlignment ) );
			EVT_MENU( (int)Cmd.ID_COLLABELVERTALIGN, new EventListener( SetColLabelVertAlignment ) );
			EVT_MENU( (int)Cmd.ID_GRIDLINECOLOUR, new EventListener( SetGridLineColour ) );
			EVT_MENU( (int)Cmd.ID_INSERTROW, new EventListener( InsertRow ) );
			EVT_MENU( (int)Cmd.ID_INSERTCOL, new EventListener( InsertCol ) );
			EVT_MENU( (int)Cmd.ID_DELETEROW, new EventListener( DeleteSelectedRows ) );
			EVT_MENU( (int)Cmd.ID_DELETECOL, new EventListener( DeleteSelectedCols ) );
			EVT_MENU( (int)Cmd.ID_CLEARGRID, new EventListener( ClearGrid ) );
			EVT_MENU( (int)Cmd.ID_SELCELLS,  new EventListener( SelectCells ) );
			EVT_MENU( (int)Cmd.ID_SELROWS,  new EventListener( SelectRows ) );
			EVT_MENU( (int)Cmd.ID_SELCOLS,  new EventListener( SelectCols ) );
			
			EVT_MENU( (int)Cmd.ID_SET_CELL_FG_COLOUR, new EventListener( SetCellFgColour ) );
			EVT_MENU( (int)Cmd.ID_SET_CELL_BG_COLOUR, new EventListener( SetCellBgColour ) );
			
			EVT_MENU( (int)Cmd.ID_ABOUT, new EventListener( About ) );
			EVT_MENU( (int)Cmd.ID_EXIT, new EventListener( OnQuit ) );
			EVT_MENU( (int)Cmd.ID_VTABLE, new EventListener( OnVTable) );
			EVT_MENU( (int)Cmd.ID_BUGS_TABLE, new EventListener( OnBugsTable) );
			EVT_MENU( (int)Cmd.ID_SMALL_GRID, new EventListener( OnSmallGrid) );
			
			EVT_MENU( (int)Cmd.ID_DESELECT_CELL, new EventListener( DeselectCell) );
			EVT_MENU( (int)Cmd.ID_DESELECT_COL, new EventListener( DeselectCol) );
			EVT_MENU( (int)Cmd.ID_DESELECT_ROW, new EventListener( DeselectRow) );
			EVT_MENU( (int)Cmd.ID_DESELECT_ALL, new EventListener( DeselectAll) );
			EVT_MENU( (int)Cmd.ID_SELECT_CELL, new EventListener( SelectCell) );
			EVT_MENU( (int)Cmd.ID_SELECT_COL, new EventListener( SelectCol) );
			EVT_MENU( (int)Cmd.ID_SELECT_ROW, new EventListener( SelectRow) );
			EVT_MENU( (int)Cmd.ID_SELECT_ALL, new EventListener( SelectAll) );
			EVT_MENU( (int)Cmd.ID_SELECT_UNSELECT, new EventListener( OnAddToSelectToggle) );
			
			EVT_MENU( (int)Cmd.ID_SET_HIGHLIGHT_WIDTH, new EventListener( OnSetHighlightWidth) );
			EVT_MENU( (int)Cmd.ID_SET_RO_HIGHLIGHT_WIDTH, new EventListener( OnSetROHighlightWidth) );
			
			EVT_GRID_LABEL_LEFT_CLICK( new EventListener( OnLabelLeftClick ) );
			EVT_GRID_CELL_LEFT_CLICK( new EventListener( OnCellLeftClick ) );
			EVT_GRID_ROW_SIZE( new EventListener( OnRowSize ) );
			EVT_GRID_COL_SIZE( new EventListener( OnColSize ) );
			EVT_GRID_SELECT_CELL( new EventListener( OnSelectCell ) );
			EVT_GRID_RANGE_SELECT( new EventListener( OnRangeSelected ) );
			EVT_GRID_CELL_CHANGE( new EventListener( OnCellValueChanged ) );
			
			EVT_GRID_EDITOR_SHOWN( new EventListener( OnEditorShown ) );
			EVT_GRID_EDITOR_HIDDEN( new EventListener( OnEditorHidden ) );			
			
		}
		
		public void SetDefaults()
		{
			MenuBar.Check( (int)Cmd.ID_TOGGLEROWLABELS, true );
			MenuBar.Check( (int)Cmd.ID_TOGGLECOLLABELS, true );
			MenuBar.Check( (int)Cmd.ID_TOGGLEEDIT, true );
			MenuBar.Check( (int)Cmd.ID_TOGGLEROWSIZING, true );
			MenuBar.Check( (int)Cmd.ID_TOGGLECOLSIZING, true );
			MenuBar.Check( (int)Cmd.ID_TOGGLEGRIDSIZING, true );
			MenuBar.Check( (int)Cmd.ID_TOGGLEGRIDLINES, true );
			MenuBar.Check( (int)Cmd.ID_CELLOVERFLOW, true );
		}
		
		public void ToggleRowLabels( object sender, Event e )
		{
			if ( MenuBar.IsChecked( (int)Cmd.ID_TOGGLEROWLABELS ) )
			{
				grid.RowLabelSize = grid.DefaultRowLabelSize;
			}
			else
			{
				grid.RowLabelSize = 0;
			}
		}
		
		public void ToggleColLabels( object sender, Event e )
		{
			if ( MenuBar.IsChecked( (int)Cmd.ID_TOGGLECOLLABELS ) )
			{
				grid.ColLabelSize = grid.DefaultColLabelSize;
			}
			else
			{
				grid.ColLabelSize = 0;
			}			
		}
		
		public void ToggleEditing( object sender, Event e )
		{
			grid.IsEditable = MenuBar.IsChecked( (int)Cmd. ID_TOGGLEEDIT );
		}

		public void ToggleRowSizing( object sender, Event e )
		{
			grid.DragRowSizeEnabled = MenuBar.IsChecked( (int)Cmd.ID_TOGGLEROWSIZING );			
		}

		public void ToggleColSizing( object sender, Event e )
		{
			grid.DragColSizeEnabled = MenuBar.IsChecked( (int)Cmd.ID_TOGGLECOLSIZING );
			
		}

		public void ToggleGridSizing( object sender, Event e )
		{
			grid.DragGridSizeEnabled = MenuBar.IsChecked( (int)Cmd.ID_TOGGLEGRIDSIZING );			
		}

		public void ToggleGridLines( object sender, Event e )
		{
			grid.GridLinesEnabled = MenuBar.IsChecked( (int)Cmd.ID_TOGGLEGRIDLINES );			
		}

		public void AutoSizeCols( object sender, Event e )
		{
			grid.AutoSizeColumns();
			grid.Refresh();			
		}

		public void CellOverflow( object sender, Event e )
		{
			CommandEvent ce = (CommandEvent) e;
			grid.DefaultCellOverflow = ce.IsChecked;
			grid.Refresh();
		}

		public void ResizeCell( object sender, Event e )
		{
			CommandEvent ce = (CommandEvent) e;
			
			if ( ce.IsChecked )
				grid.SetCellSize( 7, 1, 5, 5 );
			else
				grid.SetCellSize( 7, 1, 1, 5 );
				
			grid.Refresh();
		}

		public void SetLabelColour( object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog( null );
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.ColourData;
				Colour colour = retData.Colour;

				grid.LabelBackgroundColour = colour;
			}			
		}
		
		public void SetLabelTextColour( object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog( null );
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.ColourData;
				Colour colour = retData.Colour;

				grid.LabelTextColour = colour;
			}				
		}		
		
		public void SetLabelFont( object sender, Event e )
		{
			FontData data = new FontData();
			data.InitialFont = grid.LabelFont;
			
			FontDialog fd = new FontDialog(this, data);
			
			if ( fd.ShowModal() == wxID_OK )
			{			
				Font font = fd.FontData.ChosenFont;
				if ( font.Ok )
				{
					grid.LabelFont = font;
				}
			}
			
		}		

		public void SetRowLabelHorizAlignment( object sender, Event e )
		{
			int horiz, vert;
			grid.GetRowLabelAlignment( out horiz, out vert );

			switch ( horiz )
			{
				case (int)Alignment.wxALIGN_LEFT:
					horiz = (int)Alignment.wxALIGN_CENTRE;
				break;

				case (int)Alignment.wxALIGN_CENTRE:
					horiz = (int)Alignment.wxALIGN_RIGHT;
				break;

				case (int)Alignment.wxALIGN_RIGHT:
					horiz = (int)Alignment.wxALIGN_LEFT;
				break;
			}

			grid.SetRowLabelAlignment( horiz, -1 );			
		}		

		public void SetRowLabelVertAlignment( object sender, Event e )
		{
			int horiz, vert;
			grid.GetRowLabelAlignment( out horiz, out vert );

			switch ( vert )
			{
				case (int)Alignment.wxALIGN_TOP:
					vert = (int)Alignment.wxALIGN_CENTRE;
				break;

				case (int)Alignment.wxALIGN_CENTRE:
					vert = (int)Alignment.wxALIGN_BOTTOM;
				break;

				case (int)Alignment.wxALIGN_BOTTOM:
					vert = (int)Alignment.wxALIGN_TOP;
				break;
			}

			grid.SetRowLabelAlignment( -1, vert );			
		}		

		public void SetColLabelHorizAlignment( object sender, Event e )
		{
			int horiz, vert;
			grid.GetColLabelAlignment( out horiz, out vert );

			switch ( horiz )
			{
				case (int)Alignment.wxALIGN_LEFT:
					horiz = (int)Alignment.wxALIGN_CENTRE;
				break;

				case (int)Alignment.wxALIGN_CENTRE:
					horiz = (int)Alignment.wxALIGN_RIGHT;
				break;

				case (int)Alignment.wxALIGN_RIGHT:
					horiz = (int)Alignment.wxALIGN_LEFT;
				break;
			}

			grid.SetColLabelAlignment( horiz, -1 );			
		}		

		public void SetColLabelVertAlignment( object sender, Event e )
		{
			int horiz, vert;
			grid.GetColLabelAlignment( out horiz, out vert );

			switch ( vert )
			{
				case (int)Alignment.wxALIGN_TOP:
					vert = (int)Alignment.wxALIGN_CENTRE;
				break;

				case (int)Alignment.wxALIGN_CENTRE:
					vert = (int)Alignment.wxALIGN_BOTTOM;
				break;

				case (int)Alignment.wxALIGN_BOTTOM:
				vert = (int)Alignment.wxALIGN_TOP;
				break;
			}

			grid.SetColLabelAlignment( -1, vert );			
		}		

		public void SetGridLineColour( object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog( null );
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.ColourData;
				Colour colour = retData.Colour;

				grid.GridLineColour = colour;
			}							
		}		
		
		public void InsertRow( object sender, Event e )
		{
			grid.InsertRows( grid.GridCursorRow, 1 );			
		}		

		public void InsertCol( object sender, Event e )
		{
			grid.InsertCols( grid.GridCursorCol, 1 );
		}		

		public void DeleteSelectedRows( object sender, Event e )
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

		public void DeleteSelectedCols( object sender, Event e )
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
		
		public void ClearGrid( object sender, Event e )
		{
			grid.ClearGrid();
		}		
		
		public void SelectCells( object sender, Event e )
		{
			grid.SelectionMode = GridSelectionMode.wxGridSelectCells;
		}		
		
		public void SelectRows( object sender, Event e )
		{
			grid.SelectionMode = GridSelectionMode.wxGridSelectRows;
		}		

		public void SelectCols( object sender, Event e )
		{
			grid.SelectionMode = GridSelectionMode.wxGridSelectColumns;
		}		

		public void SetCellFgColour( object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog( null );
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.ColourData;
				Colour colour = retData.Colour;

				if ( colour.Ok() )
				{
					grid.DefaultCellTextColour = colour;
					grid.Refresh();
				}
			}										
		}		

		public void SetCellBgColour( object sender, Event e )
		{
			ColourDialog dlg = new ColourDialog( null );
			if ( dlg.ShowModal() == wxID_OK )
			{
				ColourData retData = dlg.ColourData;
				Colour colour = retData.Colour;

				if ( colour.Ok() )
				{
					grid.DefaultCellBackgroundColour = colour;
					Rectangle r = new Rectangle( 0, 0, grid.Size.Width, grid.Size.Height );
					grid.Refresh( true, r);
				}
			}													
		}		
	
		public void About( object sender, Event e )
		{
			wx.MessageDialog.ShowModal( "\n\nwxGrid demo \n\n" +
				"Ported to wx.NET \nby\n" +
				"Alexander Olk\n\n",
				"About",
				Dialog.wxOK );			
		}		

		public void OnQuit( object sender, Event e )
		{
			Close( true );
		}		

		public void OnVTable( object sender, Event e )
		{
			s_sizeGrid = GetNumberFromUser( "Size of the table to create",
                                     "Size: ",
                                     "wxGridDemo question",
                                     (int)s_sizeGrid,
                                     0, 32000, this);
				
			if ( s_sizeGrid != -1 )
			{
				BigGridFrame win = new BigGridFrame( s_sizeGrid );
				win.Show( true );
			}
		}		
		
		public void OnBugsTable( object sender, Event e )
		{
			BugsGridFrame frame = new BugsGridFrame();
			frame.Show( true );
		}		
		
		public void OnSmallGrid( object sender, Event e )
		{
			Frame frame = new Frame( null, -1, "A Small Grid", wxDefaultPosition, new Size( 640, 480 ) );
			Panel panel = new Panel( frame, -1 );
			Grid agrid = new Grid( panel, -1, new Point( 10, 10 ), new Size( 400, 400 ), wxWANTS_CHARS | wxSIMPLE_BORDER );
			agrid.CreateGrid( 3, 3 );
			frame.Show( true );
		}		
		
		public void DeselectCell( object sender, Event e )
		{
			grid.DeselectCell( 3, 1 );
		}		

		public void DeselectCol( object sender, Event e )
		{
			grid.DeselectCol( 2 );
		}		
		
		public void DeselectRow( object sender, Event e )
		{
			grid.DeselectRow( 2 );
		}		
	
		public void DeselectAll( object sender, Event e )
		{
			grid.ClearSelection();
		}		

		public void SelectCell( object sender, Event e )
		{
			grid.SelectBlock( 3, 1, 3, 1, m_addToSel );
		}		
		
		public void SelectCol( object sender, Event e )
		{
			grid.SelectCol( 2, m_addToSel );
		}		
		
		public void SelectRow( object sender, Event e )
		{
			grid.SelectRow( 2, m_addToSel );
		}		

		public void SelectAll( object sender, Event e )
		{
			grid.SelectAll();
		}		
		
		public void OnAddToSelectToggle( object sender, Event e )
		{
			CommandEvent ce = (CommandEvent) e;
			m_addToSel = ce.IsChecked;
		}		

		public void OnSetHighlightWidth( object sender, Event e )
		{
			string[] choices = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" };

			SingleChoiceDialog dlg = new SingleChoiceDialog(this, "Choose the thickness of the highlight pen:",
				"Pen Width", choices);

			int current = grid.CellHighlightPenWidth;
			dlg.SetSelection( current );
			if ( dlg.ShowModal() == wxID_OK ) 
			{
				grid.CellHighlightPenWidth = dlg.GetSelection();
			}			
		}		

		public void OnSetROHighlightWidth( object sender, Event e )
		{
			string[] choices = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" };

			SingleChoiceDialog dlg = new SingleChoiceDialog(this, "Choose the thickness of the highlight pen:",
				"Pen Width", choices);

			int current = grid.CellHighlightROPenWidth;
			dlg.SetSelection( current );
			if ( dlg.ShowModal() == wxID_OK ) 
			{
				grid.CellHighlightROPenWidth = dlg.GetSelection();
			}			
		}		
		
		public void OnLabelLeftClick( object sender, Event e )
		{
			GridEvent ge = (GridEvent) e;
			
			if ( ge.Row != -1 )
			{
				logBuf = "Left click on row label " + ge.Row;
			}
			else if ( ge.Col != -1 )
			{
				logBuf += "Left click on col label " + ge.Col;
			}
			else
			{
				logBuf += "Left click on corner label";
			}

			if ( ge.ShiftDown ) logBuf += " (shift down)";
			if ( ge.ControlDown ) logBuf += " (control down)";
			Log.LogMessage( logBuf );

			// you must call event skip if you want default grid processing
			
			ge.Skip();			
		}		
		
		public void OnCellLeftClick( object sender, Event e )
		{
			GridEvent ge = (GridEvent) e;
			logBuf = "Left click at row " + ge.Row + " col " + ge.Col;
			Log.LogMessage( logBuf );

			// you must call event skip if you want default grid processing
			// (cell highlighting etc.)
			
			ge.Skip();			
		}		

		public void OnRowSize( object sender, Event e )
		{
			GridSizeEvent ge = (GridSizeEvent) e;
			logBuf = "Resized row " + ge.RowOrCol;
			Log.LogMessage( logBuf );

			ge.Skip();			
		}		
		
		public void OnColSize( object sender, Event e )
		{
			GridSizeEvent ge = (GridSizeEvent) e;
			logBuf = "Resized col " + ge.RowOrCol;
			Log.LogMessage( logBuf );

			ge.Skip();			
		}		

		public void OnSelectCell( object sender, Event e )
		{
			GridEvent ge = (GridEvent) e;
			if ( ge.Selecting )
				logBuf = "Selected ";
			else
				logBuf = "Deselected ";
				
			logBuf += "cell at row " + ge.Row +
				" col " + ge.Col +
				" ( ControlDown: " + ( ge.ControlDown ? 'T':'F' ) +
				", ShiftDown: " + (ge.ShiftDown ? 'T':'F') +
				", AltDown: " + (ge.AltDown ? 'T':'F') +
				", MetaDown: " + (ge.MetaDown ? 'T':'F') + " )";
				
			Log.LogMessage( logBuf );

			// you must call Skip() if you want the default processing
			// to occur in wxGrid
			ge.Skip();			
		}		
		
		public void OnRangeSelected( object sender, Event e )
		{
			GridRangeSelectEvent ge = (GridRangeSelectEvent) e;
			
			if ( ge.Selecting )
				logBuf = "Selected ";
			else
				logBuf = "Deselected ";
				
			logBuf += "cells from row " + ge.TopRow +
				" col " + ge.LeftCol +
				" to row " + ge.BottomRow +
				" col " + ge.RightCol +
				" ( ControlDown: " + (ge.ControlDown ? 'T':'F') +
				", ShiftDown: " + (ge.ShiftDown ? 'T':'F') +
				", AltDown: " + (ge.AltDown ? 'T':'F') +
				", MetaDown: " + (ge.MetaDown ? 'T':'F') + " )";
				
			Log.LogMessage( logBuf );

			ge.Skip();			
		}		

		public void OnCellValueChanged( object sender, Event e )
		{
			GridEvent ge = (GridEvent) e;
			
			logBuf = "Value changed for cell at" +
				" row " + ge.Row +
				" col " + ge.Col;

				Log.LogMessage( logBuf );

			ge.Skip();			
		}		

		public void OnEditorShown( object sender, Event e )
		{
			GridEvent ge = (GridEvent) e;
			if ( ( ge.Col == 4 ) &&
				( ge.Row == 0 ) &&
				( wx.MessageDialog.ShowModal( "Are you sure you wish to edit this cell",
						"Checking", Dialog.wxYES_NO ) == wxID_NO ) ) 
			{

				ge.Veto();
				return;
			}
			
			Log.LogMessage( "Cell editor shown." );

			ge.Skip();
		}		

		public void OnEditorHidden( object sender, Event e )
		{
			GridEvent ge = (GridEvent) e;
			if ( ( ge.Col == 4 ) &&
				( ge.Row == 0 ) &&
				( wx.MessageDialog.ShowModal( "Are you sure you wish to finish editing this cell",
						"Checking", Dialog.wxYES_NO ) == wxID_NO ) ) 
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
		
		public string[] severities =
		{
			"wishlist",
			"minor",
			"normal",
			"major",
			"critical"
		};
		
		public BugsGridFrame()
			: base( null, -1, "Bugs table", wxDefaultPosition, new Size( 500, 300 ) )
		{
			Grid grid = new Grid( this, -1, wxDefaultPosition );
			GridTableBase table = new BugsGridTable();
			table.SetAttrProvider( new MyGridCellAttrProvider() );
			grid.SetTable(table, true);

			GridCellAttr attrRO    = new GridCellAttr();
			GridCellAttr attrRange = new GridCellAttr();
			GridCellAttr attrCombo = new GridCellAttr();

			attrRO.ReadOnly  = true;
			attrRange.Editor = new GridCellNumberEditor( 1, 5 );
			attrCombo.Editor = new GridCellChoiceEditor( severities );

			grid.SetColAttr((int)Columns.Col_Id,       attrRO);
			grid.SetColAttr((int)Columns.Col_Priority, attrRange);
			grid.SetColAttr((int)Columns.Col_Severity, attrCombo);

			grid.SetMargins(0, 0);

			grid.Fit();
			ClientSize = grid.Size;			
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
		
		public struct BugsGridData
		{
			public int id;
			public string summary;
			public Severity severity;
			public int prio;
			public string platform;
			public bool opened;
			
            public BugsGridData(int id, string summary, Severity severity, 
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
		{
			"wishlist",
			"minor",
			"normal",
			"major",
			"critical"
		};
		
		public static string[] headers =
		{
			"Id",
			"Summary",
			"Severity",
			"Priority",
			"Platform",
			"Opened?"
		};
		
		public static BugsGridData[] gs_dataBugsGrid = new BugsGridData[4];
		
		public BugsGridTable() 
			: base()
		{
			gs_dataBugsGrid[0] = new BugsGridData( 18, "foo doesn't work", Severity.Sev_Major, 1, "wxMSW", true );
			gs_dataBugsGrid[1] = new BugsGridData( 27, "bar crashes", Severity.Sev_Critical, 1, "all", false );
			gs_dataBugsGrid[2] = new BugsGridData( 45, "printing is slow", Severity.Sev_Minor, 3, "wxMSW", true );
			gs_dataBugsGrid[3] = new BugsGridData( 68, "Rectangle() fails", Severity.Sev_Normal, 1, "wxMSW", false );
		}
		
		public override int GetNumberRows()
		{
			return gs_dataBugsGrid.Length;
		}
		
		public override int GetNumberCols()
		{
			return (int)Columns.Col_Max;
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
				case (int)Columns.Col_Id:
				case (int)Columns.Col_Priority:
				case (int)Columns.Col_Opened:
					Log.LogError( "unexpected column" );
				break;

				case (int)Columns.Col_Severity:
					return severities[(int)gd.severity];

				case (int)Columns.Col_Summary:
					return gd.summary;

				case (int)Columns.Col_Platform:
					return gd.platform;
			}

			return "";				
		}
		
		public override void SetValue( int row, int col, string value)
		{
			BugsGridData gd = gs_dataBugsGrid[row];

			switch ( col )
			{
				case (int)Columns.Col_Id:
				case (int)Columns.Col_Priority:
				case (int)Columns.Col_Opened:
					Log.LogError( "unexpected column" );
				break;

				case (int)Columns.Col_Severity:
				{
					int n;
					for ( n = 0; n < severities.Length; n++ )
					{
						if ( severities[n] == value )
						{
							gd.severity = (Severity)n;
							break;
						} 
					}

					if ( n == severities.Length )
					{
						Log.LogWarning( "Invalid severity value '{0}'.", value );
						gd.severity = Severity.Sev_Normal;
					}
				}
				break;

				case (int)Columns.Col_Summary:
					gd.summary = value;
				break;

				case (int)Columns.Col_Platform:
					gd.platform = value;
				break;
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
				case (int)Columns.Col_Id:
					return "long";
				
				case (int)Columns.Col_Priority:
					return "long";

				case (int)Columns.Col_Severity:
					return "string:80";

				case (int)Columns.Col_Summary:
					return "string:80";

				case (int)Columns.Col_Platform:
					return "choice:all,MSW,GTK,other";

				case (int)Columns.Col_Opened:
					return "bool";
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
				return col == (int)Columns.Col_Opened;
			}
			else if ( typeName == "long" )
			{
				return col == (int)Columns.Col_Id || col == (int)Columns.Col_Priority || col == (int)Columns.Col_Severity;
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

		public override long GetValueAsLong( int row, int col )
		{
			BugsGridData gd = gs_dataBugsGrid[row];
			
			switch ( col )
			{
				case (int)Columns.Col_Id:
					return gd.id;

				case (int)Columns.Col_Priority:
					return gd.prio;

				case (int)Columns.Col_Severity:
					return (int)gd.severity;

				default:
					Log.LogError( "unexpected column" );
					return -1;
			}			
		}
		
		public override bool GetValueAsBool( int row, int col )
		{
			if ( col == (int)Columns.Col_Opened )
			{
				return gs_dataBugsGrid[row].opened;
			}
			else 
			{
				Log.LogError( "unexpected column" );

				return false;
			}			
		} 

		public override void SetValueAsLong( int row, int col, long value )
		{
			BugsGridData gd = gs_dataBugsGrid[row];
			

			switch ( col )
			{
				case (int)Columns.Col_Priority:
					gd.prio = (int)value;
				break;

				default:
					Log.LogError( "unexpected column" );
				break;
			}			
		}
		
		public override void SetValueAsBool( int row, int col, bool value )
		{
			if ( col == (int)Columns.Col_Opened )
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
		
		public MyGridCellAttrProvider()
		{
			m_attrForOddRows = new GridCellAttr();
			m_attrForOddRows.BackgroundColour = Colour.wxLIGHT_GREY;
		}
		
		public override GridCellAttr GetAttr( int row, int col, GridCellAttr.AttrKind kind)
		{
		
			GridCellAttr attr = base.GetAttr(row, col, kind);

			if ( ( row % 2 ) > 0 )
			{
				if ( attr == null )
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
		public MyGridCellRenderer()
			: base() {}
			
		public override void Draw(Grid grid, GridCellAttr attr, DC dc, Rectangle rect, int row, int col, bool isSelected)
		{
			Draw(grid, attr, dc, rect, row, col, isSelected);
			
			dc.Pen = GDIPens.wxGREEN_PEN;
			dc.Brush = GDIBrushes.wxTRANSPARENT_BRUSH;
			dc.DrawEllipse( rect.X, rect.Y, rect.Width, rect.Height );
		}
	}
	
	//---------------------------------------------------------------------
	
	public class BigGridFrame : Frame
	{
		private Grid m_grid;
		private BigGridTable m_table;
		
		public BigGridFrame(long sizeGrid)
			: base(null, -1, "Plugin Virtual Table", wxDefaultPosition, new Size( 500, 450 ) )
		{
			m_grid = new Grid( this, -1, wxDefaultPosition, wxDefaultSize );
			m_table = new BigGridTable( sizeGrid );
			 
			m_grid.SetTable( m_table, true );
		}
	}
	
	//---------------------------------------------------------------------
	
	public class BigGridTable : GridTableBase
	{
		private long m_sizeGrid;
		
		public BigGridTable( long sizeGrid)
			: base()
		{
			m_sizeGrid = sizeGrid;
		}
		
		public override int GetNumberRows()
		{
			return (int)m_sizeGrid;
		}
		
		public override int GetNumberCols()
		{
			return (int)m_sizeGrid;
		}
		
		public override string GetValue( int row, int col )
		{
			string ret = "(" + row + ", " + col + ")";
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

	public class GridApp : wx.App
	{
		public override bool OnInit()
		{
			GridFrame frame = new GridFrame();
			frame.Show( true );

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main()
		{
			GridApp app = new GridApp();
			app.Run();
		}
	}	
}
