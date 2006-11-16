//-----------------------------------------------------------------------------
// wx.NET - VidMode.cs
// 
// Michael S. Muegel mike _at_ muegel dot org
//
// Given this is such a simple structure I did a full port of it's C++ 
// counterpart instead of using a wrapper.
//
// Changes/Additions to C++ version:
//    + ToString() method for simple formatting of display properties
//    + Implemented IComparable to allow for simple sorting of modes
//    + Did not implement IsOK -- maybee I did not understand it but
//      it seems impossible to not be true.
//
// Note that == and the Matches method differ in how they work. == is
// true equality of all properties. Matches implements the wxWidgets
// concept of display equivalence.
//
// VideoMode is immutable: it can not be modified once created, either manually
// via it's constructor or more likely by calling a method in Display.
//
// Licensed under the wxWidgets license, see LICENSE.txt for details.
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Drawing;
using System.Runtime.InteropServices;

namespace wx
{
    [StructLayout(LayoutKind.Sequential)]
    public struct VideoMode : IComparable
    {
        public VideoMode(int width, int height, int depth, int freq)
        {
            w = width;
            h = height;
            bpp = depth;
            refresh = freq;
        }

		public int CompareTo(object obj)
		{
			VideoMode other = (VideoMode) obj;
			if (other.w > w)
				return -1;
			else if (other.w < w)
				return 1;
			else if (other.h > h)
				return -1;
			else if (other.h < h)
				return 1;
			else if (other.bpp > bpp)
				return -1;
			else if (other.bpp < bpp)
				return 1;
			else if (other.refresh > refresh)
				return -1;
			else if (other.refresh < refresh)
				return 1;
			else
				return 0;
		}

        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            VideoMode otherMode = (VideoMode) obj;
            return (w == otherMode.w) && (h == otherMode.h) && 
                (bpp == otherMode.bpp) && (refresh == otherMode.refresh);
        }

        public override int GetHashCode()
        {
            return w.GetHashCode() ^ h.GetHashCode() ^ 
                bpp.GetHashCode() ^ refresh.GetHashCode();
        }

        public static bool operator == (VideoMode mode1, VideoMode mode2)
        {
            object obj1 = mode1, obj2 = mode2;
            if (obj1 == null && obj2 == null) return true;
            if (obj1 == null || obj2 == null) return false;

            return mode1.Equals(mode2);
        }

        public static bool operator != (VideoMode mode1, VideoMode mode2)
        {
            return ! mode1.Equals(mode2);
        }


        // returns true if this mode matches the other one in the sense that all
        // non zero fields of the other mode have the same value in this one
        // (except for refresh which is allowed to have a greater value)
        public bool Matches(VideoMode other)
        {
            return (other.w == 0 || w == other.w) &&
                (other.h == 0 || h == other.h) &&
                (other.bpp == 0 || bpp == other.bpp) &&
                (other.refresh == 0 || refresh >= other.refresh);
        }

        // trivial accessors
        public int Width
        {
            get { return w; }
        }

        public int Height
        {
            get { return h; }
        }

        public int Depth
        {
            get { return bpp; }
        }

        // This is not defined in vidmode.h
        public int RefreshFrequency
        {
            get { return refresh; }
        }


        // returns true if the object has been initialized
        // not implemented -- seems impossible
        // bool IsOk() const { return w && h; }

		public override string ToString()
		{
			string s;
			s = w.ToString() + "x" + h.ToString();
			if ( bpp > 0 )
				s += ", " + bpp.ToString() + "bpp";

			if ( refresh > 0 )
				s += ", " + refresh.ToString() + "Hz";

			return s;
		}

        // the screen size in pixels (e.g. 640*480), 0 means unspecified
        private int w, h;

        // bits per pixel (e.g. 32), 1 is monochrome and 0 means unspecified/known
        private int bpp;

        // refresh frequency in Hz, 0 means unspecified/unknown
        private int refresh;
    }
}
