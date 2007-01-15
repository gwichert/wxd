#ifndef _COMMON_H_
#define _COMMON_H_

#include <string.h>

#include <wx/string.h>


// Can't use "bool", since the size varies...
typedef char            wxc_bool;   // D bool

// This is a char[] array, aliased "string"
typedef struct dstr     wxc_string; // D string

// This is something inherited from "Object"
typedef void*           wxc_object; // D object


/// length-prefixed string in UTF-8 format
struct dstr {
	size_t          length;
	const char*     data;

	/// convert from current char encoding to UTF
	dstr(const wxString& str) {
	#if !wxUSE_UNICODE
	    if (wxConvCurrent == &wxConvUTF8)
		{
		data = str.data();
		length = str.length();
	    }
	    else 
	#endif
	    {
#ifndef __DMD__
	    //This buffer is needed to copy the charbuffer returned by mb_str(),
		//which would otherwise be lost after the constructor returns
		static wxCharBuffer _buffer;
#else
        // another DMD hack
        wxCharBuffer _buffer;
#endif
		size_t _length;

	#if !wxUSE_UNICODE
		wxWCharBuffer _wbuffer;
		size_t _wlength;

		_wbuffer = wxConvCurrent->cMB2WC(str.data(), str.length(), &_wlength);
		_buffer = wxConvUTF8.cWC2MB(_wbuffer.data(), _wlength - 1, &_length);
	#elif wxUSE_UNICODE
		_buffer = wxConvUTF8.cWC2MB(str.data(), str.length(), &_length);
	#endif

		data = (const char*) _buffer.data();
		length = (_length - 1);  // skip trailing \0
	    }
	}

	dstr(const char* str, size_t len) {
		data = str;
		length = len;
	}

	dstr(const char* str) {
		data = str;
		length = strlen(str);
	}
};

#ifndef __DMD__
/// convert from UTF to current char encoding
static inline wxString wxstr(const dstr str)
{
#if !wxUSE_UNICODE
	if (wxConvCurrent == &wxConvUTF8)
	{
		return wxString(str.data, str.length);
	}
	else 
#endif
	{
	    //This buffer is needed to copy the charbuffer returned by wc_str(),
		//which would otherwise be lost after the constructor returns
		static wxWCharBuffer _wbuffer;
		size_t _wlength;

		_wbuffer = wxConvUTF8.cMB2WC((const char*) str.data, str.length, &_wlength);
		--_wlength;  // skip trailing \0
	#if !wxUSE_UNICODE
		return wxString(_wbuffer.data(), *wxConvCurrent, _wlength);
	#elif wxUSE_UNICODE
		return wxString(_wbuffer.data(), _wlength);
	#endif
	}
}
#else
// the inline doesn't work in DMC, so use an ASCII hack for now
#define wxstr(str)    wxString(str.data, wxConvUTF8, str.length)
#endif

#ifdef __DMD__

// DMD currently uses a 32-bit hack
typedef unsigned long long dstrret;
static inline dstrret dstr_ret(const wxString& str) { dstr dstr(str); return dstr.length | (((dstrret)(unsigned long)dstr.data)<<32); }
static inline dstrret dstr_ret(const wxString* str) { dstr dstr(*str); return dstr.length | (((dstrret)(unsigned long)dstr.data)<<32); }

#else

#define dstrret       dstr
#define dstr_ret(str) dstr(str)

#endif


#endif /* _COMMON_H_ */
