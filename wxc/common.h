#ifndef _COMMON_H_
#define _COMMON_H_

#include <string.h>

#include <wx/string.h>


typedef struct dstr     dstr;  // D string
typedef void*           dobj;  // D object

/// length-prefixed string in UTF-8 format
struct dstr {
	size_t          length;
	const char*     data;

	dstr(const wxString& str) {
		length = str.length();
	#if wxUSE_UNICODE
		data = str.mb_str(wxConvUTF8).data();
	#else // ANSI
		data = str.data();
	#endif
	}

	dstr(const wxString* str) {
		length = str->length();
	#if wxUSE_UNICODE
		data = str->mb_str(wxConvUTF8).data();
	#else // ANSI
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
