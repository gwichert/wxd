module wx.ArrayString;
import wx.common;

		static extern (C) IntPtr wxArrayString_ctor();
		static extern (C) void   wxArrayString_dtor(IntPtr self);
		static extern (C) void   wxArrayString_RegisterDisposable(IntPtr self, Virtual_Dispose onDispose);
		static extern (C) void   wxArrayString_Add(IntPtr self, string toadd);
		static extern (C) string wxArrayString_Item(IntPtr self, int num);
		static extern (C) int    wxArrayString_GetCount(IntPtr self);
		
	public class ArrayString : wxObject
	{
		//---------------------------------------------------------------------

		public this(IntPtr wxobj)
		{
			super(wxobj);
		}
			
		public this(IntPtr wxobj, bool memOwn)
		{
			super(wxobj);
			this.memOwn = memOwn;
		}

		public this()
		{
			this(wxArrayString_ctor(), true);
			wxArrayString_RegisterDisposable(wxobj, &VirtualDispose);
		}
		
		//---------------------------------------------------------------------

		public string[] toArray()
		{
			int count = this.Count;
			string[] tmps = new string[count];
			for (int i = 0; i < count; i++)
				tmps[i] = this.Item(i);
			return tmps;
		}
	
		public string Item(int num)
		{
			return wxArrayString_Item(wxobj, num).dup;
		}	
	
		public void Add(string toadd)
		{
			wxArrayString_Add(wxobj, toadd);
		}

		public int Count() { return wxArrayString_GetCount(wxobj); }
        
		//---------------------------------------------------------------------

		override private void dtor() { wxArrayString_dtor(wxobj); }
	}
	
