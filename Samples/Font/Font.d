//-----------------------------------------------------------------------------
// wx.NET/Samples - Font.cs
//
// wx.NET "Font" sample.
//
// Written by Alexander Olk (xenomorph2@onlinehome.de)
// (C) 2003 Alexander Olk
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.IO;
using System.Drawing;
using System.Collections;

namespace wx.Samples
{
	public class MyCanvas : Window
	{
		private Colour m_colour;
		private wx.Font m_font;
		
		//---------------------------------------------------------------------
		
		public MyCanvas( Window parent )
			: base( parent )
		{
			m_colour = Colour.wxRED;
			m_font = wx.Font.wxNORMAL_FONT;
			
			EVT_PAINT( new EventListener( OnPaint ) );
		}
		
		//---------------------------------------------------------------------
		
		public Font TextFont
		{
			get { return m_font; }
			set { m_font = value; }
		}
		
		//---------------------------------------------------------------------
		
		public Colour Colour 
		{
			get { return m_colour; }
			set { m_colour = value; }
		}
		
		//---------------------------------------------------------------------
		
		public void OnPaint( object sender, Event e )
		{
			PaintDC dc = new PaintDC( this );
			PrepareDC( dc );
			
			dc.Background = new Brush( "white",FillStyle.wxSOLID );
			dc.Clear();
			
			int hLine = dc.CharHeight;
			
			int x = 5;
			int y = 5;
			
			string fontinfo = "Font size is " + m_font.PointSize + " points, family: " +
				m_font.FamilyString + ", encoding: " + FontMapper.GetEncodingDescription( m_font.Encoding );
				
			dc.DrawText( fontinfo, x, y );
			y += hLine;
			
			fontinfo = "Style: " + m_font.StyleString + ", weight: " + m_font.WeightString +
				", fixed width: " + (m_font.IsFixedWidth ? "yes" : "no");
				
			dc.DrawText( fontinfo, x, y );
			y += hLine;
			
			if ( m_font.Ok )
			{
				IntPtr info = m_font.NativeFontInfo;
				if ( info != IntPtr.Zero )
				{
					string fontDesc = m_font.NativeFontInfoUserDesc;
					fontinfo = "Native font info: " + fontDesc;
					
					dc.DrawText( fontinfo, x, y );
					y += hLine;
				}
			}
			
			y += hLine;
			
			dc.Font = m_font;
			dc.TextForeground = m_colour;
			
			int maxCharWidth;
			int maxCharHeight;
			
			dc.GetTextExtent( "W", out maxCharWidth, out maxCharHeight );
			
			int w = maxCharWidth + 5;
			int h = maxCharHeight + 4;
			
			for ( int i = 0; i < 7; i++)
			{
				for ( int j = 0; j < 32; j++ )
				{
					char c = Convert.ToChar( 32 * ( i + 1 ) + j );
					
					int charWidth;
					int charHeight;
					
					dc.GetTextExtent( c.ToString(), out charWidth, out charHeight );
					dc.DrawText( 
						c.ToString(), 
						x + w * j + ( maxCharWidth - charWidth ) / 2 + 1, 
						y + h * i + ( maxCharHeight - charHeight ) / 2 
					);
				}
			}
			
			dc.Pen = new Pen( new Colour( "blue" ), 1, FillStyle.wxSOLID );
			
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
		
		public static string s_dir;
		public static string s_file;
		
		//---------------------------------------------------------------------
	
		public FontFrame( string title, Point pos, Size size )
			: base( title, pos, size )
		{
			Icon = new wx.Icon( "../Samples/Font/mondrian.png" );
			
			m_fontSize = 12;
			
			Menu menuFile = new Menu();
			menuFile.Append( (int)Cmd.Font_ViewMsg, "&View...\tCtrl-V", "View an email message file" );
			menuFile.AppendSeparator();
			menuFile.Append( (int)Cmd.Font_About, "&About...\tCtrl-A", "Show about dialog" );
			menuFile.AppendSeparator();
			menuFile.Append( (int)Cmd.Font_Quit, "E&xit\tAlt-X", "Quit this program" );
			
			Menu menuFont = new Menu();
			menuFont.Append( (int)Cmd.Font_IncSize, "&Increase font size by 2 points\tCtrl-I" );
			menuFont.Append( (int)Cmd.Font_DecSize, "&Decrease font size by 2 points\tCtrl-D" );
			menuFont.AppendSeparator();
			menuFont.AppendCheckItem( (int)Cmd.Font_Bold, "&Bold\tCtrl-B", "Toggle bold state" );
			menuFont.AppendCheckItem( (int)Cmd.Font_Italic, "&Oblique\tCtrl-O", "Toggle italic state" );
			menuFont.AppendCheckItem( (int)Cmd.Font_Underlined, "&Underlined\tCtrl-U", "Toggle underlined state" );
			
			menuFont.AppendSeparator();
			menuFont.Append( (int)Cmd.Font_CheckNativeToFromString, "Check Native Font Info To/From String" );
			
			Menu menuSelect = new Menu();
			menuSelect.Append( (int)Cmd.Font_Choose, "&Select font...\tCtrl-S", "Select a standard font" );
			
			Menu menuStdFonts = new Menu();
			menuStdFonts.Append( (int)Cmd.Font_wxNORMAL_FONT, "wxNORMAL_FONT", "Normal font used by wxWidgets" );
			menuStdFonts.Append( (int)Cmd.Font_wxSMALL_FONT,  "wxSMALL_FONT",  "Small font used by wxWidgets" );
			menuStdFonts.Append( (int)Cmd.Font_wxITALIC_FONT, "wxITALIC_FONT", "Italic font used by wxWidgets" );
			menuStdFonts.Append( (int)Cmd.Font_wxSWISS_FONT,  "wxSWISS_FONT",  "Swiss font used by wxWidgets" );
			menuSelect.Append(-2, "Standar&d fonts", menuStdFonts, "" );

			menuSelect.AppendSeparator();
			menuSelect.Append( (int)Cmd.Font_EnumFamilies, "Enumerate font &families\tCtrl-F" );
			menuSelect.Append( (int)Cmd.Font_EnumFixedFamilies, "Enumerate fi&xed font families\tCtrl-X" );
			menuSelect.Append( (int)Cmd.Font_EnumEncodings, "Enumerate &encodings\tCtrl-E" );
			menuSelect.Append( (int)Cmd.Font_EnumFamiliesForEncoding, "Find font for en&coding...\tCtrl-C", "Find font families for given encoding" );
			
			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append( menuFile, "&File" );
			menuBar.Append( menuFont, "F&ont" );
			menuBar.Append( menuSelect, "&Select" );
			
			MenuBar = menuBar;
			
			SplitterWindow splitter = new SplitterWindow( this );
			
			m_textctrl = new TextCtrl( splitter, -1, 
				"Paste text here to see how it looks\nlike in the given font",
				wxDefaultPosition, wxDefaultSize,
				TextCtrl.wxTE_MULTILINE );
			
			m_canvas = new MyCanvas( splitter );
			
			splitter.SplitHorizontally( m_textctrl, m_canvas, 100 );
			
			CreateStatusBar();
			StatusText = "Welcome to wxWidgets font demo!";	
			
			EVT_MENU( (int)Cmd.Font_Quit,  new EventListener( OnQuit ) );
			EVT_MENU( (int)Cmd.Font_ViewMsg, new EventListener( OnViewMsg ) );
			EVT_MENU( (int)Cmd.Font_About, new EventListener( OnAbout ) );

			EVT_MENU( (int)Cmd.Font_IncSize, new EventListener( OnIncFont ) );
			EVT_MENU( (int)Cmd.Font_DecSize, new EventListener( OnDecFont ) );
			EVT_MENU( (int)Cmd.Font_Bold, new EventListener( OnBold ) );
			EVT_MENU( (int)Cmd.Font_Italic, new EventListener( OnItalic ) );
			EVT_MENU( (int)Cmd.Font_Underlined, new EventListener( OnUnderline ) );

			EVT_MENU( (int)Cmd.Font_wxNORMAL_FONT, new EventListener( OnwxPointerFont ) );
			EVT_MENU( (int)Cmd.Font_wxSMALL_FONT, new EventListener( OnwxPointerFont ) );
			EVT_MENU( (int)Cmd.Font_wxITALIC_FONT, new EventListener( OnwxPointerFont ) );
			EVT_MENU( (int)Cmd.Font_wxSWISS_FONT, new EventListener( OnwxPointerFont ) );

			EVT_MENU( (int)Cmd.Font_CheckNativeToFromString, new EventListener( OnCheckNativeToFromString ) );

			EVT_MENU( (int)Cmd.Font_Choose, new EventListener( OnSelectFont ) );
			EVT_MENU( (int)Cmd.Font_EnumFamiliesForEncoding, new EventListener( OnEnumerateFamiliesForEncoding ) );
			EVT_MENU( (int)Cmd.Font_EnumFamilies, new EventListener( OnEnumerateFamilies ) );
			EVT_MENU( (int)Cmd.Font_EnumFixedFamilies, new EventListener( OnEnumerateFixedFamilies ) );
			EVT_MENU( (int)Cmd.Font_EnumEncodings, new EventListener( OnEnumerateEncodings ) );
		}
		
		//---------------------------------------------------------------------
		
		public void OnQuit( object sender, Event e )
		{
			Close();
		}
		
		//---------------------------------------------------------------------
		
		public void OnViewMsg( object sender, Event e )
		{
			FileDialog dialog = new FileDialog( this, "Open an email message file", s_dir, s_file, "*" );
			if ( dialog.ShowModal() != wxID_OK ) return;
			
			s_dir = dialog.Directory;
			s_file = dialog.Filename;
			
			string filename = dialog.Path;
			
			FileStream fs;
			
			try
			{
				fs = new FileStream( filename, FileMode.Open );
			}
			catch (Exception ex)
			{
				return;
			}
			
			StreamReader sr = new StreamReader( fs );
			//sr.BaseStream.Seek(0, SeekOrigin.Begin); 

			string message = sr.ReadToEnd();
			
			sr.Close();			
			
			string charset;
			
			string prefix = "Content-Type: text/plain; charset=";
			
			int pos = message.IndexOf( prefix );
			
			if ( pos == -1 )
			{
				Log.LogError( "The file '{0}' doesn't contain charset information.", filename );
				return;
			}
			
			pos += prefix.Length + 1; 
			
			int pos2 = pos;
			
			while ( !message[pos2].Equals('"') )
			{
				pos2++;
			}
			
			pos2--;
			
			charset = message.Substring( pos, pos2 - pos + 1 );
			
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
				if ( FontMapper.Get.GetAltForEncoding( fontenc, out encAlt ) )
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
		
		public void OnAbout( object sender, Event e )
		{
			wx.MessageDialog.ShowModal( this, "wxWidgets font demo\n(c) 1999 Vadim Zeitlin\nPorted to wx.NET by Alexander Olk",
				"About Font", Dialog.wxOK | Dialog.wxICON_INFORMATION );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnIncFont( object sender, Event e )
		{
			DoResizeFont( +2 ); 
		}		
		
		//---------------------------------------------------------------------
		
		public void OnDecFont( object sender, Event e )
		{
			DoResizeFont( -2 );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnBold( object sender, Event e )
		{
			CommandEvent ce = (CommandEvent) e;
			Font font = m_canvas.TextFont;
			
			font.Weight = ce.IsChecked ? FontWeight.wxBOLD : FontWeight.wxNORMAL ;
			DoChangeFont( font );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnItalic( object sender, Event e )
		{
			CommandEvent ce = (CommandEvent) e;
			Font font = m_canvas.TextFont;
			
			font.Style = ce.IsChecked ? FontStyle.wxITALIC : FontStyle.wxNORMAL ;
			DoChangeFont( font );
		}
		
		//---------------------------------------------------------------------
		
		public void OnUnderline( object sender, Event e )
		{
			CommandEvent ce = (CommandEvent) e;
			Font font = m_canvas.TextFont;
			
			font.Underlined = ce.IsChecked;
			DoChangeFont( font );
		}		
		
		//---------------------------------------------------------------------
		
		public void OnwxPointerFont( object sender, Event e )
		{
			Font font;
			
			switch ( e.ID )
			{
				case (int)Cmd.Font_wxNORMAL_FONT : font = Font.wxNORMAL_FONT; break;
				case (int)Cmd.Font_wxSMALL_FONT : font = Font.wxSMALL_FONT; break;
				case (int)Cmd.Font_wxITALIC_FONT : font = Font.wxITALIC_FONT; break;
				case (int)Cmd.Font_wxSWISS_FONT : font = Font.wxSWISS_FONT; break;
				default : font = Font.wxNORMAL_FONT; break;
			}
			
			MenuBar.Check( (int)Cmd.Font_Bold, false );
			MenuBar.Check( (int)Cmd.Font_Italic, false );
			MenuBar.Check( (int)Cmd.Font_Underlined, false );
			
			DoChangeFont( font );
		}
		
		//---------------------------------------------------------------------
		
		public void OnCheckNativeToFromString( object sender, Event e )
		{
			string fontinfo = m_canvas.TextFont.NativeFontInfoDesc;
			
			if ( fontinfo.Length == 0 )
			{
				Log.LogError( "Native font info string is empty!" );
			}
			else
			{
				Font font = Font.New( fontinfo );
				if ( !fontinfo.Equals( font.NativeFontInfoDesc ) )
					Log.LogError( "wxNativeFontInfo ToString()/FromString() broken!" );
				else
					Log.LogMessage( "wxNativeFontInfo works: {0}", fontinfo );
			}
		}
		
		//---------------------------------------------------------------------
		
		public void OnSelectFont( object sender, Event e )
		{
			FontData data = new FontData();
			data.InitialFont = m_canvas.TextFont;
			data.Colour = m_canvas.Colour;
			
			FontDialog dialog = new FontDialog( this, data );
			if ( dialog.ShowModal() == wxID_OK )
			{
				FontData refData = dialog.FontData;
				Font font = refData.ChosenFont;
				Colour colour = refData.Colour;
				
				DoChangeFont( font, colour );
				
				MenuBar.Check( (int)Cmd.Font_Bold, font.Weight == FontWeight.wxBOLD );
				MenuBar.Check( (int)Cmd.Font_Italic, font.Style == FontStyle.wxITALIC );
				MenuBar.Check( (int)Cmd.Font_Underlined, font.Underlined );
			}
		}		
		
		//---------------------------------------------------------------------
		
		public void OnEnumerateFamiliesForEncoding( object sender, Event e )
		{
			 FontEncoding[] encodings = 
			 {
				FontEncoding.wxFONTENCODING_ISO8859_1,
				FontEncoding.wxFONTENCODING_ISO8859_2,
				FontEncoding.wxFONTENCODING_ISO8859_5,
				FontEncoding.wxFONTENCODING_ISO8859_7,
				FontEncoding.wxFONTENCODING_ISO8859_15,
				FontEncoding.wxFONTENCODING_KOI8,
				FontEncoding.wxFONTENCODING_CP1250,
				FontEncoding.wxFONTENCODING_CP1251,
				FontEncoding.wxFONTENCODING_CP1252,
			};
			
			 string[] encodingNames =
			 {
				"Western European (ISO-8859-1)",
				"Central European (ISO-8859-2)",
				"Cyrillic (ISO-8859-5)",
				"Greek (ISO-8859-7)",
				"Western European with Euro (ISO-8859-15)",
				"KOI8-R",
				"Windows Central European (CP 1250)",
				"Windows Cyrillic (CP 1251)",
				"Windows Western European (CP 1252)",
			};
			
			string result = new GetSingleChoice( "Choose an encoding", "Font demo", encodingNames );

			int n = -1;
			for ( int i = 0; i < encodingNames.Length; i++ )
				if ( encodingNames[i].Equals( result ) )
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
		
		public void OnEnumerateFamilies( object sender, Event e )
		{
			DoEnumerateFamilies( false );
		}
		
		//---------------------------------------------------------------------
		
		public void OnEnumerateFixedFamilies( object sender, Event e )
		{
			DoEnumerateFamilies( true );
		}
		
		//---------------------------------------------------------------------
		
		public void OnEnumerateEncodings( object sender, Event e )
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
				int nFacenames = fontEnumerator.Facenames.Count;
				if ( !silent )
				{
					Log.LogStatus( "Found {0} {1}fonts", nFacenames, 
						fixedWidthOnly ? "fixed width" : "" );
				}
				
				string facename;
				if ( silent) 
				{
					facename = (string)fontEnumerator.Facenames[0];
				}
				else
				{
					string[] facenames = new string[nFacenames];
					int n;
					for ( n = 0; n < nFacenames; n++ )
						facenames[n] = (string)fontEnumerator.Facenames[n];
						
					facename = new GetSingleChoice( "Choose a facename", "Font demo", facenames );
					/*for ( int i = 0; i < facenames.Length; i ++ )
						if ( facenames[i].Equals( result ) )
							{
								n = i;
								break;
							}
					
					if ( n != -1 )
						facename = facename[n];*/
				}
				
				if ( !( facename.Length == 0 ) )
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
			if ( col != null )
				if ( col.Ok() )
					m_canvas.Colour = col;
			m_canvas.Refresh();
			
			m_textctrl.Font = font;
			if ( col != null )
				if ( col.Ok() )
					m_textctrl.ForegroundColour = col;
		}
	}
	
	//---------------------------------------------------------------------
	
	public class MyFontEnumerator : FontEnumerator
	{
		private ArrayList m_facenames;
		
		//---------------------------------------------------------------------
		
		public MyFontEnumerator()
			: base() 
		{
			m_facenames = new ArrayList();
		}
		
		//---------------------------------------------------------------------
			
		public bool GotAny
		{
			get { return ( m_facenames.Count > 0 ); } 
		}
		
		//---------------------------------------------------------------------
		
		public new ArrayList Facenames
		{
			get { return m_facenames; }
		}
		 
		//---------------------------------------------------------------------
		
		public override bool OnFacename( string facename )
		{ 
			m_facenames.Add( facename );
			return true;
		}
		
	}
	
	//---------------------------------------------------------------------
	
	public class MyEncodingEnumerator : FontEnumerator
	{
		private int m_n;
		private string m_text;
		
		//---------------------------------------------------------------------	
		
		public MyEncodingEnumerator()
			: base() {}
			
		//---------------------------------------------------------------------	
			
		public string Text
		{
			get { return m_text; }
		}
		
		//---------------------------------------------------------------------	
		 
		public override bool OnFontEncoding( string facename, 
			string encoding )
		{
			string text = "Encoding " + ++m_n + ": " + encoding + " (available in facename '" + facename + "')\n";
			
			m_text += text;
			return true;
		}
	}
	
	//---------------------------------------------------------------------	

	public class FONT : wx.App
	{
		public override bool OnInit()
		{
			FontFrame frame = new FontFrame( "Font wxWidgets App", new Point( 50, 50 ), new Size( 600,400 ) );
			frame.Show( true );
			
			return true;
		}

	//---------------------------------------------------------------------
	
		[STAThread]
		static void Main()
		{
			FONT app = new FONT();
			app.Run();
		}
	}	
}
