module wxc.dssswxlibs;

// This is the DSSS version of the wx-libs helper (wxWidgets/C++)
//
// Originally written for wxD by Gregor Richards, updated by afb

version (Tango)
{

import tango.io.File;
import tango.io.Stdout;
import tango.text.stream.LineIterator;
import tango.text.Util;

import tango.sys.Environment;
import tango.sys.Process;

    char[] backticks(char[] command)
    {
        auto p = new Process(command, Environment.get);
        p.execute();
        char[] output;
        foreach (line; new LineIterator!(char)(p.stdout))
           output = line; // wrong for multiple lines
        p.wait();
        return output;
    }

    private void WRITE(char[] file, void[] buffer)
    {
        auto f = new File(file);
        f.write(buffer);
    }

    private char[][] SPLIT(char[] s)
    {
        return split(s, " ");
    }

    alias Environment.get GETENV;

}
else // Phobos
{

import std.file;
import std.stdio;
import std.string;

import hcf.env;
import hcf.process;

    char[] backticks(char[] command)
    {
       PStream ps = new PStream(command);
       char[] output = ps.readLine();
       ps.close();
       return output;
    }

    alias std.file.write WRITE;
    alias std.string.split SPLIT;
    alias hcf.env.getEnvVar GETENV;

}

int main()
{
    char[] pss, fout;
    char[] wxconfig;
    char[][] libs;
    
    wxconfig = GETENV("WX_CONFIG");
    if (wxconfig == "") wxconfig = "wx-config";
    
    version (Unix) // make it inherit the current $PATH from the environment :
    wxconfig = "sh -c \"PATH="~GETENV("PATH")~" "~wxconfig~" \\$1\" "~wxconfig;

    fout = "module wx.libs;\n";
    fout ~= "version (build) { pragma(link, \"wxc\"";
    
    libs = SPLIT(backticks(wxconfig ~ " --libs"));
    foreach (lib; libs) {
        if (lib.length < 2 ||
            lib[0..2] != "-l") continue;
        fout ~= ", \"" ~ lib[2..$] ~ "\"";
    }
    fout ~= ", \"stdc++\"); }\n";
    
    fout ~= "version (build) { pragma(export_version, "
            "__" ~backticks("wxc/wx-platform")~ "__); }\n";

    fout ~= "version (build) { pragma(export_version, "
            "" ~backticks("wxc/wx-encoding")~ "); }\n";

    WRITE("wx/libs.d", cast(void[]) fout);
    
    return 0;
}

