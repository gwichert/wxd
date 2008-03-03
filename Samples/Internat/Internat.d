//-----------------------------------------------------------------------------
// wxD/Samples - Internat.d
//
// A wxD version of the wxWidgets "internat" sample.
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

	public class MyFrame : Frame
	{
		enum Cmd
		{ 
			About, 
			Quit, 
			Dialog,
			INTERNAT_TEXT,
    			INTERNAT_TEST,
    			INTERNAT_TEST_1,
    			INTERNAT_TEST_2,
    			INTERNAT_TEST_3,
    			INTERNAT_OPEN 
		}
		
		protected Locale m_locale;

		//---------------------------------------------------------------------

		public this(Locale locale)
		{
			super( null, -1, _("International wxWidgets App") );
			m_locale = locale;
			
			// Set the window icon

			icon = new Icon("../Samples/Internat/mondrian.png");

			// Set up a menu

			Menu fileMenu = new Menu();
			fileMenu.AppendWL( Cmd.About, _("&About..."), &OnAbout) ;
			fileMenu.AppendSeparator();
			fileMenu.AppendWL( Cmd.Quit, _("E&xit"), &OnQuit) ;

			MenuBar menuBar = new MenuBar();
			menuBar.Append( fileMenu, _("&File") );

			this.menuBar = menuBar;
		}

		//---------------------------------------------------------------------

		public void OnQuit(Object sender, Event e)
		{
			Close();
		}

		//---------------------------------------------------------------------

		public void OnAbout(Object sender, Event e)
		{
			string locale = m_locale.GetLocale();
			string sysname = m_locale.SysName;
			string canname = m_locale.CanonicalName;
			
			string localeInfo = std.string.format( _("Language: %s\nSystem locale name:\n%s\nCanonical locale name: %s\n"),
					locale, sysname, canname );
		
			string msg = _("I18n sample\n(c) 1998, 1999 Vadim Zeitlin and Julian Smart");
			msg ~= _("\nPorted 2005 to wxD by BERO\n\n");
			msg ~= localeInfo;
			MessageBox(this, msg, _("About Internat"), Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}
	}



	public class Internat : App
	{
		public static Language[] langIds =
		[
			Language.wxLANGUAGE_DEFAULT,
			Language.wxLANGUAGE_FRENCH,
			Language.wxLANGUAGE_GERMAN,
			Language.wxLANGUAGE_RUSSIAN,
			Language.wxLANGUAGE_BULGARIAN,
			Language.wxLANGUAGE_CZECH,
			Language.wxLANGUAGE_POLISH,
			Language.wxLANGUAGE_JAPANESE,
			Language.wxLANGUAGE_GEORGIAN,
			Language.wxLANGUAGE_ENGLISH,
			Language.wxLANGUAGE_ENGLISH_US
		];
	
		protected Locale m_locale;
		
		public string[] st_args;
	
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			m_locale = new Locale();

			int lng = -1;
			
			if ( st_args.length == 1 )
			{
				lng = atoi( st_args[0] );
			}
			
			if ( lng == -1 )
			{
				string[] langNames =
				[
					"System default",
					"French",
					"German",
					"Russian",
					"Bulgarian",
					"Czech",
					"Polish",
					"Japanese",
					"Georgian",
					"English",
					"English (U.S.)"
				];
				
				lng = GetSingleChoiceIndex( _("Please choose language:"), _("Language"), langNames );
			}
			
			if ( lng != -1 )
				m_locale.Init(langIds[lng]);
				
			if (m_locale.AddCatalog( "../Samples/Internat/internat" )) {}
		
			MyFrame frame = new MyFrame(m_locale);
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		
		static void Main( string[] args )
		{
			Internat app = new Internat();
			app.st_args = args;
			app.Run();
		}

		//---------------------------------------------------------------------
	}


void main(string[] args)
{
	Internat.Main(args);
}
