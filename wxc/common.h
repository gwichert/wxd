#ifndef _COMMON_H_
#define _COMMON_H_

#include <string.h>

struct dstr;

extern "C" {
	dstr _d_new(unsigned length,unsigned size);
}

struct dstr {
	unsigned length;
	const char* data;
	
	
	dstr(const wxString& str) {
	//	*this = _d_new(str.length(),1);
	//	memcpy((void*)data,(const void*)str.data(),length);
		length = str.length();
		data = str.data();
	}
	dstr(const wxString* str) {
	//	*this = _d_new(str->length(),1);
	//	memcpy((void*)data,(const void*)str->data(),length);
		length = str->length();
		data = str->data();
	}

	dstr(const char*str,unsigned int len)
	{
		data = str;
		length = len;
	}
};


typedef void* dobj;

typedef unsigned long long dstrret;
#if __WXMAC__
static inline dstrret dstr_ret(const wxString& str) { return (str.length()<<32) | ((dstrret)str.data()); }
static inline dstrret dstr_ret(const wxString* str) { return (str->length()<<32) | ((dstrret)str->data()); }
#else
static inline dstrret dstr_ret(const wxString& str) { return str.length() | ((dstrret)str.data()<<32); }
static inline dstrret dstr_ret(const wxString* str) { return str->length() | ((dstrret)str->data()<<32); }
#endif


#endif
