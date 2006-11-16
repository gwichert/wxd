//-----------------------------------------------------------------------------
// wx.NET/Samples - Internat.cs
//
// A wx.NET version of the wxWidgets "internat" sample.
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
	public class MyFrame : wx.Frame
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

		public MyFrame(Locale locale)
			: base( null, -1, _("International wxWidgets App") )
		{
			m_locale = locale;
			
			// Set the window icon

			Icon = new wx.Icon("../Samples/Internat/mondrian.png");

			// Set up a menu

			Menu fileMenu = new Menu();
			fileMenu.AppendWL( (int)Cmd.About, _("&About..."), new EventListener(OnAbout) );
			fileMenu.AppendSeparator();
			fileMenu.AppendWL( (int)Cmd.Quit, _("E&xit"), new EventListener(OnQuit) );

			wx.MenuBar menuBar = new wx.MenuBar();
			menuBar.Append( fileMenu, _("&File") );

			MenuBar = menuBar;
		}

		//---------------------------------------------------------------------

		public void OnQuit(object sender, Event e)
		{
			Close();
		}

		//---------------------------------------------------------------------

		public void OnAbout(object sender, Event e)
		{
			string locale = m_locale.GetLocale();
			string sysname = m_locale.SysName;
			string canname = m_locale.CanonicalName;
			
			string localeInfo = String.Format( _("Language: {0}\nSystem locale name:\n{1}\nCanonical locale name: {2}\n"),
					locale, sysname, canname );
		
			string msg = _("I18n sample\n(c) 1998, 1999 Vadim Zeitlin and Julian Smart");
			msg += _("\nPorted 2004 to wx.NET by Alexander Olk\n\n");
			msg += localeInfo;
			MessageDialog.ShowModal(this, msg, _("About Internat"), Dialog.wxOK | Dialog.wxICON_INFORMATION);
		}
	}



	public class Internat : wx.App
	{
		public static Language[] langIds =
		{
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
		};
	
		protected Locale m_locale = new Locale();
		
		public string[] st_args;
	
		//---------------------------------------------------------------------

		public override bool OnInit()
		{
			int lng = -1;
			
			if ( st_args.Length == 1 )
			{
				lng = System.Convert.ToInt32( st_args[0] );
			}
			
			if ( lng == -1 )
			{
				string[] langNames =
				{
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
				};
				
				lng = Utils.GetSingleChoiceIndex( _("Please choose language:"), _("Language"), langNames );
			}
			
			if ( lng != -1 )
				m_locale.Init(langIds[lng]);
				
			if (m_locale.AddCatalog( "../Samples/Internat/internat" ));
		
			MyFrame frame = new MyFrame(m_locale);
			frame.Show(true);

			return true;
		}

		//---------------------------------------------------------------------

		[STAThread]
		static void Main( string[] args )
		{
			Internat app = new Internat();
			app.st_args = args;
			app.Run();
		}

		//---------------------------------------------------------------------
	}
}
