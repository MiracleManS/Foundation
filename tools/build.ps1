$BUILDEXE = "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe"
$NUGETEXE = "C:\ProgramData\chocolatey\lib\NuGet.CommandLine\tools\nuget.exe"

if ($null -eq $SOLUTIONFILE) {
    $SOLUTIONFILE = Read-Host("Please enter full path to SLN file (ex: C:\folder\sub\file.sln)")
}

& $NUGETEXE restore $SOLUTIONFILE
& $BUILDEXE $SOLUTIONFILE /nologo /p:Configuration=Release /t:rebuild /verbosity:minimal