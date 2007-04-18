module wxc.dssswxlibs;

// This is the DSSS version of the wx-libs helper (wxWidgets/C++)
//
// Originally written for wxD by Gregor Richards, updated by afb

version (Tango)
{
pragma(msg, "DSSS does not support Tango, try again with Phobos");

void main() {}
}
else // Phobos
{

import std.file;
import std.stdio;
import std.string;

import hcf.env;
import hcf.process;

int main()
{
    char[] pss, fout;
    char[] wxconfig;
    char[][] libs;
    
    char[] backticks(char[] command)
    {
       PStream ps = new PStream(command);
       char[] output = ps.readLine();
       ps.close();
       return output;
    }
    
    wxconfig = getEnvVar("WX_CONFIG");
    if (wxconfig == "") wxconfig = "wx-config";
    
    fout = "module wx.libs;\n";
    fout ~= "version (build) { pragma(link, \"wxc\"";
    
    libs = split(backticks(wxconfig ~ " --libs"));
    foreach (lib; libs) {
        if (lib.length < 2 ||
            lib[0..2] != "-l") continue;
        fout ~= ", \"" ~ lib[2..$] ~ "\"";
    }
    fout ~= ", \"stdc++\"); }\n";
    
    fout ~= "version (build) { pragma(export_version, "
            "\"__" ~backticks("wxc/wx-platform")~ "__\"); }\n";

    fout ~= "version (build) { pragma(export_version, "
            "\"" ~backticks("wxc/wx-encoding")~ "\"); }\n";

    std.file.write("wx/libs.d", cast(void[]) fout);
    
    return 0;
}

}
