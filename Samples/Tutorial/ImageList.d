
import wx.wx;

    /**
     * Class to display a list of images.  The scrolled window helps us with
     * managing scrollbars when the window's contents are too large to be
     * displayed.
     */
    public class ImageList : ScrolledWindow
    {
        private ImageViewer m_viewer;

        /**
         * Sets up the image list.
         *
         * The base class is initialized with a default window position,
         * and a static size of width = 150, The '-1' for height means that
         * the height of the window is unconstrained.
         */
        public this(Window parent, ImageViewer viewer)
        {
            super(parent, -1, wxDefaultPosition, Size(140, -1));
            m_viewer = viewer;

            // A flex grid sizer will be used to align the images horizontally.
            // This is used, because the flex grid allows for entries to be
            // of various sizes.
            FlexGridSizer sizer = new FlexGridSizer(1, 0, 0);

            // For now, our sizer will remain empty until images are loaded.

            Sizer = sizer;

            // Initialize the scrollbars
            SetScrollbars(0, 1, 0, 0);
        }

        /**
         * Lists the images in the given list of image file names.
         */
        public void ListImages(string[] images)
        {
            // Clear our list
            ClearImages();

            // Add the images
		    Console.WriteLine("Adding images ...");
            foreach(string imageFile in images) {

				Console.WriteLine("   + " ~ imageFile);
                // Create a thumbnail will display the image
                Thumbnail thumb = new Thumbnail(this, imageFile);
                
                // Hook in our event handler
                thumb.ThumbnailClicked = 
                    new Thumbnail.ThumbnailClick(OnThumbnailClicked);

                // Add the bitmap button to the sizer.
                Sizer.Add(thumb, 1, Stretch.wxEXPAND);

                // A horizontal static line is used to help seperate the 
                // images in the list.
                StaticLine line = new StaticLine(this, -1, wxDefaultPosition, 
                                                 wxDefaultSize, 
                                                 StaticLine.wxLI_HORIZONTAL);

                // The static line is added with a small border on the bottom
                Sizer.Add(line, 0, Stretch.wxEXPAND | Direction.wxBOTTOM, 3);

                // Fit inside tells the scrolled window to reset the scrollbars,
                // so that the entire window's contents can be scrolled.
                FitInside();
            }

            m_viewer.Bitmap = null;
        }

        /**
         * Clear all the images in the list.
         */
        private void ClearImages()
        {
            // This will remove all the windows (images) that are in the sizer.
            // 
            // The 'true' parameter tells the sizer to delete the windows as
            // well.  If 'false' were given, we would have to manually do 
            // this.
            Sizer.Clear(true);

            System.GC.Collect();
        }

        public void OnThumbnailClicked(string fileName, Bitmap bmp)
        {
            m_viewer.Bitmap = bmp;

            // Set the main frame's title
            Parent.Parent.Title = fileName;
        }
    }
