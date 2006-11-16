//-----------------------------------------------------------------------------
// wx.NET - Image.cs
//
// The wxImage wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.IO;
using System.Drawing;
using System.Reflection;
using System.Collections;
using System.Runtime.InteropServices;

namespace wx
{
	public class Image : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxImage_ctor();
		[DllImport("wx-c")] static extern IntPtr wxImage_ctorByName(string name, BitmapType type);
		[DllImport("wx-c")] static extern IntPtr wxImage_ctorintintbool(int width, int height, bool clear);
		[DllImport("wx-c")] static extern IntPtr wxImage_ctorByImage(IntPtr image);
		[DllImport("wx-c")] static extern IntPtr wxImage_ctorByByteArray(IntPtr data, int length, BitmapType type);
		[DllImport("wx-c")] static extern void   wxImage_dtor(IntPtr self);
		
		[DllImport("wx-c")] static extern void   wxImage_Destroy(IntPtr self);
		
		[DllImport("wx-c")] static extern int    wxImage_GetHeight(IntPtr self);
		[DllImport("wx-c")] static extern int    wxImage_GetWidth(IntPtr self);
		[DllImport("wx-c")] static extern void   wxImage_InitAllHandlers();
		[DllImport("wx-c")] static extern void   wxImage_Rescale(IntPtr self, int width, int height);
		[DllImport("wx-c")] static extern IntPtr wxImage_Scale(IntPtr self, int width, int height);

		[DllImport("wx-c")] static extern void   wxImage_SetMask(IntPtr self, bool mask);
		[DllImport("wx-c")] static extern bool   wxImage_HasMask(IntPtr self);
		[DllImport("wx-c")] static extern void   wxImage_SetMaskColour(IntPtr self, byte r, byte g, byte b);

		[DllImport("wx-c")] static extern bool   wxImage_LoadFileByTypeId(IntPtr self, string name, BitmapType type, int index);
		[DllImport("wx-c")] static extern bool   wxImage_LoadFileByMimeTypeId(IntPtr self, string name, string mimetype, int index);
		[DllImport("wx-c")] static extern bool   wxImage_SaveFileByType(IntPtr self, string name, BitmapType type);
		[DllImport("wx-c")] static extern bool   wxImage_SaveFileByMimeType(IntPtr self, string name, string mimetype);
		
