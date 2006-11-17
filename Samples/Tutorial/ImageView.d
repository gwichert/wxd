
import wx.wx;
import ImageViewer;

    /**
     * This is the application.
     */
    public class ImageViewApp : App
    {
        /**
         * The overrided OnInit is where the main form should be created and
         * shown.  Application start-up logic can also be placed here.
         */
        public override bool OnInit()
        {
            // Create the main frame
            ImageViewFrame frame = new ImageViewFrame();

            // Show it
            frame.Show(true);

            // Return true, to indicate that everything was initialized 
            // properly.
            return true;
        }

        
        public static void Main()
        {
            // Create an instance of our application class
            ImageViewApp app = new ImageViewApp();

            // Run the application
            app.Run();
        }
    }

    /**
     * This is the main frame.  All user interaction will start here.
     */
    public class ImageViewFrame : Frame
    {
        // Every control that we want to handle events for will need an 
        // integer ID, these IDs are listed below.

        // File menu IDs
        private const int ID_FileOpenDir    = 1;
        private const int ID_FileExit       = 2;

        // Help menu IDs
        private const int ID_HelpAbout      = 3;

        // String to hold the directory we're browsing
        private string m_directory = "";

        // The image list
        private ImageList m_list;

        // The image viewer
        private ImageViewer m_viewer;

        /**
         * The base class is passed the title of the frame, the default 
         * position for its position, and an arbitrary size.
         *
         * All the components inside the frame are created and initialized 
         * here.
         */
        public this()
        {
            super("ImageView", wxDefaultPosition, Size(500, 500));
            // The menu bar is the bar where all the menus will be attached 
            // to.
            MenuBar menuBar = new MenuBar();

            // The File menu
            Menu fileMenu = new Menu();

            // The first item we append is the "Open" command.  The ID for 
            // the menu item is passed, as cast(two)well strings.
            //
            // The first string is the menu item text.  The stuff after '\t'
            // tells wxWidgets to use cast(a)this short-cut key for the item.
            // An '&' will underline the next character on the menu, for 
            // easy access.
            //
            // The second string is the help text for the menu item.  When a
            // users mouse hovers over the item, the status bar text will
            // change to this.
            fileMenu.Append(ID_FileOpenDir, "&Open Directory...\tCtrl+O",
                            "Open a directory with images");

            // Append a menu seperator.
            fileMenu.AppendSeparator();

            // Exit menu item.
            fileMenu.Append(ID_FileExit, "E&xit\tCtrl+Shift+W", 
                            "Exit this fine application");

            // Attach the file menu to the menu bar
            menuBar.Append(fileMenu, "&File");

            // The Help menu
            Menu helpMenu = new Menu();

            helpMenu.Append(ID_HelpAbout, "&About...",
                            "About this application");

            menuBar.Append(helpMenu, "&Help");

            // Next we tell the frame to use the menu bar that we've created, 
            // using the Frame.MenuBar property.
            this.menuBar = menuBar;

            // Create a status bar with 2 fields
            CreateStatusBar(2);

            // Set the initial status bar text, this will set the text in the 
            // first status bar field.
            StatusText = "Welcome to ImageView!";

            // The splitter window allows two child windows to be displayed
            // with a bar between them.
            //
            // When there is only one child in a Frame, the child will fill
            // that frame, hence we don't need a sizer in this frame.
            SplitterWindow split = new SplitterWindow(this, -1);

            // Create the image viewing control
            m_viewer = new ImageViewer(split);

            // Create our image list
            m_list = new ImageList(split, m_viewer);

            // We now split the window with the two children
            split.SplitVertically(m_list, m_viewer, 150);

            // Set some event handlers using the IDs of the controls we 
            // wish to handle events for.
            EVT_MENU(ID_FileExit,           &OnFileExit);
            EVT_MENU(ID_FileOpenDir,        &OnFileOpenDir);

            EVT_MENU(ID_HelpAbout,          &OnHelpAbout);

            // Handle when the frame is closed
            EVT_CLOSE(&OnClose);
        }

        /**
         * Exit event handler
         */
        protected void OnFileExit(Object sender, Event evt)
        {
            // Close the frame.  Since this is the last (only) frame in the
            // application, the application will exit when it is closed.

            Close();
        }

	static string[] GetFiles(string path,string ext)
	{
		string[] result;
	
		//note: buggy
		bool listing(char[] filename)
		{
			if (std.string.find(filename,ext)>=0)
				result ~= filename;
			return true;
		}
		
		std.file.listdir(path,&listing);
		return result;
	}

        /**
         * Open Directory event handler
         */
        protected void OnFileOpenDir(Object sender, Event evt)
        {
            DirDialog dlg = new DirDialog(this, "Choose an image directory",
                                          m_directory);

            if (dlg.ShowModal() == Dialog.wxID_OK) {
                m_directory = dlg.Path;

                // List the images. GetFiles is not very powerful: it is
				// limited to a DOS-like wildcard match. So in our case 
				// this is case sensitive on UN*X.
                string[] files = GetFiles(m_directory, ".jpg");
                m_list.ListImages(files);

                Title = dlg.Path;
            }
        }

        /**
         * About event handler
         */
        protected void OnHelpAbout(Object sender, Event evt)
        {
            // Message for our about dialog.
            string msg = "ImageView!\n\nAn application for viewing images.";

            // Display a message box.  The message box will have an OK button
            // (wxOK), and an information icon (wxICON_INFORMATION)
            MessageBoxl(this, msg, "About ImageView", 
                                    Dialog.wxOK | Dialog.wxICON_INFORMATION);
        }

        protected void OnClose(Object sender, Event evt)
        {
            // We can ask the user whether or not it is OK to close the frame,
            // then act appropriately.

            string msg = "Are you sure you'd like to exit?";

            int result = MessageBox(this, msg, "Exit ImageView",
                                                 Dialog.wxYES_NO |
                                                 Dialog.wxICON_QUESTION);

            // Did the user click yes?
            if (result == Dialog.wxYES) {
                // They did, we tell wxWidgets to take care of closing the
                // application
                evt.Skip();
            }
        }

        /**
         * Override the base Title, since we want to add some more intelligent
         * behaviour.
         */
        public override void Title(string value)
        {
                string title = "ImageView";

                if (value != "")
                    title ~= " (" ~ value + ")";

                super.Title = title;
        }
    }


void main()
{
	ImageViewApp.Main();
}
