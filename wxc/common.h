#ifndef _COMMON_H_
#define _COMMON_H_

#include <string.h>

#include <wx/string.h>


// Can't use "bool", since the size varies...
typedef char            dbit;  // D bit/bool

typedef struct dstr     dstr;  // D string
typedef void*           dobj;  // D object

/// length-prefixed string in UTF-8 format
struct dstr {
	size_t          length;
	const char*     data;

	dstr(const wxString& str) {
	#if wxUSE_UNICODE
		//This buffer is needed to copy the charbuffer returned by mb_str(),
		//which would otherwise be lost after the constructor returns
		static wxCharBuffer _buffer;
		_buffer = wxConvUTF8.cWC2MB(str.c_str(),str.length(),&length);
		data = _buffer.data();
		//Trailing \0 is bad for D
		--length;
	#else // ANSI
		length = str.length();
		data = str.data();
	#endif
	}

	dstr(const wxString* str) {
	#if wxUSE_UNICODE
		static wxCharBuffer _buffer;
		_buffer = wxConvUTF8.cWC2MB(str->c_str(),str->length(),&length);
		data = _buffer.data();
		--length;
	#else // ANSI
		length = str->length();
		data = str->data();
	#endif
	}

	dstr(const char* str,size_t len) {
		length = len;
		data = str;
	}

	dstr(const char* str) {
		length = strlen(str);
		data = str;
	}
};


#ifndef __GDC__

// DMD currently uses a 32-bit hack
typedef unsigned long long dstrret;
static inline dstrret dstr_ret(const wxString& str) { return str.length() | (((dstrret)(unsigned long)str.data())<<32); }
static inline dstrret dstr_ret(const wxString* str) { return str->length() | (((dstrret)(unsigned long)str->data())<<32); }

#else

#define dstrret       dstr
#define dstr_ret(str) dstr(str)

#endif


#endif /* _COMMON_H_ */
