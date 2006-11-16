
using wx;
using System;
using System.Drawing;

namespace ImageView
{
    /**
     * Class to display a thumbnail image.
     */
    public class Thumbnail : Panel, IDisposable
    {
        // Delegate to handle thumnail events
        public delegate void ThumbnailClick(string file, wx.Bitmap bmp);

        // Delegate for external classes to hook into click events
        public ThumbnailClick ThumbnailClicked;

        // The bitmap on this thumbnail
        private wx.Bitmap m_bitmap;
        
        // Filename of the bitmap to use
        private string m_fileName;

        // A bitmap button used to display the image
        private BitmapButton m_bitmapBtn;

        // A text label for the file name
        private StaticText m_label;

        public Thumbnail(Window parent, string fileName)
            : base(parent)
        {
            m_fileName = fileName;

            // A box sizer to arrange the controls vertically 
            BoxSizer sizer = new BoxSizer(Orientation.wxVERTICAL);

            // The bitmap constructor can load the image files directly
            wx.Image image = new wx.Image(m_fileName);
            m_bitmap = new wx.Bitmap(image);
            //m_bitmap = new wx.Bitmap(m_fileName, 
            //                         BitmapType.wxBITMAP_TYPE_BMP);

            wx.Bitmap smallBmp = m_bitmap;

            // Scale the bitmap to icon size, retaining the aspec ratio
            int max = Math.Max(m_bitmap.Width, m_bitmap.Height);
            if (max > 100) {

                double scale = 100.0 / (double)max;
                int width = (int)((double)m_bitmap.Width * scale), 
                    height = (int)((double)m_bitmap.Height * scale);
                
                wx.Image img = m_bitmap.ConvertToImage();
                img.Rescale(width, height);
                smallBmp = new wx.Bitmap(img);
            }

            // Create the bitmap button with the small bitmap
            m_bitmapBtn = new BitmapButton(this, -1, smallBmp);

            // Add it to the sizer, centered, with a small border
            sizer.Add(m_bitmapBtn, 1, Alignment.wxALIGN_CENTRE | 
                      Direction.wxALL, 3);

            // Create our static text label with the file name as the label
            m_label = new StaticText(this, -1, "");

            string lbl = m_fileName.Substring(m_fileName.LastIndexOf('/') + 1);
            lbl = lbl.Substring(0, lbl.LastIndexOf('.'));
            m_label.Label = lbl;

            // Add the label to the sizer, centered, with a small border
            sizer.Add(m_label, 0, Alignment.wxALIGN_CENTRE | 
                      Direction.wxALL, 3);

            // Set the sizer
            Sizer = sizer;
            sizer.SetSizeHints(this);

            // Catch the bitmap button click event, a '-1' is used, since our
            // panel control has only one bitmap button, so the event can only
            // come from one place.
            EVT_BUTTON(-1, new EventListener(OnBitmapButtonClicked));
        }

        protected void OnBitmapButtonClicked(object sender, Event evt)
        {
            // Notify our listeners
            if (ThumbnailClicked != null) {
                ThumbnailClicked(m_fileName, m_bitmap);
            }
        }
    }
}