		[DllImport("wx-c")] static extern IntPtr wxImage_Copy(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxImage_GetSubImage(IntPtr self, ref Rectangle rect);
		
		[DllImport("wx-c")] static extern void   wxImage_Paste(IntPtr self, IntPtr image, int x, int y);
		
		[DllImport("wx-c")] static extern IntPtr wxImage_ShrinkBy(IntPtr self, int xFactor, int yFactor);
		
		[DllImport("wx-c")] static extern IntPtr wxImage_Rotate(IntPtr self, double angle, ref Point centre_of_rotation, bool interpolating, ref Point offset_after_rotation);
		[DllImport("wx-c")] static extern IntPtr wxImage_Rotate90(IntPtr self, bool clockwise);
		[DllImport("wx-c")] static extern IntPtr wxImage_Mirror(IntPtr self, bool horizontally);
		
		[DllImport("wx-c")] static extern void   wxImage_Replace(IntPtr self, byte r1, byte g1, byte b1, byte r2, byte g2, byte b2);
		
		[DllImport("wx-c")] static extern IntPtr wxImage_ConvertToMono(IntPtr self, byte r, byte g, byte b);
		
		[DllImport("wx-c")] static extern void   wxImage_SetRGB(IntPtr self, int x, int y, byte r, byte g, byte b);
		
		[DllImport("wx-c")] static extern byte   wxImage_GetRed(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern byte   wxImage_GetGreen(IntPtr self, int x, int y);
		[DllImport("wx-c")] static extern byte   wxImage_GetBlue(IntPtr self, int x, int y);
		
		[DllImport("wx-c")] static extern void   wxImage_SetAlpha(IntPtr self, int x, int y, byte alpha);
		[DllImport("wx-c")] static extern byte   wxImage_GetAlpha(IntPtr self, int x, int y);
		
		[DllImport("wx-c")] static extern bool   wxImage_FindFirstUnusedColour(IntPtr self, ref byte r, ref byte g, ref byte b, byte startR, byte startG, byte startB);
		[DllImport("wx-c")] static extern bool   wxImage_SetMaskFromImage(IntPtr self, IntPtr mask, byte mr, byte mg, byte mb);
		
		[DllImport("wx-c")] static extern bool   wxImage_ConvertAlphaToMask(IntPtr self, byte threshold);
		
		[DllImport("wx-c")] static extern bool   wxImage_CanRead(string name);
		[DllImport("wx-c")] static extern int    wxImage_GetImageCount(string name, int type);
		
		[DllImport("wx-c")] static extern bool   wxImage_Ok(IntPtr self);
		//--Alex
		[DllImport("wx-c")] static extern byte   wxImage_GetMaskRed(IntPtr self);
		[DllImport("wx-c")] static extern byte   wxImage_GetMaskGreen(IntPtr self);
		[DllImport("wx-c")] static extern byte   wxImage_GetMaskBlue(IntPtr self);
		
		[DllImport("wx-c")] static extern bool   wxImage_HasPalette(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxImage_GetPalette(IntPtr self);
		[DllImport("wx-c")] static extern void   wxImage_SetPalette(IntPtr self, IntPtr palette);
		
		[DllImport("wx-c")] static extern void   wxImage_SetOption(IntPtr self, string name, string value);
		[DllImport("wx-c")] static extern void   wxImage_SetOption2(IntPtr self, string name, int value);
		[DllImport("wx-c")] static extern IntPtr wxImage_GetOption(IntPtr self, string name);
		[DllImport("wx-c")] static extern int    wxImage_GetOptionInt(IntPtr self, string name);
		[DllImport("wx-c")] static extern bool   wxImage_HasOption(IntPtr self, string name);
		
		[DllImport("wx-c")] static extern ulong  wxImage_CountColours(IntPtr self, ulong stopafter);
		
		[DllImport("wx-c")] static extern ulong  wxImage_ComputeHistogram(IntPtr self, IntPtr h);
		
		[DllImport("wx-c")] static extern IntPtr wxImage_GetHandlers();
		[DllImport("wx-c")] static extern void   wxImage_AddHandler(IntPtr handler);
		[DllImport("wx-c")] static extern void   wxImage_InsertHandler(IntPtr handler);
		[DllImport("wx-c")] static extern bool   wxImage_RemoveHandler(string name);
		[DllImport("wx-c")] static extern IntPtr wxImage_FindHandler(string name);
		[DllImport("wx-c")] static extern IntPtr wxImage_FindHandler2(string name, uint imageType);
		[DllImport("wx-c")] static extern IntPtr wxImage_FindHandler3(uint imageType);
		[DllImport("wx-c")] static extern IntPtr wxImage_FindHandlerMime(string mimetype);
		
		[DllImport("wx-c")] static extern IntPtr wxImage_GetImageExtWildcard();
		
		[DllImport("wx-c")] static extern void   wxImage_CleanUpHandlers();
		
		[DllImport("wx-c")] static extern void   wxImage_InitStandardHandlers();

		//---------------------------------------------------------------------

		private static bool handlersLoaded = false;
		
		public static void InitAllHandlers()
		{
			// We only want to load the image handlers once.
			if (!handlersLoaded) 
			{
				wxImage_InitAllHandlers();
				handlersLoaded = true;
			}
		}

		static Image()
		{
			InitAllHandlers();
		}
		
		public Image(IntPtr wxObject)
			: base(wxObject) {}

		public Image()
			: this(wxImage_ctor()) {}

		// Normally BITMAP_TYPE_ANY would be used, unless we want to read a resource
		public Image(string name, BitmapType type) : this(LoadPossibleResource(name, type, Assembly.GetCallingAssembly())) {}
		
		public Image(string name, Assembly ResourceAssembly) 
			: this(LoadImageResourceFromByteArray(name, ResourceAssembly)) {}

		public Image(string name)
			: this(wxImage_ctorByName(name, BitmapType.wxBITMAP_TYPE_ANY)) {}

		public Image(int width, int height)
			: this(width, height, true) {}

		public Image(byte[] data, BitmapType type) 
			: this(LoadImageFromByteArray(data, type)) {}

		public Image(int width, int height, bool clear)
			: this(wxImage_ctorintintbool(width, height, clear)) {}
			
		public Image(Image image)
			: this(wxImage_ctorByImage(Object.SafePtr(image))) {}
		
		//---------------------------------------------------------------------

		private static IntPtr LoadPossibleResource(string name, BitmapType type, Assembly asm)
		{
			if (type == BitmapType.wxBITMAP_TYPE_RESOURCE)
				return Object.SafePtr(new Image(name, asm));	
			else
				return wxImage_ctorByName(name, type);
		}

		//---------------------------------------------------------------------

		private static IntPtr LoadImageResourceFromByteArray(string ResourceName, Assembly ResourceAssembly)
		{
			byte[] ImageBytes;

			ManifestResourceInfo mri = ResourceAssembly.GetManifestResourceInfo(ResourceName);
			if (mri == null)
				throw new ArgumentException("No resource named \"" + ResourceName + "\" was found in the assembly.");

			Stream stm = ResourceAssembly.GetManifestResourceStream(ResourceName);

			BinaryReader binr = new BinaryReader(stm);
			ImageBytes = binr.ReadBytes(Convert.ToInt32(stm.Length));

			return Object.SafePtr(new Image(ImageBytes, BitmapType.wxBITMAP_TYPE_ANY));
		}

		//---------------------------------------------------------------------

		private static IntPtr LoadImageFromByteArray(byte[] data, BitmapType type)
		{
			IntPtr DataPtr = IntPtr.Zero;
			DataPtr = Marshal.AllocHGlobal(data.Length);

			Marshal.Copy(data, 0, DataPtr, data.Length);
			
			return wxImage_ctorByByteArray(DataPtr, data.Length, type);
		}

		//---------------------------------------------------------------------
		
		public void Destroy()
		{
			wxImage_Destroy(wxObject);
		}
		
		//---------------------------------------------------------------------

		public int Height
		{
			get { return wxImage_GetHeight(wxObject); }
		}

		//---------------------------------------------------------------------
		
		public bool LoadFile(string path)
		{
			return LoadFile(path, BitmapType.wxBITMAP_TYPE_ANY, -1);
		}
		
		public bool LoadFile(string path, BitmapType type)
		{
			return LoadFile(path, type, -1);
		}
		
		public bool LoadFile(string path, BitmapType type, int index)
		{
			return wxImage_LoadFileByTypeId(wxObject, path, type, -1);
		}
		
		//---------------------------------------------------------------------
		
		public bool LoadFile(string name, string mimetype)
		{
			return LoadFile(name, mimetype, -1);
		}
		
		public bool LoadFile(string name, string mimetype, int index)
		{
			return wxImage_LoadFileByMimeTypeId(wxObject, name, mimetype, index);
		}
		
		//---------------------------------------------------------------------

        	public bool SaveFile(string path)
		{ 
			return SaveFile(path, BitmapType.wxBITMAP_TYPE_ANY); 
		}
		
		public bool SaveFile(string path, BitmapType type)
		{
			return wxImage_SaveFileByType(wxObject, path, type);
		}
		
		//---------------------------------------------------------------------
		
		public bool SaveFile(string name, string mimetype)
		{
			return wxImage_SaveFileByMimeType(wxObject, name, mimetype);
		}

		//---------------------------------------------------------------------

		public Image Rescale(int width, int height)
		{
			wxImage_Rescale(wxObject, width, height);
			return this;
		}

		//---------------------------------------------------------------------

		public Image Scale(int width, int height)
		{
			return new Image(wxImage_Scale(wxObject, width, height));
		}

		//---------------------------------------------------------------------

		public int Width
		{
			get { return wxImage_GetWidth(wxObject); }
		}

		//---------------------------------------------------------------------

		public void SetMaskColour(byte r, byte g, byte b)
		{
			wxImage_SetMaskColour(wxObject, r, g, b);
		}
		
		//---------------------------------------------------------------------

		public Colour MaskColour
		{
			set { SetMaskColour(value.Red, value.Green, value.Blue); }
		}
		
		//---------------------------------------------------------------------

		public bool Mask
		{
			set { wxImage_SetMask(wxObject, value); }
			get { return wxImage_HasMask(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public Image Copy()
		{
			return new Image(wxImage_Copy(wxObject));
		}
		
		//---------------------------------------------------------------------
		
		public Image SubImage(Rectangle rect)
		{
			return (Image)FindObject(wxImage_GetSubImage(wxObject, ref rect), typeof(Image));
		}
		
		//---------------------------------------------------------------------
		
		public void Paste(Image image, int x, int y)
		{
			wxImage_Paste(wxObject, Object.SafePtr(image), x, y);
		}
		
		//---------------------------------------------------------------------
		
		public Image ShrinkBy(int xFactor, int yFactor)
		{
			return new Image(wxImage_ShrinkBy(wxObject, xFactor, yFactor));
		}
		
		//---------------------------------------------------------------------
		
		public Image Rotate(double angle, Point centre_of_rotation)
		{
			Point dummy = new Point();
			return Rotate(angle, centre_of_rotation, true, dummy);
		}
		
		public Image Rotate(double angle, Point centre_of_rotation, bool interpolating)
		{
			Point dummy = new Point();
			return Rotate(angle, centre_of_rotation, interpolating, dummy);
		}
		
		public Image Rotate(double angle, Point centre_of_rotation, bool interpolating, Point offset_after_rotation)
		{
			return new Image(wxImage_Rotate(wxObject, angle, ref centre_of_rotation, interpolating, ref offset_after_rotation));
		}
		
		//---------------------------------------------------------------------
		
		public Image Rotate90()
		{
			return Rotate90(true);
		}
		
		public Image Rotate90(bool clockwise)
		{
			return new Image(wxImage_Rotate90(wxObject, clockwise));
		}
		
		//---------------------------------------------------------------------
		
		public Image Mirror()
		{
			return Mirror(true);
		}
		
		public Image Mirror(bool horizontally)
		{
			return new Image(wxImage_Mirror(wxObject, horizontally));
		}
		
		//---------------------------------------------------------------------
		
		public void Replace(byte r1, byte g1, byte b1, byte r2, byte g2, byte b2)
		{
			wxImage_Replace(wxObject, r1, g1, b1, r2, g2, b2);
		}
		
		//---------------------------------------------------------------------
		
		public void ConvertToMono(byte r, byte g, byte b)
		{
			wxImage_ConvertToMono(wxObject, r, g, b);
		}
		
		//---------------------------------------------------------------------
		
		public void SetRGB(int x, int y, byte r, byte g, byte b)
		{
			wxImage_SetRGB(wxObject, x, y, r, g, b);
		}
		
		//---------------------------------------------------------------------
		
		public byte GetRed(int x, int y)
		{
			return wxImage_GetRed(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public byte GetGreen(int x, int y)
		{
			return wxImage_GetGreen(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public byte GetBlue(int x, int y)
		{
			return wxImage_GetBlue(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public void SetAlpha(int x, int y, byte alpha)
		{
			wxImage_SetAlpha(wxObject, x, y, alpha);
		}
		
		//---------------------------------------------------------------------
		
		public byte GetAlpha(int x, int y)
		{
			return wxImage_GetAlpha(wxObject, x, y);
		}
		
		//---------------------------------------------------------------------
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b)
		{
			return FindFirstUnusedColour(ref r, ref g, ref b, 1, 0, 0);
		}
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b, byte startR)
		{
			return FindFirstUnusedColour(ref r, ref g, ref b, startR, 0, 0);
		}
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b, byte startR, byte startG)
		{
			return FindFirstUnusedColour(ref r, ref g, ref b, startR, startG, 0);
		}
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b, byte startR, byte startG, byte startB)
		{
			return wxImage_FindFirstUnusedColour(wxObject, ref r, ref g, ref b, startR, startG, startB);
		}
		
		//---------------------------------------------------------------------
		
		public bool SetMaskFromImage(Image mask, byte mr, byte mg, byte mb)
		{
			return wxImage_SetMaskFromImage(wxObject, Object.SafePtr(mask), mr, mg, mb);
		}
		
		//---------------------------------------------------------------------
		
		public bool ConvertAlphaToMask()
		{
			return ConvertAlphaToMask(128);
		}
		
		public bool ConvertAlphaToMask(byte threshold)
		{
			return wxImage_ConvertAlphaToMask(wxObject, threshold);
		}
		
		//---------------------------------------------------------------------
		
		public static bool CanRead(string name)
		{
			return wxImage_CanRead(name);
		}
		
		//---------------------------------------------------------------------
		
		public static int GetImageCount(string name)
		{
			return GetImageCount(name, BitmapType.wxBITMAP_TYPE_ANY);
		}
		
		public static int GetImageCount(string name, BitmapType type)
		{
			return wxImage_GetImageCount(name, (int)type);
		}
		
		//---------------------------------------------------------------------
		
		public bool Ok
		{
			get { return wxImage_Ok(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public byte MaskRed
		{
			get { return wxImage_GetMaskRed(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public byte MaskGreen
		{
			get { return wxImage_GetMaskGreen(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public byte MaskBlue
		{
			get { return wxImage_GetMaskBlue(wxObject); }
		}
		
		//---------------------------------------------------------------------
		
		public bool HasPalette()
		{
			return wxImage_HasPalette(wxObject);
		}
		
		//---------------------------------------------------------------------
		
		public Palette Palette
		{
			get { return (Palette)FindObject(wxImage_GetPalette(wxObject), typeof(Palette)); }
			set { wxImage_SetPalette(wxObject, Object.SafePtr(value)); }
		}
		
		//---------------------------------------------------------------------
		
		public void SetOption(string name, string value)
		{
			wxImage_SetOption(wxObject, name, value);
		}
		
		//---------------------------------------------------------------------
		
		public void SetOption(string name, int value)
		{
			wxImage_SetOption2(wxObject, name, value);
		}
		
		//---------------------------------------------------------------------
		
		public string GetOption(string name)
		{
			return new wxString(wxImage_GetOption(wxObject, name), true);
		}
		
		//---------------------------------------------------------------------
		
		public int GetOptionInt(string name)
		{
			return wxImage_GetOptionInt(wxObject, name);
		}
		
		//---------------------------------------------------------------------
		
		public bool HasOption(string name)
		{
			return wxImage_HasOption(wxObject, name);
		}
		
		//---------------------------------------------------------------------
		
		public ulong CountColours()
		{
			return CountColours(ulong.MaxValue-1);
		}
		
		//---------------------------------------------------------------------
		
		public ulong CountColours(ulong stopafter)
		{
			return wxImage_CountColours(wxObject, stopafter);
		}
		
		//---------------------------------------------------------------------
		
		public ulong ComputeHistogram(ImageHistogram h)
		{
			return wxImage_ComputeHistogram(wxObject, Object.SafePtr(h));
		}
		
		//---------------------------------------------------------------------
		
		/*
		// doesn't work. wxImageHandler is an abstract class...
		public static ArrayList Handlers
		{
			get { 
				wxList wl = new wxList(wxImage_GetHandlers());
				ArrayList al = new ArrayList();
				
				for (int i = 0; i < wl.Count; i++)
                	al.Add(new ImageHandler(wl.Item(i)));
					
				return wl;
			}
		}
		*/
		
		//---------------------------------------------------------------------
		
		public static void AddHandler(ImageHandler handler)
		{
			wxImage_AddHandler(Object.SafePtr(handler));
		}
		
		//---------------------------------------------------------------------
		
		public static void InsertHandler(ImageHandler handler)
		{
			wxImage_InsertHandler(Object.SafePtr(handler));
		}
		
		//---------------------------------------------------------------------
		
		public static bool RemoveHandler(string name)
		{
			return wxImage_RemoveHandler(name);
		}
		
		//---------------------------------------------------------------------
		
		public static ImageHandler FindHandler(string name)
		{
			return (ImageHandler)FindObject(wxImage_FindHandler(name));
		}
		
		//---------------------------------------------------------------------
		
		public static ImageHandler FindHandler(string extension, long imageType)
		{
			return (ImageHandler)FindObject(wxImage_FindHandler2(extension, (uint)imageType));
		}
		
		//---------------------------------------------------------------------
		
		public static ImageHandler FindHandler(long imageType)
		{
			return (ImageHandler)FindObject(wxImage_FindHandler3((uint)imageType));
		}
		
		//---------------------------------------------------------------------
		
		public static ImageHandler FindHandlerMime(string mimetype)
		{
			return (ImageHandler)FindObject(wxImage_FindHandlerMime(mimetype));
		}
		
		//---------------------------------------------------------------------
		
		public static string ImageExtWildcard
		{
			get { return new wxString(wxImage_GetImageExtWildcard(), true); }
		}
		
		//---------------------------------------------------------------------
		
		public static void CleanUpHandlers()
		{
			wxImage_CleanUpHandlers();
		}
		
		//---------------------------------------------------------------------
		
		public static void InitStandardHandlers()
		{
			wxImage_InitStandardHandlers();
		}
	}
	
	//---------------------------------------------------------------------
	
	public class ImageHandler : Object
	{
		[DllImport("wx-c")] static extern void   wxImageHandler_SetName(IntPtr self, string name);
		[DllImport("wx-c")] static extern void   wxImageHandler_SetExtension(IntPtr self, string ext);
		[DllImport("wx-c")] static extern void   wxImageHandler_SetType(IntPtr self, uint type);
		[DllImport("wx-c")] static extern void   wxImageHandler_SetMimeType(IntPtr self, string type);
		[DllImport("wx-c")] static extern IntPtr wxImageHandler_GetName(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxImageHandler_GetExtension(IntPtr self);
		[DllImport("wx-c")] static extern uint   wxImageHandler_GetType(IntPtr self);
		[DllImport("wx-c")] static extern IntPtr wxImageHandler_GetMimeType(IntPtr self);
		
		//---------------------------------------------------------------------
	
		public ImageHandler(IntPtr wxObject)
			: base(wxObject) {}
		
		//---------------------------------------------------------------------
		
		public string Name
		{
			get { return new wxString(wxImageHandler_GetName(wxObject), true); }
			set { wxImageHandler_SetName(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public string Extension
		{
			get { return new wxString(wxImageHandler_GetExtension(wxObject), true); }
			set { wxImageHandler_SetExtension(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public long Type
		{
			get { return (long)wxImageHandler_GetType(wxObject); }
			set { wxImageHandler_SetType(wxObject, (uint)value); }
		}
		
		//---------------------------------------------------------------------
		
		public string MimeType
		{
			get { return new wxString(wxImageHandler_GetMimeType(wxObject), true); }
			set { wxImageHandler_SetMimeType(wxObject, value); }
		}
	}
	
	//---------------------------------------------------------------------
	
	public class ImageHistogramEntry : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxImageHistogramEntry_ctor();
		[DllImport("wx-c")] static extern void   wxImageHistogramEntry_dtor(IntPtr self);
		[DllImport("wx-c")] static extern ulong  wxImageHistogramEntry_index(IntPtr self);
		[DllImport("wx-c")] static extern void   wxImageHistogramEntry_Setindex(IntPtr self, ulong v);
		[DllImport("wx-c")] static extern ulong  wxImageHistogramEntry_value(IntPtr self);
		[DllImport("wx-c")] static extern void   wxImageHistogramEntry_Setvalue(IntPtr self, ulong v);
		
		//---------------------------------------------------------------------
		
		public ImageHistogramEntry(IntPtr wxObject)
			: base(wxObject) 
		{
			this.wxObject = wxObject;
		}
		
		internal ImageHistogramEntry(IntPtr wxObject, bool memOwn)
			: base(wxObject)
		{ 
			this.memOwn = memOwn;
			this.wxObject = wxObject;
		}
			
		public ImageHistogramEntry()
			: this(wxImageHistogramEntry_ctor(), true) {}
			
		//---------------------------------------------------------------------
				
		public override void Dispose()
		{
			if (!disposed)
			{
				if (wxObject != IntPtr.Zero)
				{
					if (memOwn)
					{
						wxImageHistogramEntry_dtor(wxObject);
						memOwn = false;
					}
				}
				RemoveObject(wxObject);
				wxObject = IntPtr.Zero;
				disposed= true;
			}
			
			base.Dispose();
			GC.SuppressFinalize(this);
		}
		
		//---------------------------------------------------------------------
		
		~ImageHistogramEntry() 
		{
			Dispose();
		}
		
		//---------------------------------------------------------------------
		
		public ulong index
		{
			get { return wxImageHistogramEntry_index(wxObject); }
			set { wxImageHistogramEntry_Setindex(wxObject, value); }
		}
		
		//---------------------------------------------------------------------
		
		public ulong value
		{
			get { return wxImageHistogramEntry_value(wxObject); }
			set { wxImageHistogramEntry_Setvalue(wxObject, value); }
		}
	}
	
	//---------------------------------------------------------------------
	
	public class ImageHistogram : Object
	{
		[DllImport("wx-c")] static extern IntPtr wxImageHistogram_ctor();	
		[DllImport("wx-c")] static extern void   wxImageHistogram_dtor(IntPtr self);
		[DllImport("wx-c")] static extern ulong  wxImageHistogram_MakeKey(byte r, byte g, byte b);
		[DllImport("wx-c")] static extern bool   wxImageHistogram_FindFirstUnusedColour(IntPtr self, ref byte r, ref byte g, ref byte b, byte startR, byte startG, byte startB);
				
		//---------------------------------------------------------------------
		
		public ImageHistogram(IntPtr wxObject)
			: base(wxObject) {}
			
		public ImageHistogram()
			: this(wxImageHistogram_ctor()) {}
		
		//---------------------------------------------------------------------
		
		public static ulong MakeKey(byte r, byte g, byte b)
		{
			return wxImageHistogram_MakeKey(r, g, b);
		}
		
		//---------------------------------------------------------------------
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b)
		{
			return FindFirstUnusedColour(ref r, ref g, ref b, 1, 0, 0);
		}
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b, byte startR)
		{
			return FindFirstUnusedColour(ref r, ref g, ref b, startR, 0, 0);
		}
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b, byte startR, byte startG)
		{
			return FindFirstUnusedColour(ref r, ref g, ref b, startR, startG, 0);
		}
		
		public bool FindFirstUnusedColour(ref byte r, ref byte g, ref byte b, byte startR, byte startG, byte startB)
		{
			return wxImageHistogram_FindFirstUnusedColour(wxObject, ref r, ref g, ref b, startR, startG, startB);
		}
	}
}
