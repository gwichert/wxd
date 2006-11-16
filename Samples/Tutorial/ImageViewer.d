
import wx.wx;

    /**
     * A class to view an image.
     *
     * A scrolled window is used so that large images can be viewed.
     */
    public class ImageViewer : ScrolledWindow
    {
        private Bitmap m_bitmap, m_defaultBmp;

        public this(Window parent)
        {
            super(parent);
            // Load a default image (logo)
            m_defaultBmp = new Bitmap("../Samples/Tutorial/ImageView.bmp", 
                                         BitmapType.wxBITMAP_TYPE_BMP);

            // Our panel will have a white background, the colour contructor
            // accepts strings for several common colours.
            BackgroundColour = new Colour("White");

            // Set our bitmap
            Bitmap = m_defaultBmp;
        }

        /**
         * The bitmap to be displayed.
         */
        public void bitmap(Bitmap value)
        {
                if (value == null) {
                    // Use the default
                    m_bitmap = m_defaultBmp;
                }
                else {
                    m_bitmap = value; 
                }

                // Initialize the scrollbars
                SetScrollbars(1, 1, m_bitmap.Width, m_bitmap.Height,
                              0, 0, true);

                // Redraw the window
                Refresh();
        }

        /**
         * Override the OnDraw method so we can draw the bitmap.
         */
        public override void OnDraw(DC dc)
        {
            // Draw the bitmap onto the device context
            dc.DrawBitmap(m_bitmap, 0, 0 , false);
        }
    }

