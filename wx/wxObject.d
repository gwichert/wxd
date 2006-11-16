//-----------------------------------------------------------------------------
// wx.NET - Object.cs
//
// The wxObject wrapper class.
//
// Written by Jason Perkins (jason@379.com)
// (C) 2003 by 379, Inc.
// Licensed under the wxWidgets license, see LICENSE.txt for details.
//
// $Id$
//-----------------------------------------------------------------------------

using System;
using System.Collections;
using System.Runtime.InteropServices;

namespace wx
{
	public class Object : IDisposable
	{
		protected delegate void Virtual_Dispose();
		protected Virtual_Dispose virtual_Dispose;
	
		[DllImport("wx-c")] static extern IntPtr wxObject_GetTypeName(IntPtr obj);
		[DllImport("wx-c")] static extern void   wxObject_dtor(IntPtr self);

		//---------------------------------------------------------------------

		// Reference to the associated C++ object
		internal IntPtr wxObject = IntPtr.Zero;
		internal bool disposed = false;

		// Hashtable to associate C++ objects with C# references
		private static Hashtable objects = new Hashtable();
		
		// memOwn is true when we create a new instance with the wrapper ctor
		// or if a call to a wrapper function returns new c++ instance.
		// Otherwise the created c++ object won't be deleted by the Dispose member.
		internal bool memOwn = false;
		
		//---------------------------------------------------------------------

		internal Object(IntPtr wxObject)
		{
			lock(typeof(Object)) {
				this.wxObject = wxObject;

				if (wxObject == IntPtr.Zero) {
					throw new NullReferenceException("Unable to create instance of " + this.ToString());
				}

				AddObject(this);
			}
		}

		//---------------------------------------------------------------------

		internal static IntPtr SafePtr(Object obj)
		{
			return (obj != null) ? obj.wxObject : IntPtr.Zero;
		}
		
		//---------------------------------------------------------------------
		// this is for Locale gettext support...
		
		[DllImport("wx-c")] static extern IntPtr wxGetTranslation_func(string str);
		
		public static string GetTranslation(string str)
		{
			return new wxString(wxGetTranslation_func(str), true);
		}

		// in wxWidgets it is a c/c++ macro
				
		public static string _(string str)
		{
			return new wxString(wxGetTranslation_func(str), true);
		}

		//---------------------------------------------------------------------

		internal static string GetTypeName(IntPtr wxObject)
		{
			return new wxString(wxObject_GetTypeName(wxObject), true);
		}

		public string GetTypeName()
		{
			return new wxString(wxObject_GetTypeName(wxObject), true);
		}

		//---------------------------------------------------------------------

		// Registers an Object, so that it can be referenced using a C++ object
		// pointer.
        
		internal static void AddObject(Object obj)
		{
			if (obj.wxObject != IntPtr.Zero) {
				if (objects.ContainsKey(obj.wxObject)) {
					objects[obj.wxObject] = obj;
				}
				else {
					objects.Add(obj.wxObject, obj);
				}
			}
		}
		
		//---------------------------------------------------------------------

		// Locates the registered object that references the given C++ object
		// pointer.
		//
		// If the pointer is not found, a reference to the object is created 
		// using type.
        
		internal static Object FindObject(IntPtr ptr, Type type)
		{
			if (ptr == IntPtr.Zero) {
				return null;
			}

			Object o = FindObject(ptr);

			// If the object wasn't found, create it
			if (type != null && (o == null || o.GetType() != type)) {
				o = (Object)Activator.CreateInstance(type, new object[]{ptr});
			}

			return o;
		}

		// Locates the registered object that references the given C++ object
		// pointer.

		internal static Object FindObject(IntPtr ptr)
		{
			if (ptr != IntPtr.Zero && objects.ContainsKey(ptr)) {
				return (Object)objects[ptr];
			}

			return null;
		}
		
		//---------------------------------------------------------------------

		// Removes a registered object.
		// returns true if the object is found in the
		// Hashtable and is removed (for Dispose)

		internal static bool RemoveObject(IntPtr ptr)
		{
			bool retval = false;

			if (ptr != IntPtr.Zero)
			{
				if(objects.Contains(ptr)) {
					objects.Remove(ptr);
					retval = true;
				}
			}
			
			return retval;
		}
		
		//---------------------------------------------------------------------
		
		// called when an c++ (wx)Object dtor gets invoked
		protected void VirtualDispose()
		{
			RemoveObject(wxObject);
			wxObject = IntPtr.Zero;
			disposed = true;
			virtual_Dispose = null;
		}

		public virtual void Dispose()
		{
			Dispose(true);
			GC.SuppressFinalize(this);
		}

		protected virtual void Dispose(bool disposing)
		{
			bool still_there = RemoveObject(wxObject);

			if (!disposed)
			{
				lock (typeof (Object)) {
					if (wxObject != IntPtr.Zero && memOwn && still_there)
					{
						wxObject_dtor(wxObject);
					}
				}
				
				virtual_Dispose = null;
				wxObject = IntPtr.Zero;
				memOwn = false;
			}

			disposed = true;
		}
		
		~Object()
		{
			Dispose();
		}
	}
}
