RPAN Show History v1.0
By Leslie E. Krause

RPAN Show History parses the search results for RPAN broadcasts from Old Reddit and
generates a summary of past shows as a tab-delimited text file.

The package consists of the following files:

  /rpan_show_history
  |- README.txt
  |- LICENSE.txt
  |- show_history_wizard.html
  |- convert.bat
  |- /bin
     |- parse_results (binary for Linux)
     |- parse_results.exe (binary for Windows)
  |- /src
     |- parse_results.lua

If you have the Lua interpreter on your system, then you can run the script directly from
the 'src' directory. Otherwise, standalone binaries for Windows and Linux are available
under the 'bin' directory. The binaries were generated using Enceladus:

   https://github.com/ToxicFrog/Enceladus

Note: Be sure to set the execute permissions for the standalone binary.

To run the script directly on Linux:

  % lua src/parse_results.lua > history.txt

To run the standalone binary on Linux:

  % bin/parse_results > history.txt

A batch file is provided for Windows users. Navigate to the project folder in Windows 
Explorer. Then double-click on 'convert.bat'. The show history will be saved within the 
project folder as 'history.txt'.

By default, 'results.html' is used as the source file, but an alternate filename can be
specified as the parameter. The output consists of four tab-delimited fields: Subreddit,
StreamID, PostDate, and PostTitle.
