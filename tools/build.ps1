$NUGETEXE = "C:\ProgramData\chocolatey\lib\NuGet.CommandLine\tools\nuget.exe"
$VSWHERE = "C:\ProgramData\chocolatey\lib\vswhere\tools\vshere.exe"
$BUILDPATH = &VSWHERE -property installationPath
$BUILDEXE = $BUILDPATH + "\MSBuild\Current\Bin\msbuild.exe"

if ($null -eq $SOLUTIONFILE) {
    $SOLUTIONFILE = Read-Host("Please enter full path to SLN file (ex: C:\folder\sub\file.sln)")
}

if ($null -eq $BUILDCONFIG) {
    $BUILDCONFIG = "Release
}

& $NUGETEXE restore $SOLUTIONFILE
& $BUILDEXE $SOLUTIONFILE /nologo /p:Configuration=$BUILDCONFIG /t:rebuild /verbosity:minimal