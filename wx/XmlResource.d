//-----------------------------------------------------------------------------
// wx.NET - XmlResource.cs
//
// The wxXmlResource wrapper class.
//
// Written by Achim Breunig (achim.breunig@web.de)
// (C) 2003 Achim Breunig
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Runtime.InteropServices;
using System.Runtime.Remoting;
using System.Text.RegularExpressions;
using System.Reflection;
using System.Diagnostics;

namespace wx
{
	public enum XmlResourceFlags : int
	{
		XRC_USE_LOCALE     = 1,
		XRC_NO_SUBCLASSING = 2
	};

	public class XmlResource : Object
	{
		public static XmlResource globalXmlResource = null;
	
		//---------------------------------------------------------------------
    
		[DllImport("wx-c")] static extern void wxXmlResource_InitAllHandlers(IntPtr self);
		[DllImport("wx-c")] static extern bool wxXmlResource_Load(IntPtr self, string filemask);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadDialog(IntPtr self, IntPtr parent, string name);
		[DllImport("wx-c")] static extern bool wxXmlResource_LoadDialogDlg(IntPtr self, IntPtr dlg, IntPtr parent, string name);
		[DllImport("wx-c")] static extern int wxXmlResource_GetXRCID(string str_id);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_ctorByFilemask(string filemask, int flags);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_ctor(int flags);
		[DllImport("wx-c")] static extern uint wxXmlResource_GetVersion(IntPtr self);
		[DllImport("wx-c")] static extern bool wxXmlResource_LoadFrameWithFrame(IntPtr self, IntPtr frame, IntPtr parent, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadFrame(IntPtr self, IntPtr parent, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadBitmap(IntPtr self, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadIcon(IntPtr self, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadMenu(IntPtr self, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadMenuBarWithParent(IntPtr self, IntPtr parent, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadMenuBar(IntPtr self, string name);
		[DllImport("wx-c")] static extern bool wxXmlResource_LoadPanelWithPanel(IntPtr self, IntPtr panel, IntPtr parent, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadPanel(IntPtr self, IntPtr parent, string name);
		[DllImport("wx-c")] static extern IntPtr wxXmlResource_LoadToolBar(IntPtr self, IntPtr parent, string name);
		[DllImport("wx-c")] static extern int wxXmlResource_SetFlags(IntPtr self, int flags);
		[DllImport("wx-c")] static extern int wxXmlResource_GetFlags(IntPtr self);
		[DllImport("wx-c")] static extern void wxXmlResource_UpdateResources(IntPtr self);
		[DllImport("wx-c")] static extern int wxXmlResource_CompareVersion(IntPtr self, int major, int minor, int release, int revision);
		[DllImport("wx-c")] static extern bool wxXmlResource_AttachUnknownControl(IntPtr self, string name, IntPtr control, IntPtr parent);

		//---------------------------------------------------------------------

		static XmlResource()
		{
			wxXmlSubclassFactory_ctor(m_create);
		}

		// Sets the default assembly/namespace based on the assembly from
		// which this method is called (i.e. your assembly!).
		//
		// Determines these by walking a stack trace. Normally 
		// Assembly.GetCallingAssembly should work but in my tests it 
		// returned the current assembly in the static constructor above.
		private static void SetSubclassDefaults()
		{
			string my_assembly = Assembly.GetExecutingAssembly().GetName().Name;
			StackTrace st = new StackTrace();
			
			for (int i = 0; i < st.FrameCount; ++i)
			{
				Type type = st.GetFrame(i).GetMethod().ReflectedType;
				string st_assembly = type.Assembly.GetName().Name;
				if (st_assembly != my_assembly)
				{
					_CallerNamespace = type.Namespace;
					_CallerAssembly = st_assembly;
					Console.WriteLine("Setting sub-class default assembly to {0}, namespace to {1}", _CallerAssembly, _CallerNamespace);
					break;
				}
			}
		}

		// Get/set the assembly used for sub-classing. If this is not set, the
		// assembly of the class that invokes one of the LoadXXX() methods
		// will be used. This property is only used if an assembly is not
		// specified in the XRC XML subclass property via the [assembly]class
		// syntax.
		public static string SubclassAssembly
		{
			set { _SubclassAssembly = value; }
			get { return _SubclassAssembly; }
		}
		static string _SubclassAssembly;

		// Get/set the namespace that is pre-pended to class names in sub-classing.
		// This is only used if class name does not have a dot (.) in it. If
		// this is not specified and the class does not already have a namespace
		// specified, the namespace of the class which invoked the LoadXXX() method
		// is used.
		public static string SubclassNamespace
		{
			set { _SubclassNamespace = value; }
			get { return _SubclassNamespace; }
		}
		static string _SubclassNamespace;

		// Defaults set via LoadXXX() methods
		private static string _CallerAssembly;
		private static string _CallerNamespace;


		//---------------------------------------------------------------------

		public XmlResource()
			: this(XmlResourceFlags.XRC_USE_LOCALE) {}

		public XmlResource(IntPtr wxObject)
			: base(wxObject) { }
 
		public XmlResource(XmlResourceFlags flags)
			: this(wxXmlResource_ctor((int)flags)) { }

		public XmlResource(string filemask, XmlResourceFlags flags)
			: this(wxXmlResource_ctorByFilemask(filemask,(int)flags)) { }
	    
		//---------------------------------------------------------------------
	
		public static XmlResource Get()
		{
			if (globalXmlResource == null)
			{
				globalXmlResource = new XmlResource();
			}
		
			return globalXmlResource;
		}
	
		//---------------------------------------------------------------------	
	
		public static XmlResource Set(XmlResource res)
		{ 
			XmlResource old = globalXmlResource;
			globalXmlResource = res;
			return old; 
		}
	
		//---------------------------------------------------------------------

		public void InitAllHandlers()
		{
			wxXmlResource_InitAllHandlers(wxObject);
		}
	
		//---------------------------------------------------------------------

		public bool Load(string filemask)
		{
			return wxXmlResource_Load(wxObject,filemask);
		}
	
		//---------------------------------------------------------------------

		/*public bool LoadFromEmbeddedResource(string ResourceName)
		{
		}*/
		
		//---------------------------------------------------------------------

		public Dialog LoadDialog(Window parent, string name)
		{
			SetSubclassDefaults();
			IntPtr ptr = wxXmlResource_LoadDialog(wxObject,Object.SafePtr(parent),name);
			if (ptr != IntPtr.Zero)
				return new Dialog(ptr);
			else
				return null;
		}
	
		//---------------------------------------------------------------------
        
		public bool LoadDialog(Dialog dlg, Window parent, string name)
		{
			SetSubclassDefaults();
			return wxXmlResource_LoadDialogDlg(wxObject,Object.SafePtr(dlg),Object.SafePtr(parent),name);
		}
	
		//---------------------------------------------------------------------

		public static int GetXRCID(string str_id)
		{
			return wxXmlResource_GetXRCID(str_id);
		}
	
		//---------------------------------------------------------------------
	
		public static int XRCID(string str_id)
		{
			return wxXmlResource_GetXRCID(str_id);
		}
	
		//---------------------------------------------------------------------

		public long Version
		{
			get { return wxXmlResource_GetVersion(wxObject); }
		}
	
		//---------------------------------------------------------------------

		public bool LoadFrame(Frame frame, Window parent, string name)
		{
			SetSubclassDefaults();
			return wxXmlResource_LoadFrameWithFrame(wxObject, Object.SafePtr(frame), Object.SafePtr(parent), name);
		}
	
		//---------------------------------------------------------------------

		public Frame LoadFrame(Window parent, string name)
		{
			SetSubclassDefaults();
			IntPtr ptr = wxXmlResource_LoadFrame(wxObject,Object.SafePtr(parent),name);
			if (ptr != IntPtr.Zero)
				return new Frame(ptr);
			else
				return null;
		}
	
		//---------------------------------------------------------------------

		public Menu LoadMenu(string name)
		{
			SetSubclassDefaults();
			IntPtr ptr = wxXmlResource_LoadMenu(wxObject, name);
			if (ptr != IntPtr.Zero)
				return new Menu(ptr);
			else
				return null;
		}
	
		//---------------------------------------------------------------------

		public MenuBar LoadMenuBar(Window parent, string name)
		{
			SetSubclassDefaults();
			IntPtr ptr = wxXmlResource_LoadMenuBarWithParent(wxObject, Object.SafePtr(parent), name);
			if (ptr != IntPtr.Zero)
				return new MenuBar(ptr);
			else
				return null;
		}
	
		//---------------------------------------------------------------------

		public MenuBar LoadMenuBar(string name)
		{
			SetSubclassDefaults();
			IntPtr ptr = wxXmlResource_LoadMenuBar(wxObject, name);
			if (ptr != IntPtr.Zero)
				return new MenuBar(ptr);
			else
				return null;
		}
	
		//---------------------------------------------------------------------

		public bool LoadPanel(Panel panel, Window parent, string name)
		{
			SetSubclassDefaults();
			return wxXmlResource_LoadPanelWithPanel(wxObject, Object.SafePtr(panel), Object.SafePtr(parent), name);
		}
	
		//---------------------------------------------------------------------

		public Panel LoadPanel(Window parent, string name)
		{
			SetSubclassDefaults();
			IntPtr ptr = wxXmlResource_LoadPanel(wxObject, Object.SafePtr(parent), name);
			if (ptr != IntPtr.Zero)
				return new Panel(ptr);
			else
				return null;
		}
	
		//---------------------------------------------------------------------

		public ToolBar LoadToolBar(Window parent, string name)
		{
			SetSubclassDefaults();
			IntPtr ptr = wxXmlResource_LoadToolBar(wxObject, Object.SafePtr(parent), name);
			if (ptr != IntPtr.Zero)
				return new ToolBar(ptr);
			else
				return null;
		}
	
		//---------------------------------------------------------------------

		public XmlResourceFlags Flags
		{
			set { wxXmlResource_SetFlags(wxObject, (int)value); }
			get { return (XmlResourceFlags)wxXmlResource_GetFlags(wxObject); }
		}
	
		//---------------------------------------------------------------------

		public void UpdateResources()
		{
			wxXmlResource_UpdateResources(wxObject);
		}
	
		//---------------------------------------------------------------------
	
		public Bitmap LoadBitmap(string name)
		{
			return new Bitmap(wxXmlResource_LoadBitmap(wxObject, name));
		}
	
		//---------------------------------------------------------------------
	
		public Icon LoadIcon(string name)
		{
			return new Icon(wxXmlResource_LoadIcon(wxObject, name));
		}
	
		//---------------------------------------------------------------------
	
		public int CompareVersion(int major, int minor, int release, int revision)
		{
			return wxXmlResource_CompareVersion(wxObject, major, minor, release, revision);
		}
	
		//---------------------------------------------------------------------
	
		public bool AttachUnknownControl(string name, Window control)
		{
			return AttachUnknownControl(name, control, null);
		}
	
		public bool AttachUnknownControl(string name, Window control, Window parent)
		{
			return wxXmlResource_AttachUnknownControl(wxObject, name, Object.SafePtr(control), Object.SafePtr(parent));
		}
	
		//---------------------------------------------------------------------
	  
		public static Object XRCCTRL(Window window, string id, Type type)
		{
			return window.FindWindow(XRCID(id), type);
		}

        public static Object GetControl(Window window, string id, Type type)
        { 
            return XRCCTRL(window, id, type); 
        }

		//---------------------------------------------------------------------
		// XmlResource control subclassing
        
		[DllImport("wx-c")] static extern bool wxXmlSubclassFactory_ctor(XmlSubclassCreate create);

		private delegate IntPtr XmlSubclassCreate(IntPtr className);

		private static XmlSubclassCreate m_create = new XmlSubclassCreate(XmlSubclassCreateCS);

		private static IntPtr XmlSubclassCreateCS(IntPtr className)
		{
			string name = new wxString(className);
			string assembly = null;
			// Allow these two formats for for class names:
			//   class
			//   [assembly]class (specify assembly)
			Match m = Regex.Match(name, "\\[(.+)\\]");
			if (m.Success)
			{
				assembly = m.Result("$1");
				name = m.Result("$'");
			}
			else
			{
				assembly = _SubclassAssembly;
			}

			// Use caller's assembly?
			if ((assembly == null) || (assembly == ""))
				assembly = _CallerAssembly;

			// Tack on any namespace prefix to the class? Only if the 
			// class does not already have a "." in it
			if (name.IndexOf(".") == -1)
			{
				string ns = "";
				// Use caller's namespace?
				if ((_SubclassNamespace == null) || (_SubclassNamespace == ""))
					ns = _CallerNamespace;
				else
					ns = _SubclassNamespace;
				name = ns + "." + name;
			}

			try 
			{
				Console.WriteLine("Attempting to create {0} from assembly {1}", 
					name, assembly);
				ObjectHandle handle = Activator.CreateInstance(assembly, name);

				if (handle == null) 
				{
					return IntPtr.Zero;
				}

				Object o = (Object)handle.Unwrap();
				return o.wxObject;
			} 
			catch (Exception e) 
			{
				Console.WriteLine(e);

				return IntPtr.Zero;
			}
		}
	}
}
