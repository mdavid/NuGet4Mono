Verified to run correctly on both Linux (x64 Ubuntu Oneiric) and OS X (Lion). If you want tab completion support for first level NuGet commands (still need to add support for second++ level tab completion) source the tools/lib/nuget/nuget-tab-completion.sh script before invoking tools/bin/nuget. e.g.

```bash
$ . tools/lib/nuget/nuget-tab-completion.sh
```

NOTE: the . in front of the shell script is equivalent to using the source command. e.g.

```bash
$ source tools/lib/nuget/nuget-tab-completion.sh
```

is equivalent to the first example.

After invoking either of the above commands you should then be able to invoke:

```bash
$ tools/bin/nuget <TAB>
```

which will in turn print out the first level nuget commands:

```bash
$ tools/bin/nuget <TAB>
delete     help       install    list       pack       publish    push       setApiKey  sources    spec       update     
$ tools/bin/nuget 
```

The first level commands are the same commands found by invoking the tools/bin/nuget script directly with either '?' or 'help', though running it without any parameters will result in the same.

```bash
$ tools/bin/nuget ?
```

will result in:

```bash
NuGet Version: 1.6.21205.9031
usage: NuGet <command> [args] [options] 
Type 'NuGet help <command>' for help on a specific command.

Available commands:

 delete      Deletes a package from the server.
 help (?)    Displays general help information and help information about other commands.
 install     Installs a package using the specified sources. If no sources are specified, all sources defined in %AppData%\NuGet\NuGet.config are used.  If NuGet.config specifies no sources, uses the default NuGet feed.
 list        Displays a list of packages from a given source. If no sources are specified, all sources defined in %AppData%\NuGet\NuGet.config are used. If NuGet.config specifies no sources, uses the default NuGet feed.
 pack        Creates a NuGet package based on the specified nuspec or project file.
 publish     Publishes a package that was uploaded to the server but not added to the feed.
 push        Pushes a package to the server and optionally publishes it.
 setApiKey   Saves an API key for a given server URL. When no URL is provided API key is saved for the NuGet gallery.
 sources     Provides the ability to manage list of sources located in  %AppData%\NuGet\NuGet.config
 spec        Generates a nuspec for a new package. If this command is run in the same folder as a project file (.csproj, .vbproj, .fsproj), it will create a tokenized nuspec f
             ile.
 update      Update packages to latest available versions. This command also updates NuGet.exe itself.

For more information, visit http://docs.nuget.org/docs/reference/command-line-reference
```

With or without tab completion support for first level nuget commands in place you can now invoke any of those commands using the parameter values and syntax specific to each. As of commit bde308cc3acb85bf27ec094f0da5cc9b6522423e full support for both first and second level actions and related -parameters has been added.  To view help specific to each command you can either preface the top level action you want extended usage info for with 'help':

```bash
$ tools/bin/nuget help install
usage: NuGet install packageId|pathToPackagesConfig [options]

Installs a package using the specified sources. If no sources are specified, all sources defined in %AppData%\NuGet\NuGet.config are used.  If NuGet.config specifies no sources, uses the default NuGet feed.

     Specify the id and optionally the version of the package to install. If a path to a packages.config file is used instead of an id, all the packages it contains are instal
     led.

options:

 -Source +                  A list of packages sources to use for the install.
 -OutputDirectory           Specifies the directory in which packages will be installed. If none specified, uses the current directory.
 -Version                   The version of the package to install.
 -ExcludeVersion       (x)  If set, the destination folder will contain only the package name, not the version number
 -Prerelease                Allows prerelease packages to be installed. This flag is not required when restoring packages by installing from packages.config.
 -Help                 (?)  help

For more information, visit http://docs.nuget.org/docs/reference/command-line-reference
```

... or you can use the <tab> key just after the action to gain a preview of the available -parameters for that action. e.g.

```bash
$ nuget <tab> 
delete     help       install    list       pack       publish    push       setApiKey  sources    spec       test       update     

$ nuget install <tab> 
-ExcludeVersion   -Help             -OutputDirectory  -Prerelease       -Source           -Version          -h                ?
```