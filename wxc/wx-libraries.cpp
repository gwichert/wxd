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

	wxString wxConfig = wxT("wx-config");
	wxGetEnv(wxT("WX_CONFIG"), &wxConfig);

	wxString command = wxConfig.Append(wxT(" --libs"));
	long code = wxExecute(command, output, errors);

	if (code != 0)
		wxLogFatalError(errors[0]);

        wxString compiler;
        const char *directory, *library, *spacer;
        if (argc > 1)
            compiler = wxString(argv[1], *wxConvCurrent);
        else
            compiler = wxString();

        if (compiler.Matches(wxT("gdc")))
        {
            directory = "-L";
            library = "-l";
            spacer = " ";
        }
        else if (compiler.Matches(wxT("dmd")) ||
            compiler.Matches(wxT("ldc")))
        {
            directory = "-L-L";
            library = "-L-l";
            spacer = " ";
        }
        else
        {
            directory = NULL;
            library = "";
            spacer = "\n";
        }

	wxString libs = output[0];
	size_t start, length;

	wxLogDebug(libs);
	wxRegEx reDir(wxT("\\-L([[:alnum:]\\_\\.\\-\\/]+)"));
	while (reDir.Matches(libs))
	{
		reDir.GetMatch(&start, &length, 1);
		wxString dir = libs.Mid(start, length);
                if (directory)
 		    printf("%s%s%s", directory, (const char*) dir.mb_str(), spacer);
		libs = libs.Mid(start + length);
		libs = libs.Trim(false);
	}
	wxRegEx reLib(wxT("\\-l([[:alnum:]\\_\\.\\-]+)"));
	while (reLib.Matches(libs))
	{
		reLib.GetMatch(&start, &length, 1);
		wxString lib = libs.Mid(start, length);
                if (library)
 		    printf("%s%s%s",library, (const char*) lib.mb_str(), spacer);
		libs = libs.Mid(start + length);
		libs = libs.Trim(false);
	}

	wxString frameworks = output[0];
	wxRegEx reFw(wxT("\\-framework ([[:alnum:]\\-]+)"));
	while (reFw.Matches(frameworks))
	{
		reFw.GetMatch(&start, &length, 1);
		wxString fw = frameworks.Mid(start, length);
		if (library)
		    printf("%sSystem,-framework,%s%s", library, (const char*) fw.mb_str(), spacer);
		frameworks = frameworks.Mid(start + length);
		frameworks = frameworks.Trim(false);
	}

	return 0;
} 
