#include <stdio.h>
#include <stdlib.h>

#include <wx/wx.h>
#include <wx/utils.h>
#include <wx/process.h>
#include <wx/regex.h>

int main(int argc, char *argv[])
{
	wxArrayString output;
	wxArrayString errors;

	printf("module wx.libs;\n"); 

	wxString wxConfig = wxT("wx-config");
	wxGetEnv(wxT("WX_CONFIG"), &wxConfig);

	wxString command = wxConfig.Append(wxT(" --libs"));
	long code = wxExecute(command, output, errors);

	if (code != 0)
		wxLogFatalError(errors[0]);
	
	// libraries
	printf("version (build) { pragma(link, \"wxc\""); 
	wxString libs = output[0];

	wxLogDebug(libs);
	wxRegEx reLib(wxT(".* \\-l([[:alnum:]\\_\\.\\-]+)"));
	while (reLib.Matches(libs))
	{
		wxString lib = reLib.GetMatch(libs, 1);
		printf(", \"%s\"", (const char*) lib.mb_str());
		libs = libs.Mid( reLib.GetMatch(libs,0).Len());
		libs = libs.Trim(false);
	}

	printf(", \"stdc++\"); }\n");

	// platform
	printf("version (build) { pragma(export_version, \""); 
#if defined(__WXMSW__)
    printf("__WXMSW__");
#elif defined(__WXGTK__)
    printf("__WXGTK__");
#elif defined(__WXMAC__)
    printf("__WXMAC__");
#else
    #error unknown platform
#endif
	printf("\"); }\n");

	// encoding
	printf("version (build) { pragma(export_version, \""); 
#if wxUSE_UNICODE
    printf("UNICODE");
#elif !wxUSE_UNICODE
    printf("ANSI");
#else
    #error unknown encoding
#endif
	printf("\"); }\n");

	return 0;
} 
