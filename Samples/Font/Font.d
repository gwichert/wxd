//-----------------------------------------------------------------------------
// wxD/Samples - Font.d
//
// wxD "Font" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// Modified by BERO <berobero@users.sourceforge.net>
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

import wx.wx;
private import std.stream;
private import std.string;
alias std.string.find indexOf;

	public class MyCanvas : Window
	{
		private Colour m_colour;
		private Font m_font;
		
		//---------------------------------------------------------------------
		
		public this( Window parent )
		{
			super( parent );
			m_colour = Colour.wxRED;
			m_font = Font.wxNORMAL_FONT;
			
			EVT_PAINT( & OnPaint ) ;
		}
		
		//---------------------------------------------------------------------
		
		public Font TextFont() { return m_font; }
		public void TextFont(Font value) { m_font = value; }
		
		//---------------------------------------------------------------------
		
		public Colour colour() { return m_colour; }
		public void   colour(Colour value) { m_colour = value; }
		
		//---------------------------------------------------------------------
		
		public void OnPaint( Object sender, Event e )
		{
			PaintDC dc = new PaintDC( this );
			PrepareDC( dc );
			
			dc.Background = new Brush( "white",FillStyle.wxSOLID );
			dc.Clear();
			
			int hLine = dc.CharHeight;
			
			int x = 5;
			int y = 5;
			
			string fontinfo = "Font size is " ~ .toString(m_font.PointSize) ~ " points, family: " ~
				.toString(m_font.FamilyString.ptr) ~ ", encoding: " ~ FontMapper.GetEncodingDescription( m_font.Encoding );
				
			dc.DrawText( fontinfo, x, y );
			y += hLine;
			
			fontinfo = "Style: " ~ m_font.StyleString ~ ", weight: " ~ m_font.WeightString ~
				", fixed width: " ~ (m_font.IsFixedWidth ? "yes" : "no");
				
			dc.DrawText( fontinfo, x, y );
			y += hLine;
			
			if ( m_font.Ok )
			{
				IntPtr info = m_font.NativeFontInfo;
				if ( info != IntPtr.init )
				{
					string fontDesc = m_font.NativeFontInfoUserDesc;
					fontinfo = "Native font info: " ~ fontDesc;
					
					dc.DrawText( fontinfo, x, y );
					y += hLine;
				}
			}
			
			y += hLine;
			
			dc.font = m_font;
			dc.TextForeground = m_colour;
			
			int maxCharWidth;
			int maxCharHeight;
			
			dc.GetTextExtent( "W", maxCharWidth, maxCharHeight );
			
			int w = maxCharWidth + 5;
			int h = maxCharHeight + 4;
			
			for ( int i = 0; i < 7; i++)
			{
				for ( int j = 0; j < 32; j++ )
				{
					char c = cast(char)( 32 * ( i + 1 ) + j );
					
					int charWidth;
					int charHeight;
					
					string s = .toString(c);
					dc.GetTextExtent( s, charWidth, charHeight );
					dc.DrawText( 
						s, 
						x + w * j + ( maxCharWidth - charWidth ) / 2 + 1, 
						y + h * i + ( maxCharHeight - charHeight ) / 2 
					);
				}
			}
			
			dc.pen = new Pen( new Colour( "blue" ), 1, FillStyle.wxSOLID );
			
			int l;
			
			for ( l = 0; l < 8; l++ )
			{
				int yl = y + h * l - 2;
				dc.DrawLine( x - 2, yl, x + 32 * w - 1, yl );
			}
			
			for ( l = 0; l < 33; l++ )
			{
				int xl = x + w * l - 2;
				dc.DrawLine( xl, y - 2, xl, y + 7 * h - 1 );
			}
			
			dc.Dispose(); //needed
		}
	}
	
	//---------------------------------------------------------------------
	
	public class FontFrame : Frame
	{
		enum Cmd { Font_Quit, Font_About, Font_ViewMsg, Font_IncSize, Font_DecSize, Font_Bold,
			Font_Italic, Font_Underlined, Font_wxNORMAL_FONT, Font_wxSMALL_FONT, Font_wxITALIC_FONT,
			Font_wxSWISS_FONT, Font_Choose, Font_EnumFamiliesForEncoding, Font_EnumFamilies,
			Font_EnumFixedFamilies, Font_EnumEncodings, Font_CheckNativeToFromString, Font_Max }
		
		//---------------------------------------------------------------------
		
		protected int m_fontSize;
		
		protected TextCtrl m_textctrl;
		protected MyCanvas m_canvas;
		
		public static string s_dir="";
		public static string s_file="";
		
		//---------------------------------------------------------------------
	
		public this( string title, Point pos, Size size )
		{
			super( title, pos, size );
			icon = new Icon( "../Samples/Font/mondrian.png" );
			
			m_fontSize = 12;
			
			Menu menuFile = new Menu();
			menuFile.Append( Cmd.Font_ViewMsg, "&View...\tCtrl-V", "View an email message file" );
			menuFile.AppendSeparator();
			menuFile.Append( Cmd.Font_About, "&About...\tCtrl-A", "Show about dialog" );
			menuFile.AppendSeparator();
			menuFile.Append( Cmd.Font_Quit, "E&xit\tAlt-X", "Quit this program" );
			
			Menu menuFont = new Menu();
			menuFont.Append( Cmd.Font_IncSize, "&Increase font size by 2 points\tCtrl-I" );
			menuFont.Append( Cmd.Font_DecSize, "&Decrease font size by 2 points\tCtrl-D" );
			menuFont.AppendSeparator();
			menuFont.AppendCheckItem( Cmd.Font_Bold, "&Bold\tCtrl-B", "Toggle bold state" );
			menuFont.AppendCheckItem( Cmd.Font_Italic, "&Oblique\tCtrl-O", "Toggle italic state" );
			menuFont.AppendCheckItem( Cmd.Font_Underlined, "&Underlined\tCtrl-U", "Toggle underlined state" );
			
			menuFont.AppendSeparator();
			menuFont.Append( Cmd.Font_CheckNativeToFromString, "Check Native Font Info To/From String" );
			
			Menu menuSelect = new Menu();
			menuSelect.Append( Cmd.Font_Choose, "&Select font...\tCtrl-S", "Select a standard font" );
			
			Menu menuStdFonts = new Menu();
			menuStdFonts.Append( Cmd.Font_wxNORMAL_FONT, "wxNORMAL_FONT", "Normal font used by wxWidgets" );
			menuStdFonts.Append( Cmd.Font_wxSMALL_FONT,  "wxSMALL_FONT",  "Small font used by wxWidgets" );
			menuStdFonts.Append( Cmd.Font_wxITALIC_FONT, "wxITALIC_FONT", "Italic font used by wxWidgets" );
			menuStdFonts.Append( Cmd.Font_wxSWISS_FONT,  "wxSWISS_FONT",  "Swiss font used by wxWidgets" );
			menuSelect.Append(-2, "Standar&d fonts", menuStdFonts, "" );

			menuSelect.AppendSeparator();
			menuSelect.Append( Cmd.Font_EnumFamilies, "Enumerate font &families\tCtrl-F" );
			menuSelect.Append( Cmd.Font_EnumFixedFamilies, "Enumerate fi&xed font families\tCtrl-X" );
			menuSelect.Append( Cmd.Font_EnumEncodings, "Enumerate &encodings\tCtrl-E" );
			menuSelect.Append( Cmd.Font_EnumFamiliesForEncoding, "Find font for en&coding...\tCtrl-C", "Find font families for given encoding" );
			
			MenuBar menuBar = new MenuBar();
			menuBar.Append( menuFile, "&File" );
			menuBar.Append( menuFont, "F&ont" );
			menuBar.Append( menuSelect, "&Select" );
			
			this.menuBar = menuBar;
			
			SplitterWindow splitter = new SplitterWindow( this );
			
			m_textctrl = new TextCtrl( splitter, -1, 
				"Paste text here to see how it looks\nlike in the given font",
				wxDefaultPosition, wxDefaultSize,
				TextCtrl.wxTE_MULTILINE );
			
			m_canvas = new MyCanvas( splitter );
			
			splitter.SplitHorizontally( m_textctrl, m_canvas, 100 );
			
			CreateStatusBar();
			StatusText = "Welcome to wxWidgets font demo!";	
			
			EVT_MENU( Cmd.Font_Quit,  & OnQuit ) ;
			EVT_MENU( Cmd.Font_ViewMsg, & OnViewMsg ) ;
			EVT_MENU( Cmd.Font_About, & OnAbout ) ;

			EVT_MENU( Cmd.Font_IncSize, & OnIncFont ) ;
			EVT_MENU( Cmd.Font_DecSize, & OnDecFont ) ;
			EVT_MENU( Cmd.Font_Bold, & OnBold ) ;
			EVT_MENU( Cmd.Font_Italic, & OnItalic ) ;
			EVT_MENU( Cmd.Font_Underlined, & OnUnderline ) ;

			EVT_MENU( Cmd.Font_wxNORMAL_FONT, & OnwxPointerFont ) ;
			EVT_MENU( Cmd.Font_wxSMALL_FONT, & OnwxPointerFont ) ;
			EVT_MENU( Cmd.Font_wxITALIC_FONT, & OnwxPointerFont ) ;
			EVT_MENU( Cmd.Font_wxSWISS_FONT, & OnwxPointerFont ) ;

			EVT_MENU( Cmd.Font_CheckNativeToFromString, & OnCheckNativeToFromString ) ;

			EVT_MENU( Cmd.Font_Choose, & OnSelectFont ) ;
			EVT_MENU( Cmd.Font_EnumFamiliesForEncoding, & OnEnumerateFamiliesForEncoding ) ;
			EVT_MENU( Cmd.Font_EnumFamilies, & OnEnumerateFamilies ) ;
			EVT_MENU( Cmd.Font_EnumFixedFamilies, & OnEnumerateFixedFamilies ) ;
			EVT_MENU( Cmd.Font_EnumEncodings, & OnEnumerateEncodings ) ;
		}
		
		//---------------------------------------------------------------------
		
		public void OnQuit( Object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnViewMsg( Object sender, Event e )
		{
			FileDialog dialog = new FileDialog( this, "Open an email message file", s_dir, s_file, "*" );
			if ( dialog.ShowModal() != wxID_OK ) return;
			
			s_dir = dialog.Directory;
			s_file = dialog.Filename;
			
			string filename = dialog.Path;
			string message;

			try
			{
				message = cast(string)std.file.read(filename);
			}
			catch (Exception ex)
			{
				return;
			}
						
			string charset;
			
			string prefix = "Content-Type: text/plain; charset=";
			
			int pos = message.indexOf( prefix );
			
			if ( pos == -1 )
			{
				Log.LogError( "The file '%s' doesn't contain charset information.", filename );
				return;
			}
			
			pos += prefix.length + 1; 
			
			int pos2 = pos;
			
			while ( message[pos2] != '"' )
			{
				pos2++;
			}
						
			charset = message[pos..pos2];
			
			FontEncoding fontenc = FontMapper.Get.CharsetToEncoding( charset );
			if ( fontenc == FontEncoding.wxFONTENCODING_SYSTEM )
			{
				Log.LogError( "Charset '{0}' is unsupported.", charset );
				return;
			}
			
			m_textctrl.LoadFile( filename );
			
			if ( fontenc == FontEncoding.wxFONTENCODING_UTF8 || 
				!FontMapper.Get.IsEncodingAvailable(fontenc) )
			{
				FontEncoding encAlt;
				if ( FontMapper.Get.GetAltForEncoding( fontenc, encAlt ) )
				{
					EncodingConverter conv = new EncodingConverter();
					
					if ( conv.Init( fontenc, encAlt ) )
					{
						fontenc = encAlt;
						m_textctrl.Value = conv.Convert( m_textctrl.Value );
					}
					else
					{
						Log.LogWarning( "Cannot convert from '{0}' to '{1}'.",
							FontMapper.GetEncodingDescription( fontenc ),
							FontMapper.GetEncodingDescription( encAlt ) );
					}
				}
				else
				{
					Log.LogWarning( "No fonts for encoding '{0}' on this system.",
						FontMapper.GetEncodingDescription( fontenc ) );
				}
			}
			
			if ( !DoEnumerateFamilies( false, fontenc, true ) )
			{
				Font font = new Font( 12, FontFamily.wxDEFAULT, FontStyle.wxNORMAL,
					FontWeight.wxNORMAL, false, "", fontenc );
				
				if ( font.Ok )
				{
					DoChangeFont( font );
				}
				else
				{
					Log.LogWarning( "No fonts for encoding '{0}' on this system.",
						FontMapper.GetEncodingDescription( fontenc ) );
				}
			}
		}		
		
		//---------------------------------------------------------------------
		
		public void OnAbout( Object sender, Event e )
		{
			MessageBox( this, "wxWidgets font demo\n(c) 1999 Vadim Zeitlin\nPorted to wxD by BERO",
				"About Font", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnIncFont( Object sender, Event e )
		{
			DoResizeFont( +2 ); 
		}		
		
		//---------------------------------------------------------------------
		
		public void OnDecFont( Object sender, Event e )
		{
			DoResizeFont( -2 );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnBold( Object sender, Event e )
		{
			CommandEvent ce = cast(CommandEvent) e;
			Font font = m_canvas.TextFont;
			
			font.Weight = ce.IsChecked ? FontWeight.wxBOLD : FontWeight.wxNORMAL ;
			DoChangeFont( font );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnItalic( Object sender, Event e )
		{
			CommandEvent ce = cast(CommandEvent) e;
			Font font = m_canvas.TextFont;
			
			font.Style = ce.IsChecked ? FontStyle.wxITALIC : FontStyle.wxNORMAL ;
			DoChangeFont( font );
		}
		
		//---------------------------------------------------------------------
		
		public void OnUnderline( Object sender, Event e )
		{
			CommandEvent ce = cast(CommandEvent) e;
			Font font = m_canvas.TextFont;
			
			font.Underlined = ce.IsChecked;
			DoChangeFont( font );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnwxPointerFont( Object sender, Event e )
		{
			Font font;
			
			switch ( e.ID )
			{
				case Cmd.Font_wxNORMAL_FONT : font = Font.wxNORMAL_FONT; break;
				case Cmd.Font_wxSMALL_FONT : font = Font.wxSMALL_FONT; break;
				case Cmd.Font_wxITALIC_FONT : font = Font.wxITALIC_FONT; break;
				case Cmd.Font_wxSWISS_FONT : font = Font.wxSWISS_FONT; break;
				default : font = Font.wxNORMAL_FONT; break;
			}
			
			menuBar.Check( Cmd.Font_Bold, false );
			menuBar.Check( Cmd.Font_Italic, false );
			menuBar.Check( Cmd.Font_Underlined, false );
			
			DoChangeFont( font );
		}
		
		//---------------------------------------------------------------------
		
		public void OnCheckNativeToFromString( Object sender, Event e )
		{
			string fontinfo = m_canvas.TextFont.NativeFontInfoDesc;
			
			if ( fontinfo.length == 0 )
			{
				Log.LogError( "Native font info string is empty!" );
			}
			else
			{
				Font font = Font.New( fontinfo );
				if ( fontinfo != font.NativeFontInfoDesc )
					Log.LogError( "wxNativeFontInfo toString()/FromString() broken!" );
				else
					Log.LogMessage( "wxNativeFontInfo works: " ~ fontinfo );
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelectFont( Object sender, Event e )
		{
			FontData data = new FontData();
			data.InitialFont = m_canvas.TextFont;
			data.colour = m_canvas.colour;
			
			FontDialog dialog = new FontDialog( this, data );
			if ( dialog.ShowModal() == wxID_OK )
			{
				FontData refData = dialog.fontData;
				Font font = refData.ChosenFont;
				Colour colour = refData.colour;
				
				DoChangeFont( font, colour );
				
				menuBar.Check( Cmd.Font_Bold, font.Weight == FontWeight.wxBOLD );
				menuBar.Check( Cmd.Font_Italic, font.Style == FontStyle.wxITALIC );
				menuBar.Check( Cmd.Font_Underlined, font.Underlined );
			}
		}		
		
		//---------------------------------------------------------------------
		
		public void OnEnumerateFamiliesForEncoding( Object sender, Event e )
		{
			 const FontEncoding[] encodings = 
			 [
				FontEncoding.wxFONTENCODING_ISO8859_1,
				FontEncoding.wxFONTENCODING_ISO8859_2,
				FontEncoding.wxFONTENCODING_ISO8859_5,
				FontEncoding.wxFONTENCODING_ISO8859_7,
				FontEncoding.wxFONTENCODING_ISO8859_15,
				FontEncoding.wxFONTENCODING_KOI8,
				FontEncoding.wxFONTENCODING_CP1250,
				FontEncoding.wxFONTENCODING_CP1251,
				FontEncoding.wxFONTENCODING_CP1252,
			];
			
			 string[] encodingNames =
			 [
				"Western European (ISO-8859-1)",
				"Central European (ISO-8859-2)",
				"Cyrillic (ISO-8859-5)",
				"Greek (ISO-8859-7)",
				"Western European with Euro (ISO-8859-15)",
				"KOI8-R",
				"Windows Central European (CP 1250)",
				"Windows Cyrillic (CP 1251)",
				"Windows Western European (CP 1252)",
			];
			
			string result = GetSingleChoice( "Choose an encoding", "Font demo", encodingNames );

			int n = -1;
			for ( int i = 0; i < encodingNames.length; i++ )
				if ( encodingNames[i] == result )
					{
						n = i;
						break;
					}
					
			if ( n != -1 )
			{
				DoEnumerateFamilies( false, encodings[n] );
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnEnumerateFamilies( Object sender, Event e )
		{
			DoEnumerateFamilies( false );
		}
		
		//---------------------------------------------------------------------
		
		public void OnEnumerateFixedFamilies( Object sender, Event e )
		{
			DoEnumerateFamilies( true );
		}
		
		//---------------------------------------------------------------------
		
		public void OnEnumerateEncodings( Object sender, Event e )
		{
			MyEncodingEnumerator fontEnumerator = new MyEncodingEnumerator();
			
			fontEnumerator.EnumerateEncodings("");
			
			Log.LogMessage( "Enumerating all available encodings:\n{0}", fontEnumerator.Text );
		}		
		
		//---------------------------------------------------------------------
		
		protected bool DoEnumerateFamilies( bool fixedWidthOnly )
		{
			return DoEnumerateFamilies( fixedWidthOnly, FontEncoding.wxFONTENCODING_SYSTEM, false );
		}
		
		protected bool DoEnumerateFamilies( bool fixedWidthOnly, FontEncoding encoding )
		{
			return DoEnumerateFamilies( fixedWidthOnly, encoding, false );
		}
		
		protected bool DoEnumerateFamilies( bool fixedWidthOnly, FontEncoding encoding, bool silent)
		{
			MyFontEnumerator fontEnumerator = new MyFontEnumerator();
			
			fontEnumerator.EnumerateFacenames( encoding, fixedWidthOnly );
			
			if ( fontEnumerator.GotAny )
			{
				int nFacenames = fontEnumerator.Facenames.length;
				if ( !silent )
				{
					Log.LogStatus( "Found {0} {1}fonts", nFacenames, 
						fixedWidthOnly ? "fixed width" : "" );
				}
				
				string facename;
				if ( silent) 
				{
					facename = fontEnumerator.Facenames[0];
				}
				else
				{
					string[] facenames = new string[nFacenames];
					int n;
					for ( n = 0; n < nFacenames; n++ )
						facenames[n] = fontEnumerator.Facenames[n];
						
					facename = GetSingleChoice( "Choose a facename", "Font demo", facenames );
					/*for ( int i = 0; i < facenames.length; i ++ )
						if ( facenames[i].Equals( result ) )
							{
								n = i;
								break;
							}
					
					if ( n != -1 )
						facename = facename[n];*/
				}
				
				if ( !( facename.length == 0 ) )
				{
					Font font = new Font( 12, FontFamily.wxDEFAULT, FontStyle.wxNORMAL, FontWeight.wxNORMAL, false, facename, encoding );
					
					DoChangeFont( font );
				}
				
				return true;
			}
			else if ( !silent )
			{
				Log.LogWarning( "No such fonts found." );
			}
			
			return false;
		}
		
		//---------------------------------------------------------------------
		
		protected void DoResizeFont( int diff )
		{
			Font font = m_canvas.TextFont;
			
			font.PointSize = font.PointSize + diff;
			DoChangeFont( font );
		}
		
		//---------------------------------------------------------------------
		
		protected void DoChangeFont( Font font )
		{
			DoChangeFont( font, null );
		}
		
		protected void DoChangeFont( Font font, Colour col)
		{
			m_canvas.TextFont = font;
			if ( col )
				if ( col.Ok() )
					m_canvas.colour = col;
			m_canvas.Refresh();
			m_textctrl.font = font;
			if ( col )
				if ( col.Ok() )
					m_textctrl.ForegroundColour = col;
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyFontEnumerator : FontEnumerator
	{
		private string[] m_facenames;
		
		//---------------------------------------------------------------------
		
		public this()
		{
			super() ;
		}
		
		//---------------------------------------------------------------------
			
		public bool GotAny()
		{
			return ( m_facenames.length > 0 );
		}
		
		//---------------------------------------------------------------------
		
		public string[] Facenames()
		{
			return m_facenames;
		}
		 
		//---------------------------------------------------------------------
		
		public override bool OnFacename( string facename )
		{ 
			version (D_Version2)
			m_facenames ~= facename.idup;
			else
			m_facenames ~= facename.dup;
			return true;
		}
		
	}
	
	//---------------------------------------------------------------------
	
	public class MyEncodingEnumerator : FontEnumerator
	{
		private int m_n;
		private string m_text;
		
		//---------------------------------------------------------------------	
		
		public this()
			
			{ super(); }
		//---------------------------------------------------------------------	
			
		public string Text()
		{
			return m_text;
		}
		
		//---------------------------------------------------------------------	
		 
		public override bool OnFontEncoding( string facename, 
			string encoding )
		{
			string text = "Encoding " ~ .toString(++m_n) ~ ": " ~ encoding ~ " (available in facename '" ~ facename ~ "')\n";
			
			m_text ~= text;
			return true;
		}
	}
	
	//---------------------------------------------------------------------	

	public class FONT : App
	{
		public override bool OnInit()
		{
			FontFrame frame = new FontFrame( "Font wxWidgets App", Point( 50, 50 ), Size( 600,400 ) );
			frame.Show( true );
			
			return true;
		}

	//---------------------------------------------------------------------
	
		
		static void Main()
		{
			FONT app = new FONT();
			app.Run();
		}
	}	


void main()
{
	FONT.Main();
}
